Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55D6FE990
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjEKBq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjEKBqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:46:52 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03575BA9
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:46:49 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f39600f9b8so16370091cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1683769609; x=1686361609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dazgGmOZhIybTKjulY3Sb0CURPvWP/K2FhdKf8C4aJQ=;
        b=ZoIvSnB6aklMYA9BlaCkOoEiStzHM40jSGyxReJoxiVKvCaPOz0MsIzS+8MhYlhXZl
         MjIKArOqMLJ2m4gvU/KM7RF1zgTc11e4zpQ2W+NCoistWMyQ+4eKTJ3Uvie0lGUUnzpO
         Tpy66/bjMl6Pke/QEKb285gEzyl3O3QjAMC6M4nYsOCjOJnk1IDMeHmMcXLHYqwifVvA
         ohFGvx6wNBhcvthUWPb0q5xvkyk/LckWxS6ZNMOZkTcBijnFMlXoubA5yDjLRN1VkcP8
         BAldVLN45CD7HGD4OzLkRI0nVhsYYzpUP3ZYflcN5vH/ilykt/lGI+v4BBl4b0vfTHJp
         J6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683769609; x=1686361609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dazgGmOZhIybTKjulY3Sb0CURPvWP/K2FhdKf8C4aJQ=;
        b=QoQuB/mnAZtYmBwEAugxttYWPKVzu/Qsf3LZ+ueyPL+RQ3vQT2FXdeA10Pwyv/Wzrp
         RCeB/KMBim36MSic/LfyoYMx9UiY0UHdX1y3WHi3FpFjPnmCgps9VUpW6PnyN7bsNv2u
         TdR1X7BDieA0jVGS4fYmH0QWGOYHy0JzKLgQ3uTy9dHIlv4uzLOVDrENZZtF0+9i2AF5
         MpWhkNNPDD7FucmMZVRazFlA9Pgyh2F+qGwukcCV+057PNSnpLM6SDk6BJVfFOE/8e4y
         o667sADQF4mSfSjyNXkn6qQDDDm28C7Sm189hc7Zyl2SnMz48yGXYuq6LpQXxnARAHr4
         QK4Q==
X-Gm-Message-State: AC+VfDzP5Etgv9TN+ZWYJp0bHZPAc2/yE+1Y7xDwUmmIlpn6CZpCVUcK
        +k/3hwwXJsV+6shLgTQ1Qwivjw==
X-Google-Smtp-Source: ACHHUZ7E6i8tfZSU0l7p6bLEwOwgc+8O7snDHbc8Zi+GmlgE2oGTBe+nFHTyN42e3MGZ9mAyn2v3ew==
X-Received: by 2002:ac8:7dd0:0:b0:3d9:525d:f024 with SMTP id c16-20020ac87dd0000000b003d9525df024mr31272233qte.28.1683769608812;
        Wed, 10 May 2023 18:46:48 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.ma.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id k12-20020ae9f10c000000b0074e3cf3b44dsm4316599qkg.125.2023.05.10.18.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 18:46:48 -0700 (PDT)
From:   Vineeth Pillai <vineeth@bitbyteword.org>
To:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] sched/deadline: Improve reclaim bandwidth accuracy for GRUB
Date:   Wed, 10 May 2023 21:46:24 -0400
Message-Id: <20230511014625.3443409-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current reclaim calculation for GRUB is a bit inaccurate and the
inaccuracy gets larger as the bandwidth of tasks becomes smaller.
I have a test program to show the issue - it runs one or more
deadline threads and observes the utilization. Following tests
are run on an isolated cpu(isolcpus=3) in a 4 cpu system and the
results as shown below:

RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.33
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.35
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.35
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.29

RUN 2: runtime=2ms, deadline=period=10ms, RT capacity = 95%
TID[704]: RECLAIM=1, (r=2ms, d=10ms, p=10ms), Util: 79.96
TID[704]: RECLAIM=1, (r=2ms, d=10ms, p=10ms), Util: 80.06
TID[704]: RECLAIM=1, (r=2ms, d=10ms, p=10ms), Util: 80.00

RUN 3: runtime=1ms, deadline=period=100ms, RT capacity = 95%
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.70

When running multiple tasks, the reclaimed bandwidth is divided
proportionately, but is not reclaimed to the max allowable limit:

