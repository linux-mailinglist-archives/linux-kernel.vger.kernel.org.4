Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F65688EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBCFQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBCFQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:16:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61171627B5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675401402; x=1706937402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBj9BcM+x9JVRwYAuZm5QbjM81Ix0WefJPCuSwxeVy8=;
  b=gTqF6ertAL53QQk1B70tZrcqWIiMWfbW6lr9rEDyXtAbI6U7neGrnOl1
   YJCfJmACLfBN1xoMV3jYXsfovmo+0IQCGDY4BvsGSinSatgPbVh9QLOgs
   lgmcql9DL4w2texpGYwW7NkCWOFVM3cJDUgwgRXOIEdghUDkYeLm7igDr
   aA2YRi9DDXod2sKyFBSYxUseMVaZY9DrXKVPpkyZYLxI9D8+M+XueIAgw
   4VO1obOfZ3+NTTBbQgclVz4AYxqrs414tPP8u9PlKQHGzxfk9l4QjdW/5
   OcDXiu14cBr3Cu3RkVMXw5OZiBlbmiVlGGNgE/1J+e6rjuibh5v18e8EE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="308997125"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="308997125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 21:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="774174245"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="774174245"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2023 21:16:37 -0800
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
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v5 1/2] sched/fair: Record the average duration of a task
Date:   Fri,  3 Feb 2023 13:17:59 +0800
Message-Id: <155aa36ba14b8a1f8e6c3ccda7999125edfff990.1675361144.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675361144.git.yu.c.chen@intel.com>
References: <cover.1675361144.git.yu.c.chen@intel.com>
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
can be up to 50%, which is inconsistent with task duration.

It was found that there was once a similar feature to track the
duration of a task:
commit ad4b78bbcbab ("sched: Add new wakeup preemption mode: WAKEUP_RUNNING")
Unfortunately, it was reverted because it was an experiment. Pick the
patch up again, by recording the average duration when a task voluntarily
switches out.

For example, suppose on CPU1, task p1 and p2 run alternatively:

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
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/core.c   |  2 ++
 kernel/sched/debug.c  |  1 +
 kernel/sched/fair.c   | 13 +++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4df2b3e76b30..e21709402a31 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -557,6 +557,9 @@ struct sched_entity {
 	u64				prev_sum_exec_runtime;
 
 	u64				nr_migrations;
+	u64				prev_sleep_sum_runtime;
+	/* average duration of a task */
+	u64				dur_avg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 03b8529db73f..b805c5bdc7ff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4379,6 +4379,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
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
index d4db72f8f84e..aa16611c7263 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6271,6 +6271,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
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
@@ -6343,6 +6355,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+	dur_avg_update(p, task_sleep);
 	hrtick_update(rq);
 }
 
-- 
2.25.1

