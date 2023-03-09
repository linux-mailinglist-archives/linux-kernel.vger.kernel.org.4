Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAB6B2B01
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCIQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCIQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:40:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5AF9D1A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3189261C27
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23F2C433D2;
        Thu,  9 Mar 2023 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678379416;
        bh=2myRFp+JXTxx/MD0ZKSnlRht9oyh3Nz01sw4s6UNk9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXMe8wTA0y9G+YWO8ZapyGFy7ye6yKLLbScSDbH2yRFdHJjpNx/w9aXOXoZxNq19q
         gFyJ+IeV2xMr/KopvXAbWoQZacYBClt7op/rd46edU6SJ2nz3lR4/yOV66329OUo+9
         rTDA2OPEnIurFOyX+/fIM5uOUIRvI2SiaMPJuk+ka/NAdLNWL1ksl67F5UfQyCSm/Y
         etGi4YG5I71/96IDmJ5AKq0wNfX31EzzXM+Lk0Oni81zldwa32w04u73Gvm1mOjl49
         jJP7yblqwDgyxlEQsRtTf2THMdOoLWaYzUWkwKqtoaSEWqmlTRaCzSTXA7kzji8bNz
         A2pvzPnLwxI0g==
Date:   Thu, 9 Mar 2023 17:30:12 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 11/18] timer: Split out "get next timer interrupt"
 functionality
Message-ID: <ZAoJlEwW/2hX6zlQ@localhost.localdomain>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-12-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301141744.16063-12-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 01, 2023 at 03:17:37PM +0100, Anna-Maria Behnsen a écrit :
> The functionallity for getting the next timer interrupt in
> get_next_timer_interrupt() is splitted into a separate function
> fetch_next_timer_interrupt() to be usable by other callsides.
> 
> This is preparatory work for the conversion of the NOHZ timer
> placement to a pull at expiry time model. No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
[...]
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index ff41d978cb22..dfc744545159 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2040,31 +2071,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  		if (time_before(nextevt, basej))
>  			nextevt = basej;
>  		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
> -		goto unlock;
> +		tevt.global = KTIME_MAX;
>  	}
>  
> -	/*
> -	 * If the bases are marked idle, i.e. the next event on both the
> -	 * local and the global queue are farther away than a tick,
> -	 * evaluate both bases. No need to check whether one of the bases
> -	 * has an already expired timer as this is caught by the !is_idle
> -	 * condition above.
> -	 */
> -	if (base_local->timers_pending)
> -		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
> -
> -	/*
> -	 * If the local queue expires first, then the global event can be
> -	 * ignored. The CPU wakes up before that. If the global queue is
> -	 * empty, nothing to do either.
> -	 */
> -	if (!local_first && base_global->timers_pending)
> -		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
> -
> -unlock:
> -	raw_spin_unlock(&base_global->lock);
> -	raw_spin_unlock(&base_local->lock);
> -
>  	tevt.local = min_t(u64, tevt.local, tevt.global);

So if you leave that last line, it means that the CPU will eventually
and unconditionally wake up for the next global timer if it's before the
next local timer. Am I understanding this right and, if so, is that intended?

Thanks.
