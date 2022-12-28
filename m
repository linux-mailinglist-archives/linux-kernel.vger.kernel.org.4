Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE53F65849C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiL1Q6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiL1Q6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:58:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E920187
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:54:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso10284962wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQvdBEl6RlqHje8MyaR356a6GfCf0vVWLay35+iFkb4=;
        b=woG8q+vgbDjISUbwk2dpHJyp7SH3skAyHa3lJ2ly/IUj7jlvIY66ahEwIZCdW2If+8
         sJ9Vq6E17HuosQdL+8pBMiqeI/rGUhR4AE1Y8Wi6nJWJ//zMg5Vqjna+bvKhW+mAu7VS
         dpOTcGZgACbkI7L4bfZdt66sBFnG+eF05EjLjNx4+rjsYvi4VUe0WX7C7zS4KGPES1FY
         3LuisRXcPc02AvH+PBmFFimUHPLX5tlJ8ZFCKtywyRdCzzr5iHXNP+Zjd484Nh7ND3Ph
         YWK+j7mlw6KqAOOny1p0JHd3X64AUh+jZijLNIpM8I5CcwfS3tKY0ASGtc28fWwebzP0
         x5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQvdBEl6RlqHje8MyaR356a6GfCf0vVWLay35+iFkb4=;
        b=ByhkWQqVZ1ZnCZDG0KyHFlLOfKOwBnz7iNZ1EEWNXNVsurlvkV8f7Aj+ZvrupwHc+l
         i9hNIQduVP+2296nHIz59ezHCuPL0Yoi1Ml0SdAX8pIhAb/zhV8uM8GqwZKYCrILUg69
         9jbIJ10PP4TFvl0W3lMI8qGaJyz235AaVItEIPsnqtm+tqyTbmkqIHntK5/TgT9vZjXN
         9cnsHRWJo96qKD8CVwSezyqt1usAJpePu6kSZX1eLAPLcN/XiOPWvpNAz/buVw4Sh5eG
         ytUGc3wqlvL7ibrh6RidpU6AdROm35NXzwdG9YOkfm22vsCfL2oUcEWTUnwaEFsSrnXF
         GSDQ==
X-Gm-Message-State: AFqh2kokoYSVvoLArKVXvwk6D2kXDuRoqDE46Ug8k/aiHzTy8jfjbOus
        TYEhE8yM+l8EZqQNHJFeRBQyVw==
X-Google-Smtp-Source: AMrXdXsAyvxyBSTP9kwV0rKBEuEgbYI4RR0WFbYyRzyJc92NvGgUottx2MkZGUx5TKvROog/PDhfvQ==
X-Received: by 2002:a05:600c:4255:b0:3d2:282a:e1f5 with SMTP id r21-20020a05600c425500b003d2282ae1f5mr17835687wmm.30.1672246459891;
        Wed, 28 Dec 2022 08:54:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:8107:498f:f39e:eb2c])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d414a000000b0024242111a27sm16066796wrq.75.2022.12.28.08.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:54:18 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Date:   Wed, 28 Dec 2022 17:54:15 +0100
Message-Id: <20221228165415.3436-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By taking into account uclamp_min, the 1:1 relation between task misfit
and cpu overutilized is no more true as a task with a small util_avg of
may not may not fit a high capacity cpu because of uclamp_min constraint.

Add a new state in util_fits_cpu() to reflect the case that task would fit
a CPU except for the uclamp_min hint which is a performance requirement.

Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
can use this new value to take additional action to select the best CPU
that doesn't match uclamp_min hint.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v1:
- fix some wrong conditions
- take into account more cases

 kernel/sched/fair.c | 99 +++++++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1649e7d71d24..57077f0a897e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4582,8 +4582,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 *     2. The system is being saturated when we're operating near
 	 *        max capacity, it doesn't make sense to block overutilized.
 	 */
-	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
-	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
+	uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
 	fits = fits || uclamp_max_fits;
 
 	/*
@@ -4618,8 +4617,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
-		fits = fits && (uclamp_min <= capacity_orig_thermal);
+	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+		return -1;
 
 	return fits;
 }
@@ -4629,7 +4628,7 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
 	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 	unsigned long util = task_util_est(p);
-	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
+	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6864,6 +6863,7 @@ static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	unsigned long task_util, util_min, util_max, best_cap = 0;
+	int fits, best_fits = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
@@ -6879,12 +6879,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
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
 
@@ -6897,7 +6913,7 @@ static inline bool asym_fits_cpu(unsigned long util,
 				 int cpu)
 {
 	if (sched_asym_cpucap_active())
-		return util_fits_cpu(util, util_min, util_max, cpu);
+		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
 
 	return true;
 }
@@ -7264,6 +7280,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
+	int prev_fits = -1, best_fits = -1;
+	unsigned long best_thermal_cap = 0;
+	unsigned long prev_thermal_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7299,6 +7318,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
+		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -7351,7 +7371,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 					util_max = max(rq_util_max, p_util_max);
 				}
 			}
-			if (!util_fits_cpu(util, util_min, util_max, cpu))
+
+			fits = util_fits_cpu(util, util_min, util_max, cpu);
+			if (!fits)
 				continue;
 
 			lsub_positive(&cpu_cap, util);
@@ -7359,7 +7381,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -7367,6 +7391,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				 */
 				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
+				max_fits = fits;
 			}
 		}
 
@@ -7385,26 +7410,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
+			if ((max_fits > 0) &&
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
@@ -10228,24 +10277,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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
@@ -10258,6 +10306,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;
 
+	local = &sds.local_stat;
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
-- 
2.17.1

