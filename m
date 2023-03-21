Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2446C3206
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCUMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCUMsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:48:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3558C3C07
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/WiUdk5Pa5ArXusYavghale6J5UfzFTYss/fFeIE2o=; b=Ye9SqzagYuPjFl3HM5hR5vP4Nv
        c6xWEqDsworC6skluaUutKSk6oJkDxV53XBSWgo4PcuDuTfA3rRwX7dAnf3bZ2kZZDyFlb/4vZlVN
        YkQv038SAiw5fttTohP86selRhDJSBWocEsR1Clwq8QHNmzH7vST0MOsx8AoJTAmfHp3tS2TEMDja
        kioNrKxO9K+HX20OZSJ5vO8wNRTsSACWa17gJTdr5wU7pVmd5h/Obzs+F4pgKSuK4MccDPprsgaFx
        yS2iS3AMjMOzY8J1ArmGQ8bq8sG+upqSNSFMh1omTe/jAt8jzFPtJcywSc9b0HD1IZl2x9hBXh0bx
        viS6UwrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pebPT-0022iF-3F; Tue, 21 Mar 2023 12:48:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA33E30006D;
        Tue, 21 Mar 2023 13:48:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B1FD2394C189; Tue, 21 Mar 2023 13:48:14 +0100 (CET)
Date:   Tue, 21 Mar 2023 13:48:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 03/18] timer: Move store of next event into
 __next_timer_interrupt()
Message-ID: <20230321124814.GN2234901@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-4-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-4-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:29PM +0100, Anna-Maria Behnsen wrote:
> Both call sides of __next_timer_interrupt() store return value directly in

             ^^ sites

> base->next_expiry. Move the store into __next_timer_interrupt() and to make

+its

> purpose more clear, rename function to next_expiry_recalc().
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
> index ffb94bc3852f..08e855727ff8 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1803,8 +1803,10 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
>  /*
>   * Search the first expiring timer in the various clock levels. Caller must
>   * hold base->lock.
> + *
> + * Store next expiry time in base->next_expiry.
>   */
> -static unsigned long __next_timer_interrupt(struct timer_base *base)
> +static void next_expiry_recalc(struct timer_base *base)
>  {
>  	unsigned long clk, next, adj;
>  	unsigned lvl, offset = 0;
> @@ -1870,10 +1872,11 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
>  		clk += adj;
>  	}
>  
> +	base->next_expiry = next;
>  	base->next_expiry_recalc = false;
>  	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
>  
> -	return next;
> +	return;
>  }

Can skip the return statement for a void function entirely if it is the
last statement.

