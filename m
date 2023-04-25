Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1B6EDE50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjDYIkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjDYIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:40:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D86146DF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:38:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so40988249a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682411837; x=1685003837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJCGkPHoGSFZY63Jqk/nlt1gBwH2vblI+IkzLVWvpyw=;
        b=qwfqHUkBa7MLPI/9HCXNiZc76W0GkP5Ath0jV1H3+r0utDr49cmvw5UBWdJ69LgKbI
         kQAEOU9N2BqTGmrCaEK/vo0+T2JHyTap65Pq9oze1UpbpGCFnftJil9yx/8njN5kiEbS
         2raHHC5Ci+xvifegJ4Syjenb6nDAyBcRf6fmloy9SGRJxifER74ESVUGSoWIpG65im6w
         jV4TwQDS+0Kjl6VkVvcV5v48L3ufniarmCglJzgwvS2qUkPUC3pk6xZkn7eyc6w5vfhh
         9ttyNT8VXpKD+/vNpQmAWEcvpBd3hq2oWqHDW8GxTuOLilBbBEvdAIYMmqXhQLvGRmOP
         IfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411837; x=1685003837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJCGkPHoGSFZY63Jqk/nlt1gBwH2vblI+IkzLVWvpyw=;
        b=igg/uaUGc8aaMXd1/PNapf8Gd9ChChygjKFUFqIkeN4m7AqYfjAV8jt02kCsvp77W3
         PHy2JPuE2yrLaw7/Gq/LRw4Xiv1oOzqcobF0pOhd5Fy107JWo+6W3ZFlqhbjyNCAFAP/
         H9y4Exk+DULv8wnkC2j2b2ii1TwtgpE4H2R0eVy7c84RqscN+fpa2z18Z47Zzl0aqdbO
         krX70d4Rei1HfJbNn3TPFKGYCTxlyQ8YMl82KaZXBwzhQn83L9VIwlfEeohjCglUpIY6
         gWvcl8swGgy7zxude9Y/MjYcLRm9/VQt96Obzr0rYngddojJTIYyy+s7rKlrX+DINZQm
         puHQ==
X-Gm-Message-State: AAQBX9cAouN+IcfQtjvzHUYRqaOoe3OXIy8FAI+1jdRwPsSQVuNSU3tD
        crFldOSgHZ7BWKSlRNtRZxTwXdZ/0YxQqs9bCjLCXA==
X-Google-Smtp-Source: AKy350ZzCimN5VBMy4odr40aNaphS9WPL5s1QsFomwpin6cX6Jv2A3zwror5ZbdEtmZc6/prsBRh7o0cC4Z0CxnVDwY=
X-Received: by 2002:aa7:c84d:0:b0:504:b11e:8cfb with SMTP id
 g13-20020aa7c84d000000b00504b11e8cfbmr15104412edt.13.1682411837571; Tue, 25
 Apr 2023 01:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
 <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
 <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com> <fab67eef-4dc9-420d-b127-aedc6f54cad0@notapiano>
In-Reply-To: <fab67eef-4dc9-420d-b127-aedc6f54cad0@notapiano>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 25 Apr 2023 10:36:41 +0200
Message-ID: <CAGuA+ooRGAjXONtXi9G_jTwxrHG0=OerAfK2b3mo0Z+RhPW4Wg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, daniel.lezcano@linaro.org,
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

On Tue, Apr 25, 2023 at 12:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Mar 28, 2023 at 02:20:24AM +0200, Balsam CHIHI wrote:
> > On Sat, Mar 25, 2023 at 5:33=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> > >
> > > On Wed, Mar 22, 2023 at 8:48=E2=80=AFPM Balsam CHIHI <bchihi@baylibre=
.com> wrote:
> > > >
> > > > Hi Chen-Yu,
> > > >
> > > > I suspect the bug comes from incorrect calibration data offsets for=
 AP
