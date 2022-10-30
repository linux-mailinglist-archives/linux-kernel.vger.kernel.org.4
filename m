Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F132612959
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJ3JVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJ3JVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:21:40 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C96EBC84
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:21:36 -0700 (PDT)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-03 (Coremail) with SMTP id rQCowABXCVmKPV5jkxYmBw--.33365S12;
        Sun, 30 Oct 2022 17:02:18 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH 8/8] riscv/kprobe: Patch AUIPC/JALR pair to optimize kprobe
Date:   Sun, 30 Oct 2022 17:01:41 +0800
Message-Id: <20221030090141.2550837-9-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
References: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXCVmKPV5jkxYmBw--.33365S12
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1fZF4kXFyfGFWfur1fCrg_yoW7CryrpF
        s8G3ZxJrWYkFn2grZxAws5ur1rKwsYyay3K34DGrWfAr47Jrs8Wwnakwn8ZF15GF1Fgr13
        ArnYkryruay7JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
        3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
        8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUzv3nUUUUU=
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiAwcPE2NeFqsxqwAAsC
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

The patch optimizes 'EBREAK' with 'AUIPC/JALR', introduce new patching
function to modify multiple instructions.

Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/patch.c      | 22 +++++++++---
 arch/riscv/kernel/probes/opt.c | 63 ++++++++++++++++++++++++++++++++--
 3 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index 9a7d7346001e..ee31539de65f 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -8,5 +8,6 @@
 
 int patch_text_nosync(void *addr, const void *insns, size_t len);
 int patch_text(void *addr, u32 insn);
+int patch_text_batch(void *addr, const void *insn, size_t size);
 
 #endif /* _ASM_RISCV_PATCH_H */
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 765004b60513..02c43bb1fad3 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -15,7 +15,8 @@
 
 struct patch_insn {
 	void *addr;
-	u32 insn;
+	const void *insn;
+	size_t size;
 	atomic_t cpu_count;
 };
 
@@ -106,8 +107,7 @@ static int patch_text_cb(void *data)
 
 	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
 		ret =
-		    patch_text_nosync(patch->addr, &patch->insn,
-					    GET_INSN_LENGTH(patch->insn));
+		    patch_text_nosync(patch->addr, patch->insn, patch->size);
 		atomic_inc(&patch->cpu_count);
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
@@ -123,7 +123,8 @@ int patch_text(void *addr, u32 insn)
 {
 	struct patch_insn patch = {
 		.addr = addr,
-		.insn = insn,
+		.insn = &insn,
+		.size = GET_INSN_LENGTH(insn),
 		.cpu_count = ATOMIC_INIT(0),
 	};
 
@@ -131,3 +132,17 @@ int patch_text(void *addr, u32 insn)
 				       &patch, cpu_online_mask);
 }
 NOKPROBE_SYMBOL(patch_text);
+
+int patch_text_batch(void *addr, const void *insn, size_t size)
+{
+	struct patch_insn patch = {
+		.addr = addr,
+		.insn = insn,
+		.size = size,
+		.cpu_count = ATOMIC_INIT(0),
+	};
+
+	return stop_machine_cpuslocked(patch_text_cb, &patch, cpu_online_mask);
+}
+
+NOKPROBE_SYMBOL(patch_text_batch);
diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index 77248ed7d4e8..947bc015da7e 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -448,11 +448,19 @@ static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
 
 int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
 {
-	return 0;
+	return optinsn->length;
 }
 
 int arch_check_optimized_kprobe(struct optimized_kprobe *op)
 {
+	unsigned long i;
+	struct kprobe *p;
+
+	for (i = RVC_INSN_LEN; i < op->optinsn.length; i += RVC_INSN_LEN) {
+		p = get_kprobe(op->kp.addr + i);
+		if (p && !kprobe_disabled(p))
+			return -EEXIST;
+	}
 	return 0;
 }
 
@@ -521,23 +529,74 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 
 void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
 {
+	if (op->optinsn.insn) {
+		free_optinsn_slot(op->optinsn.insn, 1);
+		op->optinsn.insn = NULL;
+		op->optinsn.length = 0;
+	}
 }
 
 void arch_optimize_kprobes(struct list_head *oplist)
 {
+	long offs;
+	kprobe_opcode_t insn[3];
+	struct optimized_kprobe *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		WARN_ON(kprobe_disabled(&op->kp));
+
+		/* Backup instructions which will be replaced by jump address */
+		memcpy(op->optinsn.copied_insn,
+		       DETOUR_ADDR(op->kp.addr, GET_INSN_LENGTH(op->kp.opcode)),
+		       op->optinsn.length - GET_INSN_LENGTH(op->kp.opcode));
+
+		/*
+		 * After patch, it should be:
+		 * auipc free_register, %hi(detour_buffer)
+		 * jalr free_register, free_register, %lo(detour_buffer)
+		 * where free_register will eventually save the return address
+		 */
+		offs = (unsigned long)op->optinsn.insn -
+		       (unsigned long)op->kp.addr;
+		insn[0] = rv_auipc(op->optinsn.rd, (offs + (1 << 11)) >> 12);
+		insn[1] = rv_jalr(op->optinsn.rd, op->optinsn.rd, offs & 0xFFF);
+		/* For 3 RVC + 1 RVI scenario, need C.NOP for padding */
+		if (op->optinsn.length > 2 * RVI_INSN_LEN)
+			insn[2] = rvc_addi(0, 0);
+
+		patch_text_batch(op->kp.addr, insn, op->optinsn.length);
+		if (memcmp(op->kp.addr, insn, op->optinsn.length))
+			continue;
+
+		list_del_init(&op->list);
+	}
 }
 
 void arch_unoptimize_kprobes(struct list_head *oplist,
 			     struct list_head *done_list)
 {
+	struct optimized_kprobe *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		arch_unoptimize_kprobe(op);
+		list_move(&op->list, done_list);
+	}
 }
 
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
+	kprobe_opcode_t buf[MAX_COPIED_INSN];
+	unsigned long offset = GET_INSN_LENGTH(op->kp.opcode);
+
+	buf[0] = (offset == RVI_INSN_LEN) ? __BUG_INSN_32 : __BUG_INSN_16;
+	memcpy(DETOUR_ADDR(buf, offset), op->optinsn.copied_insn,
+	       op->optinsn.length - offset);
+	patch_text_batch(op->kp.addr, buf, op->optinsn.length);
 }
 
 int arch_within_optimized_kprobe(struct optimized_kprobe *op,
 				 kprobe_opcode_t *addr)
 {
-	return 0;
+	return (op->kp.addr <= addr &&
+		op->kp.addr + op->optinsn.length > addr);
 }
-- 
2.25.1

