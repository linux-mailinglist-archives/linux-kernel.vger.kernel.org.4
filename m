Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D163EB65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLAIoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLAInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:43:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FC88B73
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669884211; x=1701420211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P1OoOVO+5I9n5R3UdLjRbsc/m0aVGaHv8BbreyPhTkY=;
  b=lDJB7Z+CKuwgaDfxBMuywgS7P/RDJU99NtUM87uj0pZuBFUPz0HLLssT
   8C5hXQSoYIrTCqx20CY6n1txJlGp04bRB2HwNuwbPkaaITkf8MFLD5Rm6
   WAkgqiwErC+/iZO1ODL14HxH9Zmp/FcG+uYMy+RYLx6LYUMfjZUacSnbM
   pouNnij2LwmSL6gahKxRXbnTHQYPOdrmx+j5uEHvMmsQTxZ0YKXf3s6RE
   7HIpFU+GF6WO44lwCzT4vfprc57tzNngBCsybO9tWm8CltGjoWYxPEmXJ
   2t/HQ1s1T3/jrOjufpTxahTbvQK6aJ+XaQjHFXhcy6+/GOHFz54Tis5pD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342553374"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="342553374"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 00:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733335337"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733335337"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Dec 2022 00:43:22 -0800
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
Subject: [PATCH v3 1/2] sched/fair: Introduce short duration task check
Date:   Thu,  1 Dec 2022 16:44:08 +0800
Message-Id: <7621888af45a89c3963b39e062695602a3b9499f.1669862147.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669862147.git.yu.c.chen@intel.com>
References: <cover.1669862147.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce short-duration task checks, as there is requirement
to leverage this attribute for better task placement.

There are several choices of metrics that could be used to
indicate if a task is a short-duration task.

At first thought the (p->se.sum_exec_runtime / p->nvcsw)
could be used to measure the task duration. However, the
history long past was factored too heavily in such a formula.
Ideally, the old activity should decay and not affect
the current status too much.

Although something based on PELT could be used, se.util_avg might
not be appropriate to describe the task duration:
1. Task p1 and task p2 are doing frequent ping-pong scheduling on
   one CPU, both p1 and p2 have a short duration, but the util_avg
   can be up to 50%.
2. Suppose a task lasting less than 4ms is regarded as a short task.
   If task p3 runs for 6ms and sleeps for 32ms, p3 should not be a
   short-duration task. However, PELT would decay p3's accumulated
   running time from 6ms to 3ms, because 32ms is the half-life in PELT.
   As a result, p3 would be incorrectly treated as a short task.

It was found that there was once a similar feature to track the
duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
was reverted because it was an experiment. So pick the patch up
again, by recording the average duration when a task voluntarily
switches out. Introduce SIS_SHORT to control this strategy.

The threshold of short duration reuses sysctl_sched_min_granularity,
so it can be tuned by the user. Ideally there should be a dedicated
parameter for the threshold, but that might introduce complexity.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h   |  4 ++++
 kernel/sched/core.c     |  2 ++
 kernel/sched/fair.c     | 17 +++++++++++++++++
 kernel/sched/features.h |  1 +
 4 files changed, 24 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..64b7acb77a11 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -558,6 +558,10 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
+	u64				prev_sum_exec_runtime_vol;
+	/* average duration of a task */
+	u64				dur_avg;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..a4b314b664f8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6200,6 +6200,16 @@ static int wake_wide(struct task_struct *p)
 	return 1;
 }
 
+/*
+ * If a task switches in and then voluntarily relinquishes the
+ * CPU quickly, it is regarded as a short duration task.
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
@@ -7680,6 +7690,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
 
+	if (sched_feat(SIS_SHORT) && !prev->on_rq) {
+		u64 this_dur = se->sum_exec_runtime - se->prev_sum_exec_runtime_vol;
+
+		se->prev_sum_exec_runtime_vol = se->sum_exec_runtime;
+		update_avg(&se->dur_avg, this_dur);
+	}
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
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

