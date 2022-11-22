Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C063419C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiKVQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKVQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:33:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009D2AD2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:33:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2010D617BA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8158DC433C1;
        Tue, 22 Nov 2022 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669134829;
        bh=PaFgqItu9YOEDI8NSk3JJD/NxUzu7gzwdC6Q6NmYiUo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tO/N2PKaKbBZQrOCel9JY7It2b+de35OxocRR67gi+vwOwRSscQIOaOMewaIj4nvx
         FyTKwajXmfrCcLGtMPiR6YwpKD/AI6XhUojel1vi7rwtzls25UVmwQ6zc1IpH6rA0Q
         WNWAbR3P1Trt+gujQrAHXL7afkSmegFiRf/oeaA5LUBnztAL/OTJfa03jrCXkBpfIV
         1jUs9MgN7A+nXlXB72XfHPMw7n9eR4CJjdR6YR2+P2sEQ1lKQUrlRrCkfquQRNC09F
         VlYiXuFsxCBudpIk1Y/9hBpsoyk7pPj38mTjERRY6eUK9xmVrwdEc4bEedwNAc9e1o
         0hY869rO647Pw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 275AE5C0F98; Tue, 22 Nov 2022 08:33:49 -0800 (PST)
Date:   Tue, 22 Nov 2022 08:33:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Message-ID: <20221122163349.GK4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221118193302.522399-1-longman@redhat.com>
 <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
 <601640d0-9dc2-a060-e165-c8efac54aa34@redhat.com>
 <Y3zCfQCpBu8aBy6O@hirez.programming.kicks-ass.net>
 <70b65b5b-385d-1c47-f003-1e42de290e86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70b65b5b-385d-1c47-f003-1e42de290e86@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:23:43AM -0500, Waiman Long wrote:
> On 11/22/22 07:37, Peter Zijlstra wrote:
> > On Mon, Nov 21, 2022 at 10:04:33AM -0500, Waiman Long wrote:
> > > On 11/21/22 05:38, Peter Zijlstra wrote:
> > > > On Fri, Nov 18, 2022 at 02:33:02PM -0500, Waiman Long wrote:
> > > > > Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> > > > > do_set_cpus_allowed()") may call kfree() if user_cpus_ptr was previously
> > > > > set. Unfortunately, some of the callers of do_set_cpus_allowed()
> > > > 'some' ? There's only 3 or so, which one triggers this?
> > > It happenned at __kthread_bind_mask() where do_set_cpus_allowed() is called
> > > with pi_lock held.
> > > 
> > > [ 1084.820105]  <TASK>
> > > [ 1084.820110]  dump_stack_lvl+0x57/0x81
> > > [ 1084.820117]  check_noncircular+0x103/0x120
> > > [ 10[ 1084.820160]  lock_acquire+0xba/0x230
> > > [ 1084.820164]  ? kfree+0x10f/0x380
> > > [ 1084.820172]  ? do_set_cpus_allowed+0x40/0x60
> > > [ 1084.820181]  rt_spin_lock+0x27/0xe0
> > > [ 1084.820184]  ? kfree+0x10f/0x380
> > > [ 1084.820188]  kfree+0x10f/0x380
> > > [ 1084.820195]  do_set_cpus_allowed+0x40/0x60
> > > [ 1084.820203]  kthread_bind_mask+0x4a/0x70
> > > [ 1084.820211]  create_worker+0xfb/0x1a0
> > > [ 1084.820220]  worker_thread+0x2e3/0x3c0
> > > [ 1084.820226]  ? process_one_work+0x450/0x450
> > > [ 1084.820230]  kthread+0x111/0x130
> > > [ 1084.820236]  ? kthread_complete_and_exit+0x20/0x20
> > > [ 1084.820244]  ret_from_fork+0x22/0x30
> > > [ 1084.820258]  </TASK>
> > > [ 1084.820260] BUG: sleeping function called from invalid context at
> > > kernel/locking/spinlock_rt.c:46
> > > 
> > > It shows up with PREEMPT_RT kernel.
> > Oh, I see ..
> > 
> > > Maybe. One thing that I am not clear about is why user_cpus_ptr is set in
> > > the first place.
> > Perhaps someone set an affinity on kthreadd ?
> > 
> > But I'm thinking this exact problem is also possible (rather more likely
> > even) with select_fallback_rq() that too holds pi_lock (which account
> > for both other users of this function).
> > 
> > Bah.
> > 
> > And the allocation is just the one long in size (for small configs)
> > which is just enough space for a single linked list like you had.
> That is exactly the reason why I use lockless list.
> > 
> > Urgh.
> > 
> > The below is yuck too, and I'm not sure Paul wants us to use
> > kvfree_call_rcu() without its wrapper.
> > 
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 78b2d5cabcc5..0d0af0fc7fcf 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2606,7 +2606,12 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
> >   	};
> >   	__do_set_cpus_allowed(p, &ac);
> > -	kfree(ac.user_mask);
> > +	/*
> > +	 * Because this is called with p->pi_lock held, it is not possible
> > +	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
> > +	 * kfree_rcu().
> > +	 */
> > +	kvfree_call_rcu((struct rcu_head *)ac.user_mask, (rcu_callback_t)0);
> >   }
> 
> I guess you need to do a NULL check before calling kvfree_call_rcu() as I
> don't think kvfree_call_rcu() does that. Also it is unlikely that we need to
> call it.

