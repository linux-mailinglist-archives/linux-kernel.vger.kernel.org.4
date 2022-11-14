Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B4627CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiKNLrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiKNLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFC423EAC;
        Mon, 14 Nov 2022 03:45:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0562F6108D;
        Mon, 14 Nov 2022 11:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DE6C433B5;
        Mon, 14 Nov 2022 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426310;
        bh=U88ByfantOuqzsZrA5yzPeb/FIn96646m0chM2LVf7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCVxoEI+5LJxBX9rN6Wc4juqda9V3epctKjzV0CwK6X+3ichJiOIK60Tu2gpnW8ph
         wOAUVqcC1DzgiZSNap1P1bfMgvh5IKkk+HrZG9yDldZkvc9ZMIneUY9LvIXSzW7SA5
         pod26Nz6sLlRYYh/pyp7q21H7bN1si2MZEeOm1mEDfYOIBK/nqolX9f/QstqZNR4w/
         /91dtHhwKmPvVUoQ3QcthWqBXqzarLnpckf5WCFtmsmZY2KAaNgA76W9ARF8ZLQ1bP
         E7rTL9Z7ENOYAFF9VKlIIMG/lntAB6YMs9mPj4biyKADkCzOVnfGzr5x8wL5qRed3+
         Qhg0VmAt/jt9A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Richard Biener <RGuenther@suse.com>,
        Jan Hubicka <jh@suse.de>, "H . J . Lu" <hjl.tools@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Martin Liska <mliska@suse.cz>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 30/46] Kbuild, lto: Add Link Time Optimization support
Date:   Mon, 14 Nov 2022 12:43:28 +0100
Message-Id: <20221114114344.18650-31-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This patch adds gcc LTO support. It leverages some of the existing
support for clang LTO.

With LTO, gcc will do whole program optimizations for the whole kernel
and each module. This increases compile time, but can generate faster
and smaller code and allows the compiler to do global checking. For
example the compiler can complain now about type mismatches for symbols
between different files.

LTO allows gcc to inline functions between different files and do
various other optimization across the whole binary.

The LTO patches have been used for many years by various users, mostly
to make their kernel smaller. The original versions date back to 2012.

This version has a lot of outdated cruft dropped and doesn't need any
special tool chain (except for new enough) anymore.

This adds the basic Kbuild plumbing for LTO:
* Add a new LDFINAL variable that controls the final link for vmlinux or
  module. In this case we call gcc-ld instead of ld, to run the LTO
  step.

* Add Makefile support to enable LTO

For more information see Documentation/kbuild/lto-build.rst

Thanks to H.J. Lu, Joe Mario, Honza Hubicka, Richard Biener, Don Zickus,
Changlong Xie, Gleb Schukin, Martin Liska, various github contributors,
who helped with this project (and probably some more who I forgot,
sorry).

[js] pass -flto only once (the one with jobserver)
[ml] "-m: command not found" and whitespace fix
[bs] fixed Documentation issues:
  * blank line padding before single requirement list
  * use bullet list for FAQ
  * use bullet lists for external link references list
  * add LTO documentation to toc index

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: Richard Biener <RGuenther@suse.com>
Cc: Jan Hubicka <jh@suse.de>
Cc: H.J. Lu <hjl.tools@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/kbuild/index.rst     |  2 +
 Documentation/kbuild/lto-build.rst | 76 ++++++++++++++++++++++++++++++
 Makefile                           |  4 +-
 arch/Kconfig                       | 52 ++++++++++++++++++++
 scripts/Makefile.build             |  9 ++--
 scripts/Makefile.lto               | 43 +++++++++++++++++
 scripts/Makefile.modfinal          |  2 +-
 scripts/Makefile.vmlinux           |  3 +-
 scripts/Makefile.vmlinux_o         |  4 +-
 scripts/link-vmlinux.sh            |  7 +--
 10 files changed, 190 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/kbuild/lto-build.rst
 create mode 100644 scripts/Makefile.lto

