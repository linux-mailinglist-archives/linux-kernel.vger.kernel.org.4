Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83064E497
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLOXR7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Dec 2022 18:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLOXRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:17:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A54660355;
        Thu, 15 Dec 2022 15:17:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 261D01063;
        Thu, 15 Dec 2022 15:18:34 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14B93F73B;
        Thu, 15 Dec 2022 15:17:50 -0800 (PST)
Date:   Thu, 15 Dec 2022 23:16:15 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v5 3/3] regulator: axp20x: Add support for AXP1530
 variant
Message-ID: <20221215231615.6a4fa710@slackpad.lan>
In-Reply-To: <20221214190305.3354669-4-martin.botka@somainline.org>
References: <20221214190305.3354669-1-martin.botka@somainline.org>
        <20221214190305.3354669-4-martin.botka@somainline.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 20:03:05 +0100
Martin Botka <martin.botka@somainline.org> wrote:

Hi Martin,

> AXP1530 has a few regulators that are controlled via I2C Bus.
> 
> Add support for them.

thanks for putting this together!
After coming up with a very similar patch based on the AXP313A313
datasheet, I realised that those two must indeed be *somewhat*
compatible, so I am going to compare my patch with yours ;-)

> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/regulator/axp20x-regulator.c | 44 ++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index d260c442b788..9420839ff4f9 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -1001,6 +1001,40 @@ static const struct regulator_desc axp813_regulators[] = {
>  		    AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DC1SW_MASK),
>  };
>  
> +static const struct linear_range axp1530_dcdc1_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),

The AXP313A manual mentions "steps", in decimal
(0.5~1.2V，10mV/step，71steps), so I wonder if we should follow suit
here and describe the min_sel and max_sel members in decimal?

> +	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x57, 20000),
> +	REGULATOR_LINEAR_RANGE(1600000, 0x58, 0x6A, 100000),
> +};
> +
> +static const struct linear_range axp1530_dcdc2_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
> +	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x57, 20000),
> +};

The values up till here match exactly what I extracted from the AXP313A
manual.

> +
> +static const struct linear_range axp1530_dcdc3_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
> +	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x66, 20000),
> +};

Can you double check that those are the values for DCDC3?
The AXP313A manual uses different ranges, essentially:
    REGULATOR_LINEAR_RANGE(800000, 0, 32, 10000),
    REGULATOR_LINEAR_RANGE(1140000, 33, 68, 20000),
So starting from 800mV, and using a slightly different split point.

I would just hope that's this doesn't turn out to be an incompatible register.

> +
> +static const struct regulator_desc axp1530_regulators[] = {
> +	AXP_DESC_RANGES(AXP1530, DCDC1, "dcdc1", "vin1", axp1530_dcdc1_ranges,
> +					0x6B, AXP1530_DCDC1_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,

Again I would code the steps in decimal. The other regulators use a
preprocessor constant, which helps the reader to get its meaning.
And please use at least GENMASK(6, 0) instead of 0x7f, or #define this
(can be shared for all DCDCs and the LDOs).

> +					BIT(0)),
> +	AXP_DESC_RANGES(AXP1530, DCDC2, "dcdc2", "vin2", axp1530_dcdc2_ranges,
> +					0x58, AXP1530_DCDC2_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
> +					BIT(1)),
> +	AXP_DESC_RANGES(AXP1530, DCDC3, "dcdc3", "vin3", axp1530_dcdc3_ranges,
> +					0x58, AXP1530_DCDC3_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
> +					BIT(2)),
> +	AXP_DESC(AXP1530, LDO1, "ldo1", "ldo1in", 500, 3500, 100,
> +					AXP1530_ALDO1_CONRTOL, 0x1f, AXP1530_OUTPUT_CONTROL,
> +					BIT(3)),
> +	AXP_DESC(AXP1530, LDO2, "ldo2", "ldo2in", 500, 3500, 100,
> +					AXP1530_DLDO1_CONRTOL, 0x1f, AXP1530_OUTPUT_CONTROL,
> +					BIT(4)),

Does this miss the fixed RTC-LDO? Or does the AXP1530 not have that?
        AXP_DESC_FIXED(AXP313, RTC_LDO, "rtc-ldo", "ips", 1800),
The AXP313A manual mentions that the voltage is customisable, either
1.8V or 3.3V. I don't know how to model that, exactly. Should this be a
DT property, then? Or do we fix it to one voltage, covering the value
that's used out there?

> +};
> +
>  static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
>  {
>  	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> @@ -1040,6 +1074,12 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
>  		def = 3000;
>  		step = 150;
>  		break;
> +	case AXP1530_ID:
> +		/*
> +		 * Do not set the DCDC frequency on AXP1530

This should say that the frequency is fixed and cannot be programmed.
I also added a warning if the frequency is not 3 MHz.
Either this, or we make the "x-powers,dcdc-freq" DT property optional.

Cheers,
Andre

> +		 */
> +		return 0;
> +		break;
>  	default:
>  		dev_err(&pdev->dev,
>  			"Setting DCDC frequency for unsupported AXP variant\n");
> @@ -1220,6 +1260,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  	bool drivevbus = false;
>  
>  	switch (axp20x->variant) {
> +	case AXP1530_ID:
> +		regulators = axp1530_regulators;
> +		nregulators = AXP1530_REG_ID_MAX;
> +		break;
>  	case AXP202_ID:
>  	case AXP209_ID:
>  		regulators = axp20x_regulators;

