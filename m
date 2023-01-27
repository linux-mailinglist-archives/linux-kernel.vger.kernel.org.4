Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1567E61A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjA0NGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjA0NGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:06:32 -0500
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C85A7D6DB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:06:28 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-01 (Coremail) with SMTP id qwCowADX3Eg9zNNjDyF3Ag--.52827S10;
        Fri, 27 Jan 2023 21:06:10 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v6 06/13] riscv/kprobe: Add code to check if kprobe can be optimized
Date:   Fri, 27 Jan 2023 21:05:34 +0800
Message-Id: <20230127130541.1250865-7-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADX3Eg9zNNjDyF3Ag--.52827S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGr47Jw1rKFyUuw4kuF48Zwb_yoWrur1fpF
        s0ka4YqrWrJFZagrZayrs8Ar1ftws5Gr4xtFW7KrySyw12qr90gan2kr4YvwnxGF4F9r17
        AF40yry5ur43ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiCgUEE2PTtMIZwAADsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

For the RVI and RVC hybrid encoding kernel, although AUIPC/JALR just
occupy 8 bytes space, the patched code is 10 bytes at the worst case
to ensure no RVI is truncated, so to check if kprobe satisfies the
requirement of jump optimization, it has to find out an instruction
window large enough to patch AUIPC/JALR(and padding C.NOP), and ensure
no instruction nearby jumps into the patching window.

Besides that, this series does not support the simulation of pc-relative
instruction in optprobe handler yet, so the patching window should not
includes pc-relative instruction.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/kernel/probes/opt.c | 94 +++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index d38ed1a52c93..d84aa1420fa2 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -269,6 +269,50 @@ static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
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
+			target = 0;
+		return (target >= start) && (target < end);
+	}
+#endif
+
+	if (riscv_insn_is_branch(insn))
+		target = addr + rvi_branch_imme(insn);
+	else if (riscv_insn_is_jal(insn))
+		target = addr + rvi_jal_imme(insn);
+	else
+		target = 0;
+	return (target >= start) && (target < end);
+}
+
+static int search_copied_insn(unsigned long paddr, struct optimized_kprobe *op)
+{
+	int i =  1;
+	struct arch_probe_insn api;
+	unsigned long offset = GET_INSN_LENGTH(*(kprobe_opcode_t *)paddr);
+
+	while ((i++ < MAX_COPIED_INSN) && (offset < 2 * RVI_INSN_LEN)) {
+		if (riscv_probe_decode_insn((kprobe_opcode_t *)(paddr + offset),
+					    &api) != INSN_GOOD)
+			return -1;
+		offset += GET_INSN_LENGTH(*(kprobe_opcode_t *)(paddr + offset));
+	}
+
+	op->optinsn.length = offset;
+	return 0;
+}
+
 /*
  * The kprobe based on breakpoint just requires the instrumented instruction
  * supports execute out-of-line or simulation, besides that, optimized kprobe
@@ -276,7 +320,55 @@ static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
  */
 static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
 {
-	return false;
+	int ret;
+	struct arch_probe_insn api;
+	unsigned long addr, size = 0, offset = 0;
+	struct kprobe *kp = get_kprobe((kprobe_opcode_t *)paddr);
+
+	/*
+	 * Skip optimization if kprobe has been disarmed or instrumented
+	 * instruction doest not support XOI.
+	 */
+	if (!kp || (riscv_probe_decode_insn(&kp->opcode, &api) != INSN_GOOD))
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
2.34.1

