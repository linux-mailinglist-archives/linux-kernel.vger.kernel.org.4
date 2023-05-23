Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770C470DF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbjEWOfG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 10:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbjEWOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:35:03 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941831A8;
        Tue, 23 May 2023 07:34:53 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-96f72e6925cso112270266b.1;
        Tue, 23 May 2023 07:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684852492; x=1687444492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+VrszNlhxIXM0HmjR1ilVOhQszpK9Ryak4/ZUhq7+o=;
        b=b0NYHerIBnigHn2COolPwHArVQ7I4K4r0Kc6UUR2yLKgLtKI1en0FFhOOrRaTE4lzI
         /I3RrxYJ9lcrAlGrgrYR4ex8NS2psAF/8LAJI7pBohMfSlWT58Of5MwiiRHGZ47UOj1I
         JFUxn+D+1myT5y0GFqaMnHs4pW0U7fce91Ia+Wc9+AQgF4cZIKU3Okw36CIMX79p/Kf6
         KQpLbgmTM8bwnjGJ9XbAhnsBCh+khN0UvddWnMNkhL7V6mb+mrP0x3S2LwhFgIS8v6b6
         Y6fmv1w92d2EVX9XJFhg3uBytwmwBKeG43IwCmrw0qODn5pden6m0p/wJfW5ROdzPSjT
         1fIA==
X-Gm-Message-State: AC+VfDzDNkM8UXsIiX0OiskRkVibBmotO3noIK1HwCu3HpdmCHjfQhPS
        qEPrPy1PtbPc/uuhj7mY8S75vhVE3PDV9Nktxk4=
X-Google-Smtp-Source: ACHHUZ5OwVZKxMwPGesEN+Tn/pHyrdnfO4P2PabcQE9hiq0gFVs9Dwdm8m95lCF6oHXCxky0R0ldgPl1TEwqqbgCWRo=
X-Received: by 2002:a17:906:8f:b0:965:c518:4681 with SMTP id
 15-20020a170906008f00b00965c5184681mr12293680ejc.7.1684852492007; Tue, 23 May
 2023 07:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230523085045.29391-1-kweifat@gmail.com> <CAJZ5v0ifp1088wY7o=7pnBVBm=_3H0M4sfq6=gmyChZD6R9g1g@mail.gmail.com>
 <b5e35f904174905d8f90df3f49944b22389126c7.camel@linux.intel.com>
 <CAJZ5v0ioQm95ZQ5LCCoDtVNX1TVQN_=sgzB_RRe5SAOOucpWJg@mail.gmail.com> <96d81ba4c501134c77869a08b843b39fc1bf7526.camel@linux.intel.com>
In-Reply-To: <96d81ba4c501134c77869a08b843b39fc1bf7526.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 16:34:40 +0200
Message-ID: <CAJZ5v0gc7x6x+aAic+z=usJY-1nLMOFheEj4-JfPmB5-tWRRbA@mail.gmail.com>
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

On Tue, May 23, 2023 at 4:02 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-05-23 at 15:37 +0200, Rafael J. Wysocki wrote:
> > On Tue, May 23, 2023 at 2:20 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Tue, 2023-05-23 at 13:08 +0200, Rafael J. Wysocki wrote:
> > > > On Tue, May 23, 2023 at 10:51 AM Fieah Lim <kweifat@gmail.com>
> > > > wrote:
> > > > >
> > > > > We should avoid initializing some rather expensive data
> > > > > when the function has a chance to bail out earlier
> > > > > before actually using it.
> > > > > This applies to the following initializations:
> > > > >
> > > > >  - cpudata *cpu = all_cpu_data; (in everywhere)
> > > > >  - this_cpu = smp_processor_id(); (in notify_hwp_interrupt)
> > > > >  - hwp_cap = READ_ONCE(cpu->hwp_cap_cached); (in
> > > > > intel_pstate_hwp_boost_up)
> > > > >
> > > > > These initializations are premature because there is a chance
> > > > > that the function will bail out before actually using the data.
> > > > > I think this qualifies as a micro-optimization,
> > > > > especially in such a hot path.
> > > > >
> > > > > While at it, tidy up how and when we initialize
> > > > > all of the cpu_data pointers, for the sake of consistency.
> > > > >
> > > > > A side note on the intel_pstate_cpu_online change:
> > > > > we simply don't have to initialize cpudata just
> > > > > for the pr_debug, while policy->cpu is being there.
> > > > >
> > > > > Signed-off-by: Fieah Lim <kweifat@gmail.com>
> > > > > ---
> > > > > V1 -> V2: Rewrite changelog for better explanation.
> > > > >
> > >
> > > [...]
> > >
> > > > >  void notify_hwp_interrupt(void)
> > > > >  {
> > > > > -       unsigned int this_cpu = smp_processor_id();
> > > > > +       unsigned int this_cpu;
> > > > >         struct cpudata *cpudata;
> > > > >         unsigned long flags;
> > > > >         u64 value;
> > > > > @@ -1591,6 +1593,8 @@ void notify_hwp_interrupt(void)
> > > > >         if (!(value & 0x01))
> > > > >                 return;
> > > > >
> > > > > +       this_cpu = smp_processor_id();
> > > > > +
> > > > >         spin_lock_irqsave(&hwp_notify_lock, flags);
> > > > >
> > > > >         if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
> > > >
> > > > This is a place where it may really matter for performance, but
> > > > how
> > > > much?  Can you actually estimate this?
> > >
> > > If DEBUG_PREEMPT is defined
> > > ~12 instructions (most of them with latency = 1 in dependency
> > > chain)
> >
> > I really meant "estimate the effect of this change on performance",
> > because I'm not sure if it is going to be visible in any test.
> >
> > But yes, skipping it if not needed at least makes some sense.
> It will have neglible effect.

Well, I agree.

> I can measure it, but may be next week.

No need really.
