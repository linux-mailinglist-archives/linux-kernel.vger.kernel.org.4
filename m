Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0DA60E225
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiJZN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiJZN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:27:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67012B7F57;
        Wed, 26 Oct 2022 06:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 219AEB8224F;
        Wed, 26 Oct 2022 13:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77918C433D6;
        Wed, 26 Oct 2022 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666790844;
        bh=Bdy+O4IcsdfGRjS9WX5k++Rmhb023ZdYe5PoD5BO7Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2dack708B9WhO8PTbYpiWM1MlANxYay+zjYz/4flu/RfQzfFfyKSV+OpgkuGwVw+
         JekG0KIugCyj7fz1hTMXYKPN9xpmHnd1BHC13C9JbePy2j9HoK1Cox9oTwsoH+YdZu
         0xcnZtvnEJ/2FzjSg+Bzz63AnuDS9hc8mF4lHoyou344+zfwbECFQz1EiuHLFlkgfl
         KU+598W3DHcS9r1Y6E2caGQ0+W6mQXoR7InXdEq7bz9Z8qAdArlMngQqnvwQcXIWCd
         cwP8Un1loFTeq1McB7rgkmr+XHYG+izvYfSKEdTuqBYrLe9ScsvHTgF09uwYSq/BKK
         lVLRdX2tBpW2w==
Date:   Wed, 26 Oct 2022 15:27:22 +0200
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
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v3 05/17] timer: Rework idle logic
Message-ID: <20221026132722.GC1327339@lothringen>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
 <20221025135850.51044-6-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135850.51044-6-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:58:38PM +0200, Anna-Maria Behnsen wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To improve readability of the code, split base->idle calculation and
> expires calculation into separate parts.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timer.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index f34bc75ff848..cb4194ecca60 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1727,21 +1727,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  			base->clk = nextevt;
>  	}
>  
> -	if (time_before_eq(nextevt, basej)) {
> -		expires = basem;
> -		base->is_idle = false;
> -	} else {
> -		if (base->timers_pending)
> -			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
> -		/*
> -		 * If we expect to sleep more than a tick, mark the base idle.
> -		 * Also the tick is stopped so any added timer must forward
> -		 * the base clk itself to keep granularity small. This idle
> -		 * logic is only maintained for the BASE_STD base, deferrable
> -		 * timers may still see large granularity skew (by design).
> -		 */
> -		if ((expires - basem) > TICK_NSEC)
> -			base->is_idle = true;
> +	/*
> +	 * Base is idle if the next event is more than a tick away. Also
> +	 * the tick is stopped so any added timer must forward the base clk
> +	 * itself to keep granularity small. This idle logic is only
> +	 * maintained for the BASE_STD base, deferrable timers may still
> +	 * see large granularity skew (by design).
> +	 */
> +	base->is_idle = time_after(nextevt, basej + 1);

A subtle change, yet welcome, is introduced here. If the next event is just
one jiffy ahead, base->is_idle used to be left untouched. So the behaviour
was:

1) If the tick was already stopped (so we must be after an idle IRQ),
   base->is_idle remains true
2) If the tick was not yet stopped, base->is_idle remains false

After this patch, 1) becomes:

1) If the tick was already stopped, turn base->is_idle to false

As a result, we may spare an IPI if we remotely enqueue a timer to
an idle CPU that is going to tick on the next jiffy.

Whether it's worth mentioning in the changelog, I leave it to you.

> +
> +	if (base->timers_pending) {
> +		/* If we missed a tick already, force 0 delta */
> +		if (time_before_eq(nextevt, basej))
> +			nextevt = basej;

Can be time_before() then, right?

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> +		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
>  	}
>  	raw_spin_unlock(&base->lock);
>  
> -- 
> 2.30.2
> 
