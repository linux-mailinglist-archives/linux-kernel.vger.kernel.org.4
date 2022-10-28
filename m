Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99527610B62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJ1HhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJ1HhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:37:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55ABC96DE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y16so5810310wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4kgrsJEqYaa/F19eJ53q5XCqUaTM5noPZmGTo2LpZn4=;
        b=qUhaL/1BjAG9E/aX/qxYLgPWXz1+UlNNOkpSYM0P8w8s+xlfbdFY7y1lhSj/lXlpv5
         Ngvki6GcQDiU7NKf24Kq1FQUJUGP9/+EHyFsAZlYwBNKPOoTF6DIVwMXDtKZ8wFSNkMb
         IPusg/6BielrC0OGbPVAJOAZ7z29UfKwZzi59mQMmtSerma3Io4l+7eSLEIkH1Ag9scl
         YpZfa0XVyhDXX5j6SYjTqfRq0zGMwIUZ8STs8MaMXE7LMJrHmdhsCNWoqncr5sIWMycj
         gPYiemNQ0+5zw5ko2lx5LyfODMPKKVvI6kFDBv4JTjpmez6iCH3SO70I6CS8nKz6ZMUw
         BsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kgrsJEqYaa/F19eJ53q5XCqUaTM5noPZmGTo2LpZn4=;
        b=60PkYov9jsMdC6q5mwQWmMD0qi6dYo0c2U/PlNcwKnFpNWw9hwbhfL3/VpruI42iuX
         f1uesrF2rHlZDfCWBtbXJS6ewELsgU++AP9ZVBjHU0dlrmp4EftETOxqSb7w2lNESlVL
         zEO0f0sioK5FPfH0hqkdVXUcogMwvdqljEurG6svR33WLrN4xhXOyNCIJtULDHoEoWEm
         VFaSmsVE+OmbC7eoLJCrOCvijE4WVjIb19yX8tEyjaPb0UMkoKSvIGBerUv9GwaEnTUs
         +Tn9swQMh/zP8kevilCJbVnnFIwDQ+g67vBUuTK7Fvx/DY3paQQXb6oSYRHz+T8N+Z07
         Vtog==
X-Gm-Message-State: ACrzQf0JQ0iKntexIMykwtsOAdJsji6bmh2awOiCBVg1ZVCuyuEKAq9w
        cdH8o46PCw3KtacQf2+RNzeCYw==
X-Google-Smtp-Source: AMsMyM5sxKkVa60D0IwivBmUG1OUjytDjIKBcdqc2WRan1waOgUdVkNbUOrPTOqgabpF9CTmultUxA==
X-Received: by 2002:adf:efc5:0:b0:236:6848:7c28 with SMTP id i5-20020adfefc5000000b0023668487c28mr18305278wrp.263.1666942618115;
        Fri, 28 Oct 2022 00:36:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:36:56 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 5/9] sched/fair: Take into account latency priority at wakeup
Date:   Fri, 28 Oct 2022 09:36:33 +0200
Message-Id: <20221028073637.31195-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028073637.31195-1-vincent.guittot@linaro.org>
References: <20221028073637.31195-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the latency priority of a thread when deciding to
preempt the current running thread. We don't want to provide more CPU
bandwidth to a thread but reorder the scheduling to run latency sensitive
task first whenever possible.

As long as a thread didn't use its bandwidth, it will be able to preempt
the current thread.

At the opposite, a thread with a low latency priority will preempt current
thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
wait for the tick to get its sched slice.

                                   curr vruntime
                                       |
                      sysctl_sched_wakeup_granularity
                                   <-->
----------------------------------|----|-----------------------|---------------
                                  |    |<--------------------->
                                  |    .  sysctl_sched_latency
                                  |    .
default/current latency entity    |    .
                                  |    .
1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
                                  |    .
                                  |    .
                                  |    .
low latency entity                |    .
                                   ---------------------->|
                               % of sysctl_sched_latency  |
1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
preempt ------------------------------------------------->|<- do not preempt --
                                  |    .
                                  |    .
                                  |    .
high latency entity               |    .
         |<-----------------------|----.
         | % of sysctl_sched_latency   .
111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
preempt->|<- se doesn't preempt curr ------------------------------------------

Tests results of nice latency impact on heavy load like hackbench:

