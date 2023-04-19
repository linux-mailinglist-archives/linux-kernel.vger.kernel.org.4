Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6EF6E7B05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjDSNhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDSNhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B05171D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB96263F54
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1028C433D2;
        Wed, 19 Apr 2023 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681911389;
        bh=sYChbeqEdWIRaGCrv2btDjNr1XPBmPY6fksjrfC6lVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfkLMJ0QBRJceVqkdY54PEPexZse6lbVkUBHLvMq6DHqlif+2fJuQyi5SUApdx3y3
         qYKU/EblFOCECB4PCN5KHanCwzSmqSBqfmx7dZ/avvmltOiCTPS0LSRgMBIqBcIj9m
         rffYMVytwEl0zmR7WyicukrKlqR8AScCsB7wfg/NRwiLkl4JfFvwTgBZr/8A5kQKG4
         t1ezHFAKWQvY6b9TD+1uWbWQP018ibz6MR2RZzBbkVpoDlvkVrn9+JiGsHRiqDd1tM
         eSlx6K24hxEWljGDss7QYqmWE31pGctLp8Dj9W0FdRQRdV0vxAspkfpT60Tj010UxX
         pJrYc6Z6ro2uA==
Date:   Wed, 19 Apr 2023 15:36:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZD/uWdz7dKLKlUqH@localhost.localdomain>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfd0yi4g.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Apr 15, 2023 at 11:01:51PM +0200, Thomas Gleixner a écrit :
> @@ -1020,48 +1021,89 @@ static inline ktime_t tick_get_next_peri
>  /**
>   * tick_broadcast_setup_oneshot - setup the broadcast device
>   */
> -static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
> +static void tick_broadcast_setup_oneshot(struct clock_event_device *bc,
> +					 bool from_periodic)
>  {
>  	int cpu = smp_processor_id();
> +	ktime_t nexttick = 0;
>  
>  	if (!bc)
>  		return;
>  
>  	/* Set it up only once ! */
> -	if (bc->event_handler != tick_handle_oneshot_broadcast) {
> -		int was_periodic = clockevent_state_periodic(bc);
> -
> -		bc->event_handler = tick_handle_oneshot_broadcast;
> -
> +	if (bc->event_handler == tick_handle_oneshot_broadcast) {
>  		/*
> -		 * We must be careful here. There might be other CPUs
> -		 * waiting for periodic broadcast. We need to set the
> -		 * oneshot_mask bits for those and program the
> -		 * broadcast device to fire.
> +		 * The CPU which switches from periodic to oneshot mode
> +		 * sets the broadcast oneshot bit for all other CPUs which
> +		 * are in the general (periodic) broadcast mask to ensure
> +		 * that CPUs which wait for the periodic broadcast are
> +		 * woken up.
> +		 *
> +		 * Clear the bit for the local CPU as the set bit would
> +		 * prevent the first tick_broadcast_enter() after this CPU
> +		 * switched to oneshot state to program the broadcast
> +		 * device.
>  		 */
> +		tick_broadcast_clear_oneshot(cpu);

So this path is reached when we setup/exchange a new tick device
on a CPU after the broadcast device has been set to oneshot, right?

Why does it have a specific treatment? Is it for optimization? Or am I
missing a correctness based reason?

> +	}
> +
> +
> +	bc->event_handler = tick_handle_oneshot_broadcast;
> +	bc->next_event = KTIME_MAX;
> +
> +	/*
> +	 * When the tick mode is switched from periodic to oneshot it must
> +	 * be ensured that CPUs which are waiting for periodic broadcast
> +	 * get their wake-up at the next tick.  This is achieved by ORing
> +	 * tick_broadcast_mask into tick_broadcast_oneshot_mask.
> +	 *
> +	 * For other callers, e.g. broadcast device replacement,
> +	 * tick_broadcast_oneshot_mask must not be touched as this would
> +	 * set bits for CPUs which are already NOHZ, but not idle. Their
> +	 * next tick_broadcast_enter() would observe the bit set and fail
> +	 * to update the expiry time and the broadcast event device.
> +	 */
> +	if (from_periodic) {
>  		cpumask_copy(tmpmask, tick_broadcast_mask);
> +		/* Remove the local CPU as it is obviously not idle */
>  		cpumask_clear_cpu(cpu, tmpmask);
> -		cpumask_or(tick_broadcast_oneshot_mask,
> -			   tick_broadcast_oneshot_mask, tmpmask);
> +		cpumask_or(tick_broadcast_oneshot_mask, tick_broadcast_oneshot_mask, tmpmask);
>  
> -		if (was_periodic && !cpumask_empty(tmpmask)) {
> -			ktime_t nextevt = tick_get_next_period();
> +		/*
> +		 * Ensure that the oneshot broadcast handler will wake the
> +		 * CPUs which are still waiting for periodic broadcast.
> +		 */
> +		nexttick = tick_get_next_period();
> +		tick_broadcast_init_next_event(tmpmask, nexttick);
>  
> -			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
> -			tick_broadcast_init_next_event(tmpmask, nextevt);
> -			tick_broadcast_set_event(bc, cpu, nextevt);
> -		} else
> -			bc->next_event = KTIME_MAX;
> -	} else {
>  		/*
> -		 * The first cpu which switches to oneshot mode sets
> -		 * the bit for all other cpus which are in the general
> -		 * (periodic) broadcast mask. So the bit is set and
> -		 * would prevent the first broadcast enter after this
> -		 * to program the bc device.
> +		 * If the underlying broadcast clock event device is
> +		 * already in oneshot state, then there is nothing to do.
> +		 * The device was already armed for the next tick
> +		 * in tick_handle_broadcast_periodic()
>  		 */
> -		tick_broadcast_clear_oneshot(cpu);
> +		if (clockevent_state_oneshot(bc))
> +			return;
>  	}
> +
> +	/*
> +	 * When switching from periodic to oneshot mode arm the broadcast
> +	 * device for the next tick.
> +	 *
> +	 * If the broadcast device has been replaced in oneshot mode and
> +	 * the oneshot broadcast mask is not empty, then arm it to expire
> +	 * immediately in order to reevaluate the next expiring timer.
> +	 * nexttick is 0 and therefore in the past which will cause the
> +	 * clockevent code to force an event.
> +	 *
> +	 * For both cases the programming can be avoided when the oneshot
> +	 * broadcast mask is empty.
> +	 *
> +	 * tick_broadcast_set_event() implicitly switches the broadcast
> +	 * device to oneshot state.
> +	 */
> +	if (!cpumask_empty(tick_broadcast_oneshot_mask))
> +		tick_broadcast_set_event(bc, cpu, nexttick);

For the case where the other CPUs have already installed their
tick devices and if that function is called with from_periodic=true,
the other CPUs will notice the oneshot change on their next call to
tick_broadcast_enter() thanks to the lock, right? So the tick broadcast
will keep firing until all CPUs have been through idle once and called
tick_broadcast_exit(), right? Because only them can clear themselves
from tick_broadcast_oneshot_mask, am I understanding this correctly?

I'm trying to find the opportunity for a race with dev->next_event
being seen as too far ahead in the future but can't manage so far...

Thanks.
