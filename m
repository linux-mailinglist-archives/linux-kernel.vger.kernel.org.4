Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC07C6AC397
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCFOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCFOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:43:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3951724
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XIEqWJFCXWuOHUykrcllyv7yeS4tw9zdWylKMEFcjy4=; b=ouW+UUfKkXxl2Nh4mUyaux/y0S
        yV2Dz/4FAuV2JGWuoKy4ldrohsjXYOmSFr8+a1U6lDwIAdAnHaVCDPg5V6yBSFagKm5JzXchdxJK5
        +fGofD4H39r+6LStukk5ow9wRv8Cu6WEEJkuWMqZlAXChzvkQE7bJg02/g7w4DS8XcWsP1N15zBct
        QeN0vev/rbzBb3kbSjsKkRqTDGF7d2I0S2LsBGH4tRja1mxE8SBd5bt4pLl1rT4hpOGzqLlBaY/sf
        oVj1voFKpHzH/z+hF/rwYmRc6jgNVFwZdxqDovv+clAD6Qm8fvkkoso/nB0r8m1uXAUbvgTR6YkWr
        7mpeII3A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZBe5-005P2L-J3; Mon, 06 Mar 2023 14:16:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 188D0300C1E;
        Mon,  6 Mar 2023 15:16:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0097520110FF9; Mon,  6 Mar 2023 15:16:54 +0100 (CET)
Message-ID: <20230306141502.449738212@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 06 Mar 2023 14:25:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: [PATCH 04/10] sched/fair: Add latency_offset
References: <20230306132521.968182689@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

XXX fold back into previous patches

Murdered-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h      |    4 +++-
 include/linux/sched/prio.h |    9 +++++++++
 init/init_task.c           |    2 +-
 kernel/sched/core.c        |   21 ++++++++++++++++-----
 kernel/sched/debug.c       |    2 +-
 kernel/sched/fair.c        |    8 ++++++++
 kernel/sched/sched.h       |    2 ++
 7 files changed, 40 insertions(+), 8 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -568,6 +568,8 @@ struct sched_entity {
 	/* cached value of my_q->h_nr_running */
 	unsigned long			runnable_weight;
 #endif
+	/* preemption offset in ns */
+	long				latency_offset;
 
 #ifdef CONFIG_SMP
 	/*
@@ -784,7 +786,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
-	int				latency_nice;
+	int				latency_prio;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -59,5 +59,14 @@ static inline long rlimit_to_nice(long p
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
 
 #endif /* _LINUX_SCHED_PRIO_H */
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,7 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
-	.latency_nice	= DEFAULT_LATENCY_NICE,
+	.latency_prio	= DEFAULT_LATENCY_PRIO,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1285,6 +1285,11 @@ static void set_load_weight(struct task_
 	}
 }
 
+static void set_latency_offset(struct task_struct *p)
+{
+	p->se.latency_offset = calc_latency_offset(p->latency_prio);
+}
+
 #ifdef CONFIG_UCLAMP_TASK
 /*
  * Serializes updates of utilization clamp values
@@ -4433,6 +4438,8 @@ static void __sched_fork(unsigned long c
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
+	set_latency_offset(p);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
@@ -4684,7 +4691,9 @@ int sched_fork(unsigned long clone_flags
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
-		p->latency_nice = DEFAULT_LATENCY_NICE;
+		p->latency_prio = NICE_TO_LATENCY(0);
+		set_latency_offset(p);
+
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -7456,8 +7465,10 @@ static void __setscheduler_params(struct
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
@@ -7642,7 +7653,7 @@ static int __sched_setscheduler(struct t
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
-		    attr->sched_latency_nice != p->latency_nice)
+		    attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
@@ -8183,7 +8194,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pi
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
-	kattr.sched_latency_nice = p->latency_nice;
+	kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_st
 #endif
 	P(policy);
 	P(prio);
-	P(latency_nice);
+	P(latency_prio);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -703,6 +703,14 @@ int sched_update_scaling(void)
 }
 #endif
 
+long calc_latency_offset(int prio)
+{
+	u32 weight = sched_prio_to_weight[prio];
+	u64 base = sysctl_sched_min_granularity;
+
+	return div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
+}
+
 /*
  * delta /= w
  */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2475,6 +2475,8 @@ extern unsigned int sysctl_numa_balancin
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
+extern long calc_latency_offset(int prio);
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*


