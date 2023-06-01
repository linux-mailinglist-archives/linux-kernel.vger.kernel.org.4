Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA1719CE1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjFAND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFANDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:03:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D2E7;
        Thu,  1 Jun 2023 06:03:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C0F221980;
        Thu,  1 Jun 2023 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685624632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u3dPTilvXGp8uxMn4l+Fg2INpSwUqim9wefqzjAgkeE=;
        b=sWoQjeSwqeyLwmTMHbHRK38BwL4BPEazkQloeg0LItKG4j9/aawcmj88GFMKrHarpA8e0E
        Ehq1Nt90b/lKIx9jbgcaGJiZEnTuSUReqF0MI+X4gZtM4+WPi/yWoq4XBhz7ZoTF3XDyX7
        nrCbe+8EAxSy9O43hxhmGrxArfXGyzc=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B9812C142;
        Thu,  1 Jun 2023 13:03:48 +0000 (UTC)
Date:   Thu, 1 Jun 2023 15:03:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 10/10] watchdog/hardlockup: Rename
 HAVE_HARDLOCKUP_DETECTOR_NON_ARCH to ..._PERF_OR_BUDDY
Message-ID: <ZHiXMK1QPlCpTmKV@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.10.I821fe7609e57608913fe05abd8f35b343e7a9aae@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.10.I821fe7609e57608913fe05abd8f35b343e7a9aae@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-26 18:41:40, Douglas Anderson wrote:
> HAVE_HARDLOCKUP_DETECTOR_NON_ARCH is a mouthful and
> confusing. HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY is even more of a
> mouthful, but probably less confusing. Rename the Kconfig names.

It is better. But I have an idea that might be even better.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  lib/Kconfig.debug | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index eb1edd5905bc..b9e162698a82 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1058,7 +1058,7 @@ config HARDLOCKUP_DETECTOR_BUDDY
>  # needs SMP). In either case, using the "non-arch" code conflicts with
>  # the NMI watchdog code (which is sometimes used directly and sometimes used
>  # by the arch-provided hardlockup detector).

The comment above still uses the term "no-arch" and tries to
explain the confusion around it.

> -config HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
> +config HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
>  	bool
>  	depends on (HAVE_HARDLOCKUP_DETECTOR_PERF || SMP) && !HAVE_NMI_WATCHDOG
>  	default y
> @@ -1077,10 +1077,10 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
>  	  an arch-specific hardlockup detector or if resources needed
>  	  for the hardlockup detector are better used for other things.
>  
> -# This will select the appropriate non-arch hardlockdup detector
> -config HARDLOCKUP_DETECTOR_NON_ARCH
> +# This will select the appropriate non-arch hardlockup detector
> +config HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
>  	bool
> -	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
> +	depends on HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
>  	select HARDLOCKUP_DETECTOR_BUDDY if !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
>  	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
>  
> @@ -1098,9 +1098,9 @@ config HARDLOCKUP_CHECK_TIMESTAMP
>  config HARDLOCKUP_DETECTOR
>  	bool "Detect Hard Lockups"
>  	depends on DEBUG_KERNEL && !S390
> -	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_DETECTOR_ARCH
> +	depends on HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
>  	select LOCKUP_DETECTOR
> -	select HARDLOCKUP_DETECTOR_NON_ARCH if HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
> +	select HARDLOCKUP_DETECTOR_PERF_OR_BUDDY if HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
>  
>  	help
>  	  Say Y here to enable the kernel to act as a watchdog to detect

I am sorry but I am still confused by the logic. For me, it is far
from clear what combinations are possible, impossible, and optional.

Especially, the effect of HAVE_NMI_WATCHDOG and
HAVE_HARDLOCKUP_DETECTOR_ARCH is quite tricky.

I was playing with it and came up with a more straightforward solution
and found more possibilities how the simplify the logic. I am going
to prepare a patchset that would replace this patch.