RUN 4: 2 SCHED_FLAG_RECLAIM tasks, 1 normal task
	Task 1: runtime=1ms, deadline=period=10ms
	Task 2: runtime=1ms, deadline=period=10ms
	Task 3: runtime=5ms, deadline=period=20ms(normal)
TID[624]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 20.10
TID[625]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 20.10
TID[626]: RECLAIM=0, (r=5ms, d=20ms, p=20ms), Util: 25.07
TID[624]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 20.06
TID[625]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 20.13
TID[626]: RECLAIM=0, (r=5ms, d=20ms, p=20ms), Util: 25.12
TID[624]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 19.95
TID[625]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 19.93
TID[626]: RECLAIM=0, (r=5ms, d=20ms, p=20ms), Util: 25.04

I have also tested multiple tasks on all cpus allowing for tasks to
migrate and see the same issue there as well. Running 10 tasks on 3
cpus with 6 SCHED_FLAG_RECLAIM and 4 normal tasks, top shows:
%Cpu0  : 70.1 us,  0.3 sy,  0.0 ni, 29.3 id,  0.0 wa
%Cpu1  : 69.1 us,  0.3 sy,  0.0 ni, 30.3 id,  0.3 wa
%Cpu2  : 70.5 us,  0.3 sy,  0.0 ni, 29.2 id,  0.0 wa

The max{} logic in the existing implementation seems to not fully
capture the GRUB algorithm.

This patch fixes the issue by appropriatley caping the max allowed
utilization and also slightly adjusting GRUB algorithm to account
for a mix of normal deadline and SCHED_FLAG_RECLAIM tasks.

According to the GRUB rule, the runtime is depreciated as a factor
of active bandwidth of the runqueue: "dq = -dt", where U is the
active bandwidth. Also, we do not allocate the full bandwidth of a
cpu to deadline task, but only a portion(Umax) to it, so as to avoid
deadline tasks starving lower class tasks. The equation could be
re-written as "dq = -(U / Umax) * dt".

Since both normal deadline and SCHED_FLAG_RECLAIM tasks can share
cpu, we need to consider bandwidth of only SCHED_FLAG_RECLAIM tasks
in the equation:
	"dq = -(Ureclaim / Umax_reclaim) * dt"

Following are the results with this patch:

RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
TID[616]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 94.98
TID[616]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.04
TID[616]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.01

RUN 2: runtime=2ms, deadline=period=10ms, RT capacity = 95%
TID[625]: RECLAIM=1, (r=2ms, d=10ms, p=10ms), Util: 95.00
TID[625]: RECLAIM=1, (r=2ms, d=10ms, p=10ms), Util: 95.01
TID[625]: RECLAIM=1, (r=2ms, d=10ms, p=10ms), Util: 94.99

RUN 3: runtime=1ms, deadline=period=100ms, RT capacity = 95%
TID[629]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 94.87
TID[629]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.03
TID[629]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.03

Also more results with multiple tasks.
RUN 4: 2 SCHED_FLAG RECLAIM tasks:
	Task 1: runtime=1ms, deadline=period=10ms
	Task 2: runtime=1ms, deadline=period=10ms
TID[633]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 47.53
TID[634]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 47.64
TID[633]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 47.52
TID[634]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 47.39
TID[633]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 47.59
TID[634]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 47.61

RUN 5: 2 SCHED_FLAG_RECLAIM tasks, 1 normal task
	Task 1: runtime=1ms, deadline=period=10ms
	Task 2: runtime=1ms, deadline=period=10ms
	Task 3: runtime=5ms, deadline=period=20ms(normal)
TID[641]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 35.02
TID[642]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 35.02
TID[643]: RECLAIM=0, (r=5ms, d=20ms, p=20ms), Util: 24.93
TID[641]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 35.00
TID[642]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 34.94
TID[643]: RECLAIM=0, (r=5ms, d=20ms, p=20ms), Util: 24.98
TID[641]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 35.00
TID[642]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 35.03
TID[643]: RECLAIM=0, (r=5ms, d=20ms, p=20ms), Util: 25.03

Running tasks on all cpus allowing for migration also showed that
the utilization is reclaimed to the maximum. Running 10 tasks on
3 cpus with 6 SCHED_FLAG_RECLAIM and 4 normal tasks - top shows:
%Cpu0  : 94.3 us,  0.3 sy,  0.0 ni,  5.4 id,  0.0 wa
%Cpu1  : 95.2 us,  0.0 sy,  0.0 ni,  4.8 id,  0.0 wa
%Cpu2  : 94.9 us,  0.0 sy,  0.0 ni,  5.1 id,  0.0 wa

