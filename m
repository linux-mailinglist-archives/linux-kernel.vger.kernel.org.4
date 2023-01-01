Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81A65AC0A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 23:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjAAWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 17:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjAAWSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 17:18:25 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B1B261B;
        Sun,  1 Jan 2023 14:18:24 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-144bd860fdbso31597111fac.0;
        Sun, 01 Jan 2023 14:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yy52nz5EWhcJsvWpjun3W8BAed7Pu6I0tRm9djceBtE=;
        b=aUKgOPghXlTvzrc6u7k5kEW3PvtUpuXnRdFSLQ/HFxtA6NEyFCGeIJl5XEM3oSYvMf
         yYBCOvMvrbLLqsn3ljLul0VQ5m1mief/TwD2BvREIf58XjoWaiKgm+6hfJ6TI46cjZEe
         AaJGQ+Nuy/06MFO1sIE2johDMzmR9gjbY6uzGckDHw+JpdCEZlGlfMQVIzZe4KgGTlXj
         /Kzwr9YunMYk8/bflwQVODouOYRc9Da+KNWAaky0VoTNcP3OzsJbGd/mSE90Knh8mm3k
         uhoVFbWcZ8nqA4GFNaw4ztPW1vXQ6waLEtTUg0JNhL7Q1TwR0Bwj91flhywYpdXOApta
         N/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yy52nz5EWhcJsvWpjun3W8BAed7Pu6I0tRm9djceBtE=;
        b=PZVlwu+eRB0ASA/hUGj1yFqA29F6jx9PzhdcNt9b/szBBw3GMdtASzZXEccjDWZaaU
         9rjF9pKr0u2wMu6VetlhJNFuZsRyBnnqrWue5p3VPfTGu1l3J/xFErRj4z1U+cZyWIKk
         7Ah23UUxzk/WNsg81ZsFKNHxMxt7rWhGgFgjop6Amfl+B1xpNq3UaiIGHoe10VbEF3f1
         C+PknOTZufL/MXwV/AbR34kiHV2jfEkhJMWu6f+GAo2Zmt6WgTBX0J9Lhub5JQ2GIjzj
         UaEHqvr2hbAKArGHtZRw3w9StXc0CH4jzr/h1tlyr1ED2cbjLL4TpE5+wSx7wgEUjptp
         REiw==
X-Gm-Message-State: AFqh2ko+bmntC1nKOnAODBeFxXFOENu/JqYLamcY3hV5KXFvFvrEk1dF
        QjN1ENPrIPAUyTX201N4rxyU4qiesfiSPRugY7M=
X-Google-Smtp-Source: AMrXdXte8iX8MMHmEPzIXd/8vUmQGEbPcEziUE4Pov+05WakJv8QOTo5ISycioy38t6wUo32zfYPD4Qn9C2ptiMz+wk=
X-Received: by 2002:a05:6870:513:b0:13d:51fe:3404 with SMTP id
 j19-20020a056870051300b0013d51fe3404mr2226606oao.183.1672611504025; Sun, 01
 Jan 2023 14:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20221229101846.981223-1-konrad.dybcio@linaro.org> <20221229104730.guopbgyleb6hif4h@SoMainline.org>
In-Reply-To: <20221229104730.guopbgyleb6hif4h@SoMainline.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 1 Jan 2023 14:18:11 -0800
Message-ID: <CAF6AEGvCT5S0KhcnUwGAbVqZXKxAQk4gfCegucAfQvy+Pgr4+A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Make adreno quirks not overwrite each other
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 2:47 AM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-12-29 11:18:45, Konrad Dybcio wrote:
> > So far the adreno quirks have all been assigned with an OR operator,
> > which is problematic, because they were assigned consecutive integer
> > values, which makes checking them with an AND operator kind of no bueno..
> >
> > Switch to using BIT(n) so that only the quirks that the programmer chose
> > are taken into account when evaluating info->quirks & ADRENO_QUIRK_...
> >
> > Fixes: b5f103ab98c7 ("drm/msm: gpu: Add A5XX target support")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Nice catch!
>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>
> Not sure if it's the right Fixes commit though, as it would have worked
> when ADRENO_QUIRK_LMLOADKILL_DISABLE was added with constant 4 instead
> of 3 in 370063ee427a ("drm/msm/adreno: Add A540 support"), but then
> using bitflags in an enum value type is invalid anyway, AFAIK.

It isn't a thing that c++ like so much, but for c code, gdb will
decode enum bitfields in a sensible way (IIRC).  Also, maybe it
doesn't matter at this point, but it would conflict for stable
backports prior to adding LMLOADKILL_DISABLE.

with the fixes msg corrected,

Reviewed-by: Rob Clark <robdclark@gmail.com>

> - Marijn
>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > index c85857c0a228..5eb254c9832a 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -29,11 +29,9 @@ enum {
> >       ADRENO_FW_MAX,
> >  };
> >
> > -enum adreno_quirks {
> > -     ADRENO_QUIRK_TWO_PASS_USE_WFI = 1,
> > -     ADRENO_QUIRK_FAULT_DETECT_MASK = 2,
> > -     ADRENO_QUIRK_LMLOADKILL_DISABLE = 3,
> > -};
> > +#define ADRENO_QUIRK_TWO_PASS_USE_WFI                BIT(0)
> > +#define ADRENO_QUIRK_FAULT_DETECT_MASK               BIT(1)
> > +#define ADRENO_QUIRK_LMLOADKILL_DISABLE              BIT(2)
> >
> >  struct adreno_rev {
> >       uint8_t  core;
> > @@ -65,7 +63,7 @@ struct adreno_info {
> >       const char *name;
> >       const char *fw[ADRENO_FW_MAX];
> >       uint32_t gmem;
> > -     enum adreno_quirks quirks;
> > +     u64 quirks;
> >       struct msm_gpu *(*init)(struct drm_device *dev);
> >       const char *zapfw;
> >       u32 inactive_period;
> > --
> > 2.39.0
> >
