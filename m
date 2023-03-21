Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8D6C35BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCUPdy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCUPdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:33:51 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BFA4BEB5;
        Tue, 21 Mar 2023 08:33:50 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id r5so18323221qtp.4;
        Tue, 21 Mar 2023 08:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679412829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1FAG7EG+oo0WLGCAeT69lFpq2lucqpqtpr3jD7v1IY=;
        b=INfHfxHGEI/5w8IQ9W21SiFqMaTJ06sHByu6ZOQS1PJ3c8UePiz9zcMHIFOVl1Rf1B
         PiNcJflp0SUEZIV9stxgeiCbaUy62tR47rrbA7gaV+g0XcC0sHPGNmcP3O+pLQjWUxoT
         /iczIE7PN/dE6pRSHSQe7EyqvNbf8cvUZRSxE8IgV7TVWomThA7EV/c0r5SU8iSQOV5i
         ErgqovkevFa4DHjcL6tEBShCg3Wf6GeNWtEo6hbnQHWWgCMFNYLB+BbrlJ789TfP8qqV
         Xt9vwKI1M6sYY6XTKJWHkVXs5mqf+n+8ZzdS+nHkdoZwl4lWrM0TfZEpD4xq5f3AVtos
         qs8A==
X-Gm-Message-State: AO0yUKWyuGvLmPiBIuko0TzAjt00+C1/SzV+V4WBgUJ+gBoZzo0XZHd1
        oomAg/WBf1cbXreMSn5RHvKqr6tOHPKy0A==
X-Google-Smtp-Source: AK7set+wM/CgmaLWb/Q/BFbPIxBQ3OldCjO2kaTQBKU/yUCIWgpBS7zfr0hPJ2Dp8gjZoCpk72ohtg==
X-Received: by 2002:a05:622a:1ba6:b0:3d8:3aed:66f4 with SMTP id bp38-20020a05622a1ba600b003d83aed66f4mr346788qtb.41.1679412829145;
        Tue, 21 Mar 2023 08:33:49 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 130-20020a370888000000b007467f7536d0sm4958460qki.99.2023.03.21.08.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:33:48 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5445009c26bso286836797b3.8;
        Tue, 21 Mar 2023 08:33:48 -0700 (PDT)
X-Received: by 2002:a81:ac0d:0:b0:545:45f4:2e50 with SMTP id
 k13-20020a81ac0d000000b0054545f42e50mr1317822ywh.4.1679412828173; Tue, 21 Mar
 2023 08:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320082146.4117022-1-geert@linux-m68k.org> <c85681c6-6fcf-33ed-210f-661e539f78d8@infradead.org>
 <CAMuHMdWw0OdLPUORh6=Be8AW6bN+Pa2t=dcF47B1m=-ihsNPZQ@mail.gmail.com> <7e876937-4254-a2d8-f810-513f067b4855@infradead.org>
In-Reply-To: <7e876937-4254-a2d8-f810-513f067b4855@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Mar 2023 16:33:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+t2-LO2WbWCpOuVWm1ZqR29GKH3k8WfCGKK1Vsr0K5w@mail.gmail.com>
Message-ID: <CAMuHMdU+t2-LO2WbWCpOuVWm1ZqR29GKH3k8WfCGKK1Vsr0K5w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.3-rc3 (drm/msm/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Mar 21, 2023 at 4:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/21/23 00:34, Geert Uytterhoeven wrote:
> > On Tue, Mar 21, 2023 at 6:38 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 3/20/23 01:21, Geert Uytterhoeven wrote:
> >>> Below is the list of build error/warning regressions/improvements in
> >>> v6.3-rc3[1] compared to v6.2[2].
> >>>
> >>> Summarized:
> >>>   - build errors: +9/-14
> >>>   - build warnings: +4/-1447
> >>>
> >>> JFYI, when comparing v6.3-rc3[1] to v6.3-rc2[3], the summaries are:
> >>>   - build errors: +0/-1
> >>>   - build warnings: +0/-0
> >>>
> >>> Happy fixing! ;-)
> >>>
> >>> Thanks to the linux-next team for providing the build service.
> >>>
> >>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e8d018dd0257f744ca50a729e3d042cf2ec9da65/ (all 152 configs)
> >>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c9c3395d5e3dcc6daee66c6908354d47bf98cb0c/ (all 152 configs)
> >>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eeac8ede17557680855031c6f305ece2378af326/ (all 152 configs)
> >>>
> >>>
> >>> *** ERRORS ***
> >>>
> >>> 9 error regressions:
> >>
> >>>   + /kisskb/src/drivers/gpu/drm/msm/msm_mdss.c: error: case label does not reduce to an integer constant:  => 300:2, 299:2, 296:2
> >>
> >>
> >> Are these due to the sign bit being set after a shift?
> >> It looks that way since it is only reported for such values.
> >
> > Yep.
> >
> >> From the reports on the build server, it only happens when building with gcc5.
> >> I don't have the ability to build with gcc5 or I would test it.
> >
> > I deliberately installed gcc-5.5.0-nolibc/aarch64-linux to reproduce it
> > (gcc5 on x86 didn't reproduce).
>
> Yes, I installed that same compiler. When I tried to use it, I got:
>
> /opt/crosstool/gcc-5.5.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc: unknown C compiler
> scripts/Kconfig.include:44: Sorry, this C compiler is not supported.

I didn't run into that. I used

make ARCH=arm64
CROSS_COMPILE=/opt/cross/gcc-5.5.0-nolibc/aarch64-linux/bin/aarch64-linux-
drivers/gpu/drm/msm/msm_mdss.o

I did have to disable CONFIG_GCC_PLUGINS, else it couldn't find
<gmp.h>.

> >> @Rob and other drm/msm people, what do you think about this?
> >> (or is this already fixed somewhere but not yet in linux-next?)
> >
> > Thanks, I posted a similar fix two weeks ago:
> > https://lore.kernel.org/all/20230306090633.65918-1-geert+renesas@glider.be
>
> OK, I replied to that one.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
