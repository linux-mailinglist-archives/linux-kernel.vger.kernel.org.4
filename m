Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316C173EEC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFZWqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFZWqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC45188
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5EE260F97
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E15C433C8;
        Mon, 26 Jun 2023 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687819569;
        bh=7968kreExZC6Fc9zOW2Q2czxDskvgfvx/LKbzujqlvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYYQSvkGKfbfqAtqEsr4YwE4tR7gxrieDqDEC7hFi6bRGMuZH2Ape+uzMUfxwAql0
         UFXmxMrz/C0jiIdwgMCn4HqGjQXNrm9Efstm2L5vsNbq3dH2IJ7nGXVNELvaCdi7lm
         zpBt9qEVcqTsKnHlMOTR8xuqWWd99F/9PZMcseaGZuV0vKQ/V/7W6aSalexlGpGKeB
         N/Y++1H0E4E4DhB7zoyP3HbKV1venorZ5QeBTOELB7ufgCdxqSkmj+16kExqtkCu9l
         cnMMJdhybfgo+iXY+PQyT0Km3k3QlcHzoXNfzGU4vMg0Ii+zwVIw73IabLyTCmqNoS
         dvDyJuxxTr1iA==
Date:   Tue, 27 Jun 2023 00:46:05 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 09/45] posix-cpu-timers: Fix posix_cpu_timer_get()
 behaviour
Message-ID: <ZJoVLadeU9Y5KMO8@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.532247561@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142031.532247561@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:33PM +0200, Thomas Gleixner wrote:
> timer_gettime() must return the remaining time to the next expiry of a
> timer or 0 if the timer is not armed and no signal pending.
> 
> This has to be correct also for interval timers even if the signal is
> pending or the timer has been created with SIGEV_NONE.
> 
> The posix CPU timer implementation fails for both cases as it does not
> forward the timer in posix_cpu_timer_get() before calculating the expiry
> time.
> 
> It neither clears the expiry value when a oneshot SIGEV_NONE timer expired
> and returns 1nsec instead, which is only correct for timers with signals
> when the signal delivery did not happen yet.
> 
> Aside of that posix_cpu_timer_set() pointlessly arms SIGEV_NONE timers
> which are later disarmed when the initial expiry happens. That's bogus and
> just keeping the process wide timer active for nothing.
> 
> Cure this by:
> 
>      1) Avoiding to arm SIGEV_NONE timers
> 
>      2) Forwarding interval timers in posix_cpu_timer_get()
> 
>      3) Taking SIGEV_NONE into account when a oneshot timer has expired

This patch does too many things at once...

> 
> Make the update logic a separate function so it can be reused to simplify
> posix_cpu_timer_set().
> 
> Fixes: ae1a78eecc45 ("cpu-timers: Return correct previous timer reload value")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   96 +++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 42 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -785,45 +782,60 @@ static int posix_cpu_timer_set(struct k_
>  	return ret;
>  }
>  
> -static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
> +static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
>  {
> -	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
> -	struct cpu_timer *ctmr = &timer->it.cpu;
> -	u64 now, expires = cpu_timer_getexpires(ctmr);
> -	struct task_struct *p;
> -
> -	rcu_read_lock();
> -	p = cpu_timer_task_rcu(timer);
> -	if (!p)
> -		goto out;
> +	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
> +	u64 expires;
>  
>  	/*
> -	 * Easy part: convert the reload time.
> +	 * Make sure that interval timers are moved forward for the
> +	 * following cases:
> +	 *  - SIGEV_NONE timers which are never armed
> +	 *  - Timers which expired, but the signal has not yet been
> +	 *    delivered
>  	 */
> -	itp->it_interval = ktime_to_timespec64(timer->it_interval);
> -
> -	if (!expires)
> -		goto out;
> +	expires = bump_cpu_timer(timer, now);

What if the expiration has been reached but we arrived here before
handle_posix_cpu_timers() had a chance? In that case the call to
bump_cpu_timer() may forward the timer and artificially create an
overrun / missed event.

Also we are not holding the sighand lock here. So even though the timer
is forwarded, it may still be picked up afterward by check_thread_timers()
based on its stalled previous expires value... This can create a discrepancy
between the overrun count and the actual events received, and perhaps other
funny things...

Thanks.

>  
>  	/*
> -	 * Sample the clock to take the difference with the expiry time.
> +	 * Interval timers cannot have a remaining time <= 0 because the
> +	 * forwarding guarantees to move them forward so that the next
> +	 * timer expiry is > @now.
>  	 */
> -	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> -		now = cpu_clock_sample(clkid, p);
> -	else
> -		now = cpu_clock_sample_group(clkid, p, false);
> -
>  	if (now < expires) {
>  		itp->it_value = ns_to_timespec64(expires - now);
>  	} else {
>  		/*
> -		 * The timer should have expired already, but the firing
> -		 * hasn't taken place yet.  Say it's just about to expire.
> +		 * A single shot SIGEV_NONE timer must return 0, when it is
> +		 * expired! Timers which have a real signal delivery mode
> +		 * must return a remaining time greater than 0 because the
> +		 * signal has not yet been delivered.
>  		 */
> -		itp->it_value.tv_nsec = 1;
> -		itp->it_value.tv_sec = 0;
> +		if (!sigev_none)
> +			itp->it_value.tv_nsec = 1;
> +	}
> +}

