Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271B4671BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjARMRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjARMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D0187665;
        Wed, 18 Jan 2023 03:38:05 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKOeI6CJeABbZr5jjK4xgH28Q+CRnseRGHAeKjim1sE=;
        b=2MkPdvl5Hkuy70hsqyLwLqopja5ec10Mmw50F0PetxysQUITiAKSCMgjCIXaGjMRQJpfn6
        zpbiLI6J/GtZVh1SjoH3PRNxbHhr3SBU4MjqOgesyjmiUUmuCNYLsb4PqMggU2z2e7nXKC
        q53HDIdZeaArF2q93eCxGSk+6nEH3Swmsf7OJ3Bcrf2BPiRRIzTgr1eGMWFDFqL3fWyNs8
        5xWv8s4m/Dc/teC0HqDCHbmfoz0SwR3ej8FgtCQJU3tbWUzrssxZ2W22qaiL9w+3OjUcMu
        hMP1OZ5XiMBZsxxlZHKzjm0fstEIz6jm9bcNvY3DMVT1hhu3ip5OZbs+AewPhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKOeI6CJeABbZr5jjK4xgH28Q+CRnseRGHAeKjim1sE=;
        b=FDArWEg2kSBUNlfiDXRnZKUg0qHAT0aPBNJq+XP6Xr5lqNLd9VzGHvGuh99zXBGnwOLupo
        7yiccxMRSrOEGoCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, arm64: Fix the ARM64 cpuidle logic
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
References: <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <167404188327.4906.4923868760332054149.tip-bot2@tip-bot2>
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

Commit-ID:     19235e47279894b033a3ec5cf2732de634862b3a
Gitweb:        https://git.kernel.org/tip/19235e47279894b033a3ec5cf2732de634862b3a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Jan 2023 11:26:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 12:27:17 +01:00

cpuidle, arm64: Fix the ARM64 cpuidle logic

The recent cpuidle changes started triggering RCU splats on
Juno development boards:

  | =============================
  | WARNING: suspicious RCU usage
  | -----------------------------
  | include/trace/events/ipi.h:19 suspicious rcu_dereference_check() usage!

Fix cpuidle on ARM64:

 - ... by introducing a new 'is_rcu' flag to the cpuidle helpers & make
   ARM64 use it, as ARM64 wants to keep RCU active longer and wants to
   do the ct_cpuidle_enter()/exit() dance itself.

 - Also update the PSCI driver accordingly.

 - This also removes the last known RCU_NONIDLE() user as a bonus.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net

--
---
 arch/arm64/kernel/cpuidle.c    |  4 ++--
 arch/arm64/kernel/suspend.c    | 12 +++++++++++-
 drivers/cpuidle/cpuidle-psci.c |  6 +-----
 drivers/firmware/psci/psci.c   | 11 +++++++++++
 include/linux/cpuidle.h        | 22 +++++++++++++++-------
 5 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 41974a1..42e19ff 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -67,10 +67,10 @@ __cpuidle int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 	u32 state = lpi->address;
 
 	if (ARM64_LPI_IS_RETENTION_STATE(lpi->arch_flags))
-		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(psci_cpu_suspend_enter,
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM_RCU(psci_cpu_suspend_enter,
 						lpi->index, state);
 	else
-		return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
+		return CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(psci_cpu_suspend_enter,
 					     lpi->index, state);
 }
 #endif
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index e7163f3..0fbdf5f 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -4,6 +4,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/pgtable.h>
+#include <linux/cpuidle.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -104,6 +105,10 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * From this point debug exceptions are disabled to prevent
 	 * updates to mdscr register (saved and restored along with
 	 * general purpose registers) from kernel debuggers.
+	 *
+	 * Strictly speaking the trace_hardirqs_off() here is superfluous,
+	 * hardirqs should be firmly off by now. This really ought to use
+	 * something like raw_local_daif_save().
 	 */
 	flags = local_daif_save();
 
@@ -120,6 +125,8 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 */
 	arm_cpuidle_save_irq_context(&context);
 
+	ct_cpuidle_enter();
+
 	if (__cpu_suspend_enter(&state)) {
 		/* Call the suspend finisher */
 		ret = fn(arg);
@@ -133,8 +140,11 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		 */
 		if (!ret)
 			ret = -EOPNOTSUPP;
+
+		ct_cpuidle_exit();
 	} else {
-		RCU_NONIDLE(__cpu_suspend_exit());
+		ct_cpuidle_exit();
+		__cpu_suspend_exit();
 	}
 
 	arm_cpuidle_restore_irq_context(&context);
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 4fc4e03..312a34e 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -69,16 +69,12 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	else
 		pm_runtime_put_sync_suspend(pd_dev);
 
-	ct_cpuidle_enter();
-
 	state = psci_get_domain_state();
 	if (!state)
 		state = states[idx];
 
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
-	ct_cpuidle_exit();
-
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
 	else
@@ -192,7 +188,7 @@ static __cpuidle int psci_enter_idle_state(struct cpuidle_device *dev,
 {
 	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state[idx]);
+	return CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(psci_cpu_suspend_enter, idx, state[idx]);
 }
 
 static const struct of_device_id psci_idle_state_match[] = {
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e7bcfca..f3a044f 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -462,11 +462,22 @@ int psci_cpu_suspend_enter(u32 state)
 	if (!psci_power_state_loses_context(state)) {
 		struct arm_cpuidle_irq_context context;
 
+		ct_cpuidle_enter();
 		arm_cpuidle_save_irq_context(&context);
 		ret = psci_ops.cpu_suspend(state, 0);
 		arm_cpuidle_restore_irq_context(&context);
+		ct_cpuidle_exit();
 	} else {
+		/*
+		 * ARM64 cpu_suspend() wants to do ct_cpuidle_*() itself.
+		 */
+		if (!IS_ENABLED(CONFIG_ARM64))
+			ct_cpuidle_enter();
+
 		ret = cpu_suspend(state, psci_suspend_finisher);
+
+		if (!IS_ENABLED(CONFIG_ARM64))
+			ct_cpuidle_exit();
 	}
 
 	return ret;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 630c879..3183aeb 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -307,7 +307,7 @@ extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,			\
 				idx,					\
 				state,					\
-				is_retention)				\
+				is_retention, is_rcu)			\
 ({									\
 	int __ret = 0;							\
 									\
@@ -319,9 +319,11 @@ extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 	if (!is_retention)						\
 		__ret =  cpu_pm_enter();				\
 	if (!__ret) {							\
-		ct_cpuidle_enter();					\
+		if (!is_rcu)						\
+			ct_cpuidle_enter();				\
 		__ret = low_level_idle_enter(state);			\
-		ct_cpuidle_exit();					\
+		if (!is_rcu)						\
+			ct_cpuidle_exit();				\
 		if (!is_retention)					\
 			cpu_pm_exit();					\
 	}								\
@@ -330,15 +332,21 @@ extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 })
 
 #define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 0)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 0, 0)
 
 #define CPU_PM_CPU_IDLE_ENTER_RETENTION(low_level_idle_enter, idx)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 1)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 1, 0)
 
 #define CPU_PM_CPU_IDLE_ENTER_PARAM(low_level_idle_enter, idx, state)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 0)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 0, 0)
+
+#define CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(low_level_idle_enter, idx, state)	\
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 0, 1)
 
 #define CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(low_level_idle_enter, idx, state)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 1)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 1, 0)
+
+#define CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM_RCU(low_level_idle_enter, idx, state)	\
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 1, 1)
 
 #endif /* _LINUX_CPUIDLE_H */
