Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684E68CE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjBGFCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBGFB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45BC643;
        Mon,  6 Feb 2023 21:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746114; x=1707282114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BrjwTRAQcpfuOeAV7Rg7Zm/X0IgwzgEOiAKjPiNKh1M=;
  b=ZGnjxVpa8iBCrxYykm4azWnUE82ILNVXXrmb3XL1r1GVuqN/eJz9Fv6+
   BG5KtJsW2kvHDhW8u15yamKhtbsHFWIPtI5bZy6b62TNAOHUIfg8BTl6q
   U+sxFHy32zkOO96x2ls6L01fxLkJfrLFYAAqUmWnvEcC3BtRfXWzNNNnD
   wP+BBoG13YwvVkI85fwTRqaZp3LSWQKqYSjGYX+zBXadW27ShXC/Q0wv5
   6eEhN8XbB0PTIvYMag6ip7fv7IhxmdWx61s09inzXdO9nfMYk/YOUB8lI
   R8WIEstc3TnFW/izgAh1XJg4cMWsQLMitCr/4HASdp/tYqyQKsmegaFA6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625849"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625849"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657730"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657730"
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
Subject: [PATCH v3 10/24] sched/fair: Use IPCC scores to select a busiest runqueue
Date:   Mon,  6 Feb 2023 21:10:51 -0800
Message-Id: <20230207051105.11575-11-ricardo.neri-calderon@linux.intel.com>
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

For two runqueues of equal priority and equal number of running of tasks,
select the one whose current task would have the highest IPC class score
if placed on the destination CPU.

For now, use IPCC scores only for scheduling domains with the
SD_ASYM_PACKING flag.

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
 * Only use IPCC scores to break ties if the sched domain uses
   asym_packing. (Ionela)
 * Handle errors of arch_get_ipcc_score(). (Ionela)

Changes since v1:
 * Fixed a bug when selecting a busiest runqueue: when comparing two
   runqueues with equal nr_running, we must compute the IPCC score delta
   of both.
 * Renamed local variables to improve the layout of the code block.
   (PeterZ)
 * Used the new interface names.
---
 kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 72d88270b320..d3c22dc145f7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9399,6 +9399,37 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
 	return sched_asym_ipcc_prefer(a_stats, b_stats);
 }
 
+/**
+ * ipcc_score_delta - Get the IPCC score delta wrt the load balance's dst_cpu
+ * @p:		A task
+ * @env:	Load balancing environment
+ *
+ * Returns: The IPCC score delta that @p would get if placed in the destination
+ * CPU of @env. LONG_MIN to indicate that the delta should not be used.
+ */
+static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
+{
+	unsigned long score_src, score_dst;
+	unsigned short ipcc = p->ipcc;
+
+	if (!sched_ipcc_enabled())
+		return LONG_MIN;
+
+	/* Only asym_packing uses IPCC scores at the moment. */
+	if (!(env->sd->flags & SD_ASYM_PACKING))
+		return LONG_MIN;
+
+	score_dst = arch_get_ipcc_score(ipcc, env->dst_cpu);
+	if (IS_ERR_VALUE(score_dst))
+		return LONG_MIN;
+
+	score_src = arch_get_ipcc_score(ipcc, task_cpu(p));
+	if (IS_ERR_VALUE(score_src))
+		return LONG_MIN;
+
+	return score_dst - score_src;
+}
+
 #else /* CONFIG_IPC_CLASSES */
 static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
 				    struct rq *rq)
@@ -9429,6 +9460,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
 	return false;
 }
 
+static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
+{
+	return LONG_MIN;
+}
+
 #endif /* CONFIG_IPC_CLASSES */
 
 /**
@@ -10589,6 +10625,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 {
 	struct rq *busiest = NULL, *rq;
 	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
+	long busiest_ipcc_delta = LONG_MIN;
 	unsigned int busiest_nr = 0;
 	int i;
 
@@ -10705,8 +10742,35 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 		case migrate_task:
 			if (busiest_nr < nr_running) {
+				struct task_struct *curr;
+
 				busiest_nr = nr_running;
 				busiest = rq;
+
+				/*
+				 * Remember the IPCC score delta of busiest::curr.
+				 * We may need it to break a tie with other queues
+				 * with equal nr_running.
+				 */
+				curr = rcu_dereference(busiest->curr);
+				busiest_ipcc_delta = ipcc_score_delta(curr, env);
+			/*
+			 * If rq and busiest have the same number of running
+			 * tasks and IPC classes are supported, pick rq if doing
+			 * so would give rq::curr a bigger IPC boost on dst_cpu.
+			 */
+			} else if (busiest_nr == nr_running) {
+				struct task_struct *curr;
+				long delta;
+
+				curr = rcu_dereference(rq->curr);
+				delta = ipcc_score_delta(curr, env);
+
+				if (busiest_ipcc_delta < delta) {
+					busiest_ipcc_delta = delta;
+					busiest_nr = nr_running;
+					busiest = rq;
+				}
 			}
 			break;
 
-- 
2.25.1

