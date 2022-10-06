Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D415F6DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJFTLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiJFTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2E0A3F45;
        Thu,  6 Oct 2022 12:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B2261A78;
        Thu,  6 Oct 2022 19:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FE7C433B5;
        Thu,  6 Oct 2022 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665083490;
        bh=/XbYsUSXUhmCF/Vu1iaUMc98bI9k9dauEzkMSEUjsRo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kCQhhlNUwp6V6+mHns05T+4yN7iDprsA1LdRlZ1nJC4EQaQ62IqO/jsiC/FsIV53t
         dc5lmqYhxrwK0TMFbrDqXV4F54qp0ToeECEFIm9oIaZ503kTFshz1phy9c3Avb0Gcu
         Fxkgb1hHxk6sTRpQcEZJCwk/EhY+YD6D/OICvnX5/gDznuqyOxh8I3CyXHgWqJA5mD
         gdtweMzoDbJcuEyu4LmnDjGUX8Dk6Xai3brdo/SI1KcZ5VizinvOb3ycpjR30ttcBy
         jL6mVS8xVXSMso57Z/VBNn0L/T9rn70qJQxADZ4hTQGQ08Me3YtbsqqwhwXdRYpmoM
         /qffOteDaX67A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1BDDF5C0F66; Thu,  6 Oct 2022 12:11:30 -0700 (PDT)
Date:   Thu, 6 Oct 2022 12:11:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <20221006191130.GC4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:48AM +0000, Joel Fernandes (Google) wrote:
> Implement timer-based RCU callback batching (also known as lazy
> callbacks). With this we save about 5-10% of power consumed due
> to RCU requests that happen when system is lightly loaded or idle.
> 
> By default, all async callbacks (queued via call_rcu) are marked
> lazy. An alternate API call_rcu_flush() is provided for the few users,
> for example synchronize_rcu(), that need the old behavior.
> 
> The batch is flushed whenever a certain amount of time has passed, or
> the batch on a particular CPU grows too big. Also memory pressure will
> flush it in a future patch.
> 
> To handle several corner cases automagically (such as rcu_barrier() and
> hotplug), we re-use bypass lists which were originally introduced to
> address lock contention, to handle lazy CBs as well. The bypass list
> length has the lazy CB length included in it. A separate lazy CB length
> counter is also introduced to keep track of the number of lazy CBs.
> 
> Suggested-by: Paul McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

A few comments below.  Perhaps these seem picky, but that should be
taken as evidence that we are getting close. ;-)

							Thanx, Paul

