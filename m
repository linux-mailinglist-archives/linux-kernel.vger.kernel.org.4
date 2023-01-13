Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03332669763
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjAMMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbjAMMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA05587F;
        Fri, 13 Jan 2023 04:31:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofU7vTTXMfvG9GCcmskx+vqfzqPR19t6WToEuPpzumE=;
        b=slowYCuoxBSF2QDNKdeCE0jYmChX1uC6IRSGAuPP1NYHKmysNPAJfQ6irh1/xQ4ehnshFx
        ptJZT11IISu6Yh1y26DWNB/94slyEa/8q3GfgQLw0tKlZAOji6ddfOxF+EFuhOqu49ok6S
        f0J+ALvnBwTidvANeLuttkU5PbjgNmzVRwO5bIa1dakx3tFwtS8vR3TTOG4sjudSZdmqcZ
        3B+UwERRJzo9t0GCNA1oTgKhP88mVkRT/qw+ss80kSaVZJpXGr9w+kxa1V1t7d3vZswtck
        TMM50Mh+tqkOECffEimK5qI5+43G803qjewDm4NYBSLFhA0ACy3/uTQbMgn5BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofU7vTTXMfvG9GCcmskx+vqfzqPR19t6WToEuPpzumE=;
        b=y4c+P8FrcEOWZEXJgXbXg5vnG2y7Q7h8ZWhG5Glxsy1d+3Qxbt1CEbjWaZDpjrIi1lU4Jg
        Xu9UsHcCelTfP5BA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arch/idle: Change arch_cpu_idle() behavior: always
 exit with IRQs disabled
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.618076436@infradead.org>
References: <20230112195540.618076436@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307196.4906.6553924407565413202.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     89b3098703bd2aa3237ef10a704e6a5838e6ea69
Gitweb:        https://git.kernel.org/tip/89b3098703bd2aa3237ef10a704e6a5838e6ea69
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

arch/idle: Change arch_cpu_idle() behavior: always exit with IRQs disabled

Current arch_cpu_idle() is called with IRQs disabled, but will return
with IRQs enabled.

However, the very first thing the generic code does after calling
arch_cpu_idle() is raw_local_irq_disable(). This means that
architectures that can idle with IRQs disabled end up doing a
pointless 'enable-disable' dance.

Therefore, push this IRQ disabling into the idle function, meaning
that those architectures can avoid the pointless IRQ state flipping.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.618076436@infradead.org
---
 arch/alpha/kernel/process.c      |  1 -
 arch/arc/kernel/process.c        |  3 +++
 arch/arm/kernel/process.c        |  1 -
 arch/arm/mach-gemini/board-dt.c  |  3 ++-
 arch/arm64/kernel/idle.c         |  1 -
 arch/csky/kernel/process.c       |  1 -
 arch/csky/kernel/smp.c           |  2 +-
 arch/hexagon/kernel/process.c    |  1 -
 arch/ia64/kernel/process.c       |  1 +
 arch/loongarch/kernel/idle.c     |  1 +
 arch/microblaze/kernel/process.c |  1 -
 arch/mips/kernel/idle.c          |  8 +++-----
 arch/nios2/kernel/process.c      |  1 -
 arch/openrisc/kernel/process.c   |  1 +
 arch/parisc/kernel/process.c     |  2 --
 arch/powerpc/kernel/idle.c       |  5 ++---
 arch/riscv/kernel/process.c      |  1 -
 arch/s390/kernel/idle.c          |  1 -
 arch/sh/kernel/idle.c            |  1 +
 arch/sparc/kernel/leon_pmc.c     |  4 ++++
 arch/sparc/kernel/process_32.c   |  1 -
 arch/sparc/kernel/process_64.c   |  3 ++-
 arch/um/kernel/process.c         |  1 -
 arch/x86/coco/tdx/tdx.c          |  3 +++
 arch/x86/kernel/process.c        | 15 ++++-----------
 arch/xtensa/kernel/process.c     |  1 +
 kernel/sched/idle.c              |  2 --
 27 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 65fdae9..ce20c31 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -57,7 +57,6 @@ EXPORT_SYMBOL(pm_power_off);
 void arch_cpu_idle(void)
 {
 	wtint(0);
-	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_dead(void)
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 3369f07..980b71d 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -114,6 +114,8 @@ void arch_cpu_idle(void)
 		"sleep %0	\n"
 		:
 		:"I"(arg)); /* can't be "r" has to be embedded const */
+
+	raw_local_irq_disable();
 }
 
 #else	/* ARC700 */
@@ -122,6 +124,7 @@ void arch_cpu_idle(void)
 {
 	/* sleep, but enable both set E1/E2 (levels of interrupts) before committing */
 	__asm__ __volatile__("sleep 0x3	\n");
+	raw_local_irq_disable();
 }
 
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f811733..c81e7be 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -78,7 +78,6 @@ void arch_cpu_idle(void)
 		arm_pm_idle();
 	else
 		cpu_do_idle();
