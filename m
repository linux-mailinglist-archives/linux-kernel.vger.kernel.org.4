Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0742068F432
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjBHRSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjBHRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:18:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCE16329
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oj0fvK4V4N7p3dEXp+LHTlqjdAg7rjujFs4lgyt9C0w=; b=ixavzs7m1xDzIznheBD2ON1Wke
        deUL6diBo8Tm8+bRXb9njdOBSANYWu7/RQDdV/XGF9iy+fKyE08eSo0gac6trTRFCR3zHReh36x3I
        d9ss0UnjbtKOdSlpEcAPlPTq9fMiDuNHsMcAuBkUrNHZl0x8RO6s+9puXMXE/kMYq0mAXK3br4lUl
        8pVPE5WNBUrFredkgRhXQWgiY1sj0mxf5KAErHaKZqcAMmy1MDQSKs9ef7H6UrQpUuqzytKFotADR
        GD4qk0QxRK0bqh8T/uAZmqOdy5IhQYC99pwqzOPTeX7orGjOpA6KrduV1TEVOFNle7ym7mphR07y3
        ymsu17fg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPo3p-007VmF-0Z;
        Wed, 08 Feb 2023 17:16:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80442300446;
        Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 56DD6203C41EF; Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Message-ID: <20230208171431.253636689@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:10:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, kirill.shutemov@linux.intel.com,
        Andrew.Cooper3@citrix.com, jpoimboe@redhat.com
Subject: [PATCH v3 1/4] x86/alternative: Make debug-alternative selective
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

Using debug-alternative generates a *LOT* of output, extend it a bit
to select which of the many rewrites it reports on.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   62 +++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -37,11 +37,23 @@ EXPORT_SYMBOL_GPL(alternatives_patched);
 
 #define MAX_PATCH_LEN (255-1)
 
-static int __initdata_or_module debug_alternative;
+#define DA_ALL		(~0)
+#define DA_ALT		0x01
+#define DA_RET		0x02
+#define DA_RETPOLINE	0x04
+#define DA_ENDBR	0x08
+#define DA_SMP		0x10
+
+static unsigned int __initdata_or_module debug_alternative;
 
 static int __init debug_alt(char *str)
 {
-	debug_alternative = 1;
+	if (str && *str == '=')
+		str++;
+
+	if (!str || kstrtouint(str, 0, &debug_alternative))
+		debug_alternative = DA_ALL;
+
 	return 1;
 }
 __setup("debug-alternative", debug_alt);
@@ -55,15 +67,15 @@ static int __init setup_noreplace_smp(ch
 }
 __setup("noreplace-smp", setup_noreplace_smp);
 
