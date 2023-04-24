Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF66E4B44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDQOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDQOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:18:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C36DFB463;
        Mon, 17 Apr 2023 07:18:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22DA91063;
        Mon, 17 Apr 2023 07:19:06 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D7EC3F5A1;
        Mon, 17 Apr 2023 07:18:21 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:18:18 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v1 3/4] regulator: axp20x: Add AXP15060 support
Message-ID: <20230417151818.3c7b283c@donnerap.cambridge.arm.com>
In-Reply-To: <TY3P286MB26112CE5BB0C66F8B6CA297498969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <20230407141813.89-1-wiagn233@outlook.com>
 <TY3P286MB26112CE5BB0C66F8B6CA297498969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Apr 2023 22:18:12 +0800
Shengyu Qu <wiagn233@outlook.com> wrote:

Hi,

> The AXP15060 is a typical I2C-controlled PMIC, seen on multiple boards
> with different default register value. Current driver is tested on
> Starfive Visionfive 2.
> 
> The RTCLDO is fixed, and cannot even be turned on or off. On top of
> that, its voltage is customisable (either 1.8V or 3.3V). We pretend it's
> a fixed 1.8V regulator since other AXP driver also do like this. Also,
> BSP code ignores this regulator and it's not used according to VF2
> schematic.
> 
> Describe the AXP15060's voltage settings and switch registers, how the
> voltages are encoded, and connect this to the MFD device via its
> regulator ID.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 229 ++++++++++++++++++++++++++-
>  1 file changed, 221 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index d260c442b788..ece4af93df7b 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -270,6 +270,74 @@
>  
>  #define AXP813_PWR_OUT_DCDC7_MASK	BIT_MASK(6)
>  
> +#define AXP15060_DCDC1_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_DCDC2_V_CTRL_MASK		GENMASK(6, 0)
> +#define AXP15060_DCDC3_V_CTRL_MASK		GENMASK(6, 0)
> +#define AXP15060_DCDC4_V_CTRL_MASK		GENMASK(6, 0)
> +#define AXP15060_DCDC5_V_CTRL_MASK		GENMASK(6, 0)
> +#define AXP15060_DCDC6_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_ALDO1_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_ALDO2_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_ALDO3_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_ALDO4_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_ALDO5_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_BLDO1_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_BLDO2_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_BLDO3_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_BLDO4_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_BLDO5_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_CLDO1_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_CLDO2_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_CLDO3_V_CTRL_MASK		GENMASK(4, 0)
> +#define AXP15060_CLDO4_V_CTRL_MASK		GENMASK(5, 0)
> +#define AXP15060_CPUSLDO_V_CTRL_MASK		GENMASK(3, 0)
> +
> +#define AXP15060_PWR_OUT_DCDC1_MASK	BIT_MASK(0)

I'd say "BIT(0)" is the canonical way of denoting single bit masks,
outside of Linux' bitmask framework.

