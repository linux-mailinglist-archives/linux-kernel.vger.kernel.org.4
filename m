Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26478742275
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjF2InA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjF2Ild (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95F2297C;
        Thu, 29 Jun 2023 01:40:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7B4901F892;
        Thu, 29 Jun 2023 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688028016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFWn7nv5Vx5zKuWgrGV98tz3kiZj6frtOAX4tjt+XYM=;
        b=T1pdmWPP7/Fif9yTiaQ4tKWnkO6UgKEYkJGukH9eFaSh3HSxsqN6qVQHNWTm0lq9Lb5kqZ
        eGVr0yGB5IW+pppzod99KMuW8tJDYphY/S+aEbGBQ/6BO81rSvIVVgXVszKSgUq+0A7nLC
        fk7+XwPv0q6phsqdC+9jrTDD8DA8XhQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 571F72C141;
        Thu, 29 Jun 2023 08:40:15 +0000 (UTC)
Date:   Thu, 29 Jun 2023 10:40:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: linux-next: Tree for Jun 28
 (arch/powerpc/platforms/pseries/mobility.c)
Message-ID: <ZJ1Dborac_Kj4Qbw@alley>
References: <20230628142751.0527c993@canb.auug.org.au>
 <af19b76d-aa4b-6c88-9cac-eae4b2072497@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af19b76d-aa4b-6c88-9cac-eae4b2072497@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-06-28 22:07:17, Randy Dunlap wrote:
> 
> 
> On 6/27/23 21:27, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Please do *not* add any v5.6 related stuff to your linux-next included
> > branches until after v5.5-rc1 has been released.
> > 
> > Changes since 20230627:
> > 
> 
> on powerpc64, when
> # CONFIG_HARDLOCKUP_DETECTOR is not set:
> 
> ../arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migrate_partition':
> ../arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit declaration of function 'watchdog_hardlockup_set_timeout_pct'; did you mean 'watchdog_hardlockup_stop'? [-Werror=implicit-function-declaration]
>   753 |                 watchdog_hardlockup_set_timeout_pct(factor);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                 watchdog_hardlockup_stop
> cc1: all warnings being treated as errors
> 
> 
> Full randconfig file is attached.
> 
> 
> If I blatantly modify include/linux/nmi.h with these comments, it builds OK:
> 
> //#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
> #include <asm/nmi.h>
> //#endif

This is well describes the probem.

The decision whether to include asm/nmi.h should not depend only on
CONFIG_HARDLOCKUP_DETECTOR_* when it is needed also for other stuff.

Well, it could not be always included because it exists only
on 4 architectures:

$> ls -1 arch/*/include/asm/nmi.h
arch/powerpc/include/asm/nmi.h
arch/s390/include/asm/nmi.h
arch/sparc/include/asm/nmi.h
arch/x86/include/asm/nmi.h

and include/asm-generic/nmi.h. does not exist.

I see two reasonable solutions:

1. We either create an empty "include/asm-generic/nmi.h" and
   always include asm/nmi.h in linux/nmi.h.

   It looks is a bit weird but it might be the easiest solution
   unless it creates another problems elsewhere.


2. Explicitely include asm/nmi.h where needed, in
   arch/powerpc/platforms/pseries/mobility.c and maybe somewhere as
   well.

   It is already done in many cases:

$> git grep asm/nmi.h
arch/Kconfig:     asm/nmi.h, and defines its own arch_touch_nmi_watchdog().
arch/powerpc/kernel/mce.c:#include <asm/nmi.h>
arch/powerpc/kernel/traps.c:#include <asm/nmi.h>
arch/powerpc/kernel/watchdog.c:#include <asm/nmi.h>
arch/s390/kernel/entry.S:#include <asm/nmi.h>
arch/s390/kernel/idle.c:#include <asm/nmi.h>
arch/s390/kernel/machine_kexec.c:#include <asm/nmi.h>
arch/s390/kernel/nmi.c:#include <asm/nmi.h>
arch/s390/kernel/process.c:#include <asm/nmi.h>
arch/s390/kernel/setup.c:#include <asm/nmi.h>
arch/s390/kernel/smp.c:#include <asm/nmi.h>
arch/s390/kvm/interrupt.c:#include <asm/nmi.h>
arch/s390/kvm/kvm-s390.c:#include <asm/nmi.h>
arch/s390/kvm/vsie.c:#include <asm/nmi.h>
arch/sparc/kernel/pcr.c:#include <asm/nmi.h>
arch/sparc/kernel/perf_event.c:#include <asm/nmi.h>
arch/x86/events/amd/core.c:#include <asm/nmi.h>
arch/x86/events/amd/ibs.c:#include <asm/nmi.h>
arch/x86/events/core.c:#include <asm/nmi.h>
arch/x86/kernel/alternative.c:#include <asm/nmi.h>
arch/x86/kernel/apic/hw_nmi.c:#include <asm/nmi.h>
arch/x86/kernel/cpu/mce/inject.c:#include <asm/nmi.h>
arch/x86/kernel/cpu/mshyperv.c:#include <asm/nmi.h>
arch/x86/kernel/cpu/perfctr-watchdog.c:#include <asm/nmi.h>
arch/x86/kernel/crash.c:#include <asm/nmi.h>
arch/x86/kernel/kgdb.c:#include <asm/nmi.h>
arch/x86/kernel/nmi.c:#include <asm/nmi.h>
arch/x86/kernel/nmi_selftest.c:#include <asm/nmi.h>
arch/x86/kernel/process.c:#include <asm/nmi.h>
arch/x86/kernel/reboot.c:#include <asm/nmi.h>
arch/x86/kernel/smp.c:#include <asm/nmi.h>
arch/x86/kernel/smpboot.c:#include <asm/nmi.h>
arch/x86/kernel/tsc.c:#include <asm/nmi.h>
arch/x86/platform/uv/uv_nmi.c:#include <asm/nmi.h>
drivers/char/ipmi/ipmi_watchdog.c:#include <asm/nmi.h>
drivers/edac/igen6_edac.c:#include <asm/nmi.h>
drivers/s390/cio/cio.c:#include <asm/nmi.h>
drivers/watchdog/hpwdt.c:#include <asm/nmi.h>
include/linux/nmi.h:#include <asm/nmi.h>
include/linux/nmi.h:#include <asm/nmi.h>
kernel/sysctl.c:#include <asm/nmi.h>

I would personally prefer the 2nd variant.

I am going to check other locations where it might be needed.

Best Regards,
Petr
