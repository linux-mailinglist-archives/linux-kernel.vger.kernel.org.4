Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5026DC164
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDIUbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 16:31:14 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 319B02697;
        Sun,  9 Apr 2023 13:31:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3003192009C; Sun,  9 Apr 2023 22:31:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2493492009B;
        Sun,  9 Apr 2023 21:31:09 +0100 (BST)
Date:   Sun, 9 Apr 2023 21:31:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: Remove ECOFF support from `objstrip'
Message-ID: <alpine.DEB.2.21.2304091924490.62619@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE,
        T_HDRS_LCASE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the UAPI <linux/a.out.h> header only being installed for a small 
number of hosts (namely alpha, m68k and x86, according to a rule from 
include/uapi/Kbuild), `make bootpfile' fails when building `objstrip' 
tool in a cross-build of an Alpha kernel on a build system that is not 
one of those that have the header installed:

arch/alpha/boot/tools/objstrip.c:26:10: fatal error: linux/a.out.h: No such file or directory
   26 | #include <linux/a.out.h>
      |          ^~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.host:110: arch/alpha/boot/tools/objstrip] Error 1
make: *** [arch/alpha/Makefile:54: bootpfile] Error 2

(here reported with a ppc64le system).

Now `objstrip' is a cross-tool in this context and shouldn't be using 
<linux/a.out.h> and ultimately <asm/a.out.h> installed system-wide, as 
if present, these describe the native system they have been installed 
on, which is not necessarily alpha.  Instead `objstrip' would have to 
refer to arch/alpha/include/uapi/asm/a.out.h somehow.

However we have actually long dropped support for building `vmlinux' as 
an ECOFF executable for Alpha, as far back as in 1997, with 2.1.36.  So 
instead just drop ECOFF support from `objstrip', fixing the compilation 
error.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
For posterity on using MOP to boot Linux on Alpha:

The resulting image boots (with an AlphaServer 300/266), so I think the 
change is good.  It does not boot directly though, owing to the age of the 
SRM console:

>>>show version
version             	X3.7-10895 Sep 15 1994 10:19:05
>>>

