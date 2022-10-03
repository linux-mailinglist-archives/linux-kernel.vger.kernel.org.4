Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321805F322A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJCOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJCOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:50:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE9F167C2;
        Mon,  3 Oct 2022 07:50:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C4016F8;
        Mon,  3 Oct 2022 07:50:09 -0700 (PDT)
Received: from e126311.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3123F73B;
        Mon,  3 Oct 2022 07:50:01 -0700 (PDT)
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/1] cpuidle: teo: Introduce optional util-awareness
Date:   Mon,  3 Oct 2022 15:49:14 +0100
Message-Id: <20221003144914.160547-2-kajetan.puchalski@arm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221003144914.160547-1-kajetan.puchalski@arm.com>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern interactive systems, such as recent Android phones, tend to have
power efficient shallow idle states. Selecting deeper idle states on a
device while a latency-sensitive workload is running can adversely impact
performance due to increased latency. Additionally, if the CPU wakes up
from a deeper sleep before its target residency as is often the case, it
results in a waste of energy on top of that.

This patch extends the TEO governor with an optional mechanism adding
util-awareness, effectively providing a way for the governor to reduce
the selected idle state by 1 when the CPU is being utilized over a certain
threshold while still trying to select the deepest possible state using
TEO's metrics when the CPU is not being utilized. This is now possible
since the CPU utilization is exported from the scheduler with the
sched_cpu_util function and already used e.g. in the thermal governor IPA.

This can provide drastically decreased latency and performance benefits in
certain types of mobile workloads that are sensitive to latency,
such as Geekbench 5.

Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
---
 drivers/cpuidle/Kconfig         | 12 +++++
 drivers/cpuidle/governors/teo.c | 96 ++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index ff71dd662880..1ee57a2101a0 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -33,6 +33,18 @@ config CPU_IDLE_GOV_TEO
 	  Some workloads benefit from using it and it generally should be safe
 	  to use.  Say Y here if you are not happy with the alternatives.
 
+config CPU_IDLE_GOV_TEO_UTIL_AWARE
+	bool "Util-awareness mechanism for TEO"
+	depends on CPU_IDLE_GOV_TEO
+	help
+	  Util-awareness mechanism for the TEO governor. With this enabled,
+	  the governor will reduce the selected state by 1 when the
+	  CPU's average util is above a certain threshold and default to
+	  fully using the metrics-based approach when it's not.
+
+	  Some latency-sensitive workloads on interactive devices can benefit
+	  from using it.
+
 config CPU_IDLE_GOV_HALTPOLL
 	bool "Haltpoll governor (for virtualized systems)"
 	depends on KVM_GUEST
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index d9262db79cae..2c35c744c3f1 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -2,8 +2,13 @@
 /*
  * Timer events oriented CPU idle governor
  *
+ * TEO governor:
  * Copyright (C) 2018 - 2021 Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * Util-awareness mechanism:
+ * Copyright (C) 2022 Arm Ltd.
+ * Author: Kajetan Puchalski <kajetan.puchalski@arm.com>
  */
 
 /**
@@ -99,14 +104,49 @@
  *      select the given idle state instead of the candidate one.
  *
  * 3. By default, select the candidate state.
+ *
+ * Util-awareness mechanism:
+ *
+ * The idea behind the util-awareness extension is that there are two distinct
+ * scenarios for the CPU which should result in two different approaches to idle
+ * state selection - utilized and not utilized.
+ *
+ * In this case, 'utilized' means that the average runqueue util of the CPU is
+ * above a certain threshold.
+ *
+ * When the CPU is utilized while going into idle, more likely than not it will
+ * be woken up to do more work soon and so a shallower idle state should be
+ * selected to minimise latency and maximise performance. When the CPU is not
+ * being utilized, the usual metrics-based approach to selecting the deepest
+ * available idle state should be preferred to take advantage of the power
+ * saving.
+ *
+ * In order to achieve this, the governor uses a utilization threshold.
+ * The threshold is computed per-cpu as a percentage of the CPU's capacity
+ * by bit shifting the capacity value. Based on testing, the shift of 6 (~1.56%)
+ * seems to be getting the best results.
+ *
+ * Before selecting the next idle state, the governor compares the current CPU
+ * util to the precomputed util threshold. If it's below, it defaults to the
+ * TEO metrics mechanism. If it's above, the idle state selected based on the
+ * metrics will be reduced by 1 whenever possible.
  */
 
 #include <linux/cpuidle.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/topology.h>
 #include <linux/tick.h>
 
