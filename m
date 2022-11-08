Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9749A621947
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiKHQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:24:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2111FF92
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:24:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so13836456pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yCX2R3Fyrh3hfGMJZLisOqoTG9DTLxwNXqWhh5m4aA=;
        b=1yWeD/D8xf78lK8EFzn6qZAt2au3YWGPXJdWuvb/VG9/t72yBbmrlDh7XZtVX1JEFk
         rQK8LKoXRCsucUJ94B9aMk+0LhZJgvNwbtD/OSuOj06FpB+GtuKhjL3y1x5iN20Xs1nY
         U0p+Y6D6EbVKnjcgUXBPIGy67dxMYQfT2ejm+luF2iGg6tfgIVTmga2G22z91ZGs1cw7
         gJ/Q5lixYtDh9WEwGksADjHDdcqQkg8OuxnSZhf5bBGGdvfklcsH0WKwWnPsGe0IbcLY
         fsPOThl78ZVfJglbCBHY0v9yCGFYk5ygE0T1rkEfORgj0ByMNeE/Fxj7O/hH3dg4o4TK
         3tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yCX2R3Fyrh3hfGMJZLisOqoTG9DTLxwNXqWhh5m4aA=;
        b=lwvMTIRu3KCVUJivkNoBrFeLEjZHWeZFRymVOwDrGT+HlXHl6g54d9F4NWuYOePqT7
         lpwU5hnFzmhHRXz6UKGwcyhk6ozDOAa0nEAFEja5UBatZzYrjOz9Z87TrIHTPt+Boc7o
         Il0m2HFLzMfQwFDdaN7IUa0Ghpq6WVph1STL5VD/7a8Sn/YlNf+5tjz8NeZyvKt971hW
         Vz2Hof/rhtVztBbZw9eqgOoDUqhUxOHAbX0VCi35Y9bFgq8X1KfckKCRPrqVAu8DcvZa
         cjS/7Xtjpm49xeW7NpFV8rGBA2cXoHgezhoGFjR121EpgyWc/3Vr27dEJR6UZz0t9Ors
         EEPw==
X-Gm-Message-State: ACrzQf0ON5dlPozlpIseGC2v7CJDtb3Et50lO3pi3drqs6+OzVOefssa
        BNYyX9OKc2VOuFHJ6eilfiTfuw==
X-Google-Smtp-Source: AMsMyM7PtuUS6VdUbjc7sP3fXfb2r59zv6RljKcXMcN9BPlXH7a7VQbTGXTiCqN6tI5sKRjM5Uwonw==
X-Received: by 2002:a17:90a:a88f:b0:214:25ce:fa67 with SMTP id h15-20020a17090aa88f00b0021425cefa67mr38062231pjq.116.1667924653486;
        Tue, 08 Nov 2022 08:24:13 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id oj15-20020a17090b4d8f00b0020c899b11f1sm8173294pjb.23.2022.11.08.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 08:24:12 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, vschneid@redhat.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] sched/core: Minor optimize ttwu_runnable()
Date:   Wed,  9 Nov 2022 00:24:02 +0800
Message-Id: <20221108162402.99125-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ttwu_runnable() is used as a fast wakeup path when the wakee task
is running on CPU or runnable on RQ, in both cases we can just
set its state to TASK_RUNNING to prevent a sleep.

If the wakee task is on_cpu running, we don't need to update_rq_clock()
or check_preempt_curr().

But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
the task got to schedule() and the task been preempted), we should
check_preempt_curr() to see if it can preempt the current running.

This patch reorg ttwu_do_wakeup() and ttwu_do_activate() to make
ttwu_do_wakeup() only mark the task runnable, so it can be used
in ttwu_runnable() and try_to_wake_up() fast paths.

As for p->sched_class->task_woken(), ttwu_do_wakeup() needn't it
anymore, since p isn't a woken task in this case, so should not
affect RT/DL push/pull.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
v2:
 - keep check_preempt_curr() for on_rq && !on_cpu case in ttwu_runnable(),
   per Valentin Schneider.
 - reorg ttwu_do_wakeup() and ttwu_do_activate() code, so ttwu_do_wakeup()
   can be reused in ttwu_runnable(), per Peter Zijlstra.
 - reuse ttwu_do_wakeup() in try_to_wake_up() (p == current) fast path too,
   so ttwu_do_wakeup() become the only place we mark task runnable.
---
 kernel/sched/core.c | 73 ++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15e167a1c5bd..78b5075191b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3623,14 +3623,39 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 }
 
 /*
- * Mark the task runnable and perform wakeup-preemption.
+ * Mark the task runnable.
  */
-static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
-			   struct rq_flags *rf)
+static inline void ttwu_do_wakeup(struct task_struct *p)
 {
-	check_preempt_curr(rq, p, wake_flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
 	trace_sched_wakeup(p);
+}
+
+static void
+ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
+		 struct rq_flags *rf)
+{
+	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
+
+	lockdep_assert_rq_held(rq);
+
+	if (p->sched_contributes_to_load)
+		rq->nr_uninterruptible--;
+
+#ifdef CONFIG_SMP
+	if (wake_flags & WF_MIGRATED)
+		en_flags |= ENQUEUE_MIGRATED;
+	else
+#endif
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
+
+	activate_task(rq, p, en_flags);
+	check_preempt_curr(rq, p, wake_flags);
+
+	ttwu_do_wakeup(p);
 
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
@@ -3660,31 +3685,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 }
 
-static void
-ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
-		 struct rq_flags *rf)
-{
-	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
-
-	lockdep_assert_rq_held(rq);
-
-	if (p->sched_contributes_to_load)
-		rq->nr_uninterruptible--;
-
-#ifdef CONFIG_SMP
-	if (wake_flags & WF_MIGRATED)
-		en_flags |= ENQUEUE_MIGRATED;
-	else
-#endif
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
-	activate_task(rq, p, en_flags);
-	ttwu_do_wakeup(rq, p, wake_flags, rf);
-}
-
 /*
  * Consider @p being inside a wait loop:
  *
@@ -3718,9 +3718,15 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
+		if (!task_on_cpu(rq, p)) {
+			/*
+			 * When on_rq && !on_cpu the task is preempted, see if
+			 * it should preempt whatever is current there now.
+			 */
+			update_rq_clock(rq);
+			check_preempt_curr(rq, p, wake_flags);
+		}
+		ttwu_do_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
@@ -4082,8 +4088,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		trace_sched_waking(p);
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		goto out;
 	}
 
-- 
2.37.2