which does not support BOOTP (it accepts `boot -protocols bootp', but it 
fails, looping indefinitely and never ever sending any network traffic).  
The image can be converted to an ELF executable suitable to load via MOP 
with Linux `mopd' though, as follows:

$ alpha-linux-gnu-objcopy -I binary -O elf64-alpha --rename-section .data=.text,alloc,code,contents,load,readonly arch/alpha/boot/bootpfile arch/alpha/boot/bootpfile.o
$ alpha-linux-gnu-ld -N -Ttext 0x20000000 -e 0x20000000 arch/alpha/boot/bootpfile.o -o arch/alpha/boot/bootpfile.elf

and then resulting `bootpfile.elf' image can be supplied to `mopd' and SRM
will happily load and run it:

>>>boot ewa0 -fl "ip=bootp root=/dev/nfs rw console=ttyS0"
(boot ewa0.0.0.11.0 -flags ip=bootp root=/dev/nfs rw console=ttyS0)

Trying MOP boot.
...............................................................................................................................................................................................

Network load complete.
Host name: macro.orcam.me.uk
Host address: 00-01-02-85-ca-6e

bootstrap code read in
base = 11e000, image_start = 0, image_bytes = bd5378
initializing HWRPB at 2000
initializing page table at 110000
initializing machine state
setting affinity to the primary CPU
jumping to bootstrap code
Linux/AXP bootp loader for Linux 6.3.0-rc5-dirty
Switching to OSF PAL-code .. Ok (rev 1000000020123)
Loading the kernel...'ip=bootp root=/dev/nfs rw console=ttyS0'
Linux version 6.3.0-rc5-dirty (macro@angie) (alpha-linux-gnu-gcc (GCC) 12.0.1 20220129 (experimental), GNU ld (GNU Binutils) 2.37.50.20211101) #6 Tue Apr  4 23:32:30 BST 2023
Booting on Avanti using machine vector Avanti from SRM
Major Options: LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ
Command line: ip=bootp root=/dev/nfs rw console=ttyS0
[...]
---
 arch/alpha/boot/tools/objstrip.c |   57 +++++++--------------------------------
 1 file changed, 11 insertions(+), 46 deletions(-)

linux-alpha-boot-objstrip-aout.diff
Index: linux-macro/arch/alpha/boot/tools/objstrip.c
===================================================================
--- linux-macro.orig/arch/alpha/boot/tools/objstrip.c
+++ linux-macro/arch/alpha/boot/tools/objstrip.c
@@ -2,13 +2,13 @@
 /*
  * arch/alpha/boot/tools/objstrip.c
  *
- * Strip the object file headers/trailers from an executable (ELF or ECOFF).
+ * Strip the object file headers/trailers from an ELF executable.
  *
  * Copyright (C) 1996 David Mosberger-Tang.
  */
 /*
- * Converts an ECOFF or ELF object file into a bootable file.  The
- * object file must be a OMAGIC file (i.e., data and bss follow immediately
+ * Converts an ELF object file into a bootable file.  The object
+ * file must be a OMAGIC file (i.e., data and bss follow immediately
  * behind the text).  See DEC "Assembly Language Programmer's Guide"
  * documentation for details.  The SRM boot process is documented in
  * the Alpha AXP Architecture Reference Manual, Second Edition by
@@ -23,15 +23,11 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
-#include <linux/a.out.h>
-#include <linux/coff.h>
 #include <linux/param.h>
-#ifdef __ELF__
-# include <linux/elf.h>
-# define elfhdr elf64_hdr
-# define elf_phdr elf64_phdr
-# define elf_check_arch(x) ((x)->e_machine == EM_ALPHA)
-#endif
+#include <linux/elf.h>
+#define elfhdr elf64_hdr
+#define elf_phdr elf64_phdr
+#define elf_check_arch(x) ((x)->e_machine == EM_ALPHA)
 
 /* bootfile size must be multiple of BLOCK_SIZE: */
 #define BLOCK_SIZE	512
@@ -55,13 +51,10 @@ main (int argc, char *argv[])
     size_t nwritten, tocopy, n, mem_size, fil_size, pad = 0;
     int fd, ofd, i, j, verbose = 0, primary = 0;
     char buf[8192], *inname;
-    struct exec * aout;		/* includes file & aout header */
     long offset;
-#ifdef __ELF__
     struct elfhdr *elf;
     struct elf_phdr *elf_phdr;	/* program header */
     unsigned long long e_entry;
-#endif
 
     prog_name = argv[0];
 
@@ -145,7 +138,6 @@ main (int argc, char *argv[])
 	exit(1);
     }
 
-#ifdef __ELF__
     elf = (struct elfhdr *) buf;
 
     if (memcmp(&elf->e_ident[EI_MAG0], ELFMAG, SELFMAG) == 0) {
@@ -192,37 +184,10 @@ main (int argc, char *argv[])
 		    prog_name, (long) elf_phdr->p_vaddr,
 		    elf_phdr->p_vaddr + fil_size, offset);
 	}
-    } else
-#endif
-    {
-	aout = (struct exec *) buf;
-
-	if (!(aout->fh.f_flags & COFF_F_EXEC)) {
-	    fprintf(stderr, "%s: %s is not in executable format\n",
-		    prog_name, inname);
-	    exit(1);
-	}
-
-	if (aout->fh.f_opthdr != sizeof(aout->ah)) {
-	    fprintf(stderr, "%s: %s has unexpected optional header size\n",
-		    prog_name, inname);
-	    exit(1);
-	}
-
-	if (N_MAGIC(*aout) != OMAGIC) {
-	    fprintf(stderr, "%s: %s is not an OMAGIC file\n",
-		    prog_name, inname);
-	    exit(1);
-	}
-	offset = N_TXTOFF(*aout);
-	fil_size = aout->ah.tsize + aout->ah.dsize;
-	mem_size = fil_size + aout->ah.bsize;
-
-	if (verbose) {
-	    fprintf(stderr, "%s: extracting %#016lx-%#016lx (at %lx)\n",
-		    prog_name, aout->ah.text_start,
-		    aout->ah.text_start + fil_size, offset);
-	}
+    } else {
+	fprintf(stderr, "%s: %s is not in executable format\n",
+		prog_name, inname);
+	exit(1);
     }
 
     if (lseek(fd, offset, SEEK_SET) != offset) {
