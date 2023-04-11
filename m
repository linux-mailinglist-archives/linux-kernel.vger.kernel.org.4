Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE56DD6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDKJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjDKJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:37:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644AC44B9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B66B60B54
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC62C433D2;
        Tue, 11 Apr 2023 09:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681205788;
        bh=WEgeJJ235CsYCN2OoVm6GINomtvNXOkXvhHRyZUs60I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0VqFC0xFAsDasZAsP7OhPssUKQjnN8XkHJmnuNVbxXTnWhIpL0oeakjlYFRXClgn
         /28xY8KVY5sX0QjsvnV1VL5+U5a4hQlGmR2QJQHRjBMjFPtpzG2tm0CKIr5BwV6V/z
         Sq6Nqzp0YFp23Nd28pmtElanFoW1TCNLk02SLNsxqEtx0hfaVeCzR3jVdLAckf9W8N
         nZ/tcFXH9r/GlNRSbtPnPfM7WCzGsOAzKEJ2D9z1XYCUEX6NE3D/C6F2HUbml9K1y/
         /ul/kH7khukx/X3UEzedSdz5/rrtOHmrR0v1QwTTz7S5nRyn8yX/cJEFDi4JZcEQgO
         Crf2oz1Ny/NJg==
Date:   Tue, 11 Apr 2023 11:36:24 +0200
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
Subject: Re: [PATCH v5 02/18] timer: Add comment to
 get_next_timer_interrupt() description
Message-ID: <ZDUqGCU3O7pIzn0O@lothringen>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-3-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-3-anna-maria@linutronix.de>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:28PM +0100, Anna-Maria Behnsen wrote:
> get_next_timer_interrupt() does more than simply getting the next timer
> interrupt. The timer bases are forwarded and also marked as idle whenever
> possible.
> 
> To get not confused, add a comment to function description.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v5: New patch, which adds only a comment to get_next_timer_interrupt()
> instead of changing the function name
> ---
>  kernel/time/timer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 63a8ce7177dd..ffb94bc3852f 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1915,6 +1915,10 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
>   * @basej:	base time jiffies
>   * @basem:	base time clock monotonic
>   *
> + * If required, base->clk is forwarded and base is also marked as
> + * idle. Idle handling of timer bases is allowed only to be done by CPU
> + * itself.

Idle marking you mean? Because idle handling can be done remotely after
this patchset.

Thanks.

> + *
>   * Returns the tick aligned clock monotonic time of the next pending
>   * timer or KTIME_MAX if no timer is pending.
>   */
> -- 
> 2.30.2
> 
