Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3C63A933
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiK1NOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiK1NNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697E21DA63;
        Mon, 28 Nov 2022 05:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641218; x=1701177218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QuRfJtcjeJpezXilnQW60/bNiOmEuQ40ZOh0UG1TU4A=;
  b=TIsGMRdxitwIt/fUtN7V2nT9X9lBWZouyurJtfOyx5dZUdoKk5707IcM
   ntl1vDzJKPn8i6poAh9txSBxi0C2G5iI/h8rjS1y2oP7ctsQRaht66/n1
   uqOaFjze8szn7zOvzPmIBeRoYwUMJyMTM6tBQFzhmfq37GvBQnHWedF5z
   aWOCLe9AJHDitFtq/Ate8xOn2siFldEWRvIAvBMpk2ArqyAJ9YcUcE5fC
   3J/9+YbwR0Vmm8raxkSNZRwe033ILMwJ7yuw26li5ap4Cwc026U+exMq8
   KZKXB3hHUiWzqhBx8eApRgGKCtjM55iU4taaFJM2vb4sxXokII/iClpyt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117137"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117137"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381354"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381354"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:33 -0800
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
Subject: [PATCH v2 09/22] sched/fair: Use IPC class score to select a busiest runqueue
Date:   Mon, 28 Nov 2022 05:20:47 -0800
Message-Id: <20221128132100.30253-10-ricardo.neri-calderon@linux.intel.com>
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

For two runqueues of equal priority and equal number of running of tasks,
select the one whose current task would have the highest IPC class score
if placed on the destination CPU.

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
 * Fixed a bug when selecting a busiest runqueue: when comparing two
   runqueues with equal nr_running, we must compute the IPCC score delta
   of both.
 * Renamed local variables to improve the layout of the code block.
   (PeterZ)
 * Used the new interface names.
---
 kernel/sched/fair.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8b181c31842..113470bbd7a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9233,6 +9233,24 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
 	return sched_asym_ipcc_prefer(a_stats, b_stats);
 }
 
+/**
+ * ipcc_score_delta - Get the IPCC score delta on a different CPU
+ * @p:		A task
+ * @alt_cpu:	A prospective CPU to place @p
+ *
+ * Returns: The IPCC score delta that @p would get if placed on @alt_cpu
+ */
+static int ipcc_score_delta(struct task_struct *p, int alt_cpu)
+{
+	unsigned long ipcc = p->ipcc;
+
+	if (!sched_ipcc_enabled())
+		return INT_MIN;
+
+	return arch_get_ipcc_score(ipcc, alt_cpu) -
+	       arch_get_ipcc_score(ipcc, task_cpu(p));
+}
+
 #else /* CONFIG_IPC_CLASSES */
 static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
 				    struct rq *rq)
@@ -9258,6 +9276,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
 	return false;
 }
 
+static int ipcc_score_delta(struct task_struct *p, int alt_cpu)
+{
+	return INT_MIN;
+}
+
 #endif /* CONFIG_IPC_CLASSES */
 
 /**
@@ -10419,8 +10442,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 {
 	struct rq *busiest = NULL, *rq;
 	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
+	int i, busiest_ipcc_delta = INT_MIN;
 	unsigned int busiest_nr = 0;
-	int i;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		unsigned long capacity, load, util;
@@ -10526,8 +10549,37 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 		case migrate_task:
 			if (busiest_nr < nr_running) {
+				struct task_struct *curr;
+
 				busiest_nr = nr_running;
 				busiest = rq;
+
+				/*
+				 * Remember the IPC score delta of busiest::curr.
+				 * We may need it to break a tie with other queues
+				 * with equal nr_running.
+				 */
+				curr = rcu_dereference(busiest->curr);
+				busiest_ipcc_delta = ipcc_score_delta(curr,
+								      env->dst_cpu);
+			/*
+			 * If rq and busiest have the same number of running
+			 * tasks, pick rq if doing so would give rq::curr a
+			 * bigger IPC boost on dst_cpu.
+			 */
+			} else if (sched_ipcc_enabled() &&
+				   busiest_nr == nr_running) {
+				struct task_struct *curr;
+				int delta;
+
+				curr = rcu_dereference(rq->curr);
+				delta = ipcc_score_delta(curr, env->dst_cpu);
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

