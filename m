Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DA64942D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiLKMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07ABE34;
        Sun, 11 Dec 2022 04:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D3760DD7;
        Sun, 11 Dec 2022 12:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB61C433EF;
        Sun, 11 Dec 2022 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670761428;
        bh=DMIUDF1R8YcC0VPPgVsscgLi1wpfl+6VqhVo7DQ8L/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a2Aj4+SdNjpbeAxs4JmbygG21d4cKi6Ssi/1OfDZwNunOG0tiQt9a1/fTdY4Whkki
         hrgQdzozbAvgXUn+fCypcqmdBNzJl1MBWc2zqH/WOuZy9sNiCNR25ki/sBi3ny+jk1
         xtk7e9KQeGLBK+a1rKs3RbZXSrgB0m3cdBXN4UGd9nw/32Wnu8Sd013kGq5qwM7oir
         MjLw9Yivnkn18TRzzZgFltYPZg0U9sFHcEh4AkJO9Unqar0HHvPpkAqgrnLndq++oS
         X0VW4AWQuRVScHxkjCnpvsAiPrIKKy5bbz+wk9xGRqy/MzK9RDiKsYFqmTzsfQFPnx
         81rhFFsEAbbQA==
Date:   Sun, 11 Dec 2022 12:36:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     <outreachy@lists.linux.dev>, Lee Jones <lee@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Manish Narani <manish.narani@xilinx.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Ramona Bolboaca" <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] staging: drivers: mfd: Add MAX77541/MAX77540 PMIC
 Support
Message-ID: <20221211123639.5a607fce@jic23-huawei>
In-Reply-To: <20221207090906.5896-2-okan.sahin@analog.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
        <20221207090906.5896-2-okan.sahin@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 12:08:40 +0300
Okan Sahin <okan.sahin@analog.com> wrote:

> This patch adds MFD driver for MAX77541/MAX77540 to enable its sub
> devices.
> 
> The MAX77541 is a multi-function devices. It includes
> buck converter and ADC.
> 
> The MAX77540 is a high-efficiency buck converter
> with two 3A switching phases.
> 
> They have same regmap except for ADC part of MAX77541.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>

I'll try not to duplicate the points Andy has already made, but there
may be some overlap!

> ---
>  MAINTAINERS                  |   7 ++
>  drivers/mfd/Kconfig          |  13 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77541.c       | 236 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77541.h | 150 ++++++++++++++++++++++

Huh? It's not in staging, so just change the patch titles!

>  5 files changed, 407 insertions(+)
>  create mode 100644 drivers/mfd/max77541.c
>  create mode 100644 include/linux/mfd/max77541.h
> 
or MAX77620 and MAX20024 PMIC Support"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7ed3ef4a698c..bf21228f5742 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -161,6 +161,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
>  obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
>  
>  obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
> +obj-$(CONFIG_MFD_MAX77541)	+= max77541.o
>  obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
> diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
> new file mode 100644
> index 000000000000..97a2df3ce0b6
> --- /dev/null
> +++ b/drivers/mfd/max77541.c
> @@ -0,0 +1,236 @@

...


