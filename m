Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAA72D86E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjFMEWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjFMEVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F210DF;
        Mon, 12 Jun 2023 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630103; x=1718166103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pYXtUSdKAZn71AT9JcTrqnvDxSzKtU4csFEI6Z9hgNU=;
  b=gyz2BBm/6c/j3lsDUYzclbhGI8H68562IcU+HM3JyG+V8ZuZRFoXXwg5
   9rYlmc4sOAFMBplg9Dr6UFcvODUoqdCpokCsUmi2nLIDeMtSWtnW9OXVO
   DouGE9ZwjM+01UflO3+5J1gEJACa/02eiZoFNtDXCn+6+FhC1xtxEZQ5h
   pbzi4P2Z9A/2itaHbbxgA3bS5i3zQd+j+UjSHA/N9UtkiFAhtBHJPio1X
   4svRtHBa5Jk1ZsvKwq71YnlFIhGM/b4OQFKnqjo3pj6rKM4Y+yktW6rN5
   TFrvIA4jEDneRUmKKkUNvCDOPEFSEzn6gAC7fRAMP6g8tVgkyFUFxYFAg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222096"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222096"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854950"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854950"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:41 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH v4 06/24] sched/fair: Collect load-balancing stats for IPC classes
Date:   Mon, 12 Jun 2023 21:24:04 -0700
Message-Id: <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When selecting the busiest scheduling group between two otherwise identical
groups of types asym_packing or fully_busy, IPC classes can be used to
break the tie.

Compute the IPC class performance score for a scheduling group. It is
defined as the sum of the IPC scores of the tasks at the back of each
runqueue in the group. Load balancing starts by pulling tasks from the back
of the runqueue first, making this tiebreaker more useful.

Also, track the IPC class with the lowest score in the scheduling group. A
task of this class will be pulled when the destination CPU has lower
priority than the fully_busy busiest group.

These two metrics will be used during idle load balancing to compute the
current and the potential IPC class score of a scheduling group in a
subsequent changeset.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Do not compute the IPCC stats using the current tasks of runqueues.
   Instead, use the tasks at the back of the queue. These are the tasks
   that will be pulled first during load balance. (Vincent)

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
 kernel/sched/fair.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6189d1a45635..c0cab5e501b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9110,6 +9110,11 @@ struct sg_lb_stats {
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
@@ -9387,6 +9392,77 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+#ifdef CONFIG_IPC_CLASSES
+static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
+{
+	/* All IPCC stats have been set to zero in update_sg_lb_stats(). */
+	sgs->min_score = ULONG_MAX;
+}
+
+static int rq_last_task_ipcc(int dst_cpu, struct rq *rq, unsigned short *ipcc)
+{
+	struct list_head *tasks = &rq->cfs_tasks;
+	struct task_struct *p;
+	struct rq_flags rf;
+	int ret = -EINVAL;
+
+	rq_lock_irqsave(rq, &rf);
+	if (list_empty(tasks))
+		goto out;
+
+	p = list_last_entry(tasks, struct task_struct, se.group_node);
+	if (p->flags & PF_EXITING || is_idle_task(p) ||
+	    !cpumask_test_cpu(dst_cpu, p->cpus_ptr))
+		goto out;
+
+	ret = 0;
+	*ipcc = p->ipcc;
+out:
+	rq_unlock(rq, &rf);
+	return ret;
+}
+
+/* Called only if cpu_of(@rq) is not idle and has tasks running. */
+static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
+				    struct rq *rq)
+{
+	unsigned short ipcc;
+	unsigned long score;
+
+	if (!sched_ipcc_enabled())
+		return;
+
+	if (rq_last_task_ipcc(dst_cpu, rq, &ipcc))
+		return;
+
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
  * sched_use_asym_prio - Check whether asym_packing priority must be used
  * @sd:		The scheduling domain of the load balancing
@@ -9477,6 +9553,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	int i, nr_running, local_group;
 
 	memset(sgs, 0, sizeof(*sgs));
+	init_rq_ipcc_stats(sgs);
 
 	local_group = group == sds->local;
 
@@ -9526,6 +9603,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			if (sgs->group_misfit_task_load < load)
 				sgs->group_misfit_task_load = load;
 		}
+
+		update_sg_lb_ipcc_stats(env->dst_cpu, sgs, rq);
 	}
 
 	sgs->group_capacity = group->sgc->capacity;
-- 
2.25.1

