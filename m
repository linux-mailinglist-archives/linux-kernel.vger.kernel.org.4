Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC39570AECE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjEUQGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjEUQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A019B;
        Sun, 21 May 2023 09:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26CA660FB0;
        Sun, 21 May 2023 16:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3247CC433A4;
        Sun, 21 May 2023 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685132;
        bh=09b5kPtFfLZTJTzF2I+byBFVfggNQkTgMDTDl5sdsoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0ILufWJl4SKM2LhVv9iUVqPU5AwboL2YBbCDoHXkeLmBeixZ+j74GDcuXt+CwSui
         psqNo+VA4SEIOSbUC7Snlo91j4DBe0JtZ3KmPtvDGnC1NK8KFY6jKBmfvWbEOJm/jz
         /UYb2J7VGkldGsDIoUmd2W88d+5ELWeyWDvgbmGnCIw5dhdpBe36IMr3LQRHbLbbY3
         pSVepj8XwUb315+EMvkDc2I81BN6OOrBKHOjg2ioTX3TruiNVT2eucSDhUIjFd7i/0
         62dzmSx+dZviarJkIR2QXciKVWX496SQGVNSAipky2lTfCpZy0YSYNAsevszurV/S3
         u1AVCDN8keRRg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 10/20] kbuild: generate KSYMTAB entries by modpost
Date:   Mon, 22 May 2023 01:04:15 +0900
Message-Id: <20230521160426.1881124-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
whether the EXPORT_SYMBOL() is placed in *.c or *.S.

This commit applies a similar approach to the entire data structure of
EXPORT_SYMBOL() for further cleanups. The EXPORT_SYMBOL() compilation
is split into two stages.

When a source file is compiled, EXPORT_SYMBOL() is converted into a
dummy symbol in the .export_symbol section.

For example,

    EXPORT_SYMBOL(foo);
    EXPORT_SYMBOL_NS_GPL(bar, BAR_NAMESPACE);

will be encoded into the following assembly code:

    .section ".export_symbol","a"
    __export_symbol__foo:
            .asciz ""
            .balign 8
            .quad foo
    .previous

    .section ".export_symbol","a"
    __export_symbol_gpl_bar:
            .asciz "BAR_NAMESPACE"
            .balign 8
            .quad bar
    .previous

They are just markers to tell modpost the name, license, and namespace
of the symbols. They will be dropped from the final vmlinux and modules
because the *(.export_symbol) will go into /DISCARD/ in the linker script.

Then, modpost extracts all the information about EXPORT_SYMBOL() from the
.export_symbol section, and generates C code:

    KSYMTAB_FUNC(foo, "", "");
    KSYMTAB_FUNC(bar, "_gpl", "BAR_NAMESPACE");

KSYMTAB_FUNC() (or KSYMTAB_DATA() if it is data) is expanded to struct
kernel_symbol that will be linked to the vmlinux or a module.

With this change, EXPORT_SYMBOL() works in the same way for *.c and *.S
files, providing the following benefits.

[1] Deprecate EXPORT_DATA_SYMBOL()

In the old days, EXPORT_SYMBOL() was only available in C files. To export
a symbol in *.S, EXPORT_SYMBOL() was placed in a separate *.c file.
arch/arm/kernel/armksyms.c is one example written in the classic manner.

Commit 22823ab419d8 ("EXPORT_SYMBOL() for asm") removed this limitation.
Since then, EXPORT_SYMBOL() can be placed close to the symbol definition
in *.S files. It was a nice improvement.

However, as that commit mentioned, you need to use EXPORT_DATA_SYMBOL()
for data objects on some architectures.

In the new approach, modpost checks symbol's type (STT_FUNC or not),
and outputs KSYMTAB_FUNC() or KSYMTAB_DATA() accordingly.

There are only two users of EXPORT_DATA_SYMBOL:

  EXPORT_DATA_SYMBOL_GPL(empty_zero_page)    (arch/ia64/kernel/head.S)
  EXPORT_DATA_SYMBOL(ia64_ivt)               (arch/ia64/kernel/ivt.S)

