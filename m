Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8996BC8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCPITN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCPITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:19:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA30B4829
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:18:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so4520826pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678954697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzxR0EBTeFO/0ZFfGE6ZRWS+I7Cd1oCMrLms8ta+vMk=;
        b=OPynaTHCG3nupnsSY/MaspMwOYcyHXo+IzTs/IdZ9H/qecbV4XOFodNb+l+pHYz8p5
         Z8R6P/4r2dTHnhjLTRZspwyCBsBhXe0UhJbrMh6V3jIdk7nHPJucTU2shnship0lM04e
         E964Gxc34w322ibCb1t7vq0/LJp/2WEE/7we/CYFCy73JZpAH8vf4S3PzZGKtEgcUq8I
         5ugQY96OgjZzIZ2GIc8QeNRzMdiezTUbH7mMJOWrrkqdMvdymvnNJUxVLmmqsMg9UbiJ
         mhVMsgflWc7MH17MYrh5hNefIlDwHYIjYk/FxriEAWWGgr6CAUs4z3uI3CQkIPf0aCrm
         5E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzxR0EBTeFO/0ZFfGE6ZRWS+I7Cd1oCMrLms8ta+vMk=;
        b=LBOf0gxlJfAXvqp9GgZJOB/6YIlrbF+A+bWKIoFZuDjvn57lkRMb7SHt31XvdnTAmC
         ikXN6zx+cHx36ZCDxaPKl7zsf6ZPNJyQEBcpil35LyrAw+2q9a6q23Xght3jc1iN4Gy8
         rvwquXO22FzjrCYJAxdeuSzwWQB1O4gmtTuP3O7JpVXAP/WeIW2PkmN2kd41D3Ym1kUW
         dtRm/IaAisdei1qX6S2jHlrB8fL1lcfw+3/gymH9/GWL4jBAwTQzEVTAnsbeVNgE08Lp
         NzL0dcnBuZUFohoYpH7EOrSUfSHzHVTf1EAtFkUfPAt40pGQ4kGui6wSEJqIpsAIQwrn
         CGEg==
X-Gm-Message-State: AO0yUKWcCQRMsmarjX5pOD+oD/fByzIFMm1Kd3sFniPS+cW333akW7nJ
        HskxlXvw96S3neHZEV0D2jAU9s4CsJqd1PheAcU=
X-Google-Smtp-Source: AK7set9fr0ODdMBCtXYEvJU3EsYEw1EwbT8LqPrvGpnQbP01tYv5LyvARJk7qlQfNqv4gNYje1mbSg==
X-Received: by 2002:a05:6a20:7d98:b0:d6:a2f9:ca80 with SMTP id v24-20020a056a207d9800b000d6a2f9ca80mr3332688pzj.16.1678954697343;
        Thu, 16 Mar 2023 01:18:17 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id h7-20020a62b407000000b0056283e2bdbdsm4811988pfn.138.2023.03.16.01.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:18:17 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Subject: [PATCH] sched/core: Avoid selecting the task that is throttled to run when core-sched enable
Date:   Thu, 16 Mar 2023 16:18:06 +0800
Message-Id: <20230316081806.69544-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/core.c     | 60 ++++++++++++++++++++++++++++-------------
 kernel/sched/deadline.c | 10 +++++++
 kernel/sched/fair.c     | 16 +++++++++++
 kernel/sched/rt.c       | 19 +++++++++++++
 kernel/sched/sched.h    |  4 +++
 5 files changed, 90 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e038b48..27cb06e19b12 100644
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
+		p = container_of(node, struct task_struct, core_node);
+		if (p->core_cookie != cookie)
+			return NULL;
+	} while (sched_task_is_throttled(p, cpu));
+
+	return p;
+}
 
-	node = rb_next(node);
+/*
+ * Find left-most (aka, highest priority) and unthrottled task matching @cookie.
+ * If no suitable task is found, NULL will be returned.
+ */
+static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+{
+	struct task_struct *p;
+	struct rb_node *node;
+
+	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
 	if (!node)
 		return NULL;
 
-	p = container_of(node, struct task_struct, core_node);
-	if (p->core_cookie != cookie)
-		return NULL;
+	p = __node_2_sc(node);
 
-	return p;
+	if (!sched_task_is_throttled(p, rq->cpu))
+		return p;
+
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
index 71b24371a6f7..4cc7e1ca066d 100644
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
index 7a1b1f855b96..b572367249f0 100644
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
index 0a11f44adee5..9d67dfbf1000 100644
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
index 3e8df6d31c1e..060616944d7a 100644
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
-- 
2.37.0

