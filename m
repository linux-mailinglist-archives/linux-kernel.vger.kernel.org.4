Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A9615F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKBJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiKBJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE466557;
        Wed,  2 Nov 2022 02:20:03 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:20:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GowoYa59dK5GsnCO1rA3KuWbLkKRq3INQhFHyydBf0=;
        b=XajlubdZfentfJqDR+k+96gDD9Wq0H29eWx/181gw8tb3uoLgGkLZ7vXlZ5avP///Mz0hL
        H8XpMHX+sJfWr2n6HM6OqoFG84q+XvsayLnfVfRgMvGLM4UydMaw2tAI+JEDCvVj91IwrJ
        km9QYmuqbwSFKRxiu15609fsIQIHB8F3lLqLx+HU5m6sBDg7+sLeY5jgFabVwn8gJZ+zE7
        8V3wSsF5ZIz2Fafbvzl18iBGByzAjSZ2xpv9zLaDs/pELjXuK2wyvWIrnDWUcswpAx5/6w
        nEGiLb4WjtQfOBrqq9Xjo8sVU5Gnw2YuiQD9AWYCyGctmSPC9JHFLQ7BX6pcDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GowoYa59dK5GsnCO1rA3KuWbLkKRq3INQhFHyydBf0=;
        b=mKdIaUaLRDvAqYlL0I27aPUYOv2gJfV9sOatqi1cVBXj7ro/P62rvFD83xqTV8sb0pbBrJ
        HugiY0cGHH8ATcCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Implement FineIBT
Cc:     "Joao Moreira (Intel)" <joao@overdrivepizza.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221027092842.634714496@infradead.org>
References: <20221027092842.634714496@infradead.org>
MIME-Version: 1.0
Message-ID: <166738080054.7716.13799847622767311106.tip-bot2@tip-bot2>
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

Commit-ID:     931ab63664f02b17d2213ef36b83e1e50190a0aa
Gitweb:        https://git.kernel.org/tip/931ab63664f02b17d2213ef36b83e1e50190a0aa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 27 Oct 2022 11:28:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:10 +01:00

x86/ibt: Implement FineIBT

Implement an alternative CFI scheme that merges both the fine-grained
nature of kCFI but also takes full advantage of the coarse grained
hardware CFI as provided by IBT.

To contrast:

  kCFI is a pure software CFI scheme and relies on being able to read
text -- specifically the instruction *before* the target symbol, and
does the hash validation *before* doing the call (otherwise control
flow is compromised already).

  FineIBT is a software and hardware hybrid scheme; by ensuring every
branch target starts with a hash validation it is possible to place
the hash validation after the branch. This has several advantages:

   o the (hash) load is avoided; no memop; no RX requirement.

   o IBT WAIT-FOR-ENDBR state is a speculation stop; by placing
     the hash validation in the immediate instruction after
     the branch target there is a minimal speculation window
     and the whole is a viable defence against SpectreBHB.

   o Kees feels obliged to mention it is slightly more vulnerable
     when the attacker can write code.

Obviously this patch relies on kCFI, but additionally it also relies
on the padding from the call-depth-tracking patches. It uses this
padding to place the hash-validation while the call-sites are
re-written to modify the indirect target to be 16 bytes in front of
the original target, thus hitting this new preamble.

Notably, there is no hardware that needs call-depth-tracking (Skylake)
and supports IBT (Tigerlake and onwards).

Suggested-by: Joao Moreira (Intel) <joao@overdrivepizza.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20221027092842.634714496@infradead.org
---
 arch/um/kernel/um_arch.c           |   5 +-
 arch/x86/Kconfig                   |  14 +-
 arch/x86/Makefile                  |   2 +-
 arch/x86/include/asm/alternative.h |   2 +-
 arch/x86/include/asm/linkage.h     |   6 +-
 arch/x86/kernel/alternative.c      | 253 ++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c       |   1 +-
 arch/x86/kernel/module.c           |  20 +-
 arch/x86/kernel/vmlinux.lds.S      |   9 +-
 include/linux/bpf.h                |   2 +-
 scripts/Makefile.lib               |   1 +-
 11 files changed, 294 insertions(+), 21 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8adf8e8..786b44d 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -444,6 +444,11 @@ void apply_returns(s32 *start, s32 *end)
 {
 }
 
