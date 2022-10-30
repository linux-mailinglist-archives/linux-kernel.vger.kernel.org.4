Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9368461295A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ3JVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJ3JVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:21:40 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C937B84B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:21:36 -0700 (PDT)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-03 (Coremail) with SMTP id rQCowABXCVmKPV5jkxYmBw--.33365S7;
        Sun, 30 Oct 2022 17:02:18 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH 3/8] riscv/kprobe: Prepare the skeleton to prepare optimized kprobe
Date:   Sun, 30 Oct 2022 17:01:36 +0800
Message-Id: <20221030090141.2550837-4-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
References: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXCVmKPV5jkxYmBw--.33365S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWkCFW3Cw1fKF47JFyxKrg_yoWrKr47pF
        s3C3W5trWDJa93urWfAws5XrySyFsYqr47CrWUJ34rZr13JrZ0vas7Kr4YvF98GrWF9rW3
        JrsYyry5uFW3ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
        ACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8c_aDUUUU
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiAw8PE2NeFqsxrAAAsN
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

This patch just provides a skeleton to prepare optimized kprobe
instruction slot, it consists of two major parts, the first part is to
check if current kprobe satifies the optimization requirement. The 
kprobe based on breakpoint just requires the instrumented instruction to
support execute out-of-line(non PC-relative) or simulation, however 
optimized kprobe based on long-jump needs more requirements, it includes:

 - The target of long jump in the range of 'AUIPC/JALR'
 - No near instruction jump to any instruction replaced by 'AUIPC/JALR'
 - It managed to find one free register to form 'AUIPC/JALR' jumping to
   detour buffer.
 - It managed to find one free register to form 'JR' jumping back from
   detour buffer

The second part is to allocate a larger instruction slot for each optimized
kprobe, the payload of which is patched with the assembly code defined
in opt_trampoline.S, a call to kprobe pre_handler and these instructions
replaced by 'AUIPC/JALR'.

Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
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

