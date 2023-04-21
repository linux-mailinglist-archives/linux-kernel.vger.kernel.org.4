Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09376EA59B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjDUIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjDUIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:12:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D286BC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682064731; x=1713600731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UHeIwHoNHSaGGLlq77jKVSJJ0dt1Yd7Oj21caRg448=;
  b=ZWBgi+b1BWPoJGOZzDEf90LNVVGaiAiySVLI3S6sNF/gprSdJSNE4ZBQ
   YOySnocQWutQD4ACdMGOmpYAu9iRTAvkEfynNpLsRkbZ1hQEGVG8CET7W
   YiSiwmBqjss0LBaH606xPUvtCRnnHUYgao3OCr3ms3pxaMuTG/rqs7s/w
   b2aatONChwzSxZ+nFJhkCUnaEgbZL8Sj3QLYeXlyHYk14bRg5fKg0LS+s
   mJmK2B3wBbZ1TZ2Gquuh8n1tXgPsV/QC40bN7xMaDw19zBdLozdPLC9fF
   g0j23OdW5JMnqPwHsMRpFk6vqsw3rK1bDylteXQMmexe7r4LrCs1k6hkz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="326269502"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="326269502"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 01:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="722683002"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="722683002"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 01:12:04 -0700
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
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v7 1/2] sched/fair: Record the average duration of a task
Date:   Sat, 22 Apr 2023 00:07:59 +0800
Message-Id: <5bf131940d2fa1d25bddc745892ccd407beebcd6.1682060436.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682060436.git.yu.c.chen@intel.com>
References: <cover.1682060436.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/core.c   |  2 ++
 kernel/sched/debug.c  |  1 +
 kernel/sched/fair.c   | 13 +++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6d654eb4cabd..f94e6aa159b0 100644
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
index d861db8aa7ab..59a6c0414a19 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4446,6 +4446,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
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
index f5da01a6b35a..4af5799b90fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6283,6 +6283,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
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
@@ -6355,6 +6367,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+	dur_avg_update(p, task_sleep);
 	hrtick_update(rq);
 }
 
-- 
2.25.1

