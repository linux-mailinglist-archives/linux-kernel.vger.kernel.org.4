Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E26CD3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjC2IGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjC2IG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:06:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0484223
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:06:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er13so18827830edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680077178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgTEvOUqu+byIlNns2PeM/+eklWaDNG6sL3F+Izsnuo=;
        b=78B+nejVnS9usHWPg0iqljIaK4pxCQzU1+8yHfJq6bvLatsVHbSasFqcUXDAi1w5ty
         ru6zbvClprRaH6/+61fnfwiWn6Lnt4yCrkUjxEfT9d2AanAzELr4mM8xWdV5scUE0ucB
         ELWD4r4l6HdyvxOsGNVTOK1rE2t8JO/6sZJR7NvuODLSotPDvmafMutvEUGT7OSU9L3S
         nayxjkorDtR+YqpRJ9A31V4yJvw82utxCeqHx5lFS+EMO8sDLIlo9DinRejrMiNbXD9S
         i4Vaheq/9S0knMn8t8VT3MRxm+2Vp1+ViLuycFVSBFcHnBJa6IJNLol+bZGWy4KJ+5Ym
         rx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgTEvOUqu+byIlNns2PeM/+eklWaDNG6sL3F+Izsnuo=;
        b=R3+ixqx73406MCKkP+xucIoiOjGWM3D1WT0ogumQ14KV7VUYNCCbDT4NDEP8w4RhUP
         WDSf5bn9Xay7ZcY9Hrc90fJO7kgpGV9AXXrgI9wuxU1eBPgfCWii0htg6KXYjHnxIAbu
         ZAGxGdlOSfjw2aGxqOexCADXu/3A6+luXXppWNsnEv4GOVqxR8uf1QzPAOsNa+hCcCcG
         XV8j7/fq/OGOaFuZmpzsKK6w0RbZdmm6eVuJlcXK/1TJoVrnqziiMbLWAEkKqAipmGT1
         mreBR+czsLBnkB/bfaS/dKyRkbfueMYERJ0dQ9aVXX/i0MwNKv2BywKINsHL7Pp9O+v0
         eF8Q==
X-Gm-Message-State: AAQBX9f5+DBKb54DWLapOh/Ppw1d2mb/4mIO6hl4i4j/6IwhfsC2ko0F
        fg9kxkASlY2reREh+otEXW5I8ElQRx8nR9uu7kc02w==
X-Google-Smtp-Source: AKy350YCm9Z8/PIeUFOKRay3tHd8uEY3gEm45xBRMugyFV6UFUnNJW6cauEggJeb48L7uR904b/TwctWGwwl+7M3Ehs=
X-Received: by 2002:a17:907:d687:b0:93d:a14f:c9b4 with SMTP id
 wf7-20020a170907d68700b0093da14fc9b4mr9282057ejc.2.1680077178000; Wed, 29 Mar
 2023 01:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
 <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
 <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com> <CAGXv+5GGO76H9Z-X=3nhtmSyp7uhuUF4DE0T527M5z+SBX482Q@mail.gmail.com>
In-Reply-To: <CAGXv+5GGO76H9Z-X=3nhtmSyp7uhuUF4DE0T527M5z+SBX482Q@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 29 Mar 2023 10:05:41 +0200
Message-ID: <CAGuA+or4CvyZVNuMu9tOvpoZ5nJimbp7=KX-85FiF4ghaownAg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Tue, Mar 28, 2023 at 5:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Tue, Mar 28, 2023 at 8:21=E2=80=AFAM Balsam CHIHI <bchihi@baylibre.com=
> wrote:
> >
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
> > > > mt8192_lvts_ap_data_ctrl[] =3D {
> > > >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> > > >         },
> > > >         {
> > > > -               .cal_offset =3D { 0x2e, 0x31 },
> > > > +               .cal_offset =3D { 0x04, 0x04 },
> > > >                 .lvts_sensor =3D {
> > > >                         { .dt_id =3D MT8192_AP_GPU0 },
> > > >                         { .dt_id =3D MT8192_AP_GPU1 }
> > > > @@ -1346,7 +1346,7 @@ static const struct lvts_ctrl_data
> > > > mt8192_lvts_ap_data_ctrl[] =3D {
> > > >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> > > >         },
> > > >         {
> > > > -               .cal_offset =3D { 0x37, 0x3a },
> > > > +               .cal_offset =3D { 0x04, 0x04 },
> > > >                 .lvts_sensor =3D {
> > > >                         { .dt_id =3D MT8192_AP_INFRA },
> > > >                         { .dt_id =3D MT8192_AP_CAM },
> > > > @@ -1356,7 +1356,7 @@ static const struct lvts_ctrl_data
> > > > mt8192_lvts_ap_data_ctrl[] =3D {
> > > >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> > > >         },
> > > >         {
> > > > -               .cal_offset =3D { 0x40, 0x43, 0x46 },
> > > > +               .cal_offset =3D { 0x04, 0x04, 0x04 },
> > > >                 .lvts_sensor =3D {
> > > >                         { .dt_id =3D MT8192_AP_MD0 },
> > > >                         { .dt_id =3D MT8192_AP_MD1 },
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
> >
> > Would you please point me out to the bug in interrupt handling code?
>
> I just sent out two patches and CC-ed you on them. They are here just in =
case:
>
> https://lore.kernel.org/linux-pm/20230328031037.1361048-1-wenst@chromium.=
org/
> https://lore.kernel.org/linux-pm/20230328031017.1360976-1-wenst@chromium.=
org/

Well received. I'm testing it.
Thanks!

Best regards,
Balsam

>
> ChenYu
