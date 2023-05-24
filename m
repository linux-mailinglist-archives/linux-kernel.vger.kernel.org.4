Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11F70F3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjEXKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjEXKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:01:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DFAEA7;
        Wed, 24 May 2023 03:01:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FE721042;
        Wed, 24 May 2023 03:01:56 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B2783F67D;
        Wed, 24 May 2023 03:01:07 -0700 (PDT)
Date:   Wed, 24 May 2023 11:01:05 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v1 1/4] iio: adc: Add Allwinner D1/T113s/R329 SoCs
 GPADC
Message-ID: <20230524110105.4928906c@donnerap.cambridge.arm.com>
In-Reply-To: <20230524082744.3215427-2-bigunclemax@gmail.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
        <20230524082744.3215427-2-bigunclemax@gmail.com>
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

On Wed, 24 May 2023 11:27:30 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maxim,

> The General Purpose ADC (GPADC) can convert the external signal into
> a certain proportion of digital value, to realize the measurement of
> analog signal, which can be applied to power detection and key detection.
> 
> D1, T113s and R329 contain this GPADC IP. The only difference between
> this SoCs is the number of available channels:
> 
>  T113 - 1 channel
>  D1   - 2 channels
>  R329 - 4 channels
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/iio/adc/Kconfig            |  10 ++
>  drivers/iio/adc/Makefile           |   1 +
>  drivers/iio/adc/sun20i-gpadc-iio.c | 275 +++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index eb2b09ef5d5b..988804f46bf6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1123,6 +1123,16 @@ config SUN4I_GPADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called sun4i-gpadc-iio.
>  
> +config SUN20I_GPADC
> +	tristate "Support for the Allwinner SoCs GPADC"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	help
> +	  Say yes here to build support for Allwinner (D1, T113 and R329) SoCs
> +	  GPADC. This ADC provides up to 4 channels.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sun20i-gpadc-iio.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index e07e4a3e6237..fc4ef71d5f8f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>  obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
> +obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
>  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>  obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
> new file mode 100644
> index 000000000000..90f3bb2e41cd
> --- /dev/null
> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPADC driver for sunxi platforms (D1, T113-S3 and R329)
> + * Copyright (c) 2023 Maksim Kiselev <bigunclemax@gmail.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +
> +#define SUN20I_GPADC_SR					0x00
> +
> +#define SUN20I_GPADC_CTRL				0x04
> +#define SUN20I_GPADC_CTRL_ADC_FIRST_DLY			((GENMASK(7, 0) & (x)) << 24)
> +#define SUN20I_GPADC_CTRL_ADC_AUTOCALI_EN		BIT(23)
> +#define SUN20I_GPADC_CTRL_ADC_OP_BIAS			((GENMASK(1, 0) & (x)) << 20)
> +#define SUN20I_GPADC_CTRL_WORK_MODE_SELECT(x)		((GENMASK(1, 0) & (x)) << 18)
> +#define SUN20I_GPADC_CTRL_ADC_CALI_EN			BIT(17)
> +#define SUN20I_GPADC_CTRL_ADC_EN			BIT(16)
> +
> +#define SUN20I_GPADC_CS_EN				0x08
> +#define SUN20I_GPADC_CS_EN_ADC_CHAN_CMP_EN(x)		((GENMASK(16, 0) & BIT(x)) << 16)
> +#define SUN20I_GPADC_CS_EN_ADC_CHAN_SELECT(x)		(GENMASK(16, 0) & BIT(x))
> +
> +#define SUN20I_GPADC_DATA_INTC				0x28
> +#define SUN20I_GPADC_DATA_INTC_CHAN_DATA_IRQ_EN(x)	(GENMASK(16, 0) & BIT(x))
> +
> +#define SUN20I_GPADC_DATA_INTS				0x38
> +#define SUN20I_GPADC_DATA_INTS_DATA_PENDING(x)		(GENMASK(16, 0) & BIT(x))
> +#define SUN20I_GPADC_DATA_INTS_DATA_PENDING_MASK	GENMASK(16, 0)
> +
> +#define SUN20I_GPADC_CHAN_DATA(x)			(0x80 + (x) * 4)
> +
> +#define SUN20I_GPADC_TIMEOUT				msecs_to_jiffies(100)
> +#define SUN20I_GPADC_MAX_CHANNELS			16
> +
> +struct sun20i_gpadc_configuration {
> +	const struct iio_chan_spec	*channels;
> +	u8				num_channels;
> +};
> +
> +struct sun20i_gpadc_iio {
> +	struct iio_dev			*indio_dev;
> +	struct regmap			*regmap;
> +	struct completion		completion;
> +	struct mutex			lock;
> +};
> +
> +#define SUN20I_GPADC_ADC_CHANNEL(_channel) {			\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec sun8i_t113_gpadc_channels[] = {
> +	SUN20I_GPADC_ADC_CHANNEL(0),
> +};
> +
> +static const struct iio_chan_spec sun20i_d1_gpadc_channels[] = {
> +	SUN20I_GPADC_ADC_CHANNEL(0),
> +	SUN20I_GPADC_ADC_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec sun50i_r329_gpadc_channels[] = {
> +	SUN20I_GPADC_ADC_CHANNEL(0),
> +	SUN20I_GPADC_ADC_CHANNEL(1),
> +	SUN20I_GPADC_ADC_CHANNEL(2),
> +	SUN20I_GPADC_ADC_CHANNEL(3),
> +};
> +
> +static const struct sun20i_gpadc_configuration sun20i_gpadc_config[] = {
> +	{ sun8i_t113_gpadc_channels, ARRAY_SIZE(sun8i_t113_gpadc_channels) },
> +	{ sun20i_d1_gpadc_channels, ARRAY_SIZE(sun20i_d1_gpadc_channels) },
> +	{ sun50i_r329_gpadc_channels, ARRAY_SIZE(sun50i_r329_gpadc_channels) },
> +};

It looks a bit odd to have an array here, when those are separate devices.
I think other drivers just spell those devices out, one by one:

static const struct sun20i_gpadc_configuration sun20i_d1_gpadc_config = {
	sun20i_d1_gpadc_channels, ARRAY_SIZE(sun20i_d1_gpadc_channels)
};
static const struct sun20i_gpadc_configuration sun8i_t113_gpadc_config = {
	sun8i_t113_gpadc_channels, ARRAY_SIZE(sun8i_t113_gpadc_channels)
};
....

Though I believe it would be easier to either allocate the required number
of channels at probe time, or just use one predefined array with four
channels (like the r329 version above), and then just register less for
the other SoCs, by just setting indio_dev->num_channels to the number read
from match_data.

Or we follow the other idea of reading the number of channels from a DT
property, which means we would already support every IP with up to 16
channels, without further driver changes in the future.

> +
> +static const struct regmap_config sun20i_gpadc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,
> +};

