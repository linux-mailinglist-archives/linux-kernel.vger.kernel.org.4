Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625135EF96A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiI2Prk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiI2PrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:47:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3CD18D0EE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89413CE2238
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69D7C433D6;
        Thu, 29 Sep 2022 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466378;
        bh=iHgWd4OupcrvcGhn6VujLkasfBkCqytyR4sP4lZDatQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vGjdM2XjSZzS3R05a01MSwMxgz+qdF/f6jnW9bF6TzDNO4RzFwlg5XxLuf5M+xmTU
         5hMlpNlaO4qqvUlLy6IWKUHX2kUPjPJnBRrbe3nE6YawRNfF/qghXwoE8DEbtEn4Sz
         rLIIKD43tbP2jUSqv7gviCZs2C8h4WFiRoSVHQSuH4lGDMe66EG6QtT0ZDxWaPX85R
         ylsTq45t+ws3Idear5dzig5nwVNmrr6AW6hAG2H3ri6wb0vjhb6S9WeWnSqYwgGek+
         m5RTQqn92ClV/XjLoKNyWpyiDZtPCyhpDwANuJQXpP0LEFLfVyDTO/j8pGPi9IqV2Z
         ust/fFHTL9SMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4F10A5C0AC7; Thu, 29 Sep 2022 08:46:18 -0700 (PDT)
Date:   Thu, 29 Sep 2022 08:46:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220929154618.GA2864141@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 08:20:44AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 29, 2022 at 12:55:58PM +0200, Peter Zijlstra wrote:
> > On Sat, Sep 17, 2022 at 07:25:08AM -0700, Paul E. McKenney wrote:
> > > On Fri, Sep 16, 2022 at 11:20:14AM +0200, Peter Zijlstra wrote:
> > > > On Fri, Sep 16, 2022 at 12:58:17AM -0700, Paul E. McKenney wrote:
> > > > 
> > > > > To the best of my knowledge at this point in time, agreed.  Who knows
> > > > > what someone will come up with next week?  But for people running certain
> > > > > types of real-time and HPC workloads, context tracking really does handle
> > > > > both idle and userspace transitions.
> > > > 
> > > > Sure, but idle != nohz. Nohz is where we disable the tick, and currently
> > > > RCU can inhibit this -- rcu_needs_cpu().
> > > 
> > > Exactly.  For non-nohz userspace execution, the tick is still running
> > > anyway, so RCU of course won't be inhibiting its disabling.  And in that
> > > case, RCU's hook is the tick interrupt itself.  RCU's hook is passed a
> > > flag saying whether the interrupt came from userspace or from kernel.
> > 
> > I'm not sure how we ended up here; this is completely irrelevant and I'm
> > not disagreeing with it.
> > 
> > > > AFAICT there really isn't an RCU hook for this, not through context
> > > > tracking not through anything else.
> > > 
> > > There is a directly invoked RCU hook for any transition that enables or
> > > disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
> > > that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().
> > 
> > Context tracking doesn't know about NOHZ, therefore RCU can't either.
> > Context tracking knows about IDLE, but not all IDLE is NOHZ-IDLE.
> > 
> > Specifically we have:
> > 
> > 	ct_{idle,irq,nmi,user,kernel}_enter()
> > 
> > And none of them are related to NOHZ in the slightest. So no, RCU does
> > not have a NOHZ callback.
> > 
> > I'm still thikning you're conflating NOHZ_FULL (stopping the tick when
> > in userspace) and regular NOHZ (stopping the tick when idle).

Exactly how are ct_user_enter() and ct_user_exit() completely unrelated
to nohz_full CPUs?

> > > And this of course means that any additional schemes to reduce RCU's
> > > power consumption must be compared (with real measurements on real
> > > hardware!) to Joel et al.'s work, whether in combination or as an
> > > alternative.  And either way, the power savings must of course justify
> > > the added code and complexity.
> > 
> > Well, Joel's lazy scheme has the difficulty that you can wreck things by
> > improperly marking the callback as lazy when there's an explicit
> > dependency on it. The talk even called that out.
> > 
> > I was hoping to construct a scheme that doesn't need the whole lazy
> > approach.

I agree that this is a risk that must be addressed.

> > To recap; we want the CPU to go into deeper idle states, no?
> > 
> > RCU can currently inhibit this by having callbacks pending for this CPU
> > -- in this case RCU inhibits NOHZ-IDLE and deep power states are not
> > selected or less effective.
> > 
> > Now, deep idle states actually purge the caches, so cache locality
> > cannot be an argument to keep the callbacks local.
> > 
> > We know when we're doing deep idle we stop the tick.
> > 
> > So why not, when stopping the tick, move the RCU pending crud elsewhere
> > and let the CPU get on with going idle instead of inhibiting the
> > stopping of the tick and wrecking deep idle?
> 
> Because doing so in the past has cost more energy than is saved.

