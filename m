Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59C57016D1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbjEMNEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjEMNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:03:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1030CF;
        Sat, 13 May 2023 06:03:53 -0700 (PDT)
Date:   Sat, 13 May 2023 13:03:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683983029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5dJPBsNrr5XOWVdwnxpoa99HCe2QRL4JM2sWsU8N9I=;
        b=pFSnnRuU6WCpHxx2H9nlwOOnjIstRnelLhtArjb/GP79tvxz5b/y9XVTPCQZEBOLFb168k
        /bLVzX2L2/MesRQ6+J5xUzzDu3wVpNblSKANAJqC5WUAGsrATBWEosHI6nVSKilAkmQq4r
        Hui06ILtoI/ZSJ8gCtYlZXP82zEQjVquqjKeg13HK+otw7ROCDjmzrpLGklIA+59l4HRlt
        kJ7YxWyeeeb4RLq5rRDTdnmHM0xNqmlaGtDZaCUsUQNTDCNsgQfJLQ4i4XtYMpuV6LJiUZ
        RsLRM1oCpl0iUa85scuyvVFdNw5Yac4lWO4PbubK8+1r+sZaIsaZfMcMdkqOXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683983029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5dJPBsNrr5XOWVdwnxpoa99HCe2QRL4JM2sWsU8N9I=;
        b=PqcCvh1sWrhL+9rtSxNRXc8A1bCyu7Rd7bLUthdr08xHWQYiN/Fp+EN79jLNI5rbP+jpq1
        AA1EX6YuOgH/tDDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Make debug-alternative selective
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230208171431.253636689@infradead.org>
References: <20230208171431.253636689@infradead.org>
MIME-Version: 1.0
Message-ID: <168398302931.404.9861689627338980159.tip-bot2@tip-bot2>
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

Commit-ID:     6becb5026b8192e0ed6619d6e7793c2f1288244f
Gitweb:        https://git.kernel.org/tip/6becb5026b8192e0ed6619d6e7793c2f1288244f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:10:51 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 10 May 2023 13:48:46 +02:00

x86/alternative: Make debug-alternative selective

Using debug-alternative generates a *LOT* of output, extend it a bit
to select which of the many rewrites it reports on.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230208171431.253636689@infradead.org
---
 arch/x86/kernel/alternative.c | 62 ++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0c..b3ae6cf 100644
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
@@ -55,15 +67,15 @@ static int __init setup_noreplace_smp(char *str)
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
@@ -148,7 +160,7 @@ recompute_jump(struct alt_instr *a, u8 *orig_insn, u8 *repl_insn, u8 *insn_buff)
 	tgt_rip  = next_rip + o_dspl;
 	n_dspl = tgt_rip - orig_insn;
 
-	DPRINTK("target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
+	DPRINTK(ALT, "target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
 
 	if (tgt_rip - orig_insn >= 0) {
 		if (n_dspl - 2 <= 127)
@@ -183,7 +195,7 @@ five_byte_jmp:
 
 done:
 
-	DPRINTK("final displ: 0x%08x, JMP 0x%lx",
+	DPRINTK(ALT, "final displ: 0x%08x, JMP 0x%lx",
 		n_dspl, (unsigned long)orig_insn + n_dspl + repl_len);
 }
 
@@ -217,7 +229,7 @@ static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
 	add_nops(instr + off, nnops);
 	local_irq_restore(flags);
 
-	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
+	DUMP_BYTES(ALT, instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
 
 	return nnops;
 }
@@ -270,7 +282,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
 
-	DPRINTK("alt table %px, -> %px", start, end);
+	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -297,15 +309,15 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT))
 			goto next;
 
-		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
+		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
 			(a->flags & ALT_FLAG_NOT) ? "!" : "",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
+		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
@@ -318,7 +330,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 */
 		if (a->replacementlen == 5 && *insn_buff == 0xe8) {
 			*(s32 *)(insn_buff + 1) += replacement - instr;
-			DPRINTK("Fix CALL offset: 0x%x, CALL 0x%lx",
+			DPRINTK(ALT, "Fix CALL offset: 0x%x, CALL 0x%lx",
 				*(s32 *)(insn_buff + 1),
 				(unsigned long)instr + *(s32 *)(insn_buff + 1) + 5);
 		}
@@ -329,7 +341,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 
@@ -555,15 +567,15 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
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
@@ -630,14 +642,14 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
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
@@ -667,13 +679,13 @@ static void poison_endbr(void *addr, bool warn)
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
 
@@ -1148,7 +1160,7 @@ void __init_or_module alternatives_smp_module_add(struct module *mod,
 	smp->locks_end	= locks_end;
 	smp->text	= text;
 	smp->text_end	= text_end;
-	DPRINTK("locks %p -> %p, text %p -> %p, name %s\n",
+	DPRINTK(SMP, "locks %p -> %p, text %p -> %p, name %s\n",
 		smp->locks, smp->locks_end,
 		smp->text, smp->text_end, smp->name);
 
