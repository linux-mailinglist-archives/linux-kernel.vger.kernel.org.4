Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A170F565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjEXLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjEXLgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:36:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA13C5;
        Wed, 24 May 2023 04:36:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9C4BE1FDC9;
        Wed, 24 May 2023 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684928179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwAKYD0z8pW+9JaKpkN3toV9DOYGVk/tLA54UTMvFvs=;
        b=fuotTz0Kyq5RkgGokrnxG609dhdlh7eXS5CeqjYq8WXFYQqLE3agWtLLSFpliodMeB7s5V
        xx7rusJnt2o8u0wKAllTdf9IBYj+WdwndCGv/le9IbX/t2yIPOWBM2uADVMEuQDfpGTlvu
        EOMqQltqypCXcFmrWIB/10NPqWeXfio=
Received: from suse.cz (dhcp129.suse.cz [10.100.51.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7D0452C141;
        Wed, 24 May 2023 11:36:15 +0000 (UTC)
Date:   Wed, 24 May 2023 13:36:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 10/18] watchdog/hardlockup: Add a "cpu" param to
 watchdog_hardlockup_check()
Message-ID: <ZG32r9Izc9K1Z3IJ@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.10.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid>
 <ZGzjm9h85fpYZJMc@alley>
 <CAD=FV=VeGKTvw2=qhSqkSEtYwVrXGLNzNbgBAwrmn2CWWfJckQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VeGKTvw2=qhSqkSEtYwVrXGLNzNbgBAwrmn2CWWfJckQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-05-23 09:34:37, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 23, 2023 at 9:02 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Fri 2023-05-19 10:18:34, Douglas Anderson wrote:
> > > In preparation for the buddy hardlockup detector where the CPU
> > > checking for lockup might not be the currently running CPU, add a
> > > "cpu" parameter to watchdog_hardlockup_check().
> > >
> > > As part of this change, make hrtimer_interrupts an atomic_t since now
> > > the CPU incrementing the value and the CPU reading the value might be
> > > different. Technially this could also be done with just READ_ONCE and
> > > WRITE_ONCE, but atomic_t feels a little cleaner in this case.
> > >
> > > While hrtimer_interrupts is made atomic_t, we change
> > > hrtimer_interrupts_saved from "unsigned long" to "int". The "int" is
> > > needed to match the data type backing atomic_t for hrtimer_interrupts.
> > > Even if this changes us from 64-bits to 32-bits (which I don't think
> > > is true for most compilers), it doesn't really matter. All we ever do
> > > is increment it every few seconds and compare it to an old value so
> > > 32-bits is fine (even 16-bits would be). The "signed" vs "unsigned"
> > > also doesn't matter for simple equality comparisons.
> > >
> > > hrtimer_interrupts_saved is _not_ switched to atomic_t nor even
> > > accessed with READ_ONCE / WRITE_ONCE. The hrtimer_interrupts_saved is
> > > always consistently accessed with the same CPU. NOTE: with the
> > > upcoming "buddy" detector there is one special case. When a CPU goes
> > > offline/online then we can change which CPU is the one to consistently
> > > access a given instance of hrtimer_interrupts_saved. We still can't
> > > end up with a partially updated hrtimer_interrupts_saved, however,
> > > because we end up petting all affected CPUs to make sure the new and
> > > old CPU can't end up somehow read/write hrtimer_interrupts_saved at
> > > the same time.
> > >
> > > --- a/kernel/watchdog.c
> > > +++ b/kernel/watchdog.c
> > > @@ -87,29 +87,34 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
> > >
> > >  #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > >
> > > -static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
> > > -static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
> > > +static DEFINE_PER_CPU(atomic_t, hrtimer_interrupts);
> > > +static DEFINE_PER_CPU(int, hrtimer_interrupts_saved);
> > >  static DEFINE_PER_CPU(bool, watchdog_hardlockup_warned);
> > >  static unsigned long watchdog_hardlockup_all_cpu_dumped;
> > >
> > > -static bool is_hardlockup(void)
> > > +static bool is_hardlockup(unsigned int cpu)
> > >  {
> > > -     unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
> > > +     int hrint = atomic_read(&per_cpu(hrtimer_interrupts, cpu));
> > >
> > > -     if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
> > > +     if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
> > >               return true;
> > >
> > > -     __this_cpu_write(hrtimer_interrupts_saved, hrint);
> > > +     /*
> > > +      * NOTE: we don't need any fancy atomic_t or READ_ONCE/WRITE_ONCE
> > > +      * for hrtimer_interrupts_saved. hrtimer_interrupts_saved is
> > > +      * written/read by a single CPU.
> > > +      */
> > > +     per_cpu(hrtimer_interrupts_saved, cpu) = hrint;
> > >
> > >       return false;
> > >  }
> > >
> > >  static void watchdog_hardlockup_kick(void)
> > >  {
> > > -     __this_cpu_inc(hrtimer_interrupts);
> > > +     atomic_inc(raw_cpu_ptr(&hrtimer_interrupts));
> >
> > Is there any particular reason why raw_*() is needed, please?
> >
> > My expectation is that the raw_ API should be used only when
> > there is a good reason for it. Where a good reason might be
> > when the checks might fail but the consistency is guaranteed
> > another way.
> >
> > IMHO, we should use:
> >
> >         atomic_inc(this_cpu_ptr(&hrtimer_interrupts));
> >
> > To be honest, I am a bit lost in the per_cpu API definitions.
> >
> > But this_cpu_ptr() seems to be implemented the same way as
> > per_cpu_ptr() when CONFIG_DEBUG_PREEMPT is enabled.
> > And we use per_cpu_ptr() in is_hardlockup().
> >
> > Also this_cpu_ptr() is used more commonly:
> >
> > $> git grep this_cpu_ptr | wc -l
> > 1385
> > $> git grep raw_cpu_ptr | wc -l
> > 114
> 
> Hmmm, I think maybe I confused myself. The old code purposely used the
> double-underscore prefixed version of this_cpu_inc(). I couldn't find
> a double-underscore version of this_cpu_ptr() and I somehow convinced
> myself that the raw() version was the right equivalent version.
> 
> You're right that this_cpu_ptr() is a better choice here and I don't
> see any reason why we'd need the raw version.

I was confused too. Honestly, it looks a bit messy to me.

My understanding is that this_cpu*() API has the following semantic:

    + this_cpu_*()* actively disables interrupts/preemption

    + __this_cpu_*() just warns when the task could migrate
		between CPUs.

    + raw_cpu_*() can be used in preemtible context when
		the validity is guaranteed another way.

this_cpu_ptr() does not fit the above. I guess that it is
because it is just providing the address and it is not
accessing the data. So it is enough to read the current
CPU id an atomic way.

IMHO, it would make sense to distinguish how the pointer is
going to be used. From this POV, __this_cpu_ptr() and
raw_cpu_ptr() would make more sense to me.

But it looks to me that this_cpu_ptr() has the same semantic
as per_cpu_ptr().

> Neither change seems urgent though both are important to fix, I'll
> wait a day or two to see if you have feedback on any of the other
> patches and I'll send a fixup series.

Yup, I am going to review the rest.

Best Regards,
Petr