+/*
+ * The number of bits to shift the cpu's capacity by in order to determine
+ * the utilized threshold
+ */
+#define UTIL_THRESHOLD_SHIFT 6
+
+
 /*
  * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
  * is used for decreasing metrics on a regular basis.
@@ -137,9 +177,11 @@ struct teo_bin {
  * @time_span_ns: Time between idle state selection and post-wakeup update.
  * @sleep_length_ns: Time till the closest timer event (at the selection time).
  * @state_bins: Idle state data bins for this CPU.
- * @total: Grand total of the "intercepts" and "hits" mertics for all bins.
+ * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
  * @next_recent_idx: Index of the next @recent_idx entry to update.
  * @recent_idx: Indices of bins corresponding to recent "intercepts".
+ * @util_threshold: Threshold above which the CPU is considered utilized
+ * @utilized: Whether the last sleep on the CPU happened while utilized
  */
 struct teo_cpu {
 	s64 time_span_ns;
@@ -148,10 +190,28 @@ struct teo_cpu {
 	unsigned int total;
 	int next_recent_idx;
 	int recent_idx[NR_RECENT];
+#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
+	unsigned long util_threshold;
+	bool utilized;
+#endif
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
 
+#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
+/**
+ * teo_get_util - Update the CPU utilized status
+ * @dev: Target CPU
+ * @cpu_data: Governor CPU data for the target CPU
+ */
+static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
+{
+	unsigned long util = sched_cpu_util(dev->cpu);
+
+	cpu_data->utilized = util > cpu_data->util_threshold;
+}
+#endif
+
 /**
  * teo_update - Update CPU metrics after wakeup.
  * @drv: cpuidle driver containing state data.
@@ -301,7 +361,13 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	int i;
 
 	if (dev->last_state_idx >= 0) {
+#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
+		/* don't update metrics if the cpu was utilized during the last sleep */
+		if (!cpu_data->utilized)
+			teo_update(drv, dev);
+#else
 		teo_update(drv, dev);
+#endif
 		dev->last_state_idx = -1;
 	}
 
@@ -321,6 +387,22 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			goto end;
 	}
 
+#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
+	teo_get_util(dev, cpu_data);
+	/* the cpu is being utilized and there's only 2 states to choose from */
+	/* no need to consider metrics, choose the shallowest state and exit */
+	if (drv->state_count < 3 && cpu_data->utilized) {
+		for (i = 0; i < drv->state_count; ++i) {
+			if (dev->states_usage[i].disable)
+				continue;
+			break;
+		}
+
+		idx = i;
+		goto end;
+	}
+#endif
+
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
 	 * the current sleep length and the deepest idle state not deeper than
@@ -452,6 +534,12 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (idx > constraint_idx)
 		idx = constraint_idx;
 
+#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
+	/* choose a shallower state to improve latency when the CPU is utilized */
+	if (cpu_data->utilized && idx > 0 && !dev->states_usage[idx-1].disable)
+		idx--;
+#endif
+
 end:
 	/*
 	 * Don't stop the tick if the selected state is a polling one or if the
@@ -508,9 +596,15 @@ static int teo_enable_device(struct cpuidle_driver *drv,
 			     struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
+	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
+#endif
 	int i;
 
 	memset(cpu_data, 0, sizeof(*cpu_data));
+#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
+	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
+#endif
 
 	for (i = 0; i < NR_RECENT; i++)
 		cpu_data->recent_idx[i] = -1;
-- 
2.37.1

