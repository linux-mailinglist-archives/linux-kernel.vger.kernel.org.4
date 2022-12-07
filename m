Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D48645763
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiLGKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiLGKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:17:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A456F419A8;
        Wed,  7 Dec 2022 02:17:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22D4DED1;
        Wed,  7 Dec 2022 02:17:35 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.7.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A6D63F73B;
        Wed,  7 Dec 2022 02:17:25 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        saravanak@google.com, wusamuel@google.com,
        isaacmanjarres@google.com, kernel-team@android.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: [PATCH v2 2/2] cpufreq: schedutil: Optimize operations with single max CPU capacity
Date:   Wed,  7 Dec 2022 10:17:05 +0000
Message-Id: <20221207101705.9460-3-lukasz.luba@arm.com>
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
 kernel/sched/cpufreq_schedutil.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c19d6de67b7a..f9881f3d9488 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -158,10 +158,8 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
-	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
@@ -317,6 +315,8 @@ static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned int flags)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -325,6 +325,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
+	/* Fetch the latest CPU capcity to avoid stale data */
+	sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
+
 	sugov_get_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time);
 
@@ -414,25 +417,22 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
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

