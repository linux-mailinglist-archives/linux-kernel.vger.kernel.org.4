Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90966698FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjAMNrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbjAMNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:47:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA85CFB8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:41:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q10so1784225wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=to8C6Bev+T1XukXaLfCpj5N27WyqBL3BbOApapHPhM4=;
        b=aalcNYKlp8WuG/reKf77olUau63Gzba5biFTUHqYq4rfPg8JbvsOuj1uewF3tZuGaq
         57N3Y+um6bIbfyBeLpxBZH7d22BtoAPBNHp5dEkD2OgEeIu1tPjTOUvHeddYmWJH1vcJ
         RyuPn0pMKO4di9gDltpytCmsr4w4CKin/Abjsj2PO+Y/q6Lw6sf7HdVRpCKYEovK4rk3
         8jVn7GQjQoGajj+fmNLKlB+1fSSl7E1VFAgaABqYT33TDqUZeR4Zy4Pi0NZ/KCw6vaQf
         RK9U3q5vPmAHbXQMuyEVf+4YFSnwmQrGRoFJA7Gv+XgmrxUAjuAauHl2W29KHmYQeQM1
         Aagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to8C6Bev+T1XukXaLfCpj5N27WyqBL3BbOApapHPhM4=;
        b=vRaBkkqrLckD3REOzxPtoJ8eDyM9GeqnBnSRT2Bj+YxYxBVlnuFmDneaU1wiD2K4XC
         Q+WSOP6E32LIGSL/lrlOS1hTWAfvKdN6SFGiHrGiGzcTHjxkslqXiVG9J0nhK6ntToSQ
         Y24aCCRWouxXZFgSxD7tdL5D7ZUmLH3k/d38RlT2Vu2pVFWsu4sl+Xef3FswMCIvHeqK
         IJR1VOTcf+JS6krgwS/pTwNjIZdLEc4DupDUvVplBAPyKmK/+twdbFAg3zCA5741V7xl
         5irrUHRhYS5LA8DglFHJcUnEodY5o33GSTq5h0URnQs6UT7k6P1LIPlX+hk4qPFRZXJi
         icIg==
X-Gm-Message-State: AFqh2koGTc5/vk0za+P8SwA0XWqo+r0klqf2EUz6tgIvBLewaLc1h4A0
        7x5gRJgq7H95DXmlajtEC8JVkQ==
X-Google-Smtp-Source: AMrXdXsZfvkZpxlEymlnMv1aal6S7GbjoACMXVtjWz+lBia188KCa1/Teg/KrcFO/k3PLvBeTvghfA==
X-Received: by 2002:adf:a497:0:b0:2b2:35:e0a4 with SMTP id g23-20020adfa497000000b002b20035e0a4mr21248053wrb.15.1673617259540;
        Fri, 13 Jan 2023 05:40:59 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id q4-20020adfdfc4000000b002bc6c180738sm14586348wrn.90.2023.01.13.05.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:40:58 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
Date:   Fri, 13 Jan 2023 14:40:56 +0100
Message-Id: <20230113134056.257691-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By taking into account uclamp_min, the 1:1 relation between task misfit
and cpu overutilized is no more true as a task with a small util_avg of
may not fit a high capacity cpu because of uclamp_min constraint.

Add a new state in util_fits_cpu() to reflect the case that task would fit
a CPU except for the uclamp_min hint which is a performance requirement.

Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
can use this new value to take additional action to select the best CPU
that doesn't match uclamp_min hint.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v2:
- fix a condition in feec()
- add comments

 kernel/sched/fair.c | 108 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e9d906a9bba9..29adb9e27b3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4525,8 +4525,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 *     2. The system is being saturated when we're operating near
 	 *        max capacity, it doesn't make sense to block overutilized.
 	 */
-	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
-	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
+	uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
 	fits = fits || uclamp_max_fits;
 
 	/*
@@ -4561,8 +4560,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
-		fits = fits && (uclamp_min <= capacity_orig_thermal);
+	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+		return -1;
 
 	return fits;
 }
@@ -4572,7 +4571,11 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
 	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 	unsigned long util = task_util_est(p);
-	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
+	/*
+	 * Return true only if the cpu fully fits the task requirements, which
+	 * include the utilization but also the performance.
+	 */
+	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
 	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
+	/* Return true only if the utlization doesn't fit its capacity */
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
@@ -6925,6 +6929,7 @@ static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	unsigned long task_util, util_min, util_max, best_cap = 0;
+	int fits, best_fits = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
@@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
-		if (util_fits_cpu(task_util, util_min, util_max, cpu))
+
+		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
+
+		/* This CPU fits with all capacity and performance requirements */
+		if (fits > 0)
 			return cpu;
