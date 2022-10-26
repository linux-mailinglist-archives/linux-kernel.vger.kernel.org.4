Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4613660E46E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiJZP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiJZP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47571EE8AD;
        Wed, 26 Oct 2022 08:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D612861F86;
        Wed, 26 Oct 2022 15:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD787C433C1;
        Wed, 26 Oct 2022 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666797984;
        bh=Pzek3yhRyqg9onveV/DhbH5znQ1mcRmwDYSkzMK+98w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifwIVNut1KU3sPF6rN9bNiDsLLnDSmcNPtKJLrLZvWrRpGjxiadRNZBdyFHaTBSRl
         noZbPvz1hdQitmFg3eFsp9o6AuOuAIqr1VRwVs75iowjYn3Jj0R6ANIiqKI/0iBci+
         Mf0mhiT54j9Ixm+7wSA5efQaz2caWpGM6dx2OsPJS8sI+nF11h6JJKhOrM+GEG1haH
         EBVqD5yjop3RFtrpNL60f5ooEMkFTNpjCeIzlH4CBWVn2vDX7SGek0ycWEfKUldNtL
         sIVv6LdPzHKsGQwnv8u+X2uomMRVyiPsn6+3N8B/a0rKMTi6TuPFSjSc1uewjFAVCW
         dwVft+cnQxMxA==
Date:   Wed, 26 Oct 2022 17:26:21 +0200
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
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v3 06/17] timer: Keep the pinned timers separate from the
 others
Message-ID: <20221026152621.GA1330257@lothringen>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
 <20221025135850.51044-7-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135850.51044-7-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:58:39PM +0200, Anna-Maria Behnsen wrote:
> @@ -1711,38 +1724,69 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  	if (cpu_is_offline(smp_processor_id()))
>  		return expires;
>  
> -	raw_spin_lock(&base->lock);
> +	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
> +	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
>  
> -	nextevt = next_timer_interrupt(base);
> +	raw_spin_lock(&base_local->lock);
> +	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
> +
> +	nextevt_local = next_timer_interrupt(base_local);
> +	nextevt_global = next_timer_interrupt(base_global);
>  
>  	/*
>  	 * We have a fresh next event. Check whether we can forward the
>  	 * base. We can only do that when @basej is past base->clk
>  	 * otherwise we might rewind base->clk.
>  	 */
> -	if (time_after(basej, base->clk)) {
> -		if (time_after(nextevt, basej))
> -			base->clk = basej;
> -		else if (time_after(nextevt, base->clk))
> -			base->clk = nextevt;
> +	if (time_after(basej, base_local->clk)) {
> +		if (time_after(nextevt_local, basej))
> +			base_local->clk = basej;
> +		else if (time_after(nextevt_local, base_local->clk))
> +			base_local->clk = nextevt_local;
> +	}
> +
> +	if (time_after(basej, base_global->clk)) {
> +		if (time_after(nextevt_global, basej))
> +			base_global->clk = basej;
> +		else if (time_after(nextevt_global, base_global->clk))
> +			base_global->clk = nextevt_global;

Perhaps make a helper for the two above?

>  	}
>  
> @@ -1763,6 +1807,9 @@ void timer_clear_idle(void)
>  	 * the lock in the exit from idle path.
>  	 */
>  	base->is_idle = false;
> +
> +	base = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
> +	base->is_idle = false;

May be just:

    __this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false)
    __this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false)

>  }
>  #endif
>  
> @@ -1820,17 +1869,21 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>   */
>  static void run_local_timers(void)
>  {
> -	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
> +	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
>  
>  	hrtimer_run_queues();
>  	/* Raise the softirq only if required. */
>  	if (time_before(jiffies, base->next_expiry)) {
>  		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
>  			return;
> -		/* CPU is awake, so check the deferrable base. */
> +		/* CPU is awake, so check for the global base. */
>  		base++;
> -		if (time_before(jiffies, base->next_expiry))
> -			return;
> +		if (time_before(jiffies, base->next_expiry)) {
> +			/* CPU is awake, so check the deferrable base. */
> +			base++;
> +			if (time_before(jiffies, base->next_expiry))
> +				return;
> +		}

Could be:

for (i = 0; i < NR_BASES; i++) {
    struct timer_base *base = this_cpu_ptr(&timer_bases[i]);
    if (time_after_eq(jiffies, base->next_expiry)) {
       raise_softirq(TIMER_SOFTIRQ);
       return;
    }
}
       

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!


>  	}
>  	raise_softirq(TIMER_SOFTIRQ);
>  }
> -- 
> 2.30.2
> 
