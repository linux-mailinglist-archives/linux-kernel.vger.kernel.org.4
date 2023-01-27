Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15BD67EC55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjA0RYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjA0RYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:24:33 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4C790A6;
        Fri, 27 Jan 2023 09:24:32 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id hw16so15501079ejc.10;
        Fri, 27 Jan 2023 09:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okLuszv3WkkjvFijTBMJVG9vnT1w9s4Zf+N5VQ7CwYo=;
        b=BQF3Y1p7+thh3YQvD8j4Cl77G3rnnDOIA6l+ha3aY4Dt27O3RIdTZ7T7jeFW/w6MH5
         uzGxGtDw9UdOegqch7DpjF5zLYoi3S7vMGnx7ohjgXMuNA5WDI9jYXBuZAOc2gTwzy6z
         v9nPsQo7yENV4TiSfLMfStZDwEIJj2gDLs07WY1ePRJ/idSkNlKAxbfnqn8nSaMl2e+Y
         qJ9KFeB1TWeykBX2LeQWl/eCYeh5XplfkXwv0RDSiZs7vFHISAruJEU0OnIbDhy66geU
         vF4fOHze2Mc8x7IlEtdDurSCG6iAYRp7cmu1awgB0yjROdGiM2KXuYXY7Er99Ueu+JvT
         MiuA==
X-Gm-Message-State: AO0yUKUFrC8f7fJfne1YuvdypjVWCqYReHLTjB+XVP2z1BzG87zZw3ZT
        u/xzmNm/EqeFB3CML6RPXt6pcp6xu1tGeQ==
X-Google-Smtp-Source: AK7set9j/t03I3GGre0y5bmhSmaHY4DRXqckSn2iEQBq7rKRgeQdAL/7ziEuM7LUVrbev8kS9aubpg==
X-Received: by 2002:a17:906:c2d3:b0:87b:3d29:2990 with SMTP id ch19-20020a170906c2d300b0087b3d292990mr3215399ejb.9.1674840270456;
        Fri, 27 Jan 2023 09:24:30 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906319a00b0087ba20a816asm1379516ejy.152.2023.01.27.09.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 09:24:30 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5888500wmb.2;
        Fri, 27 Jan 2023 09:24:29 -0800 (PST)
X-Received: by 2002:a05:600c:4f4a:b0:3db:52b:8ffb with SMTP id
 m10-20020a05600c4f4a00b003db052b8ffbmr1844219wmq.14.1674840269424; Fri, 27
 Jan 2023 09:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20230120184500.1899814-1-martin.botka@somainline.org> <20230120184500.1899814-4-martin.botka@somainline.org>
In-Reply-To: <20230120184500.1899814-4-martin.botka@somainline.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 28 Jan 2023 01:24:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>
Message-ID: <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] regulator: axp20x: Add support for AXP313a variant
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 2:45 AM Martin Botka
<martin.botka@somainline.org> wrote:
>
> The AXP313a is your typical I2C controlled PMIC, although in a lighter
> fashion compared to the other X-Powers PMICs: it has only three DCDC
> rails, three LDOs, and no battery charging support.
>
> The AXP313a datasheet does not describe a register to change the DCDC
> switching frequency, and talks of it being fixed at 3 MHz. The BSP
> driver hints at a register being able to change that, but we haven't
> verified that, so leave that one out. It can be added later, if needed
> and/or required.

The datasheet released by MangoPi says this isn't configurable. The
thing that is configurable is spread-spectrum operation, and mode
switching between fixed PWM and hybrid PFM/PWM. So just drop the
DCDC frequency stuff and use the default code path.

