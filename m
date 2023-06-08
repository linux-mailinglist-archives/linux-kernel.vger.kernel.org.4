Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AF77281A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjFHNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjFHNqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:46:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC8026B3;
        Thu,  8 Jun 2023 06:46:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 103221FDCA;
        Thu,  8 Jun 2023 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686232003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KBbWiKkW090r6xpGGTvZasEo61erYv6UtVsy3logoc=;
        b=HqK/AlDpvfGbTNDmGl55bMAaRj6QwKTZptYCWk/8avkFYFqLmq4bw6Sw0GLb/IrsNS/G57
        8gK1NfadlvJi1Meb9tkQezNlillNl9LFNkb33uQxqs8z0wBiQjM/DsuMQveTjApYL/MMhg
        MqyEbMnJuAYDNVYk5+VBUPnksHEqbWY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 46C822C141;
        Thu,  8 Jun 2023 13:46:41 +0000 (UTC)
Date:   Thu, 8 Jun 2023 15:46:38 +0200
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
Subject: Re: [PATCH 4/7] watchdog/hardlockup: Enable HAVE_NMI_WATCHDOG only
 on sparc64
Message-ID: <ZIHbvlw05razk-oJ@alley>
References: <20230607152432.5435-1-pmladek@suse.com>
 <20230607152432.5435-5-pmladek@suse.com>
 <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-06-07 16:36:35, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 7, 2023 at 8:25 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 13c6e596cf9e..57f15babe188 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -404,10 +404,9 @@ config HAVE_NMI_WATCHDOG
> >         depends on HAVE_NMI
> >         bool
> >         help
> > -         The arch provides its own hardlockup detector implementation instead
> > +         Sparc64 provides its own hardlockup detector implementation instead
> >           of the generic perf one.
> 
> It's a little weird to document generic things with the specifics of
> the user. The exception, IMO, is when something is deprecated.
> Personally, it would sound less weird to me to say something like:

Or I could replace "The arch" by "Sparc64" in the 5th patch which
renames the variable to HAVE_HARDLOCKUP_DETECTOR_SPARC64. It will
not longer be a generic thing...

Or I could squash the two patches. I did not want to do too many
changes at the same time. But it might actually make sense to
do this in one step.

> 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d201f5d3876b..4b4aa0f941f9 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1050,15 +1050,13 @@ config HAVE_HARDLOCKUP_DETECTOR_BUDDY
> >  #      sparc64: has a custom implementation which is not using the common
> >  #              hardlockup command line options and sysctl interface.
> >  #
> > -# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specific
> > -# implementaion. It is automatically enabled also for other arch-specific
> > -# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
> > -# of avaialable and supported variants quite tricky.
> > +# Note that HAVE_NMI_WATCHDOG is set when the sparc64 specific implementation
> > +# is used.
> >  #
> >  config HARDLOCKUP_DETECTOR
> >         bool "Detect Hard Lockups"
> > -       depends on DEBUG_KERNEL && !S390
> > -       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> > +       depends on DEBUG_KERNEL && !S390 && !HAVE_NMI_WATCHDOG
> > +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
> 
> If you add the "!HAVE_NMI_WATCHDOG" as a dependency to
> HAVE_HARDLOCKUP_DETECTOR_BUDDY, as discussed in a previous patch, you
> can skip adding it here.

It it related to the 2nd patch. Let's discuss it there.

> 
> >         imply HARDLOCKUP_DETECTOR_PERF
> >         imply HARDLOCKUP_DETECTOR_BUDDY
> >         select LOCKUP_DETECTOR
> > @@ -1079,7 +1077,7 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
> >         bool "Prefer the buddy CPU hardlockup detector"
> >         depends on HARDLOCKUP_DETECTOR
> >         depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
> > -       depends on !HAVE_NMI_WATCHDOG
> > +       depends on !HAVE_HARLOCKUP_DETECTOR_ARCH
> 
> Don't need this. Architectures never are allowed to define
> HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_HARLOCKUP_DETECTOR_ARCH

Same here...

Best Regards,
Petr
