Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4363924A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiKYXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:44:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4343859FF0;
        Fri, 25 Nov 2022 15:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE26DB82C8C;
        Fri, 25 Nov 2022 23:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867C4C433D6;
        Fri, 25 Nov 2022 23:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669419846;
        bh=dx4KFqZ6EVEnjfrcSXRUt1F3Np6H36TlPzTa24JlEx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZihZxuLZ6WTXu6nyondE9tQSnFousiW66KNNMR8suvn9ygAJqzp4ufvTJbcothExe
         HNvsrPXtQoF8xhWyAUrH0Edp7GK2zaEOxx9Q9/QQ1apLau8oYjnKffLdy6GjP14iGm
         OhhEVjfxEQsGErGbID1aIY6kVXE2XX5E2jMsu7IjMqJVvCn+NVn5fSHFAz6xs86dt5
         d3GyQP8sxUXbXJC1n2daiv+oyaPeHzEfbjSRAsguD4PRzMn3Ewxc27qXDZTZ5WVM2i
         R879aTdgDi+/06ZO/xHjwB8Q9ACve5H/o7qayY45TX95q7My4yzXF+go9UIpBF+3Za
         K2Rjb3MbrsOTw==
Date:   Fri, 25 Nov 2022 23:44:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 3/3] clocksource: timer-riscv: Set
 CLOCK_EVT_FEAT_C3STOP based on DT
Message-ID: <Y4FTQenbPLXy/9Bz@spud>
References: <20221125112105.427045-1-apatel@ventanamicro.com>
 <20221125112105.427045-4-apatel@ventanamicro.com>
 <Y4C/YOoHxX5dxwG3@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4C/YOoHxX5dxwG3@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 01:13:04PM +0000, Conor Dooley wrote:
> On Fri, Nov 25, 2022 at 04:51:05PM +0530, Anup Patel wrote:
> > We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> > when riscv,timer-cant-wake-up DT property is present in the RISC-V
> > timer DT node.
> > 
> > This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> > based on RISC-V platform capabilities rather than having it set for
> > all RISC-V platforms.
> 
> I need to go do some testing on what setting the C3STOP flag does on
> platforms other than PolarFire SoC. I'm not sure that we should be
> enabling this flag *at all* until we know that it does not break on
> other platforms too.

I tried my fu540 & fu740 - both of those seem to exhibit broken timer
behaviour with C3STOP set. Ethernet doesn't work upstream on the
VisionFive, so I didn't go through the hassle of testing that - but I
would imagine it is the same as the fu740. Whenever I get a VisionFive 2
I'll give that a try too.

I did try the D1 (thanks for fielding my dumb questions Samuel) but I
was not able to get the thing to boot if I disabled the sunxi timer :/
Ethernet would not come up in U-Boot, clearly I did something not
right..

Obviously we need to fix things & get it backported etc, so taking a
pragmatic approach: I think that it is better to merge this stuff even
though it there's a pretty good chance I think that it'll break the
SBI timer on a D1, since it is not intended that it will be used.

It does make me worried about some of the other platforms though, like
that Bouffalolabs SoC that Jisheng sent in a DT for. It's also using
thead stuff so I wonder if it needs C3STOP too. I've added Jisheng to
CC :)

> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/clocksource/timer-riscv.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index a0d66fabf073..0c8bdd168a45 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -28,6 +28,7 @@
> >  #include <asm/timex.h>
> >  
> >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > +static bool riscv_timer_cant_wake_cpu;
> >  
> >  static int riscv_clock_next_event(unsigned long delta,
> >  		struct clock_event_device *ce)
> > @@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
> >  
> >  	ce->cpumask = cpumask_of(cpu);
> >  	ce->irq = riscv_clock_event_irq;
> > +	if (riscv_timer_cant_wake_cpu)
> > +		ce->features |= CLOCK_EVT_FEAT_C3STOP;
> >  	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
> >  
> >  	enable_percpu_irq(riscv_clock_event_irq,
> > @@ -139,6 +142,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> >  	if (cpuid != smp_processor_id())
> >  		return 0;
> >  
> > +	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
> > +	if (child) {
> > +		riscv_timer_cant_wake_cpu = of_property_read_bool(child,
> > +						"riscv,timer-cant-wake-cpu");
> > +		of_node_put(child);
> > +	}
> > +
> >  	domain = NULL;
> >  	child = of_get_compatible_child(n, "riscv,cpu-intc");
> >  	if (!child) {

Anyway, the mechanics of the change here look good to me. The re-use of
child is understandable but a little odd though, since riscv,timer /is
not/ actually a child. That's relatively minor thing to change though.

I'm still not happy about turning on C3STOP when we have not figured out
why it's breaking timer behaviour, but I think that's the lessor of two
evils. Somewhat reluctantly:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I'll try to spend some time looking into why it's broken.

Thanks,
Conor.

