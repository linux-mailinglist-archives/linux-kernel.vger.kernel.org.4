Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC67A602D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJRNgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJRNgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:36:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED062C96EA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=doeA8dKWih0ZjmZNtHhITy8GLmdF5nErUZWZF4vEd1o=; b=jWWoihMmyjMDiIf28n1clFMy1u
        6XMngf2C/HG+qq263k2taGI2iJ+3hdeskw2P6SqUvWYPP1TOfgXdah7pAYVVQBWeqT749zYymvs8O
        qbdYBJVnbvyFeZF9VGqJg/CRkALUddJE6D3/MptKbyKbNzQJLy1hiN0Aw+bIZ7i8bJAPwVt7Oliy8
        q8S6Hh0HStB214q2P5qepFKVvfd4zTKxJU78K5Bwlb99ISC61a12Pxc1qzEpJ1RCzcwzAxu1mFA1m
        Cf96M9sHDqvx1bQtfTmhmGf4AD/qtJwnuFkmzObMF2lWUpGvRKu4GUt6ZZk8Tgdfttfv+iTdI13OH
        gPdLRuEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okml5-004UnX-9P; Tue, 18 Oct 2022 13:35:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67563300431;
        Tue, 18 Oct 2022 15:35:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 423742829911B; Tue, 18 Oct 2022 15:35:50 +0200 (CEST)
Date:   Tue, 18 Oct 2022 15:35:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

Obviously this patch relies on kCFI (upstream), but additionally it also
relies on the padding from the call-depth-tracking patches
(tip/x86/core). It uses this padding to place the hash-validation while
the call-sites are re-written to modify the indirect target to be 16
bytes in front of the original target, thus hitting this new preamble.

Notably, there is no hardware that needs call-depth-tracking (Skylake)
and supports IBT (Tigerlake and onwards).

Suggested-by: Joao Moreira (Intel) <joao@overdrivepizza.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

In fact, due to:

  https://lkml.kernel.org/r/Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net

I would suggest people interested in testing this use:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt

Which has all the various parts merged.

 arch/um/kernel/um_arch.c                |    5 
 arch/x86/Kconfig                        |   12 +
 arch/x86/Makefile                       |    2 
 arch/x86/include/asm/alternative.h      |    2 
 arch/x86/include/asm/linkage.h          |    6 
 arch/x86/kernel/alternative.c           |  253 ++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c            |    1 
 arch/x86/kernel/module.c                |   20 ++
 arch/x86/kernel/vmlinux.lds.S           |    9 +
 include/linux/bpf.h                     |    2 
 scripts/Makefile.lib                    |    1 
 tools/objtool/builtin-check.c           |    6 
 tools/objtool/check.c                   |   63 +++++++
 tools/objtool/include/objtool/builtin.h |    1 
 14 files changed, 363 insertions(+), 20 deletions(-)

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
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2464,13 +2464,23 @@ config FUNCTION_PADDING_BYTES
 	default FUNCTION_PADDING_CFI if CFI_CLANG
 	default FUNCTION_ALIGNMENT
 
+config CALL_PADDING
+	def_bool n
+	depends on CC_HAS_ENTRY_PADDING && OBJTOOL
+	select FUNCTION_ALIGNMENT_16B
+
+config FINEIBT
+	def_bool y
+	depends on X86_KERNEL_IBT && CFI_CLANG
+	select CALL_PADDING
+
 config HAVE_CALL_THUNKS
 	def_bool y
 	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
 
 config CALL_THUNKS
 	def_bool n
