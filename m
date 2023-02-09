Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49D690DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBIQJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBIQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:09:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEB1C26AA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:09:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 001BEFEC;
        Thu,  9 Feb 2023 08:09:46 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B65A3F8C6;
        Thu,  9 Feb 2023 08:09:01 -0800 (PST)
Date:   Thu, 9 Feb 2023 16:08:58 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>, wsd_upstream@mediatek.com,
        stanley.chu@mediatek.com, Chun-hung.Wu@mediatek.com,
        Freddy.Hsin@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
Message-ID: <20230209160858.ujz26zcnizap5lqw@bogus>
References: <20230208094813.20874-1-walter.chang@mediatek.com>
 <20230208094813.20874-2-walter.chang@mediatek.com>
 <e1a89a4e-8a0d-47e1-a8fd-75ea152ef816@linaro.org>
 <ad3a5c30-5062-55ae-7908-c0a127bec5ee@gmail.com>
 <3bbc55b8-6b12-4e81-026d-75e0c9116a7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbc55b8-6b12-4e81-026d-75e0c9116a7b@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:45:15PM +0100, Krzysztof Kozlowski wrote:
> On 08/02/2023 20:41, Matthias Brugger wrote:
> > On 08/02/2023 15:24, Krzysztof Kozlowski wrote:
> >> On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
> >>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> >>>
> >>> clocksource driver may use sched_clock_register()
> >>> to resigter itself as a sched_clock source.
> >>> Export it to support building such driver
> >>> as module, like timer-mediatek.c
> >>>
> >>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> >>> ---
> >>>   kernel/time/sched_clock.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> >>> index 8464c5acc913..8e49e87d1221 100644
> >>> --- a/kernel/time/sched_clock.c
> >>> +++ b/kernel/time/sched_clock.c
> >>> @@ -150,8 +150,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
> >>>   	return HRTIMER_RESTART;
> >>>   }
> >>>   
> >>> -void __init
> >>> -sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
> >>> +void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
> >>
> >> Is there a non-init caller?
> >>
> >>>   {
> >>>   	u64 res, wrap, new_mask, new_epoch, cyc, ns;
> >>>   	u32 new_mult, new_shift;
> >>> @@ -223,6 +222,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
> >>>   
> >>>   	pr_debug("Registered %pS as sched_clock source\n", read);
> >>>   }
> >>> +EXPORT_SYMBOL_GPL(sched_clock_register);
> >>
> >> Where is the module using it?
> >>
> >> You need to bring users of these two changes, not just prepare something
> >> for your out of tree patches.
> >>
> > 
> > I'd propose to add at least one driver that will need these changes, to make it 
> > clear why you need that.
> 
> ... and actually test if the system works fine when booted from such
> clocksource as a module. I have doubts that and unfortunately folks
> working on GKI like to put whatever stuff from mainline into modules
> even if it does not make sense for us (see long time ago discussion
> about pinctrl drivers).

Just to add, system boot test with these as modules are not sufficient
based on the usage of such timers. I am aware of systems where arm
architected timer are functional in normal running state of the CPU.
They may have bugs/errata where these arch timers(mmio access) are not
available when CPUs enter low power idle states. Generally, CPUs enter
idle states on boot, but one CPU may not as it will act as broadcast timer.
With this added timer, they may achieve all CPUs entering idle states
properly.

In short the system might be bootable w/o such timers but not power
efficient. We need to tests that involve loading and unloading of such
modules to see if the transition between this timer as broadcast and one
CPU itself as broadcast happens correctly and system survives across such
loading and unloading of the modules.

Note I am not for/against allowing the such timer as module, but just
adding possible testcase to pass to consider if we are allowing it.

--
Regards,
Sudeep
