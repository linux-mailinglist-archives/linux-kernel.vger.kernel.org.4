Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDBB5E7F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiIWQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIWQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:01:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1185147A3B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17FD9B81913
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C148FC433C1;
        Fri, 23 Sep 2022 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663948872;
        bh=IMPCQs0oP9bISwvvaMR6PDrEaL55VgGDCbMYJUBi59U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IAY1p5Q12a2GBkpLsAofYkWaX2K+dayt1I4tjb61V9Cd7qOR9DbQPceL2F4F1EFpg
         EY1rBMd3/6V530TyD4rD4OZ9yrzSvxSXXOgSmA9eZq/WSDkHo4Nd5A2AHTwRIawDIl
         TDFqLsoYqMmYVayDCU0CYKI/uuDD0kms0ilCZQVZTlI7b5+sxCJIhnYx+E3mCO0k7q
         jXvU0CjheHlIjKuJHbE04E6vi7U7blMGgh2XLt4oMb9YAYwSCMFH0VNK5lhRcsY7Uj
         yAmTuEiLA0VKz+H2+D3IKbLnpcs1vyBlEkhSADT0bGJBIac0UxN25Bi58XHRKl7vsQ
         DEj2xgAAzubcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5EBE55C0829; Fri, 23 Sep 2022 09:01:12 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:01:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220923160112.GT4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <20220921213644.GA1609461@paulmck-ThinkPad-P17-Gen-1>
 <16b11b78-245e-9db6-1d0f-267832b954ca@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b11b78-245e-9db6-1d0f-267832b954ca@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:12:17AM -0400, Joel Fernandes wrote:
