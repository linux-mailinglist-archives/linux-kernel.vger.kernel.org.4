Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591BA693002
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjBKKbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBKKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:30:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1721A08;
        Sat, 11 Feb 2023 02:30:56 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:30:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676111454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hL0SOqILhn8x8UljvWCOZX3830NSELg20slX3yDKi2E=;
        b=f8TdvoaO9v3ANgBGkiaZabfjC+HpStkcdImzyOmA+uqp0TTXC/3Rr4LgGdVVz4AUunO7Ya
        EBDbzowUUpFoCMMD9FB1NDVRQ31/wOYo980tfmIBpU+YsRyl/Ls/JxH5u5+cPFSJCIhlG4
        dE5oNhVUzDmWUYUdig1n/6NJ4qvRPcX4lAyXw4dzaZoj2DrccO97qW+qcORiB2bEHH2i3o
        nUqq3miCS08gg6E9fAmzCdiacpQm6E2Mx42xVPAH6SYJebmnqjcVAZeqg542oiqlFTpPY/
        STgL6ak2C+FIQznDLavTQl2pnfmfi50F4acA93pgFpqHMCxWajBdXNsEwcrfrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676111454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hL0SOqILhn8x8UljvWCOZX3830NSELg20slX3yDKi2E=;
        b=2B69rz070gDZj+qC74BEUPbpIjNj3Jl1MkY5uHmaR8tTdUOOucy2rFruZLJMNr/aoZPVdR
        QH6fPhfspEOOHLAA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove capacity inversion detection
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230201143628.270912-3-vincent.guittot@linaro.org>
References: <20230201143628.270912-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <167611145452.4906.14789965489970218090.tip-bot2@tip-bot2>
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

Commit-ID:     a2e90611b9f425adbbfcdaa5b5e49958ddf6f61b
Gitweb:        https://git.kernel.org/tip/a2e90611b9f425adbbfcdaa5b5e49958ddf6f61b
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 01 Feb 2023 15:36:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Feb 2023 11:18:09 +01:00

sched/fair: Remove capacity inversion detection

Remove the capacity inversion detection which is now handled by
util_fits_cpu() returning -1 when we need to continue to look for a
potential CPU with better performance.

This ends up almost reverting patches below except for some comments:
commit da07d2f9c153 ("sched/fair: Fixes for capacity inversion detection")
commit aa69c36f31aa ("sched/fair: Consider capacity inversion in util_fits_cpu()")
commit 44c7b80bffc3 ("sched/fair: Detect capacity inversion")

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230201143628.270912-3-vincent.guittot@linaro.org
---
 kernel/sched/fair.c  | 84 ++-----------------------------------------
 kernel/sched/sched.h | 19 +----------
 2 files changed, 5 insertions(+), 98 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 074742f..c6c8e7f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4476,17 +4476,9 @@ static inline int util_fits_cpu(unsigned long util,
 	 *
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
-	 *
-	 * In case of capacity inversion we should honour the inverted capacity
-	 * for both uclamp_min and uclamp_max all the time.
 	 */
-	capacity_orig = cpu_in_capacity_inversion(cpu);
-	if (capacity_orig) {
-		capacity_orig_thermal = capacity_orig;
-	} else {
-		capacity_orig = capacity_orig_of(cpu);
-		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
-	}
+	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -9027,82 +9019,16 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
-	struct rq *rq = cpu_rq(cpu);
 
-	rq->cpu_capacity_orig = capacity_orig;
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
 
 	if (!capacity)
 		capacity = 1;
 
-	rq->cpu_capacity = capacity;
-
-	/*
-	 * Detect if the performance domain is in capacity inversion state.
-	 *
-	 * Capacity inversion happens when another perf domain with equal or
-	 * lower capacity_orig_of() ends up having higher capacity than this
-	 * domain after subtracting thermal pressure.
-	 *
-	 * We only take into account thermal pressure in this detection as it's
-	 * the only metric that actually results in *real* reduction of
-	 * capacity due to performance points (OPPs) being dropped/become
-	 * unreachable due to thermal throttling.
-	 *
-	 * We assume:
-	 *   * That all cpus in a perf domain have the same capacity_orig
-	 *     (same uArch).
-	 *   * Thermal pressure will impact all cpus in this perf domain
-	 *     equally.
-	 */
-	if (sched_energy_enabled()) {
-		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-		struct perf_domain *pd;
-
-		rcu_read_lock();
-
-		pd = rcu_dereference(rq->rd->pd);
-		rq->cpu_capacity_inverted = 0;
-
-		for (; pd; pd = pd->next) {
-			struct cpumask *pd_span = perf_domain_span(pd);
-			unsigned long pd_cap_orig, pd_cap;
-
-			/* We can't be inverted against our own pd */
-			if (cpumask_test_cpu(cpu_of(rq), pd_span))
-				continue;
-
-			cpu = cpumask_any(pd_span);
-			pd_cap_orig = arch_scale_cpu_capacity(cpu);
-
-			if (capacity_orig < pd_cap_orig)
-				continue;
-
-			/*
-			 * handle the case of multiple perf domains have the
-			 * same capacity_orig but one of them is under higher
-			 * thermal pressure. We record it as capacity
-			 * inversion.
-			 */
-			if (capacity_orig == pd_cap_orig) {
-				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
-
-				if (pd_cap > inv_cap) {
-					rq->cpu_capacity_inverted = inv_cap;
-					break;
-				}
-			} else if (pd_cap_orig > inv_cap) {
-				rq->cpu_capacity_inverted = inv_cap;
-				break;
-			}
-		}
-
-		rcu_read_unlock();
-	}
-
-	trace_sched_cpu_capacity_tp(rq);
+	cpu_rq(cpu)->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1072502..3e8df6d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1044,7 +1044,6 @@ struct rq {
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
-	unsigned long		cpu_capacity_inverted;
 
 	struct balance_callback *balance_callback;
 
@@ -2899,24 +2898,6 @@ static inline unsigned long capacity_orig_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
-/*
- * Returns inverted capacity if the CPU is in capacity inversion state.
- * 0 otherwise.
- *
- * Capacity inversion detection only considers thermal impact where actual
- * performance points (OPPs) gets dropped.
- *
- * Capacity inversion state happens when another performance domain that has
- * equal or lower capacity_orig_of() becomes effectively larger than the perf
- * domain this CPU belongs to due to thermal pressure throttling it hard.
- *
- * See comment in update_cpu_capacity().
- */
-static inline unsigned long cpu_in_capacity_inversion(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_inverted;
-}
-
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
