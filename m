Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2667016D0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjEMNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjEMNDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:03:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58623C20;
        Sat, 13 May 2023 06:03:50 -0700 (PDT)
Date:   Sat, 13 May 2023 13:03:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683983029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCWcHN7aYm5UywvqOxB+bbmqKSSi/4Z9kjR3haRnzfE=;
        b=oBUz3pW0uswxwYGdJmp06G1tiEQw6hVQY80GKk4vq3pKEZWEdnTcsdxE9764XNyVY5CJG5
        pTtz4e0KxRP0RVVGWEGfa3YtjOKiK5DOcxvksTeJI6oI22XAhaoVbPgT/Hrp39twRTbMOa
        tcwwiqzoHd64HBjBLoaMO8J2wGZ1NI/P2FMO6vJEIT+OBSMKENCR45teW1Is4q6v1Vriwg
        ou7q/Bng5pV+9O48Rq17ZvXc5zcg5xNuplTxWAPLiyMVWK8eKV/lnB01siu+CPfsNSMeO5
        g3g+m1x4BHule/zfuSGdVZ2wvf/lWo7oRI+Gf6cdeLrgJRDRYs7sorjQkij83A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683983029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCWcHN7aYm5UywvqOxB+bbmqKSSi/4Z9kjR3haRnzfE=;
        b=xPUk2bmJDGlBJ1LBUqzIJ+OGqPhGePzB/FPU6QXS3wK+9oIfLhnljex7GHOf3NLMR+pNl2
        FG+qJhCOytTQYwDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Support relocations in alternatives
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230208171431.313857925@infradead.org>
References: <20230208171431.313857925@infradead.org>
MIME-Version: 1.0
Message-ID: <168398302906.404.7503197602701347579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     270a69c4485d7d07516d058bcc0473c90ee22185
Gitweb:        https://git.kernel.org/tip/270a69c4485d7d07516d058bcc0473c90ee22185
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:10:52 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 10 May 2023 14:47:08 +02:00

x86/alternative: Support relocations in alternatives

A little while ago someone (Kirill) ran into the whole 'alternatives don't
do relocations nonsense' again and I got annoyed enough to actually look
at the code.