> ---
>  include/linux/rcupdate.h |   7 ++
>  kernel/rcu/Kconfig       |   8 ++
>  kernel/rcu/rcu.h         |   8 ++
>  kernel/rcu/tiny.c        |   2 +-
>  kernel/rcu/tree.c        | 129 +++++++++++++++++++-----------
>  kernel/rcu/tree.h        |  12 ++-
>  kernel/rcu/tree_exp.h    |   2 +-
>  kernel/rcu/tree_nocb.h   | 164 +++++++++++++++++++++++++++++++--------
>  8 files changed, 246 insertions(+), 86 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 08605ce7379d..40ae36904825 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
>  
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> +#ifdef CONFIG_RCU_LAZY
> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> +#else
> +static inline void call_rcu_flush(struct rcu_head *head,
> +		rcu_callback_t func) {  call_rcu(head, func); }
> +#endif
> +
>  /* Internal to kernel */
>  void rcu_init(void);
>  extern int rcu_scheduler_active;
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index f53ad63b2bc6..edd632e68497 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
>  	  Say N here if you hate read-side memory barriers.
>  	  Take the default if you are unsure.
>  
> +config RCU_LAZY
> +	bool "RCU callback lazy invocation functionality"
> +	depends on RCU_NOCB_CPU
> +	default n
> +	help
> +	  To save power, batch RCU callbacks and flush after delay, memory
> +	  pressure or callback list growing too big.
> +
>  endmenu # "RCU Subsystem"
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index be5979da07f5..65704cbc9df7 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -474,6 +474,14 @@ enum rcutorture_type {
>  	INVALID_RCU_FLAVOR
>  };
>  
> +#if defined(CONFIG_RCU_LAZY)
> +unsigned long rcu_lazy_get_jiffies_till_flush(void);
> +void rcu_lazy_set_jiffies_till_flush(unsigned long j);
> +#else
> +static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
> +static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
> +#endif
> +
>  #if defined(CONFIG_TREE_RCU)
>  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>  			    unsigned long *gp_seq);
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index a33a8d4942c3..810479cf17ba 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -44,7 +44,7 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
>  
>  void rcu_barrier(void)
>  {
> -	wait_rcu_gp(call_rcu);
> +	wait_rcu_gp(call_rcu_flush);
>  }
>  EXPORT_SYMBOL(rcu_barrier);
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 04f33191e5ed..c20544c4aa29 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2728,47 +2728,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  
> -/**
> - * call_rcu() - Queue an RCU callback for invocation after a grace period.
> - * @head: structure to be used for queueing the RCU updates.
> - * @func: actual callback function to be invoked after the grace period
> - *
> - * The callback function will be invoked some time after a full grace
> - * period elapses, in other words after all pre-existing RCU read-side
> - * critical sections have completed.  However, the callback function
> - * might well execute concurrently with RCU read-side critical sections
> - * that started after call_rcu() was invoked.
> - *
> - * RCU read-side critical sections are delimited by rcu_read_lock()
> - * and rcu_read_unlock(), and may be nested.  In addition, but only in
> - * v5.0 and later, regions of code across which interrupts, preemption,
> - * or softirqs have been disabled also serve as RCU read-side critical
> - * sections.  This includes hardware interrupt handlers, softirq handlers,
> - * and NMI handlers.
> - *
> - * Note that all CPUs must agree that the grace period extended beyond
> - * all pre-existing RCU read-side critical section.  On systems with more
> - * than one CPU, this means that when "func()" is invoked, each CPU is
> - * guaranteed to have executed a full memory barrier since the end of its
> - * last RCU read-side critical section whose beginning preceded the call
> - * to call_rcu().  It also means that each CPU executing an RCU read-side
> - * critical section that continues beyond the start of "func()" must have
> - * executed a memory barrier after the call_rcu() but before the beginning
> - * of that RCU read-side critical section.  Note that these guarantees
> - * include CPUs that are offline, idle, or executing in user mode, as
> - * well as CPUs that are executing in the kernel.
> - *
> - * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
> - * resulting RCU callback function "func()", then both CPU A and CPU B are
> - * guaranteed to execute a full memory barrier during the time interval
> - * between the call to call_rcu() and the invocation of "func()" -- even
> - * if CPU A and CPU B are the same CPU (but again only if the system has
> - * more than one CPU).
> - *
> - * Implementation of these memory-ordering guarantees is described here:
> - * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
> - */
> -void call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static void
> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
>  {
>  	static atomic_t doublefrees;
>  	unsigned long flags;
> @@ -2809,7 +2770,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	}
>  
>  	check_cb_ovld(rdp);
> -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
>  		return; // Enqueued onto ->nocb_bypass, so just leave.
>  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
>  	rcu_segcblist_enqueue(&rdp->cblist, head);
> @@ -2831,8 +2792,84 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		local_irq_restore(flags);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(call_rcu);
>  
> +#ifdef CONFIG_RCU_LAZY
> +/**
> + * call_rcu_flush() - Queue RCU callback for invocation after grace period, and
> + * flush all lazy callbacks (including the new one) to the main ->cblist while
> + * doing so.
> + *
> + * @head: structure to be used for queueing the RCU updates.
> + * @func: actual callback function to be invoked after the grace period
> + *
> + * The callback function will be invoked some time after a full grace
> + * period elapses, in other words after all pre-existing RCU read-side
> + * critical sections have completed.
> + *
> + * Use this API instead of call_rcu() if you don't want the callback to be
> + * invoked after very long periods of time, which can happen on systems without
> + * memory pressure and on systems which are lightly loaded or mostly idle.
> + * This function will cause callbacks to be invoked sooner than later at the
> + * expense of extra power. Other than that, this function is identical to, and
> + * reuses call_rcu()'s logic. Refer to call_rcu() for more details about memory
> + * ordering and other functionality.
> + */
> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func)
> +{
> +	return __call_rcu_common(head, func, false);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_flush);
> +#endif
> +
> +/**
> + * call_rcu() - Queue an RCU callback for invocation after a grace period.
> + * By default the callbacks are 'lazy' and are kept hidden from the main
> + * ->cblist to prevent starting of grace periods too soon.
> + * If you desire grace periods to start very soon, use call_rcu_flush().
> + *
> + * @head: structure to be used for queueing the RCU updates.
> + * @func: actual callback function to be invoked after the grace period
> + *
> + * The callback function will be invoked some time after a full grace
> + * period elapses, in other words after all pre-existing RCU read-side
> + * critical sections have completed.  However, the callback function
> + * might well execute concurrently with RCU read-side critical sections
> + * that started after call_rcu() was invoked.
> + *
> + * RCU read-side critical sections are delimited by rcu_read_lock()
> + * and rcu_read_unlock(), and may be nested.  In addition, but only in
> + * v5.0 and later, regions of code across which interrupts, preemption,
> + * or softirqs have been disabled also serve as RCU read-side critical
> + * sections.  This includes hardware interrupt handlers, softirq handlers,
> + * and NMI handlers.
> + *
> + * Note that all CPUs must agree that the grace period extended beyond
> + * all pre-existing RCU read-side critical section.  On systems with more
> + * than one CPU, this means that when "func()" is invoked, each CPU is
> + * guaranteed to have executed a full memory barrier since the end of its
> + * last RCU read-side critical section whose beginning preceded the call
> + * to call_rcu().  It also means that each CPU executing an RCU read-side
> + * critical section that continues beyond the start of "func()" must have
> + * executed a memory barrier after the call_rcu() but before the beginning
> + * of that RCU read-side critical section.  Note that these guarantees
> + * include CPUs that are offline, idle, or executing in user mode, as
> + * well as CPUs that are executing in the kernel.
> + *
> + * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
> + * resulting RCU callback function "func()", then both CPU A and CPU B are
> + * guaranteed to execute a full memory barrier during the time interval
> + * between the call to call_rcu() and the invocation of "func()" -- even
> + * if CPU A and CPU B are the same CPU (but again only if the system has
> + * more than one CPU).
> + *
> + * Implementation of these memory-ordering guarantees is described here:
> + * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
> + */
> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +	return __call_rcu_common(head, func, true);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu);
>  
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
> @@ -3507,7 +3544,7 @@ void synchronize_rcu(void)
>  		if (rcu_gp_is_expedited())
>  			synchronize_rcu_expedited();
>  		else
> -			wait_rcu_gp(call_rcu);
> +			wait_rcu_gp(call_rcu_flush);
>  		return;
>  	}
>  
> @@ -3905,7 +3942,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
>  	was_done = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
>  	} else {
> @@ -4334,7 +4371,7 @@ void rcutree_migrate_callbacks(int cpu)
>  	my_rdp = this_cpu_ptr(&rcu_data);
>  	my_rnp = my_rdp->mynode;
>  	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false));
>  	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
>  	/* Leverage recent GPs and set GP for new callbacks. */
>  	needwake = rcu_advance_cbs(my_rnp, rdp) ||
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c..1d803d39f0d1 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -263,14 +263,16 @@ struct rcu_data {
>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
>  
> +	long lazy_len;			/* Length of buffered lazy callbacks. */
>  	int cpu;
>  };
>  
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
>  #define RCU_NOCB_WAKE_NOT	0
>  #define RCU_NOCB_WAKE_BYPASS	1
> -#define RCU_NOCB_WAKE		2
> -#define RCU_NOCB_WAKE_FORCE	3
> +#define RCU_NOCB_WAKE_LAZY	2
> +#define RCU_NOCB_WAKE		3
> +#define RCU_NOCB_WAKE_FORCE	4
>  
>  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
>  					/* For jiffies_till_first_fqs and */
> @@ -440,9 +442,11 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j);
> +				  unsigned long j, bool lazy);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags);
> +				bool *was_alldone, unsigned long flags,
> +				bool lazy);
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>  static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>  				 unsigned long flags);
>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 18e9b4cd78ef..5cac05600798 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -937,7 +937,7 @@ void synchronize_rcu_expedited(void)
>  
>  	/* If expedited grace periods are prohibited, fall back to normal. */
>  	if (rcu_gp_is_normal()) {
> -		wait_rcu_gp(call_rcu);
> +		wait_rcu_gp(call_rcu_flush);
>  		return;
>  	}
>  
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 6caade0683dd..56616bfbe156 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -256,6 +256,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>  }
>  
> +/*
> + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
> + * can elapse before lazy callbacks are flushed. Lazy callbacks
> + * could be flushed much earlier for a number of other reasons
> + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
> + * left unsubmitted to RCU after those many jiffies.
> + */
> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> +static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
> +
> +#ifdef CONFIG_RCU_LAZY
> +// To be called only from test code.
> +void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
> +{
> +	jiffies_till_flush = jif;
> +}
> +EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
> +
> +unsigned long rcu_lazy_get_jiffies_till_flush(void)
> +{
> +	return jiffies_till_flush;
> +}
> +EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
> +#endif
> +
>  /*
>   * Arrange to wake the GP kthread for this NOCB group at some future
>   * time when it is safe to do so.
> @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>  
>  	/*
> -	 * Bypass wakeup overrides previous deferments. In case
> -	 * of callback storm, no need to wake up too early.
> +	 * Bypass wakeup overrides previous deferments. In case of
> +	 * callback storm, no need to wake up too early.
>  	 */
> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	if (waketype == RCU_NOCB_WAKE_LAZY &&
> +	    READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {
> +		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  	} else {
> @@ -293,10 +322,13 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   * proves to be initially empty, just return false because the no-CB GP
>   * kthread may need to be awakened in this case.
>   *
> + * Return true if there was something to be flushed and it succeeded, otherwise
> + * false.
> + *
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				     unsigned long j)
> +				     unsigned long j, bool lazy)
>  {
>  	struct rcu_cblist rcl;
>  
> @@ -310,7 +342,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
>  	if (rhp)
>  		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
> -	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +
> +	/*
> +	 * If the new CB requested was a lazy one, queue it onto the main
> +	 * ->cblist so we can take advantage of a sooner grade period.
> +	 */
> +	if (lazy && rhp) {
> +		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> +		rcu_cblist_enqueue(&rcl, rhp);
> +		WRITE_ONCE(rdp->lazy_len, 0);
> +	} else {
> +		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +		WRITE_ONCE(rdp->lazy_len, 0);
> +	}

I was going to complain about this again, but I see the cleanup commit.  ;-)