hackbench -l (2560 / group) -g group
group        latency 0             latency 19
1            1.378(+/-  1%)      1.337(+/- 1%) + 3%
4            1.393(+/-  3%)      1.312(+/- 3%) + 6%
8            1.308(+/-  2%)      1.279(+/- 1%) + 2%
16           1.347(+/-  1%)      1.317(+/- 1%) + 2%

hackbench -p -l (2560 / group) -g group
group
1            1.836(+/- 17%)      1.148(+/- 5%) +37%
4            1.586(+/-  6%)      1.109(+/- 8%) +30%
8            1.209(+/-  4%)      0.780(+/- 4%) +35%
16           0.805(+/-  5%)      0.728(+/- 4%) +10%

By deacreasing the latency prio, we reduce the number of preemption at
wakeup and help hackbench making progress.

Test results of nice latency impact on short live load like cyclictest
while competing with heavy load like hackbench:

hackbench -l 10000 -g $group &
cyclictest --policy other -D 5 -q -n
        latency 0           latency -20
group   min  avg    max     min  avg    max
0       16    19     29      17   18     29
1       43   299   7359      63   84   3422
4       56   449  14806      45   83    284
8       63   820  51123      63   83    283
16      64  1326  70684      41  157  26852

group = 0 means that hackbench is not running.

The avg is significantly improved with nice latency -20 especially with
large number of groups but min and max remain quite similar. If we add the
histogram parameter to get details of latency, we have :

hackbench -l 10000 -g 16 &
cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
              latency 0    latency -20
Min Latencies:    64           62
Avg Latencies:  1170          107
Max Latencies: 88069        10417
50% latencies:   122           86
75% latencies:   614           91
85% latencies:   961           94
90% latencies:  1225           97
95% latencies:  6120          102
99% latencies: 18328          159 

With percentile details, we see the benefit of nice latency -20 as
only 1% of the latencies are above 159us whereas the default latency
has got 15% around ~1ms or above and 5% over the 6ms.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

