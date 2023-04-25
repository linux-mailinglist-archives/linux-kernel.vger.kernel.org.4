Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457B26EE10E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjDYL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjDYL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:29:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D933C04
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:29:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-508418b6d59so10360541a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682422155; x=1685014155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1nwF4kKWtunxpN6x1cZvs+8NAr3cIrq1nqIj78OXC0=;
        b=yps9efPE56h8YypYTfVXepsLT5PtBXWsHXI0YhVzeF2MkvHPBvi7NyD+QNASitywE1
         MaSBTlfunCSskCcTj0eCHpTHUuECPyGENqvYpaH+8ZA571U60fHoN2KvRua4sVG4ymGX
         4JsCsGf+3WkX5BW2Cw1lF0mIYE/Um8EEyKmHRcQt/DISj90XagxTSU5uer12QtJk1FxC
         FuAr0EdccL3o25jR8jpqa3o+m06ON1kvzvrGJ28N1fsYqwvrFi870nFw7ty87bu2Lhv1
         I+yjAnitXDUd3hwKlPGm4KQQnyhomSmnrNzxPm2ia0qf46SB5Ly+l+2L/Jr/lVBvN+DG
         jjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682422155; x=1685014155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1nwF4kKWtunxpN6x1cZvs+8NAr3cIrq1nqIj78OXC0=;
        b=gFchDS+OSFVKg5rbMYDVnko/9znBi08xd7TMWrUhJKpsKn7Kxy4tY/0ymwStyyr+pZ
         R23L8RieKWtjhYydTowbdCBNfLInhOVzjqHGdpKfq0kk8yv1lBx1fCfseT1EPCtbSj0a
         OdSDptZ8tvFzddVgtyrqT9tvzcm+fITeDNoK2j2EAoAkE4I6dj/u84ugSlmD1vPMZMs4
         iC9Reut+rQPpwTyf5Hu3Tm1RfmksvAqC1XS+PUV+Jsu+LXo63dVJPXGFLeMTqPmKPomk
         WDUaldnxdjaaEetA5FXc0+sHflJDEvyP/AsLfJdMzSs8QJ+92VPfQOrWUXCuIUyRkpm1
         yM8Q==
X-Gm-Message-State: AAQBX9cO7hYDvcxP1B2SDt1pvRhnUMMLX5NiIN0+VN+KfvGWdL8Zd3s0
        hdWmCOhzXSEiV9v/YvDJWhDXwc59WUqdGKMbfoucsw==
X-Google-Smtp-Source: AKy350YQSqh9s/SmBnFSrcBrZBRbDOugQ/O+hRGsZSA3JCuB/nNzhr1I9QOBFc8GeJdRI6uxOxpvQT1eYhskMHB2GYc=
X-Received: by 2002:aa7:d491:0:b0:506:a663:5c1b with SMTP id
 b17-20020aa7d491000000b00506a6635c1bmr12120401edr.18.1682422155536; Tue, 25
 Apr 2023 04:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
 <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
 <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
 <fab67eef-4dc9-420d-b127-aedc6f54cad0@notapiano> <CAGXv+5E0rzByZBn91d60MQ7P0=GbAQUH=PK9EYDu3Upr33td6A@mail.gmail.com>
