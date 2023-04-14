Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3316E1F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDNJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:33:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C96DC4EFB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:33:08 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxlF3THTlklmIcAA--.43825S3;
        Fri, 14 Apr 2023 17:33:07 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxjb7SHTlkpYkkAA--.885S3;
        Fri, 14 Apr 2023 17:33:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 1/4] LoongArch: Move three functions from kprobes.c to inst.c
Date:   Fri, 14 Apr 2023 17:32:58 +0800
Message-Id: <1681464781-4428-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1681464781-4428-1-git-send-email-yangtiezhu@loongson.cn>
References: <1681464781-4428-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Dxjb7SHTlkpYkkAA--.885S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFW8Wr17tFy3uw4fAw48Xrb_yoWrtFWrpF
        sruw1fJr48WFn3XryDJw4Yvr1Fkrsa93sFqF17JayfKr12qr15tF1kKrZYvF98K39Fkr4I
        qF1Yyry5W3WfAaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
        07jFE__UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions insns_not_supported(), insns_need_simulation()
and arch_simulate_insn() will be used for uprobes, move them
from kprobes.c to inst.c, this is preparation for later patch,
no functionality change.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h |  4 ++++
 arch/loongarch/kernel/inst.c      | 39 +++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/kprobes.c   | 46 ++-------------------------------------
 3 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index a04fe75..9ea485b 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -409,6 +409,10 @@ static inline bool is_self_loop_ins(union loongarch_instruction *ip, struct pt_r
 void simu_pc(struct pt_regs *regs, union loongarch_instruction insn);
 void simu_branch(struct pt_regs *regs, union loongarch_instruction insn);
 
+bool insns_not_supported(union loongarch_instruction insn);
+bool insns_need_simulation(union loongarch_instruction insn);
+void arch_simulate_insn(union loongarch_instruction insn, struct pt_regs *regs);
+
 int larch_insn_read(void *addr, u32 *insnp);
 int larch_insn_write(void *addr, u32 insn);
 int larch_insn_patch_text(void *addr, u32 insn);
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 258ef26..95219e0 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -133,6 +133,45 @@ void simu_branch(struct pt_regs *regs, union loongarch_instruction insn)
 	}
 }
 
+bool insns_not_supported(union loongarch_instruction insn)
+{
+	switch (insn.reg2i14_format.opcode) {
+	case llw_op:
+	case lld_op:
+	case scw_op:
+	case scd_op:
+		pr_notice("kprobe: ll and sc instructions are not supported\n");
+		return true;
+	}
+
+	switch (insn.reg1i21_format.opcode) {
+	case bceqz_op:
+		pr_notice("kprobe: bceqz and bcnez instructions are not supported\n");
+		return true;
+	}
+
+	return false;
+}
+
+bool insns_need_simulation(union loongarch_instruction insn)
+{
+	if (is_pc_ins(&insn))
+		return true;
+
+	if (is_branch_ins(&insn))
+		return true;
+
+	return false;
+}
+
+void arch_simulate_insn(union loongarch_instruction insn, struct pt_regs *regs)
+{
+	if (is_pc_ins(&insn))
+		simu_pc(regs, insn);
+	else if (is_branch_ins(&insn))
+		simu_branch(regs, insn);
+}
+
 int larch_insn_read(void *addr, u32 *insnp)
 {
 	int ret;
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
index 56c8c4b..08c78d2 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -21,48 +21,6 @@ static const union loongarch_instruction singlestep_insn = {
 DEFINE_PER_CPU(struct kprobe *, current_kprobe);
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
-static bool insns_not_supported(union loongarch_instruction insn)
-{
-	switch (insn.reg2i14_format.opcode) {
-	case llw_op:
-	case lld_op:
-	case scw_op:
-	case scd_op:
-		pr_notice("kprobe: ll and sc instructions are not supported\n");
-		return true;
-	}
-
-	switch (insn.reg1i21_format.opcode) {
-	case bceqz_op:
-		pr_notice("kprobe: bceqz and bcnez instructions are not supported\n");
-		return true;
-	}
-
-	return false;
-}
-NOKPROBE_SYMBOL(insns_not_supported);
-
-static bool insns_need_simulation(struct kprobe *p)
-{
-	if (is_pc_ins(&p->opcode))
-		return true;
-
-	if (is_branch_ins(&p->opcode))
-		return true;
-
-	return false;
-}
-NOKPROBE_SYMBOL(insns_need_simulation);
-
-static void arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
-{
-	if (is_pc_ins(&p->opcode))
-		simu_pc(regs, p->opcode);
-	else if (is_branch_ins(&p->opcode))
-		simu_branch(regs, p->opcode);
-}
-NOKPROBE_SYMBOL(arch_simulate_insn);
-
 static void arch_prepare_ss_slot(struct kprobe *p)
 {
 	p->ainsn.insn[0] = *p->addr;
@@ -89,7 +47,7 @@ int arch_prepare_kprobe(struct kprobe *p)
 	if (insns_not_supported(p->opcode))
 		return -EINVAL;
 
-	if (insns_need_simulation(p)) {
+	if (insns_need_simulation(p->opcode)) {
 		p->ainsn.insn = NULL;
 	} else {
 		p->ainsn.insn = get_insn_slot();
@@ -220,7 +178,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		regs->csr_era = (unsigned long)p->ainsn.insn;
 	} else {
 		/* simulate single steping */
-		arch_simulate_insn(p, regs);
+		arch_simulate_insn(p->opcode, regs);
 		/* now go for post processing */
 		post_kprobe_handler(p, kcb, regs);
 	}
-- 
2.1.0