The figures above include the whole patchset.

 include/linux/sched.h |  4 ++-
 init/init_task.c      |  2 +-
 kernel/sched/core.c   | 38 +++++++++++++++++++++----
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 66 ++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h  | 14 ++++++++-
 6 files changed, 110 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6805f378a9c3..a74cad08e91e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -567,6 +567,8 @@ struct sched_entity {
 	/* cached value of my_q->h_nr_running */
 	unsigned long			runnable_weight;
 #endif
+	/* preemption offset in ns */
+	long				latency_offset;
 
 #ifdef CONFIG_SMP
 	/*
@@ -783,7 +785,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
-	int				latency_nice;
+	int				latency_prio;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/init/init_task.c b/init/init_task.c
index 7dd71dd2d261..b8ddf403bc62 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,7 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
-	.latency_nice	= DEFAULT_LATENCY_NICE,
+	.latency_prio	= NICE_WIDTH - 20,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b2accc9da4fe..caf54e54a74f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1284,6 +1284,16 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+static void set_latency_offset(struct task_struct *p)
+{
+	long weight = sched_latency_to_weight[p->latency_prio];
+	s64 offset;
+
+	offset = weight * get_sched_latency(false);
+	offset = div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
+	p->se.latency_offset = (long)offset;
+}
+
 #ifdef CONFIG_UCLAMP_TASK
 /*
  * Serializes updates of utilization clamp values
@@ -4559,7 +4569,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
-		p->latency_nice = DEFAULT_LATENCY_NICE;
+		p->latency_prio = NICE_TO_LATENCY(0);
+		set_latency_offset(p);
+
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -7324,8 +7336,10 @@ static void __setscheduler_params(struct task_struct *p,
 static void __setscheduler_latency(struct task_struct *p,
 		const struct sched_attr *attr)
 {
-	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
-		p->latency_nice = attr->sched_latency_nice;
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);
+		set_latency_offset(p);
+	}
 }
 
 /*
@@ -7510,7 +7524,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
-		    attr->sched_latency_nice != p->latency_nice)
+		    attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
@@ -8051,7 +8065,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
-	kattr.sched_latency_nice = p->latency_nice;
+	kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
@@ -11204,6 +11218,20 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
+/*
+ * latency weight for wakeup preemption
+ */
+const int sched_latency_to_weight[40] = {
+ /* -20 */     -1024,     -973,     -922,      -870,      -819,
+ /* -15 */      -768,     -717,     -666,      -614,      -563,
+ /* -10 */      -512,     -461,     -410,      -358,      -307,
+ /*  -5 */      -256,     -205,     -154,      -102,       -51,
+ /*   0 */         0,       51,      102,       154,       205,
+ /*   5 */       256,      307,      358,       410,       461,
+ /*  10 */       512,      563,      614,       666,       717,
+ /*  15 */       768,      819,      870,       922,       973,
+};
+
 void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a3f7876217a6..06aaa0c81d4b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1042,7 +1042,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
-	P(latency_nice);
+	P(latency_prio);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eb04c83112a0..4299d5108dc7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4558,6 +4558,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
+static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -4566,7 +4568,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	unsigned long ideal_runtime, delta_exec;
 	struct sched_entity *se;
-	s64 delta;
+	s64 delta, offset;
 
 	ideal_runtime = sched_slice(cfs_rq, curr);
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
@@ -4591,10 +4593,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	se = __pick_first_entity(cfs_rq);
 	delta = curr->vruntime - se->vruntime;
 
-	if (delta < 0)
+	offset = wakeup_latency_gran(curr, se);
+	if (delta < offset)
 		return;
 
-	if (delta > ideal_runtime)
+	if ((delta > ideal_runtime) ||
+	    (delta > get_latency_max()))
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -5716,6 +5720,35 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+static void set_next_buddy(struct sched_entity *se);
+
+static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
+{
+	struct sched_entity *next;
+
+	if (se->latency_offset >= 0)
+		return;
+
+	if (cfs->nr_running <= 1)
+		return;
+	/*
+	 * When waking from another class, we don't need to check to preempt at
+	 * wakeup and don't set next buddy as a candidate for being picked in
+	 * priority.
+	 * In case of simultaneous wakeup when current is another class, the
+	 * latency sensitive tasks lost opportunity to preempt non sensitive
+	 * tasks which woke up simultaneously.
+	 */
+
+	if (cfs->next)
+		next = cfs->next;
+	else
+		next = __pick_first_entity(cfs);
+
+	if (next && wakeup_preempt_entity(next, se) == 1)
+		set_next_buddy(se);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5802,14 +5835,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
+	if (rq->curr->sched_class != &fair_sched_class)
+		check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
+
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -7128,6 +7162,23 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
+static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
+{
+	long latency_offset = se->latency_offset;
+
+	/*
+	 * A negative latency offset means that the sched_entity has latency
+	 * requirement that needs to be evaluated versus other entity.
+	 * Otherwise, use the latency weight to evaluate how much scheduling
+	 * delay is acceptable by se.
+	 */
+	if ((latency_offset < 0) || (curr->latency_offset < 0))
+		latency_offset -= curr->latency_offset;
+	latency_offset = min_t(long, latency_offset, get_latency_max());
+
+	return latency_offset;
+}
+
 static unsigned long wakeup_gran(struct sched_entity *se)
 {
 	unsigned long gran = sysctl_sched_wakeup_granularity;
@@ -7166,11 +7217,12 @@ static int
 wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 {
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
+	s64 offset = wakeup_latency_gran(curr, se);
 
-	if (vdiff <= 0)
+	if (vdiff < offset)
 		return -1;
 
-	gran = wakeup_gran(se);
+	gran = offset + wakeup_gran(se);
 
 	/*
 	 * At wake up, the vruntime of a task is capped to not be older than
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5445a894babd..cca09ce8d0d6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -142,6 +142,17 @@ extern int sched_rr_timeslice;
  * Default tasks should be treated as a task with latency_nice = 0.
  */
 #define DEFAULT_LATENCY_NICE	0
+#define DEFAULT_LATENCY_PRIO	(DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
+
+/*
+ * Convert user-nice values [ -20 ... 0 ... 19 ]
+ * to static latency [ 0..39 ],
+ * and back.
+ */
+#define NICE_TO_LATENCY(nice)	((nice) + DEFAULT_LATENCY_PRIO)
+#define LATENCY_TO_NICE(prio)	((prio) - DEFAULT_LATENCY_PRIO)
+#define NICE_LATENCY_SHIFT	(SCHED_FIXEDPOINT_SHIFT)
+#define NICE_LATENCY_WEIGHT_MAX	(1L << NICE_LATENCY_SHIFT)
 
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
@@ -2116,6 +2127,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
 
 extern const int		sched_prio_to_weight[40];
 extern const u32		sched_prio_to_wmult[40];
+extern const int		sched_latency_to_weight[40];
 
 /*
  * {de,en}queue flags:
@@ -2450,8 +2462,8 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
+#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
-- 
2.17.1

