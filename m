Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605B05F0E61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiI3PDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiI3PDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:03:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810731B797;
        Fri, 30 Sep 2022 08:02:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664550139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J+Fn4zMjsLn2Qso2M/bzpTLj/jBiqJSsMiMxkJfaFns=;
        b=AOo14cMZ2mEMUoXVzdowlMGK9daTRVgM5oGOQ5ZqkClSdLBoEp0pqdM08dbloyxeM9kJol
        e+l8hmKkF9Dvrd0Rfnt1JDQmORksEWdJJso9YSR0tWkWxqwqTInvbK+PXSIxYk0jFOeRH7
        jwcRpRgxdOjR75X52gr6rNnb0OcFwXemOJh6qETKQ/lclkFsTkgoN/aNlqcSS5GCc63xYH
        /0YWZf+VDenoSobJe8mzttRShCmXBilUhNka3hLgCbqRPIpQiMUjvwpuZ2c1wBrMsWm9gE
        4+1mDiJDpxHKEpji8SR4b3Ju1wxqyTUl5KQBupqwjHE2lZuDhCVXyU9mj0eWiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664550139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J+Fn4zMjsLn2Qso2M/bzpTLj/jBiqJSsMiMxkJfaFns=;
        b=fe954LaE1Z/wHa54KHsNWFtY6/lL2vlliP3TsrpJDWG+Q7QPmx96WVhG4Tm4auZVh4M1xx
        Pd98LjH1kpimYTBw==
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 1/8] srcu: Convert ->srcu_lock_count and
 ->srcu_unlock_count to atomic
In-Reply-To: <20220929180731.2875722-1-paulmck@kernel.org>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-1-paulmck@kernel.org>
Date:   Fri, 30 Sep 2022 17:08:18 +0206
Message-ID: <87ill4vrb9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022-09-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..6fd0665f4d1f 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -636,7 +636,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
>  	int idx;
>  
>  	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> -	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> +	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
>  	smp_mb(); /* B */  /* Avoid leaking the critical section. */
>  	return idx;
>  }

Is there any particular reason that you are directly modifying @counter
instead of raw_cpu_ptr()+atomic_long_inc() that do you in
__srcu_read_lock_nmisafe() of patch 2?

> @@ -650,7 +650,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
>  void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
>  {
>  	smp_mb(); /* C */  /* Avoid leaking the critical section. */
> -	this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);
> +	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
>  }
>  EXPORT_SYMBOL_GPL(__srcu_read_unlock);

Ditto.

> @@ -1687,8 +1687,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
>  			struct srcu_data *sdp;
>  
>  			sdp = per_cpu_ptr(ssp->sda, cpu);
> -			u0 = data_race(sdp->srcu_unlock_count[!idx]);
> -			u1 = data_race(sdp->srcu_unlock_count[idx]);
> +			u0 = data_race(sdp->srcu_unlock_count[!idx].counter);
> +			u1 = data_race(sdp->srcu_unlock_count[idx].counter);
>  
>  			/*
>  			 * Make sure that a lock is always counted if the corresponding

And instead of atomic_long_read().

> @@ -1696,8 +1696,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
>  			 */
>  			smp_rmb();
>  
> -			l0 = data_race(sdp->srcu_lock_count[!idx]);
> -			l1 = data_race(sdp->srcu_lock_count[idx]);
> +			l0 = data_race(sdp->srcu_lock_count[!idx].counter);
> +			l1 = data_race(sdp->srcu_lock_count[idx].counter);
>  
>  			c0 = l0 - u0;
>  			c1 = l1 - u1;

Ditto.

John Ogness
