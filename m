Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD086B9031
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCNKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCNKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:36:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AD0B85B2D;
        Tue, 14 Mar 2023 03:35:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9243316F2;
        Tue, 14 Mar 2023 03:35:25 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B8A23F71A;
        Tue, 14 Mar 2023 03:34:38 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 09/17] PM: EM: Add RCU mechanism which safely cleans the old data
Date:   Tue, 14 Mar 2023 10:33:49 +0000
Message-Id: <20230314103357.26010-10-lukasz.luba@arm.com>
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

The EM is going to support runtime modifications of the power data.
In order to achieve that prepare the internal mechanism. This patch
introduces RCU safe mechanism to clean up the old allocated EM data.
It also adds a mutex for the EM structure to serialize the modifiers.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 500b9cf26ba8..87962b877376 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -26,6 +26,9 @@
  */
 static DEFINE_MUTEX(em_pd_mutex);
 
+static void em_cpufreq_update_efficiencies(struct device *dev,
+					   struct em_perf_state *table);
+
 static bool _is_cpu_device(struct device *dev)
 {
 	return (dev->bus == &cpu_subsys);
@@ -109,6 +112,60 @@ static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
 #endif
 
+static void em_destroy_rt_table_rcu(struct rcu_head *rp)
+{
+	struct em_perf_table *runtime_table;
+
+	runtime_table = container_of(rp, struct em_perf_table, rcu);
+	kfree(runtime_table->state);
+	kfree(runtime_table);
+}
+
+static void em_destroy_tmp_setup_rcu(struct rcu_head *rp)
+{
+	struct em_perf_table *runtime_table;
+
+	runtime_table = container_of(rp, struct em_perf_table, rcu);
+	kfree(runtime_table);
+}
+
+static void em_perf_runtime_table_set(struct device *dev,
+				      struct em_perf_table *runtime_table)
+{
+	struct em_perf_domain *pd = dev->em_pd;
+	struct em_perf_table *tmp;
+
+	tmp = pd->runtime_table;
+
+	rcu_assign_pointer(pd->runtime_table, runtime_table);
+
+	em_cpufreq_update_efficiencies(dev, runtime_table->state);
+
+	if (trace_em_perf_state_enabled()) {
+		unsigned long freq, power, cost, flags;
+		int i;
+
+		for (i = 0; i < pd->nr_perf_states; i++) {
+			freq = runtime_table->state[i].frequency;
+			power = runtime_table->state[i].power;
+			cost = runtime_table->state[i].cost;
+			flags = runtime_table->state[i].flags;
+
+			trace_em_perf_state(dev_name(dev), pd->nr_perf_states,
+					    i, freq, power, cost, flags);
+		}
+	}
+
+	/*
+	 * Check if the 'state' array is not actually the one from setup.
+	 * If it is then don't free it.
+	 */
+	if (tmp->state == pd->table)
+		call_rcu(&tmp->rcu, em_destroy_tmp_setup_rcu);
+	else
+		call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
+}
+
 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    struct em_data_callback *cb, int nr_states,
 			    unsigned long flags)
-- 
2.17.1

