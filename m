Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3ED693003
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBKKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBKKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:30:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A022196B;
        Sat, 11 Feb 2023 02:30:55 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:30:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676111454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ungYDX7qzyRMeHGhhRpZSXmVK1Nj64kF59rGW+NJBKg=;
        b=46hDFntxGBqknSmVIMYVDAoo8H2Ohd7rmP7Sv3aoeTgTINHnlpYWldTpklVW3Kj27fgehK
        ncJqUc/0HItXG0muxrd5rHqy6zSeXWG4e17JXq6OUVmrHV8UKVaJ29oivq23hN/hMfdy7t
        0mtNZhWLfso/3kUtmFgUeHIr/9/A/GOXHbAuKO+Z8XDHnmS6idRozbvHscfckQI3a2wHMK
        B1mF+ryvvHZ8KTy9eTh/VRbcTl/wUluxJE7fiRxKSawTAT+zRnlxl5sX3z75/C7RrHt3Se
        +yU3eaALFahvg4dJcPHTeULyLKRedcTmZ0HknBnGD8Vb2UiM+VwtR/U0rQxKtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676111454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ungYDX7qzyRMeHGhhRpZSXmVK1Nj64kF59rGW+NJBKg=;
        b=NepQjkASgEDH9BLtmMskoC1VpKVt5P0CA1udotDSVRT9mV5uLgyuWR5hvZVUOaNvrwi5w9
        vEwNXFgjrRDpR+DA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Add more reschedule cases to
 prio_changed_dl()
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230206140612.701871-1-vschneid@redhat.com>
References: <20230206140612.701871-1-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <167611145381.4906.16019956049524655182.tip-bot2@tip-bot2>
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

Commit-ID:     7ea98dfa44917a201e76d4fe96bf61d76e60f524
Gitweb:        https://git.kernel.org/tip/7ea98dfa44917a201e76d4fe96bf61d76e60f524
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Mon, 06 Feb 2023 14:06:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Feb 2023 11:18:10 +01:00

sched/deadline: Add more reschedule cases to prio_changed_dl()

I've been tracking down an issue on a ~5.17ish kernel where:

  CPUx                           CPUy

  <DL task p0 owns an rtmutex M>
  <p0 depletes its runtime, gets throttled>
  <rq switches to the idle task>
				 <DL task p1 blocks on M, boost/replenish p0>
				 <No call to resched_curr() happens here>

  [idle task keeps running here until *something*
   accidentally sets TIF_NEED_RESCHED]

On that kernel, it is quite easy to trigger using rt-tests's deadline_test
[1] with the test running on isolated CPUs (this reduces the chance of
something unrelated setting TIF_NEED_RESCHED on the idle tasks, making the
issue even more obvious as the hung task detector chimes in).

I haven't been able to reproduce this using a mainline kernel, even if I
revert

  2972e3050e35 ("tracing: Make trace_marker{,_raw} stream-like")

which gets rid of the lock involved in the above test, *but* I cannot
convince myself the issue isn't there from looking at the code.

Make prio_changed_dl() issue a reschedule if the current task isn't a
deadline one. While at it, ensure a reschedule is emitted when a
queued-but-not-current task gets boosted with an earlier deadline that
current's.

[1]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20230206140612.701871-1-vschneid@redhat.com
---
 kernel/sched/deadline.c | 42 +++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0d97d54..71b2437 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2663,17 +2663,20 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 			    int oldprio)
 {
-	if (task_on_rq_queued(p) || task_current(rq, p)) {
+	if (!task_on_rq_queued(p))
+		return;
+
 #ifdef CONFIG_SMP
-		/*
-		 * This might be too much, but unfortunately
-		 * we don't have the old deadline value, and
-		 * we can't argue if the task is increasing
-		 * or lowering its prio, so...
-		 */
-		if (!rq->dl.overloaded)
-			deadline_queue_pull_task(rq);
+	/*
+	 * This might be too much, but unfortunately
+	 * we don't have the old deadline value, and
+	 * we can't argue if the task is increasing
+	 * or lowering its prio, so...
+	 */
+	if (!rq->dl.overloaded)
+		deadline_queue_pull_task(rq);
 
+	if (task_current(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
@@ -2681,15 +2684,24 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		 */
 		if (dl_time_before(rq->dl.earliest_dl.curr, p->dl.deadline))
 			resched_curr(rq);
-#else
+	} else {
 		/*
-		 * Again, we don't know if p has a earlier
-		 * or later deadline, so let's blindly set a
-		 * (maybe not needed) rescheduling point.
+		 * Current may not be deadline in case p was throttled but we
+		 * have just replenished it (e.g. rt_mutex_setprio()).
+		 *
+		 * Otherwise, if p was given an earlier deadline, reschedule.
 		 */
-		resched_curr(rq);
-#endif /* CONFIG_SMP */
+		if (!dl_task(rq->curr) ||
+		    dl_time_before(p->dl.deadline, rq->curr->dl.deadline))
+			resched_curr(rq);
 	}
+#else
+	/*
+	 * We don't know if p has a earlier or later deadline, so let's blindly
+	 * set a (maybe not needed) rescheduling point.
+	 */
+	resched_curr(rq);
+#endif
 }
 
 DEFINE_SCHED_CLASS(dl) = {
