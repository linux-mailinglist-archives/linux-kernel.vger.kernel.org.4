Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0719744E17
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGBObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:31:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A53E5E;
        Sun,  2 Jul 2023 07:31:39 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b74b37fbe0so3060982a34.1;
        Sun, 02 Jul 2023 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688308299; x=1690900299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88WutuRFo5WgJcYE0wkhr8U2pMfpdX9vpFvhW0Euzqw=;
        b=Q6NyYbxP2qEn2Xutl+FCmmv4u6vk4SUdd0kUp1aKMGv2lL0rWAaH/9qukZ808LJrSu
         W0I8koTlOwYKzChZyBTYE1sdeZBOXUOhJiNiiuv8Vn/9eLvcgeCr8NyJvaxhKn5bXn3H
         TZi83tOqNzbqK/7arYfUL9NIfvb7mHFbB+zDIvWr0pMDygLmnSzhjNTf+OMhAXDkuHh3
         YptOeF0ontuAsHf7dGPHLkKoWNVaUSynyViGQm/B/FvldaikeWo451PxAeeLlUKnSq4y
         RONdiCRiIrpf7LsliZP2NvVPE8ROVV18aO/EWv/FVs9mc2r5ARNsjoCQLYcdFppGpDDC
         lbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688308299; x=1690900299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88WutuRFo5WgJcYE0wkhr8U2pMfpdX9vpFvhW0Euzqw=;
        b=RkSVCvJPvsD2h1mMg8NdaypoQlpTddpaGMQXQDNYNmGaULLqGlWsvm7Y9Brj4rW6RS
         mONcSECdOLsvhmFc0mz+N1TSYXd+3UdUx1icCFrrOdWei6DEJHZnJSURfKG7jaA0z/of
         jdEhO1szeZEJekdiuW3w9fn7tqz97fwotg3M5oCZRBPTz2cgcAyV/eK+ZDST8hv6DKtY
         Kbf1zJhA+zf5iL5Kn6YImzW13+Kr5xPRkJFVpR2zOHY2lp3Cj8t13mfIfM7MqA4HJeJc
         UveKQERVHDDuGo6guvUX/+0QsSYrJbMytgb+ZVONK8I6gnMRbt129Zi9WMf3Kl/bAAtP
         SoGQ==
X-Gm-Message-State: AC+VfDx81YUwaHW2tvB2h7XSnZGvaOxnfjT6ormUBb+97+8NfYF7QwnN
        x9TEnWwOGxhfklZDXTyLIyqr3SPg6mkUjApXFcA=
X-Google-Smtp-Source: ACHHUZ70JPiogGnsvR1zJCU7ntAzo1ZSFvSXj5OfCRUvRh+KkQrmPShZS1FAwuEHFRDFaFf/8Ei7rvSLinqdYERzTrc=
X-Received: by 2002:a9d:7b4e:0:b0:6b8:7fe2:cde5 with SMTP id
 f14-20020a9d7b4e000000b006b87fe2cde5mr9968767oto.24.1688308299043; Sun, 02
 Jul 2023 07:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a635-v2-1-5494c881b8be@linaro.org>
 <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com> <CAA8EJpripp+Hf=GvCit75naGQqK8owHzPb+VuYHin393HcFPwA@mail.gmail.com>
In-Reply-To: <CAA8EJpripp+Hf=GvCit75naGQqK8owHzPb+VuYHin393HcFPwA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 2 Jul 2023 07:31:27 -0700
Message-ID: <CAF6AEGsdPhWO+hw3FHiqtMfiF34_RtrvvS4apykHNBbtmdj7fQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: Assign revn to A635
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 5:24=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 1 Jul 2023 at 18:50, Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Fri, Jun 30, 2023 at 4:12=E2=80=AFPM Konrad Dybcio <konrad.dybcio@li=
naro.org> wrote:
> > >
> > > Recently, a WARN_ON() was introduced to ensure that revn is filled be=
fore
> > > adreno_is_aXYZ is called. This however doesn't work very well when re=
vn is
> > > 0 by design (such as for A635). Fill it in as a stopgap solution for
> > > -fixes.
> > >
> > > Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified b=
efore being set")
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > > Changes in v2:
> > > - add fixes
> > > - Link to v1: https://lore.kernel.org/r/20230628-topic-a635-v1-1-5056=
e09c08fb@linaro.org
> > > ---
> > >  drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu=
/drm/msm/adreno/adreno_device.c
> > > index cb94cfd137a8..8ea7eae9fc52 100644
> > > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > > @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] =3D {
> > >                 .address_space_size =3D SZ_16G,
> > >         }, {
> > >                 .rev =3D ADRENO_REV(6, 3, 5, ANY_ID),
> > > +               .revn =3D 635,
> > >                 .fw =3D {
> > >                         [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> > >                         [ADRENO_FW_GMU] =3D "a660_gmu.bin",
> > >
> >
> > hmm, I realized a problem with this, it would change what
> > MSM_PARAM_GPU_ID and more importantly MSM_PARAM_CHIP_ID return..  The
> > former should be "harmless", although it isn't a good idea for uabi
> > changes to be a side effect of a fix.  The latter is more problematic.
>
> I'd say MSM_PARAM_GPU_ID is broken for 635 anyway (won't it return 0
> in this case)?
> So the new value should be correct.

no, it is very much intentional that GPU_ID returns 0 for newer GPUs,
userspace should be matching on CHIP_ID.  (Also, we should be moving
away from trying to infer generation/etc from CHIP_ID.. userspace is
farther ahead of the kernel on this.)

> But more importantly, why are we exporting speedbin in
> MSM_PARAM_CHIP_ID only if there is no revn? And why are we exporting
> the speedbin at all as a part of CHIP_ID?

Basically just being paranoid about not changing uabi.  It probably
would be ok to export the speedbin for all, but I'd have to double
check mesa version history.

BR,
-R

> >
> > I think I'm leaning more towards reverting commit cc943f43ece7
> > ("drm/msm/adreno: warn if chip revn is verified before being set") for
> > -fixes.  I'm still thinking about options for a longer term fix.
> >
> > BR,
> > -R
> >
> >
> > > ---
> > > base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> > > change-id: 20230628-topic-a635-1b3c2c987417
> > >
> > > Best regards,
> > > --
> > > Konrad Dybcio <konrad.dybcio@linaro.org>
> > >
>
>
>
> --
> With best wishes
> Dmitry
