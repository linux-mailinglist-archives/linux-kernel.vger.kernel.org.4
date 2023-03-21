Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9206C2B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCUHes convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 03:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCUHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:34:46 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FB301A9;
        Tue, 21 Mar 2023 00:34:22 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id c19so16845825qtn.13;
        Tue, 21 Mar 2023 00:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi2yBeJQj8793+/KHPYZqClW0o0BUE+jiSVHLBZTZjU=;
        b=eVuADknkkqLB1c6ILbn0H1aztEp1OfLpZWOyUC3KrbYOW4dzt8DzL+UU65SIWG32Gp
         xVOl+j4keGYTQalJ+qBlRStGmTJDaJdmcqQ6gutnjuLQkjW+sIcgaeqWQi9DPKG2JVeh
         gxPYd7oHdDb9SepSlGocxSl2ALpwzyZa5urg6qsVJUuLumRa5fhPDTTb7f9GVM23W29H
         rCOWez4768iXBgwmKSn9nyhqEM0sI1Uj6vqvwi7OGlV1do+ZL32ULKXGwmmDAJoVidok
         6pkIBJDlW0VNy7y1Ut3k1+EaLtiA2o+m+ysthOMC2kBo8xqFrwdUL+ztwFnHNtKnimB+
         KVJg==
X-Gm-Message-State: AO0yUKVaWrWF5yg85WadMnxt49C2yVMabqb0CZdeuAn1KQ5yGLDZMxuh
        aZCmLCgN7z+/5kAtndxVVF6l7wjEs0NRUA==
X-Google-Smtp-Source: AK7set+iCSpsmEdTcu698xydMV6X6ZJFNKxgMaJxv4GAM6au5yaB0BPPDiwv5bP8cUH/DLiYT4U6vQ==
X-Received: by 2002:a05:622a:1313:b0:3db:e078:2886 with SMTP id v19-20020a05622a131300b003dbe0782886mr3120025qtk.38.1679384057998;
        Tue, 21 Mar 2023 00:34:17 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 196-20020a370acd000000b0074690b42617sm2276716qkk.15.2023.03.21.00.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 00:34:17 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id y5so15981500ybu.3;
        Tue, 21 Mar 2023 00:34:16 -0700 (PDT)
X-Received: by 2002:a5b:c0d:0:b0:a02:a3a6:78fa with SMTP id
 f13-20020a5b0c0d000000b00a02a3a678famr628369ybq.12.1679384056720; Tue, 21 Mar
 2023 00:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320082146.4117022-1-geert@linux-m68k.org> <c85681c6-6fcf-33ed-210f-661e539f78d8@infradead.org>
In-Reply-To: <c85681c6-6fcf-33ed-210f-661e539f78d8@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Mar 2023 08:34:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWw0OdLPUORh6=Be8AW6bN+Pa2t=dcF47B1m=-ihsNPZQ@mail.gmail.com>
Message-ID: <CAMuHMdWw0OdLPUORh6=Be8AW6bN+Pa2t=dcF47B1m=-ihsNPZQ@mail.gmail.com>
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

On Tue, Mar 21, 2023 at 6:38 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/20/23 01:21, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v6.3-rc3[1] compared to v6.2[2].
> >
> > Summarized:
> >   - build errors: +9/-14
> >   - build warnings: +4/-1447
> >
> > JFYI, when comparing v6.3-rc3[1] to v6.3-rc2[3], the summaries are:
> >   - build errors: +0/-1
> >   - build warnings: +0/-0
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e8d018dd0257f744ca50a729e3d042cf2ec9da65/ (all 152 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c9c3395d5e3dcc6daee66c6908354d47bf98cb0c/ (all 152 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eeac8ede17557680855031c6f305ece2378af326/ (all 152 configs)
> >
> >
> > *** ERRORS ***
> >
> > 9 error regressions:
>
> >   + /kisskb/src/drivers/gpu/drm/msm/msm_mdss.c: error: case label does not reduce to an integer constant:  => 300:2, 299:2, 296:2
>
>
> Are these due to the sign bit being set after a shift?
> It looks that way since it is only reported for such values.

Yep.

> From the reports on the build server, it only happens when building with gcc5.
> I don't have the ability to build with gcc5 or I would test it.

I deliberately installed gcc-5.5.0-nolibc/aarch64-linux to reproduce it
(gcc5 on x86 didn't reproduce).

> @Rob and other drm/msm people, what do you think about this?
> (or is this already fixed somewhere but not yet in linux-next?)

Thanks, I posted a similar fix two weeks ago:
https://lore.kernel.org/all/20230306090633.65918-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