diff --git a/Documentation/kbuild/index.rst b/Documentation/kbuild/index.rst
index cee2f99f734b..1937eee7c437 100644
--- a/Documentation/kbuild/index.rst
+++ b/Documentation/kbuild/index.rst
@@ -22,6 +22,8 @@ Kernel Build System
     gcc-plugins
     llvm
 
+    lto-build
+
 .. only::  subproject and html
 
    Indices
diff --git a/Documentation/kbuild/lto-build.rst b/Documentation/kbuild/lto-build.rst
new file mode 100644
index 000000000000..3fb17342e72f
--- /dev/null
+++ b/Documentation/kbuild/lto-build.rst
@@ -0,0 +1,76 @@
+=====================================================
+gcc link time optimization (LTO) for the Linux kernel
+=====================================================
+
+Link Time Optimization allows the compiler to optimize the complete program
+instead of just each file.
+
+The compiler can inline functions between files and do various other global
+optimizations, like specializing functions for common parameters,
+determing when global variables are clobbered, making functions pure/const,
+propagating constants globally, removing unneeded data and others.
+
+It will also drop unused functions which can make the kernel
+image smaller in some circumstances, in particular for small kernel
+configurations.
+
+For small monolithic kernels it can throw away unused code very effectively
+(especially when modules are disabled) and usually shrinks
+the code size.
+
+Build time and memory consumption at build time will increase, depending
+on the size of the largest binary. Modular kernels are less affected.
+With LTO incremental builds are less incremental, as always the whole
+binary needs to be re-optimized (but not re-parsed)
+
+Oopses can be somewhat more difficult to read, due to the more aggressive
+inlining: it helps to use scripts/faddr2line.
+
+It is currently incompatible with live patching.
+
+Normal "reasonable" builds work with less than 4GB of RAM, but very large
+configurations like allyesconfig typically need more memory. The actual
+memory needed depends on the available memory (gcc sizes its garbage
+collector pools based on that or on the ulimit -m limits) and
+the compiler version.
+
+Requirements:
+-------------
+
+- Enough memory: 4GB for a standard build, more for allyesconfig
+  The peak memory usage happens single threaded (when lto-wpa merges types),
+  so dialing back -j options will not help much.
+
+A 32bit hosted compiler is unlikely to work due to the memory requirements.
+You can however build a kernel targeted at 32bit on a 64bit host.
+
+FAQs:
+-----
+
+* I get a section type attribute conflict
+
+  Usually because of someone doing const __initdata (should be
+  const __initconst) or const __read_mostly (should be just const). Check
+  both symbols reported by gcc.
+
+References:
+-----------
+
+* Presentation on Kernel LTO
+  (note, performance numbers/details totally outdated.)
+
+  http://halobates.de/kernel-lto.pdf
+
+* Generic gcc LTO:
+
+  * http://www.ucw.cz/~hubicka/slides/labs2013.pdf
+  * http://www.hipeac.net/system/files/barcelona.pdf
+
+* Somewhat outdated too (from GCC site):
+
+  * http://gcc.gnu.org/projects/lto/lto.pdf
+  * http://gcc.gnu.org/projects/lto/whopr.pdf
+
+Happy Link-Time-Optimizing!
+
+Andi Kleen
diff --git a/Makefile b/Makefile
index 0b723c903819..d0dfb5ca2b21 100644
--- a/Makefile
+++ b/Makefile
@@ -482,6 +482,7 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 
 # Make variables (CC, etc...)
 CPP		= $(CC) -E
+LDFINAL		= $(LD)
 ifneq ($(LLVM),)
 CC		= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
 LD		= $(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX)
@@ -604,7 +605,7 @@ export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO
 export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
 export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
-export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
+export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD LDFINAL
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
 export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
 
@@ -1085,6 +1086,7 @@ include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
 include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+= scripts/Makefile.randstruct
+include-$(CONFIG_LTO_GCC)	+= scripts/Makefile.lto
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
 
 include $(addprefix $(srctree)/, $(include-y))
