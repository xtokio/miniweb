all: miniweb

# optional:
# sh getlibs.sh

UNAME_S := $(shell uname -s)

# Linux
#######
ifeq ($(UNAME_S), Linux)
webview.o: webview.cc
	g++ -c webview.cc -std=c++11 -DWEBVIEW_STATIC  `pkg-config --cflags gtk+-3.0 webkit2gtk-4.0` -o webview.o

miniweb.o: miniweb.c  
	gcc -c miniweb.c -std=gnu99

miniweb: miniweb.o webview.o
	g++ miniweb.o webview.o `pkg-config --libs gtk+-3.0 webkit2gtk-4.0` -o miniweb 

install:
	sudo cp ./miniweb /usr/local/bin/.
endif

# Mac
#####
ifeq ($(UNAME_S), Darwin)
webview.o: webview.cc
	g++ -c webview.cc -std=c++11 -DWEBVIEW_STATIC -o webview.o

miniweb.o: miniweb.c	
	gcc -c miniweb.c -std=c99 

miniweb: miniweb.o webview.o
	g++ miniweb.o webview.o -framework WebKit -o miniweb 

install:
	cp ./miniweb /usr/local/bin/.
endif

clean:
	-rm *.o miniweb


###################
# From WebView doc:
###################

# Windows/MinGW

# g++ -c libs/webview/webview.cc -std=c++14 -DWEBVIEW_STATIC -Ilibs/webview2/build/native/include -o build/webview.o
# gcc -c basic.c -std=c99 -Ilibs/webview -o build/basic.o
# g++ build/basic.o build/webview.o -mwindows -ladvapi32 -lole32 -lshell32 -lshlwapi -luser32 -lversion -o build/basic.exe && "build/basic.exe"