Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA36742DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjF2TwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjF2TwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:52:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1561BDF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:52:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b699a2fe86so17825071fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688068328; x=1690660328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nfpVkx+nWq0B36vp7DHCBX9gSBsdd45OBB1wBO3r6c=;
        b=AcAbFSjuY4uOMBRnGK2a9k4LfvqII+4BGTa58GGrD0QvPVIG7FU8o4Bu1fy3NXLwg7
         3cQNZj/qKK1u1NJCy3kq9XhXgV9BMQGeBGGqIothlMxgLBYFIuTvNKHgF2Jj6c9snwB4
         GyTmcBQKRoKFi2jVxHuOKKmemv3JmP9SgTcH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068328; x=1690660328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nfpVkx+nWq0B36vp7DHCBX9gSBsdd45OBB1wBO3r6c=;
        b=ONiVqQgdzy0zbQ8H1ZFOTk7ENRPyFvhUaO2hg11PPKIaYsX/0/SMnfA56Lb5FeKY1I
         XO6/qzEZPiH/eVc1qZu1I0aNTHY9Se+8gaMklpUfDOo18DggFdAba3DWOPZGhKdKILzH
         RPCNfjKGa9ykFR9ZbS4djRAJyTOIEoKWCH2Yz6n1sKryoX43evMGRPxS2csoQlZEqUzS
         mmlYCvg06NHSJx6i8f3v+J5SeXTtac+ORLJRXHPDYFnn06JsW4ew0CVCmprBqt/X6mhk
         DtbOs5+quV3xFUuEbUV9FE/TiZZ3GgzOzIlSOfDHfUxQls8ZOUA/bk/gn6ibkMPFzY+f
         dLDg==
X-Gm-Message-State: ABy/qLaDe2fGAYfsvXlz5MESq/1A4Kn/0rBfFcLuwK2vUN4Lu/SRfHtx
        1O2AzRJRM67G8rJGwLF6xZ1dYSeJgMfrQQQJPDT9YRnE
X-Google-Smtp-Source: APBJJlGZYXW+GfDoFmh7tD1m3tfj42TanHgjcJO7hH8pxkdexg1XXBWlZXTrEuUGG0Dq79Mom3Sf8w==
X-Received: by 2002:a2e:918f:0:b0:2b6:9ed2:f61c with SMTP id f15-20020a2e918f000000b002b69ed2f61cmr524494ljg.7.1688068328262;
        Thu, 29 Jun 2023 12:52:08 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z7-20020a05651c022700b002b6cfdba3ccsm25561ljn.90.2023.06.29.12.52.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 12:52:07 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f86840c45dso21e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:52:06 -0700 (PDT)
X-Received: by 2002:ac2:59c5:0:b0:4f7:4b19:1735 with SMTP id
 x5-20020ac259c5000000b004f74b191735mr147182lfn.6.1688068326470; Thu, 29 Jun
 2023 12:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230628142751.0527c993@canb.auug.org.au> <af19b76d-aa4b-6c88-9cac-eae4b2072497@infradead.org>
 <ZJ1Dborac_Kj4Qbw@alley>