+		/*
+		 * Only the min performance (i.e. uclamp_min) doesn't fit. Look
+		 * for the CPU with highest performance capacity.
+		 */
+		else if (fits < 0)
+			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
 
-		if (cpu_cap > best_cap) {
+		/*
+		 * First, select cpu which fits better (-1 being better than 0).
+		 * Then, select the one with largest capacity at same level.
+		 */
+		if ((fits < best_fits) ||
+		    ((fits == best_fits) && (cpu_cap > best_cap))) {
 			best_cap = cpu_cap;
 			best_cpu = cpu;
+			best_fits = fits;
 		}
 	}
 
@@ -6958,7 +6979,11 @@ static inline bool asym_fits_cpu(unsigned long util,
 				 int cpu)
 {
 	if (sched_asym_cpucap_active())
-		return util_fits_cpu(util, util_min, util_max, cpu);
+		/*
+		 * Return true only if the cpu fully fits the task requirements
+		 * which include the utilization but also the performance.
+		 */
+		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
 
 	return true;
 }
@@ -7325,6 +7350,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
+	int prev_fits = -1, best_fits = -1;
+	unsigned long best_thermal_cap = 0;
+	unsigned long prev_thermal_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7360,6 +7388,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
+		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -7412,7 +7441,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 					util_max = max(rq_util_max, p_util_max);
 				}
 			}
-			if (!util_fits_cpu(util, util_min, util_max, cpu))
+
+			fits = util_fits_cpu(util, util_min, util_max, cpu);
+			if (!fits)
 				continue;
 
 			lsub_positive(&cpu_cap, util);
@@ -7420,7 +7451,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (cpu == prev_cpu) {
 				/* Always use prev_cpu as a candidate. */
 				prev_spare_cap = cpu_cap;
-			} else if (cpu_cap > max_spare_cap) {
+				prev_fits = fits;
+			} else if ((fits > max_fits) ||
+				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7428,6 +7461,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				 */
 				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
+				max_fits = fits;
 			}
 		}
 
@@ -7446,26 +7480,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
+			prev_thermal_cap = cpu_thermal_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
+			/* Current best energy cpu fits better */
+			if (max_fits < best_fits)
+				continue;
+
+			/*
+			 * Both don't fit performance (i.e. uclamp_min) but
+			 * best energy cpu has better performance.
+			 */
+			if ((max_fits < 0) &&
+			    (cpu_thermal_cap <= best_thermal_cap))
+				continue;
+
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
 			/* CPU utilization has changed */
 			if (cur_delta < base_energy)
 				goto unlock;
 			cur_delta -= base_energy;
-			if (cur_delta < best_delta) {
-				best_delta = cur_delta;
-				best_energy_cpu = max_spare_cap_cpu;
-			}
+
+			/*
+			 * Both fit for the task but best energy cpu has lower
+			 * energy impact.
+			 */
+			if ((max_fits > 0) && (best_fits > 0) &&
+			    (cur_delta >= best_delta))
+				continue;
+
+			best_delta = cur_delta;
+			best_energy_cpu = max_spare_cap_cpu;
+			best_fits = max_fits;
+			best_thermal_cap = cpu_thermal_cap;
 		}
 	}
 	rcu_read_unlock();
 
-	if (best_delta < prev_delta)
+	if ((best_fits > prev_fits) ||
+	    ((best_fits > 0) && (best_delta < prev_delta)) ||
+	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
 		target = best_energy_cpu;
 
 	return target;
@@ -10259,24 +10317,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 */
 	update_sd_lb_stats(env, &sds);
 
-	if (sched_energy_enabled()) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
-			goto out_balanced;
-	}
-
-	local = &sds.local_stat;
-	busiest = &sds.busiest_stat;
-
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest)
 		goto out_balanced;
 
+	busiest = &sds.busiest_stat;
+
 	/* Misfit tasks should be dealt with regardless of the avg load */
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;
 
+	if (sched_energy_enabled()) {
+		struct root_domain *rd = env->dst_rq->rd;
+
+		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+			goto out_balanced;
+	}
+
 	/* ASYM feature bypasses nice load balance check */
 	if (busiest->group_type == group_asym_packing)
 		goto force_balance;
@@ -10289,6 +10346,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;
 
+	local = &sds.local_stat;
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
-- 
2.34.1

