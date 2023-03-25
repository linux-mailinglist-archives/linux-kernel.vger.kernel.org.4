Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF596C8AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 05:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCYEdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 00:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYEdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 00:33:36 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C11510F5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 21:33:35 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id h34so2790959uag.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 21:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679718814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FwD1qe1aEhxGQwbkfsAcs59fzQAp+267YsErGDwRDQ=;
        b=iOFPi2EpJxYYxobOHGqjcpDoFg3I0Cf9cCiHsWV6gSJJ/2aZpe6HW9DB/PQLkXxGzN
         qj2kCyi+v1dUPETrWiILCcrZHHflu9iCIqKBzkAHRMM9GRgZ/m/uLOtcWmX4mAJDumVZ
         UNpPB7YoMkihR/Bvc44JXgVgX8VjDhAwXtAfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FwD1qe1aEhxGQwbkfsAcs59fzQAp+267YsErGDwRDQ=;
        b=4CkZPQBTnz6W8iSa02St2DKCeETWaSSJ4Esj2IM1g2YkoorrXTDBVOm7CuUmJwZTKI
         xYVeriA1fWHDe0OmpPsA6raOqTjt9LHF33IG9DcsoG13cp5pf6RxESB0wOtvRHgT+IuY
         Jt2utr9WNj2ejK35S3EEZLu+6KCLd8/Wo/PDMORR1El3r/bW8RfO0RkyUeBHZc5bcyu1
         W/nSMKlPH93fPAkOZf1qCVpDU+4UIsLdTWX7Nn3hPYfTiUdfCFtUCsTEQSz+xuC1ATc7
         8OMYelyV45n//UhoY2ccQA8lCPfOK9ihTiK3qMWZDFfMjutY0YCyaXsI8peG121P/okn
         Hiyw==
X-Gm-Message-State: AO0yUKVvhFLWCCtmwQPTg6CXPFImOKSP1424eVYOlUhUBBoj3DkRIumN
        vVQcON8IPBJCzztLNrnR39uCSYB5t1nMS8boEXQaYg==
X-Google-Smtp-Source: AK7set8snxwLMBw9XRJSwzZ8WvoC9Kq12OK3/hxUxctwmRuEURtsmj8QD8ZysLyTsXXDQnMndDgdvCTkYeUbBR3rXP4=
X-Received: by 2002:a05:6122:7c9:b0:401:7625:e9e3 with SMTP id
 l9-20020a05612207c900b004017625e9e3mr7173590vkr.1.1679718814257; Fri, 24 Mar
 2023 21:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com> <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
In-Reply-To: <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Sat, 25 Mar 2023 12:33:23 +0800
Message-ID: <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
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

On Wed, Mar 22, 2023 at 8:48=E2=80=AFPM Balsam CHIHI <bchihi@baylibre.com> =
wrote:
>
> Hi Chen-Yu,
>
> I suspect the bug comes from incorrect calibration data offsets for AP
> Domain because you confirm that MCU Domain probe runs without issues.
> Is it possible to test something for us to confirm this theory (i
> don't have an mt8192 board on hand now), when you have the time of
> course?
> We would like to test AP Domain's calibration data offsets with a
> working one, for example :
>
>  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D {
>                 {
> -               .cal_offset =3D { 0x25, 0x28 },
> +               .cal_offset =3D { 0x04, 0x04 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_VPU0 },
>                         { .dt_id =3D MT8192_AP_VPU1 }
> @@ -1336,7 +1336,7 @@ static const struct lvts_ctrl_data
> mt8192_lvts_ap_data_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x2e, 0x31 },
> +               .cal_offset =3D { 0x04, 0x04 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_GPU0 },
>                         { .dt_id =3D MT8192_AP_GPU1 }
> @@ -1346,7 +1346,7 @@ static const struct lvts_ctrl_data
> mt8192_lvts_ap_data_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x37, 0x3a },
> +               .cal_offset =3D { 0x04, 0x04 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_INFRA },
>                         { .dt_id =3D MT8192_AP_CAM },
> @@ -1356,7 +1356,7 @@ static const struct lvts_ctrl_data
> mt8192_lvts_ap_data_ctrl[] =3D {
>                 .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
>         },
>         {
> -               .cal_offset =3D { 0x40, 0x43, 0x46 },
> +               .cal_offset =3D { 0x04, 0x04, 0x04 },
>                 .lvts_sensor =3D {
>                         { .dt_id =3D MT8192_AP_MD0 },
>                         { .dt_id =3D MT8192_AP_MD1 },
>
> This example is tested and works for mt8195,
> (all sensors use the same calibration data offset for testing purposes).
>
> Thank you in advance for your help.

The MCU ones are still tripping though. If I change all of them to 0x04,
then nothing trips. There's also a bug in the interrupt handling code
that needs to be dealt with.

AFAICT the calibration data is stored differently. If you look at ChromeOS'=
s
downstream v5.10 driver, you'll see mt6873_efuse_to_cal_data() for MT8192,
and mt8195_efuse_to_cal_data() for MT8195. The difference sums up to:
MT8195 has all data sequentially stored, while MT8192 has most data stored
in lower 24 bits of each 32-bit word, and the highest 8 bits are then used
to pack data for the remaining sensors.

Regards
ChenYu
