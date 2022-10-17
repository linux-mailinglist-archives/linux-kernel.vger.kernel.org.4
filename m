Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A46011EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiJQO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiJQOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DF696D0;
        Mon, 17 Oct 2022 07:54:08 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2xpYhcBu2OHVhFFfi6o/lHeSEY/GqQeDqZ3tZOm7h8=;
        b=FnfbkQL7RFAxIbDQfXP0fsw4CLsnyIXmorxLaMVwfjb9+4lPBibLFKQ4vCdOsCLtgf6NX0
        QT4JpTTRqfmUPB/VcP3vfshrI8Jxhk/vEusbLyz4xXJOxhn9ZzdBwZVnhZoKpltYGsL+G8
        fYZp6hfSrwB7TW0DyAk33bf4ifNSira0PFiMT1H2SOp6/3QRA7cHXjZFKH+ahvSDM8ftxn
        TljU3sAAIC4lDRvUv9hW/t4pPd0XJQH+TGntevZUi9Dsbp1aEgZGokA4VwmbL0I6cae+DD
        6ctcoa5AbPSc8eaLDRQavHf4swnBh+CTpXwACvMvGPgEp5wdFJYjnLQ5IY+9yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2xpYhcBu2OHVhFFfi6o/lHeSEY/GqQeDqZ3tZOm7h8=;
        b=uQAxKhJw2sjPOQC1u5+Frg+4pnFM+GUNfZfnYaqjxNN+if4c8rSJ16MY6TCzS/+cKSJkcr
        23z0Qb2kJnbmejAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Move irq_stack variables next to current_task
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.599170752@infradead.org>
References: <20220915111145.599170752@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844549.401.13580790256557728644.tip-bot2@tip-bot2>
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

Commit-ID:     d7b6d709a76a4f4ef3108ac41e1b39eb80f5c084
Gitweb:        https://git.kernel.org/tip/d7b6d709a76a4f4ef3108ac41e1b39eb80f5c084
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:05 +02:00

x86/percpu: Move irq_stack variables next to current_task

Further extend struct pcpu_hot with the hard and soft irq stack
pointers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.599170752@infradead.org
---
 arch/x86/include/asm/current.h   |  6 ++++++
 arch/x86/include/asm/irq_stack.h | 12 ++++++------
 arch/x86/include/asm/processor.h |  4 ----
 arch/x86/kernel/cpu/common.c     |  3 ---
 arch/x86/kernel/dumpstack_32.c   |  4 ++--
 arch/x86/kernel/dumpstack_64.c   |  2 +-
 arch/x86/kernel/irq_32.c         | 13 +++++--------
 arch/x86/kernel/irq_64.c         |  6 +++---
 arch/x86/kernel/process_64.c     |  2 +-
 9 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 2dd0131..ac3090d 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -18,6 +18,12 @@ struct pcpu_hot {
 			int			preempt_count;
 			int			cpu_number;
 			unsigned long		top_of_stack;
+			void			*hardirq_stack_ptr;
+#ifdef CONFIG_X86_64
+			bool			hardirq_stack_inuse;
+#else
+			void			*softirq_stack_ptr;
+#endif
 		};
 		u8	pad[64];
 	};
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 147cb8f..7981838 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -116,7 +116,7 @@
 	ASM_CALL_ARG2
 
 #define call_on_irqstack(func, asm_call, argconstr...)			\
-	call_on_stack(__this_cpu_read(hardirq_stack_ptr),		\
+	call_on_stack(__this_cpu_read(pcpu_hot.hardirq_stack_ptr),	\
 		      func, asm_call, argconstr)
 
 /* Macros to assert type correctness for run_*_on_irqstack macros */
@@ -135,7 +135,7 @@
 	 * User mode entry and interrupt on the irq stack do not	\
 	 * switch stacks. If from user mode the task stack is empty.	\
 	 */								\
-	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
+	if (user_mode(regs) || __this_cpu_read(pcpu_hot.hardirq_stack_inuse)) { \
 		irq_enter_rcu();					\
 		func(c_args);						\
 		irq_exit_rcu();						\
@@ -146,9 +146,9 @@
 		 * places. Invoke the stack switch macro with the call	\
 		 * sequence which matches the above direct invocation.	\
 		 */							\
-		__this_cpu_write(hardirq_stack_inuse, true);		\
+		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);	\
 		call_on_irqstack(func, asm_call, constr);		\
-		__this_cpu_write(hardirq_stack_inuse, false);		\
+		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);	\
 	}								\
 }
 
