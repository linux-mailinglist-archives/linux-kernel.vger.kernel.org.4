Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB772D86F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbjFMEWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjFMEVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CB10E3;
        Mon, 12 Jun 2023 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630104; x=1718166104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hUm0MDoGkoQOMZz9UHTaezep/GE1PjQ+RBjcMUHjEnk=;
  b=X+qY9K0s7u3fT6Fzjq2rOgyz0FI52MrgIfagV1O9je6MN35B3eIhvSOm
   C0UlXB9ik5Ylvh359yS4al98ajnWVO8pL23Ti9w22pqRKbhvuTGvTCUEq
   o0uOVeYqy3/lDrYvFB1EWFHzK5LWJl6dYUHxOupJMtUC9FduydLBq7xs3
   19OqX0kkrfu7Nnlq45/5Futeds869lA588EdO7lLZgLTgV4yCjTOlYZmu
   GIQyw0m81/aAkx4mPeH2OOivGmrQRyEGpXh6s2LIV1XfFcD5U521nduBZ
   gFOkGc4rcxGG5y9CIyJraVk1IqOPI0Wg10uI59VKVYaV4RYnyDRf4zo6b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222107"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222107"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854953"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854953"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:42 -0700
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
Subject: [PATCH v4 07/24] sched/fair: Compute IPC class scores for load balancing
Date:   Mon, 12 Jun 2023 21:24:05 -0700
Message-Id: <20230613042422.5344-8-ricardo.neri-calderon@linux.intel.com>
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

When using IPCC scores to break ties between two scheduling groups, it is
necessary to consider both the current score and the score that would
result after load balancing.

Compute the combined IPC class score of a scheduling group and the local
scheduling group. Compute both the current score and the prospective score.

Collect IPCC statistics only for asym_packing and fully_busy scheduling
groups. These are the only cases that use IPCC scores.

These IPCC statistics are used during idle load balancing. The candidate
scheduling group will have one fewer busy CPU after load balancing. This
observation is important for cores with SMT support.

The IPCC score of scheduling groups composed of SMT siblings needs to
consider that the siblings share CPU resources. When computing the total
IPCC score of the scheduling group, divide the score of each sibling by
the number of busy siblings.

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
 * None

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
index c0cab5e501b6..a51c65c9335f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9114,6 +9114,8 @@ struct sg_lb_stats {
 	unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
 	unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
 	unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
+	long ipcc_score_after; /* Prospective IPCC score after load balancing */
+	unsigned long ipcc_score_before; /* IPCC score before load balancing */
 #endif
 };
 
@@ -9452,6 +9454,62 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
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
@@ -9461,6 +9519,13 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
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
@@ -9620,6 +9685,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
+	if (!local_group)
+		update_sg_lb_stats_scores(sgs, group, env);
+
 	/* Computing avg_load makes sense only when group is overloaded */
 	if (sgs->group_type == group_overloaded)
 		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
-- 
2.25.1

