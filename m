Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE7700485
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbjELJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbjELJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:58:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B848C10A3B;
        Fri, 12 May 2023 02:58:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B002169C;
        Fri, 12 May 2023 02:59:09 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0F013F5A1;
        Fri, 12 May 2023 02:58:21 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 09/17] PM: EM: Add RCU mechanism which safely cleans the old data
Date:   Fri, 12 May 2023 10:57:35 +0100
Message-Id: <20230512095743.3393563-10-lukasz.luba@arm.com>
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

The EM is going to support runtime modifications of the power data.
In order to achieve that prepare the internal mechanism. This patch
introduces RCU safe mechanism to clean up the old allocated EM data.
It also adds a mutex for the EM structure to serialize the modifiers.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 39d47028ef3d..bc9b7dec0763 100644
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
@@ -106,6 +109,60 @@ static void em_debug_create_pd(struct device *dev) {}
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
2.25.1

