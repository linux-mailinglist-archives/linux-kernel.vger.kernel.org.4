Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739706CB4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjC1DNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1DM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:12:57 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E20397
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:12:55 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id h34so7892238uag.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679973174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwOES1uov/pxVLowAE7Sgh3FPfyIsRDoqEMp2uagMQI=;
        b=NgLG8Q5l9naxBa4Jf7nYrLS8DevbrfmEMMiDB6xIjXmdvmxfcmHG1fu7YA6jdXBu5a
         I/PLOK860EliMqfH52D0rDFLicN/3jKe4r31PEmIx2OdxRR+0T9OZ962PmLqA7e0KKje
         CDwaaqQm9fEDg1oG6tSD/I8GzJu/l5G/I1sNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679973174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwOES1uov/pxVLowAE7Sgh3FPfyIsRDoqEMp2uagMQI=;
        b=jxQWmJwI5w3/XpZxgMyS9yW1zDbXrVGf33A6qhPlomlLKpVZp6nYVg/cFzcJN8Z8a7
         OPuKQ8Sfh1JxubhfKQy2c/kNsAMuo5t+XMd94iyEirrAp5nyehoHimOH+sn0Dt0a6Vj4
         Ydi/GEoYFXK8l0lHCuYAa/3DiK8gBwgyt4UR9MjqJEpsiigeV3SVdnyBUXKtPU6vLyUH
         UMTEHudP3G7Klo037UgRhdv8HsD8zxbbZQ4kUp0Ba8watfXPWMaYz4I7vg1t/cNChSv5
         stMr38S5ReoZ8iziuQS1tGhEtFleMa5/2c6jHW39N2bzHftt2ZSeTVJ8bTeim3gtPI7j
         /E2g==
X-Gm-Message-State: AAQBX9ehKlniE9jxSNNqwKHOBTtIcN8BGkNiRW524X946AQW8HyHCWti
        /MNHFgQlUL+Ra0KP5lA7AFvTr9ZTupw4+wUeympqzQ==
X-Google-Smtp-Source: AKy350bTe0q20Y1kFa3RqGcrtmmaMcfvywJnI4v6r/ZKEb+aF8/ujyJQ/dovvRsfrWL510XzD2Ai4MZ3KVikA5Tw/BY=
X-Received: by 2002:a05:6130:3a9:b0:68d:6360:77b with SMTP id
 az41-20020a05613003a900b0068d6360077bmr10737949uab.1.1679973174489; Mon, 27
 Mar 2023 20:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
 <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com> <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
In-Reply-To: <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 28 Mar 2023 11:12:43 +0800
Message-ID: <CAGXv+5GGO76H9Z-X=3nhtmSyp7uhuUF4DE0T527M5z+SBX482Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     Balsam CHIHI <bchihi@baylibre.com>
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 8:21=E2=80=AFAM Balsam CHIHI <bchihi@baylibre.com> =
wrote:
>
> On Sat, Mar 25, 2023 at 5:33=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Wed, Mar 22, 2023 at 8:48=E2=80=AFPM Balsam CHIHI <bchihi@baylibre.c=
om> wrote:
> > >
> > > Hi Chen-Yu,
> > >
> > > I suspect the bug comes from incorrect calibration data offsets for A=
P
> > > Domain because you confirm that MCU Domain probe runs without issues.
> > > Is it possible to test something for us to confirm this theory (i
> > > don't have an mt8192 board on hand now), when you have the time of
> > > course?
> > > We would like to test AP Domain's calibration data offsets with a
> > > working one, for example :
> > >
> > >  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D {
> > >                 {
> > > -               .cal_offset =3D { 0x25, 0x28 },
> > > +               .cal_offset =3D { 0x04, 0x04 },
> > >                 .lvts_sensor =3D {
> > >                         { .dt_id =3D MT8192_AP_VPU0 },
> > >                         { .dt_id =3D MT8192_AP_VPU1 }
> > > @@ -1336,7 +1336,7 @@ static const struct lvts_ctrl_data
> > > mt8192_lvts_ap_data_ctrl[] =3D {
> > >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> > >         },
> > >         {
> > > -               .cal_offset =3D { 0x2e, 0x31 },
> > > +               .cal_offset =3D { 0x04, 0x04 },
> > >                 .lvts_sensor =3D {
> > >                         { .dt_id =3D MT8192_AP_GPU0 },
> > >                         { .dt_id =3D MT8192_AP_GPU1 }
> > > @@ -1346,7 +1346,7 @@ static const struct lvts_ctrl_data
> > > mt8192_lvts_ap_data_ctrl[] =3D {
> > >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> > >         },
> > >         {
> > > -               .cal_offset =3D { 0x37, 0x3a },
> > > +               .cal_offset =3D { 0x04, 0x04 },
> > >                 .lvts_sensor =3D {
> > >                         { .dt_id =3D MT8192_AP_INFRA },
> > >                         { .dt_id =3D MT8192_AP_CAM },
> > > @@ -1356,7 +1356,7 @@ static const struct lvts_ctrl_data
> > > mt8192_lvts_ap_data_ctrl[] =3D {
> > >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> > >         },
> > >         {
> > > -               .cal_offset =3D { 0x40, 0x43, 0x46 },
> > > +               .cal_offset =3D { 0x04, 0x04, 0x04 },
> > >                 .lvts_sensor =3D {
> > >                         { .dt_id =3D MT8192_AP_MD0 },
> > >                         { .dt_id =3D MT8192_AP_MD1 },
> > >
> > > This example is tested and works for mt8195,
> > > (all sensors use the same calibration data offset for testing purpose=
s).
> > >
> > > Thank you in advance for your help.
> >
> > The MCU ones are still tripping though. If I change all of them to 0x04=
,
> > then nothing trips. There's also a bug in the interrupt handling code
> > that needs to be dealt with.
> >
> > AFAICT the calibration data is stored differently. If you look at Chrom=
eOS's
> > downstream v5.10 driver, you'll see mt6873_efuse_to_cal_data() for MT81=
92,
> > and mt8195_efuse_to_cal_data() for MT8195. The difference sums up to:
> > MT8195 has all data sequentially stored, while MT8192 has most data sto=
red
> > in lower 24 bits of each 32-bit word, and the highest 8 bits are then u=
sed
> > to pack data for the remaining sensors.
> >
> > Regards
> > ChenYu
>
> Hi Chen-Yu Tsai,
>
> Thank you very much for helping me testing this suggestion.
>
> Indeed, calibration data is stored differently in the mt8192 compared to =
mt8195.
> So, the mt8192's support will be delayed for now, to allow further debugg=
ing.
>
> In the mean time, we will only continue to upstream the remaining
> mt8195's source code, so it will get full LVTS support.
> A new series will be submitted soon.
>
> Would you please point me out to the bug in interrupt handling code?

I just sent out two patches and CC-ed you on them. They are here just in ca=
se:

https://lore.kernel.org/linux-pm/20230328031037.1361048-1-wenst@chromium.or=
g/
https://lore.kernel.org/linux-pm/20230328031017.1360976-1-wenst@chromium.or=
g/

ChenYu
