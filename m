Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEDA68F430
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjBHRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjBHRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:18:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103901631F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UVQeiuX9JNrybr3vTrDUou/NlSIsINIfXwEcFtAl90I=; b=ZH68IY+o/6lVHH8bZPUDDpFFI4
        cgHj4H3pfxXcSnSc86rxiDDdBFsOPHH8h5It6z/Rl0NzOhPwvhMQLN6I65SorzQhO2GbjJyKy6pgI
        xEKSGw02ghVrFk8a5tvrPdc9seJ8QbIjRDof5mAsXRHgWDLTi1ZUf2sq9xtZINdgDjKYfIqfjWkFi
        BIfx+e77jK0irRUVpOULPYAzaSvEe8MaR3tcafsZ0oo1iGMpjIeg8CjfOX//9960d16mnVbgZ/oRT
        IxGRyguqLrJOquApw9xkXk+Cya1ctOtkcncgs0Nc8ClBlDwxhGIwIgIGBr98M865egmLUK+EmXCLy
        KuTJbLZg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPo3p-007VmH-0Y;
        Wed, 08 Feb 2023 17:16:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81FE130080C;
        Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5B2BB203C2EC8; Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Message-ID: <20230208171431.313857925@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:10:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, kirill.shutemov@linux.intel.com,
        Andrew.Cooper3@citrix.com, jpoimboe@redhat.com
Subject: [PATCH v3 2/4] x86/alternative: Support relocations in alternatives
References: <20230208171050.490809180@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A little while ago someone (Kirill) ran into the whole 'alternatives don't
do relocations nonsense' again and I got annoyed enough to actually look
at the code.

Since the whole alternative machinery already fully decodes the
instructions it is simple enough to adjust immediates and displacement
when needed. Specifically, the immediates for IP modifying instructions
(JMP, CALL, Jcc) and the displacement for RIP-relative instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c    |  255 +++++++++++++++++++++++++--------------
 tools/objtool/arch/x86/special.c |    8 -
 2 files changed, 167 insertions(+), 96 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -135,71 +135,6 @@ extern s32 __smp_locks[], __smp_locks_en
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
@@ -266,6 +201,133 @@ static void __init_or_module noinline op
 }
 
 /*
+ * What we start with is:
+ *
+ *   src_imm = target - src_next_ip                  (1)
+ *
+ * what we want is:
+ *
+ *   dst_imm = target - dst_next_ip                  (2)
+ *
+ * so what we do is rework (1) as an expression for target like:
+ *
+ *   target = src_imm + src_next_ip                  (1a)
+ *
+ * and substitute in (2) to get:
+ *
+ *   dst_imm = (src_imm + src_next_ip) - dst_next_ip (3)
+ *
+ * Now, since the instruction stream is 'identical' at src and dst (we copy
+ * after all) we can state that:
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
+					for (int j = 2; j < insn.length; j++)
+						buf[i+j] = INT3_INSN_OPCODE;
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
@@ -308,8 +370,10 @@ void __init_or_module noinline apply_alt
 		 * - feature not present but ALTINSTR_FLAG_INV is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV))
-			goto next;
+		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV)) {
+			optimize_nops(instr, a->instrlen);
+			continue;
+		}
 
 		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
 			(a->cpuid & ALTINSTR_FLAG_INV) ? "!" : "",
@@ -318,37 +382,19 @@ void __init_or_module noinline apply_alt
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
 
@@ -1346,6 +1392,35 @@ static noinline void __init int3_selftes
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
@@ -1433,6 +1508,8 @@ void __init alternative_instructions(voi
 
 	restart_nmi();
 	alternatives_patched = 1;
+
+	alt_reloc_selftest();
 }
 
 /**
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -42,13 +42,7 @@ bool arch_support_alt_relocation(struct
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


