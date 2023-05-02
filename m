Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7276F4285
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjEBLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBLTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD7A4
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7714262331
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 11:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A95FC433EF;
        Tue,  2 May 2023 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683026344;
        bh=Nq40uZ7fxt3ZgHa/fq73UnZ8ah1ib0VIWnSEhVYGrbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6b8RLOGa0oeSMGyHmlrb3fNJo3NQQzDi6fK1Uz+3lFL+j/9pX4vj+LMMrwn7oQR/
         TWYRx29KxBIreoAiuR6u3fNmD0bz5cd6U9dbKMgrcxWo4ZW1L4n21VBSn519duMQig
         358XMzzS1ThJYIw0VY6B3SNNx+oxhbQCgRV6H45SAbvMmJdZ5uva+fy2+GF8DT3vfg
         n+IdehbijBZyjTNBc6TGSXTBtmWflTZL/ZyoJ9jiD1RqpS1Dv4ToxkIT3Bv1aRz4DC
         PNkTNd48bIAetE+wzX1szsUp9iuQYeZmiYqQzwSOb/K+TaMEVpxNO0O5VrfDwVzPGb
         BEyJ9ybaEbsoQ==
Date:   Tue, 2 May 2023 13:19:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZFDxph8YDPjwvbej@lothringen>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
 <ZD/uWdz7dKLKlUqH@localhost.localdomain>
 <87jzy42a74.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzy42a74.ffs@tglx>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:32:15PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 19 2023 at 15:36, Frederic Weisbecker wrote:
> This path is taken during the switch from periodic to oneshot mode. The
> way how this works is:
> 
> boot()
>   setup_periodic()
>     setup_periodic_broadcast()
> 
>   // From here on everything depends on the periodic broadcasting
> 
>   highres_clocksource_becomes_available()
>     tick_clock_notify() <- Set's the .check_clocks bit on all CPUs
> 
> Now the first CPU which observes that bit switches to oneshot mode, but
> the other CPUs might be waiting for the periodic broadcast at that
> point. So the periodic to oneshot transition does:
> 
>   		cpumask_copy(tmpmask, tick_broadcast_mask);
> 		/* Remove the local CPU as it is obviously not idle */
>   		cpumask_clear_cpu(cpu, tmpmask);
> 		cpumask_or(tick_broadcast_oneshot_mask, tick_broadcast_oneshot_mask, tmpmask);
> 
> I.e. it makes sure that _ALL_ not yet converted CPUs will get woken up
> by the new oneshot broadcast handler. 
> 
> Now when the other CPUs will observe the check_clock bit after that they
> need to clear their bit in the oneshot mask while switching themself
> from periodic to oneshot one otherwise the next tick_broadcast_enter()
> would do nothing. That's all serialized by broadcast lock, so no race.
> 
> But that has nothing to do with switching the underlying clockevent
> device. At that point all CPUs are already in oneshot mode and
> tick_broadcast_oneshot_mask is correct.
> 
> So that will take the other code path:
> 
>     if (bc->event_handler == tick_handle_oneshot_broadcast) {
>        // not taken because the new device is not yet set up
>        return;
>     }
> 
>     if (from_periodic) {
>        // not taken because the switchover already happened
>        // Here is where the cpumask magic happens
>     }
>

I see, I guess I got lost somewhere into the tree of the possible
callchains :)

tick_broadcast_setup_oneshot()
	tick_broadcast_switch_to_oneshot
		tick_install_broadcast_device
			tick_check_new_device
				clockevents_notify_released
					clockevents_register_device (new device)
				clockevents_register_device (new device)
		tick_switch_to_oneshot
			tick_init_highres
				 hrtimer_switch_to_hres
					hrtimer_run_queues (timer softirq)
			tick_nohz_switch_to_nohz
				tick_check_oneshot_change (test and clear check_clock)
					hrtimer_run_queues (timer softirq))
	tick_device_uses_broadcast
		tick_setup_device
			tick_install_replacement
				clockevents_replace
					__clockevents_unbind
						clockevents_unbind
							unbind_device_store (sysfs)
							clockevents_unbind_device (driver)
			tick_check_new_device
				clockevents_notify_released
					clockevents_register_device (new device)
				clockevents_register_device (new device)
	tick_broadcast_control
		tick_broadcast_enable (cpuidle driver register, cpu up, ...)
		tick_broadcast_disable (cpuidle driver unregister, ...)
		tick_broadcast_force (amd apic bug setup)


Ok I get the check_clock game. But then, why do we need to reprogram
again the broadcast device to fire in one jiffy if the caller is
tick_nohz_switch_to_nohz() (that is the (bc->event_handler ==
tick_handle_oneshot_broadcast) branch)? In that case the broadcast device
should have been programmed already by the CPU that first switched the
current broadcast device, right?

> > For the case where the other CPUs have already installed their
> > tick devices and if that function is called with from_periodic=true,
> > the other CPUs will notice the oneshot change on their next call to
> > tick_broadcast_enter() thanks to the lock, right? So the tick broadcast
> > will keep firing until all CPUs have been through idle once and called
> > tick_broadcast_exit(), right? Because only them can clear themselves
> > from tick_broadcast_oneshot_mask, am I understanding this correctly?
> 
> No. See above. It's about the check_clock bit handling on the other
> CPUs.
> 
> It seems I failed miserably to explain that coherently with the tons of
> comments added. Hrmpf :(

Don't pay too much attention, confusion is my vehicle to explore any code
that I'm not used to. But yes I must confess the
(bc->event_handler == tick_handle_oneshot_broadcast) may deserve a comment
remaining where we come from (ie: low-res hrtimer softirq).

Thanks.
