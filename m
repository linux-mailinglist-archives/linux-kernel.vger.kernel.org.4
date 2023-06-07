Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054857273C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 02:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjFHAfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 20:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFHAfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 20:35:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC4D2128
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:35:44 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53482b44007so4155750a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686184543; x=1688776543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhl3RV14fXn8RdG370rcvuPNBbtc0Bpx0+NmOZMVtZc=;
        b=AqAIlrcDf8GxrWOO53OVdvIbn67irWpF3vf4jVqMu0R13c16LlMCzhNWMwHrtFrxBE
         17qGcWl5C/JK91YVhg9IE049vSvmQ59PkHMQB6It3Ztnp0S1LcQC74k0ibdKTceDQXHe
         Et93S0wbdeI4CWmtaYtReJ7hDw4dIN8uQVPSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686184543; x=1688776543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhl3RV14fXn8RdG370rcvuPNBbtc0Bpx0+NmOZMVtZc=;
        b=YMoRJ3FpSI+/4rq5VNHKqe28OyZG3VnPo1siclcYIFyp8i2yzvAHSD5336jzzERXkl
         a9eUvd1bx862YrocT5hIu+SuJMDV6KNm4hNwrHMZOdoJNz+Y0QkrXKS6A3jpw/SPRHsf
         45M04MV1JafUGI9hTp1zR2rYM8cGOa3Uy3W4JrQlYkdOY9qUtYo+CRYsStQ8fZkq6yeM
         Gr1GRgDgF3U9wPPMzQpTJjvz2SPvOHneeH1LDeCsJsviowLpgG5BpDzthCUG76wH+8Z0
         eMImeqEjiP4189gRR/jMtZzExi4Ep74AHcknhzAWlSQQdBNcaQDN8wVDSbqc2FsbLp5X
         rKKA==
X-Gm-Message-State: AC+VfDzU11O/7AeY3qpSv9143EV1rywIXDfkkB/2Whe4yfvuiTWhihs0
        PbC4EsoQO3i+ipq4zPfN6qUsTpIuFusgntOmd6s=
X-Google-Smtp-Source: ACHHUZ5aOdJNv490teUJOs+iFLKoPPkUux2Jyyujpo6/ZsfrpFIvbAyEHOxywkh9LK6Ni9Ga/D0HzQ==
X-Received: by 2002:a05:6a20:e18b:b0:10f:9317:153a with SMTP id ks11-20020a056a20e18b00b0010f9317153amr2592711pzb.62.1686184543502;
        Wed, 07 Jun 2023 17:35:43 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001ab12ccc2a7sm99336plk.98.2023.06.07.17.35.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 17:35:43 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b025aaeddbso35605ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 17:35:43 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33e:6b65:6f78 with SMTP id
 a13-20020a92c54d000000b0033e6b656f78mr16489ilj.27.1686181007418; Wed, 07 Jun
 2023 16:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-5-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-5-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
Message-ID: <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
Subject: Re: [PATCH 4/7] watchdog/hardlockup: Enable HAVE_NMI_WATCHDOG only on sparc64
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 13c6e596cf9e..57f15babe188 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -404,10 +404,9 @@ config HAVE_NMI_WATCHDOG
>         depends on HAVE_NMI
>         bool
>         help
> -         The arch provides its own hardlockup detector implementation in=
stead
> +         Sparc64 provides its own hardlockup detector implementation ins=
tead
>           of the generic perf one.

It's a little weird to document generic things with the specifics of
the user. The exception, IMO, is when something is deprecated.
Personally, it would sound less weird to me to say something like:

The arch provides its own hardlockup detector implementation instead
of the generic perf one. This is a deprecated thing to do and kept
around until sparc64 provides a full hardlockup implementation or
moves to generic code.


> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d201f5d3876b..4b4aa0f941f9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1050,15 +1050,13 @@ config HAVE_HARDLOCKUP_DETECTOR_BUDDY
>  #      sparc64: has a custom implementation which is not using the commo=
n
>  #              hardlockup command line options and sysctl interface.
>  #
> -# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specifi=
c
> -# implementaion. It is automatically enabled also for other arch-specifi=
c
> -# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
> -# of avaialable and supported variants quite tricky.
> +# Note that HAVE_NMI_WATCHDOG is set when the sparc64 specific implement=
ation
> +# is used.
>  #
>  config HARDLOCKUP_DETECTOR
>         bool "Detect Hard Lockups"
> -       depends on DEBUG_KERNEL && !S390
> -       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DET=
ECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> +       depends on DEBUG_KERNEL && !S390 && !HAVE_NMI_WATCHDOG
> +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETEC=
TOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH

If you add the "!HAVE_NMI_WATCHDOG" as a dependency to
HAVE_HARDLOCKUP_DETECTOR_BUDDY, as discussed in a previous patch, you
can skip adding it here.


>         imply HARDLOCKUP_DETECTOR_PERF
>         imply HARDLOCKUP_DETECTOR_BUDDY
>         select LOCKUP_DETECTOR
> @@ -1079,7 +1077,7 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
>         bool "Prefer the buddy CPU hardlockup detector"
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETEC=
TOR_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARLOCKUP_DETECTOR_ARCH

Don't need this. Architectures never are allowed to define
HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_HARLOCKUP_DETECTOR_ARCH


>         default n
>         help
>           Say Y here to prefer the buddy hardlockup detector over the per=
f one.
> @@ -1096,7 +1094,7 @@ config HARDLOCKUP_DETECTOR_PERF
>         bool
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH

Similarly, don't need this.


>         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
>
>  config HARDLOCKUP_DETECTOR_BUDDY
> @@ -1104,7 +1102,7 @@ config HARDLOCKUP_DETECTOR_BUDDY
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
>         depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH

Similarly, don't need this.


In general I don't object to splitting out HAVE_NMI_WATCHDOG from
HAVE_HARDLOCKUP_DETECTOR_ARCH.
