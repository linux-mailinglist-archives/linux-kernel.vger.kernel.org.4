Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4A68CE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBGEvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBGEus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204FD3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745447; x=1707281447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=W6TuYGPZ71rk8F3QYL8M9R3AwD+pJaLK+sDkNMpMUBo=;
  b=YHYjq52ZX3LEnC+1eAoCUQfYaa7KZQeKg31l1h2r1WsbCvUzmyu8FQgO
   jm5KM5ASexmN+yucnn2vwZ1lonHeU/QnE8RVj+P2VI1iOVDxaF53ZkQWZ
   CXTqo/EuYreSuFxtEF8kCkBGdZNjlwzdudl3Ia8E/dxYBMi0keigkB5mJ
   h47mU/F8HG1yXLadpay4x+LqPF16LoXZ4rQALcLDD4Wf5klRA8+kqpDdl
   A06SFIOTK3spdfkvS6oLB/gzIhlYtBILT8CH3vWxnkGnU5znDmPwwmt1L
   6LiIv5Kr9yPgVqyT1KNwwATi6rsEN4itUNY9dGx+NjELaq1UW/upOgpYM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415623995"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415623995"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653786"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653786"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:46 -0800
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 03/10] sched/fair: Only do asym_packing load balancing from fully idle SMT cores
Date:   Mon,  6 Feb 2023 20:58:31 -0800
Message-Id: <20230207045838.11243-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When balancing load between cores, all the SMT siblings of the destination
CPU, if any, must be idle. Otherwise, pulling new tasks degrades the
throughput of the busy SMT siblings. The overall throughput of the system
remains the same.

When balancing load within an SMT core this consideration is not relevant
relevant. Follow the priorities that hardware indicates.

Using is_core_idle() renders checking !sds->local_stat.sum_nr_running
redundant. Remove it.

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
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 767bec7789ac..80c86462c6f6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9250,12 +9250,14 @@ group_type group_classify(unsigned int imbalance_pct,
  * Check the state of the SMT siblings of both @sds::local and @sg and decide
  * if @dst_cpu can pull tasks.
  *
+ * This function must be called only if all the SMT siblings of @dst_cpu are
+ * idle, if any.
+ *
  * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
  * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
  * only if @dst_cpu has higher priority.
  *
- * If @dst_cpu has SMT siblings, check if there are no running tasks in
- * @sds::local. In such case, decide based on the priority of @sg. Do it only
+ * If @dst_cpu has SMT siblings, decide based on the priority of @sg. Do it only
  * if @sg has exactly one busy CPU (i.e., one more than @sds::local). Bigger
  * imbalances in the number of busy CPUs will be dealt with in
  * find_busiest_group().
@@ -9292,15 +9294,13 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 	}
 
 	/*
-	 * @dst_cpu has SMT siblings. Do asym_packing load balancing only if
-	 * all its siblings are idle (moving tasks between physical cores in
-	 * which some SMT siblings are busy results in the same throughput).
+	 * @dst_cpu has SMT siblings and are also idle.
 	 *
 	 * If the difference in the number of busy CPUs is two or more, let
 	 * find_busiest_group() take care of it. We only care if @sg has
 	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
 	 */
-	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
+	if (sg_busy_cpus == 1)
 		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 
 	return false;
@@ -9314,7 +9314,14 @@ static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
 {
-	/* Only do SMT checks if either local or candidate have SMT siblings */
+	/*
+	 * If the destination CPU has SMT siblings, env->idle != CPU_NOT_IDLE
+	 * is not sufficient. We need to make sure the whole core is idle.
+	 */
+	if (sds->local->flags & SD_SHARE_CPUCAPACITY && !is_core_idle(env->dst_cpu))
+		return false;
+
+	/* Only do SMT checks if either local or candidate have SMT siblings. */
 	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
 	    (group->flags & SD_SHARE_CPUCAPACITY))
 		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
@@ -11261,8 +11268,17 @@ static void nohz_balancer_kick(struct rq *rq)
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
-				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
-				goto unlock;
+				/*
+				 * Always do ASYM_PACKING balance in the SMT
+				 * domain. In upper domains, the core must be
+				 * fully idle.
+				 */
+				if (sd->flags & SD_SHARE_CPUCAPACITY ||
+				    (!(sd->flags & SD_SHARE_CPUCAPACITY) &&
+				     is_core_idle(i))) {
+					flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
+					goto unlock;
+				}
 			}
 		}
 	}
-- 
2.25.1