Since the whole alternative machinery already fully decodes the
instructions it is simple enough to adjust immediates and displacement
when needed. Specifically, the immediates for IP modifying instructions
(JMP, CALL, Jcc) and the displacement for RIP-relative instructions.

  [ bp: Massage comment some more and get rid of third loop in
    apply_relocation(). ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230208171431.313857925@infradead.org
---
 arch/x86/kernel/alternative.c    | 261 +++++++++++++++++++-----------
 tools/objtool/arch/x86/special.c |   8 +-
 2 files changed, 173 insertions(+), 96 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b3ae6cf..28eb1d0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -135,71 +135,6 @@ extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
- * Are we looking at a near JMP with a 1 or 4-byte displacement.
- */
-static inline bool is_jmp(const u8 opcode)
-{
-	return opcode == 0xeb || opcode == 0xe9;
-}
-
-static void __init_or_module
-recompute_jump(struct alt_instr *a, u8 *orig_insn, u8 *repl_insn, u8 *insn_buff)
-{
-	u8 *next_rip, *tgt_rip;
-	s32 n_dspl, o_dspl;
-	int repl_len;
-
-	if (a->replacementlen != 5)
-		return;
-
-	o_dspl = *(s32 *)(insn_buff + 1);
-
-	/* next_rip of the replacement JMP */
-	next_rip = repl_insn + a->replacementlen;
-	/* target rip of the replacement JMP */
-	tgt_rip  = next_rip + o_dspl;
-	n_dspl = tgt_rip - orig_insn;
-
-	DPRINTK(ALT, "target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
-
-	if (tgt_rip - orig_insn >= 0) {
-		if (n_dspl - 2 <= 127)
-			goto two_byte_jmp;
-		else
-			goto five_byte_jmp;
-	/* negative offset */
-	} else {
-		if (((n_dspl - 2) & 0xff) == (n_dspl - 2))
-			goto two_byte_jmp;
-		else
-			goto five_byte_jmp;
-	}
-
-two_byte_jmp:
-	n_dspl -= 2;
-
-	insn_buff[0] = 0xeb;
-	insn_buff[1] = (s8)n_dspl;
-	add_nops(insn_buff + 2, 3);
-
-	repl_len = 2;
-	goto done;
-
-five_byte_jmp:
-	n_dspl -= 5;
-
-	insn_buff[0] = 0xe9;
-	*(s32 *)&insn_buff[1] = n_dspl;
-
-	repl_len = 5;
-
-done:
-
-	DPRINTK(ALT, "final displ: 0x%08x, JMP 0x%lx",
-		n_dspl, (unsigned long)orig_insn + n_dspl + repl_len);
-}
-
-/*
  * optimize_nops_range() - Optimize a sequence of single byte NOPs (0x90)
  *
  * @instr: instruction byte stream
@@ -266,6 +201,139 @@ static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 }
 
 /*
+ * In this context, "source" is where the instructions are placed in the
+ * section .altinstr_replacement, for example during kernel build by the
+ * toolchain.
+ * "Destination" is where the instructions are being patched in by this
+ * machinery.
+ *
+ * The source offset is:
+ *
+ *   src_imm = target - src_next_ip                  (1)
+ *
+ * and the target offset is:
+ *
+ *   dst_imm = target - dst_next_ip                  (2)
+ *
+ * so rework (1) as an expression for target like:
+ *
+ *   target = src_imm + src_next_ip                  (1a)
+ *
+ * and substitute in (2) to get:
+ *
+ *   dst_imm = (src_imm + src_next_ip) - dst_next_ip (3)
+ *
+ * Now, since the instruction stream is 'identical' at src and dst (it
+ * is being copied after all) it can be stated that:
+ *
+ *   src_next_ip = src + ip_offset
+ *   dst_next_ip = dst + ip_offset                   (4)
+ *
+ * Substitute (4) in (3) and observe ip_offset being cancelled out to
+ * obtain:
+ *
+ *   dst_imm = src_imm + (src + ip_offset) - (dst + ip_offset)
+ *           = src_imm + src - dst + ip_offset - ip_offset
+ *           = src_imm + src - dst                   (5)
+ *
+ * IOW, only the relative displacement of the code block matters.
+ */
+
+#define apply_reloc_n(n_, p_, d_)				\
+	do {							\
+		s32 v = *(s##n_ *)(p_);				\
+		v += (d_);					\
+		BUG_ON((v >> 31) != (v >> (n_-1)));		\
+		*(s##n_ *)(p_) = (s##n_)v;			\
+	} while (0)
+
+
+static __always_inline
+void apply_reloc(int n, void *ptr, uintptr_t diff)
+{
+	switch (n) {
+	case 1: apply_reloc_n(8, ptr, diff); break;
+	case 2: apply_reloc_n(16, ptr, diff); break;
+	case 4: apply_reloc_n(32, ptr, diff); break;
+	default: BUG();
+	}
+}
+
+static __always_inline
+bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
+{
+	u8 *target = src + offset;
+	/*
+	 * If the target is inside the patched block, it's relative to the
+	 * block itself and does not need relocation.
+	 */
+	return (target < src || target > src + src_len);
+}
+
+static void __init_or_module noinline
+apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
+{
+	for (int next, i = 0; i < len; i = next) {
+		struct insn insn;
+
+		if (WARN_ON_ONCE(insn_decode_kernel(&insn, &buf[i])))
+			return;
+
+		next = i + insn.length;
+
+		switch (insn.opcode.bytes[0]) {
+		case 0x0f:
+			if (insn.opcode.bytes[1] < 0x80 ||
+			    insn.opcode.bytes[1] > 0x8f)
+				break;
+
+			fallthrough;	/* Jcc.d32 */
+		case 0x70 ... 0x7f:	/* Jcc.d8 */
+		case JMP8_INSN_OPCODE:
+		case JMP32_INSN_OPCODE:
+		case CALL_INSN_OPCODE:
+			if (need_reloc(next + insn.immediate.value, src, src_len)) {
+				apply_reloc(insn.immediate.nbytes,
+					    buf + i + insn_offset_immediate(&insn),
+					    src - dest);
+			}
+
+			/*
+			 * Where possible, convert JMP.d32 into JMP.d8.
+			 */
+			if (insn.opcode.bytes[0] == JMP32_INSN_OPCODE) {
+				s32 imm = insn.immediate.value;
+				imm += src - dest;
+				imm += JMP32_INSN_SIZE - JMP8_INSN_SIZE;
+				if ((imm >> 31) == (imm >> 7)) {
+					buf[i+0] = JMP8_INSN_OPCODE;
+					buf[i+1] = (s8)imm;
+
+					memset(&buf[i+2], INT3_INSN_OPCODE, insn.length - 2);
+				}
+			}
+			break;
+		}
+
+		if (insn_rip_relative(&insn)) {
+			if (need_reloc(next + insn.displacement.value, src, src_len)) {
+				apply_reloc(insn.displacement.nbytes,
+					    buf + i + insn_offset_displacement(&insn),
+					    src - dest);
+			}
+		}
+
+
+		/*
+		 * See if this and any potentially following NOPs can be
+		 * optimized.
+		 */
+		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
+			next = i + optimize_nops_range(buf, len, i);
+	}
+}
+
+/*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
  * This implies that asymmetric systems where APs have less capabilities than
@@ -306,8 +374,10 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 * - feature not present but ALT_FLAG_NOT is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT))
-			goto next;
+		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
+			optimize_nops(instr, a->instrlen);
+			continue;
+		}
 
 		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
 			(a->flags & ALT_FLAG_NOT) ? "!" : "",
@@ -316,37 +386,19 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
-
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
-		/*
-		 * 0xe8 is a relative jump; fix the offset.
-		 *
-		 * Instruction length is checked before the opcode to avoid
-		 * accessing uninitialized bytes for zero-length replacements.
-		 */
-		if (a->replacementlen == 5 && *insn_buff == 0xe8) {
-			*(s32 *)(insn_buff + 1) += replacement - instr;
-			DPRINTK(ALT, "Fix CALL offset: 0x%x, CALL 0x%lx",
-				*(s32 *)(insn_buff + 1),
-				(unsigned long)instr + *(s32 *)(insn_buff + 1) + 5);
-		}
-
-		if (a->replacementlen && is_jmp(replacement[0]))
-			recompute_jump(a, instr, replacement, insn_buff);
-
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
+		apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replacementlen);
+
+		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
-
-next:
-		optimize_nops(instr, a->instrlen);
 	}
 }
 
@@ -1344,6 +1396,35 @@ static noinline void __init int3_selftest(void)
 	unregister_die_notifier(&int3_exception_nb);
 }
 
