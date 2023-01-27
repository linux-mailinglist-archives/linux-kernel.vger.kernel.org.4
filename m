Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE26467E614
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjA0NGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjA0NGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:06:30 -0500
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6561A7CCB1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:06:27 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-01 (Coremail) with SMTP id qwCowADX3Eg9zNNjDyF3Ag--.52827S7;
        Fri, 27 Jan 2023 21:06:09 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v6 03/13] riscv/kprobe: Add skeleton for preparing optimized kprobe
Date:   Fri, 27 Jan 2023 21:05:31 +0800
Message-Id: <20230127130541.1250865-4-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADX3Eg9zNNjDyF3Ag--.52827S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyUWr4fGw18ZFy8ur1Dtrb_yoWrXryrpF
        s3Cw45trWDJa93urWfZwsYvrySyFsYqr47CrW7J345Zr17Jr90va97tr1YqF9xGrWF9rW3
        JFsYyry5uFW3ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
        IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3DG5UUUUU=
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiCggEE2PTtMIZxAAAsO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

The skeleton for preparing optprobe is consist of three major parts:

 - Check if kprobe satisfies the requirements of optimization.
 - Search two registers to form AUIPC/JALR instructions.
 - Prepare detour buffer for optimized kprobe.

To avoid introducing too much code in single patch just add some dummy
implementaion for compilation.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/kernel/probes/opt.c | 98 +++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index 56c8a227c857..c03cdb1512a6 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -10,6 +10,53 @@
 
 #include <linux/kprobes.h>
 #include <asm/kprobes.h>
+#include <asm/patch.h>
+
+static int in_auipc_jalr_range(long val)
+{
+#ifdef CONFIG_ARCH_RV32I
+	return 1;
+#else
+	/*
+	 * Note that the set of address offsets that can be formed
+	 * by pairing LUI with LD, AUIPC with JALR, etc. RV64I is
+	 * [−2^31−2^11, 2^31−2^11−1].
+	 */
+	return ((-(1L << 31) - (1L << 11)) <= val) &&
+	       (val < ((1L << 31) - (1L << 11)));
+#endif
+}
+
+/*
+ * Copy optprobe assembly code template into detour buffer and modify some
+ * instructions for each kprobe.
+ */
+static void prepare_detour_buffer(kprobe_opcode_t *code, kprobe_opcode_t *slot,
+				  int rd, struct optimized_kprobe *op,
+				  kprobe_opcode_t opcode)
+{
+}
+
+/*
+ * In RISC-V ISA, AUIPC/JALR clobber one register to form target address,
+ * inspired by register renaming in OoO processor, this involves search
+ * backward that is not previously used as a source register and is used
+ * as a destination register before any branch or jump instruction.
+ */
+static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
+				int *rd, int *ra)
+{
+}
+
+/*
+ * The kprobe based on breakpoint just requires the instrumented instruction
+ * supports execute out-of-line or simulation, besides that, optimized kprobe
+ * requires no near instruction jump to any instruction replaced by AUIPC/JALR.
+ */
+static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
+{
+	return false;
+}
 
 int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
 {
@@ -24,7 +71,56 @@ int arch_check_optimized_kprobe(struct optimized_kprobe *op)
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 				  struct kprobe *orig)
 {
-	return 0;
+	long rel;
+	int rd = 0, ra = 0, ret;
+	kprobe_opcode_t *code = NULL, *slot = NULL;
+
+	if (!can_optimize((unsigned long)orig->addr, op))
+		return -EILSEQ;
+
+	code = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
+	slot = get_optinsn_slot();
+	if (!code || !slot) {
+		ret = -ENOMEM;
+		goto on_error;
+	}
+
+	/* Check if the detour buffer is in the 32-bit pc-relative range. */
+	rel = (unsigned long)slot - (unsigned long)orig->addr;
+	if (!in_auipc_jalr_range(rel)) {
+		ret = -ERANGE;
+		goto on_error;
+	}
+
+	/*
+	 * Search two free registers, rd is used to form AUIPC/JALR jumping
+	 * to detour buffer, ra is used to form JR jumping back from detour
+	 * buffer.
+	 */
+	find_free_registers(orig, op, &rd, &ra);
+	if (rd == 0 || ra == 0) {
+		ret = -EILSEQ;
+		goto on_error;
+	}
+
+	op->optinsn.rd = rd;
+	prepare_detour_buffer(code, slot, ra, op, orig->opcode);
+
+	ret = patch_text_nosync((void *)slot, code, MAX_OPTINSN_SIZE);
+	if (!ret) {
+		op->optinsn.insn = slot;
+		kfree(code);
+		return 0;
+	}
+
+on_error:
+	if (slot) {
+		free_optinsn_slot(slot, 0);
+		op->optinsn.insn = NULL;
+		op->optinsn.length = 0;
+	}
+	kfree(code);
+	return ret;
 }
 
 void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
-- 
2.34.1

