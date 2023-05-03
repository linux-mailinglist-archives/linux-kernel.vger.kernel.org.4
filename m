Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB766F58EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjECNVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjECNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:21:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80E844B8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2AtfVu6ZSWVhTUV8did4/bV3HvDosqSFhERrkFQ/sbU=; b=f2Pk9hkWZ1ctWN6fxIglRt5+iF
        1EeZYLZJ2mZaILD9O3V3VxvVjfwsBmSgiRoMR0DkIu0TGdZ/Raj+02glBZ2Haoe1JZQrxoRodnYOV
        xjGawFWDPCn9eqBCdiBZTRI+HzT4HR1qyrvWnMlMuhKhuAACGcSfNFgWuCVegU1OvQwaGRrKVy5UU
        SxnAToLhH29q5RWwlt5DgO+UwP+JyQJsK6NJmEawZUYejS7OQliHL7YDZx9V79SFzJ+QlQs1FxOTM
        S8l8BdWEC/nEH/5zllqP9WkQzdnCJezOXjyUeEPDZU1rBpekJsgNMxL+BuzOsQ3t5f7kvJIvmI9FG
        UE3P47aw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puCPf-0006TX-0L;
        Wed, 03 May 2023 13:20:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F211305F38;
        Wed,  3 May 2023 15:20:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D027726232149; Wed,  3 May 2023 15:20:51 +0200 (CEST)
Date:   Wed, 3 May 2023 15:20:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
 <20230427111937.2745231-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427111937.2745231-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 01:19:34PM +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> schedule() invokes sched_submit_work() before scheduling and
> sched_update_worker() afterwards to ensure that queued block requests are
> flushed and the (IO)worker machineries can instantiate new workers if
> required. This avoids deadlocks and starvation.
> 
> With rt_mutexes this can lead to subtle problem:
> 
>   When rtmutex blocks current::pi_blocked_on points to the rtmutex it
>   blocks on. When one of the functions in sched_submit/resume_work()
>   contends on a rtmutex based lock then that would corrupt
>   current::pi_blocked_on.
> 
> Make it possible to let rtmutex issue the calls outside of the slowpath,
> i.e. when it is guaranteed that current::pi_blocked_on is NULL, by:
> 
>   - Exposing sched_submit_work() and moving the task_running() condition
>     into schedule()
> 
>   - Renamimg sched_update_worker() to sched_resume_work() and exposing it
>     too.
> 
>   - Providing sched_rtmutex() which just does the inner loop of scheduling
>     until need_resched() is not longer set. Split out the loop so this does
>     not create yet another copy.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Urgh, so I really don't like this.

The end result is something like:

	rt_mutex_lock()
	  sched_submit_work();
	    // a nested rt_mutex_lock() here will not clobber
	    // ->pi_blocked_on because it's not set yet.

	  task_blocks_on_rt_mutex();
	    tsk->pi_blocked_on = waiter;
	    rt_mutex_enqueue(lock, waiter); <-- the real problem

	  rt_mutex_slowlock_block();
	    schedule_rtmutex();

	  sched_resume_work();

And all of this it not just because tsk->pi_blocked_on, but mostly
because of task_blocks_on_rt_mutex() enqueueing the waiter. The whole
enqueue thing is what makes the 'simple' solution of saving/restoring
tsk->pi_blocked_on not work.

Basically the pi_blocked_on curruption is a side effect, not the
fundamental issue. One task having two waiters registered is the bigger
issue.

Now, sched_submit_work() could also use (regular) mutex -- after all
it's a fully preemptible context. And then we're subject to the 'same'
problem but with tsk->blocked_on (DEBUG_MUTEXES=y).

This means that strictly speaking we should litter mutex with the same
thing :/

This all feels fragile to me. Too many things spread out in too many
places. An alternative is something like:

void __sched schedule_pi(void)
{
	struct task_struct *tsk = current;
	void *waiter = tsk->pi_blocked_on;

	sched_submit_work(tsk);
	do {
		preempt_disable();
		if (rt_mutex_blocks(tsk, waiter))
			schedule();
		sched_preempt_enable_no_resched();
	} while (need_resched());
	sched_update_worker(tsk);
}

And then rt_mutex_blocks() will do the enqueue/boost/optimistic_spin
thing. However, this is going to be a massive reorg of the rt_mutex code
and I'm not entirely sure the end result will actually be better... it
might just make a mess elsewhere :/

> +void sched_submit_work(void)
>  {
> -	unsigned int task_flags;
> +	struct task_struct *tsk = current;
> +	unsigned int task_flags = tsk->flags;
>  
> -	if (task_is_running(tsk))
> -		return;
> -
> -	task_flags = tsk->flags;
>  	/*
>  	 * If a worker goes to sleep, notify and ask workqueue whether it
>  	 * wants to wake up a task to maintain concurrency.
> @@ -6723,8 +6720,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
>  	blk_flush_plug(tsk->plug, true);
>  }

> +asmlinkage __visible void __sched schedule(void)
> +{
> +	if (!task_is_running(current))
> +		sched_submit_work();
> +	schedule_loop(SM_NONE);
> +	sched_resume_work();
>  }
>  EXPORT_SYMBOL(schedule);

pulling out task_is_running() like this is going to get into conflict
with TJs patches here:

  https://lkml.kernel.org/r/20230418205159.724789-1-tj@kernel.org

That makes sched_submit_work() do things even if task_is_running().