Is there any particular reason you chose a regmap to model this here?
Isn't that just straight-forward MMIO, which we could just drive using
readl()/writel()?

> +static int sun20i_gpadc_adc_read(struct sun20i_gpadc_iio *info,
> +				 struct iio_chan_spec const *chan, int *val)
> +{
> +	reinit_completion(&info->completion);
> +
> +	/* enable the analog input channel */
> +	regmap_write(info->regmap, SUN20I_GPADC_CS_EN,
> +		     SUN20I_GPADC_CS_EN_ADC_CHAN_SELECT(chan->channel));
> +
> +	/* enable the data irq for input channel */
> +	regmap_write(info->regmap, SUN20I_GPADC_DATA_INTC,
> +		     SUN20I_GPADC_DATA_INTC_CHAN_DATA_IRQ_EN(chan->channel));

I wonder if this should be either moved out to some multiplexer: the DT
bindings suggest that such a thing could be independent.
But at least we could cater for the possibility that this channel is
already selected, and skip this part then?

> +
> +	/* enable the ADC function */
> +	regmap_update_bits(info->regmap, SUN20I_GPADC_CTRL,
> +			   SUN20I_GPADC_CTRL_ADC_EN, SUN20I_GPADC_CTRL_ADC_EN);
> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 SUN20I_GPADC_TIMEOUT))
> +		return -ETIMEDOUT;
> +
> +	/* read the ADC data */
> +	regmap_read(info->regmap, SUN20I_GPADC_CHAN_DATA(chan->channel), val);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int sun20i_gpadc_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan, int *val,
> +				 int *val2, long mask)
> +{
> +	struct sun20i_gpadc_iio *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&info->lock);

