Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0762563C64A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbiK2RR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiK2RR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:17:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEC26124;
        Tue, 29 Nov 2022 09:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9CF6186D;
        Tue, 29 Nov 2022 17:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2278CC433C1;
        Tue, 29 Nov 2022 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669742275;
        bh=j4z3J0ry4LI3/VTORpWZJtphzv1izE78JWgG7lR/3Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0XZp60OUgaSX9b2oURE0NkBldWPiVzpBd1f8qCCQykExGnSfJCu+dSv2kEcaCf9N
         qu2Ok1ai439ftZYrxZWXyc2KsvsH7bHc2+T1Ums7BnYLd5sgZvTsg5gmrHgwJX0MAE
         s/otXrepDuTD/9Z1fo8cH5t8grwebLxpleWyRST2SJETJoSkB4XpE36S+FBReHL4PP
         EwUFwUWrpD85E6mIjFkbHPSTn2n1L2I/XJWfNWIgQtyiyebm1D5v1S4GonRIPFf275
         HzpJfee0pDKysM3nGnmhapFEPxkyInzOOsMnvRU8F+ENemHgI3dPzGXn5g8V4oNdVI
         oaaQNlgoa0H+w==
Date:   Tue, 29 Nov 2022 17:17:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] clocksource: timer-riscv: Set
 CLOCK_EVT_FEAT_C3STOP based on DT
Message-ID: <Y4Y+vZ7qndV2c5Ai@spud>
References: <20221129140313.886192-1-apatel@ventanamicro.com>
 <20221129140313.886192-4-apatel@ventanamicro.com>
 <Y4YY6kBBEBdZoUIp@wendy>
 <CAAhSdy3dWGVV=jh5mzK=m63A3UAqwJhxidcAZQU_WC4TRNfCjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3dWGVV=jh5mzK=m63A3UAqwJhxidcAZQU_WC4TRNfCjQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:41:09PM +0530, Anup Patel wrote:
> On Tue, Nov 29, 2022 at 8:06 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > On Tue, Nov 29, 2022 at 07:33:13PM +0530, Anup Patel wrote:
> > > We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> > > when riscv,timer-cant-wake-up DT property is present in the RISC-V
> > > timer DT node.
> > >
> > > This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> > > based on RISC-V platform capabilities rather than having it set for
> > > all RISC-V platforms.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
> > I thought I had left an R-b on this one?
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Also, I think that we need to backport *something* that disables C3STOP
> > which is why I had suggested keeping the revert in place.
> > Patch 1 of this series only solves the timer issues but does not restore
> > sleep states to their prior behaviour, right?
> > Either this patch or the revert needs to go to stable IMO.
> 
> Since it works for you with the C3STOP set and broadcast timer enabled,
> we can directly go with this patch. I am fine including the revert as well.

I don't mind which gets backported. To me, this one is preferable as it
is more "complete" but it is a bit on the new feature side of things,
no?

Whoever applies it can decide, and I'll backport the revert if they
decide that this patch is not stable material :)

Thanks again for helping sort this mess out, I see it helped with your
IPI series too!

Conor.

> > > ---
> > >  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > > index 969a552da8d2..0c8bdd168a45 100644
> > > --- a/drivers/clocksource/timer-riscv.c
> > > +++ b/drivers/clocksource/timer-riscv.c
> > > @@ -28,6 +28,7 @@
> > >  #include <asm/timex.h>
> > >
> > >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > > +static bool riscv_timer_cant_wake_cpu;
> > >
> > >  static int riscv_clock_next_event(unsigned long delta,
> > >               struct clock_event_device *ce)
> > > @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long delta,
> > >  static unsigned int riscv_clock_event_irq;
> > >  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
> > >       .name                   = "riscv_timer_clockevent",
> > > -     .features               = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> > > +     .features               = CLOCK_EVT_FEAT_ONESHOT,
> > >       .rating                 = 100,
> > >       .set_next_event         = riscv_clock_next_event,
> > >  };
> > > @@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
> > >
> > >       ce->cpumask = cpumask_of(cpu);
> > >       ce->irq = riscv_clock_event_irq;
> > > +     if (riscv_timer_cant_wake_cpu)
> > > +             ce->features |= CLOCK_EVT_FEAT_C3STOP;
> > >       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
> > >
> > >       enable_percpu_irq(riscv_clock_event_irq,
> > > @@ -139,6 +142,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> > >       if (cpuid != smp_processor_id())
> > >               return 0;
> > >
> > > +     child = of_find_compatible_node(NULL, NULL, "riscv,timer");
> > > +     if (child) {
> > > +             riscv_timer_cant_wake_cpu = of_property_read_bool(child,
> > > +                                             "riscv,timer-cant-wake-cpu");
> > > +             of_node_put(child);
> > > +     }
> > > +
> > >       domain = NULL;
> > >       child = of_get_compatible_child(n, "riscv,cpu-intc");
> > >       if (!child) {
> > > --
> > > 2.34.1
> > >
