Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB9D634DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiKWCXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiKWCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:23:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72095D14EF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:23:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g5so6262979pjp.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhsEomGEcHS0ITrqbixOcvOCHqtbhvqSM8S3bsVjuhw=;
        b=LJY60C9hm82Ajktbt56J964gyIfZ54hQakqP+9JsoTzhGcASSBupESEzfFhC1ztM2s
         HiL53/9c/jaw0PF9LDHlu1OHxtZ2zagtdcaTeGlcX8TOV3lPjekZupUIO/wpULT7kaSl
         mbMKtQWl6b3azlYxFblm+q1LmMXohPIsnCVnd32al1eRsrrMQiEFVe3ADMw2hy8agotb
         nRcNg3zkbYFf/w5Nlc/4VEKUYEu/hebU4TbfMGgCe8p5AmeG+YsSCzYCLWe/2OD//+nv
         pJr2gzQe/jsJiCFB3Ev7gSgUq58EUZcR/M5Xn0R/pbnBVn70C58QPMrcHmBOp1LwiV5s
         +VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhsEomGEcHS0ITrqbixOcvOCHqtbhvqSM8S3bsVjuhw=;
        b=EHeHT68/AP2DAjt27ay7BNXqmWuzJRhWIZnvTx3QIo3/M4cblHGJuEHXEXFtwEIKuO
         2vgC0KwhUqFkuVLSIHTyi54qwxFlAI7MRTzxYtR43bbLdqnCwQBJxh6H4Q29poR3yBF1
         LNkI224VwOOfP0oATeiTLZTnI5Rck1kwvfUp+bcnnhlO8mhyvkCm6UR+PdSM4me1evV0
         qP/fWZjedKMPiVaD+3SwxAAojhemTfxLlEouaQginLbp0b27WP2qQHrxWLcD8xlSi647
         bdZZWeuY7SxLQR5OlOlMblnOfm17I6WUSZ/ZCl4gCzKEkN84SKvxk/hy+xxxXmrvuvAB
         HJ+Q==
X-Gm-Message-State: ANoB5pksdLmKdLsfubOrjJXJOxcZQfCGeDEmuui/AXNNpR2DrQsYsoqP
        EPhVBhslXugqy7qVZTkvinfvQlaqnqUqhGIMulI=
X-Google-Smtp-Source: AA0mqf5DzRfWvrQG/Bl7rr76l1lOWBNm9IPBe18oEPOXIHBRs4mQ59hc13n+lkHpHP9XCgc3CCVrsr6dKZEPIGA4J0Y=
X-Received: by 2002:a17:90a:9403:b0:218:6a4e:e44a with SMTP id
 r3-20020a17090a940300b002186a4ee44amr29392875pjo.6.1669170202991; Tue, 22 Nov
 2022 18:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20221121035140.118651-1-zhouzhouyi@gmail.com> <20221122013754.GY4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221122013754.GY4001@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 23 Nov 2022 10:23:11 +0800