> +
>  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>  	WRITE_ONCE(rdp->nocb_bypass_first, j);
>  	rcu_nocb_bypass_unlock(rdp);
> @@ -326,13 +371,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j)
> +				  unsigned long j, bool lazy)
>  {
>  	if (!rcu_rdp_is_offloaded(rdp))
>  		return true;
>  	rcu_lockdep_assert_cblist_protected(rdp);
>  	rcu_nocb_bypass_lock(rdp);
> -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> +	return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
>  }
>  
>  /*
> @@ -345,7 +390,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
>  	if (!rcu_rdp_is_offloaded(rdp) ||
>  	    !rcu_nocb_bypass_trylock(rdp))
>  		return;
> -	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
> +	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
>  }
>  
>  /*
> @@ -367,12 +412,14 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
>   * there is only one CPU in operation.
>   */
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags)
> +				bool *was_alldone, unsigned long flags,
> +				bool lazy)
>  {
>  	unsigned long c;
>  	unsigned long cur_gp_seq;
>  	unsigned long j = jiffies;
>  	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +	bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));

In the alphabet, "b" comes before "c".  Picky, but it does make these
things easier to find.  Which can be important when you are searching
for all occurrences of something -- nice to be able to find the variable
in alpha order without interrupting your search.

>  	lockdep_assert_irqs_disabled();
>  
> @@ -417,25 +464,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	// If there hasn't yet been all that many ->cblist enqueues
>  	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
>  	// ->nocb_bypass first.
> -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> +	// Lazy CBs throttle this back and do immediate bypass queuing.
> +	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) {
>  		rcu_nocb_lock(rdp);
>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  		if (*was_alldone)
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("FirstQ"));
> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> +

