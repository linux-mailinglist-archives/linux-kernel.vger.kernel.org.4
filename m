Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD09361E17F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiKFKEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKFKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:03:55 -0500
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF9FDDF60
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:03:51 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-05 (Coremail) with SMTP id zQCowACnrKByhmdj7bRnCA--.7053S11;
        Sun, 06 Nov 2022 18:03:35 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v4 7/8] riscv/kprobe: Prepare detour buffer for optimized kprobe
Date:   Sun,  6 Nov 2022 18:03:15 +0800
Message-Id: <20221106100316.2803176-8-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnrKByhmdj7bRnCA--.7053S11
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1fXFyDurW3Xr1kKw47XFb_yoWDJw4fpa
        95CwnxXF4UZFn7Cry7t3Z5Jr4Sqws5Jws7Grs7GFW5tan3KrW5Xan2g3y5Xr15G3yqgry7
        ua45JryUuF9xXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjfUOOzVUUUUU
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiBwECE2NnTgRK3gAAsN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

From: Liao Chang <liaochang1@huawei.com>

This patch introduce code to prepare instruction slot for optimized
kprobe, the instruction slot for regular kprobe just records two
instructions, first one is the original instruction replaced by EBREAK,
the second one is EBREAK for single-step. While instruction slot for
optimized kprobe is larger, beside execute instruction out-of-line, it
also contains a standalone stackframe for calling kprobe handler.

All optimized instruction slots consis of 5 major parts, which copied
from the assembly code template in opt_trampoline.S.

	SAVE REGS
	CALL optimized_callback
	RESTORE REGS
	EXECUTE INSNS OUT-OF-LINE
	RETURN BACK

Although most instructions in each slot are same, these slots still have
a bit difference in their payload, it is result from three parts:

  - 'CALL optimized_callback', the relative offset for 'call'
    instruction is different for each kprobe.
  - 'EXECUTE INSN OUT-OF-LINE', no doubt.
  - 'RETURN BACK', the chosen free register is reused here as the
     destination register of jumping back.

So it also need to customize the slot payload for each optimized kprobe.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/include/asm/kprobes.h          |  16 +++
 arch/riscv/kernel/probes/opt.c            |  75 +++++++++++++
 arch/riscv/kernel/probes/opt_trampoline.S | 125 ++++++++++++++++++++++
 3 files changed, 216 insertions(+)

diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 22b73a2fd1fd..a9ef864f7225 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -48,10 +48,26 @@ void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
 /* optinsn template addresses */
 extern __visible kprobe_opcode_t optprobe_template_entry[];
 extern __visible kprobe_opcode_t optprobe_template_end[];
+extern __visible kprobe_opcode_t optprobe_template_save[];
+extern __visible kprobe_opcode_t optprobe_template_call[];
+extern __visible kprobe_opcode_t optprobe_template_insn[];
+extern __visible kprobe_opcode_t optprobe_template_return[];
 
 #define MAX_OPTINSN_SIZE				\
 	((unsigned long)optprobe_template_end -		\
 	 (unsigned long)optprobe_template_entry)
+#define DETOUR_SAVE_OFFSET				\
+	((unsigned long)optprobe_template_save -	\
+	 (unsigned long)optprobe_template_entry)
+#define DETOUR_CALL_OFFSET				\
+	((unsigned long)optprobe_template_call -	\
+	 (unsigned long)optprobe_template_entry)
+#define DETOUR_INSN_OFFSET				\
+	((unsigned long)optprobe_template_insn -	\
+	 (unsigned long)optprobe_template_entry)
+#define DETOUR_RETURN_OFFSET				\
+	((unsigned long)optprobe_template_return -	\
+	 (unsigned long)optprobe_template_entry)
 
 /*
  * For RVI and RVC hybird encoding kernel, althought long jump just needs
diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
index 876bec539554..77248ed7d4e8 100644
--- a/arch/riscv/kernel/probes/opt.c
+++ b/arch/riscv/kernel/probes/opt.c
@@ -11,9 +11,37 @@
 #include <linux/kprobes.h>
 #include <asm/kprobes.h>
 #include <asm/patch.h>
+#include <asm/asm-offsets.h>
 
 #include "simulate-insn.h"
 #include "decode-insn.h"
+#include "../../net/bpf_jit.h"
+
+static void
+optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
+{
+	unsigned long flags;
+	struct kprobe_ctlblk *kcb;
+
+	/* Save skipped registers */
+	regs->epc = (unsigned long)op->kp.addr;
+	regs->orig_a0 = ~0UL;
+
+	local_irq_save(flags);
+	kcb = get_kprobe_ctlblk();
+
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(&op->kp);
+	} else {
+		__this_cpu_write(current_kprobe, &op->kp);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		opt_pre_handler(&op->kp, regs);
+		__this_cpu_write(current_kprobe, NULL);
+	}
+	local_irq_restore(flags);
+}
+
+NOKPROBE_SYMBOL(optimized_callback)
 
 static inline int in_auipc_jalr_range(long val)
 {
@@ -30,6 +58,11 @@ static inline int in_auipc_jalr_range(long val)
 #endif
 }
 
