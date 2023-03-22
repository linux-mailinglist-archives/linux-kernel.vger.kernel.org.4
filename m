Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3FD6C4646
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCVJXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCVJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:23:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A833A274;
        Wed, 22 Mar 2023 02:23:01 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZELIwYZ8L6F5pqqKps8wkN2X6To3X1oeIsElFB0L0V8=;
        b=HjTMiV7QRJ/MT/Zq4ooAr06xd+LNTMe+msUy/j567bNmeLpcDgg9oU+4F+q1DRroHGoybh
        PmIDx7+kpXFgeQlNzCSJ++ljgHZBNYEpbaIcYdHE+dxzN4GYkxnx6hb8GFoIWS+riYHGoV
        V97OqjZnJIllwH0FMrtvPgZ6aii5u3zY63upoO9g69xSWM3UpUld2Ddde8pu6sce8aWVGL
        Lj9ALBoCQSs+g7jUif66FLQ4bpdf9W0wrxC5so1i7j+m5mM9OHxGJuIiNsm/gKl7ZXX4vC
        dsgZUCTYKlinASKk+vqGb7GY+c8jGNHSg6mpQ9q1fBd+kL6RG3AeKnSJO85B7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZELIwYZ8L6F5pqqKps8wkN2X6To3X1oeIsElFB0L0V8=;
        b=LGUyAjDTF2fufNfZxRdJiDVGxHoZmNqMYCUwJUy5KhFnc+fEVBCa2yhaX4CsHO1id/4DSz
        Wip49NCKwtwF5EBQ==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Avoid selecting the task that is
 throttled to run when core-sched enable
Cc:     Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230316081806.69544-1-jiahao.os@bytedance.com>
References: <20230316081806.69544-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <167947694502.5837.16156353798978583164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     530bfad1d53d103f98cec66a3e491a36d397884d
Gitweb:        https://git.kernel.org/tip/530bfad1d53d103f98cec66a3e491a36d397884d
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Thu, 16 Mar 2023 16:18:06 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 10:10:58 +01:00

sched/core: Avoid selecting the task that is throttled to run when core-sched enable

When {rt, cfs}_rq or dl task is throttled, since cookied tasks
are not dequeued from the core tree, So sched_core_find() and
sched_core_next() may return throttled task, which may
cause throttled task to run on the CPU.

So we add checks in sched_core_find() and sched_core_next()
to make sure that the return is a runnable task that is
not throttled.

Co-developed-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230316081806.69544-1-jiahao.os@bytedance.com
---
 kernel/sched/core.c     | 60 +++++++++++++++++++++++++++-------------
 kernel/sched/deadline.c | 10 +++++++-
 kernel/sched/fair.c     | 16 +++++++++++-
 kernel/sched/rt.c       | 19 +++++++++++++-
 kernel/sched/sched.h    |  4 +++-
 5 files changed, 90 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 488655f..9140a33 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -261,36 +261,51 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 		resched_curr(rq);
 }
 
