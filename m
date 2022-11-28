Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339463A92C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiK1NOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiK1NNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F121D675;
        Mon, 28 Nov 2022 05:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641217; x=1701177217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bGQyQKNPbV4jkYdbDYkNg5GZCIoRHz5qvQ3UspaGSq0=;
  b=aS5gpUB51cG2KwtKRyqqMPr/zzbMb3muopZIkuvj2n9GJlu08ulRQAVM
   sp/YONifCZxsl+vDaQaHzCMLfWRCxyvsKL9MBdwNKXxMQJNZikhQ58SgZ
   8YtqjHIxJ2Nn9PegIYdj7xa3Qi9fnWrv9OvRxJ/hFIGEQThkBC7Y4PigB
   5TtYthlWfGoAzzCyXn47u6Gb5yn3Z9bWzaC3kf5Uax9XOm0ZdqkfZdrGp
   7hCFNA5sKqV3pJmdBIyArMg6TUnW7W2F+0QIETBZGZwISm7/d0BT+ikr3
   AGiZ8qPbIRU9uCIcyGKtuKQ6WoXZntzLVhTRezo3FoPV84ak0JiRNXPk/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117105"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117105"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381342"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381342"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:32 -0800
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 06/22] sched/fair: Collect load-balancing stats for IPC classes
Date:   Mon, 28 Nov 2022 05:20:44 -0800
Message-Id: <20221128132100.30253-7-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When selecting a busiest scheduling group, the IPC class of the current
task can be used to select between two scheduling groups of equal
asym_packing priority and number of running tasks.

Compute a new IPC class performance score for a scheduling group. It
is the sum of the performance of the current tasks of all the runqueues.

Also, keep track of the task with the lowest IPC class score on the
scheduling group.

These two metrics will be used during idle load balancing to compute the
current and the prospective task-class performance of a scheduling
group.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
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
Changes since v1:
 * Implemented cleanups and reworks from PeterZ. Thanks!
 * Used the new interface names.
---
 kernel/sched/fair.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 224107278471..3a1d6c50a19b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9100,6 +9100,57 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+struct sg_lb_ipcc_stats {
+	int min_score;	/* Min(score(rq->curr->ipcc)) */
+	int min_ipcc;	/* Min(rq->curr->ipcc) */
+	long sum_score; /* Sum(score(rq->curr->ipcc)) */
+};
+
+#ifdef CONFIG_IPC_CLASSES
+static void init_rq_ipcc_stats(struct sg_lb_ipcc_stats *sgcs)
+{
+	*sgcs = (struct sg_lb_ipcc_stats) {
+		.min_score = INT_MAX,
+	};
+}
+
+/** Called only if cpu_of(@rq) is not idle and has tasks running. */
+static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
+				    struct rq *rq)
+{
+	struct task_struct *curr;
+	unsigned short ipcc;
+	int score;
+
+	if (!sched_ipcc_enabled())
+		return;
+
+	curr = rcu_dereference(rq->curr);
+	if (!curr || (curr->flags & PF_EXITING) || is_idle_task(curr))
+		return;
+
+	ipcc = curr->ipcc;
+	score = arch_get_ipcc_score(ipcc, cpu_of(rq));
+
+	sgcs->sum_score += score;
+
+	if (score < sgcs->min_score) {
+		sgcs->min_score = score;
+		sgcs->min_ipcc = ipcc;
+	}
+}
+
+#else /* CONFIG_IPC_CLASSES */
+static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
+				    struct rq *rq)
+{
+}
+
+static void init_rq_ipcc_stats(struct sg_lb_ipcc_stats *class_sgs)
+{
+}
+#endif /* CONFIG_IPC_CLASSES */
+
 /**
  * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
  * @dst_cpu:	Destination CPU of the load balancing
@@ -9212,9 +9263,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
 {
+	struct sg_lb_ipcc_stats sgcs;
 	int i, nr_running, local_group;
 
 	memset(sgs, 0, sizeof(*sgs));
+	init_rq_ipcc_stats(&sgcs);
 
 	local_group = group == sds->local;
 
@@ -9264,6 +9317,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			if (sgs->group_misfit_task_load < load)
 				sgs->group_misfit_task_load = load;
 		}
+
+		update_sg_lb_ipcc_stats(&sgcs, rq);
 	}
 
 	sgs->group_capacity = group->sgc->capacity;
-- 
2.25.1

