Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB4624B18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKJT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:57:40 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC89FD0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:57:39 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id oo18-20020a17090b1c9200b0020bdba475afso4004251pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Nv/CBgytn69NMqK+TFbyBd+BfQKl+kVHWTnPjJGMMU=;
        b=pQY6f1vDAT8XHF59ZRKV9GgCCjpwYTun9sBF+RHq6hglBXJnPyTL8xHYMWvQgzxaCL
         9+z7GaGdDxpKBWQa62QPd8TVNNsd3d8BLn8yOV1HUPZmNxLB9Sxz8Bt4+nPxruvDIJTd
         SRvZwNzqJZVLsgqs3RGK1shyvs/ohYPVqBvfQzrzrXiZu/dxQLYAtSsUGGK5mf5/I8o2
         qvykPFapJi956aW1SJgg00q+B/cM4pnCB8wuQAG9HoVNK4K9gD0tN0MZKaT2l1rjyd3O
         t4pi8PCzgjargodRNZ37Z2BiJPOWolc8LJK9mpHraBoFyazSBp7Wg2ubFPp1fovcY5iC
         gLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Nv/CBgytn69NMqK+TFbyBd+BfQKl+kVHWTnPjJGMMU=;
        b=7FrlM3hGSigKwznbjBINEXPO1TJ1jKL6F7SKT9Udl0hg9L/VKDV0jiASharYUu+Nga
         J3661XBLX1Pmr7mNZvBrligTKPpk+fR7tHOcXyOIwj3d4YrHuomQQD6cV+Qr1Q6mc1jp
         KpYLHY3BjfcAcVzDgLtzkYGVUoIJkEPcB/w1Vti5RpImEowL4T8mSkVyoUZjQbbD/mYe
         Y7WG+aaqrMTcIRy0sXkiFVO5AbHwX6pDEddEL61KUCoC9Loeg3p0ybVDOqCvl8flzFTh
         aEBbg83JMVtdnOYVxdfed909NSFklbxzrqsmpf0SOCXMOrFJUrekXrHQ6mAUt1lcs2fb
         GX3w==
X-Gm-Message-State: ACrzQf16LQuNkac5CqpIJYGyQUQR3sCAtkUdtbj7kcriVnE2ddwFv72f
        AUugQ0x0w4raZLiNxTckwC+UJ1hPhSAzZg==
X-Google-Smtp-Source: AMsMyM4IJBP4wy9Zci9wBJ4eUvEOuR3adcZ5+nJrkztQfesx0mZ98JTf83ulHfu5O7HqA8IV7eurhuJDP2DcxA==
X-Received: from wusamuel-special.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2a8c])
 (user=wusamuel job=sendgmr) by 2002:a17:902:b586:b0:187:30f0:b16b with SMTP
 id a6-20020a170902b58600b0018730f0b16bmr1829832pls.14.1668110258701; Thu, 10
 Nov 2022 11:57:38 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:57:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110195732.1382314-1-wusamuel@google.com>
Subject: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"
From:   Sam Wu <wusamuel@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Sam Wu <wusamuel@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6d5afdc97ea71958287364a1f1d07e59ef151b11.

On a Pixel 6 device, it is observed that this commit increases
latency by approximately 50ms, or 20%, in migrating a task
that requires full CPU utilization from a LITTLE CPU to Fmax
on a big CPU. Reverting this change restores the latency back
to its original baseline value.

Fixes: 6d5afdc97ea7 ("cpufreq: schedutil: Move max CPU capacity to sugov_policy")
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Isaac J. Manjarres <isaacmanjarres@google.com>
Signed-off-by: Sam Wu <wusamuel@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9161d1136d01..1207c78f85c1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -25,9 +25,6 @@ struct sugov_policy {
 	unsigned int		next_freq;
 	unsigned int		cached_raw_freq;
 
-	/* max CPU capacity, which is equal for all CPUs in freq. domain */
-	unsigned long		max;
-
 	/* The next fields are only needed if fast switch cannot be used: */
 	struct			irq_work irq_work;
 	struct			kthread_work work;
@@ -51,6 +48,7 @@ struct sugov_cpu {
 
 	unsigned long		util;
 	unsigned long		bw_dl;
+	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -160,6 +158,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
+	sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
@@ -254,7 +253,6 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  */
 static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 {
-	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long boost;
 
 	/* No boost currently required */
@@ -282,8 +280,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = sg_cpu->iowait_boost * sg_policy->max;
-	boost >>= SCHED_CAPACITY_SHIFT;
+	boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
 	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
 	if (sg_cpu->util < boost)
 		sg_cpu->util = boost;
@@ -340,7 +337,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	if (!sugov_update_single_common(sg_cpu, time, flags))
 		return;
 
-	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_policy->max);
+	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -376,7 +373,6 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 				     unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
-	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long prev_util = sg_cpu->util;
 
 	/*
@@ -403,8 +399,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util),
-				   sg_policy->max);
+				   map_util_perf(sg_cpu->util), sg_cpu->max);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
@@ -413,19 +408,25 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned long util = 0;
+	unsigned long util = 0, max = 1;
 	unsigned int j;
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
+		unsigned long j_util, j_max;
 
 		sugov_get_util(j_sg_cpu);
 		sugov_iowait_apply(j_sg_cpu, time);
+		j_util = j_sg_cpu->util;
+		j_max = j_sg_cpu->max;
 
-		util = max(j_sg_cpu->util, util);
+		if (j_util * max > j_max * util) {
+			util = j_util;
+			max = j_max;
+		}
 	}
 
-	return get_next_freq(sg_policy, util, sg_policy->max);
+	return get_next_freq(sg_policy, util, max);
 }
 
 static void
@@ -751,7 +752,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
-	unsigned int cpu = cpumask_first(policy->cpus);
+	unsigned int cpu;
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
@@ -759,7 +760,6 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->work_in_progress		= false;
 	sg_policy->limits_changed		= false;
 	sg_policy->cached_raw_freq		= 0;
-	sg_policy->max				= arch_scale_cpu_capacity(cpu);
 
 	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 
-- 
2.38.1.431.g37b22c650d-goog

