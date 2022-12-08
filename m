Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F16469CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLHHlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:41:28 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 016A546674
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 23:41:26 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxOekllZFjkg0EAA--.6239S3;
        Thu, 08 Dec 2022 15:41:25 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuAjlZFjn8gnAA--.32821S3;
        Thu, 08 Dec 2022 15:41:24 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/4] LoongArch: Simulate branch and PC instructions
Date:   Thu,  8 Dec 2022 15:41:10 +0800
Message-Id: <1670485273-15717-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1670485273-15717-1-git-send-email-yangtiezhu@loongson.cn>
References: <1670485273-15717-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxPuAjlZFjn8gnAA--.32821S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WrWkAF4kWFyxWF1kXF1UWrg_yoWxGr1Upr
        W29r4kCr4DWr93CrWjqr1kXr15tr4fur43uwnxCw13CFy7uFy5GrykWr4jvFyYkw4Utry0
        gayftw429F4SyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8w0eJUUUUU==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 arch/loongarch/include/asm/inst.h   |  12 ++++
 arch/loongarch/include/asm/ptrace.h |   1 +
 arch/loongarch/kernel/inst.c        | 123 ++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 6cd994d..a91798b 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <asm/asm.h>
+#include <asm/ptrace.h>
 
 #define INSN_NOP		0x03400000
 #define INSN_BREAK		0x002a0000
@@ -32,6 +33,7 @@ enum reg1i20_op {
 	lu12iw_op	= 0x0a,
 	lu32id_op	= 0x0b,
 	pcaddi_op	= 0x0c,
+	pcalau12i_op	= 0x0d,
 	pcaddu12i_op	= 0x0e,
 	pcaddu18i_op	= 0x0f,
 };
@@ -366,6 +368,16 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
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
index 59c4608..58596c4 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -6,6 +6,7 @@
 #define _ASM_PTRACE_H
 
 #include <asm/page.h>
+#include <asm/irqflags.h>
 #include <asm/thread_info.h>
 #include <uapi/asm/ptrace.h>
 
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 512579d..aaaf9de 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -165,3 +165,126 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
 
 	return insn.word;
 }
+
+void simu_branch(struct pt_regs *regs, union loongarch_instruction insn)
+{
+	unsigned int imm, imm_l, imm_h, rd, rj;
+	unsigned long pc = regs->csr_era;
+
+	if (pc & 3) {
+		pr_warn("%s: invalid pc 0x%lx\n", __func__, pc);
+		return;
+	}
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
+	if (pc & 3) {
+		pr_warn("%s: invalid pc 0x%lx\n", __func__, pc);
+		return;
+	}
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