In-Reply-To: <ZJ1Dborac_Kj4Qbw@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jun 2023 12:51:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCHp=T+6SVdzDgRDRoJ-82uWYB0hv_jWMB19jw3hXbsg@mail.gmail.com>
Message-ID: <CAD=FV=WCHp=T+6SVdzDgRDRoJ-82uWYB0hv_jWMB19jw3hXbsg@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 28 (arch/powerpc/platforms/pseries/mobility.c)
To:     Petr Mladek <pmladek@suse.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 29, 2023 at 1:40=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Wed 2023-06-28 22:07:17, Randy Dunlap wrote:
> >
> >
> > On 6/27/23 21:27, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Please do *not* add any v5.6 related stuff to your linux-next include=
d
> > > branches until after v5.5-rc1 has been released.
> > >
> > > Changes since 20230627:
> > >
> >
> > on powerpc64, when
> > # CONFIG_HARDLOCKUP_DETECTOR is not set:
> >
> > ../arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migr=
ate_partition':
> > ../arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit de=
claration of function 'watchdog_hardlockup_set_timeout_pct'; did you mean '=
watchdog_hardlockup_stop'? [-Werror=3Dimplicit-function-declaration]
> >   753 |                 watchdog_hardlockup_set_timeout_pct(factor);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                 watchdog_hardlockup_stop
> > cc1: all warnings being treated as errors
> >
> >
> > Full randconfig file is attached.
> >
> >
> > If I blatantly modify include/linux/nmi.h with these comments, it build=
s OK:
> >
> > //#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLO=
CKUP_DETECTOR_SPARC64)
> > #include <asm/nmi.h>
> > //#endif
>
> This is well describes the probem.
>
> The decision whether to include asm/nmi.h should not depend only on
> CONFIG_HARDLOCKUP_DETECTOR_* when it is needed also for other stuff.
>
> Well, it could not be always included because it exists only
> on 4 architectures:
>
> $> ls -1 arch/*/include/asm/nmi.h
> arch/powerpc/include/asm/nmi.h
> arch/s390/include/asm/nmi.h
> arch/sparc/include/asm/nmi.h
> arch/x86/include/asm/nmi.h
>
> and include/asm-generic/nmi.h. does not exist.
>
> I see two reasonable solutions:
>
> 1. We either create an empty "include/asm-generic/nmi.h" and
>    always include asm/nmi.h in linux/nmi.h.
>
>    It looks is a bit weird but it might be the easiest solution
>    unless it creates another problems elsewhere.
>
>
> 2. Explicitely include asm/nmi.h where needed, in
>    arch/powerpc/platforms/pseries/mobility.c and maybe somewhere as
>    well.
>
>    It is already done in many cases:
>
> $> git grep asm/nmi.h
> arch/Kconfig:     asm/nmi.h, and defines its own arch_touch_nmi_watchdog(=
).
> arch/powerpc/kernel/mce.c:#include <asm/nmi.h>
> arch/powerpc/kernel/traps.c:#include <asm/nmi.h>
> arch/powerpc/kernel/watchdog.c:#include <asm/nmi.h>
> arch/s390/kernel/entry.S:#include <asm/nmi.h>
> arch/s390/kernel/idle.c:#include <asm/nmi.h>
> arch/s390/kernel/machine_kexec.c:#include <asm/nmi.h>
> arch/s390/kernel/nmi.c:#include <asm/nmi.h>
> arch/s390/kernel/process.c:#include <asm/nmi.h>
> arch/s390/kernel/setup.c:#include <asm/nmi.h>
> arch/s390/kernel/smp.c:#include <asm/nmi.h>
> arch/s390/kvm/interrupt.c:#include <asm/nmi.h>
> arch/s390/kvm/kvm-s390.c:#include <asm/nmi.h>
> arch/s390/kvm/vsie.c:#include <asm/nmi.h>
> arch/sparc/kernel/pcr.c:#include <asm/nmi.h>
> arch/sparc/kernel/perf_event.c:#include <asm/nmi.h>
> arch/x86/events/amd/core.c:#include <asm/nmi.h>
> arch/x86/events/amd/ibs.c:#include <asm/nmi.h>
> arch/x86/events/core.c:#include <asm/nmi.h>
> arch/x86/kernel/alternative.c:#include <asm/nmi.h>
> arch/x86/kernel/apic/hw_nmi.c:#include <asm/nmi.h>
> arch/x86/kernel/cpu/mce/inject.c:#include <asm/nmi.h>
> arch/x86/kernel/cpu/mshyperv.c:#include <asm/nmi.h>
> arch/x86/kernel/cpu/perfctr-watchdog.c:#include <asm/nmi.h>
> arch/x86/kernel/crash.c:#include <asm/nmi.h>
> arch/x86/kernel/kgdb.c:#include <asm/nmi.h>
> arch/x86/kernel/nmi.c:#include <asm/nmi.h>
> arch/x86/kernel/nmi_selftest.c:#include <asm/nmi.h>
> arch/x86/kernel/process.c:#include <asm/nmi.h>
> arch/x86/kernel/reboot.c:#include <asm/nmi.h>
> arch/x86/kernel/smp.c:#include <asm/nmi.h>
> arch/x86/kernel/smpboot.c:#include <asm/nmi.h>
> arch/x86/kernel/tsc.c:#include <asm/nmi.h>
> arch/x86/platform/uv/uv_nmi.c:#include <asm/nmi.h>
> drivers/char/ipmi/ipmi_watchdog.c:#include <asm/nmi.h>
> drivers/edac/igen6_edac.c:#include <asm/nmi.h>
> drivers/s390/cio/cio.c:#include <asm/nmi.h>
> drivers/watchdog/hpwdt.c:#include <asm/nmi.h>
> include/linux/nmi.h:#include <asm/nmi.h>
> include/linux/nmi.h:#include <asm/nmi.h>
> kernel/sysctl.c:#include <asm/nmi.h>
>
> I would personally prefer the 2nd variant.

Yes, this seems right to me. I'm always inclined to get build failures
fixed ASAP, so I've posted a patch for it:

https://lore.kernel.org/r/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a=
9e1a9d4c4@changeid


> I am going to check other locations where it might be needed.

If you find anything else, we can either do a v2 or another patch.

-Doug
