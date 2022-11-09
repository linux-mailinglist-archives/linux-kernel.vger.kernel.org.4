Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471A5623054
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKIQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiKIQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:39:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A965722B13
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:39:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A409B81F3E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC9DC433D6;
        Wed,  9 Nov 2022 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668011984;
        bh=IibbWHhqfZix6192272Stv6BuEQS3P2pB2046KfkMbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fr8NqOlLUVG3oVWOBZDLKsIiKkemgkrFoTGKZ1gdpXnGD9AXAi3EL8YSuktFvyaQo
         qkSsd10Ii0E8P/q1+8/mKEYNTVPsLY92cvpQY8oWUxAdPlln59hLNI/wabwWZMYv3B
         WHtxfpSEuBQL2c8LXR3Q/44+ENMSVwJa5V/7XFHlJXcwiHxranfan3EybIHWiajIp9
         7TrfiPQr/7RIwojvw9RX4su9wwe2UwQFlOIuXG6TKkBdA0p05IX7YTLPAZzoo+amWc
         FHD5f/PNnACZqgg0Yb/1ZALgjCBwG3B3oOc7KUKosXvTGgl6TYKBKfEF+H/nVOhrvn
         hUwccYzy/xtrQ==
Date:   Wed, 9 Nov 2022 17:39:41 +0100
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
Subject: Re: [PATCH v4 14/16] timer: Implement the hierarchical pull model
Message-ID: <20221109163941.GC298683@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-15-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index f8b2065df79b..214397d84747 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -53,6 +53,7 @@
>  #include <asm/io.h>
>  
>  #include "tick-internal.h"
> +#include "timer_migration.h"
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/timer.h>
> @@ -592,10 +593,13 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  
>  	/*
>  	 * We might have to IPI the remote CPU if the base is idle and the
> -	 * timer is not deferrable. If the other CPU is on the way to idle
> -	 * then it can't set base->is_idle as we hold the base lock:
> +	 * timer is pinned. If it is a non pinned timer, it is only queued
> +	 * on the remote CPU, when timer was running during queueing. Then
> +	 * everything is handled by remote CPU anyway.
> +	 * on the way to idle then it can't set base->is_idle as we hold
> +	 * the base lock:
>  	 */
> -	if (base->is_idle)
> +	if (base->is_idle && timer->flags & TIMER_PINNED)
>  		wake_up_nohz_cpu(base->cpu);

I'm probably missing something but, shouldn't there be a call to
tmigr_new_timer() on the target to handle the new non-pinned timer?

Thanks.