diff --git a/arch/Kconfig b/arch/Kconfig
index 8f138e580d1a..ad52c8fddfb4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -689,6 +689,21 @@ config HAS_LTO_CLANG
 	  The compiler and Kconfig options support building with Clang's
 	  LTO.
 
+config ARCH_SUPPORTS_LTO_GCC
+	bool
+
+# Some ar versions leak file descriptors when using the LTO
+# plugin and cause strange errors when ulimit -n is too low.
+# Pick an arbitrary threshold, which should be enough for most
+# kernel configs. This was a regression that is only
+# in some transient binutils version, so either older or
+# new enough is ok.
+# This might not be the exact range with this bug.
+config BAD_AR
+	depends on LD_VERSION = 23000
+	depends on $(shell,ulimit -n) < 4000
+	def_bool y
+
 choice
 	prompt "Link Time Optimization (LTO)"
 	default LTO_NONE
@@ -736,8 +751,45 @@ config LTO_CLANG_THIN
 	    https://clang.llvm.org/docs/ThinLTO.html
 
 	  If unsure, say Y.
+
+config LTO_GCC
+	bool "gcc LTO"
+	depends on ARCH_SUPPORTS_LTO_GCC && CC_IS_GCC
+	depends on GCC_VERSION >= 100300
+	depends on LD_VERSION >= 22700
+	depends on !BAD_AR
+	select LTO
+	help
+	  Enable whole program (link time) optimizations (LTO) for the whole
+	  kernel and each module. This usually increases compile time,
+	  especially for incremential builds, but tends to generate better code
+	  as well as some global checks.
+
+	  It allows the compiler to inline functions between different files
+	  and do other global optimization, like propagating constants between
+	  functions, determine side effects of functions, avoid unnecessary
+	  register saving around functions, or optimize unused function
+	  arguments. It also allows the compiler to drop unused functions.
+
+	  With this option the compiler will also do some global checking over
+	  different source files.
+
+	  This requires a gcc 10.3 or later compiler and binutils >= 2.27.
+
+	  On larger non modular configurations this may need more than 4GB of
+	  RAM for the link phase, as well as a 64bit host compiler.
+
+	  For more information see Documentation/kbuild/lto-build.rst
 endchoice
 
+config LTO_CP_CLONE
+	bool "Allow aggressive cloning for function specialization"
+	depends on LTO_GCC
+	help
+	  Allow the compiler to clone and specialize functions for specific
+	  arguments when it determines these arguments are commonly
+	  called.  Experimential. Will increase text size.
+
 config ARCH_SUPPORTS_CFI_CLANG
 	bool
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0a28e3884efe..9b522c9efcb6 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -154,7 +154,7 @@ is-single-obj-m = $(and $(part-of-module),$(filter $@, $(obj-m)),y)
 # When a module consists of a single object, there is no reason to keep LLVM IR.
 # Make $(LD) covert LLVM IR to ELF here.
 ifdef CONFIG_LTO
-cmd_ld_single_m = $(if $(is-single-obj-m), ; $(LD) $(ld_flags) -r -o $(tmp-target) $@; mv $(tmp-target) $@)
+cmd_ld_single_m = $(if $(is-single-obj-m), ; $(LDFINAL) $(ld_flags) -r -o $(tmp-target) $@; mv $(tmp-target) $@)
 endif
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
@@ -265,7 +265,8 @@ $(obj)/%.usyms: $(obj)/%.o FORCE
 	$(call if_changed,undefined_syms)
 
 quiet_cmd_cc_lst_c = MKLST   $@
-      cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
+      cmd_cc_lst_c = $(if $(CONFIG_LTO),$(warning Listing in LTO mode does not match final binary)) \
+		     $(CC) $(c_flags) -g -c -o $*.o $< && \
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
 				     System.map $(OBJDUMP) > $@
 
@@ -446,8 +447,8 @@ $(obj)/modules.order: $(obj-m) FORCE
 $(obj)/lib.a: $(lib-y) FORCE
 	$(call if_changed,ar)
 
