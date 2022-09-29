Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC25EF9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiI2QFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiI2QFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:05:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7513F73D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:05:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id e20so912515qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/pJRNSV0HIheH8OrivaNHUmRgbgz5qcY3liUI4XTQgs=;
        b=bIHFkn4ngRG9v2bNg6tu6tRSEUonb1cxJ2fTLcvmmPzoz7LQrQtobEos02MtVuDeIT
         Dt3vA5GRksU80+2LvWrfPDbq5+m7arSGVcI6bukICsueKOoMHGvHt77YReu0Zpq5GzBL
         MACXvRl0GvjJimrRIerjjVZyeznaWu5e3RAOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/pJRNSV0HIheH8OrivaNHUmRgbgz5qcY3liUI4XTQgs=;
        b=mee55qAqTuJKSKu500KuBp4vnrLFQnENoatn3PBCiSziu+B8NhnGSJv40324t/5Dmw
         orwadYyV7DqpLxx+MaZ9Y0tybewsbCEQX+wO/C3kErf+WP0qc195vijvgkAuQrvOulOp
         d6SwUdbzFN7KTxmJXMWIU0//ZJ5c9Lu66EqLMAubTRNdpkYS7lvks7SQymALb546MMSt
         9eOBc8TUUlmPOlkcTmRv5XQ2RVmIwrRjjT/UxVJq6rOSKY12Z1IGdJrVILGZF8dIkARM
         kbnDzpxGTZ0IPQ0c6037UD+V/rLmkr7OF1x3nIMVabaVApSgo80NX/rdjzxw4v+ZGacq
         ZNCA==
X-Gm-Message-State: ACrzQf05Nn2M0QrXkCUjd+Ka0qMa1vuaFsh3xakddVro3AqNQckzlp2K
        hj4M672cs3itgmrW8SEuF3xKPI7IxwzOtVCc
X-Google-Smtp-Source: AMsMyM45eYbXBXmqaFEIR/IgJFFxLSz7KdSIw3yvJqkyvmnjamJ6CjNtSsAb6RB9zPjGRfpVSQb4yA==
X-Received: by 2002:ac8:5c01:0:b0:35c:d08b:25b with SMTP id i1-20020ac85c01000000b0035cd08b025bmr3009518qti.311.1664467548214;
        Thu, 29 Sep 2022 09:05:48 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b006ce441816e0sm6686095qko.15.2022.09.29.09.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:05:47 -0700 (PDT)
Message-ID: <809045ca-0adc-9ec2-af5b-03d68ff34c2b@joelfernandes.org>
Date:   Thu, 29 Sep 2022 12:05:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: RCU vs NOHZ
Content-Language: en-US
To:     paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
 <20220929154618.GA2864141@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220929154618.GA2864141@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2022 11:46 AM, Paul E. McKenney wrote:
> On Thu, Sep 29, 2022 at 08:20:44AM -0700, Paul E. McKenney wrote:
>> On Thu, Sep 29, 2022 at 12:55:58PM +0200, Peter Zijlstra wrote:
>>> On Sat, Sep 17, 2022 at 07:25:08AM -0700, Paul E. McKenney wro
[..]
>>>> And this of course means that any additional schemes to reduce RCU's
>>>> power consumption must be compared (with real measurements on real
>>>> hardware!) to Joel et al.'s work, whether in combination or as an
>>>> alternative.  And either way, the power savings must of course justify
>>>> the added code and complexity.
>>>
>>> Well, Joel's lazy scheme has the difficulty that you can wreck things by
>>> improperly marking the callback as lazy when there's an explicit
>>> dependency on it. The talk even called that out.
>>>
>>> I was hoping to construct a scheme that doesn't need the whole lazy
>>> approach.

Peter, when constructing such scheme, please do consider that the power savings
needs to be comparable to power testing done with large jiffies_till_first_fqs
values. Otherwise, such solution is 'not that good' (IMO). In other words, the
ideal savings is one you get when not having to ask for RCU's services too soon
(rather than optimizing RCU itself).  Of course, the tick being turned off also
could/should be optimized for when you do need RCU's services.

> I agree that this is a risk that must be addressed.

Right, it is encouraging to see that we're making good progress on this. And
also Thomas mentioned in LPC that if call_rcu() users are expecting time-bounded
callback invocation, then _that_ needs to be fixed.

thanks,

 - Joel