Couldn't taking the lock go into the function? It seems to be only one
caller, and we need the lock in any case, it seems?

> +		ret = sun20i_gpadc_adc_read(info, chan, val);
> +		mutex_unlock(&info->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* 1800mV / 4096 * raw */
> +		*val = 0;
> +		*val2 = 439453125;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t sun20i_gpadc_irq_handler(int irq, void *data)
> +{
> +	struct sun20i_gpadc_iio *info = data;
> +	u32 reg;
> +
> +	/* clear data interrupt status register */
> +	regmap_read(info->regmap, SUN20I_GPADC_DATA_INTS, &reg);
> +	regmap_write(info->regmap, SUN20I_GPADC_DATA_INTS, reg);
> +
> +	complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info sun20i_gpadc_iio_info = {
> +	.read_raw = sun20i_gpadc_read_raw,
> +};
> +
> +static int sun20i_gpadc_probe(struct platform_device *pdev)
> +{
> +	const struct sun20i_gpadc_configuration *config;
> +	struct iio_dev *indio_dev;
> +	struct sun20i_gpadc_iio *info;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	struct clk *clk;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	mutex_init(&info->lock);
> +	init_completion(&info->completion);
> +
> +	info->indio_dev = indio_dev;
> +	indio_dev->info = &sun20i_gpadc_iio_info;
> +	indio_dev->name = dev_name(&pdev->dev);
> +
> +	config = of_device_get_match_data(&pdev->dev);
> +	if (!config)
> +		return -ENODEV;
> +
> +	/* Sanity check for possible later IP variants with more channels */
> +	if (config->num_channels > SUN20I_GPADC_MAX_CHANNELS)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "max channels exceeded\n");
> +
> +	indio_dev->channels = config->channels;
> +	indio_dev->num_channels = config->num_channels;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +					     &sun20i_gpadc_regmap_config);
> +	if (IS_ERR(info->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->regmap),
> +				     "failed to init regmap\n");
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +				     "failed to enable bus clock\n");
> +
> +	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
> +				     "failed to get reset control\n");
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				    "failed to deassert reset\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq, "failed to get irq\n");
> +
> +	ret = devm_request_irq(&pdev->dev, irq, sun20i_gpadc_irq_handler,
> +			       0, dev_name(&pdev->dev), info);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed requesting irq %d\n", irq);
> +
> +	/* set the single conversion mode and enable auto calibration*/
> +	regmap_write(info->regmap, SUN20I_GPADC_CTRL,
> +		     SUN20I_GPADC_CTRL_ADC_AUTOCALI_EN |
> +		     SUN20I_GPADC_CTRL_WORK_MODE_SELECT(0));
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not register the device\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun20i_gpadc_of_id[] = {
> +	{
> +		.compatible = "allwinner,sun8i-t113-gpadc",
> +		.data = &sun20i_gpadc_config[0],
> +	},
> +	{
> +		.compatible = "allwinner,sun20i-d1-gpadc",
> +		.data = &sun20i_d1_gpadc_channels[1]

Regardless of what I said above, this looks wrong?
Shouldn't that be read &sun20i_gpadc_config[1] here?

> +	},
> +	{
> +		.compatible = "allwinner,sun50i-r329-gpadc",
> +		.data = &sun50i_r329_gpadc_channels[2]

Same as above.

Cheers,
Andre


> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);
> +
> +static struct platform_driver sun20i_gpadc_driver = {
> +	.driver = {
> +		.name = "sun20i-gpadc-iio",
> +		.of_match_table = sun20i_gpadc_of_id,
> +	},
> +	.probe = sun20i_gpadc_probe,
> +};
> +module_platform_driver(sun20i_gpadc_driver);
> +
> +MODULE_DESCRIPTION("ADC driver for sunxi platforms");
> +MODULE_AUTHOR("Maksim Kiselev <bigunclemax@gmail.com>");
> +MODULE_LICENSE("GPL");