-quiet_cmd_ld_multi_m = LD [M]  $@
-      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
+quiet_cmd_ld_multi_m = LDFINAL [M] $@
+      cmd_ld_multi_m = $(LDFINAL) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
 
 define rule_ld_multi_m
 	$(call cmd_and_savecmd,ld_multi_m)
diff --git a/scripts/Makefile.lto b/scripts/Makefile.lto
new file mode 100644
index 000000000000..33ac0da2bb47
--- /dev/null
+++ b/scripts/Makefile.lto
@@ -0,0 +1,43 @@
+#
+# Support for gcc link time optimization
+#
+
+DISABLE_LTO_GCC :=
+export DISABLE_LTO_GCC
+
+ifdef CONFIG_LTO_GCC
+	CC_FLAGS_LTO_GCC := -flto
+	DISABLE_LTO_GCC := -fno-lto
+
+	KBUILD_CFLAGS += ${CC_FLAGS_LTO_GCC}
+
+	CC_FLAGS_LTO := -flto
+	export CC_FLAGS_LTO
+
+	lto-flags-y := -flinker-output=nolto-rel -flto=jobserver
+	lto-flags-y += -fwhole-program
+
+	lto-flags-$(CONFIG_LTO_CP_CLONE) += -fipa-cp-clone
+
+	# allow extra flags from command line
+	lto-flags-y += ${LTO_EXTRA_CFLAGS}
+
+	# For LTO we need to use gcc to do the linking, not ld
+	# directly. Use a wrapper to convert the ld command line
+	# to gcc
+	LDFINAL := ${CONFIG_SHELL} ${srctree}/scripts/gcc-ld \
+                  ${lto-flags-y}
+
+	# LTO gcc creates a lot of files in TMPDIR, and with /tmp as tmpfs
+	# it's easy to drive the machine OOM. Use the object directory
+	# instead for temporaries.
+	# This has the drawback that there might be some junk more visible
+	# after interrupted compilations, but you would have that junk
+	# there anyways in /tmp.
+	TMPDIR ?= $(objtree)
+	export TMPDIR
+
+	# use plugin aware tools
+	AR = $(CROSS_COMPILE)gcc-ar
+	NM = $(CROSS_COMPILE)gcc-nm
+endif # CONFIG_LTO_GCC
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 25bedd83644b..c52536c91c8c 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -32,7 +32,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
-	$(LD) -r $(KBUILD_LDFLAGS)					\
+	$(LDFINAL) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 49946cb96844..8871e55f881b 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -26,7 +26,8 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
 cmd_link_vmlinux =							\
-	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";		\
+	$< "$(LD)" "$(LDFINAL)" "$(KBUILD_LDFLAGS)"			\
+	"$(LDFLAGS_vmlinux)";						\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 targets += vmlinux
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 1c86895cfcf8..1f646b16aa70 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -44,9 +44,9 @@ objtool-args = $(vmlinux-objtool-args-y) --link
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
 
-quiet_cmd_ld_vmlinux.o = LD      $@
+quiet_cmd_ld_vmlinux.o = LDFINAL $@
       cmd_ld_vmlinux.o = \
-	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
+	$(LDFINAL) ${KBUILD_LDFLAGS} -r -o $@ \
 	$(addprefix -T , $(initcalls-lds)) \
 	--whole-archive vmlinux.a --no-whole-archive \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 652f33be9549..c89258bcf818 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -29,8 +29,9 @@
 set -e
 
 LD="$1"
-KBUILD_LDFLAGS="$2"
-LDFLAGS_vmlinux="$3"
+LDFINAL="$2"
+KBUILD_LDFLAGS="$3"
+LDFLAGS_vmlinux="$4"
 
 is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
@@ -82,7 +83,7 @@ vmlinux_link()
 		ldlibs="-lutil -lrt -lpthread"
 	else
 		wl=
-		ld="${LD}"
+		ld="${LDFINAL}"
 		ldflags="${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}"
 		ldlibs=
 	fi
-- 
2.38.1