+void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
+		   s32 *start_cfi, s32 *end_cfi)
+{
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 32818aa..479ee63 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2463,17 +2463,27 @@ config FUNCTION_PADDING_BYTES
 	default FUNCTION_PADDING_CFI if CFI_CLANG
 	default FUNCTION_ALIGNMENT
 
+config CALL_PADDING
+	def_bool n
+	depends on CC_HAS_ENTRY_PADDING && OBJTOOL
+	select FUNCTION_ALIGNMENT_16B
+
+config FINEIBT
+	def_bool y
+	depends on X86_KERNEL_IBT && CFI_CLANG && RETPOLINE
+	select CALL_PADDING
+
 config HAVE_CALL_THUNKS
 	def_bool y
 	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
 
 config CALL_THUNKS
 	def_bool n
-	select FUNCTION_ALIGNMENT_16B
+	select CALL_PADDING
 
 config PREFIX_SYMBOLS
 	def_bool y
-	depends on CALL_THUNKS && !CFI_CLANG
+	depends on CALL_PADDING && !CFI_CLANG
 
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1640e00..a3a07df 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -208,7 +208,7 @@ ifdef CONFIG_SLS
   KBUILD_CFLAGS += -mharden-sls=all
 endif
 
-ifdef CONFIG_CALL_THUNKS
+ifdef CONFIG_CALL_PADDING
 PADDING_CFLAGS := -fpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
 KBUILD_CFLAGS += $(PADDING_CFLAGS)
 export PADDING_CFLAGS
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 664c077..7659217 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -78,6 +78,8 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 extern void apply_retpolines(s32 *start, s32 *end);
 extern void apply_returns(s32 *start, s32 *end);
 extern void apply_ibt_endbr(s32 *start, s32 *end);
+extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
+			  s32 *start_cfi, s32 *end_cfi);
 
 struct module;
 struct paravirt_patch_site;
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 45e0df8..dd9b811 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -15,7 +15,7 @@
 #define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #define __ALIGN_STR	__stringify(__ALIGN)
 
-#if defined(CONFIG_CALL_THUNKS) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#if defined(CONFIG_CALL_PADDING) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define FUNCTION_PADDING	.skip CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #else
 #define FUNCTION_PADDING
@@ -57,7 +57,7 @@
 #endif /* __ASSEMBLY__ */
 
 /*
- * Depending on -fpatchable-function-entry=N,N usage (CONFIG_CALL_THUNKS) the
+ * Depending on -fpatchable-function-entry=N,N usage (CONFIG_CALL_PADDING) the
  * CFI symbol layout changes.
  *
  * Without CALL_THUNKS:
@@ -81,7 +81,7 @@
  * In both cases the whole thing is FUNCTION_ALIGNMENT aligned and sized.
  */
 
-#ifdef CONFIG_CALL_THUNKS
+#ifdef CONFIG_CALL_PADDING
 #define CFI_PRE_PADDING
 #define CFI_POST_PADDING	.skip	CONFIG_FUNCTION_PADDING_BYTES, 0x90;
 #else
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b4ac4e5..91b0e63 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -116,6 +116,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
+extern s32 __cfi_sites[], __cfi_sites_end[];
 extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
@@ -656,6 +657,28 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+static void poison_endbr(void *addr, bool warn)
+{
+	u32 endbr, poison = gen_endbr_poison();
+
+	if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
+		return;
+
+	if (!is_endbr(endbr)) {
+		WARN_ON_ONCE(warn);
+		return;
+	}
+
+	DPRINTK("ENDBR at: %pS (%px)", addr, addr);
+
+	/*
+	 * When we have IBT, the lack of ENDBR will trigger #CP
+	 */
+	DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
+	DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
+	text_poke_early(addr, &poison, 4);
+}
+
 /*
  * Generated by: objtool --ibt
  */
