Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBCF660E1C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjAGKxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAGKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:53:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D81A230;
        Sat,  7 Jan 2023 02:53:02 -0800 (PST)
Date:   Sat, 07 Jan 2023 10:53:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGD7ZnWUKF7tqGSud2LqzF4mI7GWQmQXQGhiC3qEjrE=;
        b=CrrMF7dePnVQZLHD9vYpiSyS5JMwBsd8wmTiluM7WNpFNCg3i68ajzbKyiE9Hhh7G0S/fl
        7yzNLKZmVt8bCjQt1BM3dM+tHCe2dtSwNtVn+j3Ch/tMbgl4dMFjDulLXlRlP0A0cdpPy1
        M6StTFGbZ/mHW264kQpUy8fKkTj7nbMNl6Ig50iGnzg5zVUSQR0Pj67xud2Vg5jYLKKjU5
        xCGX/Fi4YiyjQ1liBoj1zn1rj8cJayI2JIE4lFDY2wYn1fF6M2FPdRzdmX5HgJpLvQIrPR
        5Unn6+ZwzayFnVLPYKuxYaNLXj1UeVJ4ZYwTETOx1ZzOoUMQp0CUAAsaptJgtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGD7ZnWUKF7tqGSud2LqzF4mI7GWQmQXQGhiC3qEjrE=;
        b=dq6AD7cNvcXEloWj5POeRuIhXlM4i4hgh50n/kToXKc8UO1LUqA50h4881Ps31xk0Dxd0m
        M7YUK/SmH4oYGVCA==
From:   "tip-bot2 for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpufreq, sched/util: Optimize operations with
 single CPU capacity lookup
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221208160256.859-2-lukasz.luba@arm.com>
References: <20221208160256.859-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <167308878019.4906.9272365354488767726.tip-bot2@tip-bot2>
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

Commit-ID:     948fb4c4e9cb2ad15b87e6e7cf0dd3b4ec17b8a4
Gitweb:        https://git.kernel.org/tip/948fb4c4e9cb2ad15b87e6e7cf0dd3b4ec17b8a4
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 08 Dec 2022 16:02:56 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 11:25:38 +01:00

cpufreq, sched/util: Optimize operations with single CPU capacity lookup

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221208160256.859-2-lukasz.luba@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 43 ++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1207c78..5c84015 100644
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
