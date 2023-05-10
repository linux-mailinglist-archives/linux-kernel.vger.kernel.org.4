Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0233C6FE113
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbjEJPEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbjEJPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:04:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10F1BD2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:04:19 -0700 (PDT)
Date:   Wed, 10 May 2023 17:04:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683731057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDQPXoW45Sh4GsDyF74mXExFfdrIc+V9a6S9sCy2iIY=;
        b=toUKL3XGDZQbl826q+EAyeBb4uFKAp+0Fn3MINSneMJEw1FKlIXlWDH5KYLXq006f//kox
        on8Dy8FlvZYNLvSpGuD0nrM91+LtbSxHBd2j3dSnFoae19zC9BE5O7JacOPUkR22Ak438c
        Qv0xPh9rE70sm7JNcnHx7c6q+KnRJpSfncY4gQAS++VZVdBUzOpvks9Ht6ypPJMZeMfEoc
        baQY4yISd1N3CRdE34oJnwiJdrdpKO9lPNoXkJq4vavSYXsQHbW4DiaOQW4S7lbM8aa1CX
        xzKJCGjRe3vz5sYtswTumOkir5ev4qmlMVuLt+n9ug8GMvQS3lC3P0Y0WlgGHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683731057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDQPXoW45Sh4GsDyF74mXExFfdrIc+V9a6S9sCy2iIY=;
        b=Ago1oJMV7EWRZuJfU4ck1U1Y3adXjsUEMKRBdmkTMb5ndhHshfKXHTaOZDIforsHY0x3Fn
        9AMpBkYDM7Ocw2DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/core: Provide sched_rtmutex() and expose
 sched work helpers
Message-ID: <20230510150415.6BXNs0I1@linutronix.de>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
 <20230427111937.2745231-2-bigeasy@linutronix.de>
 <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-03 15:20:51 [+0200], Peter Zijlstra wrote:
> Urgh, so I really don't like this.
>=20
> The end result is something like:
>=20
> 	rt_mutex_lock()
> 	  sched_submit_work();
> 	    // a nested rt_mutex_lock() here will not clobber
> 	    // ->pi_blocked_on because it's not set yet.
>=20
> 	  task_blocks_on_rt_mutex();
> 	    tsk->pi_blocked_on =3D waiter;
> 	    rt_mutex_enqueue(lock, waiter); <-- the real problem
>=20
> 	  rt_mutex_slowlock_block();
> 	    schedule_rtmutex();
>=20
> 	  sched_resume_work();
>=20
> And all of this it not just because tsk->pi_blocked_on, but mostly
> because of task_blocks_on_rt_mutex() enqueueing the waiter. The whole
> enqueue thing is what makes the 'simple' solution of saving/restoring
> tsk->pi_blocked_on not work.
>=20
> Basically the pi_blocked_on curruption is a side effect, not the
> fundamental issue. One task having two waiters registered is the bigger
> issue.

Yes, one task blocks on two locks but the lock in sched_submit_work()
needs to be solved first.

> Now, sched_submit_work() could also use (regular) mutex -- after all
> it's a fully preemptible context. And then we're subject to the 'same'
> problem but with tsk->blocked_on (DEBUG_MUTEXES=3Dy).

Not sure I follow. We only invoke sched_submit_work() if we block on a
lock which is sleeping on !RT (mutex_t, not spinlock_t). I browsed of
few of the sched_submit_work() callbacks and they all use non-sleeping
locks (on !RT).
If a sched_submit_work() would use a mutex_t lock then we would
recursively call blk_flush_plug() before setting tsk->blocked_on and
perform the same callback and block on the very same lock (again).
This isn't different compared to !RT therefore you must not use a
sleeping lock (mutex_t) in the callback.

> This means that strictly speaking we should litter mutex with the same
> thing :/

No need, see above logic.

> This all feels fragile to me. Too many things spread out in too many
> places. An alternative is something like:
>=20
> void __sched schedule_pi(void)
> {
> 	struct task_struct *tsk =3D current;
> 	void *waiter =3D tsk->pi_blocked_on;
>=20
> 	sched_submit_work(tsk);
> 	do {
> 		preempt_disable();
> 		if (rt_mutex_blocks(tsk, waiter))
> 			schedule();
> 		sched_preempt_enable_no_resched();
> 	} while (need_resched());
> 	sched_update_worker(tsk);
> }
>=20
> And then rt_mutex_blocks() will do the enqueue/boost/optimistic_spin
> thing. However, this is going to be a massive reorg of the rt_mutex code
> and I'm not entirely sure the end result will actually be better... it
> might just make a mess elsewhere :/

It might be not needed=E2=80=A6

> > @@ -6723,8 +6720,10 @@ static inline void sched_submit_work(struct task=
_struct *tsk)
> >  	blk_flush_plug(tsk->plug, true);
> >  }
>=20
> > +asmlinkage __visible void __sched schedule(void)
> > +{
> > +	if (!task_is_running(current))
> > +		sched_submit_work();
> > +	schedule_loop(SM_NONE);
> > +	sched_resume_work();
> >  }
> >  EXPORT_SYMBOL(schedule);
>=20
> pulling out task_is_running() like this is going to get into conflict
> with TJs patches here:
>=20
>   https://lkml.kernel.org/r/20230418205159.724789-1-tj@kernel.org
>=20
> That makes sched_submit_work() do things even if task_is_running().

Do I rebase my stuff on top of his then and we good?

Sebastian