> The third LDO, RTCLDO, is fixed, and cannot even be turned on or off,
> programmatically. On top of that, its voltage is customisable (either
> 1.8V or 3.3V), which we cannot describe easily using the existing
> regulator wrapper functions. This should be fixed properly, using
> regulator-{min,max}-microvolt in the DT, but this requires more changes
> to the code. As some other PMICs (AXP2xx, AXP803) seem to paper over the
> same problem as well, we follow suit here and pretend it's a fixed 1.8V
> regulator. A proper fix can follow later. The BSP code seems to ignore
> this regulator altogether.
>
> Describe the AXP313A's voltage settings and switch registers, how the
> voltages are encoded, and connect this to the MFD device via its
> regulator ID.
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 60 ++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index d260c442b788..3087bc98694f 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -134,6 +134,11 @@
>  #define AXP22X_PWR_OUT_DLDO4_MASK      BIT_MASK(6)
>  #define AXP22X_PWR_OUT_ALDO3_MASK      BIT_MASK(7)
>
> +#define AXP313A_DCDC1_NUM_VOLTAGES     107
> +#define AXP313A_DCDC23_NUM_VOLTAGES    88
> +#define AXP313A_DCDC_V_OUT_MASK                GENMASK(6, 0)
> +#define AXP313A_LDO_V_OUT_MASK         GENMASK(4, 0)
> +
>  #define AXP803_PWR_OUT_DCDC1_MASK      BIT_MASK(0)
>  #define AXP803_PWR_OUT_DCDC2_MASK      BIT_MASK(1)
>  #define AXP803_PWR_OUT_DCDC3_MASK      BIT_MASK(2)
> @@ -638,6 +643,48 @@ static const struct regulator_desc axp22x_drivevbus_regulator = {
>         .ops            = &axp20x_ops_sw,
>  };
>
> +static const struct linear_range axp313a_dcdc1_ranges[] = {
> +       REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
> +       REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> +       REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
> +};
> +
> +static const struct linear_range axp313a_dcdc2_ranges[] = {
> +       REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
> +       REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
> +};
> +
> +/*
> + * This is deviating from the datasheet. The values here are taken from the
> + * BSP driver and have been confirmed by measurements.
> + */
> +static const struct linear_range axp313a_dcdc3_ranges[] = {
> +       REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
> +       REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
> +};
> +
> +static const struct regulator_desc axp313a_regulators[] = {
> +       AXP_DESC_RANGES(AXP313A, DCDC1, "dcdc1", "vin1",
> +                       axp313a_dcdc1_ranges, AXP313A_DCDC1_NUM_VOLTAGES,
> +                       AXP313A_DCDC1_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> +                       AXP313A_OUTPUT_CONTROL, BIT(0)),
> +       AXP_DESC_RANGES(AXP313A, DCDC2, "dcdc2", "vin2",
> +                       axp313a_dcdc2_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
> +                       AXP313A_DCDC2_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> +                       AXP313A_OUTPUT_CONTROL, BIT(1)),
> +       AXP_DESC_RANGES(AXP313A, DCDC3, "dcdc3", "vin3",
> +                       axp313a_dcdc3_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
> +                       AXP313A_DCDC3_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> +                       AXP313A_OUTPUT_CONTROL, BIT(2)),
> +       AXP_DESC(AXP313A, LDO1, "ldo1", "vin1", 500, 3500, 100,
> +                AXP313A_ALDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
> +                AXP313A_OUTPUT_CONTROL, BIT(3)),

The datasheet says this one is called ALDO1 ...

> +       AXP_DESC(AXP313A, LDO2, "ldo2", "vin1", 500, 3500, 100,
> +                AXP313A_DLDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
> +                AXP313A_OUTPUT_CONTROL, BIT(4)),

... and this one DLDO1.

> +       AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
> +};
> +
>  /* DCDC ranges shared with AXP813 */
>  static const struct linear_range axp803_dcdc234_ranges[] = {
>         REGULATOR_LINEAR_RANGE(500000,
> @@ -1040,6 +1087,15 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
>                 def = 3000;
>                 step = 150;
>                 break;
> +       case AXP313A_ID:
> +               /* The DCDC PWM frequency seems to be fixed to 3 MHz. */
> +               if (dcdcfreq != 3000000 && dcdcfreq != 0) {
> +                       dev_err(&pdev->dev,
> +                               "DCDC frequency on AXP313a is fixed to 3 MHz.\n");
> +                       return -EINVAL;
> +               }
> +
> +               return 0;

As mentioned above, please drop this.

Besides the bits mentioned above, this looks OK.

>         default:
>                 dev_err(&pdev->dev,
>                         "Setting DCDC frequency for unsupported AXP variant\n");
> @@ -1232,6 +1288,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>                 drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
>                                                   "x-powers,drive-vbus-en");
>                 break;
> +       case AXP313A_ID:
> +               regulators = axp313a_regulators;
> +               nregulators = AXP313A_REG_ID_MAX;
> +               break;
>         case AXP803_ID:
>                 regulators = axp803_regulators;
>                 nregulators = AXP803_REG_ID_MAX;
> --
> 2.39.0
>
