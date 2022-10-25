Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80AD60D6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJYWMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiJYWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4CF5CF5;
        Tue, 25 Oct 2022 15:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4015FB81CF3;
        Tue, 25 Oct 2022 22:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89166C433C1;
        Tue, 25 Oct 2022 22:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666735914;
        bh=ZrST8jxYvpsWDgOSq/Y8N6I166vrmd60HQPbLRrsCvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsgCBuowMlZ2lEaAYIB1fOxnsatrv2L9OehwPziwHhUeCqqyHi0hqdTxqtn8uNKZ6
         0wMosU4WypK/P7ypnmtFyVnGmMp3pb/a6/PcA4DGxTdEApPAXrXIf1TUEn/+7O3IWz
         MVa+gLPKcWBv0LxmN8V622hSlQVQKr8mBvs4pEqJ2NjAf2RbnguGMQtZeZg45LU1/I
         +9vb3kQcbrsUUmtmXjQRGsctJh+AZpyTNquhGeaEfxbMfDaTdffqMKnJVsG39gDPWI
         IMHQ3jmcBXIN5qVfd8epJq0AA3l18FlNTt36a+l8CV+VzVkAzWextmJgaXPAxEYG4d
         2+2dCLhvD8pnQ==
Date:   Wed, 26 Oct 2022 00:11:51 +0200
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
Subject: Re: [PATCH v3 02/17] tick-sched: Warn when next tick seems to be in
 the past
Message-ID: <20221025221151.GA1313991@lothringen>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
 <20221025135850.51044-3-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135850.51044-3-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:58:35PM +0200, Anna-Maria Behnsen wrote:
> When the next tick is in the past, the delta between basemono and the next
> tick gets negativ. But the next tick should never be in the past. The
> negative effect of a wrong next tick might be a stop of the tick and timers
> might expire late.
> 
> To prevent expensive debugging when changing underlying code, add a
> WARN_ON_ONCE into this code path.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

> ---
>  kernel/time/tick-sched.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index b0e3c9205946..7ffdc7ba19b4 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -826,6 +826,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  	 * If the tick is due in the next period, keep it ticking or
>  	 * force prod the timer.
>  	 */
> +	WARN_ON_ONCE(basemono > next_tick);
> +
>  	delta = next_tick - basemono;
>  	if (delta <= (u64)TICK_NSEC) {
>  		/*
> -- 
> 2.30.2
> 