> +
> +static int max77541_pmic_setup(struct max77541_dev *me)
> +{
> +	struct regmap *regmap = me->regmap;
> +	struct device *dev = me->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = max77541_pmic_irq_init(me);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize IRQ\n");
> +
> +	ret = regmap_read(regmap, MAX77541_REG_INT_SRC, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(regmap, MAX77541_REG_TOPSYS_INT, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(regmap, MAX77541_REG_BUCK_INT, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_init_wakeup(dev, true);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to init wakeup\n");
> +
> +	switch (me->type) {
> +	case MAX77540:
once you've switched to using a chip_info structure instead this block just becomes

	return devm_mfd_add_devices(dev, -1, me->chip_info.devs, me->chip_info.num_devs,
				    NULL, 0, NULL);

> +		return devm_mfd_add_devices(dev, -1, max77540_devs, ARRAY_SIZE(max77540_devs),
> +					    NULL, 0, NULL);
> +	case MAX77541:
> +		return devm_mfd_add_devices(dev, -1, max77541_devs, ARRAY_SIZE(max77541_devs),
> +					    NULL, 0, NULL);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max77541_i2c_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *chip_id;
> +	struct max77541_dev *me;
> +	const void *chip_data;
> +
> +	me = devm_kzalloc(&client->dev, sizeof(*me), GFP_KERNEL);
> +	if (!me)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, me);
> +	me->dev = &client->dev;
> +	me->i2c = client;
> +
> +	chip_id = to_i2c_driver(client->dev.driver)->id_table;
> +
> +	chip_data = device_get_match_data(me->dev);
> +	if (!chip_data) {
> +		chip_data = (void *)i2c_match_id(chip_id, client)->driver_data;

Ah. This is why your enum doesn't have 0 in it. Solve that by using a poitner
to a chip_info structure rather than an enum value

> +		if (!chip_data)
> +			return dev_err_probe(me->dev, -ENODEV, "Unable to find device\n");

Message is rather misleading. More a case of unknown device.

> +	}
> +
> +	me->type = (enum dev_type)chip_data;
> +	me->regmap = devm_regmap_init_i2c(client, &max77541_regmap_config);
> +	if (IS_ERR(me->regmap))
> +		return dev_err_probe(me->dev,  PTR_ERR(me->regmap),
> +					"Failed to allocate register map\n");
> +
> +	return max77541_pmic_setup(me);
> +}
> +
> +static const struct of_device_id max77541_of_id[] = {
> +	{
> +		.compatible = "adi,max77540",
> +		.data = (void *)MAX77540,
> +	},
> +	{
> +		.compatible = "adi,max77541",
> +		.data = (void *)MAX77541,
> +	},
> +	{ /* sentinel */  }
> +};
> +MODULE_DEVICE_TABLE(of, max77541_of_id);
> +
> +static const struct i2c_device_id max77541_i2c_id[] = {
> +	{ "max77540", MAX77540 },
> +	{ "max77541", MAX77541 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max77541_i2c_id);
> +
> +static struct i2c_driver max77541_i2c_driver = {
> +	.driver = {
> +		.name = "max77541",
> +		.of_match_table = max77541_of_id,
> +	},
> +	.probe_new = max77541_i2c_probe,
> +	.id_table = max77541_i2c_id,
> +};
> +
> +module_i2c_driver(max77541_i2c_driver);
> +
> +MODULE_DESCRIPTION("MAX7740/MAX7741 MFD Driver");
> +MODULE_AUTHOR("Okan Sahin <okan.sahin@analog.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");

We almost never assign module versions any more.  They aren't useful
given we must maintain backwards compatibility of userspace interfaces anyway.

> diff --git a/include/linux/mfd/max77541.h b/include/linux/mfd/max77541.h
> new file mode 100644
> index 000000000000..6f2753300227
> --- /dev/null
> +++ b/include/linux/mfd/max77541.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __MAX77541_MFD_H__
> +#define __MAX77541_MFD_H__
> +
> +/*      REGISTERS       */
> +
> +/*      GLOBAL CONFIG1       */
> +#define MAX77541_REG_INT_SRC                    0x00
> +#define MAX77541_REG_INT_SRC_M                  0x01
> +#define MAX77541_REG_TOPSYS_INT                 0x02
> +#define MAX77541_REG_TOPSYS_INT_M               0x03
> +#define MAX77541_REG_TOPSYS_STAT                0x04
> +#define MAX77541_REG_DEVICE_CFG1                0x06
> +#define MAX77541_REG_DEVICE_CFG2                0x07
> +#define MAX77541_REG_TOPSYS_CFG                 0x08
> +#define MAX77541_REG_PROT_CFG                   0x09
> +#define MAX77541_REG_EN_CTRL                    0x0B
> +
> +/*      GLOBAL CONFIG2       */

Hmm.  A register called CFG1 is CONFIG2?
That's novel ;)


> +#define MAX77541_REG_GLB_CFG1                   0x11
> +
> +/*      BUCK CONFIG       */
> +#define MAX77541_REG_BUCK_INT                   0x20
> +#define MAX77541_REG_BUCK_INT_M                 0x21
> +#define MAX77541_REG_BUCK_STAT                  0x22
> +
> +/*      BUCK1       */
> +#define MAX77541_REG_M1_VOUT                    0x23
> +#define MAX77541_REG_M1_CFG1                    0x25
> +#define MAX77541_REG_M1_CFG2                    0x26
> +#define MAX77541_REG_M1_CFG3                    0x27
> +
> +/*      BUCK2       */
> +#define MAX77541_REG_M2_VOUT                    0x33
> +#define MAX77541_REG_M2_CFG1                    0x35
> +#define MAX77541_REG_M2_CFG2                    0x36
> +#define MAX77541_REG_M2_CFG3                    0x37
> +
> +#define MAX77541_REG_NOT_AVAILABLE              0xFF
> +
> +/* INTERRUPT MASKS*/
> +#define MAX77541_REG_INT_SRC_MASK               0x00
> +#define MAX77541_REG_TOPSYS_INT_MASK            0x00
> +#define MAX77541_REG_BUCK_INT_MASK              0x00
> +
> +/*BITS OF REGISTERS*/
> +
> +#define MAX77541_BIT_INT_SRC_TOPSYS             BIT(0)
> +#define MAX77541_BIT_INT_SRC_BUCK               BIT(1)
> +
> +#define MAX77541_BIT_TOPSYS_INT_TJ_120C         BIT(0)
> +#define MAX77541_BIT_TOPSYS_INT_TJ_140C         BIT(1)
> +#define MAX77541_BIT_TOPSYS_INT_TSHDN           BIT(2)
> +#define MAX77541_BIT_TOPSYS_INT_UVLO            BIT(3)
> +#define MAX77541_BIT_TOPSYS_INT_ALT_SWO         BIT(4)
> +#define MAX77541_BIT_TOPSYS_INT_EXT_FREQ_DET    BIT(5)
> +
> +#define MAX77541_BIT_BUCK_INT_M1_POK_FLT        BIT(0)
> +#define MAX77541_BIT_BUCK_INT_M2_POK_FLT        BIT(1)
> +#define MAX77541_BIT_BUCK_INT_M1_SCFLT          BIT(4)
> +#define MAX77541_BIT_BUCK_INT_M2_SCFLT          BIT(5)
> +
> +#define MAX77541_BITS_DEVICE_CFG1_SEL1_LATCH    GENMASK(4, 0)
> +#define MAX77541_BITS_DEVICE_CFG2_SEL2_LATCH    GENMASK(4, 0)
> +
> +#define MAX77541_BIT_TOPSYS_CFG_DIS_ALT_IN      BIT(0)
> +
> +#define MAX77541_BITS_PROT_CFG_POK_TO           GENMASK(1, 0)
> +#define MAX77541_BIT_PROT_CFG_EN_FTMON          BIT(2)
> +
> +#define MAX77541_BIT_M1_EN                      BIT(0)
> +#define MAX77541_BIT_M2_EN                      BIT(1)
> +#define MAX77541_BIT_M1_LPM                     BIT(4)
> +#define MAX77541_BIT_M2_LPM                     BIT(5)
> +
> +#define MAX77541_BITS_GLB_CFG1_SSTOP_SR         GENMASK(2, 0)

Naming of BITS is unusual for what I think is a field mask.
MSK or MASK is more common.  Cn use that for the single bit
fields as well.

> +#define MAX77541_BITS_GLB_CFG1_SSTRT_SR         GENMASK(5, 3)
> +
> +#define MAX77541_BITS_MX_VOUT                   GENMASK(7, 0)
> +
> +#define MAX77541_BITS_MX_CFG1_RU_SR             GENMASK(2, 0)
> +#define MAX77541_BITS_MX_CFG1_RD_SR             GENMASK(5, 3)
> +#define MAX77541_BITS_MX_CFG1_RNG               GENMASK(7, 6)
> +
> +#define MAX77541_BIT_MX_CFG2_FPWM               BIT(0)
> +#define MAX77541_BIT_MX_CFG2_FSREN              BIT(1)
> +#define MAX77541_BITS_MX_CFG2_SS_PAT            GENMASK(3, 2)
> +#define MAX77541_BITS_MX_CFG2_SS_FREQ           GENMASK(5, 4)
> +#define MAX77541_BITS_MX_CFG2_SS_ENV            GENMASK(7, 6)
> +
> +#define MAX77541_BITS_MX_CFG3_ILIM              GENMASK(1, 0)
> +#define MAX77541_BITS_MX_CFG3_FREQ              GENMASK(3, 2)
> +#define MAX77541_BIT_MX_CFG3_FTRAK              BIT(4)
> +#define MAX77541_BIT_MX_CFG3_RESRESH            BIT(5)
> +#define MAX77541_BIT_MX_CFG3_ADIS1              BIT(6)
> +#define MAX77541_BIT_MX_CFG3_ADIS100            BIT(7)
> +
> +#define MAX77541_MAX_REGULATORS 2
> +
> +/*      ADC       */
> +#define MAX77541_REG_ADC_INT                    0x70
> +#define MAX77541_REG_ADC_MSK                    0x71
> +
> +#define MAX77541_REG_ADC_DATA_CH1               0x72
> +#define MAX77541_REG_ADC_DATA_CH2               0x73
> +#define MAX77541_REG_ADC_DATA_CH3               0x74
> +#define MAX77541_REG_ADC_DATA_CH6               0x77
> +
> +#define MAX77541_BIT_ADC_INT_CH1_I              BIT(0)
> +#define MAX77541_BIT_ADC_INT_CH2_I              BIT(1)
> +#define MAX77541_BIT_ADC_INT_CH3_I              BIT(2)
> +#define MAX77541_BIT_ADC_INT_CH6_I              BIT(5)
> +
> +#define MAX77541_REGMAP_IRQ_REG(_mask)	\
> +	{ .mask = (_mask),  }

Define is longer than the code. Just use the code everywhere
you current use this macro.

> +
> +enum dev_type {
> +	MAX77540 = 1,
If you need to index from 1, add a comment on why.

> +	MAX77541 = 2,
> +};
> +
> +enum max77541_regulators {
> +	MAX77541_BUCK1 = 1,
> +	MAX77541_BUCK2,
> +};
> +
> +enum mx_range {

Prefix this with max77541
Also, probably better to introduce it in the patch where it is used.
For now I've no idea why we need a reserved value for example!

> +	LOW_RANGE,
> +	MID_RANGE,
> +	HIGH_RANGE,
> +	RESERVED
> +};
> +
> +struct max77541_dev {

> +	u8 type;

Rather than using an enum (incidentally the type of this should be a
named enum, not a u8) much better to define a
'chip info' structure that describes the different specific features of
each chip.  That approach ends up much more extensible as new devices
are added to the driver than a constant increase in switch statements.

> +};
> +
> +#endif /* __MAX77541_MFD_H__ */

