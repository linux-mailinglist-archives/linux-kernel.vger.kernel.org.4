Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239565E81A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiIWSPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiIWSPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A219A1176EE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE2AA62981
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE29C433D6;
        Fri, 23 Sep 2022 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663956935;
        bh=mbKu05G7ixZ6yK6H4s8nXtYQ+rZNfjldypGVc1OhoVM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uawUQz5VpIVDBPu4AH8oHM7AHQwedjyYbYRBFpTIxzyn10DL68Q6ymHgBe7Wruk5K
         zDzwdJq1WNen1KBCbY660NgX5P4cyRGTUm5ZduxRiJBRdc/aWFcByqEGb6UsXyrX20
         scYLjq4ytWAdLQBifkIJ7TY1WEzT8mOXEYUzQuynP/TFpBIIH1VyH2LvWxUOh9Arro
         FFUuA/egOvc5cU8F2FPsNWgTWoHYIi1v3hHo7IKllWQIGPn2Ag9Mvicro9aOvGRD05
         ErllQT7dMjoPFCdB/folQo5adhEG7ndiZsf2EDGodFtoLkrV2Ea0jv/fJKX9u0Wp9Z
         j+TIgIrzkJzJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D23AA5C0829; Fri, 23 Sep 2022 11:15:34 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:15:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220923181534.GX4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <20220921213644.GA1609461@paulmck-ThinkPad-P17-Gen-1>
 <16b11b78-245e-9db6-1d0f-267832b954ca@joelfernandes.org>
 <20220923160112.GT4196@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YRrk=6hwoHXA76BkwMUS9+4HQQnWy1oTpzibG88FJz_Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRrk=6hwoHXA76BkwMUS9+4HQQnWy1oTpzibG88FJz_Fw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:47:40PM -0400, Joel Fernandes wrote:
> On Fri, Sep 23, 2022 at 12:01 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > And here is an untested patch that in theory might allow much of the
> > > > reduction in power with minimal complexity/overhead for kernels without
> > > > rcu_nocbs CPUs.  On the off-chance you know of someone who would be
> > > > willing to do a realistic evaluation of it.
> > > >
> > > >                                                     Thanx, Paul
> > > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > commit 80fc02e80a2dfb6c7468217cff2d4494a1c4b58d
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Wed Sep 21 13:30:24 2022 -0700
> > > >
> > > >     rcu: Let non-offloaded idle CPUs with callbacks defer tick
> > > >
> > > >     When a CPU goes idle, rcu_needs_cpu() is invoked to determine whether or
> > > >     not RCU needs the scheduler-clock tick to keep interrupting.  Right now,
> > > >     RCU keeps the tick on for a given idle CPU if there are any non-offloaded
> > > >     callbacks queued on that CPU.
> > > >
> > > >     But if all of these callbacks are waiting for a grace period to finish,
> > > >     there is no point in scheduling a tick before that grace period has any
> > > >     reasonable chance of completing.  This commit therefore delays the tick
> > > >     in the case where all the callbacks are waiting for a specific grace
> > > >     period to elapse.  In theory, this should result in a 50-70% reduction in
> > > >     RCU-induced scheduling-clock ticks on mostly-idle CPUs.  In practice, TBD.
> > > >
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > > index 9bc025aa79a3..84e930c11065 100644
> > > > --- a/include/linux/rcutiny.h
> > > > +++ b/include/linux/rcutiny.h
> > > > @@ -133,7 +133,7 @@ static inline void rcu_softirq_qs(void)
> > > >             rcu_tasks_qs(current, (preempt)); \
> > > >     } while (0)
> > > >
> > > > -static inline int rcu_needs_cpu(void)
> > > > +static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> > > >  {
> > > >     return 0;
> > > >  }
> > > > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > > > index 70795386b9ff..3066e0975022 100644
> > > > --- a/include/linux/rcutree.h
> > > > +++ b/include/linux/rcutree.h
> > > > @@ -19,7 +19,7 @@
> > > >
> > > >  void rcu_softirq_qs(void);
> > > >  void rcu_note_context_switch(bool preempt);
> > > > -int rcu_needs_cpu(void);
> > > > +int rcu_needs_cpu(u64 basemono, u64 *nextevt);
> > > >  void rcu_cpu_stall_reset(void);
> > > >
> > > >  /*
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 5ec97e3f7468..47cd3b0d2a07 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -676,12 +676,33 @@ void __rcu_irq_enter_check_tick(void)
> > > >   * scheduler-clock interrupt.
> > > >   *
> > > >   * Just check whether or not this CPU has non-offloaded RCU callbacks
> > > > - * queued.
> > > > + * queued that need immediate attention.
> > > >   */
> > > > -int rcu_needs_cpu(void)
> > > > +int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> > > >  {
> > > > -   return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
> > > > -           !rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
> > > > +   struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > +   struct rcu_segcblist *rsclp = &rdp->cblist;
> > > > +
> > > > +   // Disabled, empty, or offloaded means nothing to do.
> > > > +   if (!rcu_segcblist_is_enabled(rsclp) ||
> > > > +       rcu_segcblist_empty(rsclp) || rcu_rdp_is_offloaded(rdp)) {
> > > > +           *nextevt = KTIME_MAX;
> > > > +           return 0;
> > > > +   }
> > > > +
> > > > +   // Callbacks ready to invoke or that have not already been
> > > > +   // assigned a grace period need immediate attention.
> > > > +   if (!rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ||
> > > > +       !rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL))
> > > > +           return 1;> +
> > > > +   // There are callbacks waiting for some later grace period.
> > > > +   // Wait for about a grace period or two for the next tick, at which
> > > > +   // point there is high probability that this CPU will need to do some
> > > > +   // work for RCU.
> > > > +   *nextevt = basemono + TICK_NSEC * (READ_ONCE(jiffies_till_first_fqs) > +                                           READ_ONCE(jiffies_till_next_fqs) + 1);
> > >
> > > Looks like nice idea. Could this race with the main GP thread on another CPU
> > > completing the grace period, then on this CPU there is actually some work to do
> > > but rcu_needs_cpu() returns 0.
> > >
> > > I think it is plausible but not common, in which case the extra delay is
> > > probably Ok.
> >
> > Glad you like it!
> >
> > Yes, that race can happen, but it can also happen today.
> > A scheduling-clock interrupt might arrive at a CPU just as a grace
> > period finishes.  Yes, the delay is longer with this patch.  If this
> > proves to be a problem, then the delay heuristic might expanded to
> > include the age of the current grace period.
> >
> > But keeping it simple to start with.
> 
> Sure sounds good and yes I agree to the point of the existing issue
> but the error is just 1 jiffie there as you pointed.

