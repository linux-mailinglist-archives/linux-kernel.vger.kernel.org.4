Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D474698D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjGDGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGDGWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:22:41 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A7E42
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:22:40 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-440c368b4e2so1441759137.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688451759; x=1691043759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu1Hflpla9IkbLaoY1CW/Ds3THRDk4wCMUEZUDRnIkc=;
        b=EyJBpj/cvSN6wh7lrRNAIhUyFjtEAjyj4fjarlA3vEwtvtFK73gvcpz0ZkXd1HKhRC
         6myzp4jURi1zf7S7n5fNUAAOZ5RUuq/AU+/m9UWl2j2xGq2EFA9CeYR0BESYJ18zHmCs
         dKml2Ruj5Lzv9FuOMWONvFC8GxTCCH+E2e1Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688451759; x=1691043759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu1Hflpla9IkbLaoY1CW/Ds3THRDk4wCMUEZUDRnIkc=;
        b=Vp6xo4S/XQdgaAh2aj6iihLFrBmj0iULbBSvKnVzDOSEBrAU+ecMT+H7l2waH9prU8
         qNnhbcp22mt8OYH4GrEkVM9rqUzolVXov410WLq3mpo2SdxzMcsxq5fmNji2+18/BgZb
         6oSu67+gwR8pTjNF+8Cqiq4qlvv9SqKyxl4+TUGYCBYhMB1CcxqJ2r53iqF+ggXNdFHw
         9m4JwZsrAbCPsMI3mwMBmvO1h74ZzcLwMYmBv8LVDCCy7Pb0A/b8lCYDqKRTWjZlco+D
         FFJ8XapJTsVYryvOSGWYpnE1lpnvHUGZXAbYzJ4AuN8ap71nuWTZlgfs/9PRGfDdSngN
         0mFg==
X-Gm-Message-State: ABy/qLZWzeA01NcmsU/Enan5NPSKyp2zsjnRYF6bC79NuYfaM6Lf2mV8
        pZsfr3UTmBEXHg8PYd289jzdf8HIz0kUZCBmh6NpfA==
X-Google-Smtp-Source: APBJJlG2WIR0Xf2B86fezEVK9rhJjCRRaXN0MCsUzHBlJi4WGPwFClWX8K6+042osTp1PPpiviozMFsIZkM1y7N3fHA=
X-Received: by 2002:a67:e3d9:0:b0:443:874b:7d60 with SMTP id
 k25-20020a67e3d9000000b00443874b7d60mr4345894vsm.26.1688451759378; Mon, 03
 Jul 2023 23:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230530195132.2286163-1-bero@baylibre.com> <20230530195132.2286163-4-bero@baylibre.com>
