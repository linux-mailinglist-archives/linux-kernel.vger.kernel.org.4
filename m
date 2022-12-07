Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A225B6463FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLGWXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGWXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:23:20 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E66723EA1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:23:19 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b13so19965243lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qfj3kJwcAgTqrtGR611iDDgd4oHJikEYmmh81zIoVo=;
        b=J7rY5pGreTLBBGQacY9oS9rCkaS2oOkxhYG6/Xsnv3bqsAvRMOuF+fM5oSRkpyNsY3
         znY3JihN9XpD5dN5NvaSdmgNVB4w/vzmseUM6QOyOjT2wGHFdk1ZkZ6lCcPoiu94JRo6
         1JJafD34xk00TxYpfaejw2gSUD+Z8vdeu2VzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qfj3kJwcAgTqrtGR611iDDgd4oHJikEYmmh81zIoVo=;
        b=NnMdrQ8SF5bbU0FmzMCdkzbZpI3Yidb2wVCw3aJwIhOHX6SFiWPSOJKrV+wn7duicy
         ZfVvqAxK+JCvEtIO3+2orNVM+rYSPNo0ZF00rTxk3mGsJPXnQ7ySDfag6GlS6AggiYSc
         H3k/QSsd3yzORoVKYcEbCRFhaDCiVZrhFw8TaNXBBB/ajT2L/7M6gxyuFNg3OvW3pQU4
         IykOyXasiLJ6dmCA25jmt6+ThirHJipRsdQEbgxNs99CQKTaOKTQZR7Tmm9ljw92Ej4h
         sASNb3wDPXHvrKuAz0ED9jPCspHl7gWd4aKExg+WfrTq+BLNPE8muZZLUJ/ZAx42e03K
         zGDA==
X-Gm-Message-State: ANoB5pnCQgjcRK2tT9CfFVsF9tW9GM/DLKNHcU3CuiOmq+VMku3X1W3y
        YMPXJHytLzYcZqD86CyLbs/TeDZJbrG4XkJVXf0D1w==
X-Google-Smtp-Source: AA0mqf7xZgADmJ2Ap7/Iy/mR0m5ZJ4+mcp4EcxUvtoCAj7OrpPTs5hds6rdxKzvh/YVdod1COiPO+2gk9eSL41bKBd0=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr29447539lfl.468.1670451797274; Wed, 07
 Dec 2022 14:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-3-joel@joelfernandes.org> <20221207221423.GH4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221207221423.GH4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 7 Dec 2022 22:23:05 +0000
Message-ID: <CAEXW_YQrdBsC0xKNSu-Y9wN5W4YOrQEHrKVCfxEJRtJVArk6vA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] locktorture: Allow non-rtmutex lock types to be boosted
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Dec 7, 2022 at 10:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Nov 23, 2022 at 01:21:03AM +0000, Joel Fernandes (Google) wrote:
> > Currently RT boosting is only done for rtmutex_lock, however with proxy
> > execution, we also have the mutex_lock participating in priorities. To
> > exercise the testing better, add RT boosting to other lock testing types
> > as well, using a new knob (rt_boost).
> >
> > Tested with boot parameters:
> > locktorture.torture_type=mutex_lock
> > locktorture.onoff_interval=1
> > locktorture.nwriters_stress=8
> > locktorture.stutter=0
> > locktorture.rt_boost=1
> > locktorture.rt_boost_factor=1
> > locktorture.nlocks=3
> >
> > For the rtmutex test, rt_boost is always enabled even if disabling is
> > requested.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/locking/locktorture.c | 91 +++++++++++++++++++-----------------
> >  1 file changed, 48 insertions(+), 43 deletions(-)
> >
> > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > index bc3557677eed..5a388ac96a9b 100644
> > --- a/kernel/locking/locktorture.c
> > +++ b/kernel/locking/locktorture.c
> > @@ -46,6 +46,7 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
> >  torture_param(int, stat_interval, 60,
> >            "Number of seconds between stats printk()s");
> >  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> > +torture_param(int, rt_boost, 0, "Perform an rt-boost from the writer, always 1 for rtmutex_lock");
> >  torture_param(int, verbose, 1,
> >            "Enable verbose debugging printk()s");
> >  torture_param(int, nlocks, 1,
> > @@ -129,15 +130,44 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
> >         /* BUGGY, do not use in real life!!! */
> >  }
> >
> > -static void torture_boost_dummy(struct torture_random_state *trsp)
>
> We no longer have torture_boot_dummy().  Is the point that the
> "spinlocks" to priority boosting in PREEMPT_RT kernels?  If so,
> would it make sense to do something like this for spinlock?
>
>         .task_boost     = IS_ENABLED(CONFIG_PREEMPT_RT) ? torture_rt_boost : torture_boost_dummy,
>
> Or maybe using a similar approach for the default value of the rt_boost
> module parameter?
>
> Or is there some benefit of priority boosting for spinlocks even in
> non-PREEMPT_RT kernels that I am missing?

