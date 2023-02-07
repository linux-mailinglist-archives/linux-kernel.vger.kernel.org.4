Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3AF68CEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBGFDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjBGFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:02:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9F1165B;
        Mon,  6 Feb 2023 21:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746119; x=1707282119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ptfoaHFvByfojwrO5m9wFLhJI66qhikYpEJ1HsiQosE=;
  b=T5FDN758/KNrKvZ6v/rCdtf0U8IQ81E3whmmtmtiqcv5uBjFKiXQHKEy
   NXYezTjbhG3XLAEbsQyQs+/AXTbO3ol8+IzvbbOVfRD3yk9D6yVoA5o0W
   Yu3cE5GqLgXw+ZI+9QNkPnbLkPbjZlh3oKFKuYItC1xwzOaK/LdSHfAph
   BBXOQHWmePCUCzL2t6nUfvd3z1REkB+VroHcQN9EzRFj3VJ/TPAzdmbHK
   nqqwQbY7lqjtj1LjXIsyEKpRTaVkro54a2xVOONVd0BrJV5R3nKIZGxKN
   jYpUPlhg/XtEOUEP/q6MNBfM5V0FQeXQAuNo7YJzuuu1iVFFYUXbe1COk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625950"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625950"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657773"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657773"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:45 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 20/24] sched/fair: Introduce sched_smt_siblings_idle()
Date:   Mon,  6 Feb 2023 21:11:01 -0800
Message-Id: <20230207051105.11575-21-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86 needs to know the idle state of the SMT siblings of a CPU to improve
the accuracy of IPCC classification. X86 implements support for IPC classes
in the thermal HFI driver.

Rename is_core_idle() as sched_smt_siblings_idle() and make it available
outside the scheduler code.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
is_core_idle() is no longer an inline function after this patch. To rule
out performance degradation, I compared the execution time of the inline
and non-inline versions on a 4-socket Cascade Lake system using the NUMA
stressor of stress-ng:

        $ stress-ng --numa 1500 -t 10m

is_core_idle() was called ~200,000 times. I measured the value of the TSC
counter before and after calling is_core_idle() and computed the delta
value.

I arbitrarily removed outliers (defined as any delta larger than 5000
counts). This required removing ~40 samples.

The table below summarizes the difference in execution time. All quantities
are expressed in TSC counts, except the standard deviation, expressed as a
percentage of the average.

                              Average  Median  Std(%) Mode
        TSCdelta inline        668.76     626   67.24   42
        TSCdelta non-inline    677.64     624   67.67   46

All metrics are similar for the inline and non-inline cases.
---
Changes since v2:
 * Brought back this previously dropped patch.
 * Profiled inline vs non-inline is_core_idle(). I found not major penalty.
 * Merged is_core_idle() and sched_smt_siblings_idle() into a single
   function. (Dietmar)

Changes since v1:
 * Dropped this patch.
---
 include/linux/sched.h |  2 ++
 kernel/sched/fair.c   | 21 +++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 45f28a601b3d..7ef9fd84e7ad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2449,4 +2449,6 @@ static inline void sched_core_fork(struct task_struct *p) { }
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
 
+extern bool sched_smt_siblings_idle(int cpu);
+
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3c22dc145f7..a66d86c5cb5c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1064,7 +1064,14 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
-static inline bool is_core_idle(int cpu)
+/**
+ * sched_smt_siblings_idle - Check whether SMT siblings of a CPU are idle
+ * @cpu:	The CPU to check
+ *
+ * Returns true if all the SMT siblings of @cpu are idle or @cpu does not have
+ * SMT siblings. The idle state of @cpu is not considered.
+ */
+bool sched_smt_siblings_idle(int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
 	int sibling;
@@ -1767,7 +1774,7 @@ static inline int numa_idle_core(int idle_core, int cpu)
 	 * Prefer cores instead of packing HT siblings
 	 * and triggering future load balancing.
 	 */
-	if (is_core_idle(cpu))
+	if (sched_smt_siblings_idle(cpu))
 		idle_core = cpu;
 
 	return idle_core;
@@ -9518,7 +9525,8 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	 * If the destination CPU has SMT siblings, env->idle != CPU_NOT_IDLE
 	 * is not sufficient. We need to make sure the whole core is idle.
 	 */
-	if (sds->local->flags & SD_SHARE_CPUCAPACITY && !is_core_idle(env->dst_cpu))
+	if (sds->local->flags & SD_SHARE_CPUCAPACITY &&
+	    !sched_smt_siblings_idle(env->dst_cpu))
 		return false;
 
 	/* Only do SMT checks if either local or candidate have SMT siblings. */
@@ -10687,7 +10695,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    sched_asym_prefer(i, env->dst_cpu) &&
 		    nr_running == 1) {
 			if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
-			    (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
+			    (!(env->sd->flags & SD_SHARE_CPUCAPACITY) &&
+			     sched_smt_siblings_idle(i)))
 				continue;
 		}
 
@@ -10816,7 +10825,7 @@ asym_active_balance(struct lb_env *env)
 		 * busy sibling.
 		 */
 		return sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
-		       !is_core_idle(env->src_cpu);
+		       !sched_smt_siblings_idle(env->src_cpu);
 	}
 
 	return false;
@@ -11563,7 +11572,7 @@ static void nohz_balancer_kick(struct rq *rq)
 				 */
 				if (sd->flags & SD_SHARE_CPUCAPACITY ||
 				    (!(sd->flags & SD_SHARE_CPUCAPACITY) &&
-				     is_core_idle(i))) {
+				     sched_smt_siblings_idle(i))) {
 					flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 					goto unlock;
 				}
-- 
2.25.1

