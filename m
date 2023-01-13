Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A279669727
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbjAMMdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbjAMMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5267743DA2;
        Fri, 13 Jan 2023 04:31:07 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQAP4u2bJ+bA1BJFeoVX4LmTMUq5A74Q/vTb8/fHtpA=;
        b=DPEoiaC1sh/1YSPEie8n5W+mejzUObKFLWD1jlRVjw5cO51HfHtQfR+J+cVtoHuf8benBq
        q0Lcu2xdj28E87/xRsIRAFPs8Ar3oqKiRuJrUcY94TsQrRo8r8s/57Z/4Cb/AZ+2dTRtkL
        kmxyU8s4KxmFQp/5Yv2tkBU/Z+Fyp6hPxsJDCtoypFnbIlqAPZjgyckOhp9nVI+mM0AeWY
        F0HHTQNCUVOz1NiUSb08EDqR9ZoL1Ay1nkBMtNex+eAdaPgKOWGOBODYI6TeN2qBTFBkPh
        3AlLxcD9CvvU9XzlUQ7i7Skay9gQW63D1h56bpK3PVuiEpHUrjQjSAnnEKPSfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQAP4u2bJ+bA1BJFeoVX4LmTMUq5A74Q/vTb8/fHtpA=;
        b=BUQqK1S9WXVcgcEEq39nLtpoa+jkUgLH6qGqjOStBhca5nndP0GkmlT/jW4GVc62tM4+KS
        hhaO7Mjjil3/t3Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, arch: Mark all ct_cpuidle_enter() callers
 __cpuidle
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195542.274096325@infradead.org>
References: <20230112195542.274096325@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306553.4906.5847045361244514962.tip-bot2@tip-bot2>
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

Commit-ID:     69e26b4f43ed396868c6e7645f9eb06c3a0d2fee
Gitweb:        https://git.kernel.org/tip/69e26b4f43ed396868c6e7645f9eb06c3a0d2fee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:44:02 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

cpuidle, arch: Mark all ct_cpuidle_enter() callers __cpuidle

For all cpuidle drivers that use CPUIDLE_FLAG_RCU_IDLE, ensure that
all functions that call ct_cpuidle_enter() are marked __cpuidle.

