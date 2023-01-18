Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6305672137
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjARP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjARP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:27:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5C17298;
        Wed, 18 Jan 2023 07:26:01 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:25:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674055558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkBdwCC72vnFXKz7wAyBwaI38/pVFTFiaN/Bh+nVBec=;
        b=0zN9/jm9ajNMr+mXoKrxvbTMD1MMQw2XozYf/rTD5Rd38p/D5vt982AvYA1EGF0zFjF3Zz
        U44RC2U/oKbyDxKdxdkYPnRP6xOlyI4S6Z9+lO+et/NO6ggLq4K8CIdDsv2MAB8Kf+rd0M
        IJnJfwjlkCl6U7rZwCe4GdhSMVTSqv2gtqYe2HAgUXp770vUvpoqyRdBtyYgFeaiowgbbc
        Kbo0IyIrR4OEPFGwvS5eCUK3mmISlbHdx/einy6lkmXTCVDgLZQYpN0PXhml9lnpIcjHLN
        FzWflrNs3w1GeZGYrFweVTD0+7JBuw4dvyUWnya2mdFPy4+E+YQqa3ZeE7+ORw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674055558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkBdwCC72vnFXKz7wAyBwaI38/pVFTFiaN/Bh+nVBec=;
        b=xYvHBkcXAL87G9vS7nzryaX9fr+1OJLj2dwhyt1g2IyitBFq+Fh0Q+ACn2B2bADJCgsf5r
        pyFqbuoQ6I0iA9Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8gPhTGkfCbGwoUu@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-17 16:50:21 [+0000], Mel Gorman wrote:

> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index c201aadb9301..99d81e8d1f25 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -65,6 +69,64 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
>  	return 0;
>  }
>  
> +/*
> + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
> + * This matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.
> + * The granularity is not exact as the lowest bit in rwbase_rt->waiter_timeout
> + * is used to detect recent DL / RT tasks taking a read lock.
> + */
> +#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
> +
> +static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
> +{
> +	/* No update required if DL / RT tasks already identified. */
> +	if (rwb->waiter_timeout & 1)
> +		return;
> +
> +	/*
> +	 * Record a DL / RT task acquiring the lock for read. This may result
> +	 * in indefinite writer starvation but DL / RT tasks should avoid such
> +	 * behaviour.
> +	 */
> +	if (rt_task(current)) {
> +		struct rt_mutex_base *rtm = &rwb->rtmutex;
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> +		rwb->waiter_timeout |= 1;

Let me see of I parsed the whole logic right:

_After_ the RT reader acquired the lock, the lowest bit is set. This may
be immediately if the timeout did not occur yet.
With this flag set, all following reader incl. SCHED_OTHER will acquire
the lock.

If so, then I don't know why this is a good idea.

If _only_ the RT reader is allowed to acquire the lock while the writer
is waiting then it make sense to prefer the RT tasks. (So the check is
on current and not on the lowest bit).
All other (SCHED_OTHER) reader would have to block on the rtmutex after
the timeout. This makes sense to avoid the starvation.

If we drop that "we prefer the RT reader" then it would block on the
RTmutex. It will _still_ be preferred over the writer because it will be
enqueued before the writer in the queue due to its RT priority. The only
downside is that it has to wait until all readers are left.
So by allowing the RT reader to always acquire the lock as long as the
WRITER_BIAS isn't set, we would allow to enter early while the other
reader are still in and after the timeout you would only have RT reader
going in and out. All SCHED_OTHER reader block on the RTmutex.

I think I like this.


> +		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> +	}
> +}
> +

Sebastian
