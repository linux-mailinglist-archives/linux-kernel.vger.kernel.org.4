Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5964F0D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiLPSSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLPSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:18:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B39AA3B9E9;
        Fri, 16 Dec 2022 10:18:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E832D1063;
        Fri, 16 Dec 2022 10:18:45 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BDF43F73B;
        Fri, 16 Dec 2022 10:18:03 -0800 (PST)
Date:   Fri, 16 Dec 2022 18:17:52 +0000
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mfd: ax20x: Add suppport for AXP1530 PMIC
Message-ID: <20221216181752.1d839233@donnerap.cambridge.arm.com>
In-Reply-To: <20221214190305.3354669-3-martin.botka@somainline.org>
References: <20221214190305.3354669-1-martin.botka@somainline.org>
        <20221214190305.3354669-3-martin.botka@somainline.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 20:03:04 +0100
Martin Botka <martin.botka@somainline.org> wrote:

Hi Martin,

> AXP1530 is a PMIC chip produced by X-Powers and an be connected via
> I2C bus.
> Where AXP313A seems to be closely related so the same driver can be used and
> seen it only paired with H616 SoC.

So as mentioned, I am pretending this is for the AXP313A now, looking at
its datasheet.
Of course the elephant in the room is s/AXP1530/AXP313A/, but other than
that:
 
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 ++
>  drivers/mfd/axp20x.c       | 62 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 32 ++++++++++++++++++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index 8fd6727dc30a..6bfb931a580e 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -60,6 +60,7 @@ static void axp20x_i2c_remove(struct i2c_client *i2c)
>  #ifdef CONFIG_OF
>  static const struct of_device_id axp20x_i2c_of_match[] = {
>  	{ .compatible = "x-powers,axp152", .data = (void *)AXP152_ID },
> +	{ .compatible = "x-powers,axp1530", .data = (void *)AXP1530_ID},
>  	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
>  	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
>  	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
> @@ -73,6 +74,7 @@ MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
>  
>  static const struct i2c_device_id axp20x_i2c_id[] = {
>  	{ "axp152", 0 },
> +	{ "axp1530", 0 },
>  	{ "axp202", 0 },
>  	{ "axp209", 0 },
>  	{ "axp221", 0 },
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 880c41fa7021..6caa7e87ad80 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -34,6 +34,7 @@
>  
>  static const char * const axp20x_model_names[] = {
>  	"AXP152",
> +	"AXP1530",
>  	"AXP202",
>  	"AXP209",
>  	"AXP221",
> @@ -66,6 +67,24 @@ static const struct regmap_access_table axp152_volatile_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(axp152_volatile_ranges),
>  };
>  
> +static const struct regmap_range axp1530_writeable_ranges[] = {
> +	regmap_reg_range(AXP1530_ON_INDICATE, AXP1530_FREQUENCY),

Where does this FREQUENCY register come from? BSP source? Is that the
lost register to set the PWM frequency?
The 313 datasheet doesn't mention it, and since we deny programming the
frequency, I would just leave it out.
If people find it existing (and useful!) later on, we should be able to
add it without breaking anything.

> +};
> +
> +static const struct regmap_range axp1530_volatile_ranges[] = {
> +	regmap_reg_range(AXP1530_ON_INDICATE, AXP1530_FREQUENCY),
> +};
> +
> +static const struct regmap_access_table axp1530_writeable_table = {
> +	.yes_ranges = axp1530_writeable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(axp1530_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table axp1530_volatile_table = {
> +	.yes_ranges = axp1530_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(axp1530_volatile_ranges),
> +};
> +
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
> @@ -245,6 +264,15 @@ static const struct regmap_config axp152_regmap_config = {
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>  
> +static const struct regmap_config axp1530_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.wr_table = &axp1530_writeable_table,
> +	.volatile_table = &axp1530_volatile_table,
> +	.max_register = AXP1530_FREQUENCY,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
>  static const struct regmap_config axp20x_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -304,6 +332,16 @@ static const struct regmap_irq axp152_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP152, GPIO0_INPUT,		2, 0),
>  };
>  
> +static const struct regmap_irq axp1530_regmap_irqs[] = {
> +	INIT_REGMAP_IRQ(AXP1530, KEY_L2H_EN, 0, 7),
> +	INIT_REGMAP_IRQ(AXP1530, KEY_H2L_EN, 0, 6),
> +	INIT_REGMAP_IRQ(AXP1530, POKSIRQ_EN, 0, 5),
> +	INIT_REGMAP_IRQ(AXP1530, POKLIRQ_EN, 0, 4),

Are those identifiers from the BSP source? The (translated) manual gives
some explanation, namely:
	PWRON key rising edge
	PWRON key falling edge
	Short press the PWRON button
	Long press the PWRON button

So I'd suggest we follow the existing naming:
	PEK_RIS_EDGE, PEK_FAL_EDGE, PEK_SHORT, PEK_LONG (respectively)

Or come up with names that people could actually decipher ;-)


> +	INIT_REGMAP_IRQ(AXP1530, DCDC3_UNDER, 0, 3),
> +	INIT_REGMAP_IRQ(AXP1530, DCDC2_UNDER, 0, 2),
> +	INIT_REGMAP_IRQ(AXP1530, TEMP_OVER, 0, 0),
> +};
> +
>  static const struct regmap_irq axp20x_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP20X, ACIN_OVER_V,		0, 7),
>  	INIT_REGMAP_IRQ(AXP20X, ACIN_PLUGIN,		0, 6),
> @@ -514,6 +552,18 @@ static const struct regmap_irq_chip axp152_regmap_irq_chip = {
>  	.num_regs		= 3,
>  };
>  
> +static const struct regmap_irq_chip axp1530_regmap_irq_chip = {
> +	.name = "axp1530_irq_chip",
> +	.status_base = AXP1530_IRQ_STATUS1,
> +	.ack_base = AXP1530_IRQ_STATUS1,
> +	.mask_base = AXP1530_IRQ_ENABLE1,
> +	.mask_invert = true,
> +	.init_ack_masked = true,
> +	.irqs = axp1530_regmap_irqs,
> +	.num_irqs = ARRAY_SIZE(axp1530_regmap_irqs),
> +	.num_regs = 1,
> +};
> +
>  static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
>  	.name			= "axp20x_irq_chip",
>  	.status_base		= AXP20X_IRQ1_STATE,
> @@ -683,6 +733,12 @@ static const struct mfd_cell axp152_cells[] = {
>  	},
>  };
>  
> +static struct mfd_cell axp1530_cells[] = {
> +	{
> +		.name = "axp20x-regulator",
> +	},
> +};
> +
>  static const struct resource axp288_adc_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP288_IRQ_GPADC, "GPADC"),
>  };
> @@ -874,6 +930,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  		axp20x->regmap_cfg = &axp152_regmap_config;
>  		axp20x->regmap_irq_chip = &axp152_regmap_irq_chip;
>  		break;
> +	case AXP1530_ID:
> +		axp20x->nr_cells = ARRAY_SIZE(axp1530_cells);
> +		axp20x->cells = axp1530_cells;
> +		axp20x->regmap_cfg = &axp1530_regmap_config;
> +		axp20x->regmap_irq_chip = &axp1530_regmap_irq_chip;
> +		break;
>  	case AXP202_ID:
>  	case AXP209_ID:
>  		axp20x->nr_cells = ARRAY_SIZE(axp20x_cells);
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 9ab0e2fca7ea..cad25754500f 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -12,6 +12,7 @@
>  
>  enum axp20x_variants {
>  	AXP152_ID = 0,
> +	AXP1530_ID,
>  	AXP202_ID,
>  	AXP209_ID,
>  	AXP221_ID,
> @@ -45,6 +46,18 @@ enum axp20x_variants {
>  #define AXP152_DCDC_FREQ		0x37
>  #define AXP152_DCDC_MODE		0x80
>  
> +#define AXP1530_ON_INDICATE		0x00
> +#define AXP1530_OUTPUT_CONTROL	0x10
> +#define AXP1530_DCDC1_CONRTOL	0x13
> +#define AXP1530_DCDC2_CONRTOL	0x14
> +#define AXP1530_DCDC3_CONRTOL	0x15
> +#define AXP1530_ALDO1_CONRTOL	0x16
> +#define AXP1530_DLDO1_CONRTOL	0x17
> +#define AXP1530_OUTOUT_MONITOR	0x1D

Shall this read AXP1530_OUTPUT_MONITOR?

> +#define AXP1530_IRQ_ENABLE1		0x20
> +#define AXP1530_IRQ_STATUS1		0x21

There is only one interrupt register, so can we drop the trailing number?

> +#define AXP1530_FREQUENCY		0x87

As mentioned, the manual does not mention it, and we don't use it anyway.

> +
>  #define AXP20X_PWR_INPUT_STATUS		0x00
>  #define AXP20X_PWR_OP_MODE		0x01
>  #define AXP20X_USB_OTG_STATUS		0x02
> @@ -287,6 +300,15 @@ enum axp20x_variants {
>  #define AXP288_FG_TUNE5             0xed
>  
>  /* Regulators IDs */
> +enum {
> +	AXP1530_DCDC1 = 0,
> +	AXP1530_DCDC2,
> +	AXP1530_DCDC3,
> +	AXP1530_LDO1,
> +	AXP1530_LDO2,

I guess we should add the RTC LDO as LDO3 here.

The rest of the numbers match with the datasheet.

Cheers,
Andre

> +	AXP1530_REG_ID_MAX,
> +};
> +
>  enum {
>  	AXP20X_LDO1 = 0,
>  	AXP20X_LDO2,
> @@ -440,6 +462,16 @@ enum {
>  	AXP152_IRQ_GPIO0_INPUT,
>  };
>  
> +enum axp1530_irqs {
> +	AXP1530_IRQ_TEMP_OVER,
> +	AXP1530_IRQ_DCDC2_UNDER = 2,
> +	AXP1530_IRQ_DCDC3_UNDER,
> +	AXP1530_IRQ_POKLIRQ_EN,
> +	AXP1530_IRQ_POKSIRQ_EN,
> +	AXP1530_IRQ_KEY_L2H_EN,
> +	AXP1530_IRQ_KEY_H2L_EN,
> +};
> +
>  enum {
>  	AXP20X_IRQ_ACIN_OVER_V = 1,
>  	AXP20X_IRQ_ACIN_PLUGIN,