-#define DPRINTK(fmt, args...)						\
+#define DPRINTK(type, fmt, args...)					\
 do {									\
-	if (debug_alternative)						\
+	if (debug_alternative & DA_##type)				\
 		printk(KERN_DEBUG pr_fmt(fmt) "\n", ##args);		\
 } while (0)
 
-#define DUMP_BYTES(buf, len, fmt, args...)				\
+#define DUMP_BYTES(type, buf, len, fmt, args...)			\
 do {									\
-	if (unlikely(debug_alternative)) {				\
+	if (unlikely(debug_alternative & DA_##type)) {			\
 		int j;							\
 									\
 		if (!(len))						\
@@ -148,7 +160,7 @@ recompute_jump(struct alt_instr *a, u8 *
 	tgt_rip  = next_rip + o_dspl;
 	n_dspl = tgt_rip - orig_insn;
 
-	DPRINTK("target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
+	DPRINTK(ALT, "target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
 
 	if (tgt_rip - orig_insn >= 0) {
 		if (n_dspl - 2 <= 127)
@@ -183,7 +195,7 @@ recompute_jump(struct alt_instr *a, u8 *
 
 done:
 
-	DPRINTK("final displ: 0x%08x, JMP 0x%lx",
+	DPRINTK(ALT, "final displ: 0x%08x, JMP 0x%lx",
 		n_dspl, (unsigned long)orig_insn + n_dspl + repl_len);
 }
 
@@ -217,7 +229,7 @@ static __always_inline int optimize_nops
 	add_nops(instr + off, nnops);
 	local_irq_restore(flags);
 
-	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
+	DUMP_BYTES(ALT, instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
 
 	return nnops;
 }
@@ -270,7 +282,7 @@ void __init_or_module noinline apply_alt
 	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
 
-	DPRINTK("alt table %px, -> %px", start, end);
+	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -299,15 +311,15 @@ void __init_or_module noinline apply_alt
 		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV))
 			goto next;
 
-		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
+		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
 			(a->cpuid & ALTINSTR_FLAG_INV) ? "!" : "",
 			feature >> 5,
 			feature & 0x1f,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
+		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
@@ -320,7 +332,7 @@ void __init_or_module noinline apply_alt
 		 */
 		if (a->replacementlen == 5 && *insn_buff == 0xe8) {
 			*(s32 *)(insn_buff + 1) += replacement - instr;
-			DPRINTK("Fix CALL offset: 0x%x, CALL 0x%lx",
+			DPRINTK(ALT, "Fix CALL offset: 0x%x, CALL 0x%lx",
 				*(s32 *)(insn_buff + 1),
 				(unsigned long)instr + *(s32 *)(insn_buff + 1) + 5);
 		}
@@ -331,7 +343,7 @@ void __init_or_module noinline apply_alt
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 
@@ -557,15 +569,15 @@ void __init_or_module noinline apply_ret
 			continue;
 		}
 
-		DPRINTK("retpoline at: %pS (%px) len: %d to: %pS",
+		DPRINTK(RETPOLINE, "retpoline at: %pS (%px) len: %d to: %pS",
 			addr, addr, insn.length,
 			addr + insn.length + insn.immediate.value);
 
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(bytes, len);
-			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
-			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
+			DUMP_BYTES(RETPOLINE, ((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(RETPOLINE, ((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
 		}
 	}
@@ -632,14 +644,14 @@ void __init_or_module noinline apply_ret
 			      addr, dest, 5, addr))
 			continue;
 
-		DPRINTK("return thunk at: %pS (%px) len: %d to: %pS",
+		DPRINTK(RET, "return thunk at: %pS (%px) len: %d to: %pS",
 			addr, addr, insn.length,
 			addr + insn.length + insn.immediate.value);
 
 		len = patch_return(addr, &insn, bytes);
 		if (len == insn.length) {
-			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
-			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
+			DUMP_BYTES(RET, ((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(RET, ((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
 		}
 	}
@@ -669,13 +681,13 @@ static void poison_endbr(void *addr, boo
 		return;
 	}
 
-	DPRINTK("ENDBR at: %pS (%px)", addr, addr);
+	DPRINTK(ENDBR, "ENDBR at: %pS (%px)", addr, addr);
 
 	/*
 	 * When we have IBT, the lack of ENDBR will trigger #CP
 	 */
-	DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
-	DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
+	DUMP_BYTES(ENDBR, ((u8*)addr), 4, "%px: orig: ", addr);
+	DUMP_BYTES(ENDBR, ((u8*)&poison), 4, "%px: repl: ", addr);
 	text_poke_early(addr, &poison, 4);
 }
 
@@ -1150,7 +1162,7 @@ void __init_or_module alternatives_smp_m
 	smp->locks_end	= locks_end;
 	smp->text	= text;
 	smp->text_end	= text_end;
-	DPRINTK("locks %p -> %p, text %p -> %p, name %s\n",
+	DPRINTK(SMP, "locks %p -> %p, text %p -> %p, name %s\n",
 		smp->locks, smp->locks_end,
 		smp->text, smp->text_end, smp->name);
 


