Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B090700486
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbjELJ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbjELJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:58:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C227E1157E;
        Fri, 12 May 2023 02:58:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24F9C169E;
        Fri, 12 May 2023 02:59:12 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB8E33F5A1;
        Fri, 12 May 2023 02:58:24 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 10/17] PM: EM: Add runtime update interface to modify EM power
Date:   Fri, 12 May 2023 10:57:36 +0100
Message-Id: <20230512095743.3393563-11-lukasz.luba@arm.com>
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

Add an interface which allows to modify EM power data at runtime.
The new power information is populated by the provided callback, which
is called for each performance state. The CPU frequencies' efficiency is
re-calculated since that might be affected as well. The old EM memory
is going to be freed later using RCU mechanism.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |   8 +++
 kernel/power/energy_model.c  | 109 +++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index a616006a8130..e1772aa6c843 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -202,6 +202,8 @@ struct em_data_callback {
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
+int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
+			      void *priv);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
@@ -382,6 +384,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 {
 	return 0;
 }
+static inline
+int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
+			      void *priv)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index bc9b7dec0763..b5675dda00e1 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -202,6 +202,101 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	return 0;
 }
 
+/**
+ * em_dev_update_perf_domain() - Update run-time EM table for a device
+ * @dev		: Device for which the EM is to be updated
+ * @cb		: Callback function providing the power data for the EM
+ * @priv	: Pointer to private data useful for passing context
+ *		which might be required while calling @cb
+ *
+ * Update EM run-time modifiable table for a @dev using the callback
+ * defined in @cb. The EM new power values are then used for calculating
+ * the em_perf_state::cost for associated performance state.
+ *
+ * This function uses mutex to serialize writers, so it must not be called
+ * from non-sleeping context.
+ *
+ * Return 0 on success or a proper error in case of failure.
+ */
+int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
+			      void *priv)
+{
+	struct em_perf_table *runtime_table;
+	unsigned long power, freq;
+	struct em_perf_domain *pd;
+	int ret, i;
+
+	if (!cb || !cb->update_power)
+		return -EINVAL;
+
+	/*
+	 * The lock serializes update and unregister code paths. When the
+	 * EM has been unregistered in the meantime, we should capture that
+	 * when entering this critical section. It also makes sure that
+	 * two concurrent updates will be serialized.
+	 */
+	mutex_lock(&em_pd_mutex);
+
+	if (!dev || !dev->em_pd) {
+		ret = -EINVAL;
+		goto unlock_em;
+	}
+
+	pd = dev->em_pd;
+
+	runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
+	if (!runtime_table) {
+		ret = -ENOMEM;
+		goto unlock_em;
+	}
+
+	runtime_table->state = kcalloc(pd->nr_perf_states,
+				       sizeof(struct em_perf_state),
+				       GFP_KERNEL);
+	if (!runtime_table->state) {
+		ret = -ENOMEM;
+		goto free_runtime_table;
+	}
+
+	/* Populate runtime table with updated values using driver callback */
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		freq = pd->table[i].frequency;
+		runtime_table->state[i].frequency = freq;
+
+		/*
+		 * Call driver callback to get a new power value for
+		 * a given frequency.
+		 */
+		ret = cb->update_power(dev, freq, &power, priv);
+		if (ret) {
+			dev_dbg(dev, "EM: run-time update error: %d\n", ret);
+			goto free_runtime_state_table;
+		}
+
+		runtime_table->state[i].power = power;
+	}
+
+	ret = em_compute_costs(dev, runtime_table->state, cb,
+			       pd->nr_perf_states, pd->flags);
+	if (ret)
+		goto free_runtime_state_table;
+
+	em_perf_runtime_table_set(dev, runtime_table);
+
+	mutex_unlock(&em_pd_mutex);
+	return 0;
+
+free_runtime_state_table:
+	kfree(runtime_table->state);
+free_runtime_table:
+	kfree(runtime_table);
+unlock_em:
+	mutex_unlock(&em_pd_mutex);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
+
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				int nr_states, struct em_data_callback *cb,
 				unsigned long flags)
@@ -521,6 +616,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
 	 * The debugfs directory name is the same as device's name.
+	 * The lock also protects the updater of the runtime modifiable
+	 * EM and this remover.
 	 */
 	mutex_lock(&em_pd_mutex);
 
@@ -528,9 +625,21 @@ void em_dev_unregister_perf_domain(struct device *dev)
 
 	tmp = pd->runtime_table;
 
+	/*
+	 * Safely destroy runtime modifiable EM. By using the call
+	 * synchronize_rcu() we make sure we don't progress till last user
+	 * finished the RCU section and our update got applied.
+	 */
 	rcu_assign_pointer(pd->runtime_table, NULL);
 	synchronize_rcu();
 
+	/*
+	 * After the sync no updates will be in-flight, so free the old
+	 * memory.
+	 */
+	if (tmp->state != pd->table)
+		kfree(tmp->state);
+
 	kfree(tmp);
 
 	kfree(dev->em_pd->table);
-- 
2.25.1

