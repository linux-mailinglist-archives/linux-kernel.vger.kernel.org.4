Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A87128D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbjEZOoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbjEZOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:44:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EEE4F;
        Fri, 26 May 2023 07:44:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1960C21AC4;
        Fri, 26 May 2023 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685112247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcZ4ZRR0yos18sY7hIGTBFkGlmXiSRFOxBcjHXBe5hU=;
        b=J4h09ub7B+8cW6XM+zzyKpToCRFhpDx/CNcNoZrZzAVQoYGEBCP2s6MJYbAJEkhjqQwr6+
        Ii2jyonq6j1wgE1F5cWTup3ltYGq2aZa7w8gMRcHYrnG3oXEpMwdEygPcGHtjblnr0n9bd
        xIplkFCoy2RpRD5gkrV4W7dOAktOra8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 151282C141;
        Fri, 26 May 2023 14:44:04 +0000 (UTC)
Date:   Fri, 26 May 2023 16:44:03 +0200
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
Subject: Re: [PATCH v5 13/18] watchdog/hardlockup: Have the perf hardlockup
 use __weak functions more cleanly
Message-ID: <ZHDFs-7al6bbOi63@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.13.I847d9ec852449350997ba00401d2462a9cb4302b@changeid>
 <ZG4YMyifGLOBJxLo@alley>
 <CAD=FV=X+LEcSrArV+w35MX4oP1sC9KoRM0puJLT1RFmyS84Hxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X+LEcSrArV+w35MX4oP1sC9KoRM0puJLT1RFmyS84Hxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-05-24 12:38:49, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 24, 2023 at 6:59 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Fri 2023-05-19 10:18:37, Douglas Anderson wrote:
> > > The fact that there watchdog_hardlockup_enable(),
> > > watchdog_hardlockup_disable(), and watchdog_hardlockup_probe() are
> > > declared __weak means that the configured hardlockup detector can
> > > define non-weak versions of those functions if it needs to. Instead of
> > > doing this, the perf hardlockup detector hooked itself into the
> > > default __weak implementation, which was a bit awkward. Clean this up.
> > >
> > > >From comments, it looks as if the original design was done because the
> > > __weak function were expected to implemented by the architecture and
> > > not by the configured hardlockup detector. This got awkward when we
> > > tried to add the buddy lockup detector which was not arch-specific but
> > > wanted to hook into those same functions.
> > >
> > > This is not expected to have any functional impact.
> > >
> > > @@ -187,27 +187,33 @@ static inline void watchdog_hardlockup_kick(void) { }
> > >  #endif /* !CONFIG_HARDLOCKUP_DETECTOR_PERF */
> > >
> > >  /*
> > > - * These functions can be overridden if an architecture implements its
> > > - * own hardlockup detector.
> > > + * These functions can be overridden based on the configured hardlockdup detector.
> > >   *
> > >   * watchdog_hardlockup_enable/disable can be implemented to start and stop when
> > > - * softlockup watchdog start and stop. The arch must select the
> > > + * softlockup watchdog start and stop. The detector must select the
> > >   * SOFTLOCKUP_DETECTOR Kconfig.
> > >   */
> > > -void __weak watchdog_hardlockup_enable(unsigned int cpu)
> > > -{
> > > -     hardlockup_detector_perf_enable();
> > > -}
> > > +void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
> > >
> > > -void __weak watchdog_hardlockup_disable(unsigned int cpu)
> > > -{
> > > -     hardlockup_detector_perf_disable();
> > > -}
> > > +void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
> > >
> > >  /* Return 0, if a hardlockup watchdog is available. Error code otherwise */
> > >  int __weak __init watchdog_hardlockup_probe(void)
> > >  {
> > > -     return hardlockup_detector_perf_init();
> > > +     /*
> > > +      * If CONFIG_HAVE_NMI_WATCHDOG is defined then an architecture
> > > +      * is assumed to have the hard watchdog available and we return 0.
> > > +      */
> > > +     if (IS_ENABLED(CONFIG_HAVE_NMI_WATCHDOG))
> > > +             return 0;
> > > +
> > > +     /*
> > > +      * Hardlockup detectors other than those using CONFIG_HAVE_NMI_WATCHDOG
> > > +      * are required to implement a non-weak version of this probe function
> > > +      * to tell whether they are available. If they don't override then
> > > +      * we'll return -ENODEV.
> > > +      */
> > > +     return -ENODEV;
> > >  }
> >
> > When thinking more about it. It is weird that we need to handle
> > CONFIG_HAVE_NMI_WATCHDOG in this default week function.
> >
> > It should be handled in watchdog_hardlockup_probe() implemented
> > in kernel/watchdog_perf.c.
> >
> > IMHO, the default __weak function could always return -ENODEV;
> >
> > Would it make sense, please?
> 
> I don't quite understand. I'd agree that the special case for
> CONFIG_HAVE_NMI_WATCHDOG is ugly, but it was also ugly before. IMO
> it's actually a little less ugly / easier to understand after my
> patch. ...but let me walk through how I think this special case works
> and maybe you can tell me where I'm confused.
> 
> The first thing to understand is that CONFIG_HARDLOCKUP_DETECTOR_PERF
> and CONFIG_HAVE_NMI_WATCHDOG are mutually exclusive from each other.
> This was true before any of my patches and is still true after them.
> Specifically, if CONFIG_HAVE_NMI_WATCHDOG is defined then an
> architecture implements arch_touch_nmi_watchdog() (as documented in
> the Kconfig docs for HAVE_NMI_WATCHDOG). Looking at the tree before my
> series you can see that the perf hardlockup detector also implemented
> arch_touch_nmi_watchdog(). This would have caused a conflict. The
> mutual exclusion was presumably enforced by an architecture not
> defining both HAVE_NMI_WATCHDOG and HAVE_HARDLOCKUP_DETECTOR_PERF.
> 
> The second thing to understand is that an architecture that defines
> CONFIG_HAVE_NMI_WATCHDOG is _not_ required to implement
> watchdog_hardlockup_probe() (used to be called watchdog_nmi_probe()).
> Maybe this should change, but at the very least it appears that
> SPARC64 defines HAVE_NMI_WATCHDOG but doesn't define
> watchdog_hardlockup_probe() AKA watchdog_nmi_probe(). Anyone who
> defines CONFIG_HAVE_NMI_WATCHDOG and doesn't implement
> watchdog_hardlockup_probe() is claiming that their watchdog needs no
> probing and is always available.
> 
> So with that context:
> 
> 1. We can't handle any special cases for CONFIG_HAVE_NMI_WATCHDOG in
> "kernel/watchdog_perf.c". The special cases that we need to handle are
> all for the cases where CONFIG_HARDLOCKUP_DETECTOR_PERF isn't defined
> and that means "kernel/watchdog_perf.c" isn't included.
> 
> 2. We can't have the default __weak function return -ENODEV because
> CONFIG_HAVE_NMI_WATCHDOG doesn't require an arch to implement
> watchdog_hardlockup_probe(), but we want watchdog_hardlockup_probe()
> to return "no error" in that case so that
> "watchdog_hardlockup_available" gets set to true.
> 
> Does that sound right?
> 
> I'd agree that a future improvement saying that
> CONFIG_HAVE_NMI_WATCHDOG means you _must_ implement
> watchdog_hardlockup_probe() would make sense and that would allow us
> to get rid of the special case. IMO, though, that's a separate patch.
> I'd be happy to review that patch if you wanted to post it up. :-)
> 
> If we want to add that requirement, I _think_ the only thing you'd
> need to do is to add watchdog_hardlockup_probe() to sparc64 and have
> it return 0 and put that definition in the same file containing
> arch_touch_nmi_watchdog().

