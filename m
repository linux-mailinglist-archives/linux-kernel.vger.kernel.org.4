Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8AD664EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjAJW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjAJW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:27:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FBEE75
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:27:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E487DCE1896
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5449C433EF;
        Tue, 10 Jan 2023 22:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673389645;
        bh=lwktKLzBFf+UNz9qvGQwQVWp7f2PvDTtElXvlxqNAq4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U7ThD80Z/op1Xf58Km6T4bXYTJ+BhHnm7RAbOyEZkaIN8XuoSvMUFOffDhzYHv+Ht
         JE5QUD4LnxTkv+c3RcnPy4sAwRxCFZtjlGXH2qw2lcSUNdDjQ1RfHa0onKZDvUJQCK
         ymSi9bx5GEms5px/byS22SsiV9lCfjCS7HP8B7+mrZIp1G1brwzA08R2wsxnzEbrap
         ZzhrZfz0gPI0UFhXJnGx9Yi/i3UJ/viL3dkEmfc328DY6veCGAi3Q7YCAwnp1miJaf
         ugl75rJROB7vrMBExNS84K281jatTWE0JLYJOPhVykfm6Aaec5AYIa0unmkpax7BAS
         P4vpSeiWR/wCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 78C5A5C0A2D; Tue, 10 Jan 2023 14:27:25 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:27:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/deadline: fix inactive_task_timer splat with
 CONFIG_PREEMPT_RT
Message-ID: <20230110222725.GT4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230104181701.43224-1-wander@redhat.com>
 <20230110013333.GH4028633@paulmck-ThinkPad-P17-Gen-1>
 <CAAq0SUm+VkoM38ULJE6zuajA3Tc7KYbiH51uc9oKjGE+RhDmXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUm+VkoM38ULJE6zuajA3Tc7KYbiH51uc9oKjGE+RhDmXg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 05:52:03PM -0300, Wander Lairson Costa wrote:
