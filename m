Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6F6CB2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjC1AVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjC1AVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:21:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180610E2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:21:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so43129037edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679962860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWxYxwYnDh/M3AqcQxupiWYE616Su6/3AVIH7JVpi+4=;
        b=iQky6ik4kDwcReUzej4+0VfVe0WBZObyKBPejB3AzdUu2vBgMJGvC+HEb/lU/4nPel
         bJgq4p1jPRFqRck8x2nm7QlGy+lf7fVlk+BRnX36blHctgndC8i7E4S3ytJk2+oFQFCt
         IFN7SJiaXctCjcRtLCuRdSt1xDx7g69MgPI8L4K9A1D1a3aFxZHs/bzXulnXGipOr62E
         QEwlTpDKxBx+vvW1ozaLPZnh5qSGFP3fnjd9LIQcGf/qde1kZn4J8FXQZTtnnGB93Dzz
         ZwvpSEbG40ESYC4RpoIciqTuoP6egsu4hhYR5vK9MwSKg+89YBVPHosawxgaaZNL+WZZ
         IsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679962860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWxYxwYnDh/M3AqcQxupiWYE616Su6/3AVIH7JVpi+4=;
        b=6FTQl+JQrlZ+TnctCDjwrUejyhzgEtJnZ66NiW3sjFuwri76Dc/Jmq4CF03ef8wVDW
         zd1p0he8oFK0RVo0v9cSHCOLGGHiVG9L4Erhgb99QOLNPVpTbCuTisRzWQC9SEiWUGyf
         vW3U2vGf1meMJ9NEMbMQM0b5Haf6pc5df+/dvWCOL/vaFUfacF5A/0w5fGHniq0lcrgP
         Tps42vfNyapqTayV+j8g7qwNpHP62PpAXyc6dRiq3jDmsS6OGBfwYBnTyh4XoFBi5Oui
         8BWu+4cdGDfgTXZB0FyK0cEDRbnzu38vZtvcIWt5ie1eOmw93bkVW65iODboQt5v2Xlq
         3HhA==
X-Gm-Message-State: AAQBX9dEBqqRLonJmOW3pOZemAw2Dd62EKeDDx6prt97KK4PCj1clfmD
        Rr9ULD4DZwcFb+MWJ4Xe8IaYbhsan9FMWfoaACEDrg==
X-Google-Smtp-Source: AKy350bS1Hba9qX/l6pm9XmTzJq4aBCpICVpxhFQWGi17RieKEkZ5vZWKqsJQqRR1BUm/4/yKCLx58qdU8g1jirg1BE=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr5715532ejc.2.1679962860515; Mon, 27
 Mar 2023 17:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com> <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
In-Reply-To: <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 28 Mar 2023 02:20:24 +0200
Message-ID: <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
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

On Sat, Mar 25, 2023 at 5:33=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Wed, Mar 22, 2023 at 8:48=E2=80=AFPM Balsam CHIHI <bchihi@baylibre.com=
> wrote:
> >
> > Hi Chen-Yu,
> >
> > I suspect the bug comes from incorrect calibration data offsets for AP
> > Domain because you confirm that MCU Domain probe runs without issues.
> > Is it possible to test something for us to confirm this theory (i
> > don't have an mt8192 board on hand now), when you have the time of
> > course?
> > We would like to test AP Domain's calibration data offsets with a
> > working one, for example :
> >
> >  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D {
> >                 {
> > -               .cal_offset =3D { 0x25, 0x28 },
> > +               .cal_offset =3D { 0x04, 0x04 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_VPU0 },
> >                         { .dt_id =3D MT8192_AP_VPU1 }
> > @@ -1336,7 +1336,7 @@ static const struct lvts_ctrl_data
> > mt8192_lvts_ap_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x2e, 0x31 },
> > +               .cal_offset =3D { 0x04, 0x04 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_GPU0 },
> >                         { .dt_id =3D MT8192_AP_GPU1 }
> > @@ -1346,7 +1346,7 @@ static const struct lvts_ctrl_data
> > mt8192_lvts_ap_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x37, 0x3a },
> > +               .cal_offset =3D { 0x04, 0x04 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_INFRA },
> >                         { .dt_id =3D MT8192_AP_CAM },
> > @@ -1356,7 +1356,7 @@ static const struct lvts_ctrl_data
> > mt8192_lvts_ap_data_ctrl[] =3D {
> >                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> >         },
> >         {
> > -               .cal_offset =3D { 0x40, 0x43, 0x46 },
> > +               .cal_offset =3D { 0x04, 0x04, 0x04 },
> >                 .lvts_sensor =3D {
> >                         { .dt_id =3D MT8192_AP_MD0 },
> >                         { .dt_id =3D MT8192_AP_MD1 },
> >
> > This example is tested and works for mt8195,
> > (all sensors use the same calibration data offset for testing purposes)=
.
> >
> > Thank you in advance for your help.
>
> The MCU ones are still tripping though. If I change all of them to 0x04,
> then nothing trips. There's also a bug in the interrupt handling code
> that needs to be dealt with.
>
> AFAICT the calibration data is stored differently. If you look at ChromeO=
S's
> downstream v5.10 driver, you'll see mt6873_efuse_to_cal_data() for MT8192=
,
> and mt8195_efuse_to_cal_data() for MT8195. The difference sums up to:
> MT8195 has all data sequentially stored, while MT8192 has most data store=
d
> in lower 24 bits of each 32-bit word, and the highest 8 bits are then use=
d
> to pack data for the remaining sensors.
>
> Regards
> ChenYu

Hi Chen-Yu Tsai,

Thank you very much for helping me testing this suggestion.

Indeed, calibration data is stored differently in the mt8192 compared to mt=
8195.
So, the mt8192's support will be delayed for now, to allow further debuggin=
g.

In the mean time, we will only continue to upstream the remaining
mt8195's source code, so it will get full LVTS support.
A new series will be submitted soon.

Would you please point me out to the bug in interrupt handling code?

Best regards,
Balsam
