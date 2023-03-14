Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39BC6B9046
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjCNKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCNKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:36:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DDDA9884C;
        Tue, 14 Mar 2023 03:35:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 560D11AED;
        Tue, 14 Mar 2023 03:35:38 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7B403F71A;
        Tue, 14 Mar 2023 03:34:51 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 13/17] PM: EM: Refactor struct em_perf_domain and add default_table
Date:   Tue, 14 Mar 2023 10:33:53 +0000
Message-Id: <20230314103357.26010-14-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314103357.26010-1-lukasz.luba@arm.com>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model support runtime modifications. Refactor old
implementation which accessed struct em_perf_state and introduce
em_perf_domain::default_table to clean up the design. This new field
is better aligned with em_perf_domain::runtime_table and helps to
distinguish them better.

Update all drivers or frameworks which used the old field:
em_perf_domain::table and now should use em_perf_domain::default_table.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_cpu.c       | 27 ++++++++++++++++++--------
 drivers/powercap/dtpm_devfreq.c   | 23 +++++++++++++++-------
 drivers/thermal/cpufreq_cooling.c | 23 ++++++++++++++--------
 drivers/thermal/devfreq_cooling.c | 23 ++++++++++++++++------
 include/linux/energy_model.h      |  4 ++--
 kernel/power/energy_model.c       | 32 ++++++++++++++++++++++---------
 6 files changed, 92 insertions(+), 40 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 2ff7717530bf..743a0ac8ecdf 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -43,6 +43,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
+	struct em_perf_state *table;
 	struct cpumask cpus;
 	unsigned long freq;
 	u64 power;
@@ -51,19 +52,21 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
 	nr_cpus = cpumask_weight(&cpus);
 
+	table = pd->default_table->state;
+
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		power = pd->table[i].power * nr_cpus;
+		power = table[i].power * nr_cpus;
 
 		if (power > power_limit)
 			break;
 	}
 
-	freq = pd->table[i - 1].frequency;
+	freq = table[i - 1].frequency;
 
 	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power * nr_cpus;
+	power_limit = table[i - 1].power * nr_cpus;
 
 	return power_limit;
 }
@@ -88,12 +91,14 @@ static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
+	struct em_perf_state *table;
 	struct em_perf_domain *pd;
 	struct cpumask *pd_mask;
 	unsigned long freq;
 	int i;
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
+	table = pd->default_table->state;
 
 	pd_mask = em_span_cpus(pd);
 
@@ -101,10 +106,10 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		if (pd->table[i].frequency < freq)
+		if (table[i].frequency < freq)
 			continue;
 
-		return scale_pd_power_uw(pd_mask, pd->table[i].power *
+		return scale_pd_power_uw(pd_mask, table[i].power *
 					 MICROWATT_PER_MILLIWATT);
 	}
 
@@ -115,17 +120,20 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
+	struct em_perf_state *table;
 	struct cpumask cpus;
 	int nr_cpus;
 
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
 	nr_cpus = cpumask_weight(&cpus);
 
-	dtpm->power_min = em->table[0].power;
+	table = em->default_table->state;
+
+	dtpm->power_min = table[0].power;
 	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
 	dtpm->power_min *= nr_cpus;
 
-	dtpm->power_max = em->table[em->nr_perf_states - 1].power;
+	dtpm->power_max = table[em->nr_perf_states - 1].power;
 	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
 	dtpm->power_max *= nr_cpus;
 
@@ -182,6 +190,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 {
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
+	struct em_perf_state *table;
 	struct em_perf_domain *pd;
 	char name[CPUFREQ_NAME_LEN];
 	int ret = -ENOMEM;
@@ -198,6 +207,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	if (!pd || em_is_artificial(pd))
 		return -EINVAL;
 
+	table = pd->default_table->state;
+
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
 	if (!dtpm_cpu)
 		return -ENOMEM;
@@ -216,7 +227,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 
 	ret = freq_qos_add_request(&policy->constraints,
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
-				   pd->table[pd->nr_perf_states - 1].frequency);
+				   table[pd->nr_perf_states - 1].frequency);
 	if (ret)
 		goto out_dtpm_unregister;
 
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index 91276761a31d..6ef0f2b4a683 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -37,11 +37,14 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct devfreq *devfreq = dtpm_devfreq->devfreq;
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
+	struct em_perf_state *table;
 
