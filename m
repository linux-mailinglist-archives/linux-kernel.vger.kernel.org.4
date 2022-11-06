Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBAF61E178
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKFKD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKFKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:03:53 -0500
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A1DADFCD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:03:50 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-05 (Coremail) with SMTP id zQCowACnrKByhmdj7bRnCA--.7053S10;
        Sun, 06 Nov 2022 18:03:35 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v4 6/8] riscv/kprobe: Add code to check if kprobe can be optimized
Date:   Sun,  6 Nov 2022 18:03:14 +0800
Message-Id: <20221106100316.2803176-7-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnrKByhmdj7bRnCA--.7053S10
X-Coremail-Antispam: 1UD129KBjvJXoWxXw13Zw45Cr1kCw17Gr4xXrb_yoW7Gry5pF
        s5Ca4YqrWrJFZagrWfAws5JrWSyws5Gr48trW7K34Fvw12qr9Igan7Kr4avFnxGF409r17
        AF40yry8uF43ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x0JUPPEfUUUUU=
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiCgUCE2NnSRxR2gABsF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

From: Liao Chang <liaochang1@huawei.com>

This patch add code to check if kprobe can be optimized, regular kprobe
replaces single instruction with EBREAK or C.EBREAK, it just requires
the instrumented instruction support execute out-of-line or simulation,
while optimized kprobe patch AUIPC/JALR pair to do a long jump, it makes
everything more compilated, espeically for kernel that is hybrid RVI and
RVC binary, although AUIPC/JALR just need 8 bytes space, the bytes to
patch are 10 bytes long at worst case to ensure no RVI would be
truncated, so there are four methods to patch optimized kprobe.

  - Replace 2 RVI with AUIPC/JALR.
  - Replace 4 RVC with AUIPC/JALR.
  - Replace 2 RVC and 1 RVI with AUIPC/JALR.
  - Replace 3 RVC and 1 RVI with AUIPC/JALR, and patch C.NOP into last
    two bytes for alignment.

So it has to find out a instruction window large enough to patch
AUIPC/JALR from the address instrumented breakpoint, meanwhile, ensure
no instruction has chance to jump into the range of patched window.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/kernel/probes/opt.c | 99 ++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index 6d23c843832e..876bec539554 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -271,15 +271,103 @@ static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
 	*ra = (kw == 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);
 }
 
+static bool insn_jump_into_range(unsigned long addr, unsigned long start,
+				 unsigned long end)
+{
+	kprobe_opcode_t insn = *(kprobe_opcode_t *)addr;
+	unsigned long target, offset = GET_INSN_LENGTH(insn);
+
+#ifdef CONFIG_RISCV_ISA_C
+	if (offset == RVC_INSN_LEN) {
+		if (riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn))
+			target = addr + rvc_branch_imme(insn);
+		else if (riscv_insn_is_c_jal(insn) || riscv_insn_is_c_j(insn))
+			target = addr + rvc_jal_imme(insn);
+		else
+			target = addr + offset;
+		return (target >= start) && (target < end);
+	}
+#endif
+
+	if (riscv_insn_is_branch(insn))
+		target = addr + rvi_branch_imme(insn);
+	else if (riscv_insn_is_jal(insn))
+		target = addr + rvi_jal_imme(insn);
+	else
+		target = addr + offset;
+	return (target >= start) && (target < end);
+}
+
+static int search_copied_insn(unsigned long paddr, struct optimized_kprobe *op)
+{
+	int i =  1;
+	unsigned long offset = GET_INSN_LENGTH(*(kprobe_opcode_t *)paddr);
+
+	while ((i++ < MAX_COPIED_INSN) && (offset < 2 * RVI_INSN_LEN)) {
+		if (riscv_probe_decode_insn((probe_opcode_t *)paddr + offset,
+					    NULL) != INSN_GOOD)
+			return -1;
+		offset += GET_INSN_LENGTH(*(kprobe_opcode_t *)(paddr + offset));
+	}
+
+	op->optinsn.length = offset;
+	return 0;
+}
+
 /*
- * If two free registers can be found at the beginning of both
- * the start and the end of replaced code, it can be optimized
- * Also, in-function jumps need to be checked to make sure that
- * there is no jump to the second instruction to be replaced
+ * The kprobe can be optimized when no in-function jump reaches to the
+ * instructions replaced by optimized jump instructions(AUIPC/JALR).
  */
 static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
 {
-	return false;
+	int ret;
+	unsigned long addr, size = 0, offset = 0;
+	struct kprobe *kp = get_kprobe((kprobe_opcode_t *)paddr);
+
+	/*
+	 * Skip optimization if kprobe has been disarmed or instrumented
+	 * instruction support XOI.
+	 */
+	if (!kp || (riscv_probe_decode_insn(&kp->opcode, NULL) != INSN_GOOD))
+		return false;
+
+	/*
+	 * Find a instruction window large enough to contain a pair
+	 * of AUIPC/JALR, and ensure each instruction in this window
+	 * supports XOI.
+	 */
+	ret = search_copied_insn(paddr, op);
+	if (ret)
+		return false;
+
+	if (!kallsyms_lookup_size_offset(paddr, &size, &offset))
+		return false;
+
+	/* Check there is enough space for relative jump(AUIPC/JALR) */
+	if (size - offset <= op->optinsn.length)
+		return false;
+
+	/*
+	 * Decode instructions until function end, check any instruction
+	 * don't jump into the window used to emit optprobe(AUIPC/JALR).
+	 */
+	addr = paddr - offset;
+	while (addr < paddr) {
+		if (insn_jump_into_range(addr, paddr + RVC_INSN_LEN,
+					 paddr + op->optinsn.length))
+			return false;
+		addr += GET_INSN_LENGTH(*(kprobe_opcode_t *)addr);
+	}
+
+	addr = paddr + op->optinsn.length;
+	while (addr < paddr - offset + size) {
+		if (insn_jump_into_range(addr, paddr + RVC_INSN_LEN,
+					 paddr + op->optinsn.length))
+			return false;
+		addr += GET_INSN_LENGTH(*(kprobe_opcode_t *)addr);
+	}
+
+	return true;
 }
 
 int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
-- 
2.25.1

