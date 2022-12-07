Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C464C645764
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLGKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLGKR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:17:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2722945EFD;
        Wed,  7 Dec 2022 02:17:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F82BD6E;
        Wed,  7 Dec 2022 02:17:31 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.7.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E76883F73B;
        Wed,  7 Dec 2022 02:17:21 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        saravanak@google.com, wusamuel@google.com,
        isaacmanjarres@google.com, kernel-team@android.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: [PATCH v2 1/2] cpufreq: schedutil: Introduce single max CPU capacity for freqency domain
Date:   Wed,  7 Dec 2022 10:17:04 +0000
Message-Id: <20221207101705.9460-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207101705.9460-1-lukasz.luba@arm.com>
References: <20221207101705.9460-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the code for optimizations and move the max CPU capacity
into the sugov_policy struct. This will allow to leverage the fact that
the max CPU capacity is the same for all CPUs in the frequency domain.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1207c78f85c1..c19d6de67b7a 100644
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
@@ -156,9 +158,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
+	sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
@@ -253,6 +256,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  */
 static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long boost;
 
 	/* No boost currently required */
@@ -280,7 +284,8 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
+	boost = sg_cpu->iowait_boost * sg_policy->max;
+	boost >>= SCHED_CAPACITY_SHIFT;
 	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
 	if (sg_cpu->util < boost)
 		sg_cpu->util = boost;
@@ -337,7 +342,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	if (!sugov_update_single_common(sg_cpu, time, flags))
 		return;
 
-	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
+	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_policy->max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -373,6 +378,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 				     unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long prev_util = sg_cpu->util;
 
 	/*
@@ -399,7 +405,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), sg_cpu->max);
+				   map_util_perf(sg_cpu->util), sg_policy->max);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
@@ -760,6 +766,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->work_in_progress		= false;
 	sg_policy->limits_changed		= false;
 	sg_policy->cached_raw_freq		= 0;
+	sg_policy->max				= 0;
 
 	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 
-- 
2.17.1