Can't say I get the rationale for some of the added blank lines, but
I am not (yet) too worried about it.

> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
>  		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>  		return false; // Caller must enqueue the callback.
>  	}
>  
>  	// If ->nocb_bypass has been used too long or is too full,
>  	// flush ->nocb_bypass to ->cblist.
> -	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
> +	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
> +	    (ncbs &&  bypass_is_lazy &&
> +		(time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush))) ||

Please line up the "(" of the above line with the "n" in "ncbs" of the
line preceding it.

>  	    ncbs >= qhimark) {
>  		rcu_nocb_lock(rdp);
>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  
> -		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
> +		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy)) {
>  			if (*was_alldone)
>  				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  						    TPS("FirstQ"));
> @@ -460,16 +511,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	// We need to use the bypass.
>  	rcu_nocb_wait_contended(rdp);
>  	rcu_nocb_bypass_lock(rdp);
> +
>  	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>  	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>  	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> +
> +	if (lazy)
> +		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
> +
>  	if (!ncbs) {
>  		WRITE_ONCE(rdp->nocb_bypass_first, j);
>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
>  	}
> +
>  	rcu_nocb_bypass_unlock(rdp);
>  	smp_mb(); /* Order enqueue before wake. */
> -	if (ncbs) {
> +
> +	// A wake up of the grace period kthread or timer adjustment needs to
> +	// be done only if:
> +	// 1. Bypass list was fully empty before (this is the first bypass list entry).
> +	//	Or, both the below conditions are met:
> +	// 1. Bypass list had only lazy CBs before.
> +	// 2. The new CB is non-lazy.

How about like this?

	// A wake up of the grace period kthread or timer adjustment
	// needs to be done only if:
	// 1. Bypass list was fully empty before (this is the first
	//    bypass list entry), or:
	// 2. Both of these conditions are met:
	//    a. The bypass list previously had only lazy CBs, and:
	//    b. The new CB is non-lazy.

> +	if (ncbs && (!bypass_is_lazy || lazy)) {
>  		local_irq_restore(flags);
>  	} else {
>  		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
> @@ -497,9 +561,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  				 unsigned long flags)
>  				 __releases(rdp->nocb_lock)
>  {
> +	long bypass_len;
>  	unsigned long cur_gp_seq;
>  	unsigned long j;
> -	long len;
> +	long len, lazy_len;

One on each line, please, with lazy_len first.

>  	struct task_struct *t;
>  
>  	// If we are being polled or there is no kthread, just leave.
> @@ -512,9 +577,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  	}
>  	// Need to actually to a wakeup.
>  	len = rcu_segcblist_n_cbs(&rdp->cblist);
> +	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +	lazy_len = READ_ONCE(rdp->lazy_len);
>  	if (was_alldone) {
>  		rdp->qlen_last_fqs_check = len;
> -		if (!irqs_disabled_flags(flags)) {
> +		// Only lazy CBs in bypass list
> +		if (lazy_len && bypass_len == lazy_len) {
> +			rcu_nocb_unlock_irqrestore(rdp, flags);
> +			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
> +					   TPS("WakeLazy"));
> +		} else if (!irqs_disabled_flags(flags)) {
>  			/* ... if queue was empty ... */
>  			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			wake_nocb_gp(rdp, false);
> @@ -611,6 +683,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	unsigned long flags;
>  	bool gotcbs = false;
>  	unsigned long j = jiffies;
> +	bool lazy = false;
> +	long lazy_ncbs;
>  	bool needwait_gp = false; // This prevents actual uninitialized use.
>  	bool needwake;
>  	bool needwake_gp;
> @@ -640,24 +714,41 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	 * won't be ignored for long.
>  	 */
>  	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
> +		bool flush_bypass = false;
> +
>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
>  		rcu_nocb_lock_irqsave(rdp, flags);
>  		lockdep_assert_held(&rdp->nocb_lock);
>  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> -		if (bypass_ncbs &&
> +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> +
> +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> +		     bypass_ncbs > 2 * qhimark)) {
> +			flush_bypass = true;
> +		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
>  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
>  		     bypass_ncbs > 2 * qhimark)) {
> -			// Bypass full or old, so flush it.
> -			(void)rcu_nocb_try_flush_bypass(rdp, j);
> -			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +			flush_bypass = true;
>  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
>  			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			continue; /* No callbacks here, try next. */
>  		}
> +
> +		if (flush_bypass) {
> +			// Bypass full or old, so flush it.
> +			(void)rcu_nocb_try_flush_bypass(rdp, j);
> +			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +			lazy_ncbs = READ_ONCE(rdp->lazy_len);
> +		}
> +
>  		if (bypass_ncbs) {
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> -					    TPS("Bypass"));
> -			bypass = true;
> +				    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));

