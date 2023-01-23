Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0485677FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjAWP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjAWP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:28:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171CF55A5;
        Mon, 23 Jan 2023 07:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD5060F5E;
        Mon, 23 Jan 2023 15:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6D9C433EF;
        Mon, 23 Jan 2023 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674487685;
        bh=8nopWCghWSW6qg8L9ZsS34jM69jMO1LFoFfm/AalAfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUxRmKp7CiHKY961/2uBdqNaRyuSjLFLuN5KZxLhGIBaSbPplMiYkKHSdBxj2WOWJ
         uXECKrCONlmX91BA7249i7kYHI66nZWawITAlgpYhgbQ3xL7umIgOE4xoEgzspGaQD
         nUNzaSzoHeJUMeh2hphujQmnzLs/+sO2z24JxDVhSrZKlMChdGKup/5KjRrjPyTIlL
         wyHR+IuQqTDXtmpbS9uKt1BfYKhLtKnKuFPoeqF3X7ZLq4RCRu/1BsyiaA74XJpPc/
         81+4RPUdPSMD3WS4TfplghlIJsgNxur8wySmD4FSl0ouRHTd5vr5FjtPC7bxx6DZ+3
         c+kROTFx620qw==
Date:   Mon, 23 Jan 2023 15:27:58 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 07/10] mfd: rk8xx: add rk806 support
Message-ID: <Y86nfvtV4AacstMZ@google.com>
References: <20230109172723.60304-1-sebastian.reichel@collabora.com>
 <20230109172723.60304-8-sebastian.reichel@collabora.com>
 <Y8rIadiDIEdXuM0Y@google.com>
 <20230123143321.lsddiol6bo2agfbk@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123143321.lsddiol6bo2agfbk@mercury.elektranox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, Sebastian Reichel wrote:

> Hi,
> 
> On Fri, Jan 20, 2023 at 04:59:21PM +0000, Lee Jones wrote:
> > On Mon, 09 Jan 2023, Sebastian Reichel wrote:
> > 
> > > Add support for SPI connected rk806, which is used by the RK3588
> > > evaluation boards. The PMIC is advertised to support I2C and SPI,
> > > but the evaluation boards all use SPI. Thus only SPI support is
> > > added here.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  drivers/mfd/Kconfig       |  14 ++
> > >  drivers/mfd/Makefile      |   1 +
> > >  drivers/mfd/rk8xx-core.c  |  67 ++++++-
> > >  drivers/mfd/rk8xx-spi.c   | 122 ++++++++++++
> > >  include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 611 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/mfd/rk8xx-spi.c
> > > 
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 692e38283bda..13582ea5cb44 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1222,6 +1222,20 @@ config MFD_RK8XX_I2C
> > >  	  through I2C interface. The device supports multiple sub-devices
> > >  	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
> > >  
> > > +config MFD_RK8XX_SPI
> > > +	tristate "Rockchip RK806 Power Management Chip"
> > > +	depends on SPI && OF
> > > +	select MFD_CORE
> > > +	select REGMAP_SPI
> > > +	select REGMAP_IRQ
> > > +	select MFD_RK8XX
> > > +	help
> > > +	  If you say yes here you get support for the RK806 Power Management
> > > +	  chip.
> > > +	  This driver provides common support for accessing the device
> > > +	  through an SPI interface. The device supports multiple sub-devices
> > > +	  including interrupts, LDO & DCDC regulators, and power on-key.
> > > +
> > >  config MFD_RN5T618
> > >  	tristate "Ricoh RN5T567/618 PMIC"
> > >  	depends on I2C
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index f65ef1bd0810..a88f27cd837b 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -222,6 +222,7 @@ obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
> > >  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> > >  obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
> > >  obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
> > > +obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
> > >  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
> > >  obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
> > >  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
> > > diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> > > index c52f5fa1a4da..289f4c1f30c2 100644
> > > --- a/drivers/mfd/rk8xx-core.c
> > > +++ b/drivers/mfd/rk8xx-core.c
> > > @@ -37,6 +37,11 @@ static const struct resource rk805_key_resources[] = {
> > >  	DEFINE_RES_IRQ(RK805_IRQ_PWRON_FALL),
> > >  };
> > >  
> > > +static struct resource rk806_pwrkey_resources[] = {
> > > +	DEFINE_RES_IRQ(RK806_IRQ_PWRON_FALL),
> > > +	DEFINE_RES_IRQ(RK806_IRQ_PWRON_RISE),
> > > +};
> > > +
> > >  static const struct resource rk817_pwrkey_resources[] = {
> > >  	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
> > >  	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
> > > @@ -64,6 +69,16 @@ static const struct mfd_cell rk805s[] = {
> > >  	},
> > >  };
> > >  
> > > +static const struct mfd_cell rk806s[] = {
> > > +	{ .name = "rk805-pinctrl", },
> > > +	{ .name = "rk808-regulator", },
> > > +	{
> > > +		.name = "rk805-pwrkey",
> > > +		.num_resources = ARRAY_SIZE(rk806_pwrkey_resources),
> > > +		.resources = &rk806_pwrkey_resources[0],
> > 
> > My OCD-sense is tingling.
> > 
> > Could you please add the resources *before* the num_resources please?
> > 
> > Also: '.resources = rk806_pwrkey_resources' is fine
> 
> Ack.
> 
> > 
> > > +	},
> > > +};
> > > +
> > >  static const struct mfd_cell rk808s[] = {
> > >  	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
> > >  	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
> > > @@ -122,6 +137,12 @@ static const struct rk808_reg_data rk805_pre_init_reg[] = {
> > >  	{RK805_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP115C},
> > >  };
> > >  
> > > +static const struct rk808_reg_data rk806_pre_init_reg[] = {
> > > +	{ RK806_GPIO_INT_CONFIG, RK806_INT_POL_MSK, RK806_INT_POL_L },
> > > +	{ RK806_SYS_CFG3, RK806_SLAVE_RESTART_FUN_MSK, RK806_SLAVE_RESTART_FUN_EN },
> > > +	{ RK806_SYS_OPTION, RK806_SYS_ENB2_2M_MSK, RK806_SYS_ENB2_2M_EN },
> > > +};
> > > +
> > >  static const struct rk808_reg_data rk808_pre_init_reg[] = {
> > >  	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
> > >  	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
> > > @@ -272,6 +293,27 @@ static const struct regmap_irq rk805_irqs[] = {
> > >  	},
> > >  };
> > >  
> > > +static const struct regmap_irq rk806_irqs[] = {
> > > +	/* INT_STS0 IRQs */
> > > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_FALL, 0, RK806_INT_STS_PWRON_FALL),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_RISE, 0, RK806_INT_STS_PWRON_RISE),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON, 0, RK806_INT_STS_PWRON),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_LP, 0, RK806_INT_STS_PWRON_LP),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_HOTDIE, 0, RK806_INT_STS_HOTDIE),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_VDC_RISE, 0, RK806_INT_STS_VDC_RISE),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_VDC_FALL, 0, RK806_INT_STS_VDC_FALL),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_VB_LO, 0, RK806_INT_STS_VB_LO),
> > > +	/* INT_STS1 IRQs */
> > > +	REGMAP_IRQ_REG(RK806_IRQ_REV0, 1, RK806_INT_STS_REV0),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_REV1, 1, RK806_INT_STS_REV1),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_REV2, 1, RK806_INT_STS_REV2),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_CRC_ERROR, 1, RK806_INT_STS_CRC_ERROR),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_SLP3_GPIO, 1, RK806_INT_STS_SLP3_GPIO),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_SLP2_GPIO, 1, RK806_INT_STS_SLP2_GPIO),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_SLP1_GPIO, 1, RK806_INT_STS_SLP1_GPIO),
> > > +	REGMAP_IRQ_REG(RK806_IRQ_WDT, 1, RK806_INT_STS_WDT),
> > > +};
> > > +
> > >  static const struct regmap_irq rk808_irqs[] = {
> > >  	/* INT_STS */
> > >  	[RK808_IRQ_VOUT_LO] = {
> > > @@ -422,6 +464,18 @@ static struct regmap_irq_chip rk805_irq_chip = {
> > >  	.init_ack_masked = true,
> > >  };
> > >  
> > > +static struct regmap_irq_chip rk806_irq_chip = {
> > > +	.name = "rk806",
> > > +	.irqs = rk806_irqs,
> > > +	.num_irqs = ARRAY_SIZE(rk806_irqs),
> > > +	.num_regs = 2,
> > > +	.irq_reg_stride = 2,
> > > +	.mask_base = RK806_INT_MSK0,
> > > +	.status_base = RK806_INT_STS0,
> > > +	.ack_base = RK806_INT_STS0,
> > > +	.init_ack_masked = true,
> > > +};
> > > +
> > >  static const struct regmap_irq_chip rk808_irq_chip = {
> > >  	.name = "rk808",
> > >  	.irqs = rk808_irqs,
> > > @@ -548,6 +602,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
> > >  	struct rk808 *rk808;
> > >  	const struct rk808_reg_data *pre_init_reg;
> > >  	const struct mfd_cell *cells;
> > > +	bool dual_support = false;
> > >  	int nr_pre_init_regs;
> > >  	int nr_cells;
> > >  	int ret;
> > > @@ -569,6 +624,14 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
> > >  		cells = rk805s;
> > >  		nr_cells = ARRAY_SIZE(rk805s);
> > >  		break;
> > > +	case RK806_ID:
> > > +		rk808->regmap_irq_chip = &rk806_irq_chip;
> > > +		pre_init_reg = rk806_pre_init_reg;
> > > +		nr_pre_init_regs = ARRAY_SIZE(rk806_pre_init_reg);
> > > +		cells = rk806s;
> > > +		nr_cells = ARRAY_SIZE(rk806s);
> > > +		dual_support = true;
> > > +		break;
> > >  	case RK808_ID:
> > >  		rk808->regmap_irq_chip = &rk808_irq_chip;
> > >  		pre_init_reg = rk808_pre_init_reg;
> > > @@ -602,7 +665,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
> > >  		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
> > >  
> > >  	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
> > > -				       IRQF_ONESHOT, -1,
> > > +				       IRQF_ONESHOT | (dual_support ? IRQF_SHARED : 0), -1,
> > 
> > Why not 'dual_support = IRQF_SHARED', then | it regardless?
> 
> Ack
> 
> > 
> > >  				       rk808->regmap_irq_chip, &rk808->irq_data);
> > >  	if (ret)
> > >  		return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
> > > @@ -617,7 +680,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
> > >  					     pre_init_reg[i].addr);
> > >  	}
> > >  
> > > -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > > +	ret = devm_mfd_add_devices(dev, dual_support ? PLATFORM_DEVID_AUTO : PLATFORM_DEVID_NONE,
> > 
> > Any reason why you can't use AUTO all the time?
> 
> That would change device names (and thus sysfs paths) for already
> supported devices. DEVID_AUTO appends a ".<number>" suffix compared
> to DEVID_NONE.

How about using cell->id instead of doing this little dance?

-- 
Lee Jones [李琼斯]
