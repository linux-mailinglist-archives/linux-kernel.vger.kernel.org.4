Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83600609467
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJWPc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:32:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA676448
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666539176; x=1698075176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/0nwjy7lGHePPi1+Bx5nEjFPCYaP5NouvrDTQFe/nE=;
  b=JT8Le38dGQjub/tm5zUvEbGf1Ykymj/DaRIisofvVXYDjq+1qnF3qj24
   BvvwEGTJyYtit8aVKx/OXa4n07w8dpw1b1Dw4VvPsFwg59WYCujFdv2Q/
   rhR0FVE7TxpYSeOoy6VdU9POHGJXbgef6doPG/jSkzyn3rHUh7IjyGQMB
   UsftcfZJ5vA7q8oPbkAt3Arf/1qLL6bH68GjC57/GWXClEIFmMcFMPdQR
   PFay08xFxyYn62XvSvIJX7VqBpDcGog9fMC3rUQbrQzlburhGeTMSkMgs
   yG6KU7fpwLHNpMh/QPvMExgwIjtj5c8J6+bax1nhwrPC9Ku+3J7vbe5Gv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="307268732"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="307268732"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 08:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="756329659"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="756329659"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2022 08:32:49 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH v2 1/2] sched/fair: Introduce short duration task check
Date:   Sun, 23 Oct 2022 23:32:31 +0800
Message-Id: <6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666531576.git.yu.c.chen@intel.com>
References: <cover.1666531576.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce short-duration task checks, as there is a
requirement to leverage this attribute for better task placement.

There are several choices of metrics that could be used to
indicate if a task is a short-duration task.

At first thought the (p->se.sum_exec_runtime / p->nvcsw)
could be used to measure the task duration. However, the
history long past was factored too heavily in such a formula.
Ideally, the old activity should decay and not affect
the current status too much.

PELT could decay the runtime time, so maybe something like
se.util_avg could be used. But after a second thought, PELT
might not be appropriate to measure the duration:
1. Task p1 and task p2 are doing frequent ping-pong scheduling on
   one CPU, both p1 and p2 have a short duration, but the util_avg
   can be up to 50%.
2. Suppose a task lasting less than 4ms is regarded as a short task.
   If task p3 runs for 6ms and sleeps for 32ms, it should not be a
   short-duration task. However, PELT would decay p3's accumulated
   running time from 6ms to 3ms, because 32ms is the half-life in PELT.
   As a result, p3 would be incorrectly treated as a short task.

It was found that there was once a similar feature to track the
duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
was reverted because it was an experiment. So pick the patch up
again, by recording the average duration when a task voluntarily
switches out. The calculation of average duration is borrowed
from the idea of Exponential Weighted Moving Average (EWMA) in
util_est_update(). The effect is that the average task duration
is calculated by:
new_avg_duration = old_avg_duration * 0.875 + lastest_duration * 0.125;
which is what update_avg() does now.

Introduce SIS_SHORT to control this strategy.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h   |  8 +++++
 kernel/sched/core.c     |  2 ++
 kernel/sched/fair.c     | 77 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 4 files changed, 88 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..ff74301b1548 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -557,6 +557,14 @@ struct sched_entity {
 	u64				prev_sum_exec_runtime;
 
 	u64				nr_migrations;
+	/*
+	 * The 'snapshot' of sum_exec_runtime when task
+	 * voluntarily switches out. This is used to
+	 * calculate the average duration below.
+	 */
+	u64				prev_sum_runtime_vol;
+	/* average duration of a task */
+	u64				dur_avg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b0623ff3..f5281fe7f8f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4330,6 +4330,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
+	p->se.dur_avg			= 0;
+	p->se.prev_sum_runtime_vol	= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..8820d0d14519 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6200,6 +6200,19 @@ static int wake_wide(struct task_struct *p)
 	return 1;
 }
 
+/*
+ * If a task switches in and then voluntarily relinquishes the
+ * CPU quickly, it is regarded as a short duration task.
+ * sysctl_sched_min_granularity is chosen as the threshold,
+ * as this value is the minimal slice if there are too many
+ * runnable tasks, see __sched_period().
+ */
+static inline int is_short_task(struct task_struct *p)
+{
+	return sched_feat(SIS_SHORT) &&
+		(p->se.dur_avg <= sysctl_sched_min_granularity);
+}
+
 /*
  * The purpose of wake_affine() is to quickly determine on which CPU we can run
  * soonest. For the purpose of speed we only consider the waking and previous
@@ -7679,6 +7692,70 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
+	u64 this_dur_avg, last_dur_avg;
+	long delta;
+
+	/*
+	 * Calculate the task's average duration.
+	 *
+	 * Only consider that task voluntarily relinquishes the CPU.
+	 * For example, suppose on CPU1, task p1 and p2 runs
+	 * alternatively:
+	 *
+	 * --------------------> time
+	 *
+	 * | p1 runs 1ms | p2 preempt p1 | p1 runs 0.5ms and sleeps |
+	 * ^             ^               ^                          ^
+	 * |_____________|               |__________________________|
+	 *        |____________________________________|
+	 *                   p1's duration
+	 *
+	 *
+	 * The duration of p1 is 1.5ms rather than 0.5ms or 1ms
+	 * in above case. That is to say, the duration period starts
+	 * when task p1 switches in, ends when task p1 voluntarily
+	 * relinquishes the CPU. This duration descibes the "nature"
+	 * of a task: If a task is not preempted, how long it will
+	 * run.
+	 *
+	 * The Exponential Weighted Moving Average (EWMA)
+	 * is used to calculate the average duration.
+	 * Borrowed from util_est_update():
+	 *
+	 *  ewma(t) = w * this_dur_avg + (1-w) * ewma(t-1)
+	 *
+	 * When 'w' is 0.125, it becomes update_avg().
+	 * This indicates that we care about approximately
+	 * the recent 1 / 0.125 = 8 history duration.
+	 */
+	if (sched_feat(SIS_SHORT) && !prev->on_rq) {
+		/*
+		 * sum_exec_runtime has been updated in update_curr()
+		 * because we reach here via dequeue.
+		 */
+		this_dur_avg = se->sum_exec_runtime - se->prev_sum_runtime_vol;
+		/*
+		 * Record the accumulated runtime when task voluntarily
+		 * switches out. End of old duration period, a new period
+		 * starts.
+		 */
+		se->prev_sum_runtime_vol = se->sum_exec_runtime;
+
+		last_dur_avg = se->dur_avg;
+		delta = this_dur_avg - last_dur_avg;
+		/* consider large change to avoid frequent update */
+		if (abs(delta) >= sysctl_sched_min_granularity) {
+			/*
+			 * If it is the first time the task starts to
+			 * record dur_avg, discard the initial value 0.
+			 * Otherwise, calculate the EWMA.
+			 */
+			if (unlikely(!this_dur_avg))
+				se->dur_avg = this_dur_avg;
+			else
+				update_avg(&se->dur_avg, this_dur_avg);
+		}
+	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..efdc29c42161 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_SHORT, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1