@@ -664,31 +687,232 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
 	s32 *s;
 
 	for (s = start; s < end; s++) {
-		u32 endbr, poison = gen_endbr_poison();
 		void *addr = (void *)s + *s;
 
-		if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
-			continue;
+		poison_endbr(addr, true);
+		if (IS_ENABLED(CONFIG_FINEIBT))
+			poison_endbr(addr - 16, false);
+	}
+}
+
+#else
+
+void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
+
+#endif /* CONFIG_X86_KERNEL_IBT */
+
+#ifdef CONFIG_FINEIBT
+/*
+ * kCFI						FineIBT
+ *
+ * __cfi_\func:					__cfi_\func:
+ *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
+ *	nop					     subl   $0x12345678,%r10d   // 7
+ *	nop					     jz     1f			// 2
+ *	nop					     ud2			// 2
+ *	nop					1:   nop			// 1
+ *	nop
+ *	nop
+ *	nop
+ *	nop
+ *	nop
+ *	nop
+ *	nop
+ *
+ *
+ * caller:					caller:
+ *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
+ *	addl	$-15(%r11),%r10d	 // 4	     sub    $16,%r11		// 4
+ *	je	1f			 // 2	     nop4			// 4
+ *	ud2				 // 2
+ * 1:	call	__x86_indirect_thunk_r11 // 5	     call   *%r11; nop2;	// 5
+ *
+ */
+
+asm(	".pushsection .rodata			\n"
+	"fineibt_preamble_start:		\n"
+	"	endbr64				\n"
+	"	subl	$0x12345678, %r10d	\n"
+	"	je	fineibt_preamble_end	\n"
+	"	ud2				\n"
+	"	nop				\n"
+	"fineibt_preamble_end:			\n"
+	".popsection\n"
+);
+
+extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_end[];
+
+#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_hash 7
+
+asm(	".pushsection .rodata			\n"
+	"fineibt_caller_start:			\n"
+	"	movl	$0x12345678, %r10d	\n"
+	"	sub	$16, %r11		\n"
+	ASM_NOP4
+	"fineibt_caller_end:			\n"
+	".popsection				\n"
+);
+
+extern u8 fineibt_caller_start[];
+extern u8 fineibt_caller_end[];
+
+#define fineibt_caller_size (fineibt_caller_end - fineibt_caller_start)
+#define fineibt_caller_hash 2
+
+#define fineibt_caller_jmp (fineibt_caller_size - 2)
+
+static u32 decode_preamble_hash(void *addr)
+{
+	u8 *p = addr;
+
+	/* b8 78 56 34 12          mov    $0x12345678,%eax */
+	if (p[0] == 0xb8)
+		return *(u32 *)(addr + 1);
+
+	return 0; /* invalid hash value */
+}
+
+static u32 decode_caller_hash(void *addr)
+{
+	u8 *p = addr;
+
+	/* 41 ba 78 56 34 12       mov    $0x12345678,%r10d */
+	if (p[0] == 0x41 && p[1] == 0xba)
+		return -*(u32 *)(addr + 2);
+
+	/* e8 0c 78 56 34 12	   jmp.d8  +12 */
+	if (p[0] == JMP8_INSN_OPCODE && p[1] == fineibt_caller_jmp)
+		return -*(u32 *)(addr + 2);
+
+	return 0; /* invalid hash value */
+}
+
+/* .retpoline_sites */
+static int cfi_disable_callers(s32 *start, s32 *end)
+{
+	/*
+	 * Disable kCFI by patching in a JMP.d8, this leaves the hash immediate
+	 * in tact for later usage. Also see decode_caller_hash() and
+	 * cfi_rewrite_callers().
+	 */
+	const u8 jmp[] = { JMP8_INSN_OPCODE, fineibt_caller_jmp };
+	s32 *s;
 
-		if (WARN_ON_ONCE(!is_endbr(endbr)))
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u32 hash;
+
+		addr -= fineibt_caller_size;
+		hash = decode_caller_hash(addr);
+		if (!hash) /* nocfi callers */
 			continue;
 
-		DPRINTK("ENDBR at: %pS (%px)", addr, addr);
+		text_poke_early(addr, jmp, 2);
+	}
 
-		/*
-		 * When we have IBT, the lack of ENDBR will trigger #CP
-		 */
-		DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
-		DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
-		text_poke_early(addr, &poison, 4);
+	return 0;
+}
+
+/* .cfi_sites */
+static int cfi_rewrite_preamble(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u32 hash;
+
+		hash = decode_preamble_hash(addr);
+		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
+			 addr, addr, 5, addr))
+			return -EINVAL;
+
+		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
+		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
+		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
 	}
