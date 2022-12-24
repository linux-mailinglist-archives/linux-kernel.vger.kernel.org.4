Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91D655A06
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 12:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiLXLoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 06:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiLXLnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 06:43:50 -0500
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F30E0A44F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:43:48 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-03 (Coremail) with SMTP id rQCowABXXpbf5aZj9dVkCA--.18955S13;
        Sat, 24 Dec 2022 19:43:29 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v5 9/9] riscv/kprobe: Search free registers from unused caller-saved ones
Date:   Sat, 24 Dec 2022 19:43:15 +0800
Message-Id: <20221224114315.850130-10-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXXpbf5aZj9dVkCA--.18955S13
X-Coremail-Antispam: 1UD129KBjvJXoWxtF48Kw45tr17Kr4UGr1xZrb_yoW3uw1xpF
        sxGw4FvrWUJa4kurZrAw1kGr4fKrs8Kr40vFyUtFWSqr4aq39Ivayv93W3Xr1DtF40vr4x
        ArW5Cry8urW3AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
        6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSApnUUUUU=
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiAwgKE2OmnOhnMQAAs1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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
 arch/riscv/kernel/probes/decode-insn.h |   5 +
 arch/riscv/kernel/probes/opt.c         | 121 ++++++++++++++++++++++---
 3 files changed, 112 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index e40c837d0a1d..7fecec799077 100644
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
index 785b023a62ea..907b951f2c86 100644
--- a/arch/riscv/kernel/probes/decode-insn.h
+++ b/arch/riscv/kernel/probes/decode-insn.h
@@ -13,6 +13,11 @@ enum probe_insn {
 	INSN_GOOD,
 };
 
+#define NRREG 32
+#define ALL_REG_OCCUPIED 0xffffffffu
+/* If a register is not caller-saved, its corresponding bit is set */
+#define NON_CALLER_SAVED_MASK 0xffc031d
+
 enum probe_insn __kprobes
 riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *asi);
 
diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index 1c0e9d218f6f..884e77d2df4c 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -12,6 +12,7 @@
 #include <asm/kprobes.h>
 #include <asm/patch.h>
 #include <asm/asm-offsets.h>
+#include <linux/extable.h>
 
 #include "simulate-insn.h"
 #include "decode-insn.h"
@@ -130,7 +131,7 @@ static void prepare_detour_buffer(kprobe_opcode_t *code, kprobe_opcode_t *slot,
  * as a destination register before any branch or jump instruction.
  */
 static void find_register(unsigned long start, unsigned long end,
-			       unsigned long *write, unsigned long *read)
+			  unsigned long *write, unsigned long *read)
 {
 	kprobe_opcode_t insn;
 	unsigned long addr, offset = 0UL;
@@ -390,16 +391,99 @@ static int search_copied_insn(unsigned long paddr, struct optimized_kprobe *op)
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
  * The kprobe can be optimized when no in-function jump reaches to the
  * instructions replaced by optimized jump instructions(AUIPC/JALR).
  */
-static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
+static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op, uint32_t *used_reg)
 {
 	int ret;
 	unsigned long addr, size = 0, offset = 0;
 	struct kprobe *kp = get_kprobe((kprobe_opcode_t *)paddr);
 
+	/*
+	 * All callee
+	 */
+	*used_reg = NON_CALLER_SAVED_MASK;
+
 	/*
 	 * Skip optimization if kprobe has been disarmed or instrumented
 	 * instruction support XOI.
@@ -429,18 +513,14 @@ static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
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
@@ -469,10 +549,13 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 {
 	long rel;
 	int rd, ra, ret;
+	u32 used_reg;
 	kprobe_opcode_t *code = NULL, *slot = NULL;
 
-	if (!can_optimize((unsigned long)orig->addr, op))
+	if (!can_optimize((unsigned long)orig->addr, op, &used_reg)) {
+		op->optinsn.rd = -1;
 		return -EILSEQ;
+	}
 
 	code = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
 	slot = get_optinsn_slot();
@@ -497,11 +580,17 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	}
 
 	/*
-	 * Search two free registers, rd is used as to form AUIPC/JALR jumping
-	 * to detour buffer, ra is used as to form JR jumping back from detour
-	 * buffer.
+	 * Search two free registers if no unused ones, rd is used as to form
+	 * AUIPC/JALR jumping to detour buffer, ra is used as to form JR jumping
+	 * back from detour buffer.
 	 */
-	find_free_registers(orig, op, &rd, &ra);
+	if (used_reg == ALL_REG_OCCUPIED) {
+		find_free_registers(orig, op, &rd, &ra);
+	} else {
+		rd = ffz(used_reg);
+		ra = rd;
+	}
+
 	if (rd == 0 || ra == 0) {
 		ret = -EILSEQ;
 		goto on_error;
@@ -545,6 +634,8 @@ void arch_optimize_kprobes(struct list_head *oplist)
 	list_for_each_entry_safe(op, tmp, oplist, list) {
 		WARN_ON(kprobe_disabled(&op->kp));
 
+		if (op->optinsn.rd < 0)
+			continue;
 		/* Backup instructions which will be replaced by jump address */
 		memcpy(op->optinsn.copied_insn,
 		       DETOUR_ADDR(op->kp.addr, GET_INSN_LENGTH(op->kp.opcode)),
-- 
2.34.1