@@ -212,9 +212,9 @@
  */
 #define do_softirq_own_stack()						\
 {									\
-	__this_cpu_write(hardirq_stack_inuse, true);			\
+	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);		\
 	call_on_irqstack(__do_softirq, ASM_CALL_ARG0);			\
-	__this_cpu_write(hardirq_stack_inuse, false);			\
+	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);		\
 }
 
 #endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c345f30..bdde687 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -448,8 +448,6 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(void *, hardirq_stack_ptr);
-DECLARE_PER_CPU(bool, hardirq_stack_inuse);
 extern asmlinkage void ignore_sysret(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
@@ -458,8 +456,6 @@ void current_save_fsgs(void);
 #ifdef CONFIG_STACKPROTECTOR
 DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
 #endif
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* !X86_64 */
 
 struct perf_event;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 408245c..2bec4b4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2024,9 +2024,6 @@ DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
 		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
 EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 
-DEFINE_PER_CPU(void *, hardirq_stack_ptr);
-DEFINE_PER_CPU(bool, hardirq_stack_inuse);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 722fd71..b4905d5 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -37,7 +37,7 @@ const char *stack_type_name(enum stack_type type)
 
 static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
@@ -62,7 +62,7 @@ static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 
 static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.softirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 6c5defd..f05339f 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -134,7 +134,7 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
 
 static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
+	unsigned long *end = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
 	unsigned long *begin;
 
 	/*
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 01833eb..dc1049c 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -52,9 +52,6 @@ static inline int check_stack_overflow(void) { return 0; }
 static inline void print_stack_overflow(void) { }
 #endif
 
-DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-DEFINE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
-
 static void call_on_stack(void *func, void *stack)
 {
 	asm volatile("xchgl	%%ebx,%%esp	\n"
@@ -77,7 +74,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	u32 *isp, *prev_esp, arg1;
 
 	curstk = (struct irq_stack *) current_stack();
-	irqstk = __this_cpu_read(hardirq_stack_ptr);
+	irqstk = __this_cpu_read(pcpu_hot.hardirq_stack_ptr);
 
 	/*
 	 * this is where we switch to the IRQ stack. However, if we are
@@ -115,7 +112,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	struct page *ph, *ps;
 
-	if (per_cpu(hardirq_stack_ptr, cpu))
+	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
 		return 0;
 
 	ph = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
@@ -127,8 +124,8 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return -ENOMEM;
 	}
 
-	per_cpu(hardirq_stack_ptr, cpu) = page_address(ph);
-	per_cpu(softirq_stack_ptr, cpu) = page_address(ps);
+	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = page_address(ph);
+	per_cpu(pcpu_hot.softirq_stack_ptr, cpu) = page_address(ps);
 	return 0;
 }
 
@@ -138,7 +135,7 @@ void do_softirq_own_stack(void)
 	struct irq_stack *irqstk;
 	u32 *isp, *prev_esp;
 
-	irqstk = __this_cpu_read(softirq_stack_ptr);
+	irqstk = __this_cpu_read(pcpu_hot.softirq_stack_ptr);
 
 	/* build the stack frame on the softirq stack */
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 1c0fb96..fe0c859 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -50,7 +50,7 @@ static int map_irq_stack(unsigned int cpu)
 		return -ENOMEM;
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -63,14 +63,14 @@ static int map_irq_stack(unsigned int cpu)
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #endif
 
 int irq_init_percpu_irqstack(unsigned int cpu)
 {
-	if (per_cpu(hardirq_stack_ptr, cpu))
+	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
 		return 0;
 	return map_irq_stack(cpu);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7f807e8..1312de5 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -563,7 +563,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
-		     this_cpu_read(hardirq_stack_inuse));
+		     this_cpu_read(pcpu_hot.hardirq_stack_inuse));
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_fpu, cpu);
