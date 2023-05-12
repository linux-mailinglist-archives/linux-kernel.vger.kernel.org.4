Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53584700489
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbjELJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbjELJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:59:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D00551208E;
        Fri, 12 May 2023 02:58:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 182EC16A3;
        Fri, 12 May 2023 02:59:18 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF6D93F5A1;
        Fri, 12 May 2023 02:58:30 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 12/17] PM: EM: Add argument to get_cost() for runtime modification
Date:   Fri, 12 May 2023 10:57:38 +0100
Message-Id: <20230512095743.3393563-13-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) supports runtime modifications. Let also the
artificial EM use this new feature and allow to update the 'cost' values
at runtime. When the artificial EM is used there is a need to provide
two callbacks: get_cost() and update_power(), not only the last one.

Update also CPPC driver code, since the new argument is needed there
to compile properly and register EM.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 include/linux/energy_model.h   | 7 ++++++-
 kernel/power/energy_model.c    | 9 +++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..f5353c10552b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -574,7 +574,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 }
 
 static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
-		unsigned long *cost)
+		unsigned long *cost, void *priv)
 {
 	unsigned long perf_step, perf_prev;
 	struct cppc_perf_caps *perf_caps;
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8e3fa2b6bf28..b8506df9af2d 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -162,6 +162,8 @@ struct em_data_callback {
 	 * @freq	: Frequency at the performance state in kHz
 	 * @cost	: The cost value for the performance state
 	 *		(modified)
+	 * @priv	: Pointer to private data useful for tracking context
+	 *		during run-time modifications of EM.
 	 *
 	 * In case of CPUs, the cost is the one of a single CPU in the domain.
 	 * It is expected to fit in the [0, EM_MAX_POWER] range due to internal
@@ -170,7 +172,7 @@ struct em_data_callback {
 	 * Return 0 on success, or appropriate error value in case of failure.
 	 */
 	int (*get_cost)(struct device *dev, unsigned long freq,
-			unsigned long *cost);
+			unsigned long *cost, void *priv);
 
 	/**
 	 * update_power() - Provide new power at the given performance state of
@@ -199,6 +201,9 @@ struct em_data_callback {
 #define EM_DATA_CB(_active_power_cb)			\
 		EM_ADV_DATA_CB(_active_power_cb, NULL)
 #define EM_UPDATE_CB(_update_power_cb) { .update_power = &_update_power_cb }
+#define EM_ADV_UPDATE_CB(_update_power_cb, _cost_cb)	\
+	{ .update_power = &_update_power_cb,		\
+	  .get_cost = _cost_cb }
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index b5675dda00e1..456d9f2b4370 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -165,7 +165,7 @@ static void em_perf_runtime_table_set(struct device *dev,
 
 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    struct em_data_callback *cb, int nr_states,
-			    unsigned long flags)
+			    unsigned long flags, void *priv)
 {
 	unsigned long prev_cost = ULONG_MAX;
 	u64 fmax;
@@ -177,7 +177,8 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 		unsigned long power_res, cost;
 
 		if (flags & EM_PERF_DOMAIN_ARTIFICIAL && cb->get_cost) {
-			ret = cb->get_cost(dev, table[i].frequency, &cost);
+			ret = cb->get_cost(dev, table[i].frequency, &cost,
+					   priv);
 			if (ret || !cost || cost > EM_MAX_POWER) {
 				dev_err(dev, "EM: invalid cost %lu %d\n",
 					cost, ret);
@@ -277,7 +278,7 @@ int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
 	}
 
 	ret = em_compute_costs(dev, runtime_table->state, cb,
-			       pd->nr_perf_states, pd->flags);
+			       pd->nr_perf_states, pd->flags, priv);
 	if (ret)
 		goto free_runtime_state_table;
 
@@ -347,7 +348,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		table[i].frequency = prev_freq = freq;
 	}
 
-	ret = em_compute_costs(dev, table, cb, nr_states, flags);
+	ret = em_compute_costs(dev, table, cb, nr_states, flags, NULL);
 	if (ret)
 		goto free_ps_table;
 
-- 
2.25.1

