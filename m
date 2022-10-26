Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF360DE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiJZJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJZJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:33:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B0BB2773;
        Wed, 26 Oct 2022 02:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3DD2B8212F;
        Wed, 26 Oct 2022 09:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DC0C433C1;
        Wed, 26 Oct 2022 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666776787;
        bh=BofbRtfIxoJoenlFoJc1d0N551Sv7Cz7H1y1Amq+Qo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCCBUq/Df0dDEVCTbMgVIdLVL865mdtl9QRgpR4rlTZFRIaHQOucswtXZaGFckhTZ
         Qu0SI6rb2kmQcRhOlDmCyoFSgPvdgxVdThEBpvBe412LTeVjEtPJJvuEv+qDyrRGfZ
         jdroKRhc9D8yHZCm1fx/T2wy2jX182MdYWx5k5TKl5wYDbFugnWiEZfQKptprlA5Ok
         mzPg9Frd2Eh+IxXGwkVJzbP35M1HM4IL9C9qHCHXJYUfHuhJyd6KDHS+ySzhrsGNIR
         e4XJUExG0QSoS0gaYOOQBL9q+S2ZhCdqjGZOf4B21cH2eOTg2XdP+85ihdpHl5uwis
         JtOWS76re+WsQ==
Date:   Wed, 26 Oct 2022 11:33:04 +0200
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
Subject: Re: [PATCH v3 03/17] timer: Move store of next event into
 __next_timer_interrupt()
Message-ID: <20221026093304.GA1327339@lothringen>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
 <20221025135850.51044-4-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135850.51044-4-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:58:36PM +0200, Anna-Maria Behnsen wrote:
> Both call sides of __next_timer_interrupt() store the return value directly
> in base->next_expiry. Move the store into __next_timer_interrupt().
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/timer.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 717fcb9fb14a..7695c733dfa5 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1571,8 +1571,10 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
>  /*
>   * Search the first expiring timer in the various clock levels. Caller must
>   * hold base->lock.
> + *
> + * Store next expiry time in base->next_expiry.
>   */
> -static unsigned long __next_timer_interrupt(struct timer_base *base)
> +static void __next_timer_interrupt(struct timer_base *base)
>  {
>  	unsigned long clk, next, adj;
>  	unsigned lvl, offset = 0;
> @@ -1638,10 +1640,11 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
>  		clk += adj;
>  	}
>  
> +	base->next_expiry = next;
>  	base->next_expiry_recalc = false;

In that case, maybe rename that function as next_expiry_recalc() to make its
purpose clearer?

Thanks!

>  	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
>  
> -	return next;
> +	return;
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -1701,7 +1704,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  
>  	raw_spin_lock(&base->lock);
>  	if (base->next_expiry_recalc)
> -		base->next_expiry = __next_timer_interrupt(base);
> +		__next_timer_interrupt(base);
>  	nextevt = base->next_expiry;
>  
>  	/*
> @@ -1784,7 +1787,7 @@ static inline void __run_timers(struct timer_base *base)
>  		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
>  			     && base->timers_pending);
>  		base->clk++;
> -		base->next_expiry = __next_timer_interrupt(base);
> +		__next_timer_interrupt(base);
>  
>  		while (levels--)
>  			expire_timers(base, heads + levels);
> -- 
> 2.30.2
> 