-	dtpm->power_min = pd->table[0].power;
+	table = pd->default_table->state;
+
+	dtpm->power_min = table[0].power;
 	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
 
-	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
+	dtpm->power_max = table[pd->nr_perf_states - 1].power;
 	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
 
 	return 0;
@@ -53,22 +56,25 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	struct devfreq *devfreq = dtpm_devfreq->devfreq;
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
+	struct em_perf_state *table;
 	unsigned long freq;
 	u64 power;
 	int i;
 
+	table = pd->default_table->state;
+
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		power = table[i].power * MICROWATT_PER_MILLIWATT;
 		if (power > power_limit)
 			break;
 	}
 
-	freq = pd->table[i - 1].frequency;
+	freq = table[i - 1].frequency;
 
 	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
+	power_limit = table[i - 1].power * MICROWATT_PER_MILLIWATT;
 
 	return power_limit;
 }
@@ -94,6 +100,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
 	struct devfreq_dev_status status;
+	struct em_perf_state *table;
 	unsigned long freq;
 	u64 power;
 	int i;
@@ -102,15 +109,17 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	status = devfreq->last_status;
 	mutex_unlock(&devfreq->lock);
 
+	table = pd->default_table->state;
+
 	freq = DIV_ROUND_UP(status.current_frequency, HZ_PER_KHZ);
 	_normalize_load(&status);
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		if (pd->table[i].frequency < freq)
+		if (table[i].frequency < freq)
 			continue;
 
-		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		power = table[i].power * MICROWATT_PER_MILLIWATT;
 		power *= status.busy_time;
 		power >>= 10;
 
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9f8b438fcf8f..012ebaf6ea96 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -91,10 +91,11 @@ struct cpufreq_cooling_device {
 static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 			       unsigned int freq)
 {
+	struct em_perf_state *table = cpufreq_cdev->em->default_table->state;
 	int i;
 
 	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
-		if (freq > cpufreq_cdev->em->table[i].frequency)
+		if (freq > table[i].frequency)
 			break;
 	}
 
@@ -104,15 +105,16 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 freq)
 {
+	struct em_perf_state *table = cpufreq_cdev->em->default_table->state;
 	unsigned long power_mw;
 	int i;
 
 	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
-		if (freq > cpufreq_cdev->em->table[i].frequency)
+		if (freq > table[i].frequency)
 			break;
 	}
 
-	power_mw = cpufreq_cdev->em->table[i + 1].power;
+	power_mw = table[i + 1].power;
 	power_mw /= MICROWATT_PER_MILLIWATT;
 
 	return power_mw;
@@ -121,18 +123,19 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 power)
 {
+	struct em_perf_state *table = cpufreq_cdev->em->default_table->state;
 	unsigned long em_power_mw;
 	int i;
 
 	for (i = cpufreq_cdev->max_level; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
-		em_power_mw = cpufreq_cdev->em->table[i].power;
+		em_power_mw = table[i].power;
 		em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (power >= em_power_mw)
 			break;
 	}
 
-	return cpufreq_cdev->em->table[i].frequency;
+	return table[i].frequency;
 }
 
 /**
@@ -262,8 +265,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
 {
-	unsigned int freq, num_cpus, idx;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	unsigned int freq, num_cpus, idx;
+	struct em_perf_state *table;
 
 	/* Request state should be less than max_level */
 	if (state > cpufreq_cdev->max_level)
@@ -271,8 +275,9 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
+	table = cpufreq_cdev->em->default_table->state;
 	idx = cpufreq_cdev->max_level - state;
-	freq = cpufreq_cdev->em->table[idx].frequency;
+	freq = table[idx].frequency;
 	*power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 
 	return 0;
