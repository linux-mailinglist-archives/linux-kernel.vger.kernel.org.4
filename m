Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3067E61C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjA0NHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjA0NGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:06:39 -0500
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C45567CCB1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:06:32 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-01 (Coremail) with SMTP id qwCowADX3Eg9zNNjDyF3Ag--.52827S13;
        Fri, 27 Jan 2023 21:06:10 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v6 09/13] riscv/kprobe: Search free registers from unused caller-saved ones
Date:   Fri, 27 Jan 2023 21:05:37 +0800
Message-Id: <20230127130541.1250865-10-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADX3Eg9zNNjDyF3Ag--.52827S13
X-Coremail-Antispam: 1UD129KBjvJXoWxtF45Ary3JryUtrWkuryDZFb_yoWfXF15pF
        sxGw4FvrWUtFykCrZrAw1kGr4fKrs8KrW0vFyUtFyayr43X39IvFWvgF1aqr1DKF4jvr4x
        Ar45Cry8urW3AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4U
        JVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
        xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
        6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI
        8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjTmh7UUUUU==
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiBwUEE2PTsCcetQABsY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch further allows optprobe to use caller-saved registers that
is not used across the function being optimized as free registers.

Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Co-developed-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Reported-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/include/asm/kprobes.h       |   1 +
 arch/riscv/kernel/probes/decode-insn.h |  29 +++++++
 arch/riscv/kernel/probes/opt.c         | 116 ++++++++++++++++++++++---
 3 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 75ebd02be171..f7d33f6861c6 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -86,6 +86,7 @@ struct arch_optimized_insn {
 	kprobe_opcode_t *insn;
 	unsigned long length;
 	int rd;
+	u32 free_reg;
 };
 
 #endif /* CONFIG_OPTPROBES */
diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/probes/decode-insn.h
index 785b023a62ea..140f5b6a9886 100644
--- a/arch/riscv/kernel/probes/decode-insn.h
+++ b/arch/riscv/kernel/probes/decode-insn.h
@@ -13,6 +13,35 @@ enum probe_insn {
 	INSN_GOOD,
 };
 
+#define NRREG 32
+#define ALL_REG_OCCUPIED 0xffffffffu
+/*
+ * Register	ABI Name	Saver
+ * x0		zero		--
+ * x1		ra		Caller
+ * x2		sp		Callee
+ * x3		gp		--
+ * x4		tp		--
+ * x5-7 	t0-2		Caller
+ * x8		so/fp		Callee
+ * x9		so/fp		Callee
+ * x10-11	a0-1		Caller
+ * x12-17	a2-7		Caller
+ * x18-27	s2-11		Callee
+ * x28-32	t3-6		Caller
+ *
+ * If register is not caller-saved, it is potentially unsafe to used
+ * as a free register to form AUIPC/JALR, then use one bitmask to filter
+ * out these registers. Because ra is used to record return address for
+ * function call, so mark ra as non-caller-saved register here.
+ * */
+#define NON_CALLER_SAVED_MASK				\
+	(1 <<  0) | (1 <<  1) | (1 <<  2) | (1 <<  3) |	\
+	(1 <<  4) | (1 <<  8) | (1 <<  9) | (1 << 18) |	\
+	(1 << 19) | (1 << 20) | (1 << 21) | (1 << 22) |	\
+	(1 << 23) | (1 << 24) | (1 << 25) | (1 << 26) |	\
+	(1 << 27)
+
 enum probe_insn __kprobes
 riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *asi);
 
diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index c52d5bdc748c..e151b1c60d6d 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -13,6 +13,7 @@
 #include <asm/kprobes.h>
 #include <asm/patch.h>
 #include <asm/asm-offsets.h>
+#include <linux/extable.h>
 
 #include "simulate-insn.h"
 #include "decode-insn.h"
