Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A36F1B57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbjD1PVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346217AbjD1PVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:21:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19064EF2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682695259; x=1714231259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAP4LlcLCbheWZnyXGmFMWlML/Dgi3y7OP7EmkzhsIs=;
  b=Z/paJMiMc0qV6aaVad2pYLZq42+EPfwpFqGGza2xlQXv6GH90QcffQrF
   jIzYNXQyhn78xXVvBvKs64GqCSPP3+Z/LyorTKoyrmCYDg1XDLq40ep4Q
   JIfp9L84XXw1C3xW9UjSzJjEHHfzxH2CemBHSM0e+f3c/RswxU/DqPtJe
   x0/kJS8oyb4s6AzXWIFmFGeltrRTv70OWbFrAycOABt5AHwMGLi+pkNOW
   nk9JUXFHEGBAYfKruz8jxkW+P/TOAha84RInQhj3TNGdmaMctD8VQStV8
   dJHIvZ0EjrLBkz6faMhxmkBOJEq/xEhA0McnTt7VFQEl3qT6iRB5acvGo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="347799327"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="347799327"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="727577121"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="727577121"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2023 08:20:51 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v8 1/2] sched/fair: Record the average duration of a task
Date:   Sat, 29 Apr 2023 07:16:41 +0800
Message-Id: <a1ec30f98c143bc4dea3c18827f72944331d0a9e.1682661027.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682661027.git.yu.c.chen@intel.com>
References: <cover.1682661027.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record the average duration of a task, as there is a requirement
to leverage this information for better task placement.

At first thought the (p->se.sum_exec_runtime / p->nvcsw)
can be used to measure the task duration. However, the
history long past was factored too heavily in such a formula.
Ideally, the old activity should decay and not affect
the current status too much.

Although something based on PELT can be used, se.util_avg might
not be appropriate to describe the task duration:
Task p1 and task p2 are doing frequent ping-pong scheduling on
one CPU, both p1 and p2 have a short duration, but the util_avg
of each task can be up to 50%, which is inconsistent with the
short task duration.

It was found that there was once a similar feature to track the
duration of a task:
commit ad4b78bbcbab ("sched: Add new wakeup preemption mode: WAKEUP_RUNNING")
Unfortunately, it was reverted because it was an experiment. Pick the
patch up again, by recording the average duration when a task voluntarily
switches out.

Suppose on CPU1, task p1 and p2 run alternatively:

 --------------------> time

 | p1 runs 1ms | p2 preempt p1 | p1 switch in, runs 0.5ms and blocks |
               ^               ^                                     ^
 |_____________|               |_____________________________________|
                                                                     ^
                                                                     |
                                                                  p1 dequeued

p1's duration in one section is (1 + 0.5)ms. Because if p2 does not
preempt p1, p1 can run 1.5ms. This reflects the nature of a task:
how long it wishes to run at most.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/core.c   |  2 ++
 kernel/sched/debug.c  |  1 +
 kernel/sched/fair.c   | 13 +++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 675298d6eb36..6ee6b00faa12 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -558,6 +558,9 @@ struct sched_entity {
 	u64				prev_sum_exec_runtime;
 
 	u64				nr_migrations;
+	u64				prev_sleep_sum_runtime;
+	/* average duration of a task */
+	u64				dur_avg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 898fa3bc2765..32eacd220e39 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4452,6 +4452,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
+	p->se.dur_avg			= 0;
+	p->se.prev_sleep_sum_runtime	= 0;
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
index 3f8135d7c89d..3236011658a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6319,6 +6319,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 static void set_next_buddy(struct sched_entity *se);
 
+static inline void dur_avg_update(struct task_struct *p, bool task_sleep)
+{
+	u64 dur;
+
+	if (!task_sleep)
+		return;
+
+	dur = p->se.sum_exec_runtime - p->se.prev_sleep_sum_runtime;
+	p->se.prev_sleep_sum_runtime = p->se.sum_exec_runtime;
+	update_avg(&p->se.dur_avg, dur);
+}
+
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -6391,6 +6403,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+	dur_avg_update(p, task_sleep);
 	hrtick_update(rq);
 }
 
-- 
2.25.1

