Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725F864018B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiLBIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiLBIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:06:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E510934EA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:06:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o12so4202451pjo.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D84hfbqZitUA1X32kPBv1SQQXYvCLsU+gMkXU1h6U+s=;
        b=oYA2eu1XPZt1mXSfBeeHgqydjwLj+6nBD8zAFPq13Mir3dz1OGn9daXwGXi6ldKS/i
         34P9Ckf63zMi7SxUpdKn0ZAPRmSmCfquJW3+7tZ8kD77poq7nVcF8d70K36VTvbRdiJo
         8TRm+em3erdZLIXRdRYQfQdPM2aKy+3G+EAHDxpmPf7Q8FxYTKZefBrGKfvL6V8m1oh4
         XbWu1sa/Sj4GkqHx+mLKkfxXjIo+HEbxz3hSmtGX2qgFktG0rQjHnvMlu1NP84Za8tJ9
         9jLDH7ya1RsefjDR/etH9EZGdr0siwUNLcZVdLX83YXO9AnNBdEdu5Tha/qp7PtfmLIF
         A7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D84hfbqZitUA1X32kPBv1SQQXYvCLsU+gMkXU1h6U+s=;
        b=17Sfvpx5QmiF4ew3Cy8Uhd/QcNT/37b1sWUJk5PhvWMiOmvkF8Edwdc6gPLa9O/5dI
         NhBlJr+x177+l7gqBQpqVwPFeRqKtReFLFf9mUOB6gMOZTbLAlfAL2vvhzsOcC3InLY2
         0KQudzDAWNR91nilAFtmKAOSU9+BYLxHmxMCc+0KoHuBEa5HStSl7Kz8Z7nzyqUUSj9A
         R5UW1tZ9m2q+SXg/AHwlK2T8v6yKu8FXUBMZaol5YuuNap40dA+a5keGebKcKCxdCxVu
         wyx1MYbEGrT87U4NFcPhtpnpcsFJNwgKuPtshcjtfY+m9BIdlErYMASIjzVono8Kdz8P
         hW+Q==
X-Gm-Message-State: ANoB5pmRS1UDTTLX+M6xib8nxO9JpGwLq4A1U+aByLfuPWOmMh7Aeb6B
        40xEcRvbacFH3NWQDV3OKV4BlA==
X-Google-Smtp-Source: AA0mqf5yUHgkCYSaAYj1JHOmuB1YALaqGdf3mleWRB6ow0sxTy4iOfcSjrMwIIXzd8GXcrVCMMgMYA==
X-Received: by 2002:a17:902:db09:b0:186:def0:4886 with SMTP id m9-20020a170902db0900b00186def04886mr54965418plx.152.1669968416751;
        Fri, 02 Dec 2022 00:06:56 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b0018980f14ecfsm4985339plx.115.2022.12.02.00.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:06:56 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vschneid@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4] sched/core: Minor optimize ttwu_runnable()
Date:   Fri,  2 Dec 2022 16:06:44 +0800
Message-Id: <20221202080644.76999-1-zhouchengming@bytedance.com>
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

Reorganize ttwu_do_wakeup() and ttwu_do_activate() to make
ttwu_do_wakeup() only mark the task runnable, so it can be used
in ttwu_runnable() and try_to_wake_up() fast paths.

This also removes the class->task_woken() callback from ttwu_runnable(),
which wasn't required per the RT/DL implementations: any required push
operation would have been queued during class->set_next_task() when p
got preempted.

ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
the rq cannot be idle in this scenario.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
v4:
 - s/This patch reorg/Reorganize/ per Bagas Sanjaya. Thanks!

v3:
 - Improve the changelog per Valentin Schneider. Thanks!

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
index 314c2c0219d9..d8216485b0ad 100644
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
@@ -4086,8 +4092,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		trace_sched_waking(p);
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		goto out;
 	}
 
-- 
2.37.2

