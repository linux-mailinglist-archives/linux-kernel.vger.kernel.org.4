Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF65B42D9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIIXGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIIXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AFB112B13
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764795; x=1694300795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tvE2qSOAJYgPdimf6y9rbAfyRdXmrVfr0H+iQAnFajc=;
  b=AHXDIVfb7Yozs3wxCMCjPmW9yhJsowylDipVEt4VQLw/e8F4t0FGmkl7
   uyy4LR63H4CXFFFDziuDj0gUCT41+uL1/1X4Gd+xZqDCCYlw7np5N4E85
   oKr0LtT54T5ABqp1uvLNB9FlY59Gt0lRTz9319CbCTi9I0eRCOZM/a7Zi
   PU5qJM6xuJ2KI4ZE3BZj2sEvSWMbL6IanT4LKk/7aBUagHt/JU/eBVaVw
   63WY8bIKiID3RwUwxj8SRVNXfDAcmNpbhMCt6kP5ZpIqV4hdBvBeF+Lxk
   Wab3bEbN9VtSKW8BmFYK1cUbpHW9P9pZXpzU+TTLbPUZKUOAcLMedsu4s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386910"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386910"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354993"
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
Subject: [RFC PATCH 08/23] sched/fair: Compute task-class performance scores for load balancing
Date:   Fri,  9 Sep 2022 16:11:50 -0700
Message-Id: <20220909231205.14009-9-ricardo.neri-calderon@linux.intel.com>
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

Compute both the current and the prospective the task-class performance
of a scheduling group. As task-class statistics are used during asym_
packing load balancing, the scheduling group will become idle.

For a scheduling group with only one CPU, the prospective performance is
the performance of its current task if placed on the destination CPU.

In a scheduling group composed of SMT siblings the current tasks of all
CPUs share the resources of the core. Divide the task-class performance of
scheduling group by the number of busy CPUs.

After load balancing, the throughput of the siblings that remain busy
increases. Plus, the destination CPU now contributes to the overall
throughput.

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
 kernel/sched/fair.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58a435a04c1c..97731f81b570 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8405,6 +8405,8 @@ struct sg_lb_stats {
 	enum group_type group_type;
 	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
+	long task_class_score_after; /* Prospective task-class score after load balancing */
+	long task_class_score_before; /* Task-class score before load balancing */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -8732,6 +8734,49 @@ static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sg
 	class_sgs->min_score = score;
 	class_sgs->p_min_score = rq->curr;
 }
+
+static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *class_sgs,
+					     struct sg_lb_stats *sgs,
+					     int dst_cpu)
+{
+	int group_score, group_score_without, score_on_dst_cpu;
+	int busy_cpus = sgs->group_weight - sgs->idle_cpus;
+
+	if (!sched_task_classes_enabled())
+		return;
+
+	/* No busy CPUs in the group. No tasks to move. */
+	if (!busy_cpus)
+		return;
+
+	score_on_dst_cpu = arch_get_task_class_score(class_sgs->p_min_score->class,
+						     dst_cpu);
+
+	/*
+	 * The simpest case. The single busy CPU in the current group will
+	 * become idle after pulling its current task. The destination CPU is
+	 * idle.
+	 */
+	if (busy_cpus == 1) {
+		sgs->task_class_score_before = class_sgs->sum_score;
+		sgs->task_class_score_after = score_on_dst_cpu;
+		return;
+	}
+
+	/*
+	 * Now compute the group score with and without the task with the
+	 * lowest score. We assume that the tasks that remain in the group share
+	 * the CPU resources equally.
+	 */
+	group_score = class_sgs->sum_score / busy_cpus;
+
+	group_score_without =  (class_sgs->sum_score - class_sgs->min_score) /
+			       (busy_cpus - 1);
+
+	sgs->task_class_score_after = group_score_without + score_on_dst_cpu;
+	sgs->task_class_score_before = group_score;
+}
+
 #else /* CONFIG_SCHED_TASK_CLASSES */
 static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
 					 struct rq *rq)
@@ -8741,6 +8786,13 @@ static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sg
 static void init_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs)
 {
 }
+
+static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *class_sgs,
+					     struct sg_lb_stats *sgs,
+					     int dst_cpu)
+{
+}
+
 #endif /* CONFIG_SCHED_TASK_CLASSES */
 
 /**
@@ -8920,6 +8972,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
 	    sched_asym(env, sds, sgs, group)) {
+		compute_ilb_sg_task_class_scores(&class_stats, sgs, env->dst_cpu);
 		sgs->group_asym_packing = 1;
 	}
 
-- 
2.25.1

