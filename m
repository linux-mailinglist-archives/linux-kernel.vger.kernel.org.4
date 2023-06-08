Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADF727CA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjFHKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjFHKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:19:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19F2D61;
        Thu,  8 Jun 2023 03:19:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B432321A43;
        Thu,  8 Jun 2023 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686219547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qH7hbjRKkb1LYOldC3fpKEsvGCEPNOpUQ3QVueg8k94=;
        b=ubBBzAI5Jfq44AopMPQk7sptKMpk3Olqv9uhKFbg+3Qb27Tdk/x97Pdyyc+g9TQwuCFTsM
        sxXE4W276BgmPZExKbxUU8w/ic4r8NBjuASLGMi/hqOy977FBzx5XUeDmft7/KnI19WFQl
        f0SCXK/ToeHSmXXB1qhFGEf3wPR4kmA=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8228C2C141;
        Thu,  8 Jun 2023 10:19:06 +0000 (UTC)
Date:   Thu, 8 Jun 2023 12:19:02 +0200
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
Subject: Re: [PATCH 1/7] watchdog/hardlockup: Sort hardlockup detector
 related config values a logical way
Message-ID: <ZIGrFiGhUiO6OOsa@alley>
References: <20230607152432.5435-1-pmladek@suse.com>
 <20230607152432.5435-2-pmladek@suse.com>
 <CAD=FV=X4Sp=ZE4DWob-W0NzRm00K7wOWxyyCCaHUHNPPinsjhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X4Sp=ZE4DWob-W0NzRm00K7wOWxyyCCaHUHNPPinsjhg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-06-07 16:34:20, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 7, 2023 at 8:25 AM Petr Mladek <pmladek@suse.com> wrote:
> > Only one hardlockup detector can be compiled in. The selection is done
> > using quite complex dependencies between several CONFIG variables.
> > The following patches will try to make it more straightforward.
> >
> > As a first step, reorder the definitions of the various CONFIG variables.
> > The logical order is:
> >
> >    1. HAVE_* variables define available variants. They are typically
> >       defined in the arch/ config files.
> >
> >    2. HARDLOCKUP_DETECTOR y/n variable defines whether the hardlockup
> >       detector is enabled at all.
> >
> >    3. HARDLOCKUP_DETECTOR_PREFER_BUDDY y/n variable defines whether
> >       the buddy detector should be preferred over the perf one.
> >       Note that the arch specific variants are always preferred when
> >       available.
> >
> >    4. HARDLOCKUP_DETECTOR_PERF/BUDDY variables define whether the given
> >       detector is enabled in the end.
> >
> >    5. HAVE_HARDLOCKUP_DETECTOR_NON_ARCH and HARDLOCKUP_DETECTOR_NON_ARCH
> >       are temporary variables that are going to be removed in
> >       a followup patch.
> >
> 
> I don't really have any strong opinions, so I'm fine with this. In
> general I think the ordering I picked tried to match the existing
> "style" which generally tried to list configs and then select them
> below. To me the existing style makes more sense when thinking about
> writing C code

I know. My motivation was the following:

1. Kconfig is not C. My view is that it is more like a menu. There is a
   top level item. If the top level is enabled then there is a submenu
   with a more detailed selection of various variants and options.

2. The current logic is quite complicated from my POV. And it was
   even before your patchset. For example,
   HAVE_HARDLOCKUP_DETECTOR_BUDDY is defined as:

	config HAVE_HARDLOCKUP_DETECTOR_BUDDY
		bool
		depends on SMP
		default y

   One would expect that it would be enabled on SMP system.
   But the final value depends on many other variables
   which are defined using relatively complex conditions,
   especially HARDLOCKUP_DETECTOR, HAVE_HARDLOCKUP_DETECTOR_NON_ARCH,
   and HARDLOCKUP_DETECTOR_NON_ARCH.

   Understanding the logic is even more complicated because Kconfig is
   not indexed by cscope.

Important: The logic used at the end of the patchset actually
   follows the C style. It defines how the various variables
   depend on each other from top to bottom.

> 
> config SOFTLOCKUP_DETECTOR:
>   ... blah blah blah ...

This one is actually defined in the menu-like order:

	config SOFTLOCKUP_DETECTOR

	config BOOTPARAM_SOFTLOCKUP_PANIC
		depends on SOFTLOCKUP_DETECTOR

It is because the custom option depends on the top level one.
This is exactly what I would like to achieve with HARDLOCKUP
variables in this patchset.

Best Regards,
Petr