> +#define AXP15060_PWR_OUT_DCDC2_MASK	BIT_MASK(1)
> +#define AXP15060_PWR_OUT_DCDC3_MASK	BIT_MASK(2)
> +#define AXP15060_PWR_OUT_DCDC4_MASK	BIT_MASK(3)
> +#define AXP15060_PWR_OUT_DCDC5_MASK	BIT_MASK(4)
> +#define AXP15060_PWR_OUT_DCDC6_MASK	BIT_MASK(5)
> +#define AXP15060_PWR_OUT_ALDO1_MASK	BIT_MASK(0)
> +#define AXP15060_PWR_OUT_ALDO2_MASK	BIT_MASK(1)
> +#define AXP15060_PWR_OUT_ALDO3_MASK	BIT_MASK(2)
> +#define AXP15060_PWR_OUT_ALDO4_MASK	BIT_MASK(3)
> +#define AXP15060_PWR_OUT_ALDO5_MASK	BIT_MASK(4)
> +#define AXP15060_PWR_OUT_BLDO1_MASK	BIT_MASK(5)
> +#define AXP15060_PWR_OUT_BLDO2_MASK	BIT_MASK(6)
> +#define AXP15060_PWR_OUT_BLDO3_MASK	BIT_MASK(7)
> +#define AXP15060_PWR_OUT_BLDO4_MASK	BIT_MASK(0)
> +#define AXP15060_PWR_OUT_BLDO5_MASK	BIT_MASK(1)
> +#define AXP15060_PWR_OUT_CLDO1_MASK	BIT_MASK(2)
> +#define AXP15060_PWR_OUT_CLDO2_MASK	BIT_MASK(3)
> +#define AXP15060_PWR_OUT_CLDO3_MASK	BIT_MASK(4)
> +#define AXP15060_PWR_OUT_CLDO4_MASK	BIT_MASK(5)
> +#define AXP15060_PWR_OUT_CPUSLDO_MASK	BIT_MASK(6)
> +#define AXP15060_PWR_OUT_SW_MASK		BIT_MASK(7)
> +
> +#define AXP15060_DCDC23_POLYPHASE_DUAL_MASK		BIT_MASK(6)
> +#define AXP15060_DCDC46_POLYPHASE_DUAL_MASK		BIT_MASK(7)
> +
> +#define AXP15060_DCDC234_500mV_START	0x00

Can you make those values consistently decimal? It's a bit confusing to
see the 70 steps in decimal, but the start (71) in hex.