+
+	return 0;
+}
+
+/* .retpoline_sites */
+static int cfi_rewrite_callers(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u32 hash;
+
+		addr -= fineibt_caller_size;
+		hash = decode_caller_hash(addr);
+		if (hash) {
+			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
+			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
+			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
+		}
+		/* rely on apply_retpolines() */
+	}
+
+	return 0;
+}
+
+static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
+			    s32 *start_cfi, s32 *end_cfi, bool builtin)
+{
+	int ret;
+
+	if (WARN_ONCE(fineibt_preamble_size != 16,
+		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
+		return;
+
+	if (!HAS_KERNEL_IBT || !cpu_feature_enabled(X86_FEATURE_IBT))
+		return;
+
+	/*
+	 * Rewrite the callers to not use the __cfi_ stubs, such that we might
+	 * rewrite them. This disables all CFI. If this succeeds but any of the
+	 * later stages fails, we're without CFI.
+	 */
+	ret = cfi_disable_callers(start_retpoline, end_retpoline);
+	if (ret)
+		goto err;
+
+	ret = cfi_rewrite_preamble(start_cfi, end_cfi);
+	if (ret)
+		goto err;
+
+	ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
+	if (ret)
+		goto err;
+
+	if (builtin)
+		pr_info("Using FineIBT CFI\n");
+
+	return;
+
+err:
+	pr_err("Something went horribly wrong trying to rewrite the CFI implementation.\n");
 }
 
 #else
 
-void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
+static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
+			    s32 *start_cfi, s32 *end_cfi, bool builtin)
+{
+}
 
-#endif /* CONFIG_X86_KERNEL_IBT */
+#endif
+
+void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
+		   s32 *start_cfi, s32 *end_cfi)
+{
+	return __apply_fineibt(start_retpoline, end_retpoline,
+			       start_cfi, end_cfi,
+			       /* .builtin = */ false);
+}
 
 #ifdef CONFIG_SMP
 static void alternatives_smp_lock(const s32 *start, const s32 *end,
@@ -996,6 +1220,9 @@ void __init alternative_instructions(void)
 	 */
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
+	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
+			__cfi_sites, __cfi_sites_end, true);
+
 	/*
 	 * Rewrite the retpolines, must be done before alternatives since
 	 * those can rewrite the retpoline thunks.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2bec4b4..423a760 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -609,6 +609,7 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 
 	if (!ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
+		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
 		return;
 	}
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 2fb9de2..0142982 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -255,7 +255,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
-		*calls = NULL;
+		*calls = NULL, *cfi = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -277,6 +277,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			returns = s;
 		if (!strcmp(".call_sites", secstrings + s->sh_name))
 			calls = s;
+		if (!strcmp(".cfi_sites", secstrings + s->sh_name))
+			cfi = s;
 		if (!strcmp(".ibt_endbr_seal", secstrings + s->sh_name))
 			ibt_endbr = s;
 	}
@@ -289,6 +291,22 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *pseg = (void *)para->sh_addr;
 		apply_paravirt(pseg, pseg + para->sh_size);
 	}
+	if (retpolines || cfi) {
+		void *rseg = NULL, *cseg = NULL;
+		unsigned int rsize = 0, csize = 0;
+
+		if (retpolines) {
+			rseg = (void *)retpolines->sh_addr;
+			rsize = retpolines->sh_size;
+		}
+
+		if (cfi) {
+			cseg = (void *)cfi->sh_addr;
+			csize = cfi->sh_size;
+		}
+
+		apply_fineibt(rseg, rseg + rsize, cseg, cseg + csize);
+	}
 	if (retpolines) {
 		void *rseg = (void *)retpolines->sh_addr;
 		apply_retpolines(rseg, rseg + retpolines->sh_size);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 49f3f86..2e0ee14 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -309,6 +309,15 @@ SECTIONS
 	}
 #endif
 
+#ifdef CONFIG_FINEIBT
+	. = ALIGN(8);
+	.cfi_sites : AT(ADDR(.cfi_sites) - LOAD_OFFSET) {
+		__cfi_sites = .;
+		*(.cfi_sites)
+		__cfi_sites_end = .;
+	}
+#endif
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5296aea..923a3d5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -984,7 +984,7 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 }
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_CALL_THUNKS
+#ifdef CONFIG_CALL_PADDING
 #define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5+CONFIG_FUNCTION_PADDING_BYTES,CONFIG_FUNCTION_PADDING_BYTES)))
 #else
 #define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5)))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 2e03bcb..2b2fab7 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -256,6 +256,7 @@ objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
 objtool-args-$(CONFIG_CALL_DEPTH_TRACKING)		+= --hacks=skylake
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
+objtool-args-$(CONFIG_FINEIBT)				+= --cfi
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
 objtool-args-$(CONFIG_RETPOLINE)			+= --retpoline
