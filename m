Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52268CE89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBGFCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjBGFBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462E55A2;
        Mon,  6 Feb 2023 21:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746111; x=1707282111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9U3HT2fPkvVUOBW50CYIJ3B+L4hO5S4Nc1uYuLdQPpY=;
  b=aC0QiTkNKtnMvNl23FvuS1tVrjynTfR9uEtl8VzdUW+9Y/2E5f2tORgs
   414kjOfSowGsHPg/CX3gTgBzYlJk+5r4hOGMZeaWBMhmlisHG7SNRVK+K
   cNZUs0BhJC/oZM422gUvFhP9W9M7uQaZRw07TRlxEIE1evtZeCmlFSKim
   gSDNOYgWQxz2Sn1BCfbmAwQOZAXsY/58ONzAtIxFeQ6RS2fFK6O1un5Xv
   kojvIHxSnaZa+JTTsHXe7mCgbA16TVdyYKInn75Ub4XG7WIGfSehJaWrF
   U8xInG+XqJTd3lazXpDkwsaY/3H9uTXdU2ojsY2RiCkt7p6wZO6HCxnvH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625795"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625795"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657713"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657713"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:41 -0800
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
Subject: [PATCH v3 06/24] sched/fair: Collect load-balancing stats for IPC classes
Date:   Mon,  6 Feb 2023 21:10:47 -0800
Message-Id: <20230207051105.11575-7-ricardo.neri-calderon@linux.intel.com>
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

When selecting a busiest scheduling group, the IPC class of the current
task can be used to select between two scheduling groups of types asym_
packing or fully_busy that are otherwise identical.

Compute the IPC class performance score for a scheduling group. It
is the sum of the scores of the current tasks of all the runqueues.

Also, keep track of the class of the task with the lowest IPC class score
in the scheduling group.

These two metrics will be used during idle load balancing to compute the
current and the prospective IPC class score of a scheduling group.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Also excluded deadline and realtime tasks from IPCC stats. (Dietmar)
 * Also excluded tasks that cannot run on the destination CPU from the
   IPCC stats.
 * Folded struct sg_lb_ipcc_stats into struct sg_lb_stats. (Dietmar)
 * Reworded description sg_lb_stats::min_ipcc. (Ionela)
 * Handle errors of arch_get_ipcc_score(). (Ionela)

Changes since v1:
 * Implemented cleanups and reworks from PeterZ. Thanks!
 * Used the new interface names.
---
 kernel/sched/fair.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ada2d18b934..d773380a95b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8897,6 +8897,11 @@ struct sg_lb_stats {
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
 #endif
+#ifdef CONFIG_IPC_CLASSES
+	unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
+	unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
+	unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
+#endif
 };
 
 /*
@@ -9240,6 +9245,59 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+#ifdef CONFIG_IPC_CLASSES
+static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
+{
+	/* All IPCC stats have been set to zero in update_sg_lb_stats(). */
+	sgs->min_score = ULONG_MAX;
+}
+
+/* Called only if cpu_of(@rq) is not idle and has tasks running. */
+static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
+				    struct rq *rq)
+{
+	struct task_struct *curr;
+	unsigned short ipcc;
+	unsigned long score;
+
+	if (!sched_ipcc_enabled())
+		return;
+
+	curr = rcu_dereference(rq->curr);
+	if (!curr || (curr->flags & PF_EXITING) || is_idle_task(curr) ||
+	    task_is_realtime(curr) ||
+	    !cpumask_test_cpu(dst_cpu, curr->cpus_ptr))
+		return;
+
+	ipcc = curr->ipcc;
+	score = arch_get_ipcc_score(ipcc, cpu_of(rq));
+
+	/*
+	 * Ignore tasks with invalid scores. When finding the busiest group, we
+	 * prefer those with higher sum_score. This group will not be selected.
+	 */
+	if (IS_ERR_VALUE(score))
+		return;
+
+	sgs->sum_score += score;
+
+	if (score < sgs->min_score) {
+		sgs->min_score = score;
+		sgs->min_ipcc = ipcc;
+	}
+}
+
+#else /* CONFIG_IPC_CLASSES */
+static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
+				    struct rq *rq)
+{
+}
+
+static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
+{
+}
+#endif /* CONFIG_IPC_CLASSES */
+
 /**
  * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
  * @dst_cpu:	Destination CPU of the load balancing
@@ -9332,6 +9390,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	int i, nr_running, local_group;
 
 	memset(sgs, 0, sizeof(*sgs));
+	init_rq_ipcc_stats(sgs);
 
 	local_group = group == sds->local;
 
@@ -9381,6 +9440,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			if (sgs->group_misfit_task_load < load)
 				sgs->group_misfit_task_load = load;
 		}
+
+		update_sg_lb_ipcc_stats(env->dst_cpu, sgs, rq);
 	}
 
 	sgs->group_capacity = group->sgc->capacity;
-- 
2.25.1

