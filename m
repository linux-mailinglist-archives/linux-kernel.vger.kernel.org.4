Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93CB6D06BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjC3NaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjC3N35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A623AD0E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F0462062
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFCCC433EF;
        Thu, 30 Mar 2023 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680182981;
        bh=Iiezy7MHd0OQyIJ37QYZcwjoZ0dREEzhmcn52eBrRuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeYyouDObQFj3T4HvZViNgVGfFTyAyXiJvupN/7ZvVndsmt9LVnRAH6IdunpT+uJO
         julqE8DajyjDJShnLetEan2x+sQJk+uWCYnflD5amFk68K4x+7ez+L10TRNOEYaRNK
         qFe5K8gH4pJssfgs8rgVVJoxcxfwx/xy3QkFyegmifObuqIINir9HTt3Pp4zRm3yO5
         V1PeLSobbK0duiZtgGxte39ZkhBxfkD0gIz4+PQa99wnd3fKtlgws9d+wVH0M5zYtk
         qiLhg4C1cyhLr0RXKk5vaCSWV0coz0O0wmGetqT95X2gQynP1J4OBwzGYnvlKdGunI
         QYUkETK32zsOQ==
Date:   Thu, 30 Mar 2023 14:29:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] mfd: axp20x: Add support for AXP313a PMIC
Message-ID: <20230330132935.GS434339@google.com>
References: <20230324113013.254371-1-andre.przywara@arm.com>
 <20230324113013.254371-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230324113013.254371-3-andre.przywara@arm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023, Andre Przywara wrote:

> From: Martin Botka <martin.botka@somainline.org>
>
> The AXP313a is a PMIC chip produced by X-Powers, it can be connected via
> an I2C bus.
> The name AXP1530 seems to appear as well, and this is what is used in
> the BSP driver. From all we know it's the same chip, just a different
> name. However we have only seen AXP313a chips in the wild, so go with
> this name.
>
> Compared to the other AXP PMICs it's a rather simple affair: just three
> DCDC converters, three LDOs, and no battery charging support.
>
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C. Aside from the various regulators, also describe the power key
> interrupts, and adjust the shutdown handler routine to use a different
> register than the other PMICs.
> Eventually advertise the device using the new compatible string.
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 +
>  drivers/mfd/axp20x.c       | 82 +++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/axp20x.h | 32 +++++++++++++++
>  3 files changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index f49fbd3079589..f061177cb18e5 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -63,6 +63,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
>  	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
>  	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
>  	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
> +	{ .compatible = "x-powers,axp313a", .data = (void *)AXP313A_ID },
>  	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
>  	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
>  	{ },
> @@ -76,6 +77,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
>  	{ "axp209", 0 },
>  	{ "axp221", 0 },
>  	{ "axp223", 0 },
> +	{ "axp313a", 0 },
>  	{ "axp803", 0 },
>  	{ "axp806", 0 },
>  	{ },
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 01a6bbb6d266d..c4325977e384b 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -39,6 +39,7 @@ static const char * const axp20x_model_names[] = {
>  	"AXP221",
>  	"AXP223",
>  	"AXP288",
> +	"AXP313a",
>  	"AXP803",
>  	"AXP806",
>  	"AXP809",
> @@ -154,6 +155,25 @@ static const struct regmap_range axp806_writeable_ranges[] = {
>  	regmap_reg_range(AXP806_REG_ADDR_EXT, AXP806_REG_ADDR_EXT),
>  };
>
> +static const struct regmap_range axp313a_writeable_ranges[] = {
> +	regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
> +};
> +
> +static const struct regmap_range axp313a_volatile_ranges[] = {
> +	regmap_reg_range(AXP313A_SHUTDOWN_CTRL, AXP313A_SHUTDOWN_CTRL),
> +	regmap_reg_range(AXP313A_IRQ_STATE, AXP313A_IRQ_STATE),
> +};
> +
> +static const struct regmap_access_table axp313a_writeable_table = {
> +	.yes_ranges = axp313a_writeable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(axp313a_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table axp313a_volatile_table = {
> +	.yes_ranges = axp313a_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(axp313a_volatile_ranges),
> +};
> +
>  static const struct regmap_range axp806_volatile_ranges[] = {
>  	regmap_reg_range(AXP20X_IRQ1_STATE, AXP20X_IRQ2_STATE),
>  };
> @@ -221,6 +241,11 @@ static const struct resource axp288_fuel_gauge_resources[] = {
>  	DEFINE_RES_IRQ(AXP288_IRQ_WL1),
>  };
>
> +static const struct resource axp313a_pek_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP313A_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
> +	DEFINE_RES_IRQ_NAMED(AXP313A_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> +};
> +
>  static const struct resource axp803_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>  	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -272,6 +297,15 @@ static const struct regmap_config axp288_regmap_config = {
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>
> +static const struct regmap_config axp313a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.wr_table = &axp313a_writeable_table,
> +	.volatile_table = &axp313a_volatile_table,
> +	.max_register = AXP313A_IRQ_STATE,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
>  static const struct regmap_config axp806_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -415,6 +449,16 @@ static const struct regmap_irq axp288_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP288, BC_USB_CHNG,            5, 1),
>  };
>
> +static const struct regmap_irq axp313a_regmap_irqs[] = {
> +	INIT_REGMAP_IRQ(AXP313A, PEK_RIS_EDGE,		0, 7),
> +	INIT_REGMAP_IRQ(AXP313A, PEK_FAL_EDGE,		0, 6),
> +	INIT_REGMAP_IRQ(AXP313A, PEK_SHORT,		0, 5),
> +	INIT_REGMAP_IRQ(AXP313A, PEK_LONG,		0, 4),
> +	INIT_REGMAP_IRQ(AXP313A, DCDC3_V_LOW,		0, 3),
> +	INIT_REGMAP_IRQ(AXP313A, DCDC2_V_LOW,		0, 2),
> +	INIT_REGMAP_IRQ(AXP313A, DIE_TEMP_HIGH,		0, 0),
> +};
> +
>  static const struct regmap_irq axp803_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP803, ACIN_OVER_V,		0, 7),
>  	INIT_REGMAP_IRQ(AXP803, ACIN_PLUGIN,		0, 6),
> @@ -548,6 +592,17 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
>
>  };
>
> +static const struct regmap_irq_chip axp313a_regmap_irq_chip = {
> +	.name			= "axp313a_irq_chip",
> +	.status_base		= AXP313A_IRQ_STATE,
> +	.ack_base		= AXP313A_IRQ_STATE,
> +	.unmask_base		= AXP313A_IRQ_EN,
> +	.init_ack_masked	= true,
> +	.irqs			= axp313a_regmap_irqs,
> +	.num_irqs		= ARRAY_SIZE(axp313a_regmap_irqs),
> +	.num_regs		= 1,
> +};
> +
>  static const struct regmap_irq_chip axp803_regmap_irq_chip = {
>  	.name			= "axp803",
>  	.status_base		= AXP20X_IRQ1_STATE,
> @@ -676,6 +731,15 @@ static const struct mfd_cell axp152_cells[] = {
>  	},
>  };
>
> +static struct mfd_cell axp313a_cells[] = {
> +	MFD_CELL_NAME("axp20x-regulator"),
> +	{
> +		.name		= "axp313a-pek",
> +		.num_resources	= ARRAY_SIZE(axp313a_pek_resources),
> +		.resources	= axp313a_pek_resources,
> +	},

Nit: MFD_CELL_RES() ?

Other than that, looks fine.  Once fixed:

For my own reference (apply this as-is to your sign-off block):

Acked-for-MFD-by: Lee Jones <lee@kernel.org>

--
Lee Jones [李琼斯]
