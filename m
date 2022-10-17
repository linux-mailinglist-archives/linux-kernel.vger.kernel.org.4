Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8411A601228
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiJQO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiJQO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C029E6AEA0;
        Mon, 17 Oct 2022 07:55:29 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRRzc0lJSGyWmsjfsGEGJxK5nMKStNTxv/6FkpgUndU=;
        b=HeP1Ey5vaQJPQG0FKogEwKtOCvi+rfK5HWX5nkLMt4qKiYdqzrOnnoYgTtH7/vhkDMgzPT
        2hPQD0/w/UT46aSjXdzY3WDhe9Ch3uYsO+ne8fgy9bdl+s9/32/eewqFEnax+XyWat3p7L
        8rBle46P5ytY9sN5sV3JWqqbfHv4uk0aLEVDjBKY5Jl1ajWSyxj/r+ULPiwFXLfBdgEdxf
        FVP2I+BfKK8r2/QDx8Xzl15hz72BlljcgyknrDLxw0/8nWaHQ4WTxLgjvlPnPLRRTmKOtd
        L8RySDFJtkObWmyuJ2ZkRZ26AMwwvTa29P/LL0IHFZ4VOelPAKCx8ZZuy2Ee1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRRzc0lJSGyWmsjfsGEGJxK5nMKStNTxv/6FkpgUndU=;
        b=Ncl04xEz7lGeRLkdnJGNkl1lyPwABrJS1bA29XmgYribUvei8RmcOX4/WZ4YdO33DBgxKa
        hYjfWvuUAK5qhgAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] arch: Introduce CONFIG_FUNCTION_ALIGNMENT
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.719248727@infradead.org>
References: <20220915111143.719248727@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846460.401.3940443761327379184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d49a0626216b95cd4bf696f6acf55f39a16ab0bb
Gitweb:        https://git.kernel.org/tip/d49a0626216b95cd4bf696f6acf55f39a16ab0bb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:10:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:58 +02:00

arch: Introduce CONFIG_FUNCTION_ALIGNMENT

Generic function-alignment infrastructure.

Architectures can select FUNCTION_ALIGNMENT_xxB symbols; the
FUNCTION_ALIGNMENT symbol is then set to the largest such selected
size, 0 otherwise.

>From this the -falign-functions compiler argument and __ALIGN macro
are set.

This incorporates the DEBUG_FORCE_FUNCTION_ALIGN_64B knob and future
alignment requirements for x86_64 (later in this series) into a single
place.

NOTE: also removes the 0x90 filler byte from the generic __ALIGN
      primitive, that value makes no sense outside of x86.

NOTE: .balign 0 reverts to a no-op.

Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.719248727@infradead.org
---
 Makefile                           |  4 ++--
 arch/Kconfig                       | 24 ++++++++++++++++++++++++
 arch/ia64/Kconfig                  |  1 +
 arch/ia64/Makefile                 |  2 +-
 arch/x86/Kconfig                   |  2 ++
 arch/x86/boot/compressed/head_64.S |  8 ++++++++
 arch/x86/include/asm/linkage.h     |  4 +---
 include/asm-generic/vmlinux.lds.h  |  4 ++--
 include/linux/linkage.h            |  4 ++--
 lib/Kconfig.debug                  |  1 +
 10 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index f41ec8c..141e1bc 100644
--- a/Makefile
+++ b/Makefile
@@ -1004,8 +1004,8 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
-ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
-KBUILD_CFLAGS += -falign-functions=64
+ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
diff --git a/arch/Kconfig b/arch/Kconfig
index 8f138e5..4025802 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1428,4 +1428,28 @@ source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
+config FUNCTION_ALIGNMENT_4B
+	bool
+
+config FUNCTION_ALIGNMENT_8B
+	bool
+
+config FUNCTION_ALIGNMENT_16B
+	bool
+
+config FUNCTION_ALIGNMENT_32B
+	bool
+
+config FUNCTION_ALIGNMENT_64B
+	bool
+
+config FUNCTION_ALIGNMENT
+	int
+	default 64 if FUNCTION_ALIGNMENT_64B
+	default 32 if FUNCTION_ALIGNMENT_32B
+	default 16 if FUNCTION_ALIGNMENT_16B
+	default 8 if FUNCTION_ALIGNMENT_8B
+	default 4 if FUNCTION_ALIGNMENT_4B
+	default 0
+
 endmenu
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index c6e06cd..d7e4a24 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -63,6 +63,7 @@ config IA64
 	select NUMA if !FLATMEM
 	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select ZONE_DMA32
+	select FUNCTION_ALIGNMENT_32B
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 56c4bb2..d553ab7 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -23,7 +23,7 @@ KBUILD_AFLAGS_KERNEL := -mconstant-gp
 EXTRA		:=
 
 cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -mfixed-range=f12-f15,f32-f127 \
-		   -falign-functions=32 -frename-registers -fno-optimize-sibling-calls
+		   -frename-registers -fno-optimize-sibling-calls
 KBUILD_CFLAGS_KERNEL := -mconstant-gp
 
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6d1879e..f408fa8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -290,6 +290,8 @@ config X86
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
+	select FUNCTION_ALIGNMENT_16B		if X86_64 || X86_ALIGNMENT_16
+	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060..190b803 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -38,6 +38,14 @@
 #include "pgtable.h"
 
 /*
+ * Fix alignment at 16 bytes. Following CONFIG_FUNCTION_ALIGNMENT will result
+ * in assembly errors due to trying to move .org backward due to the excessive
+ * alignment.
+ */
+#undef __ALIGN
+#define __ALIGN		.balign	16, 0x90
+
+/*
  * Locally defined symbols should be marked hidden:
  */
 	.hidden _bss
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index f484d65..9ee0e28 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -14,10 +14,8 @@
 
 #ifdef __ASSEMBLY__
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN		.p2align 4, 0x90
+#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #define __ALIGN_STR	__stringify(__ALIGN)
-#endif
 
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c15de16..335b571 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -81,8 +81,8 @@
 #define RO_EXCEPTION_TABLE
 #endif
 
-/* Align . to a 8 byte boundary equals to maximum function alignment. */
-#define ALIGN_FUNCTION()  . = ALIGN(8)
+/* Align . function alignment. */
+#define ALIGN_FUNCTION()  . = ALIGN(CONFIG_FUNCTION_ALIGNMENT)
 
 /*
  * LD_DEAD_CODE_DATA_ELIMINATION option enables -fdata-sections, which
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 1feab61..5c8865b 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -69,8 +69,8 @@
 #endif
 
 #ifndef __ALIGN
-#define __ALIGN		.align 4,0x90
-#define __ALIGN_STR	".align 4,0x90"
+#define __ALIGN			.balign CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR		__stringify(__ALIGN)
 #endif
 
 #ifdef __ASSEMBLY__
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abf..e90dc67 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -467,6 +467,7 @@ config SECTION_MISMATCH_WARN_ONLY
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
 	bool "Force all function address 64B aligned"
 	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC)
+	select FUNCTION_ALIGNMENT_64B
 	help
 	  There are cases that a commit from one domain changes the function
 	  address alignment of other domains, and cause magic performance