> 
>>> To recap; we want the CPU to go into deeper idle states, no?
>>>
>>> RCU can currently inhibit this by having callbacks pending for this CPU
>>> -- in this case RCU inhibits NOHZ-IDLE and deep power states are not
>>> selected or less effective.
>>>
>>> Now, deep idle states actually purge the caches, so cache locality
>>> cannot be an argument to keep the callbacks local.
>>>
>>> We know when we're doing deep idle we stop the tick.
>>>
>>> So why not, when stopping the tick, move the RCU pending crud elsewhere
>>> and let the CPU get on with going idle instead of inhibiting the
>>> stopping of the tick and wrecking deep idle?
>>
>> Because doing so in the past has cost more energy than is saved.
> 
> And I should hasten to add that I have no intention of sending this
> commit upstream unless/until it is demonstrated to save real energy on
> real hardware.  In the meantime, please see below for an updated version
> that avoids indefinitely postponing the tick on systems having CPUs that
> enter and exit idle frequently.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit e30960e87d58db50bbe4fd09a2ff1e5eeeaad754
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Sep 21 13:30:24 2022 -0700
> 
>     rcu: Let non-offloaded idle CPUs with callbacks defer tick
>     
>     When a CPU goes idle, rcu_needs_cpu() is invoked to determine whether or
>     not RCU needs the scheduler-clock tick to keep interrupting.  Right now,
>     RCU keeps the tick on for a given idle CPU if there are any non-offloaded
>     callbacks queued on that CPU.
>     
>     But if all of these callbacks are waiting for a grace period to finish,
>     there is no point in scheduling a tick before that grace period has any
>     reasonable chance of completing.  This commit therefore delays the tick
>     in the case where all the callbacks are waiting for a specific grace
>     period to elapse.  In theory, this should result in a 50-70% reduction in
>     RCU-induced scheduling-clock ticks on mostly-idle CPUs.  In practice, TBD.
>     /bin/bash: fm: command not found
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 9bc025aa79a3..84e930c11065 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -133,7 +133,7 @@ static inline void rcu_softirq_qs(void)
>  		rcu_tasks_qs(current, (preempt)); \
>  	} while (0)
>  
> -static inline int rcu_needs_cpu(void)
> +static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 70795386b9ff..3066e0975022 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -19,7 +19,7 @@
>  
>  void rcu_softirq_qs(void);
>  void rcu_note_context_switch(bool preempt);
> -int rcu_needs_cpu(void);
> +int rcu_needs_cpu(u64 basemono, u64 *nextevt);
>  void rcu_cpu_stall_reset(void);
>  
>  /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..1930cee1ccdb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -676,12 +676,40 @@ void __rcu_irq_enter_check_tick(void)
>   * scheduler-clock interrupt.
>   *
>   * Just check whether or not this CPU has non-offloaded RCU callbacks
> - * queued.
> + * queued that need immediate attention.
>   */
> -int rcu_needs_cpu(void)
> +int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>  {
> -	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
> -		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
> +	unsigned long j;
> +	unsigned long jlast;
> +	unsigned long jwait;
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +	struct rcu_segcblist *rsclp = &rdp->cblist;
> +
> +	// Disabled, empty, or offloaded means nothing to do.
> +	if (!rcu_segcblist_is_enabled(rsclp) ||
> +	    rcu_segcblist_empty(rsclp) || rcu_rdp_is_offloaded(rdp)) {
> +		*nextevt = KTIME_MAX;
> +		return 0;
> +	}
> +
> +	// Callbacks ready to invoke or that have not already been
> +	// assigned a grace period need immediate attention.
> +	if (!rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ||
> +	    !rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL))
> +		return 1;
> +
> +	// There are callbacks waiting for some later grace period.
> +	// Wait for about a grace period or two since the last tick, at which
> +	// point there is high probability that this CPU will need to do some
> +	// work for RCU.
> +	j = jiffies;
> +	jlast = __this_cpu_read(rcu_data.last_sched_clock);
> +	jwait = READ_ONCE(jiffies_till_first_fqs) + READ_ONCE(jiffies_till_next_fqs) + 1;
> +	if (time_after(j, jlast + jwait))
> +		return 1;
> +	*nextevt = basemono + TICK_NSEC * (jlast + jwait - j);
> +	return 0;
>  }
>  
>  /*
> @@ -2324,11 +2352,9 @@ void rcu_sched_clock_irq(int user)
>  {
>  	unsigned long j;
>  
> -	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
> -		j = jiffies;
> -		WARN_ON_ONCE(time_before(j, __this_cpu_read(rcu_data.last_sched_clock)));
> -		__this_cpu_write(rcu_data.last_sched_clock, j);
> -	}
> +	j = jiffies;
> +	WARN_ON_ONCE(time_before(j, __this_cpu_read(rcu_data.last_sched_clock)));
> +	__this_cpu_write(rcu_data.last_sched_clock, j);
>  	trace_rcu_utilization(TPS("Start scheduler-tick"));
>  	lockdep_assert_irqs_disabled();
>  	raw_cpu_inc(rcu_data.ticks_this_gp);
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index b0e3c9205946..303ea15cdb96 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -784,7 +784,7 @@ static inline bool local_timer_softirq_pending(void)
>  
>  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  {
> -	u64 basemono, next_tick, delta, expires;
> +	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
>  	unsigned long basejiff;
>  	unsigned int seq;
>  
> @@ -807,7 +807,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  	 * minimal delta which brings us back to this place
>  	 * immediately. Lather, rinse and repeat...
>  	 */
> -	if (rcu_needs_cpu() || arch_needs_cpu() ||
> +	if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
>  	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
>  		next_tick = basemono + TICK_NSEC;
>  	} else {
> @@ -818,8 +818,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  		 * disabled this also looks at the next expiring
>  		 * hrtimer.
>  		 */
> -		next_tick = get_next_timer_interrupt(basejiff, basemono);
> -		ts->next_timer = next_tick;
> +		next_tmr = get_next_timer_interrupt(basejiff, basemono);
> +		ts->next_timer = next_tmr;
> +		/* Take the next rcu event into account */
> +		next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
>  	}
>  
>  	/*