+#define DETOUR_ADDR(code, offs) \
+	((void *)((unsigned long)(code) + (offs)))
+#define DETOUR_INSN(code, offs) \
+	(*(kprobe_opcode_t *)((unsigned long)(code) + (offs)))
+
 /*
  * Copy optprobe assembly code template into detour buffer and modify some
  * instructions for each kprobe.
@@ -38,6 +71,49 @@ static void prepare_detour_buffer(kprobe_opcode_t *code, kprobe_opcode_t *slot,
 				  int rd, struct optimized_kprobe *op,
 				  kprobe_opcode_t opcode)
 {
+	long offs;
+	unsigned long data;
+
+	memcpy(code, optprobe_template_entry, MAX_OPTINSN_SIZE);
+
+	/* Step1: record optimized_kprobe pointer into detour buffer */
+	memcpy(DETOUR_ADDR(code, DETOUR_SAVE_OFFSET), &op, sizeof(op));
+
+	/*
+	 * Step2
+	 * auipc ra, 0     --> aupic ra, HI20.{optimized_callback - pc}
+	 * jalr  ra, 0(ra) --> jalr  ra, LO12.{optimized_callback - pc}(ra)
+	 */
+	offs = (unsigned long)&optimized_callback -
+	       (unsigned long)DETOUR_ADDR(slot, DETOUR_CALL_OFFSET);
+	DETOUR_INSN(code, DETOUR_CALL_OFFSET) =
+				rv_auipc(1, (offs + (1 << 11)) >> 12);
+	DETOUR_INSN(code, DETOUR_CALL_OFFSET + 0x4) =
+				rv_jalr(1, 1, offs & 0xFFF);
+
+	/* Step3: copy replaced instructions into detour buffer */
+	memcpy(DETOUR_ADDR(code, DETOUR_INSN_OFFSET), op->kp.addr,
+	       op->optinsn.length);
+	memcpy(DETOUR_ADDR(code, DETOUR_INSN_OFFSET), &opcode,
+	       GET_INSN_LENGTH(opcode));
+
+	/* Step4: record return address of long jump into detour buffer */
+	data = (unsigned long)op->kp.addr + op->optinsn.length;
+	memcpy(DETOUR_ADDR(code, DETOUR_RETURN_OFFSET), &data, sizeof(data));
+
+	/*
+	 * Step5
+	 * auipc ra, 0      --> auipc rd, 0
+	 * ld/w  ra, -4(ra) --> ld/w  rd, -8(rd)
+	 * jalr  x0,  0(ra) --> jalr  x0,  0(rd)
+	 */
+	DETOUR_INSN(code, DETOUR_RETURN_OFFSET + 0x8) = rv_auipc(rd, 0);
+#if __riscv_xlen == 32
+	DETOUR_INSN(code, DETOUR_RETURN_OFFSET + 0xC) = rv_lw(rd, -8, rd);
+#else
+	DETOUR_INSN(code, DETOUR_RETURN_OFFSET + 0xC) = rv_ld(rd, -8, rd);
+#endif
+	DETOUR_INSN(code, DETOUR_RETURN_OFFSET + 0x10) = rv_jalr(0, rd, 0);
 }
 
 /* Registers the first usage of which is the destination of instruction */
diff --git a/arch/riscv/kernel/probes/opt_trampoline.S b/arch/riscv/kernel/probes/opt_trampoline.S
index 16160c4367ff..75e34e373cf2 100644
--- a/arch/riscv/kernel/probes/opt_trampoline.S
+++ b/arch/riscv/kernel/probes/opt_trampoline.S
@@ -1,12 +1,137 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2022 Guokai Chen
+ * Copyright (C) 2022 Liao, Chang <liaochang1@huawei.com>
  */
 
 #include <linux/linkage.h>
 
+#include <asm/asm.h>
 #incldue <asm/csr.h>
 #include <asm/asm-offsets.h>
 
 SYM_ENTRY(optprobe_template_entry, SYM_L_GLOBAL, SYM_A_NONE)
