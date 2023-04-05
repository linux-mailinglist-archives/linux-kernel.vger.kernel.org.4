Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D66D7F36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjDEOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbjDEOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2447065B8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C851662695
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10A5C4339B;
        Wed,  5 Apr 2023 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680704469;
        bh=dHpgODcNgqxK0uVP+IR7uJMaZZhj+un3AM6tvrsl1yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXqN1EvncaN4mFD5qhnaffryz18okXhP/B1iV0qPXZE8orhz6N+l+jGGD8w2Wy6mE
         +vlFw07nyzlylojdpCO93Q+saAqwXL75BfGbV/fifkVW32W8jKh3Ga65i83TPY8p8b
         PHaeRkGU9CFJuAKqzsAMGHA3sSnIVxuoxsRvnFmOXcDtdOKP6n1i/2yQeN+2WHq16F
         uCGrITSMkCi9eHe9sMCt6RO84yBcNNzqVVNByvPkNZNthv/WVGi5G4b15tS0uIQeKT
         vJE+5wLdFnLVT4QKnm3VgG7iEC1fX7ONDKnfI6KJ/0bOGE48UamnP7Wy7KEoB6egKf
         3tUnpPxmplZ6g==
Date:   Wed, 5 Apr 2023 15:21:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <20230405142103.GL8371@google.com>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230401001850.4988-4-andre.przywara@arm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Sat, 01 Apr 2023, Andre Przywara wrote:

> From: Martin Botka <martin.botka@somainline.org>
>
> The AXP313a is your typical I2C controlled PMIC, although in a lighter
> fashion compared to the other X-Powers PMICs: it has only three DCDC
> rails, three LDOs, and no battery charging support.
>
> The AXP313a datasheet does not describe a register to change the DCDC
> switching frequency, and talks of it being fixed at 3 MHz. Check that
> the property allowing to change that frequency is absent from the DT,
> and bail out otherwise.
>
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

Is this on your radar?

Can I take the other two patches without causing issues?

> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index d260c442b788d..81f339009df9b 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -134,6 +134,11 @@
>  #define AXP22X_PWR_OUT_DLDO4_MASK	BIT_MASK(6)
>  #define AXP22X_PWR_OUT_ALDO3_MASK	BIT_MASK(7)
>
> +#define AXP313A_DCDC1_NUM_VOLTAGES	107
> +#define AXP313A_DCDC23_NUM_VOLTAGES	88
> +#define AXP313A_DCDC_V_OUT_MASK		GENMASK(6, 0)
> +#define AXP313A_LDO_V_OUT_MASK		GENMASK(4, 0)
> +
>  #define AXP803_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
>  #define AXP803_PWR_OUT_DCDC2_MASK	BIT_MASK(1)
>  #define AXP803_PWR_OUT_DCDC3_MASK	BIT_MASK(2)
> @@ -638,6 +643,48 @@ static const struct regulator_desc axp22x_drivevbus_regulator = {
>  	.ops		= &axp20x_ops_sw,
>  };
>
> +static const struct linear_range axp313a_dcdc1_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
> +	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> +	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
> +};
> +
> +static const struct linear_range axp313a_dcdc2_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
> +	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
> +};
> +
> +/*
> + * This is deviating from the datasheet. The values here are taken from the
> + * BSP driver and have been confirmed by measurements.
> + */
> +static const struct linear_range axp313a_dcdc3_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
> +	REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
> +};
> +
> +static const struct regulator_desc axp313a_regulators[] = {
> +	AXP_DESC_RANGES(AXP313A, DCDC1, "dcdc1", "vin1",
> +			axp313a_dcdc1_ranges, AXP313A_DCDC1_NUM_VOLTAGES,
> +			AXP313A_DCDC1_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> +			AXP313A_OUTPUT_CONTROL, BIT(0)),
> +	AXP_DESC_RANGES(AXP313A, DCDC2, "dcdc2", "vin2",
> +			axp313a_dcdc2_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
> +			AXP313A_DCDC2_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> +			AXP313A_OUTPUT_CONTROL, BIT(1)),
> +	AXP_DESC_RANGES(AXP313A, DCDC3, "dcdc3", "vin3",
> +			axp313a_dcdc3_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
> +			AXP313A_DCDC3_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> +			AXP313A_OUTPUT_CONTROL, BIT(2)),
> +	AXP_DESC(AXP313A, ALDO1, "aldo1", "vin1", 500, 3500, 100,
> +		 AXP313A_ALDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
> +		 AXP313A_OUTPUT_CONTROL, BIT(3)),
> +	AXP_DESC(AXP313A, DLDO1, "dldo1", "vin1", 500, 3500, 100,
> +		 AXP313A_DLDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
> +		 AXP313A_OUTPUT_CONTROL, BIT(4)),
> +	AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
> +};
> +
>  /* DCDC ranges shared with AXP813 */
>  static const struct linear_range axp803_dcdc234_ranges[] = {
>  	REGULATOR_LINEAR_RANGE(500000,
> @@ -1040,6 +1087,15 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
>  		def = 3000;
>  		step = 150;
>  		break;
> +	case AXP313A_ID:
> +		/* The DCDC PWM frequency seems to be fixed to 3 MHz. */
> +		if (dcdcfreq != 0) {
> +			dev_err(&pdev->dev,
> +				"DCDC frequency on AXP313a is fixed to 3 MHz.\n");
> +			return -EINVAL;
> +		}
> +
> +		return 0;
>  	default:
>  		dev_err(&pdev->dev,
>  			"Setting DCDC frequency for unsupported AXP variant\n");
> @@ -1232,6 +1288,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
>  						  "x-powers,drive-vbus-en");
>  		break;
> +	case AXP313A_ID:
> +		regulators = axp313a_regulators;
> +		nregulators = AXP313A_REG_ID_MAX;
> +		break;
>  	case AXP803_ID:
>  		regulators = axp803_regulators;
>  		nregulators = AXP803_REG_ID_MAX;
> --
> 2.35.7
>

--
Lee Jones [李琼斯]
