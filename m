Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33926278C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiKNJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiKNJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:10:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F14614E;
        Mon, 14 Nov 2022 01:10:17 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:10:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668417015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y49qs12nsxt1d/LMV8DSpp4/FrBjPgi64qdyTM5CjJ8=;
        b=CSRrCbw8iunTbgSOicinysJ0A9phuWnbNqQLntaxcZtU7tPu/yDuTCVC3M/5FhRGKCf89C
        a4dN7tsaqq5kQvEEmOawg9tib+nlFuKxXuGw+EezpwNhphyx6FZiXcjFDzlEU7/iUgIb0o
        DRZQDvfs757Ky+378XAXjpMqovex/CRkzK7IG7LKAQv6N6Zqm5G4HRkqelxwSx0rT3/6Rm
        4JgRr5Njz8DXOUn97Vfcyvtba0/vLyyzwO6kYVLUssmWHbZyheuOAfiqNM4fcNnExvgYfV
        0sHieNALN7H/yu2hlUv6AyQAybopcc+p10cW/Gb97WTseLAAwjWQQD+DQMIXjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668417015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y49qs12nsxt1d/LMV8DSpp4/FrBjPgi64qdyTM5CjJ8=;
        b=ItGYM00/IdR7RzwrgpVPptt1lZthHmdX6KFwphtYuGSfSpItnTRQXBbqro/BcfKtJmO+ft
        V6gAwtQF+T9OXdDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix race in task_call_func()
Cc:     ville.syrjala@linux.intel.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
References: <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166841701431.4906.7873933542030208235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     91dabf33ae5df271da63e87ad7833e5fdb4a44b9
Gitweb:        https://git.kernel.org/tip/91dabf33ae5df271da63e87ad7833e5fdb4=
a44b9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 26 Oct 2022 13:43:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Nov 2022 09:58:32 +01:00

sched: Fix race in task_call_func()

There is a very narrow race between schedule() and task_call_func().

  CPU0						CPU1

  __schedule()
    rq_lock();
    prev_state =3D READ_ONCE(prev->__state);
    if (... && prev_state) {
      deactivate_tasl(rq, prev, ...)
        prev->on_rq =3D 0;

						task_call_func()
						  raw_spin_lock_irqsave(p->pi_lock);
						  state =3D READ_ONCE(p->__state);
						  smp_rmb();
						  if (... || p->on_rq) // false!!!
						    rq =3D __task_rq_lock()

						  ret =3D func();

    next =3D pick_next_task();
    rq =3D context_switch(prev, next)
      prepare_lock_switch()
        spin_release(&__rq_lockp(rq)->dep_map...)

So while the task is on it's way out, it still holds rq->lock for a
little while, and right then task_call_func() comes in and figures it
doesn't need rq->lock anymore (because the task is already dequeued --
but still running there) and then the __set_task_frozen() thing observes
it's holding rq->lock and yells murder.

Avoid this by waiting for p->on_cpu to get cleared, which guarantees
the task is fully finished on the old CPU.

( While arguably the fixes tag is 'wrong' -- none of the previous
  task_call_func() users appears to care for this case. )

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Link: https://lkml.kernel.org/r/Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.=
net
---
 kernel/sched/core.c | 52 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b..daff72f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4200,6 +4200,40 @@ out:
 	return success;
 }
=20
+static bool __task_needs_rq_lock(struct task_struct *p)
+{
+	unsigned int state =3D READ_ONCE(p->__state);
+
+	/*
+	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
+	 * the task is blocked. Make sure to check @state since ttwu() can drop
+	 * locks at the end, see ttwu_queue_wakelist().
+	 */
+	if (state =3D=3D TASK_RUNNING || state =3D=3D TASK_WAKING)
+		return true;
+
+	/*
+	 * Ensure we load p->on_rq after p->__state, otherwise it would be
+	 * possible to, falsely, observe p->on_rq =3D=3D 0.
+	 *
+	 * See try_to_wake_up() for a longer comment.
+	 */
+	smp_rmb();
+	if (p->on_rq)
+		return true;
+
+#ifdef CONFIG_SMP
+	/*
+	 * Ensure the task has finished __schedule() and will not be referenced
+	 * anymore. Again, see try_to_wake_up() for a longer comment.
+	 */
+	smp_rmb();
+	smp_cond_load_acquire(&p->on_cpu, !VAL);
+#endif
+
+	return false;
+}
+
 /**
  * task_call_func - Invoke a function on task in fixed state
  * @p: Process for which the function is to be invoked, can be @current.
@@ -4217,28 +4251,12 @@ out:
 int task_call_func(struct task_struct *p, task_call_f func, void *arg)
 {
 	struct rq *rq =3D NULL;
-	unsigned int state;
 	struct rq_flags rf;
 	int ret;
=20
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
=20
-	state =3D READ_ONCE(p->__state);
-
-	/*
-	 * Ensure we load p->on_rq after p->__state, otherwise it would be
-	 * possible to, falsely, observe p->on_rq =3D=3D 0.
-	 *
-	 * See try_to_wake_up() for a longer comment.
-	 */
-	smp_rmb();
-
-	/*
-	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
-	 * the task is blocked. Make sure to check @state since ttwu() can drop
-	 * locks at the end, see ttwu_queue_wakelist().
-	 */
-	if (state =3D=3D TASK_RUNNING || state =3D=3D TASK_WAKING || p->on_rq)
+	if (__task_needs_rq_lock(p))
 		rq =3D __task_rq_lock(p, &rf);
=20
 	/*
