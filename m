Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9126644110
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiLFKNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiLFKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:13:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 014A2275F6;
        Tue,  6 Dec 2022 02:10:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77F323A;
        Tue,  6 Dec 2022 02:10:56 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.7.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A7743F73B;
        Tue,  6 Dec 2022 02:10:46 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        saravanak@google.com, wusamuel@google.com,
        isaacmanjarres@google.com, kernel-team@android.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: [PATCH] cpufreq: schedutil: Optimize operations with single max CPU capacity
Date:   Tue,  6 Dec 2022 10:10:21 +0000
Message-Id: <20221206101021.18113-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max CPU capacity is the same for all CPUs sharing frequency domain
and thus 'policy' object. There is a way to avoid heavy operations
in a loop for each CPU by leveraging this knowledge. Thus, simplify
the looping code in the sugov_next_freq_shared() and drop heavy
multiplications. Instead, use simple max() to get the highest utilization
from these CPUs. This is useful for platforms with many (4 or 6) little
CPUs.

The max CPU capacity must be fetched every time we are called, due to
difficulties during the policy setup, where we are not able to get the
normalized CPU capacity at the right time.

The stored value in sugov_policy::max is also than used in
sugov_iowait_apply() to calculate the right boost. Thus, that field is
useful to have in that sugov_policy struct.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

Hi all,

This is a different approach for the optimization of the looping,
fetching and multiplying the CPUs capacity (which is the same for all
in freq. domain).

As suggested by Viresh, to try to keep the sugov_policy::max usefulness.

This time the CPU capacity is fetched once every time is needed and then
simple max() formula for utilization is used (removed multiplications).

Regards,
Lukasz


 kernel/sched/cpufreq_schedutil.c | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1207c78f85c1..bb5dca20876e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -25,6 +25,9 @@ struct sugov_policy {
 	unsigned int		next_freq;
 	unsigned int		cached_raw_freq;
 
+	/* max CPU capacity, which is equal for all CPUs in freq. domain */
+	unsigned long           max;
+
 	/* The next fields are only needed if fast switch cannot be used: */
 	struct			irq_work irq_work;
 	struct			kthread_work work;
@@ -48,7 +51,6 @@ struct sugov_cpu {
 
 	unsigned long		util;
 	unsigned long		bw_dl;
-	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -158,7 +160,6 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
@@ -253,6 +254,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  */
 static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long boost;
 
 	/* No boost currently required */
@@ -280,7 +282,8 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
+	boost = sg_cpu->iowait_boost * sg_policy->max;
+	boost >>= SCHED_CAPACITY_SHIFT;
 	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
 	if (sg_cpu->util < boost)
 		sg_cpu->util = boost;
@@ -312,6 +315,8 @@ static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned int flags)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -320,6 +325,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
+	/* Fetch the latest CPU capcity to avoid stale data */
+	sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
+
 	sugov_get_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time);
 
@@ -337,7 +345,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	if (!sugov_update_single_common(sg_cpu, time, flags))
 		return;
 
-	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
+	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_policy->max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -373,6 +381,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 				     unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long prev_util = sg_cpu->util;
 
 	/*
@@ -399,7 +408,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), sg_cpu->max);
+				   map_util_perf(sg_cpu->util), sg_policy->max);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
@@ -408,25 +417,22 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned long util = 0, max = 1;
+	unsigned long util = 0;
 	unsigned int j;
 
+	/* Fetch the latest CPU capcity to avoid stale data */
+	sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
+
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
-		unsigned long j_util, j_max;
 
 		sugov_get_util(j_sg_cpu);
 		sugov_iowait_apply(j_sg_cpu, time);
-		j_util = j_sg_cpu->util;
-		j_max = j_sg_cpu->max;
 
-		if (j_util * max > j_max * util) {
-			util = j_util;
-			max = j_max;
-		}
+		util = max(j_sg_cpu->util, util);
 	}
 
-	return get_next_freq(sg_policy, util, max);
+	return get_next_freq(sg_policy, util, sg_policy->max);
 }
 
 static void
-- 
2.17.1