( due to lack of noinstr validation on these platforms it is entirely
  possible this isn't complete )

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112195542.274096325@infradead.org
---
 arch/arm/mach-imx/cpuidle-imx6q.c         |  4 ++--
 arch/arm/mach-imx/cpuidle-imx6sx.c        |  4 ++--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |  4 ++--
 arch/arm/mach-omap2/pm34xx.c              |  2 +-
 arch/arm64/kernel/cpuidle.c               |  2 +-
 drivers/cpuidle/cpuidle-arm.c             |  4 ++--
 drivers/cpuidle/cpuidle-big_little.c      |  4 ++--
 drivers/cpuidle/cpuidle-mvebu-v7.c        |  6 +++---
 drivers/cpuidle/cpuidle-psci.c            | 17 ++++++-----------
 drivers/cpuidle/cpuidle-qcom-spm.c        |  4 ++--
 drivers/cpuidle/cpuidle-riscv-sbi.c       | 10 +++++-----
 drivers/cpuidle/cpuidle-tegra.c           | 10 +++++-----
 12 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index c24c78a..2b0d316 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -17,8 +17,8 @@
 static int num_idle_cpus = 0;
 static DEFINE_RAW_SPINLOCK(cpuidle_lock);
 
-static int imx6q_enter_wait(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
+static __cpuidle int imx6q_enter_wait(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv, int index)
 {
 	raw_spin_lock(&cpuidle_lock);
 	if (++num_idle_cpus == num_online_cpus())
diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 479f062..83c5cbd 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -30,8 +30,8 @@ static int imx6sx_idle_finish(unsigned long val)
 	return 0;
 }
 
-static int imx6sx_enter_wait(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
+static __cpuidle int imx6sx_enter_wait(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int index)
 {
 	imx6_set_lpm(WAIT_UNCLOCKED);
 
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 7f29e17..7ad74db 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -224,8 +224,8 @@ static void __init save_l2x0_context(void)
  *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
  *	3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
  */
-int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
-			 bool rcuidle)
+__cpuidle int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
+				   bool rcuidle)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int save_state = 0, cpu_logic_state = PWRDM_POWER_RET;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9856091..6897577 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -175,7 +175,7 @@ static int omap34xx_do_sram_idle(unsigned long save_state)
 	return 0;
 }
 
-void omap_sram_idle(bool rcuidle)
+__cpuidle void omap_sram_idle(bool rcuidle)
 {
 	/* Variable to tell what needs to be saved and restored
 	 * in omap_sram_idle*/
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 4150e30..41974a1 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -62,7 +62,7 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 	return psci_acpi_cpu_init_idle(cpu);
 }
 
-int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+__cpuidle int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	u32 state = lpi->address;
 
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 8c75892..7cfb980 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -31,8 +31,8 @@
  * Called from the CPUidle framework to program the device to the
  * specified target state selected by the governor.
  */
-static int arm_enter_idle_state(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int arm_enter_idle_state(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int idx)
 {
 	/*
 	 * Pass idle state index to arm_cpuidle_suspend which in turn
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 5858db2..74972de 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -122,8 +122,8 @@ static int notrace bl_powerdown_finisher(unsigned long arg)
  * Called from the CPUidle framework to program the device to the
  * specified target state selected by the governor.
  */
-static int bl_enter_powerdown(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int bl_enter_powerdown(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int idx)
 {
 	cpu_pm_enter();
 	ct_cpuidle_enter();
diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 20bfb26..114bd09 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -25,9 +25,9 @@
 
 static int (*mvebu_v7_cpu_suspend)(int);
 
-static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+static __cpuidle int mvebu_v7_enter_idle(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
 {
 	int ret;
 	bool deepidle = false;
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 58b2cbb..4fc4e03 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -49,14 +49,9 @@ static inline u32 psci_get_domain_state(void)
 	return __this_cpu_read(domain_state);
 }
 
-static inline int psci_enter_state(int idx, u32 state)
-{
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
-}
-
-static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
-					  struct cpuidle_driver *drv, int idx,
-					  bool s2idle)
+static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
+						    struct cpuidle_driver *drv, int idx,
+						    bool s2idle)
 {
 	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
 	u32 *states = data->psci_states;
@@ -192,12 +187,12 @@ static void psci_idle_init_cpuhp(void)
 		pr_warn("Failed %d while setup cpuhp state\n", err);
 }
 
-static int psci_enter_idle_state(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int psci_enter_idle_state(struct cpuidle_device *dev,
+					   struct cpuidle_driver *drv, int idx)
 {
 	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 
-	return psci_enter_state(idx, state[idx]);
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state[idx]);
 }
 
 static const struct of_device_id psci_idle_state_match[] = {
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index beedf22..326bca1 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -58,8 +58,8 @@ static int qcom_cpu_spc(struct spm_driver_data *drv)
 	return ret;
 }
 
-static int spm_enter_idle_state(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int spm_enter_idle_state(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int idx)
 {
 	struct cpuidle_qcom_spm_data *data = container_of(drv, struct cpuidle_qcom_spm_data,
 							  cpuidle_driver);
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 0a480f5..be383f4 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -93,8 +93,8 @@ static int sbi_suspend(u32 state)
 		return sbi_suspend_finisher(state, 0, 0);
 }
 
-static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
-				   struct cpuidle_driver *drv, int idx)
+static __cpuidle int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
+					     struct cpuidle_driver *drv, int idx)
 {
 	u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
 	u32 state = states[idx];
@@ -106,9 +106,9 @@ static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
 							     idx, state);
 }
 
-static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
-					  struct cpuidle_driver *drv, int idx,
-					  bool s2idle)
+static __cpuidle int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
+						   struct cpuidle_driver *drv, int idx,
+						   bool s2idle)
 {
 	struct sbi_cpuidle_data *data = this_cpu_ptr(&sbi_cpuidle_data);
 	u32 *states = data->states;
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 9c2903c..b203a93 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -160,8 +160,8 @@ static int tegra_cpuidle_coupled_barrier(struct cpuidle_device *dev)
 	return 0;
 }
 
-static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
-				     int index, unsigned int cpu)
+static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
+					       int index, unsigned int cpu)
 {
 	int err;
 
@@ -226,9 +226,9 @@ static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
 	return index;
 }
 
-static int tegra_cpuidle_enter(struct cpuidle_device *dev,
-			       struct cpuidle_driver *drv,
-			       int index)
+static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
 {
 	bool do_rcu = drv->states[index].flags & CPUIDLE_FLAG_RCU_IDLE;
 	unsigned int cpu = cpu_logical_map(dev->cpu);
