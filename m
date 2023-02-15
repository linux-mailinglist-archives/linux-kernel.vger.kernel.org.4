Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A170697AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjBOLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBOLmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:42:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7C3A9B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:42:50 -0800 (PST)
Date:   Wed, 15 Feb 2023 12:42:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676461367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0a52X5Hlk27SaORPu0OBnTwp1+88q2WMC/6E686eAA8=;
        b=etdTQe1M9jsvQmD196dJXg1pu5wEfHwdHGdD1dJa/Ruwh2lIL6wTf3Sl1HKqE7EGMPac7Q
        C8LOpAdBJgYhADYuudj4m39f7TjHXtChIjxJ86JEDF0BORXf4gJ/xQVXidoJtr0jZFIE3n
        BAyiXRbJ3c0lOc/DVT2shqRnSN+iBfc9kYmq4I2h6IkH6gPbVECT+VZKInnVQLzbaYLZ1p
        1EEZ/K30WrljvL9s1wZlMHZ+RCXJ0sPjREoj8ag3yXhVHADv3Xi92MFAOGxULgEhyCG5/+
        kJD9pS9Hb7T4wY2Q1TGHYW/eW97NzYPmdlr3eskUoCT15QSt2hblITsctHq6Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676461367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0a52X5Hlk27SaORPu0OBnTwp1+88q2WMC/6E686eAA8=;
        b=tgDiwMWlcqCVjL0NQ5Yq8F9g17LpmHD4j7ugA46QnOAp9hqyC/8s8sFMEOnxkwrNOaDWD6
        IYpFBWEdROgIg2AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v5] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <Y+zFNrCjBn53/+Q2@linutronix.de>
References: <20230210161323.37400-1-wander@redhat.com>
 <Y+Z8uqzJQOMahKWH@linutronix.de>
 <20230213121355.z3guvrrbg5onryqa@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230213121355.z3guvrrbg5onryqa@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 09:13:55 [-0300], Wander Lairson Costa wrote:
=E2=80=A6
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 9f7fe3541897..9bf30c725ed8 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -857,6 +857,37 @@ void __put_task_struct(struct task_struct *tsk)
> > >  	sched_core_free(tsk);
> > >  	free_task(tsk);
> > >  }
> > > +
> > > +static void __put_task_struct_rcu(struct rcu_head *rhp)
> > > +{
> > > +	struct task_struct *task =3D container_of(rhp, struct task_struct, =
rcu);
> > > +
> > > +	___put_task_struct(task);
> > > +}
> > > +
> > > +void __put_task_struct(struct task_struct *tsk)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
> >=20
> > No. If you do this on non-RT kernel with CONFIG_PROVE_RAW_LOCK_NESTING
> > then it will complain. And why do we have in_task() here?
> >=20
>=20
> Initially I thought you were saying it would cause a build failure, but
> I built the kernel successfully with CONFIG_PROVE_RAW_LOCK_NESTING.
> If it is a non-RT kernel, I understand the optimizer will vanish with
> the `if` clause. Would mind further explaining the conflict with
> CONFIG_PROVE_RAW_LOCK_NESTING?

Documentation/locking/locktypes.rst explains the individual lock types
we have in the kernel and how you should nest them. In short,

 mutex_t -> spinlock_t ->  raw_spinlock_t

You nest/ acquire them left to right, i.e. first the mutex_t, last
raw_spinlock_t. This works always. If you leave PREEMPT_RT out of the
picture then
	raw_spinlock_t -> spinlock_t
and
	spinlock_t -> raw_spinlock_t=20

make no difference because the underlying lock structure is the same,
the behaviour is the same. It only causes warning or a boom once
PREEMPT_RT is enabled.
CONFIG_PROVE_RAW_LOCK_NESTING performs exactly this kind of
verification so you can see on a !PREEMPT_RT kernel if there is a
locking chain (or nesting) that would not be okay on PREEMPT_RT.

In this case, at the time you do __put_task_struct() the sched-RQ lock
is held which is a raw_spinlock_t. Later in __put_task_struct() it will
free memory (or do something else) requiring a spinlock_t which would do
the nesting
	raw_spinlock_t -> spinlock_t

which is invalid and so lockdep should yell here.

> The `!in_task()` call is to test if we are in interrupt context.

I am aware of this but here in terms of PREEMPT_RT it doesn't matter.
It excluded the hardirq context which is the important one but this also
happens with preemptible(). It additionally excludes the "serving"
softirq context which is fine because it is preemtible on PREEMPT_RT.

> > If Oleg does not want the unconditional RCU then I would prefer an
> > explicit put task which delays it to RCU for the few users that need it.
> >=20
>=20
> Do you mean like the approach in v2[1]? I believe to spot all possible
> problematic scenarios, would should add

Yes, an explicit function because you know the context in which put_.*()
is invoked. It wasn't audited by the time it was added, it is not
"regular" case.

> ```
> if (IS_ENABLED(CONFIG_PREEMPT_RT))
>     might_sleep();
> ```
>=20
> to `put_task_struct()`.

This only works on PREEMPT_RT and should be enough to spot some of the
offender we have right now. It might also trigger if task::state is
changed (not TASK_RUNNING) and it should be fine. Therefore I would
suggest to use rtlock_might_resched() for testing which is in
   kernel/locking/spinlock_rt.c
but you get the idea.

Longterm, something like the diff at the bottom might compile and will
show raw_spinlock_t -> spinlock_t nesting with
CONFIG_PROVE_RAW_LOCK_NESTING. We won't catch explicit
preempt_disable(), local_irq_disable() users but _should_ be enough and
it would have warned us in this case because:
- the scheduler acquires a raw_spinlock_t
- the hrtimer has an check for this in lockdep_hrtimer_enter() to
  distinguish between timers which are "regular" and those which
  explicitly ask for the hardirq context.

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c1..eedbd50eb5df3 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -113,14 +113,18 @@ static inline struct task_struct *get_task_struct(str=
uct task_struct *t)
=20
 extern void __put_task_struct(struct task_struct *t);
=20
+extern spinlock_t task_put_lock;
+
 static inline void put_task_struct(struct task_struct *t)
 {
+	might_lock(&task_put_lock);
 	if (refcount_dec_and_test(&t->usage))
 		__put_task_struct(t);
 }
=20
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
+	might_lock(&task_put_lock);
 	if (refcount_sub_and_test(nr, &t->usage))
 		__put_task_struct(t);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe35418978..2f9c09bc22bdb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -840,6 +840,8 @@ static inline void put_signal_struct(struct signal_stru=
ct *sig)
 		free_signal_struct(sig);
 }
=20
+DEFINE_SPINLOCK(task_put_lock);
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