And I should hasten to add that I have no intention of sending this
commit upstream unless/until it is demonstrated to save real energy on
real hardware.  In the meantime, please see below for an updated version
that avoids indefinitely postponing the tick on systems having CPUs that
enter and exit idle frequently.

							Thanx, Paul

------------------------------------------------------------------------

commit e30960e87d58db50bbe4fd09a2ff1e5eeeaad754
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Sep 21 13:30:24 2022 -0700

    rcu: Let non-offloaded idle CPUs with callbacks defer tick
    
    When a CPU goes idle, rcu_needs_cpu() is invoked to determine whether or
    not RCU needs the scheduler-clock tick to keep interrupting.  Right now,
    RCU keeps the tick on for a given idle CPU if there are any non-offloaded
    callbacks queued on that CPU.
    
    But if all of these callbacks are waiting for a grace period to finish,
    there is no point in scheduling a tick before that grace period has any
    reasonable chance of completing.  This commit therefore delays the tick
    in the case where all the callbacks are waiting for a specific grace
    period to elapse.  In theory, this should result in a 50-70% reduction in
    RCU-induced scheduling-clock ticks on mostly-idle CPUs.  In practice, TBD.
    /bin/bash: fm: command not found
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 9bc025aa79a3..84e930c11065 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -133,7 +133,7 @@ static inline void rcu_softirq_qs(void)
 		rcu_tasks_qs(current, (preempt)); \
 	} while (0)
 
-static inline int rcu_needs_cpu(void)
+static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
 	return 0;
 }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 70795386b9ff..3066e0975022 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -19,7 +19,7 @@
 
 void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
-int rcu_needs_cpu(void);
+int rcu_needs_cpu(u64 basemono, u64 *nextevt);
 void rcu_cpu_stall_reset(void);
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..1930cee1ccdb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -676,12 +676,40 @@ void __rcu_irq_enter_check_tick(void)
  * scheduler-clock interrupt.
  *
  * Just check whether or not this CPU has non-offloaded RCU callbacks
- * queued.
+ * queued that need immediate attention.
  */
-int rcu_needs_cpu(void)
+int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
-	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
-		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
+	unsigned long j;
+	unsigned long jlast;
+	unsigned long jwait;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_segcblist *rsclp = &rdp->cblist;
+
+	// Disabled, empty, or offloaded means nothing to do.
+	if (!rcu_segcblist_is_enabled(rsclp) ||
+	    rcu_segcblist_empty(rsclp) || rcu_rdp_is_offloaded(rdp)) {
+		*nextevt = KTIME_MAX;
+		return 0;
+	}
+
+	// Callbacks ready to invoke or that have not already been
+	// assigned a grace period need immediate attention.
+	if (!rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ||
+	    !rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL))
+		return 1;
+
+	// There are callbacks waiting for some later grace period.
+	// Wait for about a grace period or two since the last tick, at which
+	// point there is high probability that this CPU will need to do some
+	// work for RCU.
+	j = jiffies;
+	jlast = __this_cpu_read(rcu_data.last_sched_clock);
+	jwait = READ_ONCE(jiffies_till_first_fqs) + READ_ONCE(jiffies_till_next_fqs) + 1;
+	if (time_after(j, jlast + jwait))
+		return 1;
+	*nextevt = basemono + TICK_NSEC * (jlast + jwait - j);
+	return 0;
 }
 
 /*
@@ -2324,11 +2352,9 @@ void rcu_sched_clock_irq(int user)
 {
 	unsigned long j;
 
-	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
-		j = jiffies;
-		WARN_ON_ONCE(time_before(j, __this_cpu_read(rcu_data.last_sched_clock)));
-		__this_cpu_write(rcu_data.last_sched_clock, j);
-	}
+	j = jiffies;
+	WARN_ON_ONCE(time_before(j, __this_cpu_read(rcu_data.last_sched_clock)));
+	__this_cpu_write(rcu_data.last_sched_clock, j);
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	lockdep_assert_irqs_disabled();
 	raw_cpu_inc(rcu_data.ticks_this_gp);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..303ea15cdb96 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -784,7 +784,7 @@ static inline bool local_timer_softirq_pending(void)
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, delta, expires;
+	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
 
@@ -807,7 +807,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * minimal delta which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
-	if (rcu_needs_cpu() || arch_needs_cpu() ||
+	if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
 	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
 		next_tick = basemono + TICK_NSEC;
 	} else {
@@ -818,8 +818,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		next_tick = get_next_timer_interrupt(basejiff, basemono);
-		ts->next_timer = next_tick;
+		next_tmr = get_next_timer_interrupt(basejiff, basemono);
+		ts->next_timer = next_tmr;
+		/* Take the next rcu event into account */
+		next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
 	}
 
 	/*