Please line this up.  Given 100-column lines, one easy way to do that
is as follows:

 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
					    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));

> +			if (bypass_ncbs == lazy_ncbs)
> +				lazy = true;
> +			else
> +				bypass = true;
>  		}
>  		rnp = rdp->mynode;
>  
> @@ -705,12 +796,20 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	my_rdp->nocb_gp_gp = needwait_gp;
>  	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
>  
> -	if (bypass && !rcu_nocb_poll) {
> -		// At least one child with non-empty ->nocb_bypass, so set
> -		// timer in order to avoid stranding its callbacks.
> -		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
> -				   TPS("WakeBypassIsDeferred"));
> +	// At least one child with non-empty ->nocb_bypass, so set
> +	// timer in order to avoid stranding its callbacks.
> +	if (!rcu_nocb_poll) {
> +		// If bypass list only has lazy CBs. Add a deferred lazy wake up.
> +		if (lazy && !bypass) {
> +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
> +					TPS("WakeLazyIsDeferred"));
> +		// Otherwise add a deferred bypass wake up.
> +		} else if (bypass) {
> +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
> +					TPS("WakeBypassIsDeferred"));
> +		}
>  	}
> +
>  	if (rcu_nocb_poll) {
>  		/* Polling, so trace if first poll in the series. */
>  		if (gotcbs)
> @@ -1036,7 +1135,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	 * return false, which means that future calls to rcu_nocb_try_bypass()
>  	 * will refuse to put anything into the bypass.
>  	 */
> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
>  	/*
>  	 * Start with invoking rcu_core() early. This way if the current thread
>  	 * happens to preempt an ongoing call to rcu_core() in the middle,
> @@ -1278,6 +1377,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
>  	raw_spin_lock_init(&rdp->nocb_gp_lock);
>  	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
>  	rcu_cblist_init(&rdp->nocb_bypass);
> +	WRITE_ONCE(rdp->lazy_len, 0);
>  	mutex_init(&rdp->nocb_gp_kthread_mutex);
>  }
>  
> @@ -1558,18 +1658,14 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  {
>  }
>  
> -static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> -{
> -}
> -
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j)
> +				  unsigned long j, bool lazy)
>  {
>  	return true;
>  }
>  
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags)
> +				bool *was_alldone, unsigned long flags, bool lazy)
>  {
>  	return false;
>  }
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