Indeed, the NULL check is in kvfree_rcu_arg_2().  By the time you get
to kvfree_call_rcu, the pointer is assumed to be non-NULL.

> >   int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
> > @@ -8196,7 +8201,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> >   	struct affinity_context ac;
> >   	struct cpumask *user_mask;
> >   	struct task_struct *p;
> > -	int retval;
> > +	int retval, size;
> >   	rcu_read_lock();
> > @@ -8229,7 +8234,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> >   	if (retval)
> >   		goto out_put_task;
> > -	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> > +	/*
> > +	 * See do_set_cpus_allowed() for the rcu_head usage.
> > +	 */
> > +	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
> > +	user_mask = kmalloc(size, GFP_KERNEL);
> >   	if (!user_mask) {
> >   		retval = -ENOMEM;
> >   		goto out_put_task;
> 
> I guess that will work too. Just like you, I am a bit uneasy to call into
> kvfree_call_rcu() directly as it may change in the future. How about
> 
> iff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 78b2d5cabcc5..5fac4aa6ac7f 100644
> --- a/kernel/sched/core.c
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 78b2d5cabcc5..5fac4aa6ac7f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2593,6 +2593,11 @@ __do_set_cpus_allowed(struct task_struct *p, struct
> affinity_context *ctx)
>                 set_next_task(rq, p);
>  }
> 
> +union cpumask_rcuhead {
> +       void *cpumask;
> +       struct rcu_head rcu;
> +};
> +
>  /*
>   * Used for kthread_bind() and select_fallback_rq(), in both cases the user
>   * affinity (if any) should be destroyed too.
> @@ -2606,7 +2611,12 @@ void do_set_cpus_allowed(struct task_struct *p, const
> struct cpumask *new_mask)
>         };
> 
>         __do_set_cpus_allowed(p, &ac);
> -       kfree(ac.user_mask);
> +       /*
> +        * Because this is called with p->pi_lock held, it is not possible
> +        * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
> +        * kfree_rcu().
> +        */
> +       kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);

This looks plausible to me.

							Thanx, Paul

>  }
> 
>  int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
> @@ -8196,7 +8206,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask
> *in_mask)
>         struct affinity_context ac;
>         struct cpumask *user_mask;
>         struct task_struct *p;
> -       int retval;
> +       int retval, size;
> 
>         rcu_read_lock();
> 
> @@ -8229,7 +8239,11 @@ long sched_setaffinity(pid_t pid, const struct
> cpumask *in_mask)
>         if (retval)
>                 goto out_put_task;
> 
> -       user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> +       /*
> +        * See do_set_cpus_allowed() for the rcu_head usage.
> +        */
> +       size = max_t(int, cpumask_size(), sizeof(union cpumask_rcuhead));
> +       user_mask = kmalloc(size, GFP_KERNEL);
>         if (!user_mask) {
>                 retval = -ENOMEM;
>                 goto out_put_task;
> 
> Cheers,
> Longman
> 
> 
