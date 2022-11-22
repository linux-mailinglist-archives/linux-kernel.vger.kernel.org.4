Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABB76343D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiKVSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKVSpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:45:13 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E528E7ECA3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:45:10 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 8so10931039qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+KpXUPOyLk/u42oJHSTcN89+/nJxrP8bWURlcY53/v8=;
        b=gVve/fTREr9obNMNcQU1+EMZEVothVhNOme0deHpw8FBs43xER595MAeJqtpCmmUoK
         hBWqJdQWKIfpYN1ZxiDgAgLsd4e9aVlUajpaTec5+aOvUbUBswp0NN49Za7P8EersZrg
         9MvltgXYksUcdhFpOsltbCGV4cKn8dQYt2VDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KpXUPOyLk/u42oJHSTcN89+/nJxrP8bWURlcY53/v8=;
        b=owhwIJTl/yT5R4FvypvE944Krvbv3ON41t5D6A/pmy8nm89p8mYbteznLnelPSzxgC
         LZfvWuGJFHLCFHMWaOV9ltXzsWOu5URKuLeDZ8Fn3nzOk+SU+E/NoLfR4rtlrtRtfeom
         gP6vm6pijhbzOJjplLkb7tTPV8U+u3+hbELUMvKlTdGaAypxrACni/XPCph7hodUe8UL
         JeF/R+q4OOGtDhsQnIy8dcTDeKyepN/z3L3bdOiEPjro1DY3pOJA9j+DXKzUoFKJjP8/
         v+Nlii3uMqRn01oO+718TVGdKlqxLkGk2Z4X8XMblRw/HyJSTo9oSbHeBwav1qK9gATO
         AL2A==
X-Gm-Message-State: ANoB5pkV1PgD7hXIO+HADGiZDn1FqPlGibP0H6i0pU4Ec7m0LBPWX8cA
        MOuJpJyr2vzXYKygUnvQC5VXjw==
X-Google-Smtp-Source: AA0mqf7AfQCfHyyjsX/wJp244VN+ZEFptmiBDzzrTbivuHP3sSFq5r56n/0E8KeooIxhggI+7KXdTw==
X-Received: by 2002:a05:620a:12b3:b0:6f9:c3d9:311b with SMTP id x19-20020a05620a12b300b006f9c3d9311bmr7835526qki.498.1669142709863;
        Tue, 22 Nov 2022 10:45:09 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c23-20020ac85197000000b003a623e5b9ecsm8066504qtn.78.2022.11.22.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 10:45:09 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:45:08 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y30YtPo/RSzTi4q5@google.com>
References: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com>
 <34B2D8B9-A0C1-4280-944D-17224FB24339@joelfernandes.org>
 <4e396924-c3be-1932-91a3-5f458cc843fe@arm.com>
 <Y2ANPi7y5HhHvelr@google.com>
 <4ec6ab79-9f0f-e14b-dd06-d2840a1bf71a@arm.com>
 <Y3rEq7IFKjYA+/bj@google.com>
 <CAEXW_YRwwiq=ZquiMqSvaTEDw=07H-GSaZKV2rrO9wv_TRyBHQ@mail.gmail.com>
 <Y3r3vvzfONR2sY9V@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3r3vvzfONR2sY9V@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:59:58AM +0000, Joel Fernandes wrote:
> On Sun, Nov 20, 2022 at 08:49:22PM -0500, Joel Fernandes wrote:
> > On Sun, Nov 20, 2022 at 7:22 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > Hello Dietmar,
> > >
> > > On Fri, Nov 04, 2022 at 06:09:26PM +0100, Dietmar Eggemann wrote:
> > > > On 31/10/2022 19:00, Joel Fernandes wrote:
> > > > > On Mon, Oct 31, 2022 at 05:39:45PM +0100, Dietmar Eggemann wrote:
> > > > >> On 29/10/2022 05:31, Joel Fernandes wrote:
> > > > >>> Hello Dietmar,
> > > > >>>
> > > > >>>> On Oct 24, 2022, at 6:13 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > > > >>>>
> > > > >>>> ﻿On 03/10/2022 23:44, Connor O'Brien wrote:
> > > > >>>>> From: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > [...]
> > > >
> > > > >>>>> +    rq_unpin_lock(rq, rf);
> > > > >>>>> +    raw_spin_rq_unlock(rq);
> > > > >>>>
> > > > >>>> Don't we run into rq_pin_lock()'s:
> > > > >>>>
> > > > >>>> SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
> > > > >>>> &balance_push_callback)
> > > > >>>>
> > > > >>>> by releasing rq lock between queue_balance_callback(, push_rt/dl_tasks)
> > > > >>>> and __balance_callbacks()?
> > > > >>>
> > > > >>> Apologies, I’m a bit lost here. The code you are responding to
> > > > >>> inline does not call rq_pin_lock, it calls rq_unpin_lock.  So
> > > > >>> what scenario does the warning trigger according to you?
> > > > >>
> > > > >> True, but the code which sneaks in between proxy()'s
> > > > >> raw_spin_rq_unlock(rq) and raw_spin_rq_lock(rq) does.
> > > > >>
> > > > >
> > > > > Got it now, thanks a lot for clarifying. Can this be fixed by do a
> > > > > __balance_callbacks() at:
> > > >
> > > > I tried the:
> > > >
> > > >    head = splice_balance_callbacks(rq)
> > > >    task_rq_unlock(rq, p, &rf);
> > > >    ...
> > > >    balance_callbacks(rq, head);
> > > >
> > > > separation known from __sched_setscheduler() in __schedule() (right
> > > > after pick_next_task()) but it doesn't work. Lot of `BUG: scheduling
> > > > while atomic:`
> > >
> > > How about something like the following? This should exclude concurrent
> > > balance callback queues from other CPUs and let us release the rq lock early
> > > in proxy(). I ran locktorture with your diff to make writer threads RT, and I
> > > cannot reproduce any crash with it:
> > >
> > > ---8<-----------------------
> > >
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > Subject: [PATCH] Exclude balance callback queuing during proxy's migrate
> > >
> > > In commit 565790d28b1e ("sched: Fix balance_callback()"), it is clear that rq
> > > lock needs to be held when __balance_callbacks() in schedule() is called.
> > > However, it is possible that because rq lock is dropped in proxy(), another
> > > CPU, say in __sched_setscheduler() can queue balancing callbacks and cause
> > > issues.
> > >
> > > To remedy this, exclude balance callback queuing on other CPUs, during the
> > > proxy().
> > >
> > > Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/sched/core.c  | 15 +++++++++++++++
> > >  kernel/sched/sched.h |  3 +++
> > >  2 files changed, 18 insertions(+)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 88a5fa34dc06..f1dac21fcd90 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -6739,6 +6739,10 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> > >                 p->wake_cpu = wake_cpu;
> > >         }
> > >
> > > +       // Prevent other CPUs from queuing balance callbacks while we migrate
> > > +       // tasks in the migrate_list with the rq lock released.
> > > +       raw_spin_lock(&rq->balance_lock);
> > > +
> > >         rq_unpin_lock(rq, rf);
> > >         raw_spin_rq_unlock(rq);
> > >         raw_spin_rq_lock(that_rq);
> > > @@ -6758,7 +6762,18 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> > >         }
> > >
> > >         raw_spin_rq_unlock(that_rq);
> > > +
> > > +       // This may make lockdep unhappy as we acquire rq->lock with balance_lock
> > > +       // held. But that should be a false positive, as the following pattern
> > > +       // happens only on the current CPU with interrupts disabled:
> > > +       // rq_lock()
> > > +       // balance_lock();
> > > +       // rq_unlock();
> > > +       // rq_lock();
> > >         raw_spin_rq_lock(rq);
> > 
> > Hmm, I think there's still a chance of deadlock here. I need to
> > rethink it a bit, but that's the idea I was going for.
> 
> Took care of that, and came up with the below. Tested with locktorture and it
> survives. Thoughts?

Found a new bug in my patch during locktorture + hotplug. I was missing an
unlock() during early return of queue_balance_callback(). Please try the
following version of the patch for testing.  To trigger the bug in the v2, I
gave the following options to locktorture:

locktorture.stutter=5 locktorture.torture_type=mutex_lock
locktorture.onoff_interval=1 locktorture.onoff_holdoff=10
locktorture.nwriters_stress=10

Now it is fixed.
---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3] Exclude balance callback queuing during proxy's migrate

In commit 565790d28b1e ("sched: Fix balance_callback()"), it is clear that rq
lock needs to be held when __balance_callbacks() in schedule() is called.
However, it is possible that because rq lock is dropped in proxy(), another
CPU, say in __sched_setscheduler() can queue balancing callbacks and cause
issues.

To remedy this, exclude balance callback queuing on other CPUs, during the
proxy().

Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 72 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  7 ++++-
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88a5fa34dc06..aba90b3dc3ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -633,6 +633,29 @@ struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	}
 }
 
+/*
+ * Helper to call __task_rq_lock safely, in scenarios where we might be about to
+ * queue a balance callback on a remote CPU. That CPU might be in proxy(), and
+ * could have released its rq lock while holding balance_lock. So release rq
+ * lock in such a situation to avoid deadlock, and retry.
+ */
+struct rq *__task_rq_lock_balance(struct task_struct *p, struct rq_flags *rf)
+{
+	struct rq *rq;
+	bool locked = false;
+
+	do {
+		if (locked) {
+			__task_rq_unlock(rq, rf);
+			cpu_relax();
+		}
+		rq = __task_rq_lock(p, rf);
+		locked = true;
+	} while (raw_spin_is_locked(&rq->balance_lock));
+
+	return rq;
+}
+
 /*
  * task_rq_lock - lock p->pi_lock and lock the rq @p resides on.
  */
@@ -675,6 +698,29 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	}
 }
 
+/*
+ * Helper to call task_rq_lock safely, in scenarios where we might be about to
+ * queue a balance callback on a remote CPU. That CPU might be in proxy(), and
+ * could have released its rq lock while holding balance_lock. So release rq
+ * lock in such a situation to avoid deadlock, and retry.
+ */
+struct rq *task_rq_lock_balance(struct task_struct *p, struct rq_flags *rf)
+{
+	struct rq *rq;
+	bool locked = false;
+
+	do {
+		if (locked) {
+			task_rq_unlock(rq, p, rf);
+			cpu_relax();
+		}
+		rq = task_rq_lock(p, rf);
+		locked = true;
+	} while (raw_spin_is_locked(&rq->balance_lock));
+
+	return rq;
+}
+
 /*
  * RQ-clock updating methods:
  */
@@ -6739,6 +6785,12 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		p->wake_cpu = wake_cpu;
 	}
 
+	/*
+	 * Prevent other CPUs from queuing balance callbacks while we migrate
+	 * tasks in the migrate_list with the rq lock released.
+	 */
+	raw_spin_lock(&rq->balance_lock);
+
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
 	raw_spin_rq_lock(that_rq);
@@ -6758,7 +6810,21 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	}
 
 	raw_spin_rq_unlock(that_rq);
+
+	/*
+	 * This may make lockdep unhappy as we acquire rq->lock with
+	 * balance_lock held. But that should be a false positive, as the
+	 * following pattern happens only on the current CPU with interrupts
+	 * disabled:
+	 * rq_lock()
+	 * balance_lock();
+	 * rq_unlock();
+	 * rq_lock();
+	 */
 	raw_spin_rq_lock(rq);
+
+	raw_spin_unlock(&rq->balance_lock);
+
 	rq_repin_lock(rq, rf);
 
 	return NULL; /* Retry task selection on _this_ CPU. */
@@ -7489,7 +7555,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (p->pi_top_task == pi_task && prio == p->prio && !dl_prio(prio))
 		return;
 
-	rq = __task_rq_lock(p, &rf);
+	rq = __task_rq_lock_balance(p, &rf);
 	update_rq_clock(rq);
 	/*
 	 * Set under pi_lock && rq->lock, such that the value can be used under
@@ -8093,7 +8159,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * To be able to change p->policy safely, the appropriate
 	 * runqueue lock must be held.
 	 */
-	rq = task_rq_lock(p, &rf);
+	rq = task_rq_lock_balance(p, &rf);
+
 	update_rq_clock(rq);
 
 	/*
@@ -10312,6 +10379,7 @@ void __init sched_init(void)
 
 		rq = cpu_rq(i);
 		raw_spin_lock_init(&rq->__lock);
+		raw_spin_lock_init(&rq->balance_lock);
 		rq->nr_running = 0;
 		rq->calc_load_active = 0;
 		rq->calc_load_update = jiffies + LOAD_FREQ;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 354e75587fed..17947a4009de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1057,6 +1057,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	raw_spinlock_t		balance_lock;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1748,18 +1749,22 @@ queue_balance_callback(struct rq *rq,
 		       void (*func)(struct rq *rq))
 {
 	lockdep_assert_rq_held(rq);
+	raw_spin_lock(&rq->balance_lock);
 
 	/*
 	 * Don't (re)queue an already queued item; nor queue anything when
 	 * balance_push() is active, see the comment with
 	 * balance_push_callback.
 	 */
-	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
+	if (unlikely(head->next || rq->balance_callback == &balance_push_callback)) {
+		raw_spin_unlock(&rq->balance_lock);
 		return;
+	}
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	raw_spin_unlock(&rq->balance_lock);
 }
 
 #define rcu_dereference_check_sched_domain(p) \
-- 
2.38.1.584.g0f3c55d4c2-goog

