Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9916272DB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 23:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiKMWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 17:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 17:20:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70EE0C8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 14:20:33 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668378032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFuhDtI5E596clgtvdQHNPXYyvIgW5iwp/YHGywCpts=;
        b=byDq0bIQ9u99fuRPJlc3gY02GidmLCRGFnohb1gpX50S9n8MyXhwrwRzaWEeUBxsCKyufT
        BeJRStFWEmi6+Ix/CR5afdF8d/UfgE3Mvv72+mHs01erjoCCMuBjvO3h9UPthUVXpt1GjY
        MEgho1g+ucfG33Y2OG3DaGmGkLRlDNpzFs1LWMiI2e71wHLww1wGuuGv/AYxGEDY98Vg/P
        TJFn8bUlmD4aHh2x9+69M08ceMf62boRvO0UeB6T1NpRavVSoV5ie1+sDFDmkj1CfoLkYR
        gjIieybtiWZDc88J9l8fMJb2GG2T+XlTCb8x5xClKewh5+FVHSLoxT7Z5aeRdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668378032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFuhDtI5E596clgtvdQHNPXYyvIgW5iwp/YHGywCpts=;
        b=f3eZRMahdQyVAO1pbGBZ1MOZg9Ps/OpJJ7MyT7JJwt9mR9RfQVi6G8FHxgQDP0UgRZBhGL
        MmMCD1hhKAZzDjCQ==
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 5/6] timers: Add timer_shutdown() to be called before
 freeing timers
In-Reply-To: <20221110064147.529154710@goodmis.org>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.529154710@goodmis.org>
Date:   Sun, 13 Nov 2022 23:20:31 +0100
Message-ID: <87a64uts28.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2022 at 01:41, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

$Subject: !!@*&^*&^@!

> Before a timer is to be freed, it must be shutdown. But there are some
> locations were timer_shutdown_sync() can not be called due to the context
> the object that holds the timer is in when it is freed.

locations? This is not about locations, it's about contexts. And please
provide a proper example for such a context.

> For cases where the logic should keep the timer from being re-armed but
> still needs to be shutdown with a sync, a new API of timer_shutdown() is
> available.

"Needs to shutdown with a sync"? "is available"? Try again with
comprehensible explanations.

> This is the same as del_timer() except that after it is called, the
> timer can not be re-armed. If it is, a WARN_ON_ONCE() will be
> triggered.
>
> The implementation of timer_shutdown() follows the timer_shutdown_sync()
> method of using the same code as del_timer() but will pass in a boolean
> that the timer is about to be freed, in which case the timer->function is
> set to NULL, just like timer_shutdown_sync().

That's complete useless information for a changelog. We can see that
from the patch itself, no?

Changelogs are about context and the problem the patch tries to solve,
not about implementation details.

> +/**
> + * del_timer - deactivate a timer.
> + * @timer: the timer to be deactivated

See previous comments about uppercase.

> + * del_timer() deactivates a timer - this works on both active and inactive
> + * timers.

How so? What "works"? What's the work done on an inactive timer? Also
this lacks documentation that this function is fundamentally racy
against a concurrent rearm.

> + * The function returns whether it has deactivated a pending timer or not.
> + * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
> + * active timer returns 1.)

See previous comment about return value documentation.

> + */
> +static inline int del_timer(struct timer_list *timer)
> +{
> +	return __del_timer(timer, false);
> +}
> +
> +/**
> + * timer_shutdown - deactivate a timer and shut it down
> + * @timer: the timer to be deactivated
> + *
> + * timer_shutdown() deactivates a timer - this works on both active
> + * and inactive timers, and will prevent it from being rearmed.

This needs some further explanation especially vs. the function pointer
being set to NULL. Which means that in case that the timer is not freed
and reused later on it needs to be initialized again. Which is btw
lacking from timer_shutdown_sync() too.

> + * The function returns whether it has deactivated a pending timer or not.
> + * (ie. timer_shutdown() of an inactive timer returns 0,
> + *   timer_shutdown() of an active timer returns 1.)
> + */
> +static inline int timer_shutdown(struct timer_list *timer)
> +{
> +	return __del_timer(timer, true);
> +}
> +
>  /*
>   * The jiffies value which is added to now, when there is no timer
>   * in the timer wheel:
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 111a3550b3f2..7c224766065e 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1240,18 +1240,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
>  }
>  EXPORT_SYMBOL_GPL(add_timer_on);
>  
> -/**
> - * del_timer - deactivate a timer.
> - * @timer: the timer to be deactivated
> - *
> - * del_timer() deactivates a timer - this works on both active and inactive
> - * timers.
> - *
> - * The function returns whether it has deactivated a pending timer or not.
> - * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
> - * active timer returns 1.)
> - */

Instead of blurbing about invoking __del_timer() with free=true in the
changelog you could have kept the kernel doc here and/or added some
useful comment to the code below.

But...

> -int del_timer(struct timer_list *timer)
> +int __del_timer(struct timer_list *timer, bool free)
>  {
>  	struct timer_base *base;
>  	unsigned long flags;
> @@ -1262,12 +1251,18 @@ int del_timer(struct timer_list *timer)
>  	if (timer_pending(timer)) {
>  		base = lock_timer_base(timer, &flags);
>  		ret = detach_if_pending(timer, base, true);
> +		if (free)
> +			timer->function = NULL;
> +		raw_spin_unlock_irqrestore(&base->lock, flags);
> +	} else if (free) {
> +		base = lock_timer_base(timer, &flags);
> +		timer->function = NULL;
>  		raw_spin_unlock_irqrestore(&base->lock, flags);
>  	}

... this function is a concurrency disaster:

CPU0                           		CPU1

timer_shutdown(timer)
  __del_timer(timer, free=true)
    // timer is not pending
    ....
    } else if (free)                    mod_timer()
                                          lock_timer(timer);
      lock_timer(timer)                   enqueue_timer(timer);
                                          unlock_timer(timer);
      timer->function = NULL;
      unlock_timer(timer);
                                        //timer expires
                                        lock_timer(timer);
                                        fn = timer->function;
                                        unlock_timer(timer);
                                        fn(timer); <--- NULL pointer dereference

So you "solve" the existing problem by introducing one which is even
more horrible to debug, right?

Let me go back to the timer_shutdown_sync() variant and figure out
whether that one is at least not borked in the same way.

Thanks,

        tglx
