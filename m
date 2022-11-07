Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2091261F386
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiKGMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiKGMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:42:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3221B9C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:42:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD22561014
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A5AC433C1;
        Mon,  7 Nov 2022 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667824931;
        bh=R1VAOr8rvwk8SKiN2iCbCJLyF/xEg7xivzA6nNONtzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWvbUoy4SLon+yYzVVDHXlTYE0N1XLMMnNsYL3/0e+eaPyWtclpXaD8dc/P0ZhFVM
         QbYNWEWof4NU7bVeZ1qTz9XaQVlFcsHdMMzVKdx4IloU9haX7pP5V3jUKQ8DzGeuig
         awEHG56HjYCmFjy1q/DsbAWZa64sf1cXOZ+MYPyzeABMpg7RQbZ+6OLeTzfcfLTc6v
         UB06FnYL2viGB/ueXWDzBM6r4eybpvaMGK+VRGZJzwqZgjtDYfxp1l9uqWQObU0oAc
         YBtps6PsZBNRq0Gprcg6Z/gU378A1drIcITN2/Id18G6aMxPxSUrI/gs2cmjI80rMC
         EOa90+X3x67GA==
Date:   Mon, 7 Nov 2022 13:42:05 +0100
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
Subject: Re: [PATCH v4 09/16] timer: Split out "get next timer interrupt"
 functionality
Message-ID: <20221107124205.GC4588@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-10-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-10-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:30PM +0100, Anna-Maria Behnsen wrote:
> forward_and_idle_timer_bases() includes the functionality for getting the
> next timer interrupt. To reuse it, it is splitted into an separate function
> "get_next_timer_interrupt()".
> 
> This is preparatory work for the conversion of the NOHZ timer
> placement to a pull at expiry time model. No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v4: Fix typo in comment
> ---
>  kernel/time/timer.c | 93 +++++++++++++++++++++++++--------------------
>  1 file changed, 51 insertions(+), 42 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 680a0760e30d..853089febf83 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1704,6 +1704,46 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
>  	return base->next_expiry;
>  }
>  
> +static unsigned long get_next_timer_interrupt(struct timer_base *base_local,

So perhaps forward_and_idle_timer_interrupt() could stay as
"get_next_timer_interrupt()" and the new get_next_timer_interrupt() above could
become fetch_next_timer_interrupt().

Just an idea.

From a functional POV:

     Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.