They are transformed as follows and output into .vmlinux.export.c

  KSYMTAB_DATA(empty_zero_page, "_gpl", "");
  KSYMTAB_DATA(ia64_ivt, "", "");

The other EXPORT_SYMBOL users in ia64 assembly are output as
KSYMTAB_FUNC().

EXPORT_DATA_SYMBOL() is now deprecated.

[2] merge <linux/export.h> and <asm-generic/export.h>

There are two similar header implementations:

  include/linux/export.h        for .c files
  include/asm-generic/export.h  for .S files

Ideally, the functionality should be consistent between them, but they
tend to diverge.

Commit 8651ec01daed ("module: add support for symbol namespaces.") did
not support the namespace for *.S files.

This commit shifts the essential implementation part to C, which supports
EXPORT_SYMBOL_NS() for *.S files.

<asm/export.h> and <asm-generic/export.h> will remain as a wrapper of
<linux/export.h> for a while.

They will be removed after #include <asm/export.h> directives are all
replaced with #include <linux/export.h>.

[3] Implement CONFIG_TRIM_UNUSED_KSYMS in one-pass algorithm (by a later commit)

When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
the directory tree to determine which EXPORT_SYMBOL to trim. If an
EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
second traverse, where some source files are recompiled with their
EXPORT_SYMBOL() tuned into a no-op.

We can do this better now; modpost can selectively emit KSYMTAB entries
that are really used by modules.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
  - Fix build error on UML

Changes in v5:
  - Fix build error on ARM

Changes in v4:
  - Version 3 did not work if a same name symbol exists in a different compilation unit
    Fix it.

Changes in v3:
  - Move struct kernel_symbol to kernel/module/internal.h

Changes in v2:
  - Use KSYMTAB_FUNC and KSYMTAB_DATA for functions and data, respectively
    This distinction is needed for ia64.

 arch/ia64/include/asm/Kbuild      |   1 +
 arch/ia64/include/asm/export.h    |   3 -
 arch/um/os-Linux/user_syms.c      |   9 ++-
 include/asm-generic/export.h      |  84 ++-----------------------
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/export-internal.h   |  49 +++++++++++++++
 include/linux/export.h            |  98 +++++++++++------------------
 include/linux/pm.h                |   8 +--
 kernel/module/internal.h          |  12 ++++
 scripts/Makefile.build            |   8 +--
 scripts/check-local-export        |   4 +-
 scripts/mod/modpost.c             | 100 ++++++++++++++++++++----------
 scripts/mod/modpost.h             |   1 +
 13 files changed, 188 insertions(+), 190 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index aefae2efde9f..33733245f42b 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
 generic-y += agp.h
+generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += vtime.h
diff --git a/arch/ia64/include/asm/export.h b/arch/ia64/include/asm/export.h
deleted file mode 100644
index ad18c6583252..000000000000
--- a/arch/ia64/include/asm/export.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* EXPORT_DATA_SYMBOL != EXPORT_SYMBOL here */
-#define KSYM_FUNC(name) @fptr(name)
-#include <asm-generic/export.h>
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 9b62a9d352b3..0b3a82aedbfa 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -38,10 +38,15 @@ EXPORT_SYMBOL(vsyscall_end);
 #endif
 
 /* Export symbols used by GCC for the stack protector. */
-extern void __stack_smash_handler(void *) __attribute__((weak));
+/*
+ * REVISIT:
+ *   ARCH=um cannot enable CONFIG_STACKPROTECTOR because
+ *   'select HAVE_STACKPROTECTOR' is missing. Is this already broken?
+ */
+void (*__stack_smash_handler)(void *) __attribute__((weak));
 EXPORT_SYMBOL(__stack_smash_handler);
 
