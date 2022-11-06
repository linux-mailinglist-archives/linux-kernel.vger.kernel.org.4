Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8273F61E17A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKFKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiKFKDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:03:54 -0500
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31551E09D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:03:50 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-05 (Coremail) with SMTP id zQCowACnrKByhmdj7bRnCA--.7053S7;
        Sun, 06 Nov 2022 18:03:34 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v4 3/8] riscv/kprobe: Prepare the skeleton to prepare optimized kprobe
Date:   Sun,  6 Nov 2022 18:03:11 +0800
Message-Id: <20221106100316.2803176-4-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnrKByhmdj7bRnCA--.7053S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXw13AFyktr1fWw18ur43Awb_yoWrKryxpF
        s3C3W5trWDJayfurWfZws5XrySyFsYqr47CrWUJ34rZr13JrZ0vas7Kr4YvF98GrWS9rW3
        JrsYvry5uF43ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
        z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
        IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7VUbPEfUUUUUU==
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiCQQCE2NnSqBQOgAAsY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

From: Liao Chang <liaochang1@huawei.com>

This patch provide a skeleton to prepare optimized kprobe instruction
slot, it is consist of two major parts, the first part is check if
current kprobe satifies the requirement to optimize. The kprobe bases on
breakpoint just require the instrumented instruction supports execute
out-of-line or simulation, however optimized kprobe bases on long-jump
needs more requirements, it includes:

 - The target of long-jump in the range of 'AUIPC/JALR'.
 - No near instruction jump to any instruction replaced by 'AUIPC/JALR'
 - It managed to find one free register to form 'AUIPC/JALR' jumping to
   detour buffer.
 - It managed to find one free register to form 'JR' jumping back from
   detour buffer

The second part is allocate a larger instruction slot for each optimized
kprobe, the payload of which is patched with the assembly code defined
in opt_trampoline.S, a call to kprobe pre_handler and these instructions
replaced by 'AUIPC/JALR'.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/kernel/probes/opt.c | 107 ++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index 56c8a227c857..e4a619c2077e 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -10,6 +10,54 @@
 
 #include <linux/kprobes.h>
 #include <asm/kprobes.h>
+#include <asm/patch.h>
+
+static inline int in_auipc_jalr_range(long val)
+{
+#ifdef CONFIG_ARCH_RV32I
+	return 1;
+#else
+	/*
+	 * Note that the set of address offsets that can be formed
+	 * by pairing LUI with LD, AUIPC with JALR, etc. in RV64I is
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
+ * by inspired by register renaming in OoO processor, this involves search
+ * backwards that is not previously used as a source register and is used
+ * as a destination register before any branch or jump instruction.
+ */
+static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
+				int *rd1, int *rd2)
+{
+}
+
+/*
+ * If two free registers can be found at the beginning of both
+ * the start and the end of replaced code, it can be optimized
+ * Also, in-function jumps need to be checked to make sure that
+ * there is no jump to the second instruction to be replaced
+ */
+static bool can_optimize(unsigned long paddr, struct optimized_kprobe *op)
+{
+	return false;
+}
 
 int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
 {
@@ -24,7 +72,64 @@ int arch_check_optimized_kprobe(struct optimized_kprobe *op)
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 				  struct kprobe *orig)
 {
-	return 0;
+	long rel;
+	int rd, ra, ret;
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
+	/*
+	 * Verify if the address gap is within 4GB range, because this uses
+	 * a auipc+jalr pair.
+	 */
+	rel = (unsigned long)slot - (unsigned long)orig->addr;
+	if (!in_auipc_jalr_range(rel)) {
+		/*
+		 * Different from x86, we free code buf directly instead of
+		 * calling __arch_remove_optimized_kprobe() because
+		 * we have not fill any field in op.
+		 */
+		ret = -ERANGE;
+		goto on_error;
+	}
+
+	/*
+	 * Search two free registers, rd is used as to form AUIPC/JALR jumping
+	 * to detour buffer, ra is used as to form JR jumping back from detour
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
2.25.1

