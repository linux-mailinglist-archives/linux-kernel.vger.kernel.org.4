Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797C6011DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiJQOzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJQOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062A68CE8;
        Mon, 17 Oct 2022 07:53:59 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hT1Sg9NoUlHdvQC0/hd4Jpdct7raTNMEYVcD4FbUFgs=;
        b=KrnBH4W0CtEsnwraq4T1Fi65uDM88j2xjMi37hwhZ/0mx+E3XLIoe7DiRKI5jSlIoVpI/w
        yINyTkB2uf/mnh9He8O0ZWBx/HAPUq3EUFhHJm9vmvd2Hg7hg1musbbWlrSRjc56Wc3c4L
        NSKCakZZNQajwuGpx9G34D3Ik2zrAyykfR6TCQeCztAWwvzDRblTIWzjhgjNJVXR+qBo4G
        X7pIUewSvzpjj/DmCdd1Ah433+2HDg4mgcleepJnF20Cp5IyoQ2yl3+msbDNtdAfGjb7f7
        8+wdPymqqz8tbbmaCJ1gzPdXqS9VQewb+MfmxbCpK88FxVTd/VDTqxgXi5uu0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hT1Sg9NoUlHdvQC0/hd4Jpdct7raTNMEYVcD4FbUFgs=;
        b=wmzGMnaj2B2hif0HW9f2TkzHYTojBnLp6GnO9NLpzkNQNWwaGSo6BAz8KucX0FEFR1Ypox
        lOE2jva+fu/uEbBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/Kconfig: Introduce function padding
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.950884492@infradead.org>
References: <20220915111146.950884492@infradead.org>
MIME-Version: 1.0
Message-ID: <166601843038.401.4437133016879385496.tip-bot2@tip-bot2>
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

Commit-ID:     bea75b33895f7f87f0c40023e36a2d087e87ffa1
Gitweb:        https://git.kernel.org/tip/bea75b33895f7f87f0c40023e36a2d087e87ffa1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:10 +02:00

x86/Kconfig: Introduce function padding

Now that all functions are 16 byte aligned, add 16 bytes of NOP
padding in front of each function. This prepares things for software
call stack tracking and kCFI/FineIBT.

This significantly increases kernel .text size, around 5.1% on a
x86_64-defconfig-ish build.

However, per the random access argument used for alignment, these 16
extra bytes are code that wouldn't be used. Performance measurements
back this up by showing no significant performance regressions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.950884492@infradead.org
---
 arch/x86/Kconfig               | 20 ++++++++++++-
 arch/x86/Makefile              |  6 ++++-
 arch/x86/entry/vdso/Makefile   |  3 +-
 arch/x86/include/asm/linkage.h | 51 +++++++++++++++++++++++++++++++--
 include/linux/bpf.h            |  4 +++-
 5 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e18963e..e368fc0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2446,9 +2446,27 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
+config CC_HAS_ENTRY_PADDING
+	def_bool $(cc-option,-fpatchable-function-entry=16,16)
+
+config FUNCTION_PADDING_CFI
+	int
+	default 59 if FUNCTION_ALIGNMENT_64B
+	default 27 if FUNCTION_ALIGNMENT_32B
+	default 11 if FUNCTION_ALIGNMENT_16B
+	default  3 if FUNCTION_ALIGNMENT_8B
+	default  0
+
+# Basically: FUNCTION_ALIGNMENT - 5*CFI_CLANG
+# except Kconfig can't do arithmetic :/
+config FUNCTION_PADDING_BYTES
+	int
+	default FUNCTION_PADDING_CFI if CFI_CLANG
+	default FUNCTION_ALIGNMENT
+
 config HAVE_CALL_THUNKS
 	def_bool y
-	depends on RETHUNK && OBJTOOL
+	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
 
 config CALL_THUNKS
 	def_bool n
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 415a5d1..1640e00 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -208,6 +208,12 @@ ifdef CONFIG_SLS
   KBUILD_CFLAGS += -mharden-sls=all
 endif
 
+ifdef CONFIG_CALL_THUNKS
+PADDING_CFLAGS := -fpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
+KBUILD_CFLAGS += $(PADDING_CFLAGS)
+export PADDING_CFLAGS
+endif
+
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
 ifdef CONFIG_LTO_CLANG
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 3ef6110..838613a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -95,7 +95,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 
 #
@@ -158,6 +158,7 @@ KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(PADDING_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index c2d6e27..45e0df8 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -15,8 +15,19 @@
 #define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #define __ALIGN_STR	__stringify(__ALIGN)
 
-#define ASM_FUNC_ALIGN		__ALIGN_STR
-#define __FUNC_ALIGN		__ALIGN
+#if defined(CONFIG_CALL_THUNKS) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#define FUNCTION_PADDING	.skip CONFIG_FUNCTION_ALIGNMENT, 0x90;
+#else
+#define FUNCTION_PADDING
+#endif
+
+#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BULID_VDSO)
+# define __FUNC_ALIGN		__ALIGN; FUNCTION_PADDING
+#else
+# define __FUNC_ALIGN		__ALIGN
+#endif
+
+#define ASM_FUNC_ALIGN		__stringify(__FUNC_ALIGN)
 #define SYM_F_ALIGN		__FUNC_ALIGN
 
 #ifdef __ASSEMBLY__
@@ -45,11 +56,45 @@
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * Depending on -fpatchable-function-entry=N,N usage (CONFIG_CALL_THUNKS) the
+ * CFI symbol layout changes.
+ *
+ * Without CALL_THUNKS:
+ *
+ * 	.align	FUNCTION_ALIGNMENT
+ * __cfi_##name:
+ * 	.skip	FUNCTION_PADDING, 0x90
+ * 	.byte   0xb8
+ * 	.long	__kcfi_typeid_##name
+ * name:
+ *
+ * With CALL_THUNKS:
+ *
+ * 	.align FUNCTION_ALIGNMENT
+ * __cfi_##name:
+ * 	.byte	0xb8
+ * 	.long	__kcfi_typeid_##name
+ * 	.skip	FUNCTION_PADDING, 0x90
+ * name:
+ *
+ * In both cases the whole thing is FUNCTION_ALIGNMENT aligned and sized.
+ */
+
+#ifdef CONFIG_CALL_THUNKS
+#define CFI_PRE_PADDING
+#define CFI_POST_PADDING	.skip	CONFIG_FUNCTION_PADDING_BYTES, 0x90;
+#else
+#define CFI_PRE_PADDING		.skip	CONFIG_FUNCTION_PADDING_BYTES, 0x90;
+#define CFI_POST_PADDING
+#endif
+
 #define __CFI_TYPE(name)					\
 	SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)	\
-	.fill 11, 1, 0x90 ASM_NL				\
+	CFI_PRE_PADDING						\
 	.byte 0xb8 ASM_NL					\
 	.long __kcfi_typeid_##name ASM_NL			\
+	CFI_POST_PADDING					\
 	SYM_FUNC_END(__cfi_##name)
 
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d..5296aea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -984,7 +984,11 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 }
 
 #ifdef CONFIG_X86_64
+#ifdef CONFIG_CALL_THUNKS
+#define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5+CONFIG_FUNCTION_PADDING_BYTES,CONFIG_FUNCTION_PADDING_BYTES)))
+#else
 #define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5)))
+#endif
 #else
 #define BPF_DISPATCHER_ATTRIBUTES
 #endif