-/*
- * Find left-most (aka, highest priority) task matching @cookie.
- */
-static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+static int sched_task_is_throttled(struct task_struct *p, int cpu)
 {
-	struct rb_node *node;
-
-	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
-	/*
-	 * The idle task always matches any cookie!
-	 */
-	if (!node)
-		return idle_sched_class.pick_task(rq);
+	if (p->sched_class->task_is_throttled)
+		return p->sched_class->task_is_throttled(p, cpu);
 
-	return __node_2_sc(node);
+	return 0;
 }
 
 static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
 {
 	struct rb_node *node = &p->core_node;
+	int cpu = task_cpu(p);
+
+	do {
+		node = rb_next(node);
+		if (!node)
+			return NULL;
+
+		p = __node_2_sc(node);
+		if (p->core_cookie != cookie)
+			return NULL;
+
+	} while (sched_task_is_throttled(p, cpu));
+
+	return p;
+}
+
+/*
+ * Find left-most (aka, highest priority) and unthrottled task matching @cookie.
+ * If no suitable task is found, NULL will be returned.
+ */
+static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+{
+	struct task_struct *p;
+	struct rb_node *node;
 
-	node = rb_next(node);
+	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
 	if (!node)
 		return NULL;
 
-	p = container_of(node, struct task_struct, core_node);
-	if (p->core_cookie != cookie)
-		return NULL;
+	p = __node_2_sc(node);
+	if (!sched_task_is_throttled(p, rq->cpu))
+		return p;
 
-	return p;
+	return sched_core_next(p, cookie);
 }
 
 /*
@@ -6236,7 +6251,7 @@ static bool try_steal_cookie(int this, int that)
 		goto unlock;
 
 	p = sched_core_find(src, cookie);
-	if (p == src->idle)
+	if (!p)
 		goto unlock;
 
 	do {
@@ -6248,6 +6263,13 @@ static bool try_steal_cookie(int this, int that)
 
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
+		/*
+		 * sched_core_find() and sched_core_next() will ensure that task @p
+		 * is not throttled now, we also need to check whether the runqueue
+		 * of the destination CPU is being throttled.
+		 */
+		if (sched_task_is_throttled(p, this))
+			goto next;
 
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b2437..4cc7e1c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2704,6 +2704,13 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+static int task_is_throttled_dl(struct task_struct *p, int cpu)
+{
+	return p->dl.dl_throttled;
+}
+#endif
+
 DEFINE_SCHED_CLASS(dl) = {
 
 	.enqueue_task		= enqueue_task_dl,
@@ -2736,6 +2743,9 @@ DEFINE_SCHED_CLASS(dl) = {
 	.switched_to		= switched_to_dl,
 
 	.update_curr		= update_curr_dl,
+#ifdef CONFIG_SCHED_CORE
+	.task_is_throttled	= task_is_throttled_dl,
+#endif
 };
 
 /* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a1b1f8..b572367 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11933,6 +11933,18 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 	return delta > 0;
 }
+
+static int task_is_throttled_fair(struct task_struct *p, int cpu)
+{
+	struct cfs_rq *cfs_rq;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	cfs_rq = task_group(p)->cfs_rq[cpu];
+#else
+	cfs_rq = &cpu_rq(cpu)->cfs;
+#endif
+	return throttled_hierarchy(cfs_rq);
+}
 #else
 static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
 #endif
@@ -12559,6 +12571,10 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_change_group	= task_change_group_fair,
 #endif
 
+#ifdef CONFIG_SCHED_CORE
+	.task_is_throttled	= task_is_throttled_fair,
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK
 	.uclamp_enabled		= 1,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44..9d67dfb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2677,6 +2677,21 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 		return 0;
 }
 
+#ifdef CONFIG_SCHED_CORE
+static int task_is_throttled_rt(struct task_struct *p, int cpu)
+{
+	struct rt_rq *rt_rq;
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	rt_rq = task_group(p)->rt_rq[cpu];
+#else
+	rt_rq = &cpu_rq(cpu)->rt;
+#endif
+
+	return rt_rq_throttled(rt_rq);
+}
+#endif
+
 DEFINE_SCHED_CLASS(rt) = {
 
 	.enqueue_task		= enqueue_task_rt,
@@ -2710,6 +2725,10 @@ DEFINE_SCHED_CLASS(rt) = {
 
 	.update_curr		= update_curr_rt,
 
+#ifdef CONFIG_SCHED_CORE
+	.task_is_throttled	= task_is_throttled_rt,
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK
 	.uclamp_enabled		= 1,
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d..0606169 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2224,6 +2224,10 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p);
 #endif
+
+#ifdef CONFIG_SCHED_CORE
+	int (*task_is_throttled)(struct task_struct *p, int cpu);
+#endif
 };
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
