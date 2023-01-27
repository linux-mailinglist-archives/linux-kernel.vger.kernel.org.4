Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DD867E618
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjA0NGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjA0NGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:06:32 -0500
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C789C7D986
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:06:29 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-01 (Coremail) with SMTP id qwCowADX3Eg9zNNjDyF3Ag--.52827S12;
        Fri, 27 Jan 2023 21:06:10 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v6 08/13] riscv/kprobe: Patch AUIPC/JALR pair to optimize kprobe
Date:   Fri, 27 Jan 2023 21:05:36 +0800
Message-Id: <20230127130541.1250865-9-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADX3Eg9zNNjDyF3Ag--.52827S12
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1fZF4kXFyfGFWfur1fCrg_yoW7ZFWxpF
        s8C3ZxJrWYkFn2grZxAws5ur1rKwsYvay3K34DGFWfCrsrJrs8Wwn7Kwn8Zr15GF1Fgr13
        ArnYkryruay7JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
        6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjTmh7UUUUU==
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiBwUEE2PTsCcetQAAsZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

There is race when replacing EBREAK with AUIPC/JALR pairs under SMP,
so it needs to patch multiple instructions safely, this patch enhances
patch_text_cb() to ensure no race occurs when patching AUIPC/JALR pairs.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/patch.c      | 23 +++++++++---
 arch/riscv/kernel/probes/opt.c | 65 ++++++++++++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 6 deletions(-)

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
index 765004b60513..ce324b6a6998 100644
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
index a47f7d2bf3a6..c52d5bdc748c 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt)	"optprobe: " fmt
 
+#include <linux/types.h>
 #include <linux/kprobes.h>
 #include <asm/kprobes.h>
 #include <asm/patch.h>
@@ -444,11 +445,19 @@ static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
 
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
 
@@ -509,23 +518,75 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 
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
+		       DETOUR_ADDR(op->optinsn.insn, DETOUR_INSN_OFFSET),
+		       op->optinsn.length);
+
+		/*
+		 * After patching, it should be:
+		 * auipc free_register, %hi(detour_buffer)
+		 * jalr free_register, free_register, %lo(detour_buffer)
+		 * where free_register will eventually save the return address
+		 */
+		offs = (unsigned long)op->optinsn.insn -
+		       (unsigned long)op->kp.addr;
+		insn[0] = rv_auipc(op->optinsn.rd, (offs + (1 << 11)) >> 12);
+		insn[1] = rv_jalr(op->optinsn.rd, op->optinsn.rd, offs & 0xFFF);
+		/* For 3 RVC + 1 RVI scenario, fill C.NOP for padding */
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
+
+	memcpy(buf, op->optinsn.copied_insn, op->optinsn.length);
+	if (GET_INSN_LENGTH(op->kp.opcode) == RVI_INSN_LEN)
+		*(u32 *)buf = __BUG_INSN_32;
+	else
+		*(u16 *)buf = __BUG_INSN_16;
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
2.34.1

