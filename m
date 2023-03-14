Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA66B9038
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCNKgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCNKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:36:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94F8A30184;
        Tue, 14 Mar 2023 03:35:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7089B16A3;
        Tue, 14 Mar 2023 03:35:22 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB0CA3F71A;
        Tue, 14 Mar 2023 03:34:35 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 08/17] PM: EM: Introduce runtime modifiable table
Date:   Tue, 14 Mar 2023 10:33:48 +0000
Message-Id: <20230314103357.26010-9-lukasz.luba@arm.com>
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

This patch introduces the new feature: modifiable EM perf_state table.
The new runtime table would be populated with a new power data to better
reflect the actual power. The power can vary over time e.g. due to the
SoC temperature change. Higher temperature can increase power values.
For longer running scenarios, such as game or camera, when also other
devices are used (e.g. GPU, ISP) the CPU power can change. The new
EM framework is able to addresses this issue and change the data
at runtime safely. The runtime modifiable EM data is used by the Energy
Aware Scheduler (EAS) for the task placement.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 13 +++++++++++++
 kernel/power/energy_model.c  | 24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index cc2bf607191e..a616006a8130 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -36,9 +36,21 @@ struct em_perf_state {
  */
 #define EM_PERF_STATE_INEFFICIENT BIT(0)
 
+/**
+ * struct em_perf_table - Performance states table, which can be
+ *		runtime modifiable and protected with RCU
+ * @state:	List of performance states, in ascending order
+ * @rcu:	RCU used for safe access and destruction
+ */
+struct em_perf_table {
+	struct em_perf_state *state;
+	struct rcu_head rcu;
+};
+
 /**
  * struct em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
+ * @runtime_table:	Pointer to the runtime modified em_perf_table
  * @nr_perf_states:	Number of performance states
  * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
@@ -54,6 +66,7 @@ struct em_perf_state {
  */
 struct em_perf_domain {
 	struct em_perf_state *table;
+	struct em_perf_table __rcu *runtime_table;
 	int nr_perf_states;
 	unsigned long flags;
 	unsigned long cpus[];
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 230310709e2a..500b9cf26ba8 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -216,6 +216,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus,
 			unsigned long flags)
 {
+	struct em_perf_table *runtime_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -240,12 +241,23 @@ static int em_create_pd(struct device *dev, int nr_states,
 			return -ENOMEM;
 	}
 
+	runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
+	if (!runtime_table) {
+		kfree(pd);
+		return -ENOMEM;
+	}
+
 	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
 	if (ret) {
 		kfree(pd);
+		kfree(runtime_table);
 		return ret;
 	}
 
+	/* Re-use temporally (till 1st modification) the memory */
+	runtime_table->state = pd->table;
+	rcu_assign_pointer(pd->runtime_table, runtime_table);
+
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
 			cpu_dev = get_cpu_device(cpu);
@@ -441,20 +453,32 @@ EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
  */
 void em_dev_unregister_perf_domain(struct device *dev)
 {
+	struct em_perf_domain *pd;
+	struct em_perf_table *tmp;
+
 	if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
 		return;
 
 	if (_is_cpu_device(dev))
 		return;
 
+	pd = dev->em_pd;
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
 	 * The debugfs directory name is the same as device's name.
 	 */
 	mutex_lock(&em_pd_mutex);
+
 	em_debug_remove_pd(dev);
 
+	tmp = pd->runtime_table;
+
+	rcu_assign_pointer(pd->runtime_table, NULL);
+	synchronize_rcu();
+
+	kfree(tmp);
+
 	kfree(dev->em_pd->table);
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
-- 
2.17.1

