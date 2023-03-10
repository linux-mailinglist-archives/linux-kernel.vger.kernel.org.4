Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD736B523E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCJUzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjCJUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6B118BED;
        Fri, 10 Mar 2023 12:54:49 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwSo/U7qcN9odK5ztX8XPyzUwewpR5+8k7gDgiaJl9c=;
        b=oY9MGhXZNg+zVVB5xuDOaHPNRVPOihKf0UMn4KlUM7ENabtrjy4Bbv5zd5yJ2nDRc5NPj/
        VrySElWoBc5OWh9sKBSi10v/ZvL1k0AmqluVNfTWeCFVjAncHolik3jym153uG1IGWlnAz
        KdWa5W/OfwqozOpulVFHTfy4wZQmGiJmNkd5JDGW/MCX7ZxWP4dEb8Jb9/uBygezYwKfqj
        cMy/H9z7rlh6kveqdOtJNiLctkGEanFXbEfvlLG2D0INVZ8Hv9v4hOnoxK6GyBDOLbApkn
        s56GUNmR/Ri6l+VHi5q1ICbX2E6DEMUGOioKqDvT7/WbFsY0zj6VcPsFaKkU6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwSo/U7qcN9odK5ztX8XPyzUwewpR5+8k7gDgiaJl9c=;
        b=JB3o6zdbtHJ2Ltn1GNeO0r46Bk5DDmlDOxJeX/vJHj6U+Yy0ALB0BSg07CNvoyPWUFoiCu
        83Nt3EdvUtvfHnBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] sched/idle: Mark arch_cpu_idle_dead() __noreturn
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <60d527353da8c99d4cf13b6473131d46719ed16d.1676358308.git.jpoimboe@kernel.org>
References: <60d527353da8c99d4cf13b6473131d46719ed16d.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848168727.5837.3929313333702203573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     071c44e4278156f18a6a56958617223b6bffa6ab
Gitweb:        https://git.kernel.org/tip/071c44e4278156f18a6a56958617223b6bffa6ab
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:58 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:28 -08:00

sched/idle: Mark arch_cpu_idle_dead() __noreturn

Before commit 076cbf5d2163 ("x86/xen: don't let xen_pv_play_dead()
return"), in Xen, when a previously offlined CPU was brought back
online, it unexpectedly resumed execution where it left off in the
middle of the idle loop.

There were some hacks to make that work, but the behavior was surprising
as do_idle() doesn't expect an offlined CPU to return from the dead (in
arch_cpu_idle_dead()).

Now that Xen has been fixed, and the arch-specific implementations of
arch_cpu_idle_dead() also don't return, give it a __noreturn attribute.

This will cause the compiler to complain if an arch-specific
implementation might return.  It also improves code generation for both
caller and callee.

Also fixes the following warning:

  vmlinux.o: warning: objtool: do_idle+0x25f: unreachable instruction

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/60d527353da8c99d4cf13b6473131d46719ed16d.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/alpha/kernel/process.c     | 2 +-
 arch/arm/kernel/smp.c           | 2 +-
 arch/arm64/kernel/process.c     | 2 +-
 arch/csky/kernel/smp.c          | 2 +-
 arch/ia64/kernel/process.c      | 2 +-
 arch/loongarch/kernel/process.c | 2 +-
 arch/mips/kernel/process.c      | 2 +-
 arch/parisc/kernel/process.c    | 2 +-
 arch/powerpc/kernel/smp.c       | 2 +-
 arch/riscv/kernel/cpu-hotplug.c | 2 +-
 arch/s390/kernel/idle.c         | 2 +-
 arch/sh/kernel/idle.c           | 2 +-
 arch/sparc/kernel/process_64.c  | 2 +-
 arch/x86/kernel/process.c       | 2 +-
 arch/xtensa/kernel/smp.c        | 2 +-
 include/linux/cpu.h             | 2 +-
 kernel/sched/idle.c             | 2 +-
 tools/objtool/check.c           | 1 +
 18 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index a82fefa..582d965 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -60,7 +60,7 @@ void arch_cpu_idle(void)
 	wtint(0);
 }
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	wtint(INT_MAX);
 	BUG();
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 441ea5c..d6be450 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -320,7 +320,7 @@ void __cpu_die(unsigned int cpu)
  * of the other hotplug-cpu capable cores, so presumably coming
  * out of idle fixes this.
  */
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	unsigned int cpu = smp_processor_id();
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 71d59b5..089ced6 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -69,7 +69,7 @@ void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
 #ifdef CONFIG_HOTPLUG_CPU
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
        cpu_die();
 }
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 0ec20ef..9c7a20b 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -300,7 +300,7 @@ void __cpu_die(unsigned int cpu)
 	pr_notice("CPU%u: shutdown\n", cpu);
 }
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
 
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 78f5794..9a5cd9f 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -225,7 +225,7 @@ static inline void __noreturn play_dead(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	play_dead();
 }
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index fa2443c..b71e17c 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -62,7 +62,7 @@ unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
 #ifdef CONFIG_HOTPLUG_CPU
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	play_dead();
 }
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 093dbbd..a322591 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -40,7 +40,7 @@
 #include <asm/stacktrace.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	play_dead();
 }
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index c064719..97c6f87 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -159,7 +159,7 @@ EXPORT_SYMBOL(running_on_qemu);
 /*
  * Called from the idle thread for the CPU which has been shutdown.
  */
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 #ifdef CONFIG_HOTPLUG_CPU
 	idle_task_exit();
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6b90f10..f62e5e6 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1752,7 +1752,7 @@ void __cpu_die(unsigned int cpu)
 		smp_ops->cpu_die(cpu);
 }
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	/*
 	 * Disable on the down path. This will be re-enabled by
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index f7a832e..59b8021 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -71,7 +71,7 @@ void __cpu_die(unsigned int cpu)
 /*
  * Called from the idle thread for the CPU which has been shutdown.
  */
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
 
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 38e267c..e7239aa 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -88,7 +88,7 @@ void arch_cpu_idle_exit(void)
 {
 }
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	cpu_die();
 }
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 114f0c4..d662503 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -30,7 +30,7 @@ void default_idle(void)
 	clear_bl_bit();
 }
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	play_dead();
 }
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 91c2b81..b51d8fb 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -95,7 +95,7 @@ void arch_cpu_idle(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	sched_preempt_enable_no_resched();
 	cpu_play_dead();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f1ec36c..3e30147 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -727,7 +727,7 @@ void arch_cpu_idle_enter(void)
 	local_touch_nmi();
 }
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	play_dead();
 }
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 7bad784..054bd64 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -322,7 +322,7 @@ void __cpu_die(unsigned int cpu)
 	pr_err("CPU%u: unable to kill\n", cpu);
 }
 
-void arch_cpu_idle_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	cpu_die();
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index f83e451..8582a71 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -182,7 +182,7 @@ void arch_cpu_idle(void);
 void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
-void arch_cpu_idle_dead(void);
+void __noreturn arch_cpu_idle_dead(void);
 
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 56e152f..342f58a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -75,7 +75,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
-void __weak arch_cpu_idle_dead(void) { while (1); }
+void __weak __noreturn arch_cpu_idle_dead(void) { while (1); }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f937be1..37c36dc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -202,6 +202,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__reiserfs_panic",
 		"__stack_chk_fail",
 		"__ubsan_handle_builtin_unreachable",
+		"arch_cpu_idle_dead",
 		"cpu_bringup_and_idle",
 		"cpu_startup_entry",
 		"do_exit",