One jiffy currently, but it would typically be about seven jiffies with
the patch.  Systems with smaller values of HZ would have fewer jiffies,
and systems with more than 128 CPUs would have more jiffies.  Systems
booted with explicit values for the rcutree.jiffies_till_first_fqs and
rcutree.jiffies_till_next_fqs kernel boot parameters could have whatever
the administrator wanted.  ;-)

But the key point is that the grace period itself can be extended by
that value just due to timing and distribution of idle CPUs.

> > > Also, if the RCU readers take a long time, then we'd still wake up the system
> > > periodically although with the above change, much fewer times, which is a good
> > > thing.
> >
> > And the delay heuristic could also be expanded to include a digitally
> > filtered estimate of grace-period duration.  But again, keeping it simple
> > to start with.  ;-)
> >
> > My guess is that offloading gets you more power savings, but I don't
> > have a good way of testing this guess.
> 
> I could try to run turbostat on Monday on our Intel SoCs, and see how
> it reacts, but I was thinking of tracing this first to see the
> behavior. Another thing I was thinking of was updating (the future)
> rcutop to see how many 'idle ticks' are RCU related, vs others; and
> then see how this patch effects that.

Such testing would be very welcome, thank you!

This patch might also need to keep track of the last tick on a given
CPU in order to prevent frequent short idle periods from indefinitely
delaying the tick.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > > >     unsigned long basejiff;
> > > >     unsigned int seq;
> > > >
> > > > @@ -807,7 +807,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> > > >      * minimal delta which brings us back to this place
> > > >      * immediately. Lather, rinse and repeat...
> > > >      */
> > > > -   if (rcu_needs_cpu() || arch_needs_cpu() ||
> > > > +   if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
> > > >         irq_work_needs_cpu() || local_timer_softirq_pending()) {
> > > >             next_tick = basemono + TICK_NSEC;
> > > >     } else {
> > > > @@ -818,8 +818,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> > > >              * disabled this also looks at the next expiring
> > > >              * hrtimer.
> > > >              */
> > > > -           next_tick = get_next_timer_interrupt(basejiff, basemono);
> > > > -           ts->next_timer = next_tick;
> > > > +           next_tmr = get_next_timer_interrupt(basejiff, basemono);
> > > > +           ts->next_timer = next_tmr;
> > > > +           /* Take the next rcu event into account */
> > > > +           next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
> > > >     }
> > > >
> > > >     /*