> On 9/21/2022 5:36 PM, Paul E. McKenney wrote:
> > On Sat, Sep 17, 2022 at 07:25:08AM -0700, Paul E. McKenney wrote:
> >> On Fri, Sep 16, 2022 at 11:20:14AM +0200, Peter Zijlstra wrote:
> >>> On Fri, Sep 16, 2022 at 12:58:17AM -0700, Paul E. McKenney wrote:
> >>>
> >>>> To the best of my knowledge at this point in time, agreed.  Who knows
> >>>> what someone will come up with next week?  But for people running certain
> >>>> types of real-time and HPC workloads, context tracking really does handle
> >>>> both idle and userspace transitions.
> >>>
> >>> Sure, but idle != nohz. Nohz is where we disable the tick, and currently
> >>> RCU can inhibit this -- rcu_needs_cpu().
> >>
> >> Exactly.  For non-nohz userspace execution, the tick is still running
> >> anyway, so RCU of course won't be inhibiting its disabling.  And in that
> >> case, RCU's hook is the tick interrupt itself.  RCU's hook is passed a
> >> flag saying whether the interrupt came from userspace or from kernel.
> >>
> >>> AFAICT there really isn't an RCU hook for this, not through context
> >>> tracking not through anything else.
> >>
> >> There is a directly invoked RCU hook for any transition that enables or
> >> disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
> >> that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().
> >>
> >>>> It wasn't enabled for ChromeOS.
> >>>>
> >>>> When fully enabled, it gave them the energy-efficiency advantages Joel
> >>>> described.  And then Joel described some additional call_rcu_lazy()
> >>>> changes that provided even better energy efficiency.  Though I believe
> >>>> that the application should also be changed to avoid incessantly opening
> >>>> and closing that file while the device is idle, as this would remove
> >>>> -all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
> >>>> use cases would likely remain.
> >>>
> >>> So I'm thinking the scheme I outlined gets you most if not all of what
> >>> lazy would get you without having to add the lazy thing. A CPU is never
> >>> refused deep idle when it passes off the callbacks.
> >>>
> >>> The NOHZ thing is a nice hook for 'this-cpu-wants-to-go-idle-long-term'
> >>> and do our utmost bestest to move work away from it. You *want* to break
> >>> affinity at this point.
> >>>
> >>> If you hate on the global, push it to a per rcu_node offload list until
> >>> the whole node is idle and then push it up the next rcu_node level until
> >>> you reach the top.
> >>>
> >>> Then when the top rcu_node is full idle; you can insta progress the QS
> >>> state and run the callbacks and go idle.
> >>
> >> Unfortunately, the overhead of doing all that tracking along with
> >> resolving all the resulting race conditions will -increase- power
> >> consumption.  With RCU, counting CPU wakeups is not as good a predictor
> >> of power consumption as one might like.  Sure, it is a nice heuristic
> >> in some cases, but with RCU it is absolutely -not- a replacement for
> >> actually measuring power consumption on real hardware.  And yes, I did
> >> learn this the hard way.  Why do you ask?  ;-)
> >>
> >> And that is why the recently removed CONFIG_RCU_FAST_NO_HZ left the
> >> callbacks in place and substituted a 4x slower timer for the tick.
> >> -That- actually resulted in significant real measured power savings on
> >> real hardware.
> >>
> >> Except that everything that was building with CONFIG_RCU_FAST_NO_HZ
> >> was also doing nohz_full on each and every CPU.  Which meant that all
> >> that CONFIG_RCU_FAST_NO_HZ was doing for them was adding an additional
> >> useless check on each transition to and from idle.  Which in turn is why
> >> CONFIG_RCU_FAST_NO_HZ was removed.  No one was using it in any way that
> >> made any sense.
> >>
> >> And more recent testing with rcu_nocbs on both ChromeOS and Android has
> >> produced better savings than was produced by CONFIG_RCU_FAST_NO_HZ anyway.
> >>
> >> Much of the additional savings from Joel et al.'s work is not so much
> >> from reducing the number of ticks, but rather from reducing the number
> >> of grace periods, which are of course much heavier weight.
> >>
> >> And this of course means that any additional schemes to reduce RCU's
> >> power consumption must be compared (with real measurements on real
> >> hardware!) to Joel et al.'s work, whether in combination or as an
> >> alternative.  And either way, the power savings must of course justify
> >> the added code and complexity.
> > 
> > And here is an untested patch that in theory might allow much of the
> > reduction in power with minimal complexity/overhead for kernels without
> > rcu_nocbs CPUs.  On the off-chance you know of someone who would be
> > willing to do a realistic evaluation of it.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 80fc02e80a2dfb6c7468217cff2d4494a1c4b58d
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Sep 21 13:30:24 2022 -0700
> > 
> >     rcu: Let non-offloaded idle CPUs with callbacks defer tick
> >     
> >     When a CPU goes idle, rcu_needs_cpu() is invoked to determine whether or
> >     not RCU needs the scheduler-clock tick to keep interrupting.  Right now,
> >     RCU keeps the tick on for a given idle CPU if there are any non-offloaded
> >     callbacks queued on that CPU.
> >     
> >     But if all of these callbacks are waiting for a grace period to finish,
> >     there is no point in scheduling a tick before that grace period has any
> >     reasonable chance of completing.  This commit therefore delays the tick
> >     in the case where all the callbacks are waiting for a specific grace
> >     period to elapse.  In theory, this should result in a 50-70% reduction in
> >     RCU-induced scheduling-clock ticks on mostly-idle CPUs.  In practice, TBD.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> > 
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index 9bc025aa79a3..84e930c11065 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -133,7 +133,7 @@ static inline void rcu_softirq_qs(void)
> >  		rcu_tasks_qs(current, (preempt)); \
> >  	} while (0)
> >  
> > -static inline int rcu_needs_cpu(void)
> > +static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> >  {
> >  	return 0;
> >  }
> > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > index 70795386b9ff..3066e0975022 100644
> > --- a/include/linux/rcutree.h
> > +++ b/include/linux/rcutree.h
> > @@ -19,7 +19,7 @@
> >  
> >  void rcu_softirq_qs(void);
> >  void rcu_note_context_switch(bool preempt);
> > -int rcu_needs_cpu(void);
> > +int rcu_needs_cpu(u64 basemono, u64 *nextevt);
> >  void rcu_cpu_stall_reset(void);
> >  
> >  /*
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 5ec97e3f7468..47cd3b0d2a07 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -676,12 +676,33 @@ void __rcu_irq_enter_check_tick(void)
> >   * scheduler-clock interrupt.
> >   *
> >   * Just check whether or not this CPU has non-offloaded RCU callbacks
> > - * queued.
> > + * queued that need immediate attention.
> >   */
> > -int rcu_needs_cpu(void)
> > +int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> >  {
> > -	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
> > -		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
> > +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > +	struct rcu_segcblist *rsclp = &rdp->cblist;
> > +
> > +	// Disabled, empty, or offloaded means nothing to do.
> > +	if (!rcu_segcblist_is_enabled(rsclp) ||
> > +	    rcu_segcblist_empty(rsclp) || rcu_rdp_is_offloaded(rdp)) {
> > +		*nextevt = KTIME_MAX;
> > +		return 0;
> > +	}
> > +
> > +	// Callbacks ready to invoke or that have not already been
> > +	// assigned a grace period need immediate attention.
> > +	if (!rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ||
> > +	    !rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL))
> > +		return 1;> +
> > +	// There are callbacks waiting for some later grace period.
> > +	// Wait for about a grace period or two for the next tick, at which
> > +	// point there is high probability that this CPU will need to do some
> > +	// work for RCU.
> > +	*nextevt = basemono + TICK_NSEC * (READ_ONCE(jiffies_till_first_fqs) > +					   READ_ONCE(jiffies_till_next_fqs) + 1);
> 
> Looks like nice idea. Could this race with the main GP thread on another CPU
> completing the grace period, then on this CPU there is actually some work to do
> but rcu_needs_cpu() returns 0.
> 
> I think it is plausible but not common, in which case the extra delay is
> probably Ok.

