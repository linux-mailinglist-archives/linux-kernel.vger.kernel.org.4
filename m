Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89064E735
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLPGKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLPGK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:10:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76BE389E4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671171027; x=1702707027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k49v4yjd5aMJh2ppyfh2b1SfwZ43h3meOrgSC9csfg4=;
  b=d0oVezWchuTKajdN0hNaCrHAfFoJJD0aOyV4McpLFWc2e+XGDCpO9w4E
   ovTMK5GCbXIADn0Hq8zMLEPpDk/zBpzbiW1DdpcLvpfGfOVFbkRMsvsfY
   bl0nHktyfjdubfIyCMFuSAM2EMnF7bLZH3NMpomf6/a0BULz89jrcLInM
   7GJe1G1El3iKpH3kr1snC2MHHZjHYdJxFn+PMG2blzJ/bxmt8yfx+1eag
   ZDutUJa80uFqf+KtU9xOfeqVj2ufNv7l6Pq3vpCq9+t7+dAlkDu3hp1SW
   zFxWo+0Hlv1yOcSzE2IILNP/IZcHR0XSKjp7bWkLzlLrNL2RWAP4GLdTv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="381116154"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="381116154"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 22:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="823999936"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="823999936"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2022 22:10:20 -0800
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
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH v4 1/2] sched/fair: Introduce short duration task check
Date:   Fri, 16 Dec 2022 14:11:17 +0800
Message-Id: <ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1671158588.git.yu.c.chen@intel.com>
References: <cover.1671158588.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce short-duration task checks, as there is a requirement
to leverage this attribute for better task placement.

There are several choices of metrics that could be used to
indicate if a task is a short-duration task.

At first thought the (p->se.sum_exec_runtime / p->nvcsw)
can be used to measure the task duration. However, the
history long past was factored too heavily in such a formula.
Ideally, the old activity should decay and not affect
the current status too much.

Although something based on PELT can be used, se.util_avg might
not be appropriate to describe the task duration:
1. Task p1 and task p2 are doing frequent ping-pong scheduling on
   one CPU, both p1 and p2 have a short duration, but the util_avg
   can be up to 50%.
2. Suppose a task lasting less than 4ms is regarded as a short task.
   If task p3 runs for 6 ms and sleeps for 32 ms, p3 should not be a
   short-duration task. However, PELT would decay p3's accumulated
   running time from 6 ms to 3 ms, because 32 ms is the half-life
   in PELT. As a result, p3 would be incorrectly treated as a short
   task.

It was found that there was once a similar feature to track the
duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
was reverted because it was an experiment. So pick the patch up
again, by recording the average duration when a task voluntarily
switches out.

The threshold of short duration is sysctl_sched_min_granularity / 8,
so it can be tuned by the user. By default, the threshold is 375 us.
The reason to reuse sysctl_sched_min_granularity is that it reflects
how long the user would like the task to run. So the criteria of a
short task have a connection to it.

Josh is not in favor of tying the threshold to
sysctl_sched_min_granularity, ideally there should be a dedicated
parameter for the threshold, but that introduces complexity for
maintenance and the user.

Introduce SIS_SHORT to enable the short duration check.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h   |  3 +++
 kernel/sched/core.c     |  2 ++
 kernel/sched/debug.c    |  1 +
 kernel/sched/fair.c     | 23 +++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 5 files changed, 30 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..26f4768e63f3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -557,6 +557,9 @@ struct sched_entity {
 	u64				prev_sum_exec_runtime;
 
 	u64				nr_migrations;
+	u64				prev_sum_exec_runtime_vol;
+	/* average duration of a task */
+	u64				dur_avg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daff72f00385..c5202f1be3f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4348,6 +4348,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
+	p->se.dur_avg			= 0;
+	p->se.prev_sum_exec_runtime_vol	= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..8d64fba16cfe 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1024,6 +1024,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	__PS("nr_involuntary_switches", p->nivcsw);
 
 	P(se.load.weight);
+	P(se.dur_avg);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
 	P(se.avg.runnable_sum);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..abdb7a442052 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4824,6 +4824,16 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static int
 wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
 
+/*
+ * If a task switches in and then voluntarily relinquishes the
+ * CPU quickly, it is regarded as a short duration task.
+ */
+static inline int is_short_task(struct task_struct *p)
+{
+	return sched_feat(SIS_SHORT) && p->se.dur_avg &&
+		((p->se.dur_avg * 8) <= sysctl_sched_min_granularity);
+}
+
 /*
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
@@ -5995,6 +6005,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 static void set_next_buddy(struct sched_entity *se);
 
+static inline void dur_avg_update(struct task_struct *p, bool task_sleep)
+{
+	u64 dur;
+
+	if (!task_sleep)
+		return;
+
+	dur = p->se.sum_exec_runtime - p->se.prev_sum_exec_runtime_vol;
+	p->se.prev_sum_exec_runtime_vol = p->se.sum_exec_runtime;
+	update_avg(&p->se.dur_avg, dur);
+}
+
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -6067,6 +6089,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+	dur_avg_update(p, task_sleep);
 	hrtick_update(rq);
 }
 
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

