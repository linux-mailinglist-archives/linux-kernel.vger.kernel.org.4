Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8651D69D759
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjBTXzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjBTXzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:55:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7D20D35;
        Mon, 20 Feb 2023 15:55:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676937334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZQezCgdD0D+uTwi8vQExA2xupF4S/Y7SBoqChxjpyY=;
        b=S7YzGxtw8dhSuWGrI1DzfQ3ZLhXgknk4qBTCrwFwwOTtHmNDV86hYFpIjP2O5VTLj2/Ai/
        Us+BQd3A+RZYFUBQdNXawr2t0AHgnJ7FAxRHNzxnKszAY3tzcy6LMKe/WzCiKPa3cepwlp
        SebPe1+B0F/oSWaqshQFQB4gMBnw7V7/kdvFydd/ddKftRnouQCJNq22BFYT3rz1KCMCT9
        Mr8Ky5au2pD1Afim4LVHgkfDqNmQHyU5T/RxgCXJWqRfQxZUZMripO3xJRppYoWgxGMuPq
        9BbC2CVyx7zrdM5YeKgUM4RcopKdYXBXVK5Hjx2dfdyK+4KrsEY2bQ7yeREEgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676937334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZQezCgdD0D+uTwi8vQExA2xupF4S/Y7SBoqChxjpyY=;
        b=n5ShpAR5q4MrUmDc7Z3BCgXsWMHpihYiY9Ab1RS7VlJCwGRAzjVvkGih2Rcttg/iZpshsK
        JwUGXUTza6WUDnDg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] locking/rwbase: Mitigate indefinite writer starvation
In-Reply-To: <Y+0W0wgyaJqYHKoj@linutronix.de>
References: <Y+0W0wgyaJqYHKoj@linutronix.de>
Date:   Tue, 21 Feb 2023 00:55:33 +0100
Message-ID: <877cwbq4cq.ffs@tglx>
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

On Wed, Feb 15 2023 at 18:30, Sebastian Andrzej Siewior wrote:
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 1d264dd086250..b969b1d9bb85c 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -10,12 +10,14 @@
>  
>  struct rwbase_rt {
>  	atomic_t		readers;
> +	unsigned long		waiter_timeout;

I'm still not convinced that this timeout has any value and if it has
then it should be clearly named writer_timeout because that's what it is
about.

The only reason for this timeout I saw so far is:

> +/*
> + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick. This
> + * matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.

Clearly RT and !RT have completely different implementations and
behaviour vs. rwsems and rwlocks. Just because !RT has a timeout does
not make a good argument.

Just for the record: !RT has the timeout applicable in both directions
to prevent writer bias via lock stealing. That's not a problem for RT
because?

Can we finally get a proper justification for this?

> @@ -264,12 +285,20 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  		if (__rwbase_write_trylock(rwb))
>  			break;
>  
> +		/*
> +		 * Record timeout when reader bias is ignored. Ensure timeout
> +		 * is at least 1 in case of overflow.
> +		 */
> +		rwb->waiter_timeout = (jiffies + RWBASE_RT_WAIT_TIMEOUT) | 1;
> +

So this has two sillies:

   1) It resets the timeout once per loop which is plain wrong

   2) The "| 1" is really a sloppy hack

Why not doing the obvious:

static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
{
	int r = atomic_read(&rwb->readers);

        if (likely(r < 0))
        	return true;

        if (r == WRITER_BIAS)
        	return false;

	/* Allow reader bias unless the writer timeout has expired. */
	return time_before(jiffies, rwb->writer_timeout);
}

and with that the "| 1" and all the rwb->timeout = 0 nonsense simply
goes away and rwbase_read_lock() becomes:

	if (rwbase_allow_reader_bias(rwb)) {
		// fastpath
		atomic_inc(&rwb->readers);
		raw_spin_unlock_irq(&rtm->wait_lock);
		return 0;
	}
        // slowpath

and the writelock slowpath has:

	rwb->writer_timeout = jiffies + RWBASE_RT_WAIT_TIMEOUT;

	for (;;) {
        	....

No?

Thanks,

        tglx