-extern long __guard __attribute__((weak));
+long __guard __attribute__((weak));
 EXPORT_SYMBOL(__guard);
 
 #ifdef _FORTIFY_SOURCE
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 5e4b1f2369d2..0ae9f38a904c 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -3,86 +3,12 @@
 #define __ASM_GENERIC_EXPORT_H
 
 /*
- * This comment block is used by fixdep. Please do not remove.
- *
- * When CONFIG_MODVERSIONS is changed from n to y, all source files having
- * EXPORT_SYMBOL variants must be re-compiled because genksyms is run as a
- * side effect of the *.o build rule.
+ * <asm/export.h> and <asm-generic/export.h> are deprecated.
+ * Please include <linux/export.h> directly.
  */
+#include <linux/export.h>
 
-#ifndef KSYM_FUNC
-#define KSYM_FUNC(x) x
-#endif
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define KSYM_ALIGN 4
-#elif defined(CONFIG_64BIT)
-#define KSYM_ALIGN 8
-#else
-#define KSYM_ALIGN 4
-#endif
-
-.macro __put, val, name
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-	.long	\val - ., \name - ., 0
-#elif defined(CONFIG_64BIT)
-	.quad	\val, \name, 0
-#else
-	.long	\val, \name, 0
-#endif
-.endm
-
-/*
- * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
- * section flag requires it. Use '%progbits' instead of '@progbits' since the
- * former apparently works on all arches according to the binutils source.
- */
-
-.macro ___EXPORT_SYMBOL name,val,sec
-#if defined(CONFIG_MODULES) && !defined(__DISABLE_EXPORTS)
-	.section ___ksymtab\sec+\name,"a"
-	.balign KSYM_ALIGN
-__ksymtab_\name:
-	__put \val, __kstrtab_\name
-	.previous
-	.section __ksymtab_strings,"aMS",%progbits,1
-__kstrtab_\name:
-	.asciz "\name"
-	.previous
-#endif
-.endm
-
-#if defined(CONFIG_TRIM_UNUSED_KSYMS)
-
-#include <linux/kconfig.h>
-#include <generated/autoksyms.h>
-
-.macro __ksym_marker sym
-	.section ".discard.ksym","a"
-__ksym_marker_\sym:
-	 .previous
-.endm
-
-#define __EXPORT_SYMBOL(sym, val, sec)				\
-	__ksym_marker sym;					\
-	__cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
-#define __cond_export_sym(sym, val, sec, conf)			\
-	___cond_export_sym(sym, val, sec, conf)
-#define ___cond_export_sym(sym, val, sec, enabled)		\
-	__cond_export_sym_##enabled(sym, val, sec)
-#define __cond_export_sym_1(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
-#define __cond_export_sym_0(sym, val, sec) /* nothing */
-
-#else
-#define __EXPORT_SYMBOL(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
-#endif
-
-#define EXPORT_SYMBOL(name)					\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name),)
-#define EXPORT_SYMBOL_GPL(name) 				\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name), _gpl)
-#define EXPORT_DATA_SYMBOL(name)				\
-	__EXPORT_SYMBOL(name, name,)
-#define EXPORT_DATA_SYMBOL_GPL(name)				\
-	__EXPORT_SYMBOL(name, name,_gpl)
+#define EXPORT_DATA_SYMBOL(name)	EXPORT_SYMBOL(name)
+#define EXPORT_DATA_SYMBOL_GPL(name)	EXPORT_SYMBOL_GPL(name)
 
 #endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..e65d55e8819c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1006,6 +1006,7 @@
 	PATCHABLE_DISCARDS						\
 	*(.discard)							\
 	*(.discard.*)							\
+	*(.export_symbol)						\
 	*(.modinfo)							\
 	/* ld.bfd warns about .gnu.version* even when not emitted */	\
 	*(.gnu.version*)						\
diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index fe7e6ba918f1..1c849db953a5 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -10,6 +10,55 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+#if defined(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)
+/*
+ * relative reference: this reduces the size by half on 64-bit architectures,
+ * and eliminates the need for absolute relocations that require runtime
+ * processing on relocatable kernels.
+ */
+#define __KSYM_REF(sym)		".long " #sym "- ."
+#elif defined(CONFIG_64BIT)
+#define __KSYM_REF(sym)		".quad " #sym
+#else
+#define __KSYM_REF(sym)		".long " #sym
+#endif
+
+/*
+ * For every exported symbol, do the following:
+ *
+ * - Put the name of the symbol and namespace (empty string "" for none) in
+ *   __ksymtab_strings.
+ * - Place a struct kernel_symbol entry in the __ksymtab section.
+ *
+ * Note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
+ * former apparently works on all arches according to the binutils source.
+ */
+#define __KSYMTAB(name, sym, sec, ns)						\
+	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1"	"\n"	\
+	    "__kstrtab_" #name ":"					"\n"	\
+	    "	.asciz \"" #name "\""					"\n"	\
+	    "__kstrtabns_" #name ":"					"\n"	\
+	    "	.asciz \"" ns "\""					"\n"	\
+	    "	.previous"						"\n"	\
+	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
+	    "	.balign	4"						"\n"	\
+	    "__ksymtab_" #name ":"					"\n"	\
+		__KSYM_REF(sym)						"\n"	\
+		__KSYM_REF(__kstrtab_ ##name)				"\n"	\
+		__KSYM_REF(__kstrtabns_ ##name)				"\n"	\
+	    "	.previous"						"\n"	\
+	)
+
+#ifdef CONFIG_IA64
+#define KSYM_FUNC(name)		@fptr(name)
+#else
+#define KSYM_FUNC(name)		name
+#endif
+
+#define KSYMTAB_FUNC(name, sec, ns)	__KSYMTAB(name, KSYM_FUNC(name), sec, ns)
+#define KSYMTAB_DATA(name, sec, ns)	__KSYMTAB(name, name, sec, ns)
+
 #define SYMBOL_CRC(sym, crc, sec)   \
 	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
 	    "__crc_" #sym ":"					"\n" \
diff --git a/include/linux/export.h b/include/linux/export.h
index 3f31ced0d977..32461a01608c 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_EXPORT_H
 #define _LINUX_EXPORT_H
 
+#include <linux/compiler.h>
 #include <linux/stringify.h>
 
 /*
@@ -28,72 +29,35 @@ extern struct module __this_module;
 #else
 #define THIS_MODULE ((struct module *)0)
 #endif
+#endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#include <linux/compiler.h>
-/*
- * Emit the ksymtab entry as a pair of relative references: this reduces
- * the size by half on 64-bit architectures, and eliminates the need for
- * absolute relocations that require runtime processing on relocatable
- * kernels.
- */
-#define __KSYMTAB_ENTRY(sym, sec)					\
-	__ADDRESSABLE(sym)						\
-	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.balign	4					\n"	\
-	    "__ksymtab_" #sym ":				\n"	\
-	    "	.long	" #sym "- .				\n"	\
-	    "	.long	__kstrtab_" #sym "- .			\n"	\
-	    "	.long	__kstrtabns_" #sym "- .			\n"	\
-	    "	.previous					\n")
-
-struct kernel_symbol {
-	int value_offset;
-	int name_offset;
-	int namespace_offset;
-};
+#ifdef CONFIG_64BIT
+#define __EXPORT_SYMBOL_REF(sym)	.balign 8; .quad sym
 #else
-#define __KSYMTAB_ENTRY(sym, sec)					\
-	static const struct kernel_symbol __ksymtab_##sym		\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
-
-struct kernel_symbol {
-	unsigned long value;
-	const char *name;
-	const char *namespace;
-};
+#define __EXPORT_SYMBOL_REF(sym)	.balign 4; .long sym
 #endif
 
+#define ____EXPORT_SYMBOL(sym, license, ns)			\
+	.section ".export_symbol","a" ;				\
+	__export_symbol_##license##_##sym: ;			\
+	.asciz ns ;						\
+	__EXPORT_SYMBOL_REF(sym) ;				\
+	.previous
+
 #ifdef __GENKSYMS__
 
 #define ___EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
+#elif defined(__ASSEMBLY__)
+
+#define ___EXPORT_SYMBOL(sym, license, ns) \
+	____EXPORT_SYMBOL(sym, license, ns)
+
 #else
 
-/*
- * For every exported symbol, do the following:
- *
- * - Put the name of the symbol and namespace (empty string "" for none) in
- *   __ksymtab_strings.
- * - Place a struct kernel_symbol entry in the __ksymtab section.
- *
- * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
- * section flag requires it. Use '%progbits' instead of '@progbits' since the
- * former apparently works on all arches according to the binutils source.
- */
-#define ___EXPORT_SYMBOL(sym, sec, ns)						\
-	extern typeof(sym) sym;							\
-	extern const char __kstrtab_##sym[];					\
-	extern const char __kstrtabns_##sym[];					\
-	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1	\n"	\
-	    "__kstrtab_" #sym ":					\n"	\
-	    "	.asciz 	\"" #sym "\"					\n"	\
-	    "__kstrtabns_" #sym ":					\n"	\
-	    "	.asciz 	\"" ns "\"					\n"	\
-	    "	.previous						\n");	\
-	__KSYMTAB_ENTRY(sym, sec)
+#define ___EXPORT_SYMBOL(sym, license, ns)			\
+	__ADDRESSABLE(sym)					\
+	asm(__stringify(____EXPORT_SYMBOL(sym, license, ns)))
 
 #endif
 
