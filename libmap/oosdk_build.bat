SETLOCAL EnableDelayedExpansion

Rem Libraries to link in
set libraries=-lc -lkernel

Rem Read the script arguments into local vars
set intdir=%1
set targetname=%~2
set outputPath=%3

set outputLib=libmap.a

Rem Compile object files for all the source files
for %%f in (src/*.c) do (
    clang -cc1 -triple x86_64-scei-ps4-elf -munwind-tables -I"%OO_PS4_TOOLCHAIN%\\include" -emit-obj -o src/%%~nf.o src/%%~nf.c
)

Rem the archiver to make the libmap.a file
llvm-ar -rc %outputLib% src/map.o

Rem install the library
copy "%CD%\%outputLib%" "%OO_PS4_TOOLCHAIN%/lib/%outputLib%"
copy "%CD%\src\map.h" "%OO_PS4_TOOLCHAIN%/include/map.h"