In-Reply-To: <20230530195132.2286163-4-bero@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 4 Jul 2023 14:22:28 +0800
Message-ID: <CAGXv+5HCQ+S8ZNP1nLH9jYnzMhg5MfjWdiTevghGZjdK=pC2Zw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:51=E2=80=AFAM Bernhard Rosenkr=C3=A4nzer <bero@ba=
ylibre.com> wrote:
>
> From: Balsam CHIHI <bchihi@baylibre.com>
>
> Add LVTS Driver support for MT8192.
>
> Co-developed-by : N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 95 +++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 5ea8a9d569ea6..d5e5214784ece 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -80,6 +80,7 @@
>  #define LVTS_MSR_FILTERED_MODE         1
>
>  #define LVTS_HW_SHUTDOWN_MT8195                105000
> +#define LVTS_HW_SHUTDOWN_MT8192                105000
>
>  static int golden_temp =3D LVTS_GOLDEN_TEMP_DEFAULT;
>  static int coeff_b =3D LVTS_COEFF_B;
> @@ -1280,6 +1281,88 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_=
data_ctrl[] =3D {
>         }
>  };
>
> +static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
> +       {
> +               .cal_offset =3D { 0x04, 0x08 },
> +               .lvts_sensor =3D {
> +                       { .dt_id =3D MT8192_MCU_BIG_CPU0 },
> +                       { .dt_id =3D MT8192_MCU_BIG_CPU1 }
> +               },
> +               .num_lvts_sensor =3D 2,
> +               .offset =3D 0x0,
> +               .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> +               .mode =3D LVTS_MSR_FILTERED_MODE,
> +       },
> +       {
> +               .cal_offset =3D { 0x0c, 0x10 },
> +               .lvts_sensor =3D {
> +                       { .dt_id =3D MT8192_MCU_BIG_CPU2 },
> +                       { .dt_id =3D MT8192_MCU_BIG_CPU3 }
> +               },
> +               .num_lvts_sensor =3D 2,
> +               .offset =3D 0x100,
> +               .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> +               .mode =3D LVTS_MSR_FILTERED_MODE,
> +       },
> +       {
> +               .cal_offset =3D { 0x14, 0x18, 0x1c, 0x20 },
> +               .lvts_sensor =3D {
> +                       { .dt_id =3D MT8192_MCU_LITTLE_CPU0 },
> +                       { .dt_id =3D MT8192_MCU_LITTLE_CPU1 },
> +                       { .dt_id =3D MT8192_MCU_LITTLE_CPU2 },
> +                       { .dt_id =3D MT8192_MCU_LITTLE_CPU3 }
> +               },
> +               .num_lvts_sensor =3D 4,
> +               .offset =3D 0x200,
> +               .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> +               .mode =3D LVTS_MSR_FILTERED_MODE,
> +       }
> +};
> +
> +static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D {
> +               {
> +               .cal_offset =3D { 0x24, 0x28 },
> +               .lvts_sensor =3D {
> +                       { .dt_id =3D MT8192_AP_VPU0 },
> +                       { .dt_id =3D MT8192_AP_VPU1 }
> +               },
> +               .num_lvts_sensor =3D 2,
> +               .offset =3D 0x0,
> +               .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> +       },
> +       {
> +               .cal_offset =3D { 0x2c, 0x30 },
> +               .lvts_sensor =3D {
> +                       { .dt_id =3D MT8192_AP_GPU0 },
> +                       { .dt_id =3D MT8192_AP_GPU1 }
> +               },
> +               .num_lvts_sensor =3D 2,
> +               .offset =3D 0x100,
> +               .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> +       },
> +       {
> +               .cal_offset =3D { 0x34, 0x38 },
> +               .lvts_sensor =3D {
> +                       { .dt_id =3D MT8192_AP_INFRA },
> +                       { .dt_id =3D MT8192_AP_CAM },
> +               },
> +               .num_lvts_sensor =3D 2,
> +               .offset =3D 0x200,
> +               .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> +       },
> +       {
> +               .cal_offset =3D { 0x3c, 0x40, 0x44 },
> +               .lvts_sensor =3D {
> +                       { .dt_id =3D MT8192_AP_MD0 },
> +                       { .dt_id =3D MT8192_AP_MD1 },
> +                       { .dt_id =3D MT8192_AP_MD2 }
> +               },
> +               .num_lvts_sensor =3D 3,
> +               .offset =3D 0x300,
> +               .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
> +       }
> +};
> +
>  static const struct lvts_data mt8195_lvts_mcu_data =3D {
>         .lvts_ctrl      =3D mt8195_lvts_mcu_data_ctrl,
>         .num_lvts_ctrl  =3D ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
> @@ -1290,9 +1373,21 @@ static const struct lvts_data mt8195_lvts_ap_data =
=3D {
>         .num_lvts_ctrl  =3D ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
>  };
>
> +static const struct lvts_data mt8192_lvts_mcu_data =3D {
> +       .lvts_ctrl      =3D mt8192_lvts_mcu_data_ctrl,
> +       .num_lvts_ctrl  =3D ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
> +};
> +
> +static const struct lvts_data mt8192_lvts_ap_data =3D {
> +       .lvts_ctrl      =3D mt8192_lvts_ap_data_ctrl,
> +       .num_lvts_ctrl  =3D ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
> +};
> +
>  static const struct of_device_id lvts_of_match[] =3D {
>         { .compatible =3D "mediatek,mt8195-lvts-mcu", .data =3D &mt8195_l=
vts_mcu_data },
>         { .compatible =3D "mediatek,mt8195-lvts-ap", .data =3D &mt8195_lv=
ts_ap_data },
> +       { .compatible =3D "mediatek,mt8192-lvts-mcu", .data =3D &mt8192_l=
vts_mcu_data },
> +       { .compatible =3D "mediatek,mt8192-lvts-ap", .data =3D &mt8192_lv=
ts_ap_data },

Could you reorder everything so that they follow the order of the chip
model name? That includes the entries here, and the data structures above.
That would help with readability once this driver supports more chips.

ChenYu

>         {},
>  };
>  MODULE_DEVICE_TABLE(of, lvts_of_match);
> --
> 2.41.0.rc2
>
