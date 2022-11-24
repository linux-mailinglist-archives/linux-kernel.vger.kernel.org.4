Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F0637055
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKXCTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKXCTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:19:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4889898FF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:19:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ci10so258344pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=21lSEg2vXSFoHO1msB/0t+aM934kgEehRE9bwrPsG98=;
        b=M++o8EzByfjyBaiqS+e8UmHNUp76zCjYvMqojZ3+KoXa0b1R3CqyVD8fjxyaB74FAX
         neRRiN4/Q1GD7r9njMwcThpT7w4oJWkGBCW5TPD9DCrrMIIE8Is7bQidYJ1Ceyrm8YIE
         e5DClzN4jeOXladpv5A5uDUcyOiGRu8UCad8XPNGOPLameYXrKL/1M89sVflNue7u8Uo
         784jqZ+R7yYVOs14A3OxfrZci4O7oYV9kaEhs2guYgyGdk40wYXIV2COwqDFrDhhcDpu
         5STo2CrgeMM83O9xrhjpdG9jqoxn/G6By3ujxqdqZWFbIe4+U3uPemVLlsVJR4tWN9Z8
         6aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21lSEg2vXSFoHO1msB/0t+aM934kgEehRE9bwrPsG98=;
        b=ZjocblTnjHYc5tRFL2VIZyDCGLRkjQSwuvA4ewTYQfzs6FYLtACvRuBbPSJJ74kPOJ
         +W9qhUI8+y1Q8R/va70S1fcn4+4g5aBZSuoKviD/GqYER3vjbKVDXCOTFlNlRyzlbXAS
         IzHyzQIy7HYaSTFJNUIngeaZOeD2e/jmqE82Uxv2JEYFjYJC+63NoVheApK4gl44qzzd
         C1hPJpcChRPhtS1M7+cB+I9Zq9Cl8a93bZNQzRG5PUsTL/fMGR5XXJu2XwzpX1Mt9oIY
         TxtfjnbtQj6tCRLcto7hTPqYaFRbFQ6aRSiBBwXGsKtMGm7VIxMJTA1BWvh/JD0btAXK
         TUxA==
X-Gm-Message-State: ANoB5pn/FrgVMcr/lGG/N4J89byc2SXrDflWNcaU/0Ol8xdHQ3ekQIRQ
        RugNAwmu7MlJCgHO0NeDQHEzEuqHB+snp6sCor4=
X-Google-Smtp-Source: AA0mqf7sCcwj/0deayiyopQsUgF0aXV/P1BLzhFeCXXjGFm3ZD27pTDb1KpYV/ifmNUanYNhuL/oTqLbNcHWov6h+5g=
X-Received: by 2002:a17:90a:2a09:b0:218:7040:886e with SMTP id
 i9-20020a17090a2a0900b002187040886emr3119248pjd.1.1669256342183; Wed, 23 Nov
 2022 18:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20221121035140.118651-1-zhouzhouyi@gmail.com> <20221123223658.GC1395324@lothringen>
In-Reply-To: <20221123223658.GC1395324@lothringen>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 24 Nov 2022 10:18:51 +0800
Message-ID: <CAABZP2yDMTKqkj6r+hsQb=3zdoXOWMQ8Z3QKSxaaVTWv2eS-kw@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 24, 2022 at 6:37 AM Frederic Weisbecker <frederic@kernel.org> wrote:
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
>
> Please rather make a function for this. This is an internal value
> that we don't want to expose to modules.
>
> This can be:
>
>      int tick_nohz_full_timekeeper(void)
>      {
>          if (tick_nohz_full_enabled() && tick_do_timer_cpu >= 0)
>              return tick_do_timer_cpu;
>          else
>              return nr_cpu_ids;
>      }
>
> And then just check if the value is below nr_cpu_ids.
Thank Paul and Frederic both for your guidance!

Things are much easier;-) and I will do it.

Cheers
Zhouyi
>
> Thanks.