Just to get the idea. I made the following changes:

     + define the values in logical order:
	+ HAVE_*
	+ HARDLOCKUP_DETECTOR y/n value
	+ HARDLOCKUP_DETECTOR_PREFER_BUDDY y/n value
	+ HARDLOCKUP_DETECTOR_PERF decision based on above
	+ HARDLOCKUP_DETECTOR_BUDDY decision based on above

     + remove HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY,
       instead, explicitly define the dependencies on all HAVE_*
       variables to make it clear what it possible
       and what is not possible

     + remove HARDLOCKUP_DETECTOR_PERF_OR_BUDDY,
       instead use "imply" in HARDLOCKUP_DETECTOR to trigger
       re-evaluation of HARDLOCKUP_DETECTOR_PERF and
       HARDLOCKUP_DETECTOR_BUDDY decisions


My current version has the following in lib/Kconfig.devel:

--- cut ---
config HAVE_HARDLOCKUP_DETECTOR_BUDDY
	bool
	depends on SMP
	default y

#
# arch/ can define HAVE_NMI_WATCHDOG to provide their own hard
# lockup detector rather than the generic perf or buddy detector.
#
config HARDLOCKUP_DETECTOR
	bool "Detect Hard Lockups"
	depends on DEBUG_KERNEL && !S390
	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_NMI_WATCHDOG
	imply HARDLOCKUP_DETECTOR_PERF
	imply HARDLOCKUP_DETECTOR_BUDDY
	select LOCKUP_DETECTOR

	help
	  Say Y here to enable the kernel to act as a watchdog to detect
	  hard lockups.

	  Hardlockups are bugs that cause the CPU to loop in kernel mode
	  for more than 10 seconds, without letting other interrupts have a
	  chance to run.  The current stack trace is displayed upon detection
	  and the system will stay locked up.

#
# The architecture-specific variant is always used when available,
# see HAVE_NMI_WATCHDOG
#
config HARDLOCKUP_DETECTOR_PREFER_BUDDY
	bool "Prefer the buddy CPU hardlockup detector"
	depends on HARDLOCKUP_DETECTOR
	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY && !HAVE_NMI_WATCHDOG
	default n
	help
	  Say Y here to prefer the buddy hardlockup detector over the perf one.

	  With the buddy detector, each CPU uses its softlockup hrtimer
	  to check that the next CPU is processing hrtimer interrupts by
	  verifying that a counter is increasing.

	  This hardlockup detector is useful on systems that don't have
	  an arch-specific hardlockup detector or if resources needed
	  for the hardlockup detector are better used for other things.

config HARDLOCKUP_DETECTOR_PERF
	bool
	depends on HARDLOCKUP_DETECTOR
	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY && !HAVE_NMI_WATCHDOG
	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER

config HARDLOCKUP_DETECTOR_BUDDY
	bool
	depends on HARDLOCKUP_DETECTOR
	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
	depends on HARDLOCKUP_DETECTOR_PREFER_BUDDY || !HAVE_HARDLOCKUP_DETECTOR_PERF
	depends on !HAVE_NMI_WATCHDOG
	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER

# Both the "perf" and "buddy" hardlockup detectors need counting hrtimer
# interrupts.
config HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
	bool
	depends on HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_BUDDY
	select SOFTLOCKUP_DETECTOR
--- cut ---

Also I am going to break the dependency between HAVE_NMI_WATCHDOG and
HAVE_HADRDLOCKUP_DETECTOR_ARCH. HAVE_NMI_WATCHDOG is needed only
for the very special powerpc64 watchdog. I am going to make sure
that it will be used only there and it will not be needed for
sparc and arm. As a result, we would have 4 separate implementations:

    + HAVE_HARDLOCKUP_DETECTOR_BUDDY enabled on any SMP system

    + HAVE_HARDLOCKUP_DETECTOR_PERF enabled on architectures supporting
	this perf-based solution

    + HAVE_HARDLOCKUP_DETECTOR_ARCH enabled on architectures which
	need another solution instead of the perf interface;
	they would support the usual HARDLOCKUP_DETECTOR command
	line parameters and sysctl interface

    + HAVE_NMI_WATCHDOG enabled just on powerpc64; it is special
	solution with its own command line parameters. Also it does
	not support hardlockup sysctl interface. I think about
	renaming it to HAVE_HARDLOCKUP_DETECTOR_POWERPC64 or
	_CUSTOM.

Best Regards,
Petr