> On Mon, Jan 9, 2023 at 10:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Jan 04, 2023 at 03:17:01PM -0300, Wander Lairson Costa wrote:
> > > inactive_task_timer() executes in interrupt (atomic) context. It calls
> > > put_task_struct(), which indirectly acquires sleeping locks under
> > > PREEMPT_RT.
> > >
> > > Below is an example of a splat that happened in a test environment:
> > >
> > >  CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
> > >  Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
> > >  Call Trace:
> > >  dump_stack_lvl+0x57/0x7d
> > >  mark_lock_irq.cold+0x33/0xba
> > >  ? stack_trace_save+0x4b/0x70
> > >  ? save_trace+0x55/0x150
> > >  mark_lock+0x1e7/0x400
> > >  mark_usage+0x11d/0x140
> > >  __lock_acquire+0x30d/0x930
> > >  lock_acquire.part.0+0x9c/0x210
> > >  ? refill_obj_stock+0x3d/0x3a0
> > >  ? rcu_read_lock_sched_held+0x3f/0x70
> > >  ? trace_lock_acquire+0x38/0x140
> > >  ? lock_acquire+0x30/0x80
> > >  ? refill_obj_stock+0x3d/0x3a0
> > >  rt_spin_lock+0x27/0xe0
> > >  ? refill_obj_stock+0x3d/0x3a0
> > >  refill_obj_stock+0x3d/0x3a0
> > >  ? inactive_task_timer+0x1ad/0x340
> > >  kmem_cache_free+0x357/0x560
> > >  inactive_task_timer+0x1ad/0x340
> > >  ? switched_from_dl+0x2d0/0x2d0
> > >  __run_hrtimer+0x8a/0x1a0
> > >  __hrtimer_run_queues+0x91/0x130
> > >  hrtimer_interrupt+0x10f/0x220
> > >  __sysvec_apic_timer_interrupt+0x7b/0xd0
> > >  sysvec_apic_timer_interrupt+0x4f/0xd0
> > >  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
> > >  asm_sysvec_apic_timer_interrupt+0x12/0x20
> > >  RIP: 0033:0x7fff196bf6f5
> > >
> > > Instead of calling put_task_struct() directly, we defer it using
> > > call_rcu(). A more natural approach would use a workqueue, but since
> > > in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> > > the code would become more complex because we would need to put the
> > > work_struct instance in the task_struct and initialize it when we
> > > allocate a new task_struct.
> > >
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > Cc: Paul McKenney <paulmck@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  kernel/sched/build_policy.c |  1 +
> > >  kernel/sched/deadline.c     | 24 +++++++++++++++++++++++-
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
> > > index d9dc9ab3773f..f159304ee792 100644
> > > --- a/kernel/sched/build_policy.c
> > > +++ b/kernel/sched/build_policy.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/suspend.h>
> > >  #include <linux/tsacct_kern.h>
> > >  #include <linux/vtime.h>
> > > +#include <linux/rcupdate.h>
> > >
> > >  #include <uapi/linux/sched/types.h>
> > >
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 9ae8f41e3372..ab9301d4cc24 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1405,6 +1405,13 @@ static void update_curr_dl(struct rq *rq)
> > >       }
> > >  }
> > >
> > > +static void delayed_put_task_struct(struct rcu_head *rhp)
> > > +{
> > > +     struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> > > +
> > > +     __put_task_struct(task);
> >
> > Please note that BH is disabled here.  Don't you therefore
> > need to schedule a workqueue handler?  Perhaps directly from
> > inactive_task_timer(), or maybe from this point.  If the latter, one
> > way to skip the extra step is to use queue_rcu_work().
> >
> 
> My initial work was using a workqueue [1,2]. However, I realized I
> could reach a much simpler code with call_rcu().
> I am afraid my ignorance doesn't allow me to get your point. Does
> disabling softirq imply atomic context?

Given that this problem occurred in PREEMPT_RT, I am assuming that the
appropriate definition of "atomic context" is "cannot call schedule()".
And you are in fact not permitted to call schedule() from a bh-disabled
region.

This also means that you cannot acquire a non-raw spinlock in a
bh-disabled region of code in a PREEMPT_RT kernel, because doing
so can invoke schedule.

Of course, using a workqueue does incur needless overhead in
non-PREEMPT_RT kernels.  So one alternative approach is to use
the workqueue only in PREEMPT_RT kernels and to just invoke
__put_task_struct() directly (without call_rcu() along the way)
otherwise.

Does that help, or am I missing your point?

						Thanx, Paul

> [1] https://gitlab.com/walac/kernel-ark/-/commit/ec8addbe38d5c318f1789b4c0fa480a9d2afdb65
> [2] https://gitlab.com/walac/kernel-ark/-/commit/0bde233235ffed233a7466a36a4866bc48064f54
> 
> 
> >                                                         Thanx, Paul
> >
> > > +}
> > > +
> > >  static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
> > >  {
> > >       struct sched_dl_entity *dl_se = container_of(timer,
> > > @@ -1442,7 +1449,22 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
> > >       dl_se->dl_non_contending = 0;
> > >  unlock:
> > >       task_rq_unlock(rq, p, &rf);
> > > -     put_task_struct(p);
> > > +
> > > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > +             /*
> > > +              * Decrement the refcount explicitly to avoid unnecessarily
> > > +              * calling call_rcu.
> > > +              */
> > > +             if (refcount_dec_and_test(&p->usage))
> > > +                     /*
> > > +                      * under PREEMPT_RT, we can't call put_task_struct
> > > +                      * in atomic context because it will indirectly
> > > +                      * acquire sleeping locks.
> > > +                      */
> > > +                     call_rcu(&p->rcu, delayed_put_task_struct);
> > > +     } else {
> > > +             put_task_struct(p);
> > > +     }
> > >
> > >       return HRTIMER_NORESTART;
> > >  }
> > > --
> > > 2.39.0
> > >
> >
> 
