Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94C160E2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiJZN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiJZNzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:55:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC221BA;
        Wed, 26 Oct 2022 06:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C09E7B82256;
        Wed, 26 Oct 2022 13:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF802C433C1;
        Wed, 26 Oct 2022 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666792466;
        bh=LKZk9dBZGIq7KqFoibWcuqHEwOK9OLBpzjrlxQ1KBlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKikGAmSLTBEDZcy4Ji5S4E690ealCJfSRBv9dXVt94phADLKB5WObZ+//7lt9E4e
         JsA+/VaZOCeJmTM1QTSFmKvpP6TvQh/xfpYyS44d3aypIebEYZ8BSbPFjTJDMraLdx
         xGcX+2U+g+sQEPhhcH/3lUnbIIx6BosZx67YY/LLdaOO5vF2EVuYoFUDmhquFVHpWS
         IdeCVOtIabZjvD43K7P8xYekLqKFQMMu5re3buLjeTDqlutyl98+qK9AAuBzW25RO8
         D45F5rDYtybZJGS2qzAQRxUNwdmGkVnzVcL9tW2jVkkJ6O9kyqM/rBB8GL2QPk4cz8
         XQReRe+ltefuQ==
Date:   Wed, 26 Oct 2022 15:54:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 01/17] cpufreq: Prepare timer flags for hierarchical
 timer pull model
Message-ID: <20221026135423.GA1329996@lothringen>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
 <20221025135850.51044-2-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135850.51044-2-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:58:34PM +0200, Anna-Maria Behnsen wrote:
> Note: This is a proposal only. I was waiting on input how to change this
> driver properly to use the already existing infrastructure. See therfore
> the thread on linux-pm mailinglist:
> https://lore.kernel.org/linux-pm/4c99f34b-40f1-e6cc-2669-7854b615b5fd@linutronix.de/
> 
> gpstates timer is the only timer using TIMER_PINNED and TIMER_DEFERRABLE
> flag. When moving to hierarchical timer pull model, pinned and deferrable
> timers are stored in separate bases.
> 
> To ensure gpstates timer always expires on the CPU where it is pinned to,
> keep only TIMER_PINNED flag and drop TIMER_DEFERRABLE flag.

OTOH there are deferrable timers out there that expect to run on a
specific CPU, because there are always queued with add_timer_on().

For example workqueues using DECLARE_DEFERRABLE_WORK() that are queued
with queue_delayed_work_on(). Like vmstat().

Those are not explicitely pinned because they don't rely on __mod_timer()
but they expect CPU affinity.

Thanks.

> 
> While at it, rewrite comment explaining the rule for timer expiry for the
> next interval and fix whitespace damages.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index fddbd1ea1635..08d6bd54539d 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -640,18 +640,18 @@ static inline int calc_global_pstate(unsigned int elapsed_time,
>  		return highest_lpstate_idx + index_diff;
>  }
>  
> -static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
> +static inline void queue_gpstate_timer(struct global_pstate_info *gpstates)
>  {
>  	unsigned int timer_interval;
>  
>  	/*
> -	 * Setting up timer to fire after GPSTATE_TIMER_INTERVAL ms, But
> -	 * if it exceeds MAX_RAMP_DOWN_TIME ms for ramp down time.
> -	 * Set timer such that it fires exactly at MAX_RAMP_DOWN_TIME
> -	 * seconds of ramp down time.
> +	 * Timer should expire next time after GPSTATE_TIMER_INTERVAL. If
> +	 * the resulting interval (elapsed time + interval) between last
> +	 * and next timer expiry is greater than MAX_RAMP_DOWN_TIME, ensure
> +	 * it is maximum MAX_RAMP_DOWN_TIME when queueing the next timer.
>  	 */
>  	if ((gpstates->elapsed_time + GPSTATE_TIMER_INTERVAL)
> -	     > MAX_RAMP_DOWN_TIME)
> +	    > MAX_RAMP_DOWN_TIME)
>  		timer_interval = MAX_RAMP_DOWN_TIME - gpstates->elapsed_time;
>  	else
>  		timer_interval = GPSTATE_TIMER_INTERVAL;
> @@ -865,8 +865,7 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  	/* initialize timer */
>  	gpstates->policy = policy;
> -	timer_setup(&gpstates->timer, gpstate_timer_handler,
> -		    TIMER_PINNED | TIMER_DEFERRABLE);
> +	timer_setup(&gpstates->timer, gpstate_timer_handler, TIMER_PINNED);
>  	gpstates->timer.expires = jiffies +
>  				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
>  	spin_lock_init(&gpstates->gpstate_lock);
> -- 
> 2.30.2
> 