Changes since v1
----------------
1. Corrected comments as pointed out by Luca Abeni
2. Minor refactoring

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 kernel/sched/deadline.c | 98 ++++++++++++++++++++++++-----------------
 kernel/sched/sched.h    | 21 +++++++--
 2 files changed, 76 insertions(+), 43 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..af718daa3f66 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -229,11 +229,13 @@ __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
 }
 
 static inline
-void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq, bool reclaim_bw_se)
 {
 	u64 old = dl_rq->running_bw;
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
+	if (reclaim_bw_se)
+		dl_rq->reclaim_bw += dl_bw;
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
@@ -242,15 +244,19 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 }
 
 static inline
-void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq, bool reclaim_bw_se)
 {
 	u64 old = dl_rq->running_bw;
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
+	if (reclaim_bw_se)
+		dl_rq->reclaim_bw -= dl_bw;
 	dl_rq->running_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
-	if (dl_rq->running_bw > old)
+	if (dl_rq->running_bw > old) {
 		dl_rq->running_bw = 0;
+		dl_rq->reclaim_bw = 0;
+	}
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
@@ -296,14 +302,14 @@ static inline
 void add_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 	if (!dl_entity_is_special(dl_se))
-		__add_running_bw(dl_se->dl_bw, dl_rq);
+		__add_running_bw(dl_se->dl_bw, dl_rq, dl_entity_is_reclaim(dl_se));
 }
 
 static inline
 void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 	if (!dl_entity_is_special(dl_se))
-		__sub_running_bw(dl_se->dl_bw, dl_rq);
+		__sub_running_bw(dl_se->dl_bw, dl_rq, dl_entity_is_reclaim(dl_se));
 }
 
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
@@ -522,6 +528,7 @@ void init_dl_rq(struct dl_rq *dl_rq)
 #endif
 
 	dl_rq->running_bw = 0;
+	dl_rq->reclaim_bw = 0;
 	dl_rq->this_bw = 0;
 	init_dl_rq_bw_ratio(dl_rq);
 }
@@ -1260,44 +1267,58 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
 }
 
 /*
- * This function implements the GRUB accounting rule:
- * according to the GRUB reclaiming algorithm, the runtime is
- * not decreased as "dq = -dt", but as
- * "dq = -max{u / Umax, (1 - Uinact - Uextra)} dt",
- * where u is the utilization of the task, Umax is the maximum reclaimable
- * utilization, Uinact is the (per-runqueue) inactive utilization, computed
- * as the difference between the "total runqueue utilization" and the
- * runqueue active utilization, and Uextra is the (per runqueue) extra
- * reclaimable utilization.
- * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
- * multiplied by 2^BW_SHIFT, the result has to be shifted right by
- * BW_SHIFT.
- * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT,
- * dl_bw is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
- * Since delta is a 64 bit variable, to have an overflow its value
- * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
- * So, overflow is not an issue here.
+ * This function implements a slightly modified version of the GRUB accounting
+ * rule to accommodate mix of normal deadline tasks and SCHED_FLAG_RECLAIM tasks
+ * running together:
+ * As per the GRUB rule, the runtime is not decreased as "dq = -dt", but as a
+ * factor of the running(active) bandwidth for a cpu:
+ *	"dq = -U * dt"
+ * In our case, deadline is not allowed to use the whole bandwidth of the cpu,
+ * but only a fraction of it: "Umax". So the equation becomes:
+ *	"dq = -(U / Umax) * dt"
+ *
+ * To account for the fact that we have a mix of normal deadline tasks and
+ * SCHED_RECLAIM_FLAG tasks running together, we do not consider the bandwidth
+ * of normal tasks in the equation. So
+ *	"dq = -(Ureclaim / Umax_reclaim) * dt"
+ * Where
+ *	Ureclaim:	Active Bandwidth of SCHED_FLAG_RECLAIM tasks for this rq.
+ *	Umax_reclaim:	Maximum reclaimable bandwidth for this rq.
+ *
+ * We can calculate Umax_reclaim as:
+ *	"Umax_reclaim =	Uextra + Uinact + Ureclaim"
+ * Where:
+ *	running_bw:	Total bandwidth of tasks in active state for this rq.
+ *	Ureclaim:	Total bandwidth of SCHED_FLAG_RECLAIM tasks in active
+ *	                state for this rq.
+ *	this_bw:	Reserved bandwidth for this rq. Includes active and
+ *			inactive bandwidth for this rq.
+ *	Uinact:		Inactive utilization (this_bw - running_bw)
+ *	Umax:		Max usable bandwidth. Currently
+ *			= sched_rt_runtime_us / sched_rt_period_us
+ *	Uextra:		Extra bandwidth not reserved:
+ *			= Umax - \Sum(u_i / #cpus in the root domain)
+ *	u_i:		Bandwidth of an admitted dl task in the
+ *			root domain.
+ *
+ * We use the above formula to scale the runtime down
+ *
+ *	dq = -(Ureclaim / Umax_reclaim) * dt
+ *	   = -(Ureclaim / (Ureclaim + Uextra + Uinact)) * dt
  */
 static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
 	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
