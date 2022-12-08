Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0386473D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLHQDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLHQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:03:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D00C9E469;
        Thu,  8 Dec 2022 08:03:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6E8823A;
        Thu,  8 Dec 2022 08:03:47 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39AAE3F73D;
        Thu,  8 Dec 2022 08:03:38 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        saravanak@google.com, wusamuel@google.com,
        isaacmanjarres@google.com, kernel-team@android.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: [PATCH v3 1/1] cpufreq: schedutil: Optimize operations with single CPU capacity lookup
Date:   Thu,  8 Dec 2022 16:02:56 +0000
Message-Id: <20221208160256.859-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221208160256.859-1-lukasz.luba@arm.com>
References: <20221208160256.859-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max CPU capacity is the same for all CPUs sharing frequency domain.
There is a way to avoid heavy operations in a loop for each CPU by
leveraging this knowledge. Thus, simplify the looping code in the
sugov_next_freq_shared() and drop heavy multiplications. Instead, use
simple max() to get the highest utilization from these CPUs.

This is useful for platforms with many (4 or 6) little CPUs. We avoid
heavy 2*PD_CPU_NUM multiplications in that loop, which is called billions
of times, since it's not limited by the schedutil time delta filter in
sugov_should_update_freq(). When there was no need to change frequency
the code bailed out, not updating the sg_policy::last_freq_update_time.
Then every visit after delta_ns time longer than the
sg_policy::freq_update_delay_ns goes through and triggers the next
frequency calculation code. Although, if the next frequency, as outcome
of that, would be the same as current frequency, we won't update the
sg_policy::last_freq_update_time and the story will be repeated (in
a very short period, sometimes a few microseconds).

The max CPU capacity must be fetched every time we are called, due to
difficulties during the policy setup, where we are not able to get the
normalized CPU capacity at the right time.

The fetched CPU capacity value is than used in sugov_iowait_apply() to
calculate the right boost. This required a few changes in the local
functions and arguments. The capacity value should hopefully be fetched
once when needed and then passed over CPU registers to those functions.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 43 +++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1207c78f85c1..5c840151f3bb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -48,7 +48,6 @@ struct sugov_cpu {
 
 	unsigned long		util;
 	unsigned long		bw_dl;
-	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -158,7 +157,6 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
@@ -238,6 +236,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * sugov_iowait_apply() - Apply the IO boost to a CPU.
  * @sg_cpu: the sugov data for the cpu to boost
  * @time: the update time from the caller
+ * @max_cap: the max CPU capacity
  *
  * A CPU running a task which woken up after an IO operation can have its
  * utilization boosted to speed up the completion of those IO operations.
@@ -251,7 +250,8 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * This mechanism is designed to boost high frequently IO waiting tasks, while
  * being more conservative on tasks which does sporadic IO operations.
  */
-static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
+static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
+			       unsigned long max_cap)
 {
 	unsigned long boost;
 
@@ -280,7 +280,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
+	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
 	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
 	if (sg_cpu->util < boost)
 		sg_cpu->util = boost;
@@ -310,7 +310,8 @@ static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
-					      u64 time, unsigned int flags)
+					      u64 time, unsigned long max_cap,
+					      unsigned int flags)
 {
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -321,7 +322,7 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 		return false;
 
 	sugov_get_util(sg_cpu);
-	sugov_iowait_apply(sg_cpu, time);
+	sugov_iowait_apply(sg_cpu, time, max_cap);
 
 	return true;
 }
@@ -332,12 +333,15 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned int cached_freq = sg_policy->cached_raw_freq;
+	unsigned long max_cap;
 	unsigned int next_f;
 
-	if (!sugov_update_single_common(sg_cpu, time, flags))
+	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
+
+	if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
 		return;
 
-	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
+	next_f = get_next_freq(sg_policy, sg_cpu->util, max_cap);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -374,6 +378,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	unsigned long prev_util = sg_cpu->util;
+	unsigned long max_cap;
 
 	/*
 	 * Fall back to the "frequency" path if frequency invariance is not
@@ -385,7 +390,9 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		return;
 	}
 
-	if (!sugov_update_single_common(sg_cpu, time, flags))
+	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
+
+	if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
 		return;
 
 	/*
@@ -399,7 +406,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), sg_cpu->max);
+				   map_util_perf(sg_cpu->util), max_cap);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
@@ -408,25 +415,21 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned long util = 0, max = 1;
+	unsigned long util = 0, max_cap;
 	unsigned int j;
 
+	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
+
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
-		unsigned long j_util, j_max;
 
 		sugov_get_util(j_sg_cpu);
-		sugov_iowait_apply(j_sg_cpu, time);
-		j_util = j_sg_cpu->util;
-		j_max = j_sg_cpu->max;
+		sugov_iowait_apply(j_sg_cpu, time, max_cap);
 
-		if (j_util * max > j_max * util) {
-			util = j_util;
-			max = j_max;
-		}
+		util = max(j_sg_cpu->util, util);
 	}
 
-	return get_next_freq(sg_policy, util, max);
+	return get_next_freq(sg_policy, util, max_cap);
 }
 
 static void
-- 
2.17.1

