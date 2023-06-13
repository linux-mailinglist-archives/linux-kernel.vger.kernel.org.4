Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC8F72D875
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbjFMEWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbjFMEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:22:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B96171D;
        Mon, 12 Jun 2023 21:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630109; x=1718166109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/I49eIsDquR6DFYsO93kE0UH3pQmCgZ0Nh4gXSalcss=;
  b=NjjKNrQXJsw2RrnH4XFLz/Y+huzpJBJMxesqJW03q34Gt4I0hc9fHz+3
   s/e4ycpeOpeTHP0oMXmo2P1N7DAIL+ihNbegVQkMYYaHgx/e67TB+pJCz
   lhoHmPtMd0vMBlQ3HZAKJgTo+vXAjxQO10he19oH1kds/bO+cVkovvyup
   /b3uxnV84NRSMXQreySCkfAyJ3TE/Td/lJsIaeZPuWsU6zLBf3F6+JWt0
   /KW9AyIsRNEW5IDOX7BmbvGc0+oMxq4WnolXaIf8nu8P5tbU69HKfK0JI
   Ir6f65tYgEmBD++b5rRh7ckJJla53zMKePdDqvxIk9jEK0HTuOqT9ixH7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222148"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222148"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854962"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854962"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:47 -0700
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
Subject: [PATCH v4 10/24] sched/fair: Use IPCC scores to select a busiest runqueue
Date:   Mon, 12 Jun 2023 21:24:08 -0700
Message-Id: <20230613042422.5344-11-ricardo.neri-calderon@linux.intel.com>
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

Use IPCC scores to break a tie between two runqueues with the same priority
and number of running tasks: select the runqueue of which the task enqueued
last would get a higher IPC boost when migrated to the destination CPU.
(These tasks are migrated first during load balance.)

For now, restrict the utilization of IPCC scores to scheduling domains
marked with the SD_ASYM_PACKING flag.

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
 kernel/sched/fair.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcec791ede4f..da3e009eef42 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9564,6 +9564,41 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
 	return sched_asym_ipcc_prefer(a_stats, b_stats);
 }
 
+/**
+ * ipcc_score_delta - Get the IPCC score delta wrt the load balance's dst_cpu
+ * @rq:		A runqueue
+ * @env:	Load balancing environment
+ *
+ * Returns: The IPCC score delta that the last task enqueued in @rq would get
+ * if placed in the destination CPU of @env. LONG_MIN to indicate that the
+ * delta should not be used.
+ */
+static long ipcc_score_delta(struct rq *rq, struct lb_env *env)
+{
+	unsigned long score_src, score_dst;
+	unsigned short ipcc;
+
+	if (!sched_ipcc_enabled())
+		return LONG_MIN;
+
+	/* Only asym_packing uses IPCC scores at the moment. */
+	if (!(env->sd->flags & SD_ASYM_PACKING))
+		return LONG_MIN;
+
+	if (rq_last_task_ipcc(env->dst_cpu, rq, &ipcc))
+		return LONG_MIN;
+
+	score_dst = arch_get_ipcc_score(ipcc, env->dst_cpu);
+	if (IS_ERR_VALUE(score_dst))
+		return LONG_MIN;
+
+	score_src = arch_get_ipcc_score(ipcc, cpu_of(rq));
+	if (IS_ERR_VALUE(score_src))
+		return LONG_MIN;
+
+	return score_dst - score_src;
+}
+
 #else /* CONFIG_IPC_CLASSES */
 static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
 				    struct rq *rq)
@@ -9594,6 +9629,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
 	return false;
 }
 
+static long ipcc_score_delta(struct rq *rq, struct lb_env *env)
+{
+	return LONG_MIN;
+}
+
 #endif /* CONFIG_IPC_CLASSES */
 
 /**
@@ -10769,6 +10809,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 {
 	struct rq *busiest = NULL, *rq;
 	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
+	long busiest_ipcc_delta = LONG_MIN;
 	unsigned int busiest_nr = 0;
 	int i;
 
@@ -10885,6 +10926,26 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			if (busiest_nr < nr_running) {
 				busiest_nr = nr_running;
 				busiest = rq;
+
+				/*
+				 * Remember the IPCC score of the busiest
+				 * runqueue. We may need it to break a tie with
+				 * other queues with equal nr_running.
+				 */
+				busiest_ipcc_delta = ipcc_score_delta(busiest, env);
+			/*
+			 * For ties, select @rq if doing would give its last
+			 * queued task a bigger IPC boost when migrated to
+			 * dst_cpu.
+			 */
+			} else if (busiest_nr == nr_running) {
+				long delta = ipcc_score_delta(rq, env);
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