-	u64 u_act;
-	u64 u_act_min = (dl_se->dl_bw * rq->dl.bw_ratio) >> RATIO_SHIFT;
+	u64 u_max_reclaim = rq->dl.extra_bw + u_inact + rq->dl.reclaim_bw;
 
 	/*
-	 * Instead of computing max{u * bw_ratio, (1 - u_inact - u_extra)},
-	 * we compare u_inact + rq->dl.extra_bw with
-	 * 1 - (u * rq->dl.bw_ratio >> RATIO_SHIFT), because
-	 * u_inact + rq->dl.extra_bw can be larger than
-	 * 1 * (so, 1 - u_inact - rq->dl.extra_bw would be negative
-	 * leading to wrong results)
+	 * u_max_reclaim can be greater than max_bw in SMP.
+	 * We should cap it to Umax for every cpu.
 	 */
-	if (u_inact + rq->dl.extra_bw > BW_UNIT - u_act_min)
-		u_act = u_act_min;
-	else
-		u_act = BW_UNIT - u_inact - rq->dl.extra_bw;
+	if (u_max_reclaim > rq->dl.max_bw)
+		u_max_reclaim = rq->dl.max_bw;
 
-	return (delta * u_act) >> BW_SHIFT;
+	return div64_u64(delta * rq->dl.reclaim_bw, u_max_reclaim);
 }
 
 /*
@@ -2783,12 +2804,9 @@ int sched_dl_global_validate(void)
 static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 {
 	if (global_rt_runtime() == RUNTIME_INF) {
-		dl_rq->bw_ratio = 1 << RATIO_SHIFT;
-		dl_rq->extra_bw = 1 << BW_SHIFT;
+		dl_rq->max_bw = dl_rq->extra_bw = 1 << BW_SHIFT;
 	} else {
-		dl_rq->bw_ratio = to_ratio(global_rt_runtime(),
-			  global_rt_period()) >> (BW_SHIFT - RATIO_SHIFT);
-		dl_rq->extra_bw = to_ratio(global_rt_period(),
+		dl_rq->max_bw = dl_rq->extra_bw = to_ratio(global_rt_period(),
 						    global_rt_runtime());
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..13d85af0f42b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -257,6 +257,11 @@ static inline bool dl_entity_is_special(const struct sched_dl_entity *dl_se)
 #endif
 }
 
+static inline bool dl_entity_is_reclaim(const struct sched_dl_entity *dl_se)
+{
+	return dl_se->flags & SCHED_FLAG_RECLAIM;
+}
+
 /*
  * Tells if entity @a should preempt entity @b.
  */
@@ -754,10 +759,20 @@ struct dl_rq {
 	u64			extra_bw;
 
 	/*
-	 * Inverse of the fraction of CPU utilization that can be reclaimed
-	 * by the GRUB algorithm.
+	 * Maximum available bandwidth for this runqueue. This is used to
+	 * calculate reclaimable bandwidth for SCHED_FLAG_RECLAIM tasks.
+	 * By restricting maximum usable bandwidth, we aim to give other
+	 * tasks on lower classes a chance to run, when competing with
+	 * SCHED_FLAG_RECLAIM tasks.
 	 */
-	u64			bw_ratio;
+	u64			max_bw;
+
+	/*
+	 * Active bandwidth of SCHED_FLAG_RECLAIM tasks on this rq.
+	 * This will be a subset of running_bw.
+	 */
+	u64			reclaim_bw;
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.40.1

