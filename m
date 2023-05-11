Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065DF6FED81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbjEKIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjEKIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:06:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 004A0A5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:06:21 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Ax2en9oVxkRK0HAA--.13157S3;
        Thu, 11 May 2023 16:06:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxqjr5oVxk7XNVAA--.21787S5;
        Thu, 11 May 2023 16:06:20 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v4 3/6] LoongArch: Use larch_insn_gen_break() for kprobes
Date:   Thu, 11 May 2023 16:06:09 +0800
Message-Id: <1683792372-29338-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1683792372-29338-1-git-send-email-yangtiezhu@loongson.cn>
References: <1683792372-29338-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Cxqjr5oVxk7XNVAA--.21787S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFW5AF15ZF13Cw47Zr1UKFg_yoWrXFWUpF
        nrCwnaqr4rJan5Cr9rJw4UZr1Syw48u3yqqFWUC3ySyr17Xwn8JF1xKrZ0yF98K3yvkFWS
        qwnxtrW8Za4xAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjxU4miiDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, we can use larch_insn_gen_break() to define KPROBE_BP_INSN and
KPROBE_SSTEPBP_INSN. Because larch_insn_gen_break() returns instruction
word, define kprobe_opcode_t as u32, then do some small changes related
with type conversion, no functional change intended.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/kprobes.h |  2 +-
 arch/loongarch/kernel/kprobes.c      | 33 ++++++++++++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
index 798020a..7ef7a0f 100644
--- a/arch/loongarch/include/asm/kprobes.h
+++ b/arch/loongarch/include/asm/kprobes.h
@@ -22,7 +22,7 @@ do {									\
 
 #define kretprobe_blacklist_size	0
 
-typedef union loongarch_instruction kprobe_opcode_t;
+typedef u32 kprobe_opcode_t;
 
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
index 08c78d2..1835102 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -4,19 +4,8 @@
 #include <linux/preempt.h>
 #include <asm/break.h>
 
-static const union loongarch_instruction breakpoint_insn = {
-	.reg0i15_format = {
-		.opcode = break_op,
-		.immediate = BRK_KPROBE_BP,
-	}
-};
-
-static const union loongarch_instruction singlestep_insn = {
-	.reg0i15_format = {
-		.opcode = break_op,
-		.immediate = BRK_KPROBE_SSTEPBP,
-	}
-};
+#define KPROBE_BP_INSN		larch_insn_gen_break(BRK_KPROBE_BP)
+#define KPROBE_SSTEPBP_INSN	larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe);
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -24,7 +13,7 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void arch_prepare_ss_slot(struct kprobe *p)
 {
 	p->ainsn.insn[0] = *p->addr;
-	p->ainsn.insn[1] = singlestep_insn;
+	p->ainsn.insn[1] = KPROBE_SSTEPBP_INSN;
 	p->ainsn.restore = (unsigned long)p->addr + LOONGARCH_INSN_SIZE;
 }
 NOKPROBE_SYMBOL(arch_prepare_ss_slot);
@@ -37,17 +26,20 @@ NOKPROBE_SYMBOL(arch_prepare_simulate);
 
 int arch_prepare_kprobe(struct kprobe *p)
 {
+	union loongarch_instruction insn;
+
 	if ((unsigned long)p->addr & 0x3)
 		return -EILSEQ;
 
 	/* copy instruction */
 	p->opcode = *p->addr;
+	insn.word = p->opcode;
 
 	/* decode instruction */
-	if (insns_not_supported(p->opcode))
+	if (insns_not_supported(insn))
 		return -EINVAL;
 
-	if (insns_need_simulation(p->opcode)) {
+	if (insns_need_simulation(insn)) {
 		p->ainsn.insn = NULL;
 	} else {
 		p->ainsn.insn = get_insn_slot();
@@ -68,7 +60,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
 /* Install breakpoint in text */
 void arch_arm_kprobe(struct kprobe *p)
 {
-	*p->addr = breakpoint_insn;
+	*p->addr = KPROBE_BP_INSN;
 	flush_insn_slot(p);
 }
 NOKPROBE_SYMBOL(arch_arm_kprobe);
@@ -163,6 +155,8 @@ NOKPROBE_SYMBOL(post_kprobe_handler);
 static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 			     struct kprobe_ctlblk *kcb, int reenter)
 {
+	union loongarch_instruction insn;
+
 	if (reenter) {
 		save_previous_kprobe(kcb);
 		set_current_kprobe(p);
@@ -178,7 +172,8 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		regs->csr_era = (unsigned long)p->ainsn.insn;
 	} else {
 		/* simulate single steping */
-		arch_simulate_insn(p->opcode, regs);
+		insn.word = p->opcode;
+		arch_simulate_insn(insn, regs);
 		/* now go for post processing */
 		post_kprobe_handler(p, kcb, regs);
 	}
@@ -253,7 +248,7 @@ bool kprobe_breakpoint_handler(struct pt_regs *regs)
 		}
 	}
 
-	if (addr->word != breakpoint_insn.word) {
+	if (*addr != KPROBE_BP_INSN) {
 		/*
 		 * The breakpoint instruction was removed right
 		 * after we hit it.  Another cpu has removed
-- 
2.1.0

