Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7963A926
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiK1NOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiK1NNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F671D676;
        Mon, 28 Nov 2022 05:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641217; x=1701177217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2uPfNNplw7xOwTi269F+VNr3fJJfs2c0TJ+7Nw/WlL4=;
  b=W2mD71dOmlZY9WM53EkJ/Uy9G7hyZOgGnRJ14qwTAHhYW/RLkVjqhltN
   CuKkQs3ExkJPIt4eO0JvXCYhXHVkpoh8vBDkouHeSKDrzRmO7F0LsX0Wb
   dWiEwUb+UKsNOXNloc8CSUTIgZ7pJ3PhTtdrM+NN8opTVzbjye6aTVkSe
   BqnP71iOS6AFuL8v2jSc4DfLB8ghR6Gk6683P3ZRFRl6O+DEUNEuQOQus
   ZVLNyI/m+NjIJYpbHlHas1VJMAcNnSUh90JrqcnmR0Ojh6Skyq+1sFrOy
   TPec0XhDsegeMrYxVUnlaLsXWsyKFILWR3RTCHS4kocgHVMRrEiAt2vWL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117115"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381345"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381345"
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
Subject: [PATCH v2 07/22] sched/fair: Compute IPC class scores for load balancing
Date:   Mon, 28 Nov 2022 05:20:45 -0800
Message-Id: <20221128132100.30253-8-ricardo.neri-calderon@linux.intel.com>
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

Compute the joint total (both current and prospective) IPC class score of
a scheduling group and the local scheduling group.

These IPCC statistics are used during asym_packing load balancing. It
implies that the candidate sched group will have one fewer busy CPU after
load balancing. This observation is important for physical cores with
SMT support.

The IPCC score of scheduling groups composed of SMT siblings needs to
consider that the siblings share CPU resources. When computing the total
IPCC score of the scheduling group, divide score from each sibilng by
the number of busy siblings.

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
 * Implemented cleanups and reworks from PeterZ. I took all his
   suggestions, except the computation of the  IPC score before and after
   load balancing. We are computing not the average score, but the *total*.
 * Check for the SD_SHARE_CPUCAPACITY to compute the throughput of the SMT
   siblings of a physical core.
 * Used the new interface names.
 * Reworded commit message for clarity.
---
 kernel/sched/fair.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3a1d6c50a19b..e333f9623b3a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8766,6 +8766,10 @@ struct sg_lb_stats {
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
 #endif
+#ifdef CONFIG_IPC_CLASSES
+	long ipcc_score_after; /* Prospective IPCC score after load balancing */
+	long ipcc_score_before; /* IPCC score before load balancing */
+#endif
 };
 
 /*
@@ -9140,6 +9144,38 @@ static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
 	}
 }
 
+static void update_sg_lb_stats_scores(struct sg_lb_ipcc_stats *sgcs,
+				      struct sg_lb_stats *sgs,
+				      struct sched_group *sg,
+				      int dst_cpu)
+{
+	int busy_cpus, score_on_dst_cpu;
+	long before, after;
+
+	if (!sched_ipcc_enabled())
+		return;
+
+	busy_cpus = sgs->group_weight - sgs->idle_cpus;
+	/* No busy CPUs in the group. No tasks to move. */
+	if (!busy_cpus)
+		return;
+
+	score_on_dst_cpu = arch_get_ipcc_score(sgcs->min_ipcc, dst_cpu);
+
+	before = sgcs->sum_score;
+	after = before - sgcs->min_score;
+
+	/* SMT siblings share throughput. */
+	if (busy_cpus > 1 && sg->flags & SD_SHARE_CPUCAPACITY) {
+		before /= busy_cpus;
+		/* One sibling will become idle after load balance. */
+		after /= busy_cpus - 1;
+	}
+
+	sgs->ipcc_score_after = after + score_on_dst_cpu;
+	sgs->ipcc_score_before = before;
+}
+
 #else /* CONFIG_IPC_CLASSES */
 static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
 				    struct rq *rq)
@@ -9149,6 +9185,14 @@ static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
 static void init_rq_ipcc_stats(struct sg_lb_ipcc_stats *class_sgs)
 {
 }
+
+static void update_sg_lb_stats_scores(struct sg_lb_ipcc_stats *sgcs,
+				      struct sg_lb_stats *sgs,
+				      struct sched_group *sg,
+				      int dst_cpu)
+{
+}
+
 #endif /* CONFIG_IPC_CLASSES */
 
 /**
@@ -9329,6 +9373,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
 	    sched_asym(env, sds, sgs, group)) {
+		update_sg_lb_stats_scores(&sgcs, sgs, group, env->dst_cpu);
 		sgs->group_asym_packing = 1;
 	}
 
-- 
2.25.1