-	select FUNCTION_ALIGNMENT_16B
+	select CALL_PADDING
 
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
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
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -78,6 +78,8 @@ extern void apply_alternatives(struct al
 extern void apply_retpolines(s32 *start, s32 *end);
 extern void apply_returns(s32 *start, s32 *end);
 extern void apply_ibt_endbr(s32 *start, s32 *end);
+extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
+			  s32 *start_cfi, s32 *end_cfi);
 
 struct module;
 struct paravirt_patch_site;
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
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -116,6 +116,7 @@ static void __init_or_module add_nops(vo
 
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
+extern s32 __cfi_sites[], __cfi_sites_end[];
 extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
@@ -656,6 +657,28 @@ void __init_or_module noinline apply_ret
 
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
@@ -664,31 +687,232 @@ void __init_or_module noinline apply_ibt
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
+ *	movl   $0x12345678,%eax			     endbr64			// 4
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
@@ -996,6 +1220,9 @@ void __init alternative_instructions(voi
 	 */
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
+	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
+			__cfi_sites, __cfi_sites_end, true);
+
 	/*
 	 * Rewrite the retpolines, must be done before alternatives since
 	 * those can rewrite the retpoline thunks.
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -609,6 +609,7 @@ static __always_inline void setup_cet(st
 
 	if (!ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
+		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
 		return;
 	}
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
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -984,7 +984,7 @@ int arch_prepare_bpf_dispatcher(void *im
 }
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_CALL_THUNKS
+#ifdef CONFIG_CALL_PADDING
 #define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5+CONFIG_FUNCTION_PADDING_BYTES,CONFIG_FUNCTION_PADDING_BYTES)))
 #else
 #define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5)))
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -256,6 +256,7 @@ objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HA
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
 objtool-args-$(CONFIG_CALL_DEPTH_TRACKING)		+= --hacks=skylake
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
+objtool-args-$(CONFIG_FINEIBT)                          += --cfi
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
 objtool-args-$(CONFIG_RETPOLINE)			+= --retpoline
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -79,6 +79,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
 	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
+	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "generate cfi_sites"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
@@ -206,6 +207,11 @@ int objtool_run(int argc, const char **a
 	if (!link_opts_valid(file))
 		return 1;
 
+	if (opts.cfi && !opts.ibt) {
+		ERROR("--cfi requires --ibt");
+		return 1;
+	}
+
 	ret = check(file);
 	if (ret)
 		return ret;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -861,6 +861,62 @@ static int create_ibt_endbr_seal_section
 	return 0;
 }
 
+static int create_cfi_sections(struct objtool_file *file)
+{
+	struct section *sec, *s;
+	struct symbol *sym;
+	unsigned int *loc;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".cfi_sites");
+	if (sec) {
+		INIT_LIST_HEAD(&file->call_list);
+		WARN("file already has .cfi_sites section, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	for_each_sec(file, s) {
+		if (!s->text)
+			continue;
+
+		list_for_each_entry(sym, &s->symbol_list, list) {
+			if (strncmp(sym->name, "__cfi_", 6))
+				continue;
+
+			idx++;
+		}
+	}
+
+	sec = elf_create_section(file->elf, ".cfi_sites", 0, sizeof(unsigned int), idx);
+	if (!sec)
+		return -1;
+
+	idx = 0;
+	for_each_sec(file, s) {
+		if (!s->text)
+			continue;
+
+		list_for_each_entry(sym, &s->symbol_list, list) {
+			if (strncmp(sym->name, "__cfi_", 6))
+				continue;
+
+			loc = (unsigned int *)sec->data->d_buf + idx;
+			memset(loc, 0, sizeof(unsigned int));
+
+			if (elf_add_reloc_to_insn(file->elf, sec,
+						  idx * sizeof(unsigned int),
+						  R_X86_64_PC32,
+						  s, sym->offset))
+				return -1;
+
+			idx++;
+		}
+	}
+
+	return 0;
+}
+
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
 	struct section *sec;
@@ -4397,6 +4453,13 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+	}
+
+	if (opts.cfi) {
+		ret = create_cfi_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.rethunk) {
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -26,6 +26,7 @@ struct opts {
 	bool stackval;
 	bool static_call;
 	bool uaccess;
+	bool cfi;
 
 	/* options: */
 	bool backtrace;