Glad you like it!

Yes, that race can happen, but it can also happen today.
A scheduling-clock interrupt might arrive at a CPU just as a grace
period finishes.  Yes, the delay is longer with this patch.  If this
proves to be a problem, then the delay heuristic might expanded to
include the age of the current grace period.

But keeping it simple to start with.

> Also, if the RCU readers take a long time, then we'd still wake up the system
> periodically although with the above change, much fewer times, which is a good
> thing.

And the delay heuristic could also be expanded to include a digitally
filtered estimate of grace-period duration.  But again, keeping it simple
to start with.  ;-)

My guess is that offloading gets you more power savings, but I don't
have a good way of testing this guess.

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> 
> 
> > +	return 0;
> >  }
> >  
> >  /*
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index b0e3c9205946..303ea15cdb96 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -784,7 +784,7 @@ static inline bool local_timer_softirq_pending(void)
> >  
> >  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> >  {
> > -	u64 basemono, next_tick, delta, expires;
> > +	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
> >  	unsigned long basejiff;
> >  	unsigned int seq;
> >  
> > @@ -807,7 +807,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> >  	 * minimal delta which brings us back to this place
> >  	 * immediately. Lather, rinse and repeat...
> >  	 */
> > -	if (rcu_needs_cpu() || arch_needs_cpu() ||
> > +	if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
> >  	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
> >  		next_tick = basemono + TICK_NSEC;
> >  	} else {
> > @@ -818,8 +818,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> >  		 * disabled this also looks at the next expiring
> >  		 * hrtimer.
> >  		 */
> > -		next_tick = get_next_timer_interrupt(basejiff, basemono);
> > -		ts->next_timer = next_tick;
> > +		next_tmr = get_next_timer_interrupt(basejiff, basemono);
> > +		ts->next_timer = next_tmr;
> > +		/* Take the next rcu event into account */
> > +		next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
> >  	}
> >  
> >  	/*
