Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E636E4AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDQOGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjDQOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:06:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC62849DB;
        Mon, 17 Apr 2023 07:05:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274291691;
        Mon, 17 Apr 2023 07:06:08 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06BFD3F5A1;
        Mon, 17 Apr 2023 07:05:22 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:05:20 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com
Subject: Re: [PATCH v1 2/4] mfd: axp20x: Add support for AXP15060 PMIC
Message-ID: <20230417150520.384d0747@donnerap.cambridge.arm.com>
In-Reply-To: <TY3P286MB2611B7354DE4050FFB7CCD5498969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <20230407141813.89-1-wiagn233@outlook.com>
 <TY3P286MB2611B7354DE4050FFB7CCD5498969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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

On Fri,  7 Apr 2023 22:18:11 +0800
Shengyu Qu <wiagn233@outlook.com> wrote:

Hi Shengyu,

thanks for doing the tedious work and sending this!

> The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
> via an I2C bus.
> 
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C. Eventually advertise the device using a new compatible string
> and add support for power off the system.
> 
> The driver would disable PEK function if IRQ is not configured in device
> tree, since some boards (For example, Starfive Visionfive 2) didn't
> connect IRQ line of PMIC to SOC.
> 
> GPIO function isn't enabled in this commit, since its configuration
> operation is different from any existing AXP PMICs and needs
> logic modification on existing driver. GPIO support might come in later
> patches.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 +
>  drivers/mfd/axp20x.c       | 90 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 85 +++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index f49fbd307958..b4f5cb457117 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
>  	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
>  	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
>  	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
> +	{ .compatible = "x-powers,axp15060", .data = (void *)AXP15060_ID },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
> @@ -78,6 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
>  	{ "axp223", 0 },
>  	{ "axp803", 0 },
>  	{ "axp806", 0 },
> +	{ "axp15060", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 01a6bbb6d266..42ec27a4dfc4 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -43,6 +43,7 @@ static const char * const axp20x_model_names[] = {
>  	"AXP806",
>  	"AXP809",
>  	"AXP813",
> +	"AXP15060",
>  };
>  
>  static const struct regmap_range axp152_writeable_ranges[] = {
> @@ -168,6 +169,31 @@ static const struct regmap_access_table axp806_volatile_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(axp806_volatile_ranges),
>  };
>  
> +static const struct regmap_range axp15060_writeable_ranges[] = {
> +	regmap_reg_range(AXP15060_PWR_OUT_CTRL1, AXP15060_DCDC_MODE_CTRL2),
> +	regmap_reg_range(AXP15060_OUTPUT_MONITOR_DISCHARGE, AXP15060_CPUSLDO_V_CTRL),
> +	regmap_reg_range(AXP15060_PWR_WAKEUP_CTRL, AXP15060_PWR_DISABLE_DOWN_SEQ),
> +	regmap_reg_range(AXP15060_PEK_KEY, AXP15060_PEK_KEY),
> +	regmap_reg_range(AXP15060_IRQ1_EN, AXP15060_IRQ2_EN),
> +	regmap_reg_range(AXP15060_IRQ1_STATE, AXP15060_IRQ2_STATE),
> +};
> +
> +static const struct regmap_range axp15060_volatile_ranges[] = {
> +	regmap_reg_range(AXP15060_STARTUP_SRC, AXP15060_STARTUP_SRC),
> +	regmap_reg_range(AXP15060_PWR_WAKEUP_CTRL, AXP15060_PWR_DISABLE_DOWN_SEQ),
> +	regmap_reg_range(AXP15060_IRQ1_STATE, AXP15060_IRQ2_STATE),
> +};
> +
> +static const struct regmap_access_table axp15060_writeable_table = {
> +	.yes_ranges	= axp15060_writeable_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(axp15060_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table axp15060_volatile_table = {
> +	.yes_ranges	= axp15060_volatile_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(axp15060_volatile_ranges),
> +};
> +
>  static const struct resource axp152_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>  	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -236,6 +262,11 @@ static const struct resource axp809_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
>  };
>  
> +static const struct resource axp15060_pek_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP15060_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
> +	DEFINE_RES_IRQ_NAMED(AXP15060_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> +};
> +
>  static const struct regmap_config axp152_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -281,6 +312,15 @@ static const struct regmap_config axp806_regmap_config = {
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>  
> +static const struct regmap_config axp15060_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.wr_table	= &axp15060_writeable_table,
> +	.volatile_table	= &axp15060_volatile_table,
> +	.max_register	= AXP15060_IRQ2_STATE,
> +	.cache_type	= REGCACHE_RBTREE,
> +};
> +
>  #define INIT_REGMAP_IRQ(_variant, _irq, _off, _mask)			\
>  	[_variant##_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
>  
> @@ -502,6 +542,23 @@ static const struct regmap_irq axp809_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP809, GPIO0_INPUT,		4, 0),
>  };
>  
> +static const struct regmap_irq axp15060_regmap_irqs[] = {
> +	INIT_REGMAP_IRQ(AXP15060, DIE_TEMP_HIGH_LV1,	0, 0),
> +	INIT_REGMAP_IRQ(AXP15060, DIE_TEMP_HIGH_LV2,	0, 1),
> +	INIT_REGMAP_IRQ(AXP15060, DCDC1_V_LOW,		0, 2),
> +	INIT_REGMAP_IRQ(AXP15060, DCDC2_V_LOW,		0, 3),
> +	INIT_REGMAP_IRQ(AXP15060, DCDC3_V_LOW,		0, 4),
> +	INIT_REGMAP_IRQ(AXP15060, DCDC4_V_LOW,		0, 5),
> +	INIT_REGMAP_IRQ(AXP15060, DCDC5_V_LOW,		0, 6),
> +	INIT_REGMAP_IRQ(AXP15060, DCDC6_V_LOW,		0, 7),
> +	INIT_REGMAP_IRQ(AXP15060, PEK_LONG,			1, 0),
> +	INIT_REGMAP_IRQ(AXP15060, PEK_SHORT,			1, 1),
> +	INIT_REGMAP_IRQ(AXP15060, GPIO1_INPUT,		1, 2),
> +	INIT_REGMAP_IRQ(AXP15060, PEK_FAL_EDGE,			1, 3),
> +	INIT_REGMAP_IRQ(AXP15060, PEK_RIS_EDGE,			1, 4),
> +	INIT_REGMAP_IRQ(AXP15060, GPIO2_INPUT,		1, 5),
> +};
> +
>  static const struct regmap_irq_chip axp152_regmap_irq_chip = {
>  	.name			= "axp152_irq_chip",
>  	.status_base		= AXP152_IRQ1_STATE,
> @@ -581,6 +638,17 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
>  	.num_regs		= 5,
>  };
>  
> +static const struct regmap_irq_chip axp15060_regmap_irq_chip = {
> +	.name			= "axp15060",
> +	.status_base		= AXP15060_IRQ1_STATE,
> +	.ack_base		= AXP15060_IRQ1_STATE,
> +	.unmask_base		= AXP15060_IRQ1_EN,
> +	.init_ack_masked	= true,
> +	.irqs			= axp15060_regmap_irqs,
> +	.num_irqs		= ARRAY_SIZE(axp15060_regmap_irqs),
> +	.num_regs		= 2,
> +};
> +
>  static const struct mfd_cell axp20x_cells[] = {
>  	{
>  		.name		= "axp20x-gpio",
> @@ -825,6 +893,16 @@ static const struct mfd_cell axp813_cells[] = {
>  	},
>  };
>  
> +static const struct mfd_cell axp15060_cells[] = {
> +	{
> +		.name		= "axp221-pek",
> +		.num_resources	= ARRAY_SIZE(axp15060_pek_resources),
> +		.resources	= axp15060_pek_resources,
> +	}, {
> +		.name		= "axp20x-regulator",
> +	},

As Lee mentioned the other day, there are the MFD_CELL_NAME and
MFD_CELL_RES macro to wrap those now.

I compared all the register offsets and bit names against the (AXP853T)
manual, they match.

> +};
> +
>  static int axp20x_power_off(struct sys_off_data *data)
>  {
>  	struct axp20x_dev *axp20x = data->cb_data;
> @@ -934,6 +1012,18 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  		 */
>  		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
>  		break;
> +	case AXP15060_ID:
> +		/* Don't register the power key part if there is no interrupt line. */

Mmh, I don't know if this is really needed. If the IRQ line is not
connected, it isn't really critical, it just wouldn't work, would it? I
wonder if the same problem applies to all the other PMICs?
I see that we handle it like this for the AXP806, but I wonder if this is
more a by-product of the slave mode requirement there.

> +		if (axp20x->irq > 0) {
> +			axp20x->nr_cells = ARRAY_SIZE(axp15060_cells);
> +			axp20x->cells = axp15060_cells;
> +		} else {
> +			axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
> +			axp20x->cells = axp806_cells;

That looks a bit odd. Either we rename this alternative axp806_cells
definition somewhere above to something generic (axp_regulator_cells?), or
there should be a comment here explaining why all of a sudden an AXP15060
without an IRQ line is the same as the AXP806.

> +		}
> +		axp20x->regmap_cfg = &axp15060_regmap_config;
> +		axp20x->regmap_irq_chip = &axp15060_regmap_irq_chip;
> +		break;
>  	default:
>  		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
>  		return -EINVAL;
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 2058194807bd..abc2bdc54bf5 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -21,6 +21,7 @@ enum axp20x_variants {
>  	AXP806_ID,
>  	AXP809_ID,
>  	AXP813_ID,
> +	AXP15060_ID,
>  	NR_AXP20X_VARIANTS,
>  };
>  
> @@ -131,6 +132,39 @@ enum axp20x_variants {
>  /* Other DCDC regulator control registers are the same as AXP803 */
>  #define AXP813_DCDC7_V_OUT		0x26
>  
> +#define AXP15060_STARTUP_SRC		0x00
> +#define AXP15060_PWR_OUT_CTRL1		0x10
> +#define AXP15060_PWR_OUT_CTRL2		0x11
> +#define AXP15060_PWR_OUT_CTRL3		0x12
> +#define AXP15060_DCDC1_V_CTRL		0x13
> +#define AXP15060_DCDC2_V_CTRL		0x14
> +#define AXP15060_DCDC3_V_CTRL		0x15
> +#define AXP15060_DCDC4_V_CTRL		0x16
> +#define AXP15060_DCDC5_V_CTRL		0x17
> +#define AXP15060_DCDC6_V_CTRL		0x18
> +#define AXP15060_ALDO1_V_CTRL		0x19
> +#define AXP15060_DCDC_MODE_CTRL1		0x1a
> +#define AXP15060_DCDC_MODE_CTRL2		0x1b
> +#define AXP15060_OUTPUT_MONITOR_DISCHARGE		0x1e
> +#define AXP15060_IRQ_PWROK_VOFF		0x1f
> +#define AXP15060_ALDO2_V_CTRL		0x20
> +#define AXP15060_ALDO3_V_CTRL		0x21
> +#define AXP15060_ALDO4_V_CTRL		0x22
> +#define AXP15060_ALDO5_V_CTRL		0x23
> +#define AXP15060_BLDO1_V_CTRL		0x24
> +#define AXP15060_BLDO2_V_CTRL		0x25
> +#define AXP15060_BLDO3_V_CTRL		0x26
> +#define AXP15060_BLDO4_V_CTRL		0x27
> +#define AXP15060_BLDO5_V_CTRL		0x28
> +#define AXP15060_CLDO1_V_CTRL		0x29
> +#define AXP15060_CLDO2_V_CTRL		0x2a
> +#define AXP15060_CLDO3_V_CTRL		0x2b
> +#define AXP15060_CLDO4_V_CTRL		0x2d
> +#define AXP15060_CPUSLDO_V_CTRL		0x2e
> +#define AXP15060_PWR_WAKEUP_CTRL		0x31
> +#define AXP15060_PWR_DISABLE_DOWN_SEQ		0x32
> +#define AXP15060_PEK_KEY		0x36
> +
>  /* Interrupt */
>  #define AXP152_IRQ1_EN			0x40
>  #define AXP152_IRQ2_EN			0x41
> @@ -139,6 +173,11 @@ enum axp20x_variants {
>  #define AXP152_IRQ2_STATE		0x49
>  #define AXP152_IRQ3_STATE		0x4a
>  
> +#define AXP15060_IRQ1_EN		0x40
> +#define AXP15060_IRQ2_EN		0x41
> +#define AXP15060_IRQ1_STATE		0x48
> +#define AXP15060_IRQ2_STATE		0x49
> +
>  #define AXP20X_IRQ1_EN			0x40
>  #define AXP20X_IRQ2_EN			0x41
>  #define AXP20X_IRQ3_EN			0x42
> @@ -222,6 +261,8 @@ enum axp20x_variants {
>  #define AXP22X_GPIO_STATE		0x94
>  #define AXP22X_GPIO_PULL_DOWN		0x95
>  
> +#define AXP15060_CLDO4_GPIO2_MODESET		0x2c
> +

Compared the register offsets against the manual, they match.

Cheers,
Andre

>  /* Battery */
>  #define AXP20X_CHRG_CC_31_24		0xb0
>  #define AXP20X_CHRG_CC_23_16		0xb1
> @@ -419,6 +460,33 @@ enum {
>  	AXP813_REG_ID_MAX,
>  };
>  
> +enum {
> +	AXP15060_DCDC1 = 0,
> +	AXP15060_DCDC2,
> +	AXP15060_DCDC3,
> +	AXP15060_DCDC4,
> +	AXP15060_DCDC5,
> +	AXP15060_DCDC6,
> +	AXP15060_ALDO1,
> +	AXP15060_ALDO2,
> +	AXP15060_ALDO3,
> +	AXP15060_ALDO4,
> +	AXP15060_ALDO5,
> +	AXP15060_BLDO1,
> +	AXP15060_BLDO2,
> +	AXP15060_BLDO3,
> +	AXP15060_BLDO4,
> +	AXP15060_BLDO5,
> +	AXP15060_CLDO1,
> +	AXP15060_CLDO2,
> +	AXP15060_CLDO3,
> +	AXP15060_CLDO4,
> +	AXP15060_CPUSLDO,
> +	AXP15060_SW,
> +	AXP15060_RTC_LDO,
> +	AXP15060_REG_ID_MAX,
> +};
> +
>  /* IRQs */
>  enum {
>  	AXP152_IRQ_LDO0IN_CONNECT = 1,
> @@ -637,6 +705,23 @@ enum axp809_irqs {
>  	AXP809_IRQ_GPIO0_INPUT,
>  };
>  
> +enum axp15060_irqs {
> +	AXP15060_IRQ_DIE_TEMP_HIGH_LV1 = 1,
> +	AXP15060_IRQ_DIE_TEMP_HIGH_LV2,
> +	AXP15060_IRQ_DCDC1_V_LOW,
> +	AXP15060_IRQ_DCDC2_V_LOW,
> +	AXP15060_IRQ_DCDC3_V_LOW,
> +	AXP15060_IRQ_DCDC4_V_LOW,
> +	AXP15060_IRQ_DCDC5_V_LOW,
> +	AXP15060_IRQ_DCDC6_V_LOW,
> +	AXP15060_IRQ_PEK_LONG,
> +	AXP15060_IRQ_PEK_SHORT,
> +	AXP15060_IRQ_GPIO1_INPUT,
> +	AXP15060_IRQ_PEK_FAL_EDGE,
> +	AXP15060_IRQ_PEK_RIS_EDGE,
> +	AXP15060_IRQ_GPIO2_INPUT,
> +};
> +
>  struct axp20x_dev {
>  	struct device			*dev;
>  	int				irq;