> +#define AXP15060_DCDC234_500mV_STEPS	70
> +#define AXP15060_DCDC234_500mV_END		\
> +	(AXP15060_DCDC234_500mV_START + AXP15060_DCDC234_500mV_STEPS)
> +#define AXP15060_DCDC234_1220mV_START	0x47
> +#define AXP15060_DCDC234_1220mV_STEPS	16
> +#define AXP15060_DCDC234_1220mV_END		\
> +	(AXP15060_DCDC234_1220mV_START + AXP15060_DCDC234_1220mV_STEPS)
> +#define AXP15060_DCDC234_NUM_VOLTAGES	88
> +
> +#define AXP15060_DCDC5_800mV_START	0x00
> +#define AXP15060_DCDC5_800mV_STEPS	32
> +#define AXP15060_DCDC5_800mV_END		\
> +	(AXP15060_DCDC5_800mV_START + AXP15060_DCDC5_800mV_STEPS)
> +#define AXP15060_DCDC5_1140mV_START	0x21
> +#define AXP15060_DCDC5_1140mV_STEPS	35
> +#define AXP15060_DCDC5_1140mV_END		\
> +	(AXP15060_DCDC5_1140mV_START + AXP15060_DCDC5_1140mV_STEPS)
> +#define AXP15060_DCDC5_NUM_VOLTAGES	69
> +
>  #define AXP_DESC_IO(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
>  		    _vmask, _ereg, _emask, _enable_val, _disable_val)		\
>  	[_family##_##_id] = {							\
> @@ -1001,6 +1069,104 @@ static const struct regulator_desc axp813_regulators[] = {
>  		    AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DC1SW_MASK),
>  };
>  
> +static const struct linear_range axp15060_dcdc234_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000,
> +			       AXP15060_DCDC234_500mV_START,
> +			       AXP15060_DCDC234_500mV_END,
> +			       10000),
> +	REGULATOR_LINEAR_RANGE(1220000,
> +			       AXP15060_DCDC234_1220mV_START,
> +			       AXP15060_DCDC234_1220mV_END,
> +			       20000),
> +};
> +
> +static const struct linear_range axp15060_dcdc5_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(800000,
> +			       AXP15060_DCDC5_800mV_START,
> +			       AXP15060_DCDC5_800mV_END,
> +			       10000),
> +	REGULATOR_LINEAR_RANGE(1140000,
> +			       AXP15060_DCDC5_1140mV_START,
> +			       AXP15060_DCDC5_1140mV_END,
> +			       20000),
> +};
> +
> +static const struct regulator_desc axp15060_regulators[] = {
> +	AXP_DESC(AXP15060, DCDC1, "dcdc1", "vin1", 1500, 3400, 100,
> +		 AXP15060_DCDC1_V_CTRL, AXP15060_DCDC1_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC1_MASK),
> +	AXP_DESC_RANGES(AXP15060, DCDC2, "dcdc2", "vin2",
> +			axp15060_dcdc234_ranges, AXP15060_DCDC234_NUM_VOLTAGES,
> +			AXP15060_DCDC2_V_CTRL, AXP15060_DCDC2_V_CTRL_MASK,
> +			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC2_MASK),
> +	AXP_DESC_RANGES(AXP15060, DCDC3, "dcdc3", "vin3",
> +			axp15060_dcdc234_ranges, AXP15060_DCDC234_NUM_VOLTAGES,
> +			AXP15060_DCDC3_V_CTRL, AXP15060_DCDC3_V_CTRL_MASK,
> +			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC3_MASK),
> +	AXP_DESC_RANGES(AXP15060, DCDC4, "dcdc4", "vin4",
> +			axp15060_dcdc234_ranges, AXP15060_DCDC234_NUM_VOLTAGES,
> +			AXP15060_DCDC4_V_CTRL, AXP15060_DCDC4_V_CTRL_MASK,
> +			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC4_MASK),
> +	AXP_DESC_RANGES(AXP15060, DCDC5, "dcdc5", "vin5",
> +			axp15060_dcdc5_ranges, AXP15060_DCDC5_NUM_VOLTAGES,
> +			AXP15060_DCDC5_V_CTRL, AXP15060_DCDC5_V_CTRL_MASK,
> +			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC5_MASK),
> +	AXP_DESC(AXP15060, DCDC6, "dcdc6", "vin6", 500, 3400, 100,
> +		 AXP15060_DCDC6_V_CTRL, AXP15060_DCDC6_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC6_MASK),
> +	AXP_DESC(AXP15060, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
> +		 AXP15060_ALDO1_V_CTRL, AXP15060_ALDO1_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO1_MASK),
> +	AXP_DESC(AXP15060, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
> +		 AXP15060_ALDO2_V_CTRL, AXP15060_ALDO2_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO2_MASK),
> +	AXP_DESC(AXP15060, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
> +		 AXP15060_ALDO3_V_CTRL, AXP15060_ALDO3_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO3_MASK),
> +	AXP_DESC(AXP15060, ALDO4, "aldo4", "aldoin", 700, 3300, 100,
> +		 AXP15060_ALDO4_V_CTRL, AXP15060_ALDO4_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO4_MASK),
> +	AXP_DESC(AXP15060, ALDO5, "aldo5", "aldoin", 700, 3300, 100,
> +		 AXP15060_ALDO5_V_CTRL, AXP15060_ALDO5_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO5_MASK),
> +	AXP_DESC(AXP15060, BLDO1, "bldo1", "bldoin", 700, 3300, 100,
> +		 AXP15060_BLDO1_V_CTRL, AXP15060_BLDO1_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_BLDO1_MASK),
> +	AXP_DESC(AXP15060, BLDO2, "bldo2", "bldoin", 700, 3300, 100,
> +		 AXP15060_BLDO2_V_CTRL, AXP15060_BLDO2_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_BLDO2_MASK),
> +	AXP_DESC(AXP15060, BLDO3, "bldo3", "bldoin", 700, 3300, 100,
> +		 AXP15060_BLDO3_V_CTRL, AXP15060_BLDO3_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_BLDO3_MASK),
> +	AXP_DESC(AXP15060, BLDO4, "bldo4", "bldoin", 700, 3300, 100,
> +		 AXP15060_BLDO4_V_CTRL, AXP15060_BLDO4_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_BLDO4_MASK),
> +	AXP_DESC(AXP15060, BLDO5, "bldo5", "bldoin", 700, 3300, 100,
> +		 AXP15060_BLDO5_V_CTRL, AXP15060_BLDO5_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_BLDO5_MASK),
> +	AXP_DESC(AXP15060, CLDO1, "cldo1", "cldoin", 700, 3300, 100,
> +		 AXP15060_CLDO1_V_CTRL, AXP15060_CLDO1_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO1_MASK),
> +	AXP_DESC(AXP15060, CLDO2, "cldo2", "cldoin", 700, 3300, 100,
> +		 AXP15060_CLDO2_V_CTRL, AXP15060_CLDO2_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO2_MASK),
> +	AXP_DESC(AXP15060, CLDO3, "cldo3", "cldoin", 700, 3300, 100,
> +		 AXP15060_CLDO3_V_CTRL, AXP15060_CLDO3_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO3_MASK),
> +	AXP_DESC(AXP15060, CLDO4, "cldo4", "cldoin", 700, 4200, 100,
> +		 AXP15060_CLDO4_V_CTRL, AXP15060_CLDO4_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO4_MASK),
> +	AXP_DESC(AXP15060, CPUSLDO, "cpusldo", NULL, 700, 1400, 50,
> +		 AXP15060_CPUSLDO_V_CTRL, AXP15060_CPUSLDO_V_CTRL_MASK,
> +		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CPUSLDO_MASK),
> +	/* Supply comes from DCDC5 */

This comment (and the two below) should be *before* the respective
description.

> +	AXP_DESC_SW(AXP15060, SW, "swout", NULL,

Shouldn't the name here be "dc1sw", to match the other regulators? Also
"swout" wouldn't be covered by the regulator binding regexp, IIUC.

> +		    AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_SW_MASK),
> +	/* Supply comes from DCDC1 */
> +	AXP_DESC_FIXED(AXP15060, RTC_LDO, "rtc-ldo", NULL, 1800),
> +	/* Supply comes from ALDO1 */
> +};