@@ -373,13 +378,15 @@ static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 				   unsigned long state)
 {
 	struct cpufreq_policy *policy;
+	struct em_perf_state *table;
 	unsigned long idx;
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	/* Use the Energy Model table if available */
 	if (cpufreq_cdev->em) {
+		table = cpufreq_cdev->em->default_table->state;
 		idx = cpufreq_cdev->max_level - state;
-		return cpufreq_cdev->em->table[idx].frequency;
+		return table[idx].frequency;
 	}
 #endif
 
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 24b474925cd6..01187a5848ac 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -87,6 +87,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
+	struct em_perf_state *table;
 	unsigned long freq;
 	int perf_idx;
 
@@ -99,8 +100,9 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 		return -EINVAL;
 
 	if (dfc->em_pd) {
+		table = dfc->em_pd->default_table->state;
 		perf_idx = dfc->max_state - state;
-		freq = dfc->em_pd->table[perf_idx].frequency * 1000;
+		freq = table[perf_idx].frequency * 1000;
 	} else {
 		freq = dfc->freq_table[state];
 	}
@@ -123,10 +125,11 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
  */
 static int get_perf_idx(struct em_perf_domain *em_pd, unsigned long freq)
 {
+	struct em_perf_state *table = em_pd->default_table->state;
 	int i;
 
 	for (i = 0; i < em_pd->nr_perf_states; i++) {
-		if (em_pd->table[i].frequency == freq)
+		if (table[i].frequency == freq)
 			return i;
 	}
 
@@ -181,6 +184,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct devfreq_dev_status status;
+	struct em_perf_state *table;
 	unsigned long state;
 	unsigned long freq;
 	unsigned long voltage;
@@ -192,6 +196,8 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 
 	freq = status.current_frequency;
 
+	table = dfc->em_pd->default_table->state;
+
 	if (dfc->power_ops && dfc->power_ops->get_real_power) {
 		voltage = get_voltage(df, freq);
 		if (voltage == 0) {
@@ -204,7 +210,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 			state = dfc->capped_state;
 
 			/* Convert EM power into milli-Watts first */
-			dfc->res_util = dfc->em_pd->table[state].power;
+			dfc->res_util = table[state].power;
 			dfc->res_util /= MICROWATT_PER_MILLIWATT;
 
 			dfc->res_util *= SCALE_ERROR_MITIGATION;
@@ -225,7 +231,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		_normalize_load(&status);
 
 		/* Convert EM power into milli-Watts first */
-		*power = dfc->em_pd->table[perf_idx].power;
+		*power = table[perf_idx].power;
 		*power /= MICROWATT_PER_MILLIWATT;
 		/* Scale power for utilization */
 		*power *= status.busy_time;
@@ -245,13 +251,15 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 				       unsigned long state, u32 *power)
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
+	struct em_perf_state *table;
 	int perf_idx;
 
 	if (state > dfc->max_state)
 		return -EINVAL;
 
+	table = dfc->em_pd->default_table->state;
 	perf_idx = dfc->max_state - state;
-	*power = dfc->em_pd->table[perf_idx].power;
+	*power = table[perf_idx].power;
 	*power /= MICROWATT_PER_MILLIWATT;
 
 	return 0;
@@ -264,6 +272,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	struct devfreq *df = dfc->devfreq;
 	struct devfreq_dev_status status;
 	unsigned long freq, em_power_mw;
+	struct em_perf_state *table;
 	s32 est_power;
 	int i;
 
@@ -273,6 +282,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 
 	freq = status.current_frequency;
 
+	table = dfc->em_pd->default_table->state;
+
 	if (dfc->power_ops && dfc->power_ops->get_real_power) {
 		/* Scale for resource utilization */
 		est_power = power * dfc->res_util;
@@ -290,7 +301,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	 */
 	for (i = dfc->max_state; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
-		em_power_mw = dfc->em_pd->table[i].power;
+		em_power_mw = table[i].power;
 		em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (est_power >= em_power_mw)
 			break;
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b8506df9af2d..eb28920b1b2c 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -49,7 +49,7 @@ struct em_perf_table {
 
 /**
  * struct em_perf_domain - Performance domain
- * @table:		List of performance states, in ascending order
+ * @default_table:	Pointer to the default em_perf_table
  * @runtime_table:	Pointer to the runtime modified em_perf_table
  * @nr_perf_states:	Number of performance states
  * @flags:		See "em_perf_domain flags"
@@ -65,7 +65,7 @@ struct em_perf_table {
  * field is unused.
  */
 struct em_perf_domain {
-	struct em_perf_state *table;
+	struct em_perf_table *default_table;
 	struct em_perf_table __rcu *runtime_table;
 	int nr_perf_states;
 	unsigned long flags;
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 4fcc3b9d63e0..e981be27d2d4 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -72,6 +72,7 @@ DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
 
 static void em_debug_create_pd(struct device *dev)
 {
+	struct em_perf_table *table = dev->em_pd->default_table;
 	struct dentry *d;
 	int i;
 
@@ -87,7 +88,7 @@ static void em_debug_create_pd(struct device *dev)
 
 	/* Create a sub-directory for each performance state */
 	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
-		em_debug_create_ps(&dev->em_pd->table[i], d);
+		em_debug_create_ps(&table->state[i], d);
 
 }
 
@@ -160,7 +161,7 @@ static void em_perf_runtime_table_set(struct device *dev,
 	 * Check if the 'state' array is not actually the one from setup.
 	 * If it is then don't free it.
 	 */
-	if (tmp->state == pd->table)
+	if (tmp->state == pd->default_table->state)
 		call_rcu(&tmp->rcu, em_destroy_tmp_setup_rcu);
 	else
 		call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
@@ -264,7 +265,7 @@ int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
 
 	/* Populate runtime table with updated values using driver callback */
 	for (i = 0; i < pd->nr_perf_states; i++) {
-		freq = pd->table[i].frequency;
+		freq = pd->default_table->state[i].frequency;
 		runtime_table->state[i].frequency = freq;
 
 		/*
@@ -355,7 +356,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 	if (ret)
 		goto free_ps_table;
 
-	pd->table = table;
+	pd->default_table->state = table;
 	pd->nr_perf_states = nr_states;
 
 	return 0;
@@ -369,7 +370,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus,
 			unsigned long flags)
 {
-	struct em_perf_table *runtime_table;
+	struct em_perf_table *default_table, *runtime_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -394,21 +395,31 @@ static int em_create_pd(struct device *dev, int nr_states,
 			return -ENOMEM;
 	}
 
+	default_table = kzalloc(sizeof(*default_table), GFP_KERNEL);
+	if (!default_table) {
+		kfree(pd);
+		return -ENOMEM;
+	}
+
 	runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
 	if (!runtime_table) {
 		kfree(pd);
+		kfree(default_table);
 		return -ENOMEM;
 	}
 
+	pd->default_table = default_table;
+
 	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
 	if (ret) {
 		kfree(pd);
+		kfree(default_table);
 		kfree(runtime_table);
 		return ret;
 	}
 
 	/* Re-use temporally (till 1st modification) the memory */
-	runtime_table->state = pd->table;
+	runtime_table->state = pd->default_table->state;
 	rcu_assign_pointer(pd->runtime_table, runtime_table);
 
 	if (_is_cpu_device(dev))
@@ -529,6 +540,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				bool microwatts)
 {
 	unsigned long cap, prev_cap = 0;
+	struct em_perf_state *table;
 	unsigned long flags = 0;
 	int cpu, ret;
 
@@ -587,7 +599,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
+	table = dev->em_pd->default_table->state;
+	em_cpufreq_update_efficiencies(dev, table);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
@@ -641,12 +654,13 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	 * After the sync no updates will be in-flight, so free the old
 	 * memory.
 	 */
-	if (tmp->state != pd->table)
+	if (tmp->state != pd->default_table->state)
 		kfree(tmp->state);
 
 	kfree(tmp);
 
-	kfree(dev->em_pd->table);
+	kfree(pd->default_table->state);
+	kfree(pd->default_table);
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
 	mutex_unlock(&em_pd_mutex);
-- 
2.17.1

