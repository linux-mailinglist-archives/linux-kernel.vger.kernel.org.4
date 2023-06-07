Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92672733A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjFGXk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFGXky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:40:54 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78730269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:40:48 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6263b2526a0so443016d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181247; x=1688773247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GavxFaHwlTnRx3gt9uObRrogsyEG4oEATw/XGEuAuMI=;
        b=GOvdHIXUICNlPvOWMbavblUzrUQXkPCl1xHHGbC+t61I5zPfwHRZ9XmnY2ARHJwsq5
         v96eOSiM/bRznCXAXuIGN+CicxvemE8ktEirevBFo2zOpBVbOu2vpmcLkmgImUU7LFPV
         z6RI75yrhM+g84IB56V950tIBo1s4yD3HN050=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181247; x=1688773247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GavxFaHwlTnRx3gt9uObRrogsyEG4oEATw/XGEuAuMI=;
        b=F2S21lC8hHkWQ40fI26llU/Ghpl1SbEDB7PvtsKDY0Od+LwIEc9feBB86uC7348F2N
         8R/yuc/N5FEHI9l10dPvhXfC3Af+RA4cS1iYKiIuM3e7epmOGHZrlP4s9IxuRPoEY7gb
         AljoqR3vUjPelah3q8BftBZUHfC3CpxrcR0zAJH/PIp0gpGmVbx9TibhMi0RjKtBdkip
         9DRc/ufTwDhg3RGwkgnfLh1CYB3Izw8EyiuT37UNtfKnXPMQOpsRb11AaVk1IPyhaZwj
         YuzvaRpWSZpJeJp8DcAJuFv5X/cr23oJFqyIp9Oy7x5WWA30Oq/s/5vn7PXDsTrMPuDo
         gNIw==
X-Gm-Message-State: AC+VfDxqMfZkOAO5WHxzNnhKgAHfydCrX4RVZKlRcL1vUvbbe2ShbMMw
        1cJ0rDZh/OrMZZpfifTpE3kyf+vvHjWjL/45D+w=
X-Google-Smtp-Source: ACHHUZ4FRfmvsxsIwJUMRGN08624KdBemAioAz5uM8v8fL9GBxUGi27ll0iWxXC/xBbh70qjS/1AVA==
X-Received: by 2002:a05:6214:1d2e:b0:628:6ed3:109f with SMTP id f14-20020a0562141d2e00b006286ed3109fmr5573168qvd.27.1686181246889;
        Wed, 07 Jun 2023 16:40:46 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id w4-20020a0ce104000000b006261e141f4bsm260588qvk.87.2023.06.07.16.40.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:40:45 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f805551a19so53571cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:40:45 -0700 (PDT)
X-Received: by 2002:a5e:a611:0:b0:777:aa56:f5e9 with SMTP id
 q17-20020a5ea611000000b00777aa56f5e9mr11095206ioi.16.1686180931677; Wed, 07
 Jun 2023 16:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-4-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-4-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:35:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvUAeKFAcOD_xaT2to45=CCiKJMRbi-uxgrZ4mWN7hZg@mail.gmail.com>
Message-ID: <CAD=FV=XvUAeKFAcOD_xaT2to45=CCiKJMRbi-uxgrZ4mWN7hZg@mail.gmail.com>
Subject: Re: [PATCH 3/7] watchdog/hardlockup: Declare arch_touch_nmi_watchdog()
 only in linux/nmi.h
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> arch_touch_nmi_watchdog() needs a different implementation for various
> hardlockup detector implementations. And it does nothing when
> any hardlockup detector is not build at all.

s/build/built/


> arch_touch_nmi_watchdog() has to be declared in linux/nmi.h. It is done
> directly in this header file for the perf and buddy detectors. And it
> is done in the included asm/linux.h for arch specific detectors.
>
> The reason probably is that the arch specific variants build the code
> using another conditions. For example, powerpc64/sparc64 builds the code
> when CONFIG_PPC_WATCHDOG is enabled.
>
> Another reason might be that these architectures define more functions
> in asm/nmi.h anyway.
>
> However the generic code actually knows the information. The config
> variables HAVE_NMI_WATCHDOG and HAVE_HARDLOCKUP_DETECTOR_ARCH are used
> to decide whether to build the buddy detector.
>
> In particular, CONFIG_HARDLOCKUP_DETECTOR is set only when a generic
> or arch-specific hardlockup detector is built. The only exception
> is sparc64 which ignores the global HARDLOCKUP_DETECTOR switch.
>
> The information about sparc64 is a bit complicated. The hardlockup
> detector is built there when CONFIG_HAVE_NMI_WATCHDOG is set and
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> People might wonder whether this change really makes things easier.
> The motivation is:
>
>   + The current logic in linux/nmi.h is far from obvious.
>     For example, arch_touch_nmi_watchdog() is defined as {} when
>     neither CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER nor
>     CONFIG_HAVE_NMI_WATCHDOG is defined.
>
>   + The change synchronizes the checks in lib/Kconfig.debug and
>     in the generic code.
>
>   + It is a step that will help cleaning HAVE_NMI_WATCHDOG related
>     checks.
>
> The change should not change the existing behavior.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/powerpc/include/asm/nmi.h |  2 --
>  arch/sparc/include/asm/nmi.h   |  1 -
>  include/linux/nmi.h            | 13 ++++++++++---
>  3 files changed, 10 insertions(+), 6 deletions(-)

This looks right and is a nice cleanup.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
