Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC85C744BEF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGBAYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 20:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGBAYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 20:24:37 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38310DF
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 17:24:36 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bfee66a5db6so2915228276.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 17:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688257476; x=1690849476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urzXsrUWGcl4UyBILDjOiaiWQROp3RKTi/U4MGrtkrM=;
        b=iZOAttD7VYAawco0QIHpxIFtGOHtWeU2LK7KpRl3l8lETQjIYGQrHH/nupFtERCd8S
         zkd5lbE+ICbk5XImA8eLJh7042KfwpiuS0jJY5lYUyyzenvvwpeMO/eyaySb1SYiDAuX
         fS0Wjm8+2BNzXIA7y82Gq6/1uNnAVlLECP6Wzr1JJnEB2IpKwb+ySKCiEYoMuNdz6tDU
         Zee4eH/NRcxjCnQRLQcjz8qzaGjtT76GGz4vuSDOiXcwX9I9yMXD51vx52yephJw64Wn
         hiPxanafedXHM9UMODNhgfwMwD9pF0CZ1oVe063Jq8PvRQmsh+wrAgwNhVKTeGTpiLU/
         aVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688257476; x=1690849476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urzXsrUWGcl4UyBILDjOiaiWQROp3RKTi/U4MGrtkrM=;
        b=GqL3B1SE0yEnGoLjK2J+AquQVIS6Vn3QB4QFNTG7TiYYQuG2QXSKdY7Gqddw9aH17W
         1KsP09bq5ICg2wD4ov8orcEQPuI8rVBc5Ny8LTv7Ma9abk59aWeQ8sYKH3mBSkfjLB9C
         ZGioiNDLamie7GADCGIgIs3oZukDcsNoWw36LlUWVoS40b3RlTITpckWCkZKa1Ezq8j1
         OkLAT6Uvi20TU6HNPHr8zPDyybsMoS0nCGPN8h/xPS2nuWVfk98h3MS3jtZyygObN1Vr
         hbc0YxwhjQLKJLOZAK1cupwozLor6Bc9bUiN/8pfttkqEgN9qqcBPan6JpdKaIHBsook
         0JtA==
X-Gm-Message-State: ABy/qLYGKaEojvh5iAvqRunfhal4XLLrPzzDP+EfGJQm8R1p6bYIzdrA
        J9OTZvEJHBRc5xV15OB4ZfJqKh9CplivBM/liD/LKg==
X-Google-Smtp-Source: APBJJlGs2pz64z1/S2iPbXPMC9ztG90XJQHlFFYOdiHoEDy/FwFGZpceDr9gy6ZybwdrV2YU3rBeED0TUj4duHCPyd8=
X-Received: by 2002:a25:842:0:b0:c1d:4fce:464 with SMTP id 63-20020a250842000000b00c1d4fce0464mr5385642ybi.9.1688257475814;
 Sat, 01 Jul 2023 17:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a635-v2-1-5494c881b8be@linaro.org> <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com>
In-Reply-To: <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 2 Jul 2023 03:24:24 +0300
Message-ID: <CAA8EJpripp+Hf=GvCit75naGQqK8owHzPb+VuYHin393HcFPwA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: Assign revn to A635
To:     Rob Clark <robdclark@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2023 at 18:50, Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Jun 30, 2023 at 4:12=E2=80=AFPM Konrad Dybcio <konrad.dybcio@lina=
ro.org> wrote:
> >
> > Recently, a WARN_ON() was introduced to ensure that revn is filled befo=
re
> > adreno_is_aXYZ is called. This however doesn't work very well when revn=
 is
> > 0 by design (such as for A635). Fill it in as a stopgap solution for
> > -fixes.
> >
> > Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified bef=
ore being set")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > Changes in v2:
> > - add fixes
> > - Link to v1: https://lore.kernel.org/r/20230628-topic-a635-v1-1-5056e0=
9c08fb@linaro.org
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index cb94cfd137a8..8ea7eae9fc52 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] =3D {
> >                 .address_space_size =3D SZ_16G,
> >         }, {
> >                 .rev =3D ADRENO_REV(6, 3, 5, ANY_ID),
> > +               .revn =3D 635,
> >                 .fw =3D {
> >                         [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> >                         [ADRENO_FW_GMU] =3D "a660_gmu.bin",
> >
>
> hmm, I realized a problem with this, it would change what
> MSM_PARAM_GPU_ID and more importantly MSM_PARAM_CHIP_ID return..  The
> former should be "harmless", although it isn't a good idea for uabi
> changes to be a side effect of a fix.  The latter is more problematic.

I'd say MSM_PARAM_GPU_ID is broken for 635 anyway (won't it return 0
in this case)?
So the new value should be correct.

But more importantly, why are we exporting speedbin in
MSM_PARAM_CHIP_ID only if there is no revn? And why are we exporting
the speedbin at all as a part of CHIP_ID?

>
> I think I'm leaning more towards reverting commit cc943f43ece7
> ("drm/msm/adreno: warn if chip revn is verified before being set") for
> -fixes.  I'm still thinking about options for a longer term fix.
>
> BR,
> -R
>
>
> > ---
> > base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> > change-id: 20230628-topic-a635-1b3c2c987417
> >
> > Best regards,
> > --
> > Konrad Dybcio <konrad.dybcio@linaro.org>
> >



--=20
With best wishes
Dmitry