@@ -126,7 +127,7 @@ static void prepare_detour_buffer(kprobe_opcode_t *code, kprobe_opcode_t *slot,
  * as a destination register before any branch or jump instruction.
  */
 static void find_register(unsigned long start, unsigned long end,
-			       unsigned long *write, unsigned long *read)
+			  unsigned long *write, unsigned long *read)
 {
 	kprobe_opcode_t insn;
 	unsigned long addr, offset = 0UL;
@@ -385,18 +386,101 @@ static int search_copied_insn(unsigned long paddr, struct optimized_kprobe *op)
 	return 0;
 }
 
+static void update_free_reg(unsigned long addr, uint32_t *used_reg)
+{
+	kprobe_opcode_t insn = *(kprobe_opcode_t *)addr;
+	unsigned long offset = GET_INSN_LENGTH(insn);
+
+#ifdef CONFIG_RISCV_ISA_C
+	if (offset == RVI_INSN_LEN)
+		goto is_rvi;
+
+	insn &= __COMPRESSED_INSN_MASK;
+	if (riscv_insn_is_c_jal(insn)) {
+		*used_reg |= 1 << 1;
+	} else if (riscv_insn_is_c_jr(insn)) {
+		*used_reg |= 1 << rvc_r_rs1(insn);
+	} else if (riscv_insn_is_c_jalr(insn)) {
+		*used_reg |= 1 << rvc_r_rs1(insn);
+	} else if (riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn)) {
+		*used_reg |= 1 << rvc_b_rs(insn);
+	} else if (riscv_insn_is_c_sub(insn) || riscv_insn_is_c_subw(insn)) {
+		*used_reg |= 1 << rvc_a_rs1(insn);
+		*used_reg |= 1 << rvc_a_rs2(insn);
+	} else if (riscv_insn_is_c_sq(insn) || riscv_insn_is_c_sw(insn) ||
+			   riscv_insn_is_c_sd(insn)) {
+		*used_reg |= 1 << rvc_s_rs1(insn);
+		*used_reg |= 1 << rvc_s_rs2(insn);
+	} else if (riscv_insn_is_c_addi16sp(insn) || riscv_insn_is_c_addi(insn) ||
+			   riscv_insn_is_c_addiw(insn) ||
+			   riscv_insn_is_c_slli(insn)) {
+		*used_reg |= 1 << rvc_i_rs1(insn);
+	} else if (riscv_insn_is_c_sri(insn) ||
+			   riscv_insn_is_c_andi(insn)) {
+		*used_reg |= 1 << rvc_b_rs(insn);
+	} else if (riscv_insn_is_c_sqsp(insn) || riscv_insn_is_c_swsp(insn) ||
+			   riscv_insn_is_c_sdsp(insn)) {
+		*used_reg |= 1 << rvc_ss_rs2(insn);
+		*used_reg |= 1 << 2;
+	} else if (riscv_insn_is_c_mv(insn)) {
+		*used_reg |= 1 << rvc_r_rs2(insn);
+	} else if (riscv_insn_is_c_addi4spn(insn)) {
+		*used_reg |= 1 << 2;
+	} else if (riscv_insn_is_c_lq(insn) || riscv_insn_is_c_lw(insn) ||
+			   riscv_insn_is_c_ld(insn)) {
+		*used_reg |= 1 << rvc_l_rs(insn);
+	} else if (riscv_insn_is_c_lqsp(insn) || riscv_insn_is_c_lwsp(insn) ||
+			   riscv_insn_is_c_ldsp(insn)) {
+		*used_reg |= 1 << 2;
+	}
+	/* li and lui does not have source reg */
+	return;
+is_rvi:
+#endif
+	if (riscv_insn_is_arith_ri(insn) || riscv_insn_is_load(insn)) {
+		*used_reg |= 1 << rvi_rs1(insn);
+	} else if (riscv_insn_is_arith_rr(insn) || riscv_insn_is_store(insn) ||
+		riscv_insn_is_amo(insn)) {
+		*used_reg |= 1 << rvi_rs1(insn);
+		*used_reg |= 1 << rvi_rs2(insn);
+	} else if (riscv_insn_is_branch(insn)) {
+		*used_reg |= 1 << rvi_rs1(insn);
+		*used_reg |= 1 << rvi_rs2(insn);
+	} else if (riscv_insn_is_jalr(insn)) {
+		*used_reg |= 1 << rvi_rs1(insn);
+	}
+}
+
+static bool scan_code(unsigned long *addr, unsigned long paddr,
+		      struct optimized_kprobe *op, uint32_t *used_reg)
+{
+	if (insn_jump_into_range(*addr, paddr + RVC_INSN_LEN,
+				 paddr + op->optinsn.length))
+		return false;
+	if (search_exception_tables(*addr))
+		return false;
+	update_free_reg(*addr, used_reg);
+	*addr += GET_INSN_LENGTH(*(kprobe_opcode_t *)addr);
+	return true;
+}
+
 /*
  * The kprobe based on breakpoint just requires the instrumented instruction
  * supports execute out-of-line or simulation, besides that, optimized kprobe
  * requires no near instruction jump to any instruction replaced by AUIPC/JALR.
  */
