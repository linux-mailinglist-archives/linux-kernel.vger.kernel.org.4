Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43423660E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjAGKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjAGKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:53:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF41AA01;
        Sat,  7 Jan 2023 02:53:02 -0800 (PST)
Date:   Sat, 07 Jan 2023 10:53:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zotIngnfFjUCAlEXnwMFZZiKtOu852+3JcwkGFgHyGI=;
        b=D7SFbj7iRON1xym7pO2Yd5j+VZDjiza5Oe29ZLm7s6HpVmrLojMMWx4q/DK8y332jKiC8O
        1M48+emaXZ2vB/JUAj7n04lrGTjHdx7PEfgNuFpBPYGjQ9lxSdoDv5ItRuAIxDjE+nBcYu
        o2eHXw0+97SRH6gmlOyvM97wOH7UOh16TH3xaX3yD+yT39Ew2f0JlQ55s2bcTvOR5S7/5j
        033/ETHZZmjQycLscJOeO1OuoXLXVRKiPVOhakm/chKxbcWuPPGS6e0DppeG07goavsJD8
        RuRuqaWs/sJWp29Slfz4/rExzHJ6oOHYxd0IMHM5gu5bwICwh0AUpJsxw+ZwpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zotIngnfFjUCAlEXnwMFZZiKtOu852+3JcwkGFgHyGI=;
        b=FIxCSEoj7dUot1ZPrumcwqzfSAL+it4aJCc2PTGDkyGua3d2gU1lccgjayrc/6Qdzyvecv
        A5g9FiwjlwQERfCw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Reorganize ttwu_do_wakeup() and
 ttwu_do_activate()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221223103257.4962-2-zhouchengming@bytedance.com>
References: <20221223103257.4962-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <167308878040.4906.10135833329024897698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     160fb0d83f206b3429fc495864a022110f9e4978
Gitweb:        https://git.kernel.org/tip/160fb0d83f206b3429fc495864a022110f9e4978
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 23 Dec 2022 18:32:57 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 10:48:38 +01:00

sched/core: Reorganize ttwu_do_wakeup() and ttwu_do_activate()

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221223103257.4962-2-zhouchengming@bytedance.com
---
 kernel/sched/core.c | 64 +++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 255a318..03b8529 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3625,14 +3625,39 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
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
@@ -3662,31 +3687,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
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
@@ -3728,8 +3728,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 			update_rq_clock(rq);
 			check_preempt_curr(rq, p, wake_flags);
 		}
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
@@ -4095,8 +4094,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		trace_sched_waking(p);
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		goto out;
 	}
 
