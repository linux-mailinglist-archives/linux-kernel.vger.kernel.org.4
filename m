Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE50721E45
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjFEGj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjFEGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:39:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E560EA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:39:14 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxHvARg31k+wUAAA--.14S3;
        Mon, 05 Jun 2023 14:39:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axa9YPg31kHQcAAA--.72S5;
        Mon, 05 Jun 2023 14:39:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 3/6] LoongArch: Use larch_insn_gen_break() for kprobes
Date:   Mon,  5 Jun 2023 14:39:07 +0800
Message-Id: <1685947150-4949-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn>
References: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Axa9YPg31kHQcAAA--.72S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCrWUAF47tw15Wr1fZFW5Jwc_yoWrWr4fpF
        nrCwnaqF4rJFs5Cr9rJw4UZr1Syw48u3yqqFWUC3ySyr17Xwn8JF1xKrZ0yF98K3yvkFWS
        qwnxtrWIva4xAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
        6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8EeHDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
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
Tested-by: Jeff Xie <xiehuan09@gmail.com>
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