-static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
+static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op, uint32_t *used_reg)
 {
 	int ret;
 	struct arch_probe_insn api;
 	unsigned long addr, size = 0, offset = 0;
 	struct kprobe *kp = get_kprobe((kprobe_opcode_t *)paddr);
 
+	/*
+	 * All callee
+	 */
+	*used_reg = NON_CALLER_SAVED_MASK;
+
 	/*
 	 * Skip optimization if kprobe has been disarmed or instrumented
 	 * instruction doest not support XOI.
@@ -426,18 +510,14 @@ static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
 	 */
 	addr = paddr - offset;
 	while (addr < paddr) {
-		if (insn_jump_into_range(addr, paddr + RVC_INSN_LEN,
-					 paddr + op->optinsn.length))
+		if (!scan_code(&addr, paddr, op, used_reg))
 			return false;
-		addr += GET_INSN_LENGTH(*(kprobe_opcode_t *)addr);
 	}
-
-	addr = paddr + op->optinsn.length;
+	update_free_reg((unsigned long)&kp->opcode, used_reg);
+	addr = paddr + GET_INSN_LENGTH(*(kprobe_opcode_t *)&kp->opcode);
 	while (addr < paddr - offset + size) {
-		if (insn_jump_into_range(addr, paddr + RVC_INSN_LEN,
-					 paddr + op->optinsn.length))
+		if (!scan_code(&addr, paddr, op, used_reg))
 			return false;
-		addr += GET_INSN_LENGTH(*(kprobe_opcode_t *)addr);
 	}
 
 	return true;
@@ -466,10 +546,13 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 {
 	long rel;
 	int rd = 0, ra = 0, ret;
+	u32 used_reg;
 	kprobe_opcode_t *code = NULL, *slot = NULL;
 
-	if (!can_optimize((unsigned long)orig->addr, op))
+	if (!can_optimize((unsigned long)orig->addr, op, &used_reg)) {
+		op->optinsn.rd = -1;
 		return -EILSEQ;
+	}
 
 	code = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
 	slot = get_optinsn_slot();
@@ -490,7 +573,14 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	 * to detour buffer, ra is used to form JR jumping back from detour
 	 * buffer.
 	 */
-	find_free_registers(orig, op, &rd, &ra);
+	if (used_reg == ALL_REG_OCCUPIED) {
+		find_free_registers(orig, op, &rd, &ra);
+	} else {
+		/* Choose one unused caller-saved register. */
+		rd = ffz(used_reg);
+		ra = rd;
+	}
+
 	if (rd == 0 || ra == 0) {
 		ret = -EILSEQ;
 		goto on_error;
@@ -534,6 +624,8 @@ void arch_optimize_kprobes(struct list_head *oplist)
 	list_for_each_entry_safe(op, tmp, oplist, list) {
 		WARN_ON(kprobe_disabled(&op->kp));
 
+		if (op->optinsn.rd < 0)
+			continue;
 		/* Backup instructions which will be replaced by jump address */
 		memcpy(op->optinsn.copied_insn,
 		       DETOUR_ADDR(op->optinsn.insn, DETOUR_INSN_OFFSET),
-- 
2.34.1