There are 2 advantages as far as I can see:

1. The shuffle thread which ends up in setscheduler exercises the same
path as the rt mutex boost, so that would test races with that and the
boost path.

2. In the future, proxy execution deals with migrations, and changes
of the tasks' class there can race with boosting / and schedule().

If there is no harm, I would like us to keep torture_rt_boost even in
!PREEMPT_RT, just so we can shake bugs out more. Thoughts?

> > +static void torture_rt_boost(struct torture_random_state *trsp)
> >  {
> > -     /* Only rtmutexes care about priority */
> > +     const unsigned int factor = 50000; /* yes, quite arbitrary */
>
> OK, this one looks like code movement combined with 50000 being named
> "factor".  Whoever originally wrote these comments needs to have done
> a better job.  ;-)

True, I will adjust the comments in v2 :)

> > +
> > +     if (!rt_boost)
> > +             return;
> > +
> > +     if (!rt_task(current)) {
> > +             /*
> > +              * Boost priority once every ~50k operations. When the
> > +              * task tries to take the lock, the rtmutex it will account
> > +              * for the new priority, and do any corresponding pi-dance.
> > +              */
> > +             if (trsp && !(torture_random(trsp) %
> > +                           (cxt.nrealwriters_stress * factor))) {
> > +                     sched_set_fifo(current);
> > +             } else /* common case, do nothing */
> > +                     return;
> > +     } else {
> > +             /*
> > +              * The task will remain boosted for another ~500k operations,
> > +              * then restored back to its original prio, and so forth.
> > +              *
> > +              * When @trsp is nil, we want to force-reset the task for
> > +              * stopping the kthread.
> > +              */
> > +             if (!trsp || !(torture_random(trsp) %
> > +                            (cxt.nrealwriters_stress * factor * 2))) {
> > +                     sched_set_normal(current, 0);
> > +             } else /* common case, do nothing */
> > +                     return;
> > +     }
> >  }
> >
> >  static struct lock_torture_ops lock_busted_ops = {
> >       .writelock      = torture_lock_busted_write_lock,
> >       .write_delay    = torture_lock_busted_write_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_lock_busted_write_unlock,
> >       .readlock       = NULL,
> >       .read_delay     = NULL,
> > @@ -181,7 +211,7 @@ __releases(torture_spinlock)
> >  static struct lock_torture_ops spin_lock_ops = {
> >       .writelock      = torture_spin_lock_write_lock,
> >       .write_delay    = torture_spin_lock_write_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_spin_lock_write_unlock,
> >       .readlock       = NULL,
> >       .read_delay     = NULL,
> > @@ -208,7 +238,7 @@ __releases(torture_spinlock)
> >  static struct lock_torture_ops spin_lock_irq_ops = {
> >       .writelock      = torture_spin_lock_write_lock_irq,
> >       .write_delay    = torture_spin_lock_write_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_lock_spin_write_unlock_irq,
> >       .readlock       = NULL,
> >       .read_delay     = NULL,
> > @@ -277,7 +307,7 @@ __releases(torture_rwlock)
> >  static struct lock_torture_ops rw_lock_ops = {
> >       .writelock      = torture_rwlock_write_lock,
> >       .write_delay    = torture_rwlock_write_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_rwlock_write_unlock,
> >       .readlock       = torture_rwlock_read_lock,
> >       .read_delay     = torture_rwlock_read_delay,
> > @@ -320,7 +350,7 @@ __releases(torture_rwlock)
> >  static struct lock_torture_ops rw_lock_irq_ops = {
> >       .writelock      = torture_rwlock_write_lock_irq,
> >       .write_delay    = torture_rwlock_write_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_rwlock_write_unlock_irq,
> >       .readlock       = torture_rwlock_read_lock_irq,
> >       .read_delay     = torture_rwlock_read_delay,
> > @@ -362,7 +392,7 @@ __releases(torture_mutex)
> >  static struct lock_torture_ops mutex_lock_ops = {
> >       .writelock      = torture_mutex_lock,
> >       .write_delay    = torture_mutex_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_mutex_unlock,
> >       .readlock       = NULL,
> >       .read_delay     = NULL,
> > @@ -460,7 +490,7 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
> >       .exit           = torture_ww_mutex_exit,
> >       .writelock      = torture_ww_mutex_lock,
> >       .write_delay    = torture_mutex_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_ww_mutex_unlock,
> >       .readlock       = NULL,
> >       .read_delay     = NULL,
> > @@ -471,6 +501,11 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
> >  #ifdef CONFIG_RT_MUTEXES
> >  static DEFINE_RT_MUTEX(torture_rtmutex);
> >
> > +static void torture_rtmutex_init(void)
> > +{
> > +     rt_boost = 1;
> > +}
> > +
> >  static int torture_rtmutex_lock(int tid __maybe_unused)
> >  __acquires(torture_rtmutex)
> >  {
> > @@ -478,37 +513,6 @@ __acquires(torture_rtmutex)
> >       return 0;
> >  }
> >
> > -static void torture_rtmutex_boost(struct torture_random_state *trsp)
> > -{
> > -     const unsigned int factor = 50000; /* yes, quite arbitrary */
> > -
> > -     if (!rt_task(current)) {
> > -             /*
> > -              * Boost priority once every ~50k operations. When the
> > -              * task tries to take the lock, the rtmutex it will account
> > -              * for the new priority, and do any corresponding pi-dance.
> > -              */
> > -             if (trsp && !(torture_random(trsp) %
> > -                           (cxt.nrealwriters_stress * factor))) {
> > -                     sched_set_fifo(current);
> > -             } else /* common case, do nothing */
> > -                     return;
> > -     } else {
> > -             /*
> > -              * The task will remain boosted for another ~500k operations,
> > -              * then restored back to its original prio, and so forth.
> > -              *
> > -              * When @trsp is nil, we want to force-reset the task for
> > -              * stopping the kthread.
> > -              */
> > -             if (!trsp || !(torture_random(trsp) %
> > -                            (cxt.nrealwriters_stress * factor * 2))) {
> > -                     sched_set_normal(current, 0);
> > -             } else /* common case, do nothing */
> > -                     return;
> > -     }
> > -}
> > -
> >  static void torture_rtmutex_delay(struct torture_random_state *trsp)
> >  {
> >       const unsigned long shortdelay_us = 2;
> > @@ -535,9 +539,10 @@ __releases(torture_rtmutex)
> >  }
> >
> >  static struct lock_torture_ops rtmutex_lock_ops = {
> > +     .init           = torture_rtmutex_init,
>
> OK, so rt_boost defaults on for rtmutex.  In fact, it cannot be disabled,
> which might make things more difficult for debugging.

Ah ok, true. I was hoping the number of users who want it off for
rtmutex would be ~0 :-D

> Another approach would to do something similar to the test_boost module
> parameter for RCU.  This defaults to "1", which means "Boost if it
> makes sense in this situation".  It can be set to "0", which means
> "Never boost", and also to "2", which means "Boost even if it makes no
> sense to do so.  This last helps verify rcutorture's ability to detect
> boost failures.  There is a can_boost field in the rcu_torture_ops
> structure that defines when it makes sense to boost, and this field
> is initialized based on CONFIG_RCU_BOOST.
>
> In this case, it makes sense to boost rt_mutex always, and it makes
> sense to boost exclusive spinlocks in PREEMPT_RT kernels.  It might make
> sense to boost reader-writer spinlock situations involving only writers,
> but that would likely require additional changes.
>
> Or is there some reason why this approach would not work well?

I am thinking let us default to always boosting, for the reasons
mentioned above, and also because it will exercise more scheduler
paths and shake out bugs.

Thoughts?

thanks,

  - Joel

>
>                                                         Thanx, Paul
>
> >       .writelock      = torture_rtmutex_lock,
> >       .write_delay    = torture_rtmutex_delay,
> > -     .task_boost     = torture_rtmutex_boost,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_rtmutex_unlock,
> >       .readlock       = NULL,
> >       .read_delay     = NULL,
> > @@ -604,7 +609,7 @@ __releases(torture_rwsem)
> >  static struct lock_torture_ops rwsem_lock_ops = {
> >       .writelock      = torture_rwsem_down_write,
> >       .write_delay    = torture_rwsem_write_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_rwsem_up_write,
> >       .readlock       = torture_rwsem_down_read,
> >       .read_delay     = torture_rwsem_read_delay,
> > @@ -656,7 +661,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
> >       .exit           = torture_percpu_rwsem_exit,
> >       .writelock      = torture_percpu_rwsem_down_write,
> >       .write_delay    = torture_rwsem_write_delay,
> > -     .task_boost     = torture_boost_dummy,
> > +     .task_boost     = torture_rt_boost,
> >       .writeunlock    = torture_percpu_rwsem_up_write,
> >       .readlock       = torture_percpu_rwsem_down_read,
> >       .read_delay     = torture_rwsem_read_delay,
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
