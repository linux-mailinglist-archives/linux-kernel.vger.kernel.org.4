Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57426A2040
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBXRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBXRFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECD15FD2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677258302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLDxhjziQI/CtWmB/JJs1/6DqRSDpx9RukavHZ32S1U=;
        b=cZ9JRJyftRj/abkHPXLsSmwVai9rC3gN2Jx9Q1qo7T5WRiP81Cd5/VDxnVvDtrXr9NlNvc
        y/B5rw+p1Px06gxtbAogFHevgdBHeoNxdOpYnzRAIMKBasuM5tSZkiS7vcFCNNGV8EJ/4H
        3QYz2MP2Ft6onnqSCpH2rBWfAOEUXTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-wzk6xzLaM2aJzgzcYWFVcg-1; Fri, 24 Feb 2023 12:04:56 -0500
X-MC-Unique: wzk6xzLaM2aJzgzcYWFVcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD4E9886065;
        Fri, 24 Feb 2023 17:04:55 +0000 (UTC)
Received: from fedora (unknown [10.22.16.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E27AC15BA0;
        Fri, 24 Feb 2023 17:04:52 +0000 (UTC)
Date:   Fri, 24 Feb 2023 14:04:50 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20230224170450.oerntwam6pik2ag5@fedora>
References: <20230210161323.37400-1-wander@redhat.com>
 <Y+Z8uqzJQOMahKWH@linutronix.de>
 <20230213121355.z3guvrrbg5onryqa@fedora>
 <Y+zFNrCjBn53/+Q2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+zFNrCjBn53/+Q2@linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:42:46PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-02-13 09:13:55 [-0300], Wander Lairson Costa wrote:
> …
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index 9f7fe3541897..9bf30c725ed8 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -857,6 +857,37 @@ void __put_task_struct(struct task_struct *tsk)
> > > >  	sched_core_free(tsk);
> > > >  	free_task(tsk);
> > > >  }
> > > > +
> > > > +static void __put_task_struct_rcu(struct rcu_head *rhp)
> > > > +{
> > > > +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> > > > +
> > > > +	___put_task_struct(task);
> > > > +}
> > > > +
> > > > +void __put_task_struct(struct task_struct *tsk)
> > > > +{
> > > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
> > > 
> > > No. If you do this on non-RT kernel with CONFIG_PROVE_RAW_LOCK_NESTING
> > > then it will complain. And why do we have in_task() here?
> > > 
> > 
> > Initially I thought you were saying it would cause a build failure, but
> > I built the kernel successfully with CONFIG_PROVE_RAW_LOCK_NESTING.
> > If it is a non-RT kernel, I understand the optimizer will vanish with
> > the `if` clause. Would mind further explaining the conflict with
> > CONFIG_PROVE_RAW_LOCK_NESTING?
> 
> Documentation/locking/locktypes.rst explains the individual lock types
> we have in the kernel and how you should nest them. In short,
> 
>  mutex_t -> spinlock_t ->  raw_spinlock_t
> 
> You nest/ acquire them left to right, i.e. first the mutex_t, last
> raw_spinlock_t. This works always. If you leave PREEMPT_RT out of the
> picture then
> 	raw_spinlock_t -> spinlock_t
> and
> 	spinlock_t -> raw_spinlock_t 
> 
> make no difference because the underlying lock structure is the same,
> the behaviour is the same. It only causes warning or a boom once
> PREEMPT_RT is enabled.
> CONFIG_PROVE_RAW_LOCK_NESTING performs exactly this kind of
> verification so you can see on a !PREEMPT_RT kernel if there is a
> locking chain (or nesting) that would not be okay on PREEMPT_RT.
> 
> In this case, at the time you do __put_task_struct() the sched-RQ lock
> is held which is a raw_spinlock_t. Later in __put_task_struct() it will
> free memory (or do something else) requiring a spinlock_t which would do
> the nesting
> 	raw_spinlock_t -> spinlock_t
> 
> which is invalid and so lockdep should yell here.

Thanks for the detailed explanation!

> 
> > The `!in_task()` call is to test if we are in interrupt context.
> 
> I am aware of this but here in terms of PREEMPT_RT it doesn't matter.
> It excluded the hardirq context which is the important one but this also
> happens with preemptible(). It additionally excludes the "serving"
> softirq context which is fine because it is preemtible on PREEMPT_RT.
> 

Indeed, you are write, the !in_task() is uneeded.

> > > If Oleg does not want the unconditional RCU then I would prefer an
> > > explicit put task which delays it to RCU for the few users that need it.
> > > 
> > 
> > Do you mean like the approach in v2[1]? I believe to spot all possible
> > problematic scenarios, would should add
> 
> Yes, an explicit function because you know the context in which put_.*()
> is invoked. It wasn't audited by the time it was added, it is not
> "regular" case.
> 
> > ```
> > if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >     might_sleep();
> > ```
> > 
> > to `put_task_struct()`.
> 
> This only works on PREEMPT_RT and should be enough to spot some of the
> offender we have right now. It might also trigger if task::state is
> changed (not TASK_RUNNING) and it should be fine. Therefore I would
> suggest to use rtlock_might_resched() for testing which is in
>    kernel/locking/spinlock_rt.c
> but you get the idea.
> 
> Longterm, something like the diff at the bottom might compile and will
> show raw_spinlock_t -> spinlock_t nesting with
> CONFIG_PROVE_RAW_LOCK_NESTING. We won't catch explicit
> preempt_disable(), local_irq_disable() users but _should_ be enough and
> it would have warned us in this case because:
> - the scheduler acquires a raw_spinlock_t
> - the hrtimer has an check for this in lockdep_hrtimer_enter() to
>   distinguish between timers which are "regular" and those which
>   explicitly ask for the hardirq context.
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 357e0068497c1..eedbd50eb5df3 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -113,14 +113,18 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
>  
>  extern void __put_task_struct(struct task_struct *t);
>  
> +extern spinlock_t task_put_lock;
> +
>  static inline void put_task_struct(struct task_struct *t)
>  {
> +	might_lock(&task_put_lock);
>  	if (refcount_dec_and_test(&t->usage))
>  		__put_task_struct(t);
>  }
>  
>  static inline void put_task_struct_many(struct task_struct *t, int nr)
>  {
> +	might_lock(&task_put_lock);
>  	if (refcount_sub_and_test(nr, &t->usage))
>  		__put_task_struct(t);
>  }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe35418978..2f9c09bc22bdb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -840,6 +840,8 @@ static inline void put_signal_struct(struct signal_struct *sig)
>  		free_signal_struct(sig);
>  }
>  
> +DEFINE_SPINLOCK(task_put_lock);
> +
>  void __put_task_struct(struct task_struct *tsk)
>  {
>  	WARN_ON(!tsk->exit_state);
> 

I tried this, but it doesn't give the splat in !PREEMPT_RT. But IIUC,
CONFIG_PROVE_RAW_LOCK_NESTING will only work if we hold a raw_spinlock_t
and try to acquire a spin lock. Does it check irq context as well?