@@ -117,9 +81,21 @@ struct kernel_symbol {
  * from the $(NM) output (see scripts/gen_ksymdeps.sh). These symbols are
  * discarded in the final link stage.
  */
+
+#ifdef __ASSEMBLY__
+
+#define __ksym_marker(sym)					\
+	.section ".discard.ksym","a" ;				\
+__ksym_marker_##sym: ;						\
+	.previous
+
+#else
+
 #define __ksym_marker(sym)	\
 	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
 
+#endif
+
 #define __EXPORT_SYMBOL(sym, sec, ns)					\
 	__ksym_marker(sym);						\
 	__cond_export_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
@@ -147,11 +123,9 @@ struct kernel_symbol {
 #define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, "")
 #endif
 
-#define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym, "")
-#define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym, "_gpl")
-#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", __stringify(ns))
-#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", __stringify(ns))
-
-#endif /* !__ASSEMBLY__ */
+#define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym,)
+#define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym,gpl)
+#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym,, __stringify(ns))
+#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym,gpl, __stringify(ns))
 
 #endif /* _LINUX_EXPORT_H */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 035d9649eba4..aabb6bd8f89e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -388,10 +388,10 @@ const struct dev_pm_ops name = { \
 #define EXPORT_PM_FN_NS_GPL(name, ns)
 #endif
 
-#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
-#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "_gpl", "")
-#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "", #ns)
-#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "_gpl", #ns)
+#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name,, "")
+#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name,gpl, "")
+#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name,, #ns)
+#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name,gpl, #ns)
 
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index dc7b0160c480..c8b7b4dcf782 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -32,6 +32,18 @@
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
 
+struct kernel_symbol {
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	int value_offset;
+	int name_offset;
+	int namespace_offset;
+#else
+	unsigned long value;
+	const char *name;
+	const char *namespace;
+#endif
+};
+
 extern struct mutex module_mutex;
 extern struct list_head modules;
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9f94fc83f086..6bf026a304e4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -161,7 +161,7 @@ quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
 ifdef CONFIG_MODVERSIONS
 # When module versioning is enabled the following steps are executed:
 # o compile a <file>.o from <file>.c
-# o if <file>.o doesn't contain a __ksymtab version, i.e. does
+# o if <file>.o doesn't contain a __export_symbol*, i.e. does
 #   not export symbols, it's done.
 # o otherwise, we calculate symbol versions using the good old
 #   genksyms on the preprocessed source and dump them into the .cmd file.
@@ -169,7 +169,7 @@ ifdef CONFIG_MODVERSIONS
 #   be compiled and linked to the kernel and/or modules.
 
 gen_symversions =								\
-	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
+	if $(NM) $@ 2>/dev/null | grep -q '__export_symbol_[^_]*_'; then	\
 		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
 			>> $(dot-target).cmd;					\
 	fi
@@ -340,9 +340,7 @@ $(obj)/%.ll: $(src)/%.rs FORCE
 cmd_gensymtypes_S =                                                         \
    { echo "\#include <linux/kernel.h>" ;                                    \
      echo "\#include <asm/asm-prototypes.h>" ;                              \
-    $(CPP) $(a_flags) $< |                                                  \
-     grep "\<___EXPORT_SYMBOL\>" |                                          \
-     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
+     $(NM) $@ | sed -n 's/.*__export_symbol_[^_]*_\(.*\)/EXPORT_SYMBOL(\1);/p' ; } | \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
 
 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
diff --git a/scripts/check-local-export b/scripts/check-local-export
index f90b5a9c67b3..969a313b9299 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -46,9 +46,9 @@ BEGIN {
 { symbol_types[$3]=$2 }
 
 # append the exported symbol to the array
-($3 ~ /^__ksymtab_/) {
+($3 ~ /^__export_symbol_(gpl)?_.*/) {
 	export_symbols[i] = $3
-	sub(/^__ksymtab_/, "", export_symbols[i])
+	sub(/^__export_symbol_(gpl)?_/, "", export_symbols[i])
 	i++
 }
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 378fb9649545..8b94090d0743 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -215,6 +215,7 @@ struct symbol {
 	unsigned int crc;
 	bool crc_valid;
 	bool weak;
+	bool is_func;
 	bool is_gpl_only;	/* exported by EXPORT_SYMBOL_GPL */
 	char name[];
 };
@@ -531,6 +532,8 @@ static int parse_elf(struct elf_info *info, const char *filename)
 				fatal("%s has NOBITS .modinfo\n", filename);
 			info->modinfo = (void *)hdr + sechdrs[i].sh_offset;
 			info->modinfo_len = sechdrs[i].sh_size;
+		} else if (!strcmp(secname, ".export_symbol")) {
+			info->export_symbol_secndx = i;
 		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
@@ -653,18 +656,6 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 				   ELF_ST_BIND(sym->st_info) == STB_WEAK);
 		break;
 	default:
-		/* All exported symbols */
-		if (strstarts(symname, "__ksymtab_")) {
-			const char *name, *secname;
-
-			name = symname + strlen("__ksymtab_");
-			secname = sec_name(info, get_secindex(info, sym));
-
-			if (strstarts(secname, "___ksymtab_gpl+"))
-				sym_add_exported(name, mod, true);
-			else if (strstarts(secname, "___ksymtab+"))
-				sym_add_exported(name, mod, false);
-		}
 		if (strcmp(symname, "init_module") == 0)
 			mod->has_init = true;
 		if (strcmp(symname, "cleanup_module") == 0)
@@ -865,7 +856,6 @@ enum mismatch {
 	XXXEXIT_TO_SOME_EXIT,
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
-	EXPORT_TO_INIT_EXIT,
 	EXTABLE_TO_NON_TEXT,
 };
 
@@ -947,12 +937,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { INIT_SECTIONS, NULL },
 	.mismatch = ANY_INIT_TO_ANY_EXIT,
 },
-/* Do not export init/exit functions or data */
-{
-	.fromsec = { "___ksymtab*", NULL },
-	.bad_tosec = { INIT_SECTIONS, EXIT_SECTIONS, NULL },
-	.mismatch = EXPORT_TO_INIT_EXIT,
-},
 {
 	.fromsec = { "__ex_table", NULL },
 	/* If you're adding any new black-listed sections in here, consider
@@ -1198,10 +1182,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
 		     modname, fromsym, fromsec, tosym, tosec);
 		break;
-	case EXPORT_TO_INIT_EXIT:
-		warn("%s: EXPORT_SYMBOL used for init/exit symbol: %s (section: %s)\n",
-		     modname, tosym, tosec);
-		break;
 	case EXTABLE_TO_NON_TEXT:
 		warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
 		     modname, fromsec, (long)faddr, tosec, tosym);
@@ -1229,14 +1209,69 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	}
 }
 
+static void check_export_symbol(struct module *mod, struct elf_info *elf,
+				Elf_Addr faddr, const char *secname,
+				Elf_Sym *sym)
+{
+	const char *label_name, *name, *prefix;
+	Elf_Sym *label;
+	struct symbol *s;
+	bool is_gpl;
+
+	label = find_fromsym(elf, faddr, elf->export_symbol_secndx);
+	label_name = sym_name(elf, label);
+
+	name = sym_name(elf, sym);
+
+	if (strstarts(label_name, "__export_symbol_gpl_")) {
+		prefix = "__export_symbol_gpl_";
+		is_gpl = true;
+	} else if (strstarts(label_name, "__export_symbol__")) {
+		prefix = "__export_symbol__";
+		is_gpl = false;
+	} else {
+		error("%s: .export_symbol section contains strange symbol '%s'\n",
+		      mod->name, label_name);
+		return;
+	}
+
+	if (strcmp(label_name + strlen(prefix), name)) {
+		error("%s: .export_symbol section references '%s', but it does not seem to be an export symbol\n",
+		      mod->name, name);
+		return;
+	}
+
+	s = sym_add_exported(name, mod, is_gpl);
+	sym_update_namespace(name, sym_get_data(elf, label));
+
+	/*
+	 * We need to be aware whether we are exporting a function or
+	 * a data on some architectures.
+	 */
+	s->is_func = (ELF_ST_TYPE(sym->st_info) == STT_FUNC);
+
+	if (match(secname, PATTERNS(INIT_SECTIONS)))
+		error("%s: %s: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.\n",
+		      mod->name, name);
+	else if (match(secname, PATTERNS(EXIT_SECTIONS)))
+		error("%s: %s: EXPORT_SYMBOL used for exit symbol. Remove __exit or EXPORT_SYMBOL.\n",
+		      mod->name, name);
+}
+
 static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 				   Elf_Sym *sym,
 				   unsigned int fsecndx, const char *fromsec,
 				   Elf_Addr faddr, Elf_Addr taddr)
 {
 	const char *tosec = sec_name(elf, get_secindex(elf, sym));
-	const struct sectioncheck *mismatch = section_mismatch(fromsec, tosec);
+	const struct sectioncheck *mismatch;
 
+	if (elf->export_symbol_secndx == fsecndx) {
+		check_export_symbol(mod, elf, faddr, tosec, sym);
+		return;
+	}
+
+	mismatch = section_mismatch(fromsec, tosec);
 	if (!mismatch)
 		return;
 
@@ -1650,15 +1685,6 @@ static void read_symbols(const char *modname)
 		handle_moddevtable(mod, &info, sym, symname);
 	}
 
-	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
-		symname = remove_dot(info.strtab + sym->st_name);
-
-		/* Apply symbol namespaces from __kstrtabns_<symbol> entries. */
-		if (strstarts(symname, "__kstrtabns_"))
-			sym_update_namespace(symname + strlen("__kstrtabns_"),
-					     sym_get_data(&info, sym));
-	}
-
 	check_sec_ref(mod, &info);
 
 	if (!mod->is_vmlinux) {
@@ -1842,6 +1868,14 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 {
 	struct symbol *sym;
 
+	/* generate struct for exported symbols */
+	buf_printf(buf, "\n");
+	list_for_each_entry(sym, &mod->exported_symbols, list)
+		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
+			   sym->is_func ? "FUNC" : "DATA", sym->name,
+			   sym->is_gpl_only ? "_gpl" : "",
+			   sym->namespace ?: "");
+
 	if (!modversions)
 		return;
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index b1e2d95f8047..dfdb9484e325 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -137,6 +137,7 @@ struct elf_info {
 	Elf_Shdr     *sechdrs;
 	Elf_Sym      *symtab_start;
 	Elf_Sym      *symtab_stop;
+	unsigned int export_symbol_secndx;	/* .export_symbol section */
 	char         *strtab;
 	char	     *modinfo;
 	unsigned int modinfo_len;
-- 
2.39.2

