Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A0654F31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiLWKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLWKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:34:05 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7D28732
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:34:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x3so4610521pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBTCDvfK9c6UzSIP6NvqIg7a0cCvfRzIEpaDRlTGr6g=;
        b=6BvXIbIt7BQVxem2tvhC4ERzYcCfvWO7F3SH5gRhOzYBj/FjV0Gl0c7lgFDz+VnFGB
         +XHW71Fh4/VmiuZwK2v1+YCJNLwbG8y/EmUkdIVktfjj4IBZtPtvimtVAozFLhBhk8ff
         jtxna/DmfEZfhvxdWyydcDkgRVJzV/Txj6utwA0UJ++fR1N44Pi9wBo0pdZ9mQvRYHuf
         L+FJqvLM0ni+6dGDV3IUNw+XgZ8IjNi+ToJY+lkb5v4h7fCNYhOwWY0ZzuJDel2Vj5Cl
         5SM4UTrowuK+uuvmSDorOVMGTFLRW/o9dGjk8Oo/WEgWsShfR4Lrmad819Si7TTHqovP
         xW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBTCDvfK9c6UzSIP6NvqIg7a0cCvfRzIEpaDRlTGr6g=;
        b=yrBzRtpXnHwwwloWb3vDHZrO3I2V40VyMkjfFTbDHwcEuxHLFzR43pingUvY3cFBE3
         hXcT6pCH1sLcbVMXGbKvFuCEIWcEaEXs4ZYCCwAqVKpklEYytbX4kn7H51h4y7MTtVLl
         IoNrxnSxjC2nlJY3S0NJr/qHUB91EvoSR6mTSZSqLUr4Dii5niYO+qI86fpa5jY90N1h
         XLbeA4YFdjtk63TT9P4vWoDAaEzM9EHMvfNbid7rgJ5FITkak4qDQOElIeu34i3+1eu/
         +Uv4uRgDcRyXGUwq8rZN4/OGJDTNQBBbVBcgyuooLCNh/1xCljkI6xWtmr8tv5m3Twz4
         +1Uw==
X-Gm-Message-State: AFqh2koxPGsv38WxGP6P6cTJ2DaCZZQ/BbdH8UuPqmfQbOpGp4j40fVx
        glDagKK3Kt6WOOoCck5ZwA+kug==
X-Google-Smtp-Source: AMrXdXt4frh17OKkII7wCsRH33HrHYaBUd4pxgWzU1EVBLJ1w0YN64ECz2V2da0PKyp6pX4ljx/obg==
X-Received: by 2002:a17:90a:c690:b0:21a:2d8:bf98 with SMTP id n16-20020a17090ac69000b0021a02d8bf98mr25385402pjt.10.1671791644599;
        Fri, 23 Dec 2022 02:34:04 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e6b:a810:15ee:4139:496a:7697])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a430700b0020bfd6586c6sm1976207pjg.7.2022.12.23.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:34:04 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 2/2] sched/core: Reorganize ttwu_do_wakeup() and ttwu_do_activate()
Date:   Fri, 23 Dec 2022 18:32:57 +0800
Message-Id: <20221223103257.4962-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223103257.4962-1-zhouchengming@bytedance.com>
References: <20221223103257.4962-1-zhouchengming@bytedance.com>
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

ttwu_do_activate() is used for a complete wakeup, in which we will
activate_task() and use ttwu_do_wakeup() to mark the task runnable
and perform wakeup-preemption, also call class->task_woken() callback
and update the rq->idle_stamp.

Since ttwu_runnable() is not a complete wakeup, don't need all those
done in ttwu_do_wakeup(), so we can move those to ttwu_do_activate()
to simplify ttwu_do_wakeup(), making it only mark the task runnable
to be reused in ttwu_runnable() and try_to_wake_up().

This patch should not have any functional changes.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/core.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 607a5430b192..3936b3328500 100644
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
@@ -3726,8 +3726,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 			update_rq_clock(rq);
 			check_preempt_curr(rq, p, wake_flags);
 		}
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
@@ -4093,8 +4092,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		trace_sched_waking(p);
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		goto out;
 	}
 
-- 
2.37.2

