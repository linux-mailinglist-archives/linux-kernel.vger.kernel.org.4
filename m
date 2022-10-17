Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1126011FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJQO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiJQOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82785696EF;
        Mon, 17 Oct 2022 07:54:15 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slcpjwvmUivkfDM6rePvZomTFDKVkh69xF82qRvShag=;
        b=Nt+PtXyXfA+w9LY/WD4mquwBoM0+vlATcvN5lWB6Qx7HBaYQtJ3dSqwlU+EXZD7Q14FQow
        Wz7RfkGwVjHTvaHneMmPQN/S0HSXvP0z1bcWpLxrCvRLrONxebOQ9vf30znNwBKZYbplDi
        ggntPGGt6nNcB4ZEK1z4vrZqa5uWnSDK83oARrTqjKDdXHBnfIySkdIY9gOx0AjZUurorA
        sqpSDg3GUUoOQXdl3eNf/NJdQV8/zl/LhvHR8Wx2+eX4c8jDUsot7YgqchwWEoh4kC6suE
        65OaWDheeQnnXrwkyLZyLHd10YeQNG1POMkGg7CO1z0O/ba5Sbx8Nyw91NGaFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slcpjwvmUivkfDM6rePvZomTFDKVkh69xF82qRvShag=;
        b=hHtcGKOg+Ypqk1Q3P04d1pKQrI0+BVF7Tmu0tcwIcYDOGZYlbPGtG+Poi6+nC9CsSYewh4
        rdP17t//ctoWKADA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Move current_top_of_stack next to current_task
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.493038635@infradead.org>
References: <20220915111145.493038635@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844653.401.2714011756689788842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c063a217bc0726c2560138229de5673dbb253a02
Gitweb:        https://git.kernel.org/tip/c063a217bc0726c2560138229de5673dbb253a02
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:05 +02:00

x86/percpu: Move current_top_of_stack next to current_task

Extend the struct pcpu_hot cacheline with current_top_of_stack;
another very frequently used value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.493038635@infradead.org
---
 arch/x86/entry/entry_32.S        |  4 ++--
 arch/x86/entry/entry_64.S        |  6 +++---
 arch/x86/entry/entry_64_compat.S |  6 +++---
 arch/x86/include/asm/current.h   |  1 +
 arch/x86/include/asm/processor.h |  4 +---
 arch/x86/kernel/asm-offsets.c    |  2 ++
 arch/x86/kernel/cpu/common.c     | 12 +-----------
 arch/x86/kernel/process_32.c     |  4 ++--
 arch/x86/kernel/process_64.c     |  2 +-
 arch/x86/kernel/smpboot.c        |  2 +-
 arch/x86/kernel/traps.c          |  4 ++--
 11 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e309e71..91397f5 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1181,7 +1181,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 * is using the thread stack right now, so it's safe for us to use it.
 	 */
 	movl	%esp, %ebx
-	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
+	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esp
 	call	exc_nmi
 	movl	%ebx, %esp
 
@@ -1243,7 +1243,7 @@ SYM_CODE_START(rewind_stack_and_make_dead)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esi
+	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esi
 	leal	-TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
 
 	call	make_task_dead
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e635f96..9249a45 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -92,7 +92,7 @@ SYM_CODE_START(entry_SYSCALL_64)
 	/* tss.sp2 is scratch space. */
 	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -1209,7 +1209,7 @@ SYM_CODE_START(asm_exc_nmi)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 	UNWIND_HINT_IRET_REGS base=%rdx offset=8
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
@@ -1525,7 +1525,7 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
 	UNWIND_HINT_REGS
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4dd1981..1dfee86 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -58,7 +58,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	popq	%rax
 
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
@@ -191,7 +191,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 
 	/* Switch to the kernel stack */
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -332,7 +332,7 @@ SYM_CODE_START(entry_INT80_compat)
 	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 
 	movq	%rsp, %rax
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 	pushq	5*8(%rax)		/* regs->ss */
 	pushq	4*8(%rax)		/* regs->rsp */
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 8ac6589..2dd0131 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -17,6 +17,7 @@ struct pcpu_hot {
 			struct task_struct	*current_task;
 			int			preempt_count;
 			int			cpu_number;
+			unsigned long		top_of_stack;
 		};
 		u8	pad[64];
 	};
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c660700..c345f30 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -426,8 +426,6 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
-
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
 	/*
@@ -566,7 +564,7 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  and around vm86 mode and sp0 on x86_64 is special because of the
 	 *  entry trampoline.
 	 */
-	return this_cpu_read_stable(cpu_current_top_of_stack);
+	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
 
 static __always_inline bool on_thread_stack(void)
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index cb50589..a982431 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -109,6 +109,8 @@ static void __used common(void)
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 
+	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
+
 	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
 		BLANK();
 		OFFSET(VMX_spec_ctrl, vcpu_vmx, spec_ctrl);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cafb6bd..408245c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2015,6 +2015,7 @@ __setup("clearcpuid=", setup_clearcpuid);
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,
+	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 
@@ -2026,8 +2027,6 @@ EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 DEFINE_PER_CPU(void *, hardirq_stack_ptr);
 DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
-DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
@@ -2078,15 +2077,6 @@ void syscall_init(void)
 
 #else	/* CONFIG_X86_64 */
 
-/*
- * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
- * the top of the kernel stack.  Use an extra percpu variable to track the
- * top of the kernel stack directly.
- */
-DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
-	(unsigned long)&init_thread_union + THREAD_SIZE;
-EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
-
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 807da45..470c128 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -191,13 +191,13 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	arch_end_context_switch(next_p);
 
 	/*
-	 * Reload esp0 and cpu_current_top_of_stack.  This changes
+	 * Reload esp0 and pcpu_hot.top_of_stack.  This changes
 	 * current_thread_info().  Refresh the SYSENTER configuration in
 	 * case prev or next is vm86.
 	 */
 	update_task_stack(next_p);
 	refresh_sysenter_cs(next);
-	this_cpu_write(cpu_current_top_of_stack,
+	this_cpu_write(pcpu_hot.top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c4f6cac..7f807e8 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -618,7 +618,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * Switch the PDA and FPU contexts.
 	 */
 	raw_cpu_write(pcpu_hot.current_task, next_p);
-	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
+	raw_cpu_write(pcpu_hot.top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish();
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 05f3157..87863a9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1056,7 +1056,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
-	per_cpu(cpu_current_top_of_stack, cpu) = task_top_of_stack(idle);
+	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
 #else
 	initial_gs = per_cpu_offset(cpu);
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a..7ac19ab 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -851,7 +851,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
@@ -869,7 +869,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * trust it and switch to the current kernel stack
 	 */
 	if (ip_within_syscall_gap(regs)) {
-		sp = this_cpu_read(cpu_current_top_of_stack);
+		sp = this_cpu_read(pcpu_hot.top_of_stack);
 		goto sync;
 	}
 
