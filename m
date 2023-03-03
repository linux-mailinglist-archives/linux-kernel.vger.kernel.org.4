Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129986A9E30
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjCCSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjCCSLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:11:37 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623ED13D5B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:11:36 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id jo29so2373217qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677867095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIqYWARmeAB73vFJjEiepAwpm059DAqBCk0QnUuhxsI=;
        b=pa1++eeFbM0l48iTBSVKGnBlQZgwPqF2SnZry7jXywWo8U2t/KLhENBQbiFVoMyWDE
         rM+8MDXXWrpoHGFhn9hF/mx36qsmoBw1T7XQ6JyyNK2aU8Co2pNlGALho19GDNLLURFz
         ID2jLQI0Fy3IDL790hXk/vRroFaodEwy06J/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIqYWARmeAB73vFJjEiepAwpm059DAqBCk0QnUuhxsI=;
        b=rKoVWOOhTRb7L0QJ9qVqEAnkw2Kp2z3KRg89yoKThWRpLxL0zNVgj8Ycy95FyO5KIO
         sNZslPmLBV8ji3oo0PtNd6SZ0GNz0Wvf1gzTXWt4+rn4Uiq+KHsQaMKbAXF2X6rdhEJy
         hg2O808+yAEPXTJeBeixmci4YvUC8CIyvDQoixC9yClK/ERAwC8mFUw0NTgwgfe9yyKk
         igIG3pVLGawuwSrQyoC8ElZV7t/mlacmg3J1nd43Gk9PVhSX5IBdhU+lJ1rzIesLrYdo
         6pS/9lJFgs471HbT11YYdIPjX5Bj+w+eI/fHj/JOam7M9Ljf4RsYfLDyJdTtBQKMfAUh
         YG5Q==
X-Gm-Message-State: AO0yUKXZWC/HqwTshJwKPQi75n/DgVnCuk399w4+KyyrYjqQ7KQGphxZ
        c/iQZRSNJJmJvuGRjFEfXEmgGA==
X-Google-Smtp-Source: AK7set+FbOma0se6R6RBXWULU4tyYEKgyTFUc1cOtP2fz6E/O7ymkmuY4c76/ZQ+fHxDsyR+iezWMg==
X-Received: by 2002:a05:6214:4118:b0:56c:13cc:d21f with SMTP id kc24-20020a056214411800b0056c13ccd21fmr3306876qvb.50.1677867095412;
        Fri, 03 Mar 2023 10:11:35 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id a191-20020ae9e8c8000000b00742743dba2asm2156338qkg.39.2023.03.03.10.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 10:11:34 -0800 (PST)
Date:   Fri, 3 Mar 2023 18:11:34 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230303181134.GA1837196@google.com>
References: <20230302062741.483079-1-jstultz@google.com>
 <20230302082414.77613351@gandalf.local.home>
 <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home>
 <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home>
 <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302200136.381468f0@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On Thu, Mar 02, 2023 at 08:01:36PM -0500, Steven Rostedt wrote:
> On Thu, 2 Mar 2023 16:56:13 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Knowing that rcu_read_lock() keeps the tasks safe, I made the optimization
> > to only grab the spinlock (and disable interrupts) once, or whenever the
> > top waiter changes.
> 
> v3 as I found that there were too places to test for top waiter that had to
> be removed:

Nice patch!!! One question below:

> (I took out the trace_printk() here).
> 
> -- Steve
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 010cf4e6d0b8..283dd8e654ef 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1399,8 +1399,12 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
>  				  struct rt_mutex_waiter *waiter,
>  				  struct task_struct *owner)
>  {
> +	struct rt_mutex_waiter *top_waiter;
> +	struct rt_mutex_waiter *last_waiter = NULL;
> +	struct task_struct *top_task = NULL;
>  	bool res = true;
>  
> +	/* rcu_read_lock keeps task_structs around */
>  	rcu_read_lock();
>  	for (;;) {
>  		/* If owner changed, trylock again. */
> @@ -1421,11 +1425,23 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
>  		 *    for CONFIG_PREEMPT_RCU=y)
>  		 *  - the VCPU on which owner runs is preempted
>  		 */
> -		if (!owner_on_cpu(owner) || need_resched() ||
> -		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
> +		if (!owner_on_cpu(owner) || need_resched()) {
>  			res = false;
>  			break;
>  		}
> +		top_waiter = rt_mutex_top_waiter(lock);
> +		if (top_waiter != waiter) {
> +			if (top_waiter != last_waiter) {
> +				raw_spin_lock_irq(&lock->wait_lock);
> +				last_waiter = rt_mutex_top_waiter(lock);
> +				top_task = last_waiter->task;
> +				raw_spin_unlock_irq(&lock->wait_lock);
> +			}
> +			if (!owner_on_cpu(top_task)) {
> +				res = false;
> +				break;
> +			}
> +		}

In the normal mutex's adaptive spinning, there is no check for if there is a
change in waiter AFAICS (ignoring ww mutex stuff for a second).

I can see one may want to do that waiter-check, as spinning
indefinitely if the lock owner is on the CPU for too long may result in
excessing power burn. But normal mutex does not seem to do that.

What  makes the rtmutex spin logic different from normal mutex in this
scenario, so that rtmutex wants to do that but normal ones dont?

Another thought is, I am wondering if all of them spinning indefinitely might
be Ok for rtmutex as well, since as you mentioned, preemption is enabled. So
adding the if (top_waiter != last_waiter) {...} might be unnecessary? In fact
may be even harmful as you are disabling interrupts in the process.

Either way, I think a comment should go on top of the "if (top_waiter !=
waiter)" check IMO.

thanks,

 - Joel



>  		cpu_relax();
>  	}
>  	rcu_read_unlock();
> @@ -1547,10 +1563,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
>  				break;
>  		}
>  
> -		if (waiter == rt_mutex_top_waiter(lock))
> -			owner = rt_mutex_owner(lock);
> -		else
> -			owner = NULL;
> +		owner = rt_mutex_owner(lock);
>  		raw_spin_unlock_irq(&lock->wait_lock);
>  
>  		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
> @@ -1736,10 +1749,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
>  		if (try_to_take_rt_mutex(lock, current, &waiter))
>  			break;
>  
> -		if (&waiter == rt_mutex_top_waiter(lock))
> -			owner = rt_mutex_owner(lock);
> -		else
> -			owner = NULL;
> +		owner = rt_mutex_owner(lock);
>  		raw_spin_unlock_irq(&lock->wait_lock);
>  
>  		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