-	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_prepare(void)
diff --git a/arch/arm/mach-gemini/board-dt.c b/arch/arm/mach-gemini/board-dt.c
index de0afcc..fbafe74 100644
--- a/arch/arm/mach-gemini/board-dt.c
+++ b/arch/arm/mach-gemini/board-dt.c
@@ -42,8 +42,9 @@ static void gemini_idle(void)
 	 */
 
 	/* FIXME: Enabling interrupts here is racy! */
-	local_irq_enable();
+	raw_local_irq_enable();
 	cpu_do_idle();
+	raw_local_irq_disable();
 }
 
 static void __init gemini_init_machine(void)
diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
index a2cfbac..c112575 100644
--- a/arch/arm64/kernel/idle.c
+++ b/arch/arm64/kernel/idle.c
@@ -42,5 +42,4 @@ void noinstr arch_cpu_idle(void)
 	 * tricks
 	 */
 	cpu_do_idle();
-	raw_local_irq_enable();
 }
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 2b0ed51..0c6e4b1 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -100,6 +100,5 @@ void arch_cpu_idle(void)
 #ifdef CONFIG_CPU_PM_STOP
 	asm volatile("stop\n");
 #endif
-	raw_local_irq_enable();
 }
 #endif
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 4b605aa..b45d107 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -309,7 +309,7 @@ void arch_cpu_idle_dead(void)
 	while (!secondary_stack)
 		arch_cpu_idle();
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	asm volatile(
 		"mov	sp, %0\n"
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index e15eeae..dd7f74e 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -44,7 +44,6 @@ void arch_cpu_idle(void)
 {
 	__vmwait();
 	/*  interrupts wake us up, but irqs are still disabled */
-	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 416305e..f6195a0 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -242,6 +242,7 @@ void arch_cpu_idle(void)
 		(*mark_idle)(1);
 
 	raw_safe_halt();
+	raw_local_irq_disable();
 
 	if (mark_idle)
 		(*mark_idle)(0);
diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
index 1a65d05..0b5dd2f 100644
--- a/arch/loongarch/kernel/idle.c
+++ b/arch/loongarch/kernel/idle.c
@@ -13,4 +13,5 @@ void __cpuidle arch_cpu_idle(void)
 {
 	raw_local_irq_enable();
 	__arch_cpu_idle(); /* idle instruction needs irq enabled */
+	raw_local_irq_disable();
 }
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 1f802aa..56342e1 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -140,5 +140,4 @@ int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 
 void arch_cpu_idle(void)
 {
-       raw_local_irq_enable();
 }
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 53adcc1..3e7ccdd 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -33,13 +33,13 @@ static void __cpuidle r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
 	write_c0_conf(cfg | R30XX_CONF_HALT);
-	raw_local_irq_enable();
 }
 
 void __cpuidle r4k_wait(void)
 {
 	raw_local_irq_enable();
 	__r4k_wait();
+	raw_local_irq_disable();
 }
 
 /*
@@ -57,7 +57,6 @@ void __cpuidle r4k_wait_irqoff(void)
 		"	.set	arch=r4000	\n"
 		"	wait			\n"
 		"	.set	pop		\n");
-	raw_local_irq_enable();
 }
 
 /*
@@ -77,7 +76,6 @@ static void __cpuidle rm7k_wait_irqoff(void)
 		"	wait						\n"
 		"	mtc0	$1, $12		# stalls until W stage	\n"
 		"	.set	pop					\n");
-	raw_local_irq_enable();
 }
 
 /*
@@ -103,6 +101,8 @@ static void __cpuidle au1k_wait(void)
 	"	nop				\n"
 	"	.set	pop			\n"
 	: : "r" (au1k_wait), "r" (c0status));
+
+	raw_local_irq_disable();
 }
 
 static int __initdata nowait;
@@ -245,8 +245,6 @@ void arch_cpu_idle(void)
 {
 	if (cpu_wait)
 		cpu_wait();
-	else
-		raw_local_irq_enable();
 }
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 29593b9..f840213 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -33,7 +33,6 @@ EXPORT_SYMBOL(pm_power_off);
 
 void arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index f94b5ec..dfa558f 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -102,6 +102,7 @@ void arch_cpu_idle(void)
 	raw_local_irq_enable();
 	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
+	raw_local_irq_disable();
 }
 
 void (*pm_power_off)(void) = NULL;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index c4f8374..c064719 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -183,8 +183,6 @@ void arch_cpu_idle_dead(void)
 
 void __cpuidle arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
-
 	/* nop on real hardware, qemu will idle sleep. */
 	asm volatile("or %%r10,%%r10,%%r10\n":::);
 }
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 77cd4c5..b9a725a 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -51,10 +51,9 @@ void arch_cpu_idle(void)
 		 * Some power_save functions return with
 		 * interrupts enabled, some don't.
 		 */