So I compared all the bits and register offset above against the
(AXP853T) manual: they match.

> +
>  static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
>  {
>  	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> @@ -1145,6 +1311,15 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
>  		workmode <<= id - AXP813_DCDC1;
>  		break;
>  
> +	case AXP15060_ID:
> +		reg = AXP15060_DCDC_MODE_CTRL2;
> +		if (id < AXP15060_DCDC1 || id > AXP15060_DCDC6)
> +			return -EINVAL;
> +
> +		mask = AXP22X_WORKMODE_DCDCX_MASK(id - AXP15060_DCDC1);
> +		workmode <<= id - AXP15060_DCDC1;
> +		break;
> +
>  	default:
>  		/* should not happen */
>  		WARN_ON(1);
> @@ -1164,7 +1339,7 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
>  
>  	/*
>  	 * Currently in our supported AXP variants, only AXP803, AXP806,
> -	 * and AXP813 have polyphase regulators.
> +	 * AXP813 and AXP15060 have polyphase regulators.
>  	 */
>  	switch (axp20x->variant) {
>  	case AXP803_ID:
> @@ -1196,6 +1371,17 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
>  		}
>  		break;
>  
> +	case AXP15060_ID:
> +		regmap_read(axp20x->regmap, AXP15060_DCDC_MODE_CTRL1, &reg);
> +
> +		switch (id) {
> +		case AXP15060_DCDC3:
> +			return !!(reg & AXP15060_DCDC23_POLYPHASE_DUAL_MASK);
> +		case AXP15060_DCDC6:
> +			return !!(reg & AXP15060_DCDC46_POLYPHASE_DUAL_MASK);
> +		}
> +		break;
> +
>  	default:
>  		return false;
>  	}
> @@ -1217,6 +1403,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  	u32 workmode;
>  	const char *dcdc1_name = axp22x_regulators[AXP22X_DCDC1].name;
>  	const char *dcdc5_name = axp22x_regulators[AXP22X_DCDC5].name;
> +	const char *aldo1_name = axp15060_regulators[AXP15060_ALDO1].name;
>  	bool drivevbus = false;
>  
>  	switch (axp20x->variant) {
> @@ -1252,6 +1439,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
>  						  "x-powers,drive-vbus-en");
>  		break;
> +	case AXP15060_ID:
> +		regulators = axp15060_regulators;
> +		nregulators = AXP15060_REG_ID_MAX;
> +		break;
>  	default:
>  		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
>  			axp20x->variant);
> @@ -1278,8 +1469,9 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  			continue;
>  
>  		/*
> -		 * Regulators DC1SW and DC5LDO are connected internally,
> -		 * so we have to handle their supply names separately.
> +		 * Regulators DC1SW, DC5LDO and RTCLDO on AXP15060 are
> +		 * connected internally, so we have to handle their supply
> +		 * names separately.
>  		 *
>  		 * We always register the regulators in proper sequence,
>  		 * so the supply names are correctly read. See the last
> @@ -1288,7 +1480,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  		 */
>  		if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
>  		    (regulators == axp803_regulators && i == AXP803_DC1SW) ||
> -		    (regulators == axp809_regulators && i == AXP809_DC1SW)) {
> +			(regulators == axp809_regulators && i == AXP809_DC1SW) ||

looks like whitespace is off here

> +		    (regulators == axp15060_regulators && i == AXP15060_SW)) {

Can you name that AXP15060_DC1SW?

>  			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
>  						GFP_KERNEL);
>  			if (!new_desc)
> @@ -1300,7 +1493,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  		}
>  
>  		if ((regulators == axp22x_regulators && i == AXP22X_DC5LDO) ||
> -		    (regulators == axp809_regulators && i == AXP809_DC5LDO)) {
> +			(regulators == axp809_regulators && i == AXP809_DC5LDO) ||

whitespace, and again some more times below.

The rest looks good to me.

Cheers,
Andre

> +		    (regulators == axp15060_regulators && i == AXP15060_CPUSLDO)) {
>  			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
>  						GFP_KERNEL);
>  			if (!new_desc)
> @@ -1311,6 +1505,18 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  			desc = new_desc;
>  		}
>  
> +
> +		if (regulators == axp15060_regulators && i == AXP15060_RTC_LDO) {
> +			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
> +						GFP_KERNEL);
> +			if (!new_desc)
> +				return -ENOMEM;
> +
> +			*new_desc = regulators[i];
> +			new_desc->supply_name = aldo1_name;
> +			desc = new_desc;
> +		}
> +
>  		rdev = devm_regulator_register(&pdev->dev, desc, &config);
>  		if (IS_ERR(rdev)) {
>  			dev_err(&pdev->dev, "Failed to register %s\n",
> @@ -1329,19 +1535,26 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>  		}
>  
>  		/*
> -		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
> +		 * Save AXP22X DCDC1 / DCDC5 / AXP15060 ALDO1 regulator names for later.
>  		 */
>  		if ((regulators == axp22x_regulators && i == AXP22X_DCDC1) ||
> -		    (regulators == axp809_regulators && i == AXP809_DCDC1))
> +		    (regulators == axp809_regulators && i == AXP809_DCDC1) ||
> +			(regulators == axp15060_regulators && i == AXP15060_DCDC1))
>  			of_property_read_string(rdev->dev.of_node,
>  						"regulator-name",
>  						&dcdc1_name);
>  
>  		if ((regulators == axp22x_regulators && i == AXP22X_DCDC5) ||
> -		    (regulators == axp809_regulators && i == AXP809_DCDC5))
> +		    (regulators == axp809_regulators && i == AXP809_DCDC5) ||
> +			(regulators == axp15060_regulators && i == AXP15060_DCDC5))
>  			of_property_read_string(rdev->dev.of_node,
>  						"regulator-name",
>  						&dcdc5_name);
> +
> +		if (regulators == axp15060_regulators && i == AXP15060_ALDO1)
> +			of_property_read_string(rdev->dev.of_node,
> +						"regulator-name",
> +						&aldo1_name);
>  	}
>  
>  	if (drivevbus) {

