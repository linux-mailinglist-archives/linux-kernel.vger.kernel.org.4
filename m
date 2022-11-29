Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9E63C750
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiK2Snx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiK2Snv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:43:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EEF24F2A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:43:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y4so14311798plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIP9oJ9P+APqb6Nuc1oFCXi9Ku92JtxYoKl2iytzunU=;
        b=q3vblXcbmKuJHwVKfmwgfjy9/h4v0009YQb+0/FuwZ3Iz1csn6IZnsw5WdOAK6Bu+s
         lIsdvWmKpPYbHoqKvFZXyVqvjv1uy74XWP8+h1ZCm+EgJYF3Nw/b000sk+ErQNOyW+16
         N9nqb0EChxhay9SNzmCT53O0LKeIHgWshnVZH6cHxYm1s3qlsSJWYnBM8RAw5d6K+lja
         wYA/EX6BkBs0tJrwy69C64qsAQJgHNE936RwiiRtC/dsOQ9XDSuQfxkzSoAfxSnzoCvB
         vvWyI20zoJNU0tu6q2KvDXH8CS4tEH+/qWYMLrSoZKZWS0mc1E+GwOHwvaRxj6+bmhpO
         dwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIP9oJ9P+APqb6Nuc1oFCXi9Ku92JtxYoKl2iytzunU=;
        b=vPRLUc9JT1sGrrXU/z63bnOhEbnwYTzRYpY6X9AwpcWgO632mpE6q5RRIriVgfovTG
         Dy4UpT3vyIduFHTxZORq6i+WtRVb0RVTyRcI013Mge2Yj9Uu18AitQ7d87MUGwrVWeK1
         NNZuOdTuh0/XlDVm9nsNQr7v2qsnW51JIx9g9AASj1W071q5n5qzab6H9A4H59XFTOvn
         7ubAHGw75FHWe3zsOZhlF6dN5g3NnG5z6dtcDC87Ix34Es59kCibF17HGN7Kvl7Bt7G8
         hf7+Z6Q2Rs4W/QMs2SbtJIxKCJ6vPqq4J0dr0KqU4ws/dHGB4/SfGEHGesn2fv2lfpbT
         f7VQ==
X-Gm-Message-State: ANoB5pljig0h2TCrmtxlge5NB3esCRSIDcAspnsrn35tKZq6kihhd/5t
        BdmZT+bp3c/HnN6a0lFU91+gOA==
X-Google-Smtp-Source: AA0mqf4IeSQwsDl+1u45CxVm1HfRMtXFY7QhkodjxiwdD7ipkX2OKjUhJJbujpe8qWB0ItynPWazag==
X-Received: by 2002:a17:902:7443:b0:189:82da:7b70 with SMTP id e3-20020a170902744300b0018982da7b70mr13878354plt.159.1669747429462;
        Tue, 29 Nov 2022 10:43:49 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001743ba85d39sm11243785plg.110.2022.11.29.10.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:43:48 -0800 (PST)
Date:   Tue, 29 Nov 2022 10:43:48 -0800 (PST)
X-Google-Original-Date: Tue, 29 Nov 2022 10:43:38 PST (-0800)
Subject:     Re: [PATCH v4 3/3] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT
In-Reply-To: <CAK9=C2VtgCOk9S_FucJbwsG+nMuBqEsFk3sAMt7_doAKsMHQ8w@mail.gmail.com>
CC:     Conor Dooley <conor@kernel.org>, anup@brainfault.org,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        ajones@ventanamicro.com, atishp@atishpatra.org,
        samuel@sholland.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-7ff4d7f4-bbf5-45bf-b4c5-30bc2a53119c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 09:22:22 PST (-0800), apatel@ventanamicro.com wrote:
> On Tue, Nov 29, 2022 at 10:47 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Tue, Nov 29, 2022 at 10:41:09PM +0530, Anup Patel wrote:
>> > On Tue, Nov 29, 2022 at 8:06 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>> > >
>> > > On Tue, Nov 29, 2022 at 07:33:13PM +0530, Anup Patel wrote:
>> > > > We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
>> > > > when riscv,timer-cant-wake-up DT property is present in the RISC-V
>> > > > timer DT node.
>> > > >
>> > > > This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
>> > > > based on RISC-V platform capabilities rather than having it set for
>> > > > all RISC-V platforms.
>> > > >
>> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> > >
>> > > I thought I had left an R-b on this one?
>> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> > >
>> > > Also, I think that we need to backport *something* that disables C3STOP
>> > > which is why I had suggested keeping the revert in place.
>> > > Patch 1 of this series only solves the timer issues but does not restore
>> > > sleep states to their prior behaviour, right?
>> > > Either this patch or the revert needs to go to stable IMO.
>> >
>> > Since it works for you with the C3STOP set and broadcast timer enabled,
>> > we can directly go with this patch. I am fine including the revert as well.
>>
>> I don't mind which gets backported. To me, this one is preferable as it
>> is more "complete" but it is a bit on the new feature side of things,
>> no?
>>
>> Whoever applies it can decide, and I'll backport the revert if they
>> decide that this patch is not stable material :)

IIRC the clock folks took the original C3 patch, so that's probably the 
best way to take these as well?

>>
>> Thanks again for helping sort this mess out, I see it helped with your
>> IPI series too!
>
> Yes, I was surprised to see that it helped the IPI series as well.
> Thanks for your patch.
>
> Regards,
> Anup
>
>>
>> Conor.
>>
>> > > > ---
>> > > >  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
>> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> > > > index 969a552da8d2..0c8bdd168a45 100644
>> > > > --- a/drivers/clocksource/timer-riscv.c
>> > > > +++ b/drivers/clocksource/timer-riscv.c
>> > > > @@ -28,6 +28,7 @@
>> > > >  #include <asm/timex.h>
>> > > >
>> > > >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
>> > > > +static bool riscv_timer_cant_wake_cpu;
>> > > >
>> > > >  static int riscv_clock_next_event(unsigned long delta,
>> > > >               struct clock_event_device *ce)
>> > > > @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long delta,
>> > > >  static unsigned int riscv_clock_event_irq;
>> > > >  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>> > > >       .name                   = "riscv_timer_clockevent",
>> > > > -     .features               = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
>> > > > +     .features               = CLOCK_EVT_FEAT_ONESHOT,
>> > > >       .rating                 = 100,
>> > > >       .set_next_event         = riscv_clock_next_event,
>> > > >  };
>> > > > @@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>> > > >
>> > > >       ce->cpumask = cpumask_of(cpu);
>> > > >       ce->irq = riscv_clock_event_irq;
>> > > > +     if (riscv_timer_cant_wake_cpu)
>> > > > +             ce->features |= CLOCK_EVT_FEAT_C3STOP;
>> > > >       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>> > > >
>> > > >       enable_percpu_irq(riscv_clock_event_irq,
>> > > > @@ -139,6 +142,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>> > > >       if (cpuid != smp_processor_id())
>> > > >               return 0;
>> > > >
>> > > > +     child = of_find_compatible_node(NULL, NULL, "riscv,timer");
>> > > > +     if (child) {
>> > > > +             riscv_timer_cant_wake_cpu = of_property_read_bool(child,
>> > > > +                                             "riscv,timer-cant-wake-cpu");
>> > > > +             of_node_put(child);
>> > > > +     }
>> > > > +
>> > > >       domain = NULL;
>> > > >       child = of_get_compatible_child(n, "riscv,cpu-intc");
>> > > >       if (!child) {
>> > > > --
>> > > > 2.34.1
>> > > >
