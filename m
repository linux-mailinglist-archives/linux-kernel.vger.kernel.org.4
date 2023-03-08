Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C016B03B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCHKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCHKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:05:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1B7B491
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:04:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so1724538pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678269875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9REEP/8ROAureHI/NaNojTlrwNXg/sHpmQLban0nLw=;
        b=WtEwAN7f4WNf0+O0RFrUJtgdnKhz/yXbAl6pZL5Wt/FqUavJhtBGmKdouF9wkb6qSZ
         Tv/OS0t5v4YgN85io+R6Wg7xnjFlVz/jraPxVHmKY7ifTBfV0e0uxNidMxberE6eL1N3
         QXaGLYbdLCfKdNKYeGaDsgUUYEvx9FBbbOUvqP8edKr2akEBShSaPVQzNyrW+jPpBGu8
         Vh2pNQ8csPMEWYGYThJP6zvxg/U1K86sCpPLUEELmc/GFmfVfwzwpBUU5w77ZGGMPhFQ
         RkDnsWvII4XbHvEJNL0Tb2SvgFq5sGVEUIi6+4cysiKElUa0PqNdvvuUdpm6iNTR6GBu
         1E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9REEP/8ROAureHI/NaNojTlrwNXg/sHpmQLban0nLw=;
        b=NdzZv/mMh1hEmINg5w0ec5g5WTcl/al6V3HIJHNpNFlUd5Y5gdoi13i4pxw1papiX6
         Q+zWxqCZmeqOBlFK4OIouunw8G2aOSuEvoN/QV+66iC4GyjP7Fzb/PnvkWqVni0tLjpe
         c0q61Pv96TjgW9riRBlLmm2E9bGgku8iLFRHK21/gwqgr9U3Z1w1Ns146S6crHiIwSQl
         GKbuobhNn+jmxpTGGVNAFHJDWOEFQrEXs9Q5iJSfZCf07y9ewoM99iY94yIYrFvT9AHg
         MsJtMML8EuUBfy2wXHVDZzPefHEUoEhijsUtykcrykjjHJg3FSX7dZ313DvZD9Y9Emzz
         w/QQ==
X-Gm-Message-State: AO0yUKVx7qeAWmX+sf50D048OuJUgWJ5tqskHqrjfALSOVn2bPgUpFur
        nXHqjpagtJy9QkqCfMVvCtGcJw==
X-Google-Smtp-Source: AK7set8804YjQtp1/hGBWudP/34T/upP0AAPNFVt4rZB3Lrqp9wYRfcmFeYYZMOCHP9DPZUFVteG6g==
X-Received: by 2002:a05:6a20:4fa4:b0:cb:af96:9687 with SMTP id gh36-20020a056a204fa400b000cbaf969687mr13462057pzb.15.1678269875253;
        Wed, 08 Mar 2023 02:04:35 -0800 (PST)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b005813f365afcsm9171874pfb.189.2023.03.08.02.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:04:34 -0800 (PST)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] sched/core: Minor optimize pick_next_task() when core-sched enable
Date:   Wed,  8 Mar 2023 18:04:13 +0800
Message-Id: <20230308100414.37114-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If core-sched is enabled, sometimes we will traverse each CPU on the core
to find the highest priority task 'max' on the entire core, and then try
and find a runnable task that matches @max.
But in the following case, we choose the runnable task is not the best.

core max: task2 (cookie 0)

	rq0				rq1
task0(cookie non-zero)		task2(cookie 0)
task1(cookie 0)
task3(cookie 0)
...

pick-task: idle			pick-task: task2

CPU0 and CPU1 are two CPUs on the same core, task0 and task2 are the
highest priority tasks on rq0 and rq1 respectively, task2 is @max
on the entire core.

In the case that 'max' has a zero cookie, instead of continuing to
search for a runnable task on rq0 that matches @max's cookie, we
choose idle for rq0 directly.
At this time, it is obviously better to choose task1 to run for rq0,
which will increase the CPU utilization.
Therefore, we queue tasks with zero cookies in core_tree, and record
the number of non-zero cookie tasks of each rq to detect the status
of the sched-core.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c       | 29 +++++++++++++++--------------
 kernel/sched/core_sched.c |  9 ++++-----
 kernel/sched/sched.h      |  1 +
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e038b48..765cd14c52e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -236,8 +236,8 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
-		return;
+	if (p->core_cookie)
+		rq->cookied_count++;
 
 	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
 }
@@ -246,11 +246,16 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 {
 	rq->core->core_task_seq++;
 
+	if (p->core_cookie)
+		rq->cookied_count--;
+
 	if (sched_core_enqueued(p)) {
 		rb_erase(&p->core_node, &rq->core_tree);
 		RB_CLEAR_NODE(&p->core_node);
 	}
 
+	if (!sched_core_enabled(rq))
+		return;
 	/*
 	 * Migrating the last task off the cpu, with the cpu in forced idle
 	 * state. Reschedule to create an accounting edge for forced idle,
@@ -370,7 +375,7 @@ static void sched_core_assert_empty(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		WARN_ON_ONCE(!RB_EMPTY_ROOT(&cpu_rq(cpu)->core_tree));
+		WARN_ON_ONCE(cpu_rq(cpu)->cookied_count);
 }
 
 static void __sched_core_enable(void)
@@ -2061,14 +2066,12 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 
-	if (sched_core_enabled(rq))
-		sched_core_enqueue(rq, p);
+	sched_core_enqueue(rq, p);
 }
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (sched_core_enabled(rq))
-		sched_core_dequeue(rq, p, flags);
+	sched_core_dequeue(rq, p, flags);
 
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
@@ -6126,13 +6129,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick;
 
-		if (!cookie_equals(p, cookie)) {
-			p = NULL;
-			if (cookie)
-				p = sched_core_find(rq_i, cookie);
-			if (!p)
-				p = idle_sched_class.pick_task(rq_i);
-		}
+		if (!cookie_equals(p, cookie))
+			p = sched_core_find(rq_i, cookie);
 
 		rq_i->core_pick = p;
 
@@ -6333,6 +6331,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 	sched_core_lock(cpu, &flags);
 
 	WARN_ON_ONCE(rq->core != rq);
+	WARN_ON_ONCE(rq->cookied_count);
 
 	/* if we're the first, we'll be our own leader */
 	if (cpumask_weight(smt_mask) == 1)
@@ -6425,6 +6424,7 @@ static inline void sched_core_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
+	WARN_ON_ONCE(rq->cookied_count);
 	if (rq->core != rq)
 		rq->core = rq;
 }
@@ -9917,6 +9917,7 @@ void __init sched_init(void)
 		rq->core = rq;
 		rq->core_pick = NULL;
 		rq->core_enabled = 0;
+		rq->cookied_count = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle_count = 0;
 		rq->core_forceidle_occupation = 0;
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f27498..70f424abcc2b 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -56,6 +56,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	unsigned long old_cookie;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool enqueued;
 
 	rq = task_rq_lock(p, &rf);
 
@@ -67,16 +68,14 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	 */
 	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
 
-	if (sched_core_enqueued(p))
+	enqueued = task_on_rq_queued(p);
+	if (enqueued)
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
 
 	old_cookie = p->core_cookie;
 	p->core_cookie = cookie;
 
-	/*
-	 * Consider the cases: !prev_cookie and !cookie.
-	 */
-	if (cookie && task_on_rq_queued(p))
+	if (enqueued)
 		sched_core_enqueue(rq, p);
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..f5a0ee7fccae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1148,6 +1148,7 @@ struct rq {
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned int		cookied_count;
 	unsigned int		core_forceidle_count;
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
-- 
2.11.0