+	addi  sp, sp, -(PT_SIZE_ON_STACK)
+	REG_S x1,  PT_RA(sp)
+	REG_S x2,  PT_SP(sp)
+	REG_S x3,  PT_GP(sp)
+	REG_S x4,  PT_TP(sp)
+	REG_S x5,  PT_T0(sp)
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
+	REG_S x10, PT_A0(sp)
+	REG_S x11, PT_A1(sp)
+	REG_S x12, PT_A2(sp)
+	REG_S x13, PT_A3(sp)
+	REG_S x14, PT_A4(sp)
+	REG_S x15, PT_A5(sp)
+	REG_S x16, PT_A6(sp)
+	REG_S x17, PT_A7(sp)
+	REG_S x18, PT_S2(sp)
+	REG_S x19, PT_S3(sp)
+	REG_S x20, PT_S4(sp)
+	REG_S x21, PT_S5(sp)
+	REG_S x22, PT_S6(sp)
+	REG_S x23, PT_S7(sp)
+	REG_S x24, PT_S8(sp)
+	REG_S x25, PT_S9(sp)
+	REG_S x26, PT_S10(sp)
+	REG_S x27, PT_S11(sp)
+	REG_S x28, PT_T3(sp)
+	REG_S x29, PT_T4(sp)
+	REG_S x30, PT_T5(sp)
+	REG_S x31, PT_T6(sp)
+	/* Update fp is friendly for stacktrace */
+	addi  s0, sp, (PT_SIZE_ON_STACK)
+	j 1f
+
+SYM_ENTRY(optprobe_template_save, SYM_L_GLOBAL, SYM_A_NONE)
+	/*
+	 * Step1:
+	 * Filled with the pointer to optimized_kprobe data
+	 */
+	.dword 0
+1:
+	/* Load optimize_kprobe pointer from .dword below */
+	auipc a0, 0
+	REG_L a0, -8(a0)
+	add   a1, sp, x0
+
+SYM_ENTRY(optprobe_template_call, SYM_L_GLOBAL, SYM_A_NONE)
+	/*
+	 * Step2:
+	 * <IMME> of AUIPC/JALR are modified to the offset to optimized_callback
+	 * jump target is loaded from above .dword.
+	 */
+	auipc ra, 0
+	jalr  ra, 0(ra)
+
+	REG_L x1,  PT_RA(sp)
+	REG_L x3,  PT_GP(sp)
+	REG_L x4,  PT_TP(sp)
+	REG_L x5,  PT_T0(sp)
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
+	REG_L x10, PT_A0(sp)
+	REG_L x11, PT_A1(sp)
+	REG_L x12, PT_A2(sp)
+	REG_L x13, PT_A3(sp)
+	REG_L x14, PT_A4(sp)
+	REG_L x15, PT_A5(sp)
+	REG_L x16, PT_A6(sp)
+	REG_L x17, PT_A7(sp)
+	REG_L x18, PT_S2(sp)
+	REG_L x19, PT_S3(sp)
+	REG_L x20, PT_S4(sp)
+	REG_L x21, PT_S5(sp)
+	REG_L x22, PT_S6(sp)
+	REG_L x23, PT_S7(sp)
+	REG_L x24, PT_S8(sp)
+	REG_L x25, PT_S9(sp)
+	REG_L x26, PT_S10(sp)
+	REG_L x27, PT_S11(sp)
+	REG_L x28, PT_T3(sp)
+	REG_L x29, PT_T4(sp)
+	REG_L x30, PT_T5(sp)
+	REG_L x31, PT_T6(sp)
+	REG_L x2,  PT_SP(sp)
+	addi  sp, sp, (PT_SIZE_ON_STACK)
+
+SYM_ENTRY(optprobe_template_insn, SYM_L_GLOBAL, SYM_A_NONE)
+	/*
+	 * Step3:
+	 * NOPS will be replaced by the probed instruction, at worst case 3 RVC
+	 * and 1 RVI instructions is about to execute out of line.
+	 */
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	j 2f
+
+SYM_ENTRY(optprobe_template_return, SYM_L_GLOBAL, SYM_A_NONE)
+	/*
+	 * Step4:
+	 * Filled with the return address of long jump(AUIPC/JALR)
+	 */
+	.dword 0
+2:
+	/*
+	 * Step5:
+	 * The <RA> of AUIPC/LD/JALR will be replaced for each kprobe,
+	 * used to read return address saved in .dword above.
+	 */
+	auipc ra, 0
+	REG_L ra, -8(ra)
+	jalr  x0, 0(ra)
 SYM_ENTRY(optprobe_template_end, SYM_L_GLOBAL, SYM_A_NONE)
-- 
2.25.1