-		if (irqs_disabled())
-			raw_local_irq_enable();
+		if (!irqs_disabled())
+			raw_local_irq_disable();
 	} else {
-		raw_local_irq_enable();
 		/*
 		 * Go into low thread priority and possibly
 		 * low power mode.
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 8955f24..774ffde 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -39,7 +39,6 @@ extern asmlinkage void ret_from_kernel_thread(void);
 void arch_cpu_idle(void)
 {
 	cpu_do_idle();
-	raw_local_irq_enable();
 }
 
 void __show_regs(struct pt_regs *regs)
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index a6bbcea..b04fb41 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -66,7 +66,6 @@ void arch_cpu_idle(void)
 	idle->idle_count++;
 	account_idle_time(cputime_to_nsecs(idle_time));
 	raw_write_seqcount_end(&idle->seqcount);
-	raw_local_irq_enable();
 }
 
 static ssize_t show_idle_count(struct device *dev,
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index f598149..3418c40 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -25,6 +25,7 @@ void default_idle(void)
 	raw_local_irq_enable();
 	/* Isn't this racy ? */
 	cpu_sleep();
+	raw_local_irq_disable();
 	clear_bl_bit();
 }
 
diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index 396f46b..6c00cba 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -57,6 +57,8 @@ static void pmc_leon_idle_fixup(void)
 		"lda	[%0] %1, %%g0\n"
 		:
 		: "r"(address), "i"(ASI_LEON_BYPASS));
+
+	raw_local_irq_disable();
 }
 
 /*
@@ -70,6 +72,8 @@ static void pmc_leon_idle(void)
 
 	/* For systems without power-down, this will be no-op */
 	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
+
+	raw_local_irq_disable();
 }
 
 /* Install LEON Power Down function */
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 33b0215..9c7c662 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -71,7 +71,6 @@ void arch_cpu_idle(void)
 {
 	if (sparc_idle)
 		(*sparc_idle)();
-	raw_local_irq_enable();
 }
 
 /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 6335b69..91c2b81 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -59,7 +59,6 @@ void arch_cpu_idle(void)
 {
 	if (tlb_type != hypervisor) {
 		touch_nmi_watchdog();
-		raw_local_irq_enable();
 	} else {
 		unsigned long pstate;
 
@@ -90,6 +89,8 @@ void arch_cpu_idle(void)
 			"wrpr %0, %%g0, %%pstate"
 			: "=&r" (pstate)
 			: "i" (PSTATE_IE));
+
+		raw_local_irq_disable();
 	}
 }
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 47830ad..106b7da 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -218,7 +218,6 @@ void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
-	raw_local_irq_enable();
 }
 
 int __cant_sleep(void) {
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cfd4c95..f4a59c3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -274,6 +274,9 @@ void __cpuidle tdx_safe_halt(void)
 	 */
 	if (__halt(irq_disabled, do_sti))
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
+
+	/* XXX I can't make sense of what @do_sti actually does */
+	raw_local_irq_disable();
 }
 
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 8481fbe..e57cd31 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -701,6 +701,7 @@ EXPORT_SYMBOL(boot_option_idle_override);
 void __cpuidle default_idle(void)
 {
 	raw_safe_halt();
+	raw_local_irq_disable();
 }
 #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
 EXPORT_SYMBOL(default_idle);
@@ -806,13 +807,7 @@ static void amd_e400_idle(void)
 
 	default_idle();
 
-	/*
-	 * The switch back from broadcast mode needs to be called with
-	 * interrupts disabled.
-	 */
-	raw_local_irq_disable();
 	tick_broadcast_exit();
-	raw_local_irq_enable();
 }
 
 /*
@@ -870,12 +865,10 @@ static __cpuidle void mwait_idle(void)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
+		if (!need_resched()) {
 			__sti_mwait(0, 0);
-		else
-			raw_local_irq_enable();
-	} else {
-		raw_local_irq_enable();
+			raw_local_irq_disable();
+		}
 	}
 	__current_clr_polling();
 }
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 68e0e2f..a815577 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -183,6 +183,7 @@ void coprocessor_flush_release_all(struct thread_info *ti)
 void arch_cpu_idle(void)
 {
 	platform_idle();
+	raw_local_irq_disable();
 }
 
 /*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e924602..e9ef66b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -79,7 +79,6 @@ void __weak arch_cpu_idle_dead(void) { }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
-	raw_local_irq_enable();
 }
 
 /**
@@ -96,7 +95,6 @@ void __cpuidle default_idle_call(void)
 
 		ct_cpuidle_enter();
 		arch_cpu_idle();
-		raw_local_irq_disable();
 		ct_cpuidle_exit();
 
 		start_critical_timings();
