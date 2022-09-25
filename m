Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0755E93B0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiIYOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiIYOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:41:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A82DA8F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n15so6711271wrq.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=McxzoSyGgN0mMu4LmDTxJ3mXTH5u5yE8fp9dw11YuUg=;
        b=Mw07vpbbd2RUDvXabW7GB3HZUgWS+JdnKszKXl5YvMnuIjIeoqL70Tj3xqjwFXLOPJ
         OmR/x/ow7c7DLgIQ1L1Ipx6TEP3ecbOlhNwGovIacDFzlOYydOkFsBasHIx7tNimketO
         50hr6awGxlc54VdC4Vbti/XB84tl5riBKZbz2D0RhBQfQjndbagYjByYoOXH7pdDOStO
         B4A8kDZaGHIuUzAJ6ZmJ/GBgahOv6NBSLUoWfbs3noM2OohZdtbnm+Ndq+HPxK127+5O
         xBRK1RRsveJVwoeZoy8hQSWP62XlTp0nM+GWd+Q++J50r5eiWk+YEP3eVpmNdS1Et+1x
         gPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=McxzoSyGgN0mMu4LmDTxJ3mXTH5u5yE8fp9dw11YuUg=;
        b=W7LGex4PavGpIjPXe0WD0GFxfmb0qJcorW+J8pD7ceqsveFmxN0p7yVypsWIUk9eAA
         6sjnrjNmwNW1hfah6XsyycyslnU7Lz8Re4Una+nrkEty6MqAu3OZkhzWDAXSgZm54Pu/
         As50Fr8GTGqTKGg4vkGx0Kw9XWoWfib1F11bn+isTjjy8RqaQe0GEQ3moFlvvo4kqyff
         HCOxLvTtmTipwEj3GZKJjykSMRoIrjhBFVe4b2W4IeKOOa0U71T/qCoY7OHnjnQp4h0h
         A6tv65er2Ak81RWB7I9PvDu7p7fiNbXn+pmKSMTsBBtpuDnfeSadrZqF2BuTfBLaEg2b
         SLcQ==
X-Gm-Message-State: ACrzQf3eqHbH93sa1EWqTau/htQx7B+mzwijmxrpRtdGlpsd7SD6BT/J
        OBJugDCTtcclLBCeLDHWFdQCbw==
X-Google-Smtp-Source: AMsMyM6IoHp/09oB6vJRkG1m6Z+zzow5eOg6xIJwcQsE0547aDBHNXzfNHA5b3QF+2Soy02ANmA4/A==
X-Received: by 2002:a05:6000:1565:b0:22c:8da7:3cf8 with SMTP id 5-20020a056000156500b0022c8da73cf8mr5643302wrz.688.1664116879959;
        Sun, 25 Sep 2022 07:41:19 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm20774761wms.1.2022.09.25.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:41:18 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 4/7] sched/fair: Take into account latency priority at wakeup
Date:   Sun, 25 Sep 2022 16:39:05 +0200
Message-Id: <20220925143908.10846-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925143908.10846-1-vincent.guittot@linaro.org>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
         |<-----------------------|    .
         | % of sysctl_sched_latency   .
111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
preempt->|<- se doesn't preempt curr ------------------------------------------

Tests results of nice latency impact on heavy load like hackbench:

hackbench -l (2560 / group) -g group
group        latency 0             latency 19
1            1.350(+/- 1.10%)      1.287(+/- 1.60%) + 5%
4            1.392(+/- 1.67%)      1.248(+/- 1.51%) +11%
8            1.294(+/- 1.56%)      1.254(+/- 1.96%) + 3%
16           1.315(+/- 1.02%)      1.288(+/- 1.53%) + 2%

hackbench -p -l (2560 / group) -g group
group
1            1.768(+/- 13%)      0.805(+/- 2%) +54%
4            1.634(+/- 13%)      0.765(+/- 1%) +53%
8            1.305(+/-  4%)      0.745(+/- 2%) +43%
16           0.786(+/-  4%)      0.705(+/- 2%) +10%

By deacreasing the latency prio, we reduce the number of preemption at
wakeup and help hackbench making progress.

Test results of nice latency impact on short live load like cyclictest
while competing with heavy load like hackbench:

hackbench -l 10000 -g $group &
cyclictest --policy other -D 5 -q -n
        latency 0           latency -20
group   min  avg    max     min  avg    max
0       17    18     28      16   18     28
1       67   319   7369      63   76   2479
4       64   453  51699      45   95   8788
8       65   814  51699      63  116  19535
16      64  1275  37744      63  159  51134

group = 0 means that hackbench is not running.

The avg is significantly improved with nice latency -20 especially with
large number of groups but min and max remain quite similar. If we add the
histogram parameter to get details of latency, we have :

hackbench -l 10000 -g 16 &
cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
              latency 0    latency -20
Min Latencies:    63           63
Avg Latencies:  1459          214
Max Latencies: 58274        82358
50% latencies:   164           87
75% latencies:   848           91
85% latencies:  1246           94
90% latencies:  2149           96
95% latencies:  8463           99
99% latencies:>20000          120

With percentile details, we see the benefit of nice latency -20 as
only 1% of the latencies stays above 120us whereas the default latency
has got 25% are above 848us, 10% over the 2ms and 1% above 20ms.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  4 +++-
 init/init_task.c      |  2 +-
 kernel/sched/core.c   | 38 +++++++++++++++++++++++++----
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 56 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  | 14 ++++++++++-
 6 files changed, 105 insertions(+), 11 deletions(-)

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
index 6a6116ea4c2c..00fa2da12506 100644
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
+	offset = sysctl_sched_latency * weight;
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
index 5ffec4370602..c3f857630dcf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4574,6 +4574,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
+static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -4606,6 +4608,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 
 	se = __pick_first_entity(cfs_rq);
 	delta = curr->vruntime - se->vruntime;
+	delta -= wakeup_latency_gran(curr, se);
 
 	if (delta < 0)
 		return;
@@ -5732,6 +5735,35 @@ static int sched_idle_cpu(int cpu)
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
@@ -5818,14 +5850,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -7144,6 +7177,22 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
+	if ((se->latency_offset < 0) || (curr->latency_offset < 0))
+		latency_offset -= curr->latency_offset;
+
+	return latency_offset;
+}
+
 static unsigned long wakeup_gran(struct sched_entity *se)
 {
 	unsigned long gran = sysctl_sched_wakeup_granularity;
@@ -7183,6 +7232,9 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 {
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
 
+	/* Take into account latency priority */
+	vdiff -= wakeup_latency_gran(curr, se);
+
 	if (vdiff <= 0)
 		return -1;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eeb6efb0b610..80c4d2f5827f 100644
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