Message-ID: <CAABZP2z5CLJg4tabNwDMopiNZTZYGC++Z9w6ZOhhGrXQHGMGUA@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
To:     paulmck@kernel.org
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        dave@stgolabs.net, josh@joshtriplett.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 9:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Nov 21, 2022 at 11:51:40AM +0800, Zhouyi Zhou wrote:
> > During CPU-hotplug torture (CONFIG_NO_HZ_FULL=y), if we try to
> > offline tick_do_timer_cpu, the operation will fail because in
> > function tick_nohz_cpu_down:
> > ```
> > if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
> >       return -EBUSY;
> > ```
> > Above bug was first discovered in torture tests performed in PPC VM
> > of Open Source Lab of Oregon State University, and reproducable in RISC-V
> > and X86-64 (with additional kernel commandline cpu0_hotplug).
> >
> > In this patch, we avoid offline tick_do_timer_cpu by distribute
> > the offlining cpu among remaining cpus.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> Good show chasing this down!
Thank Paul for your guidance and encouragement!
>
> A couple of questions below.
The answers below.
>
> > ---
> >  include/linux/tick.h        |  1 +
> >  kernel/time/tick-common.c   |  1 +
> >  kernel/time/tick-internal.h |  1 -
> >  kernel/torture.c            | 10 ++++++++++
> >  4 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index bfd571f18cfd..23cc0b205853 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/rcupdate.h>
> >
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> > +extern int tick_do_timer_cpu __read_mostly;
> >  extern void __init tick_init(void);
> >  /* Should be core only, but ARM BL switcher requires it */
> >  extern void tick_suspend_local(void);
> > diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> > index 46789356f856..87b9b9afa320 100644
> > --- a/kernel/time/tick-common.c
> > +++ b/kernel/time/tick-common.c
> > @@ -48,6 +48,7 @@ ktime_t tick_next_period;
> >   *    procedure also covers cpu hotplug.
> >   */
> >  int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
> > +EXPORT_SYMBOL_GPL(tick_do_timer_cpu);
> >  #ifdef CONFIG_NO_HZ_FULL
> >  /*
> >   * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
> > diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> > index 649f2b48e8f0..8953dca10fdd 100644
> > --- a/kernel/time/tick-internal.h
> > +++ b/kernel/time/tick-internal.h
> > @@ -15,7 +15,6 @@
> >
> >  DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
> >  extern ktime_t tick_next_period;
> > -extern int tick_do_timer_cpu __read_mostly;
> >
> >  extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
> >  extern void tick_handle_periodic(struct clock_event_device *dev);
> > diff --git a/kernel/torture.c b/kernel/torture.c
> > index 789aeb0e1159..bccbdd33dda2 100644
> > --- a/kernel/torture.c
> > +++ b/kernel/torture.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/stat.h>
> >  #include <linux/slab.h>
> > +#include <linux/tick.h>
> >  #include <linux/trace_clock.h>
> >  #include <linux/ktime.h>
> >  #include <asm/byteorder.h>
> > @@ -358,7 +359,16 @@ torture_onoff(void *arg)
> >                       schedule_timeout_interruptible(HZ / 10);
> >                       continue;
> >               }
> > +#ifdef CONFIG_NO_HZ_FULL
> > +             /* do not offline tick do timer cpu */
> > +             if (tick_nohz_full_running) {
> > +                     cpu = (torture_random(&rand) >> 4) % maxcpu;
> > +                     if (cpu >= tick_do_timer_cpu)
>
> Why is this ">=" instead of "=="?
I use probability theory here to let the remaining cpu distribute evenly.
Example:
we have cpus: 0 1 2 3 4 5 6 7
maxcpu = 7
tick_do_timer_cpu = 2
remaining cpus are: 0 1 3 4 5 6 7
if the offline cpu candidate is 2, then the result cpu is 2+1
else if the offline cpu candidate is 3, then the result cpu is 3+1
...
else if the offline cpu candidate is 6, then the result cpu is 6+1
>
> > +                             cpu = (cpu + 1) % (maxcpu + 1);
we could just use cpu = cpu + 1 here
> > +             } else
> > +#else
> >               cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
> > +#endif
>
> What happens if the value of tick_do_timer_cpu changes between the time of
> the check above and the call to torture_offline() below?  Alternatively,
> how is such a change in value prevented?
I did a preliminary research about the above question, this is quite
complicated for me
(because I think I must not bring locks to kernel just because our
test frame need them),
Please give me some days to perform intensive research.

Thanks again
Cheers
Zhouyi
>
>                                                         Thanx, Paul
>
> >               if (!torture_offline(cpu,
> >                                    &n_offline_attempts, &n_offline_successes,
> >                                    &sum_offline, &min_offline, &max_offline))
> > --
> > 2.34.1
> >
