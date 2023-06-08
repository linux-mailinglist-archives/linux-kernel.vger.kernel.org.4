Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F9727D74
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjFHLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjFHLCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:02:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC8271B;
        Thu,  8 Jun 2023 04:02:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 722EC1FDE2;
        Thu,  8 Jun 2023 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686222147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g44MDDH9tfB/XpM0/EESISEKQiRS6U0QnFvaGcmzdk=;
        b=CCLKjh4l086lb/mfvsw8O378/hEr9vO/2QT8GYe9J9S/ENCObCwIhDoN0A8TCMonSEPAkF
        NYZZCOgVX0xxpN+/I41wO4gktn2BkEypvV6mCUFLMhGH6Lie8tFWk9aANtZJqOZH95HZFv
        n9GWwORRzUw0ojKl1Ui++tV2Z8p66P0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 012D62C141;
        Thu,  8 Jun 2023 11:02:26 +0000 (UTC)
Date:   Thu, 8 Jun 2023 13:02:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/7] watchdog/hardlockup: Make the config checks more
 straightforward
Message-ID: <ZIG1Qi0iUjTKICQM@alley>
References: <20230607152432.5435-1-pmladek@suse.com>
 <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-06-07 16:35:09, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 7, 2023 at 8:25 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 422f0ffa269e..13c6e596cf9e 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -404,17 +404,27 @@ config HAVE_NMI_WATCHDOG
> >         depends on HAVE_NMI
> >         bool
> >         help
> > -         The arch provides a low level NMI watchdog. It provides
> > -         asm/nmi.h, and defines its own watchdog_hardlockup_probe() and
> > -         arch_touch_nmi_watchdog().
> > +         The arch provides its own hardlockup detector implementation instead
> > +         of the generic perf one.
> 
> nit: did you mean to have different wording here compared to
> HAVE_HARDLOCKUP_DETECTOR_ARCH? Here you say "the generic perf one" and
> there you say "the generic ones", though it seems like you mean them
> to be the same.

Good point, I'll fix it in v2.

> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 3e91fa33c7a0..d201f5d3876b 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1035,16 +1035,33 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
> >
> >           Say N if unsure.
> >
> > +config HAVE_HARDLOCKUP_DETECTOR_BUDDY
> > +       bool
> > +       depends on SMP
> > +       default y
> 
> I think you simplify your life if you also add:
> 
>   depends on !HAVE_NMI_WATCHDOG
> 
> The existing config system has always assumed that no architecture
> defines both HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_NMI_WATCHDOG
> (symbols would have clashed and you would get a link error as two
> watchdogs try to implement the same weak symbol). If you add the extra
> dependency to "buddy" as per above, then a few things below fall out.
> I'll try to point them out below.

My aim is to have two variables with and without HAVE_* prefix
for each variant. They already existed for perf:

   + HAVE_HARDLOCKUP_DETECTOR_PERF means that it is supported by the arch.
   + HARDLOCKUP_DETECTOR_PERF means that it will really be built.

1. It will make it clear what variants are available on the give system.
   And it will make it clear what variant is used in the end.

2. It allows to add the dependecy on the global switch HARDLOCKUP_DETECTOR.
   It makes it clear that the detector could be disabled by this switch.
   Also it actually allows to use both top-bottom logic and C-like
   definition ordering.


> 
> > +
> >  #
> > -# arch/ can define HAVE_HARDLOCKUP_DETECTOR_ARCH to provide their own hard
> > -# lockup detector rather than the perf based detector.
> > +# Global switch whether to build a hardlockup detector at all. It is available
> > +# only when the architecture supports at least one implementation. There are
> > +# two exceptions. The hardlockup detector is newer enabled on:
> 
> s/newer/never/

Great catch. Will fix in v2.

> > +#
> > +#      s390: it reported many false positives there
> > +#
> > +#      sparc64: has a custom implementation which is not using the common
> > +#              hardlockup command line options and sysctl interface.
> > +#
> > +# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specific
> > +# implementaion. It is automatically enabled also for other arch-specific
> > +# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
> > +# of avaialable and supported variants quite tricky.
> >  #
> >  config HARDLOCKUP_DETECTOR
> >         bool "Detect Hard Lockups"
> >         depends on DEBUG_KERNEL && !S390
> > -       depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_DETECTOR_ARCH
> > +       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> 
> Adding the dependency to buddy (see ablove) would simplify the above
> to just this:
> 
> depends on HAVE_HARDLOCKUP_DETECTOR_PERF ||
> HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH

This is exactly what I do not want. It would just move the check
somewhere else. But it would make the logic harder to understand.
Especially when the related definitions could not be found by cscope.

> As per above, it's simply a responsibility of architectures not to
> define that they have both "perf" if they have the NMI watchdog, so
> it's just buddy to worry about.

Where is this documented, please?
Is it safe to assume this?

I would personally prefer to ensure this by the config check.
It is even better than documentation because nobody reads
documentation ;-)

It took me long time to understand all the dependencies and
possibilities. My motivation is that neither me nor others
would need to absolve the same adventure in the future.

> 
> > +       imply HARDLOCKUP_DETECTOR_PERF
> > +       imply HARDLOCKUP_DETECTOR_BUDDY
> >         select LOCKUP_DETECTOR
> > -       select HARDLOCKUP_DETECTOR_NON_ARCH if HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
> >
> >         help
> >           Say Y here to enable the kernel to act as a watchdog to detect
> > @@ -1055,9 +1072,15 @@ config HARDLOCKUP_DETECTOR
> >           chance to run.  The current stack trace is displayed upon detection
> >           and the system will stay locked up.
> >
> > +#
> > +# Note that arch-specific variants are always preferred.
> > +#
> >  config HARDLOCKUP_DETECTOR_PREFER_BUDDY
> >         bool "Prefer the buddy CPU hardlockup detector"
> > -       depends on HAVE_HARDLOCKUP_DETECTOR_PERF && SMP
> > +       depends on HARDLOCKUP_DETECTOR
> > +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
> > +       depends on !HAVE_NMI_WATCHDOG
> 
> Can get rid of above "!HAVE_NMI_WATCHDOG" if it's added to
> HAVE_HARDLOCKUP_DETECTOR_BUDDY.

I would prefer to keep it hear to make it clear on the first look.

> > +       default n
> 
> I'm pretty sure "default n" isn't needed.

I'll try and fix in v2.

> 
> >         help
> >           Say Y here to prefer the buddy hardlockup detector over the perf one.
> >
> > @@ -1071,39 +1094,27 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
> >
> >  config HARDLOCKUP_DETECTOR_PERF
> >         bool
> > -       depends on HAVE_HARDLOCKUP_DETECTOR_PERF
> > +       depends on HARDLOCKUP_DETECTOR
> > +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
> > +       depends on !HAVE_NMI_WATCHDOG
> 
> We don't really need the "!HAVE_NMI_WATCHDOG". A user wouldn't be able
> to mess this up and it's up to an architecture not to define both
> HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_NMI_WATCHDOG.

This is an assumption that only few people knows. I would prefer
to enforce this by the check.

> Overall, though, I agree that this improves things! Thanks! :-)

Thanks a lot for the review. I did my best and I got lost many times ;-)

Best Regards,
Petr
