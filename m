Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFFD68EC56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBHKIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:08:42 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F55E125AA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:08:40 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxTuundONjzOwPAA--.31599S3;
        Wed, 08 Feb 2023 18:08:39 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtOWldONjv1gtAA--.52925S4;
        Wed, 08 Feb 2023 18:08:39 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] LoongArch: Add ptrace single step support
Date:   Wed,  8 Feb 2023 18:08:37 +0800
Message-Id: <20230208100837.2451-3-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230208100837.2451-1-zhangqing@loongson.cn>
References: <20230208100837.2451-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxtOWldONjv1gtAA--.52925S4
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrykGw4UWFyrtw4rAr4kCrg_yoW7tFW5pF
        9rCrn5GrW5GF1kWFnIy3Z8ZrnxJw4kW3y2ga4IyaySyw17tr4rXr1kCr1qvF45A3yUWa4S
        grZ8KF4SgFs8Zw7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
        0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07jrPEfUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT,
PTRACE_KILL and PTRACE_SINGLESTEP. This implies defining
arch_has_single_step in  and implementing the
user_enable_single_step and user_disable_single_step functions.

LongArch has no hardware single-step register. the hardware single-step
function multiplex fetch instruction watchpoint(FWPS) and specifies that
the next instruction must trigger the watch exception by setting the mask bit.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ptrace.h   |  2 +
 arch/loongarch/kernel/hw_breakpoint.c | 13 ++++-
 arch/loongarch/kernel/ptrace.c        | 68 +++++++++++++++++++++++++++
 arch/loongarch/kernel/traps.c         | 27 +++++++++--
 4 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 58596c4f8a0f..66a0e6c480a3 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -150,4 +150,6 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
 	regs->regs[3] = val;
 }
 
+#define arch_has_single_step()		(1)
+
 #endif /* _ASM_PTRACE_H */
diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kernel/hw_breakpoint.c
index 4ba1e730f3e9..bcecc076b420 100644
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -497,9 +497,18 @@ arch_initcall(arch_hw_breakpoint_init);
 void hw_breakpoint_thread_switch(struct task_struct *next)
 {
 	struct pt_regs *regs = task_pt_regs(next);
+	u64 addr, mask;
 
-	/* Update breakpoints/watchpoints. */
-	update_bp_registers(regs, 1);
+	if (test_bit(TIF_SINGLESTEP, &task_thread_info(next)->flags)) {
+		addr = read_wb_reg(CSR_CFG_ADDR, 0, 0);
+		mask = read_wb_reg(CSR_CFG_MASK, 0, 0);
+		if ((task_pt_regs(next)->csr_era & ~mask) == (addr & ~mask))
+			csr_write32(0x10000, LOONGARCH_CSR_FWPS);
+			regs->csr_prmd |= CSR_PRMD_PWE;
+	} else {
+		/* Update breakpoints/watchpoints. */
+		update_bp_registers(regs, 1);
+	}
 }
 
 void hw_breakpoint_pmu_read(struct perf_event *bp)
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index bee4194177fd..52a3ee4366f4 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -20,6 +20,7 @@
 #include <linux/context_tracking.h>
 #include <linux/elf.h>
 #include <linux/errno.h>
+#include <linux/hw_breakpoint.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
 #include <linux/regset.h>
@@ -30,6 +31,7 @@
 #include <linux/stddef.h>
 #include <linux/seccomp.h>
 #include <linux/uaccess.h>
+#include <linux/thread_info.h>
 
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
@@ -39,6 +41,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
+#include <asm/ptrace.h>
 #include <asm/reg.h>
 #include <asm/syscall.h>
 
@@ -541,3 +544,68 @@ long arch_ptrace(struct task_struct *child, long request,
 
 	return ret;
 }
+
+void ptrace_triggered(struct perf_event *bp,
+		      struct perf_sample_data *data, struct pt_regs *regs)
+{
+	struct perf_event_attr attr;
+
+	attr = bp->attr;
+	attr.disabled = true;
+	modify_user_hw_breakpoint(bp, &attr);
+}
+
+static int set_single_step(struct task_struct *tsk, unsigned long addr)
+{
+	struct thread_struct *thread = &tsk->thread;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	struct arch_hw_breakpoint *info;
+
+	bp = thread->hbp_break[0];
+	if (!bp) {
+		ptrace_breakpoint_init(&attr);
+
+		attr.bp_addr = addr;
+		attr.bp_len = HW_BREAKPOINT_LEN_8;
+		attr.bp_type = HW_BREAKPOINT_X;
+
+		bp = register_user_hw_breakpoint(&attr, ptrace_triggered,
+						 NULL, tsk);
+		if (IS_ERR(bp))
+			return PTR_ERR(bp);
+
+		thread->hbp_break[0] = bp;
+	} else {
+		int err;
+
+		attr = bp->attr;
+		attr.bp_addr = addr;
+		/* reenable breakpoint */
+		attr.disabled = false;
+		err = modify_user_hw_breakpoint(bp, &attr);
+		if (unlikely(err))
+			return err;
+
+		csr_write64(attr.bp_addr, LOONGARCH_CSR_IB0ADDR);
+	}
+	info = counter_arch_bp(bp);
+	info->mask = 0xffffffffffff;
+
+	return 0;
+}
+
+/* ptrace API */
+void user_enable_single_step(struct task_struct *task)
+{
+	struct thread_info *ti = task_thread_info(task);
+
+	set_single_step(task, task_pt_regs(task)->csr_era);
+	task->thread.single_step = task_pt_regs(task)->csr_era;
+	set_ti_thread_flag(ti, TIF_SINGLESTEP);
+}
+
+void user_disable_single_step(struct task_struct *task)
+{
+	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
+}
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 70085d83476d..0c4c6dcf9a4e 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -512,13 +512,30 @@ asmlinkage void noinstr do_watch(struct pt_regs *regs)
 
 	prev_state = exception_enter();
 
+	if (test_tsk_thread_flag(current, TIF_SINGLESTEP)) {
+		int llbit = (csr_read32(LOONGARCH_CSR_LLBCTL) & 0x1);
+		unsigned long pc = regs->csr_era;
+
+		if (llbit) {
+			csr_write32(0x10000, LOONGARCH_CSR_FWPS);
+			csr_write32(0x4, LOONGARCH_CSR_LLBCTL);
+		} else if (pc == current->thread.single_step) {
+			csr_write32(0x10000, LOONGARCH_CSR_FWPS);
+		} else {
+			csr_write32(0x10000, LOONGARCH_CSR_FWPS);
+			pr_info("Single step in progress\n");
+			force_sig(SIGTRAP);
+		}
+	} else {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	if (breakpoint_handler(regs))
-		return;
-	if (watchpoint_handler(regs))
-		return;
+		if (breakpoint_handler(regs))
+			return;
+		if (watchpoint_handler(regs))
+			return;
+		force_sig(SIGTRAP);
 #endif
-	force_sig(SIGTRAP);
+	}
+
 	exception_exit(prev_state);
 	return;
 }
-- 
2.36.0