This is my understanding. IMHO, if we define
watchdog_hardlockup_probe() in /arch/sparc/kernel/nmi.c
then we could remove the CONFIG_HAVE_NMI_WATCHDOG check from
the default watchdog_hardlockup_probe().

Honestly, I am afraid that nobody really thought about any rules.
People were just adding their stuff any way that worked for them.
And this is why we ended with this maze.

It is not your fault. You just moved the ifdef from the header file
into the function definition. But it showed very well how ugly it was.

By ugly, I mean that powerpc, perf, and buddy hardlockup detectors
make watchdog_hardlockup_probe() successful by implementing
an alternative to the default weak implementation. Only, sparc64
reports success via a crazy check in the default weak configuration.

The check is crazy because it makes the decision based on
CONFIG_HAVE_NMI_WATCHDOG. But the related code is in
arch/sparc/kernel/nmi.c which is compiled when CONFIG_SPARC64
is enabled.

The connection between CONFIG_HAVE_NMI_WATCHDOG and
CONFIG_SPARC64 is hidden in arch/sparc/Kconfig.

It would be much more straightforward when the weak function
is implemented in arch/sparc/kernel/nmi.c. It will be clear
that probe() will succeed when the watchdog gets initialized.


> powerpc also gets CONFIG_HAVE_NMI_WATCHDOG
> as a side effect of selecting CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH but
> it looks like they implement watchdog_hardlockup_probe() already. Oh,
> but maybe this will fix a preexisting (existed before my patches)
> minor bug... Unless I'm missing something (entirely possible!) on
> powerpc today I guess if you turn off CONFIG_PPC_WATCHDOG then
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH and CONFIG_HAVE_NMI_WATCHDOG
> would still be defined and we'd end up returning 0 (no error) from
> watchdog_hardlockup_probe(). That means that on powerpc today if you
> turn off CONFIG_PPC_WATCHDOG that '/proc/sys/kernel/nmi_watchdog' will
> still think the watchdog is enabled?

Yeah, it seems that this bug was there. And it will get fixed when
the default weak implementation of watchdog_hardlockup_probe()
always returns false.

Again, I'll let Andrew to decide whether this should get cleaned
in this patchset or later. But it would be fine to fix this
after we spent so much time understanding the mess.

Best Regards,
Petr
