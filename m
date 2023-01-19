Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9D6733A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjASI0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjASI0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:26:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBA3677BD;
        Thu, 19 Jan 2023 00:26:01 -0800 (PST)
Date:   Thu, 19 Jan 2023 09:25:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674116757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UL5oma6ejlLF3N+uLlDTWSEseczx97uBZC0GZjrlM6k=;
        b=3heCkZOhJTEFLLsQfzuQw1rsg0gkYuGSZcBGSYZrizUeXhblr1QlTKX4l3gAoEZTaOXBLj
        +oy9RwlB0k1x2vhGJVHJNFyl+Jyyo3ILaceodBn3QE78poDYoBHDRzpRoVxZGuP6fyh1Fr
        U2wZttowTwnmEx3PdMIp/pZ66gmIcdaGNfWbv7Uk28BGhhoIjonCqXlE9WkULC10JdWMKO
        fCxgG2MzSsNdYMVzFcUygOffdNb4wRFW0QRsLbaBsrFaY8Jp5CAUloF4hc/sBEVO9MW4aK
        PraAyUcbEa6Vr5AAIy7Hc3X3DlAQppPLkRrud/WV8Rxqf7fTfl//3ND5r1aOlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674116757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UL5oma6ejlLF3N+uLlDTWSEseczx97uBZC0GZjrlM6k=;
        b=lPxErHMuXBykY/ZAX21XfN/w1l/K9BFSybPlBcs0f7C3msLY1H0OlZyIPTY4uorB80wRrj
        3ZF1qAsBFvXycQDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8j+lENBWNWgt4mf@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-18 17:31:30 [+0000], Mel Gorman wrote:
 > If we drop that "we prefer the RT reader" then it would block on the
> > RTmutex. It will _still_ be preferred over the writer because it will be
> > enqueued before the writer in the queue due to its RT priority. The only
> > downside is that it has to wait until all readers are left.
>=20
> The writer has to wait until all the readers have left anyway.

I meant the READER in case it has RT priority. It will enqueue itself on
the RTmutex, first in line, and wait until all other READER leave.

> If I understand you correctly, the patch becomes this;

exactly.

> --8<--
=E2=80=A6
> This patch records a timestamp when the first writer is blocked. DT /

s/DT/DL

> RT tasks can continue to take the lock for read as long as readers exist
> indefinitely. Other readers can acquire the read lock unless a writer
> has been blocked for a minimum of 4ms. This is sufficient to allow the
> dio_truncate test case to complete within the 30 minutes timeout.
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
=E2=80=A6
> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index c201aadb9301..84c5e4e4d25b 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -74,9 +106,11 @@ static int __sched __rwbase_read_lock(struct rwbase_r=
t *rwb,
>  	raw_spin_lock_irq(&rtm->wait_lock);
>  	/*
>  	 * Allow readers, as long as the writer has not completely
> -	 * acquired the semaphore for write.
> +	 * acquired the semaphore for write and reader bias is still
> +	 * allowed.
>  	 */
> -	if (atomic_read(&rwb->readers) !=3D WRITER_BIAS) {
> +	if (atomic_read(&rwb->readers) !=3D WRITER_BIAS &&
> +	    rwbase_allow_reader_bias(rwb)) {
>  		atomic_inc(&rwb->readers);
>  		raw_spin_unlock_irq(&rtm->wait_lock);
>  		return 0;
> @@ -264,12 +298,17 @@ static int __sched rwbase_write_lock(struct rwbase_=
rt *rwb,
>  		if (__rwbase_write_trylock(rwb))
>  			break;
> =20
> +		/* Record first new read/write contention. */
> +		set_writer_blocked(rwb);
> +
>  		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
>  		rwbase_schedule();
>  		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> =20
>  		set_current_state(state);
>  	}
> +
> +	rwb->waiter_timeout =3D 0;

Regarding memory ordering and ordering in general:
- Should the writer leave from rwbase_schedule() due to a signal then
  set_writer_blocked() sets a timeout but it is not cleared on the
  signal leave.

- There is only writer in that for loop within rwbase_write_lock()
  because only one writer can own the rtmutex at a time. (A second
  writer blocks on the RTmutex and needs to wait, I may have spread some
  confusion earler). Therefore it should be okay to unconditionally set
  the timeout (instead of checking for zero).

- Once the writer removes READER_BIAS, it forces the reader into the
  slowpath. At that time the writer does not own the wait_lock meaning
  the reader _could_ check the timeout before writer had a chance to set
  it. The worst thing is probably that if jiffies does not have the
  highest bit set then it will always disable the reader bias here.
  The easiest thing is probably to check timeout vs 0 and ensure on the
  writer side that the lowest bit is always set (in the unlikely case it
  will end up as zero).

>  	rwbase_restore_current_state();
>  	trace_contention_end(rwb, 0);

Sebastian
