Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEF674036
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjASRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjASRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:43:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE2690847
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:42:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so4088850wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO/E9/rO1yWlxCIS0yttksgOKDS2Yz9CAOXxHv3xIQs=;
        b=RsfgSebXzdR8lxygfWtHlFckRG+lzybc1+RHIGMLXa77zqTqHjSbOPw3lRhbCj/mBk
         FsKvMSv4I3pozBX6LcUJ+pY3szAfr39mylKsyS309d9XlClBEkroa5qD8ykBZOfHsr1L
         DO6a2ylInRL7g/8kyF+iySzxUj5obkxvDKUnF8sbqGOKgscTMn2w/rfUDmYugTQ5PGJH
         lJl9Sz8uWtxD77okYoPhh8gADpUsvkf/h6mamY1YhP65nXPRSUdvY0Y5z0IIhK/anRoH
         iJXvQDycaphlxYeyCYX0Wzl0d6RrL11EcN3IyIFGqqrrMxUbMngoD4WR6zKlBfkOM/xc
         g3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO/E9/rO1yWlxCIS0yttksgOKDS2Yz9CAOXxHv3xIQs=;
        b=ELtiYMT/4JFiJsnRNIhLz3NcLrSb0oTrwIQHMgWTtpKSw9O7jF1w2eLCErWlVp0OdU
         bnIVMblL5JKEwBFcLUUXc6kYjj5s+Ghomy6zrwisM6jy5Mv8yUCpLCBfMPV92y+vbPIo
         fPZ14nD2Ajbzqrx+VyqYLR0G0Hy7IfenVgKrgujNFp1gjUG0w2OXkWdsSd/CxNMFhSwM
         ycrtYmlU/HhyCbVNt8tsbmpHaTvSGll5G3Le7UysMVmiNu7w3o7DvA3CCRQfTfIQDCoa
         SOXS1TfUJ8QbT3uR06flBMMhkQ0zHu2GMv5taNqRsQvtjEgxJM0UI6YBhf2jQM8fPWl1
         BQWQ==
X-Gm-Message-State: AFqh2kpJGXfyU0IZxS4/qKzhHcuiB1AB9CL3gPrLdNxTWlVmSZDkzFrP
        mGEOLRet6Qm2Dn8jhVZESDJbrw==
X-Google-Smtp-Source: AMrXdXsaCGXb1CXvrh26UOz32WXXKOWbp9e3ddjsK7j1ax3BugfAD0EYl2r5HnFAioBd9+QGjVrGgA==
X-Received: by 2002:a05:600c:4e14:b0:3c6:e63d:adaf with SMTP id b20-20020a05600c4e1400b003c6e63dadafmr10629872wmq.31.1674150168753;
        Thu, 19 Jan 2023 09:42:48 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:2755:9231:a3ec:f91])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c511600b003d9780466b0sm6145704wms.31.2023.01.19.09.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:42:48 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
Date:   Thu, 19 Jan 2023 18:42:44 +0100
Message-Id: <20230119174244.2059628-1-vincent.guittot@linaro.org>
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
and cpu overutilized is no more true as a task with a small util_avg may
not fit a high capacity cpu because of uclamp_min constraint.

Add a new state in util_fits_cpu() to reflect the case that task would fit
a CPU except for the uclamp_min hint which is a performance requirement.

Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
can use this new value to take additional action to select the best CPU
that doesn't match uclamp_min hint.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v3:
- Keep current condition for uclamp_max_fits in util_fits_cpu()
- Update some comments

 kernel/sched/fair.c | 105 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4db72f8f84e..54e14da53274 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4561,8 +4561,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
-		fits = fits && (uclamp_min <= capacity_orig_thermal);
+	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+		return -1;
 
 	return fits;
 }
@@ -4572,7 +4572,11 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
 	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 	unsigned long util = task_util_est(p);
-	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
+	/*
+	 * Return true only if the cpu fully fits the task requirements, which
+	 * include the utilization but also the performance hints.
+	 */
+	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6138,6 +6142,7 @@ static inline bool cpu_overutilized(int cpu)
 	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
+	/* Return true only if the utilization doesn't fits CPU's capacity */
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
@@ -6931,6 +6936,7 @@ static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	unsigned long task_util, util_min, util_max, best_cap = 0;
+	int fits, best_fits = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
@@ -6946,12 +6952,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
-		if (util_fits_cpu(task_util, util_min, util_max, cpu))
+
+		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
+
+		/* This CPU fits with all requirements */
+		if (fits > 0)
 			return cpu;
+		/*
+		 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
+		 * Look for the CPU with best capacity.
+		 */
+		else if (fits < 0)
+			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
 
-		if (cpu_cap > best_cap) {
+		/*
+		 * First, select CPU which fits better (-1 being better than 0).
+		 * Then, select the one with best capacity at same level.
+		 */
+		if ((fits < best_fits) ||
+		    ((fits == best_fits) && (cpu_cap > best_cap))) {
 			best_cap = cpu_cap;
 			best_cpu = cpu;
+			best_fits = fits;
 		}
 	}
 
@@ -6964,7 +6986,11 @@ static inline bool asym_fits_cpu(unsigned long util,
 				 int cpu)
 {
 	if (sched_asym_cpucap_active())
-		return util_fits_cpu(util, util_min, util_max, cpu);
+		/*
+		 * Return true only if the cpu fully fits the task requirements
+		 * which include the utilization and the performance hints.
+		 */
+		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
 
 	return true;
 }
@@ -7331,6 +7357,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
+	int prev_fits = -1, best_fits = -1;
+	unsigned long best_thermal_cap = 0;
+	unsigned long prev_thermal_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7366,6 +7395,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
+		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -7418,7 +7448,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 					util_max = max(rq_util_max, p_util_max);
 				}
 			}
-			if (!util_fits_cpu(util, util_min, util_max, cpu))
+
+			fits = util_fits_cpu(util, util_min, util_max, cpu);
+			if (!fits)
 				continue;
 
 			lsub_positive(&cpu_cap, util);
@@ -7426,7 +7458,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -7434,6 +7468,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				 */
 				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
+				max_fits = fits;
 			}
 		}
 
@@ -7452,26 +7487,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
+			 * Both don't fit performance hint (i.e. uclamp_min)
+			 * but best energy cpu has better capacity.
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
@@ -10265,24 +10324,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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
@@ -10295,6 +10353,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;
 
+	local = &sds.local_stat;
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
-- 
2.34.1

