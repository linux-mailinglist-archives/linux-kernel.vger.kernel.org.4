Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9374172FAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbjFNKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244493AbjFNKae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:30:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5733AA4;
        Wed, 14 Jun 2023 03:29:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 653CF21C83;
        Wed, 14 Jun 2023 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686738557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhRpOEE0FKxbTYX/Job7y10yZH4TueIGHLBhWciCR2w=;
        b=jJ+ALNsoAPJuxj3+WmnJdYwDSPIw7fH3gY97cONrkYcvme6b6gIAlQILJQKaiEWZBDWE+y
        +5lNxbi2GlKwyPHV7zJEe68SriHx/afjuWaMhBfIPlhAZcuY/XGLQQc91eFEcIXkoRCR8r
        XdyKtXz+yrqwb0V6rw5zk3u7kHRIQ0E=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 55CB82C141;
        Wed, 14 Jun 2023 10:29:15 +0000 (UTC)
Date:   Wed, 14 Jun 2023 12:29:11 +0200
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
Message-ID: <ZImWd62fXjsZildv@alley>
References: <20230607152432.5435-1-pmladek@suse.com>
 <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
 <ZIG1Qi0iUjTKICQM@alley>
 <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-06-08 06:55:23, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 8, 2023 at 4:02 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > > >  config HARDLOCKUP_DETECTOR
> > > >         bool "Detect Hard Lockups"
> > > >         depends on DEBUG_KERNEL && !S390
> > > > -       depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_DETECTOR_ARCH
> > > > +       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> > >
> > > Adding the dependency to buddy (see ablove) would simplify the above
> > > to just this:
> > >
> > > depends on HAVE_HARDLOCKUP_DETECTOR_PERF ||
> > > HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
> >
> > This is exactly what I do not want. It would just move the check
> > somewhere else. But it would make the logic harder to understand.
> 
> Hmmm. To me, it felt easier to understand by moving this into the
> "HAVE_HARDLOCKUP_DETECTOR_BUDDY". To me it was pretty easy to say "if
> an architecture defined its own arch-specific watchdog then buddy
> can't be enabled" and that felt like it fit cleanly within the
> "HAVE_HARDLOCKUP_DETECTOR_BUDDY" definition. It got rid of _a lot_ of
> other special cases / checks elsewhere and felt quite a bit cleaner to
> me. I only had to think about the conflict between the "buddy" and
> "nmi" watchdogs once when I understood
> "HAVE_HARDLOCKUP_DETECTOR_BUDDY".

I see. My problem with this approach was that the dependencies between
the 4 alternative implementations were too distributed. It was
necessary read many definitions to understand what was possible and
what was not possible. And it is even more complicated when
cscope does not support Kconfig.

Also the above solves the buddy detector which is global.

The same conflict has PERF which has arch-specific dependencies.
Maybe, it can be disabled by a conflict in the arch/Kconfig.
But then the PERF dependencies would be split into 3 config
files: arch/Kconfig, lib/Kconfig.debug, arch/Kconfig/.

Anyway, HAVE_*_BUDDY and HAVE_*_PERF should behave the same.
Both should either explicitly conflict with HAVE_*_ARCH
and HAVE_NMI_WATCHDOG. Or they both should be enabled when
they are supported by the architecture and just ignored when
choosing the final implementation.

My wish was to have consistent naming:

   + HAVE_HARDLOCKUP_DETECTOR_<impl> set when the the architecture
       supports the particular implementation.

  + HARDLOCKUP_DETECTOR_<impl> set when the implementation will
       be used (built).


Step aside:

It seems that we have entered into a bike shedding mode.
The following questions come to my mind:

   1. Does this patchset improve the current state?

   2. Maybe, it is not black&white. Is it possible to summarize
      what exactly got better and what got worse?

Maybe, there is no need to do bike-shedding about every step
if the final result is reasonable and the steps are not
completely wrong.

I just followed my intuition and tried to do some changes step
by step. I got lost many times so maybe the steps are not
ideal. Anyway, the steps helped me to understand the logic
and stay reasonably confident that they did not change
the behavior.

I could rework the patchset. But I first need to know what
exactly is bad in the result. And eventually if there is more
logical way how to end there.

Best Regards,
Petr
