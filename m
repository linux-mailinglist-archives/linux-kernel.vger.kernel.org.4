Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBFB5ED238
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiI1Aug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiI1AuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:50:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77BD512385B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 17:50:13 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmtBmjNjVwIjAA--.53900S3;
        Wed, 28 Sep 2022 08:50:10 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] LoongArch: Simulate branch and PC instructions
Date:   Wed, 28 Sep 2022 08:50:05 +0800
Message-Id: <1664326209-13995-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxvmtBmjNjVwIjAA--.53900S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWkAF4fWF1ftr18CF43Awb_yoWxWr4kpr
        Wa9r4kCr4DWr93CrWjqw1kZr15tr4fur43u3ZrCw13CFy7Cry5KrykGr4jvFyqkw48tFy0
        gayftw47uF4SyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_twCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bFeOJUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to LoongArch Reference Manual, simulate branch and
PC instructions, this is preparation for later patch.

Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#branch-instructions
Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_pcaddi_pcaddu121_pcaddu18l_pcalau12i

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h   |  19 ++++++
 arch/loongarch/include/asm/ptrace.h |   1 +
 arch/loongarch/kernel/inst.c        | 113 ++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index fce1843..93d5cd4 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <asm/asm.h>
+#include <asm/ptrace.h>
 
 #define INSN_BREAK		0x002a0000
 
@@ -28,6 +29,8 @@ enum reg0i26_op {
 enum reg1i20_op {
 	lu12iw_op	= 0x0a,
 	lu32id_op	= 0x0b,
+	pcaddi_op	= 0x0c,
+	pcalau12i_op	= 0x0d,
 	pcaddu12i_op	= 0x0e,
 	pcaddu18i_op	= 0x0f,
 };
@@ -313,6 +316,12 @@ static inline bool is_branch_ins(union loongarch_instruction *ip)
 		ip->reg1i21_format.opcode <= bgeu_op;
 }
 
+static inline bool is_pc_ins(union loongarch_instruction *ip)
+{
+	return ip->reg1i20_format.opcode >= pcaddi_op &&
+		ip->reg1i20_format.opcode <= pcaddu18i_op;
+}
+
 static inline bool is_ra_save_ins(union loongarch_instruction *ip)
 {
 	/* st.d $ra, $sp, offset */
@@ -334,6 +343,16 @@ static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
+void simu_branch(struct pt_regs *regs, union loongarch_instruction insn);
+void simu_pc(struct pt_regs *regs, union loongarch_instruction insn);
+
+static inline unsigned long sign_extended(unsigned long val, unsigned int idx)
+{
+	if (val & (1UL << idx))
+		return ~((1UL << (idx + 1)) - 1) | val;
+	else
+		return ((1UL << (idx + 1)) - 1) & val;
+}
 
 static inline bool signed_imm_check(long val, unsigned int bit)
 {
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 17838c6..eb9538a 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -6,6 +6,7 @@
 #define _ASM_PTRACE_H
 
 #include <asm/page.h>
+#include <asm/irqflags.h>
 #include <asm/thread_info.h>
 #include <uapi/asm/ptrace.h>
 
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index b1df0ec..f5c1eff6 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -38,3 +38,116 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
 
 	return insn.word;
 }
+
+void simu_branch(struct pt_regs *regs, union loongarch_instruction insn)
+{
+	unsigned int imm, imm_l, imm_h, rd, rj;
+	unsigned long pc = regs->csr_era;
+
+	imm_l = insn.reg0i26_format.immediate_l;
+	imm_h = insn.reg0i26_format.immediate_h;
+	switch (insn.reg0i26_format.opcode) {
+	case b_op:
+		regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 27);
+		return;
+	case bl_op:
+		regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 27);
+		regs->regs[1] = pc + LOONGARCH_INSN_SIZE;
+		return;
+	}
+
+	imm_l = insn.reg1i21_format.immediate_l;
+	imm_h = insn.reg1i21_format.immediate_h;
+	rj = insn.reg1i21_format.rj;
+	switch (insn.reg1i21_format.opcode) {
+	case beqz_op:
+		if (regs->regs[rj] == 0)
+			regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 22);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		return;
+	case bnez_op:
+		if (regs->regs[rj] != 0)
+			regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 22);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		return;
+	}
+
+	imm = insn.reg2i16_format.immediate;
+	rj = insn.reg2i16_format.rj;
+	rd = insn.reg2i16_format.rd;
+	switch (insn.reg2i16_format.opcode) {
+	case beq_op:
+		if (regs->regs[rj] == regs->regs[rd])
+			regs->csr_era = pc + sign_extended(imm << 2, 17);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		break;
+	case bne_op:
+		if (regs->regs[rj] != regs->regs[rd])
+			regs->csr_era = pc + sign_extended(imm << 2, 17);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		break;
+	case blt_op:
+		if ((long)regs->regs[rj] < (long)regs->regs[rd])
+			regs->csr_era = pc + sign_extended(imm << 2, 17);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		break;
+	case bge_op:
+		if ((long)regs->regs[rj] >= (long)regs->regs[rd])
+			regs->csr_era = pc + sign_extended(imm << 2, 17);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		break;
+	case bltu_op:
+		if (regs->regs[rj] < regs->regs[rd])
+			regs->csr_era = pc + sign_extended(imm << 2, 17);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		break;
+	case bgeu_op:
+		if (regs->regs[rj] >= regs->regs[rd])
+			regs->csr_era = pc + sign_extended(imm << 2, 17);
+		else
+			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
+		break;
+	case jirl_op:
+		regs->csr_era = regs->regs[rj] + sign_extended(imm << 2, 17);
+		regs->regs[rd] = pc + LOONGARCH_INSN_SIZE;
+		break;
+	default:
+		pr_info("%s: unknown opcode\n", __func__);
+		return;
+	}
+}
+
+void simu_pc(struct pt_regs *regs, union loongarch_instruction insn)
+{
+	unsigned long pc = regs->csr_era;
+	unsigned int rd = insn.reg1i20_format.rd;
+	unsigned int imm = insn.reg1i20_format.immediate;
+
+	switch (insn.reg1i20_format.opcode) {
+	case pcaddi_op:
+		regs->regs[rd] = pc + sign_extended(imm << 2, 21);
+		break;
+	case pcaddu12i_op:
+		regs->regs[rd] = pc + sign_extended(imm << 12, 31);
+		break;
+	case pcaddu18i_op:
+		regs->regs[rd] = pc + sign_extended(imm << 18, 37);
+		break;
+	case pcalau12i_op:
+		regs->regs[rd] = pc + sign_extended(imm << 12, 31);
+		regs->regs[rd] &= ~((1 << 12) - 1);
+		break;
+	default:
+		pr_info("%s: unknown opcode\n", __func__);
+		return;
+	}
+
+	regs->csr_era += LOONGARCH_INSN_SIZE;
+}
-- 
2.1.0