+static __initdata int __alt_reloc_selftest_addr;
+
+__visible noinline void __init __alt_reloc_selftest(void *arg)
+{
+	WARN_ON(arg != &__alt_reloc_selftest_addr);
+}
+
+static noinline void __init alt_reloc_selftest(void)
+{
+	/*
+	 * Tests apply_relocation().
+	 *
+	 * This has a relative immediate (CALL) in a place other than the first
+	 * instruction and additionally on x86_64 we get a RIP-relative LEA:
+	 *
+	 *   lea    0x0(%rip),%rdi  # 5d0: R_X86_64_PC32    .init.data+0x5566c
+	 *   call   +0              # 5d5: R_X86_64_PLT32   __alt_reloc_selftest-0x4
+	 *
+	 * Getting this wrong will either crash and burn or tickle the WARN
+	 * above.
+	 */
+	asm_inline volatile (
+		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftest;", X86_FEATURE_ALWAYS)
+		: /* output */
+		: [mem] "m" (__alt_reloc_selftest_addr)
+		: _ASM_ARG1
+	);
+}
+
 void __init alternative_instructions(void)
 {
 	int3_selftest();
@@ -1431,6 +1512,8 @@ void __init alternative_instructions(void)
 
 	restart_nmi();
 	alternatives_patched = 1;
+
+	alt_reloc_selftest();
 }
 
 /**
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 7c97b73..799ad6b 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -42,13 +42,7 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc)
 {
-	/*
-	 * The x86 alternatives code adjusts the offsets only when it
-	 * encounters a branch instruction at the very beginning of the
-	 * replacement group.
-	 */
-	return insn->offset == special_alt->new_off &&
-	       (insn->type == INSN_CALL || is_jump(insn));
+	return true;
 }
 
 /*
