Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9CE70DD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjEWNhm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjEWNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:37:39 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F61DCA;
        Tue, 23 May 2023 06:37:38 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96ffba243b1so52377366b.0;
        Tue, 23 May 2023 06:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684849057; x=1687441057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTOVQSwHwdcqFwCeAzjs0914zunxaGgHWWXc+AF0OJE=;
        b=QQ5PZ3+lerpuhhbqdaubz2QdUnxhcypeTEJz/CRiK7FNamO14RJ4Gt+BSJdrH/8+5U
         MfeeBaOsklbULdmTPG4n60tya8i1Fl6wcsqJSNm2vUJ275xHq8vZfxUg0xXMko0CRFh6
         19cDoB/uxyES+6w7FOZf6O4koJYDzetPHt/Kel+b2dBw4x4akrqIT8RknLkVEUWSkQi8
         B2AMBq3XKlKHfU9NN9SdIej4+mIHCAnjCP9Ws3PwcD39jrV798DrS5BJAXX5NXXuEvBi
         aqRZBpcvpZKL9WmorwP39kdwbQAh7+glGm9E8s/hTtmAcLWfdVEtRtuypTNNl2Llo3e5
         HA4A==
X-Gm-Message-State: AC+VfDwNYFrz5KHoKrZFnIRUgZKA50qPUlTMLUSVljY3ATrX75oCWq5i
        PCf8oFFwczOTpXhHmr0KrJ1sNrEm5i0hwMz8cZk=
X-Google-Smtp-Source: ACHHUZ7+vL++Xxy2h/4Tq46DRc3VvN3aqVV1T9mjBb/FJbkyCUkTal8gSVhHA2wxAoSPqFqdJQ4R3BHuW288pLHbZN0=
X-Received: by 2002:a17:906:7a50:b0:94a:5f0d:d9d6 with SMTP id
 i16-20020a1709067a5000b0094a5f0dd9d6mr10904249ejo.4.1684849056661; Tue, 23
 May 2023 06:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230523085045.29391-1-kweifat@gmail.com> <CAJZ5v0ifp1088wY7o=7pnBVBm=_3H0M4sfq6=gmyChZD6R9g1g@mail.gmail.com>
 <b5e35f904174905d8f90df3f49944b22389126c7.camel@linux.intel.com>
In-Reply-To: <b5e35f904174905d8f90df3f49944b22389126c7.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 15:37:25 +0200
Message-ID: <CAJZ5v0ioQm95ZQ5LCCoDtVNX1TVQN_=sgzB_RRe5SAOOucpWJg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Avoid initializing variables prematurely
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Fieah Lim <kweifat@gmail.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 2:20 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-05-23 at 13:08 +0200, Rafael J. Wysocki wrote:
> > On Tue, May 23, 2023 at 10:51 AM Fieah Lim <kweifat@gmail.com> wrote:
> > >
> > > We should avoid initializing some rather expensive data
> > > when the function has a chance to bail out earlier
> > > before actually using it.
> > > This applies to the following initializations:
> > >
> > >  - cpudata *cpu = all_cpu_data; (in everywhere)
> > >  - this_cpu = smp_processor_id(); (in notify_hwp_interrupt)
> > >  - hwp_cap = READ_ONCE(cpu->hwp_cap_cached); (in
> > > intel_pstate_hwp_boost_up)
> > >
> > > These initializations are premature because there is a chance
> > > that the function will bail out before actually using the data.
> > > I think this qualifies as a micro-optimization,
> > > especially in such a hot path.
> > >
> > > While at it, tidy up how and when we initialize
> > > all of the cpu_data pointers, for the sake of consistency.
> > >
> > > A side note on the intel_pstate_cpu_online change:
> > > we simply don't have to initialize cpudata just
> > > for the pr_debug, while policy->cpu is being there.
> > >
> > > Signed-off-by: Fieah Lim <kweifat@gmail.com>
> > > ---
> > > V1 -> V2: Rewrite changelog for better explanation.
> > >
>
> [...]
>
> > >  void notify_hwp_interrupt(void)
> > >  {
> > > -       unsigned int this_cpu = smp_processor_id();
> > > +       unsigned int this_cpu;
> > >         struct cpudata *cpudata;
> > >         unsigned long flags;
> > >         u64 value;
> > > @@ -1591,6 +1593,8 @@ void notify_hwp_interrupt(void)
> > >         if (!(value & 0x01))
> > >                 return;
> > >
> > > +       this_cpu = smp_processor_id();
> > > +
> > >         spin_lock_irqsave(&hwp_notify_lock, flags);
> > >
> > >         if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
> >
> > This is a place where it may really matter for performance, but how
> > much?  Can you actually estimate this?
>
> If DEBUG_PREEMPT is defined
> ~12 instructions (most of them with latency = 1 in dependency chain)

I really meant "estimate the effect of this change on performance",
because I'm not sure if it is going to be visible in any test.

But yes, skipping it if not needed at least makes some sense.
