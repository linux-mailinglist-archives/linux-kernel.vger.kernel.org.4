Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF15723241
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjFEV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFEV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:29:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39431D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B131261457
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 21:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699D3C433D2;
        Mon,  5 Jun 2023 21:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686000581;
        bh=1mPAjWecCHoTi0Z6YKshdwkOoJ9BKqq5bDhFqKUI4IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDOhA7vBEahmuqQWv8PmA6N8/ZOWv+1xA9hNfl/lytv3SqbT4btZVQbOTA5G74ppS
         Y1h9KfTtGjc7uWaC4XcT1lFItMjFxoAV6hdYBUoZcLbRSvmh2t68zvXZF0796QnJzM
         jn7kqLId0oaf7IWj9VN2eWFpGBr6GTOAmSOkHdnm3lwhy2K6vs7ZQ5dVYzZSNOorMk
         Nzqh1O37UCq/C/YhjzQ9PN7p4ka26k+rR0coxYHZrnwWkKS/JUEA0s07NQBTerjvjc
         RaZ2cRBq/EiQf2nn2jOxRKnTWZnVGt4NlkO+7yQVLOCuBe1AT/x6y+1CXQjAsH8R4L
         gS0ZpN3c/AAjw==
Date:   Mon, 5 Jun 2023 23:29:37 +0200
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
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v7 02/21] timer: Do not IPI for deferrable timers
Message-ID: <ZH5TwdrDwLqsWWRA@localhost.localdomain>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-3-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524070629.6377-3-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 24, 2023 at 09:06:10AM +0200, Anna-Maria Behnsen a écrit :
> Deferrable timers do not prevent CPU from going idle and are not taken into
> account on idle path. Sending an IPI to a remote CPU when a new first
> deferrable timer was enqueued will wake up the remote CPU and but nothing
> will be done regarding the deferrable timers.
> 
> Drop IPI completely when a new first deferrable timer was enqueued.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v6: new patch
> ---
>  kernel/time/timer.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 63a8ce7177dd..6e251e3cf659 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -571,18 +571,15 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk,
>  static void
>  trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  {
> -	if (!is_timers_nohz_active())
> -		return;
> -
>  	/*
> -	 * TODO: This wants some optimizing similar to the code below, but we
> -	 * will do that when we switch from push to pull for deferrable timers.
> +	 * Deferrable timers do not prevent CPU from going idle and are not
> +	 * taken into account on idle path. An IPI when a new deferrable

Just to make sure everyone is aware that this concerns also nohz_full,
this could be:

	/*
	 * Deferrable timers do not prevent CPU from entering dynticks
	 * and are not taken into account on idle/nohz_full path. An IPI
	 * when a new deferrable timer is enqueued will wake up the remote
	 * CPU but nothing will be done with the deferrable timer base.
	 * Therefore skip remote IPI for deferrable timers completely.
	 */

But anyway:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