In-Reply-To: <CAGXv+5E0rzByZBn91d60MQ7P0=GbAQUH=PK9EYDu3Upr33td6A@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 25 Apr 2023 13:28:39 +0200
Message-ID: <CAGuA+oo0w8n9zEKdd1UfYx+F08wK4CcUGqRbBi4C-xNYp+vtDA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 12:00=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Tue, Apr 25, 2023 at 6:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Tue, Mar 28, 2023 at 02:20:24AM +0200, Balsam CHIHI wrote:
> > > On Sat, Mar 25, 2023 at 5:33=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.=
org> wrote:
> > > >
> > > > On Wed, Mar 22, 2023 at 8:48=E2=80=AFPM Balsam CHIHI <bchihi@baylib=
re.com> wrote:
> > > > >
> > > > > Hi Chen-Yu,
> > > > >
> > > > > I suspect the bug comes from incorrect calibration data offsets f=
or AP
> > > > > Domain because you confirm that MCU Domain probe runs without iss=
ues.
> > > > > Is it possible to test something for us to confirm this theory (i
> > > > > don't have an mt8192 board on hand now), when you have the time o=
f
> > > > > course?
> > > > > We would like to test AP Domain's calibration data offsets with a
> > > > > working one, for example :
> > > > >
> > > > >  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =
=3D {
> > > > >                 {
> > > > > -               .cal_offset =3D { 0x25, 0x28 },
> > > > > +               .cal_offset =3D { 0x04, 0x04 },
> > > > >                 .lvts_sensor =3D {
> > > > >                         { .dt_id =3D MT8192_AP_VPU0 },
> > > > >                         { .dt_id =3D MT8192_AP_VPU1 }
> > > > > @@ -1336,7 +1336,7 @@ static const struct lvts_ctrl_data
> > [..]
> > > > >
> > > > > This example is tested and works for mt8195,
> > > > > (all sensors use the same calibration data offset for testing pur=
poses).
> > > > >
> > > > > Thank you in advance for your help.
> > > >
> > > > The MCU ones are still tripping though. If I change all of them to =
0x04,
> > > > then nothing trips. There's also a bug in the interrupt handling co=
de
> > > > that needs to be dealt with.
> > > >
> > > > AFAICT the calibration data is stored differently. If you look at C=
hromeOS's
> > > > downstream v5.10 driver, you'll see mt6873_efuse_to_cal_data() for =
MT8192,
> > > > and mt8195_efuse_to_cal_data() for MT8195. The difference sums up t=
o:
> > > > MT8195 has all data sequentially stored, while MT8192 has most data=
 stored
> > > > in lower 24 bits of each 32-bit word, and the highest 8 bits are th=
en used
> > > > to pack data for the remaining sensors.
> > > >
> > > > Regards
> > > > ChenYu
> > >
> > > Hi Chen-Yu Tsai,
> > >
> > > Thank you very much for helping me testing this suggestion.
> > >
> > > Indeed, calibration data is stored differently in the mt8192 compared=
 to mt8195.
> > > So, the mt8192's support will be delayed for now, to allow further de=
bugging.
> > >
> > > In the mean time, we will only continue to upstream the remaining
> > > mt8195's source code, so it will get full LVTS support.
> > > A new series will be submitted soon.
> >
> > Hi Balsam,
> >
> > like Chen-Yu mentioned, the calibration data is stored with 4 byte alig=
nment for
> > MT8192, but the data that is split between non-contiguous bytes is for =
the
> > thermal controllers (called Resistor-Capacitor Calibration downstream) =
not the
> > sensors. The controller calibration isn't currently handled in this dri=
ver (and
> > downstream it also isn't used, since a current value is read from the c=
ontroller
> > instead), so we can just ignore those.
> >
> > The patch below adjusts the addresseses for the sensors and gives me re=
asonable
> > reads, so the machine no longer reboots. Can you integrate it into your=
 series?
>
> Not sure what I got wrong, but on my machine the VPU0 and VPU1 zone inter=
rupts
> are still tripping excessively. The readings seem normal though. Specific=
ally,
> it's bits 16 and 17 that are tripping.
>

Hi Chen-Yu,

Thank you for testing!

As the readings are normal that proves that calibration data offsets
are correct.
would you like that I send the v2 of series to add mt8192 support?
Then we could deal with the interrupts later in a separate fix,
because the interrupt code in common for both SoC (mt8192 and mt8195)?

Does N=C3=ADcolas also have tripping interrupts?
On my side, I've got no interrupts tripping on mt8195.

Any other suggestions (a question for everyone)?

Best regards,
Balsam

> > Thanks,
> > N=C3=ADcolas
> >
> > From 4506f03b806f3eeb89887bac2c1c86d61da97281 Mon Sep 17 00:00:00 2001
> > From: =3D?UTF-8?q?N=3DC3=3DADcolas=3D20F=3D2E=3D20R=3D2E=3D20A=3D2E=3D2=
0Prado?=3D
> >  <nfraprado@collabora.com>
> > Date: Mon, 24 Apr 2023 17:42:42 -0400
> > Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Fix calibration
> >  offsets for MT8192
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >  drivers/thermal/mediatek/lvts_thermal.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/=
mediatek/lvts_thermal.c
> > index b6956c89d557..f8afbc2ac190 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -1261,7 +1261,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap=
_data_ctrl[] =3D {
> >
> >  static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
> >         {
> > -               .cal_offset =3D { 0x04, 0x07 },
> > +               .cal_offset =3D { 0x04, 0x08 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_MCU_BIG_CPU0 },
> >                         { .dt_id =3D MT8192_MCU_BIG_CPU1 }
> > @@ -1271,7 +1271,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mc=
u_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x0d, 0x10 },
> > +               .cal_offset =3D { 0x0c, 0x10 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_MCU_BIG_CPU2 },
> >                         { .dt_id =3D MT8192_MCU_BIG_CPU3 }
> > @@ -1281,7 +1281,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mc=
u_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x16, 0x19, 0x1c, 0x1f },
> > +               .cal_offset =3D { 0x14, 0x18, 0x1c, 0x20 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_MCU_LITTLE_CPU0 },
> >                         { .dt_id =3D MT8192_MCU_LITTLE_CPU1 },
> > @@ -1296,7 +1296,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mc=
u_data_ctrl[] =3D {
> >
> >  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D {
> >                 {
> > -               .cal_offset =3D { 0x25, 0x28 },
> > +               .cal_offset =3D { 0x24, 0x28 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_VPU0 },
> >                         { .dt_id =3D MT8192_AP_VPU1 }
> > @@ -1306,7 +1306,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap=
_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x2e, 0x31 },
> > +               .cal_offset =3D { 0x2c, 0x30 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_GPU0 },
> >                         { .dt_id =3D MT8192_AP_GPU1 }
> > @@ -1316,7 +1316,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap=
_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x37, 0x3a },
> > +               .cal_offset =3D { 0x34, 0x38 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_INFRA },
> >                         { .dt_id =3D MT8192_AP_CAM },
> > @@ -1326,7 +1326,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap=
_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x40, 0x43, 0x46 },
> > +               .cal_offset =3D { 0x3c, 0x40, 0x44 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_MD0 },
> >                         { .dt_id =3D MT8192_AP_MD1 },
> > --
> > 2.40.0
