Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBF5B42C8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiIIXGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiIIXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0ACB5E5C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764793; x=1694300793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=w19sK3bnEMqEOpqrSxMYGg8KsY3IvqEuquQPb+4JYyA=;
  b=i7VJFYZxzlmb2EkEVf7ePS3q+EtDO2wpyaRc/ryh7uxSTOMHNxErzRVH
   DbGCIgzTcjST4DS5QfILRHjsocKVF+UsAGmmPaXEZ9HDhPP8Nl3EO0qnA
   1LrzWzpWDnKTzCqafJj+kmF3raej/ZR5xha6mDUNqi8lFJ6WZ0te+S1CX
   fBkGMppv2T1sPluwbp8+VrFYiv/ySNksmY22NLPPQ1x7rAabJHGqnjkdP
   nPS4NYykkxdmYPu4kJQ6p50SQgkJMfKM91MhE0UWzHEuk0CBwaV/LBO0p
   VRkGV3vOK64UxihUPQGbrRjhKLWaxxYb6OZfn4BFxzIYwC23Rf5MGuXu8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386908"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386908"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354987"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:32 -0700
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 07/23] sched/fair: Collect load-balancing stats for task classes
Date:   Fri,  9 Sep 2022 16:11:49 -0700
Message-Id: <20220909231205.14009-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When selecting a busiest scheduling group, the class of the current task
can be used to select between two scheduling groups of equal asym_packing
priority and number of running tasks.

Compute a new task-class performance score for a scheduling group. It
is the sum of the performance of the current tasks of all the runqueues.

Also, keep track of the task with the lowest performance score on the
scheduling group.

These two metrics will be used during idle load balancing to compute the
current and the prospective task-class performance of a scheduling
group.

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
 kernel/sched/fair.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f2a6bb5990d..58a435a04c1c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8686,6 +8686,63 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+struct sg_lb_task_class_stats {
+	/*
+	 * Score of the task with lowest score among the current tasks (i.e.,
+	 * runqueue::curr) of all runqueues in the scheduling group.
+	 */
+	int min_score;
+	/*
+	 * Sum of the scores of the current tasks of all runqueues in the
+	 * scheduling group.
+	 */
+	long sum_score;
+	/* The task with score equal to @min_score */
+	struct task_struct *p_min_score;
+};
+
+#ifdef CONFIG_SCHED_TASK_CLASSES
+static void init_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs)
+{
+	class_sgs->min_score = INT_MAX;
+	class_sgs->sum_score = 0;
+	class_sgs->p_min_score = NULL;
+}
+
+/** Called only if cpu_of(@rq) is not idle and has tasks running. */
+static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
+					 struct rq *rq)
+{
+	int score;
+
+	if (!sched_task_classes_enabled())
+		return;
+
+	/*
+	 * TODO: if nr_running > 1 we may want go through all the tasks behind
+	 * rq->curr.
+	 */
+	score = arch_get_task_class_score(rq->curr->class, cpu_of(rq));
+
+	class_sgs->sum_score += score;
+
+	if (score >= class_sgs->min_score)
+		return;
+
+	class_sgs->min_score = score;
+	class_sgs->p_min_score = rq->curr;
+}
+#else /* CONFIG_SCHED_TASK_CLASSES */
+static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
+					 struct rq *rq)
+{
+}
+
+static void init_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs)
+{
+}
+#endif /* CONFIG_SCHED_TASK_CLASSES */
+
 /**
  * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
  * @dst_cpu:	Destination CPU of the load balancing
@@ -8797,9 +8854,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
 {
+	struct sg_lb_task_class_stats class_stats;
 	int i, nr_running, local_group;
 
 	memset(sgs, 0, sizeof(*sgs));
+	init_rq_task_classes_stats(&class_stats);
 
 	local_group = group == sds->local;
 
@@ -8849,6 +8908,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			if (sgs->group_misfit_task_load < load)
 				sgs->group_misfit_task_load = load;
 		}
+
+		update_rq_task_classes_stats(&class_stats, rq);
 	}
 
 	sgs->group_capacity = group->sgc->capacity;
-- 
2.25.1