> > > > Domain because you confirm that MCU Domain probe runs without issue=
s.
> > > > Is it possible to test something for us to confirm this theory (i
> > > > don't have an mt8192 board on hand now), when you have the time of
> > > > course?
> > > > We would like to test AP Domain's calibration data offsets with a
> > > > working one, for example :
> > > >
> > > >  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D =
{
> > > >                 {
> > > > -               .cal_offset =3D { 0x25, 0x28 },
> > > > +               .cal_offset =3D { 0x04, 0x04 },
> > > >                 .lvts_sensor =3D {
> > > >                         { .dt_id =3D MT8192_AP_VPU0 },
> > > >                         { .dt_id =3D MT8192_AP_VPU1 }
> > > > @@ -1336,7 +1336,7 @@ static const struct lvts_ctrl_data
> [..]
> > > >
> > > > This example is tested and works for mt8195,
> > > > (all sensors use the same calibration data offset for testing purpo=
ses).
> > > >
> > > > Thank you in advance for your help.
> > >
> > > The MCU ones are still tripping though. If I change all of them to 0x=
04,
> > > then nothing trips. There's also a bug in the interrupt handling code
> > > that needs to be dealt with.
> > >
> > > AFAICT the calibration data is stored differently. If you look at Chr=
omeOS's
> > > downstream v5.10 driver, you'll see mt6873_efuse_to_cal_data() for MT=
8192,
> > > and mt8195_efuse_to_cal_data() for MT8195. The difference sums up to:
> > > MT8195 has all data sequentially stored, while MT8192 has most data s=
tored
> > > in lower 24 bits of each 32-bit word, and the highest 8 bits are then=
 used
> > > to pack data for the remaining sensors.
> > >
> > > Regards
> > > ChenYu
> >
> > Hi Chen-Yu Tsai,
> >
> > Thank you very much for helping me testing this suggestion.
> >
> > Indeed, calibration data is stored differently in the mt8192 compared t=
o mt8195.
> > So, the mt8192's support will be delayed for now, to allow further debu=
gging.
> >
> > In the mean time, we will only continue to upstream the remaining
> > mt8195's source code, so it will get full LVTS support.
> > A new series will be submitted soon.
>
> Hi Balsam,
>
> like Chen-Yu mentioned, the calibration data is stored with 4 byte alignm=
ent for
> MT8192, but the data that is split between non-contiguous bytes is for th=
e
> thermal controllers (called Resistor-Capacitor Calibration downstream) no=
t the
> sensors. The controller calibration isn't currently handled in this drive=
r (and
> downstream it also isn't used, since a current value is read from the con=
troller
> instead), so we can just ignore those.
>
> The patch below adjusts the addresseses for the sensors and gives me reas=
onable
> reads, so the machine no longer reboots. Can you integrate it into your s=
eries?
>
> Thanks,
> N=C3=ADcolas
>

Hello N=C3=ADcolas,

Thank you very much for your help!
I really appreciate it.
Yes, of course I will integrate your fix to the series immediately.

Best regards,
Balsam

> From 4506f03b806f3eeb89887bac2c1c86d61da97281 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?N=3DC3=3DADcolas=3D20F=3D2E=3D20R=3D2E=3D20A=3D2E=3D20P=
rado?=3D
>  <nfraprado@collabora.com>
> Date: Mon, 24 Apr 2023 17:42:42 -0400
> Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Fix calibration
>  offsets for MT8192
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index b6956c89d557..f8afbc2ac190 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1261,7 +1261,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
>
>  static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
>         {
> -               .cal_offset =3D { 0x04, 0x07 },
> +               .cal_offset =3D { 0x04, 0x08 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_MCU_BIG_CPU0 },
>                         { .dt_id =3D MT8192_MCU_BIG_CPU1 }
> @@ -1271,7 +1271,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x0d, 0x10 },
> +               .cal_offset =3D { 0x0c, 0x10 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_MCU_BIG_CPU2 },
>                         { .dt_id =3D MT8192_MCU_BIG_CPU3 }
> @@ -1281,7 +1281,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x16, 0x19, 0x1c, 0x1f },
> +               .cal_offset =3D { 0x14, 0x18, 0x1c, 0x20 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_MCU_LITTLE_CPU0 },
>                         { .dt_id =3D MT8192_MCU_LITTLE_CPU1 },
> @@ -1296,7 +1296,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>
>  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D {
>                 {
> -               .cal_offset =3D { 0x25, 0x28 },
> +               .cal_offset =3D { 0x24, 0x28 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_VPU0 },
>                         { .dt_id =3D MT8192_AP_VPU1 }
> @@ -1306,7 +1306,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x2e, 0x31 },
> +               .cal_offset =3D { 0x2c, 0x30 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_GPU0 },
>                         { .dt_id =3D MT8192_AP_GPU1 }
> @@ -1316,7 +1316,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x37, 0x3a },
> +               .cal_offset =3D { 0x34, 0x38 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_INFRA },
>                         { .dt_id =3D MT8192_AP_CAM },
> @@ -1326,7 +1326,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x40, 0x43, 0x46 },
> +               .cal_offset =3D { 0x3c, 0x40, 0x44 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_MD0 },
>                         { .dt_id =3D MT8192_AP_MD1 },
> --
> 2.40.0
