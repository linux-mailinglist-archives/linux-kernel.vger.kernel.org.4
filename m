Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1362736D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 00:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiKMXSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 18:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiKMXS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 18:18:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA5DD6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 15:18:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668381501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GElb0Q0Spb4WXlQ7HhaogZlg9YgU+muEVwXfBjt/Fn0=;
        b=DsozGNCkHgOuv5fD8ayb+j1qcJiOR9HY1MZFEQNQr4iof8vFTt7L6MXtYqWWOPqTDbWV52
        UscAjtSYDxsUTsGQDoCT4gWIKzrixvgEFE2D5vg/bHzkucp0/C4Gmq7sLKBx+OaN42XT56
        R2bTd2y3SBJhx6MJ/ifnjqqP5r8Fsh+YnC/mDWjw0wZCViQXwr5LhSR6Xy00YgQNnMCD4E
        RNBJExgTz3+6zUKRyuS4pue2BRFAqyxIZzJgmbz4hMxspb1RLHCGZlpvCAYRXHo6frcVjd
        5uzR6Ab1kSTSmjoc56ksVO+ZPbmEo+8MJUCBev1lCes01YCsX8NYqB+Bf6NRhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668381501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GElb0Q0Spb4WXlQ7HhaogZlg9YgU+muEVwXfBjt/Fn0=;
        b=ZWzgVCehYsrjL8a85j1mJrGJr53ogyusZqqEjwZL9imdmPwSAWqkMYb2B654SQ6SF90Lna
        R0pxBOEYEKJMm6Bw==
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <20221110064147.343514404@goodmis.org>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org>
Date:   Mon, 14 Nov 2022 00:18:21 +0100
Message-ID: <875yfitpdu.ffs@tglx>
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
> +static inline int timer_shutdown_sync(struct timer_list *timer)
> +{
> +	return __del_timer_sync(timer, true);
> +}

> +static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
>  {
>  	struct timer_base *base;
>  	unsigned long flags;
> @@ -1285,11 +1281,25 @@ int try_to_del_timer_sync(struct timer_list *timer)
>  
>  	if (base->running_timer != timer)
>  		ret = detach_if_pending(timer, base, true);
> +	if (free)
> +		timer->function = NULL;

Same problem as in the timer_shutdown() case just more subtle:

CPU0                           		CPU1

                                        lock_timer(timer);
                                        base->running_timer = timer;
					fn = timer->function;
					unlock_timer(timer);
					fn(timer) {

__try_to_del_timer_sync(timer, free=true)
    lock_timer(timer);
    if (base->running_timer != timer)
       // Not taken
    if (free)                             mod_timer(timer);
                                            if (WARN_ON_ONCE(!timer->function))
                                               return; // not taken
       timer->function = NULL;
    unlock_timer(timer);
					    lock_timer(timer);
                                            enqueue_timer(timer);
					    unlock_timer(timer);
                                        }

					//timer expires
					lock_timer(timer);
					fn = timer->function;
					unlock_timer(timer);
					fn(timer); <--- NULL pointer dereference

You surely have spent a massive amount of analysis on this!

Can you please explain how you came up with the brilliant idea of asking
Linus to pull this post -rc4 without a review from the timer maintainers
or anyone else who understands concurrency?

If we really want to make this work, then this needs at least a sanity
check of timer->function in the mod/add*_timer() path _after_ locking
the timer.

Though I'm not convinced that this would really be cutting it simply
because the circular dependencies of timer scheduling work and work
arming timer is as demonstrated above not as trivial as you might think.

In the worst case the concurrent code path might still end up in a UAF
as far as I can tell.

But what's worse is that you try to create the illusion that
timer_shutdown_sync() is actually preventing people from shooting
themself into their feet.

As implemented right now it's just a bandaid which makes it less likely,
but does neither prevent any of the hard to debug shutdown issues nor
the resulting holes in peoples feets.

Thanks,

        tglx








