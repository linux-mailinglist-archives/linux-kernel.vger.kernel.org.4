Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3868CE8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBGFCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBGFBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472E6A56;
        Mon,  6 Feb 2023 21:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746112; x=1707282112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=s23DDV+a9X4aP0kA4U7st9P3jUXY+WdjiUqKmcmbNZo=;
  b=Sv+DsJxd21ekmcvCS9JQXGV8feTCQx8c9HGtN/ZIuR/YpRcDacT2EfAs
   +2YDbamk127Uqfu//18/Gl2XGmohoQ7ofFyyrMfjieT6oaeYNPzCQ8Yn6
   cU9RM1/TqLOQvasG4/JTjGOb85/DIBOA+3DJEWR47yW9LOlK0boUv/doM
   JOGbwP9WuxFggbMK9f5FiqrtWObLgFVtdWnXL7EzWWWWnNnYMAWwDaSUM
   wVLmDrw3wVGQd8cCNjL36Ch0+031pQb5Cc8uNaR4sstEY6/0uIXk3LE2K
   2zMWPmIWc+UU/fhG73oapQTCqfQNu35NM7g70AYpAJiIaZOlDAWXVM1sB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625809"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625809"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657717"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657717"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:42 -0800
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
Subject: [PATCH v3 07/24] sched/fair: Compute IPC class scores for load balancing
Date:   Mon,  6 Feb 2023 21:10:48 -0800
Message-Id: <20230207051105.11575-8-ricardo.neri-calderon@linux.intel.com>
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

Compute the joint total (both current and prospective) IPC class score of
a scheduling group and the local scheduling group.

These IPCC statistics are used during idle load balancing. The candidate
scheduling group will have one fewer busy CPU after load balancing. This
observation is important for cores with SMT support.

The IPCC score of scheduling groups composed of SMT siblings needs to
consider that the siblings share CPU resources. When computing the total
IPCC score of the scheduling group, divide score of each sibling by the
number of busy siblings.

Collect IPCC statistics for asym_packing and fully_busy scheduling groups.
When picking a busiest group, they are used to break ties between otherwise
identical groups.

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
 * Also collect IPCC stats for fully_busy sched groups.
 * Restrict use of IPCC stats to SD_ASYM_PACKING. (Ionela)
 * Handle errors of arch_get_ipcc_score(). (Ionela)

Changes since v1:
 * Implemented cleanups and reworks from PeterZ. I took all his
   suggestions, except the computation of the  IPC score before and after
   load balancing. We are computing not the average score, but the *total*.
 * Check for the SD_SHARE_CPUCAPACITY to compute the throughput of the SMT
   siblings of a physical core.
 * Used the new interface names.
 * Reworded commit message for clarity.
---
 kernel/sched/fair.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d773380a95b3..b6165aa8a376 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8901,6 +8901,8 @@ struct sg_lb_stats {
 	unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
 	unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
 	unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
+	long ipcc_score_after; /* Prospective IPCC score after load balancing */
+	unsigned long ipcc_score_before; /* IPCC score before load balancing */
 #endif
 };
 
@@ -9287,6 +9289,62 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
 	}
 }
 
+static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
+				      struct sched_group *sg,
+				      struct lb_env *env)
+{
+	unsigned long score_on_dst_cpu, before;
+	int busy_cpus;
+	long after;
+
+	if (!sched_ipcc_enabled())
+		return;
+
+	/*
+	 * IPCC scores are only useful during idle load balancing. For now,
+	 * only asym_packing uses IPCC scores.
+	 */
+	if (!(env->sd->flags & SD_ASYM_PACKING) ||
+	    env->idle == CPU_NOT_IDLE)
+		return;
+
+	/*
+	 * IPCC scores are used to break ties only between these types of
+	 * groups.
+	 */
+	if (sgs->group_type != group_fully_busy &&
+	    sgs->group_type != group_asym_packing)
+		return;
+
+	busy_cpus = sgs->group_weight - sgs->idle_cpus;
+
+	/* No busy CPUs in the group. No tasks to move. */
+	if (!busy_cpus)
+		return;
+
+	score_on_dst_cpu = arch_get_ipcc_score(sgs->min_ipcc, env->dst_cpu);
+
+	/*
+	 * Do not use IPC scores. sgs::ipcc_score_{after, before} will be zero
+	 * and not used.
+	 */
+	if (IS_ERR_VALUE(score_on_dst_cpu))
+		return;
+
+	before = sgs->sum_score;
+	after = before - sgs->min_score;
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
 static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
 				    struct rq *rq)
@@ -9296,6 +9354,13 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
 static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
 {
 }
+
+static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
+				      struct sched_group *sg,
+				      struct lb_env *env)
+{
+}
+
 #endif /* CONFIG_IPC_CLASSES */
 
 /**
@@ -9457,6 +9522,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
+	if (!local_group)
+		update_sg_lb_stats_scores(sgs, group, env);
+
 	/* Computing avg_load makes sense only when group is overloaded */
 	if (sgs->group_type == group_overloaded)
 		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-- 
2.25.1

