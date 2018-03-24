NAME=knmr

build: test
	go build -o build/$(NAME) ./cmd/$(NAME)

run: build
	./build/$(NAME) -d

agent: build
	./build/$(NAME) -d agent

github: build
	./build/$(NAME) -d github

godoc: build
	./build/$(NAME) -d godoc

twitter: build
	./build/$(NAME) -d twitter

test: vet
	go test -v -short ./...

vet: deps
	go tool vet -all .

deps: 
	go get -d -v -t ./...

testdeps:
	go get golang.org/x/tools/cmd/cover
	go get github.com/pierrre/gotestcover
	go get github.com/mattn/goveralls

cover: testdeps
	gotestcover -v -covermode=count -coverprofile=.profile.cov -parallelpackages=4 ./...

fmt: 
	gofmt -w -d -s .
	goimports -w -d .

.PHONY: vet test deps fmt cover