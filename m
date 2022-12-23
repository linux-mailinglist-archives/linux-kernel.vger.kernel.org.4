Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657B265516B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiLWOeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLWOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:34:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33040824;
        Fri, 23 Dec 2022 06:34:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 738F76112A;
        Fri, 23 Dec 2022 14:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3612AC433EF;
        Fri, 23 Dec 2022 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671806050;
        bh=hUbV80B48WYrMpojH35bKsJ0Y0Ib9DymbvPqWacu3Hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fcD1M85aKE19b9StiMQFkuPLug0xSu9RM0uws2llOK0XSd1z1bZdRO+/WJR0NuAkX
         AoEuT38DFHBltp/ztqQ8MNZMAYARzJzYu2WpXaI1K2aWjYI+HreF6mhXw9PoERafzt
         GTgsccOlEYkgBfZFgoZsfa7snBVcFglnQVqlmDpfKtGYNryN7d7NNbaxe6pNno8TF9
         lQ9gEEwM2vbX3o1Y3tf2p565tQmBqHh32M1zGUZ1cuBot/0XgtObdpaN5rOfv3lLWF
         6C6t/mAPCk3lKuM3+1PHSt98qIqnjJrinsE1FdnU7uVZWh616YJbwvaEDYESdFnr2V
         K44OJwr+WbvqA==
Date:   Fri, 23 Dec 2022 14:47:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: adc: ti-ads7924: add ADS7924 driver
Message-ID: <20221223144719.79f2201b@jic23-huawei>
In-Reply-To: <20221222203610.2571287-3-hugo@hugovil.com>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-3-hugo@hugovil.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 15:36:09 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> digital converter (ADC) with an I2C interface.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hi Hugo,

Thanks for the driver. Some comments inline.
Given the various bits of support present, are you planning to follow up
with buffered support (chardev etc).

Jonathan

> ---
>  MAINTAINERS                  |   7 +
>  drivers/iio/adc/Kconfig      |  13 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads7924.c | 514 +++++++++++++++++++++++++++++++++++
>  4 files changed, 535 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads7924.c
>=20

...

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 235319546974..18adcd6200b0 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1207,6 +1207,19 @@ config TI_ADS1015
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1015.
> =20
> +config TI_ADS7924
> +	tristate "Texas Instruments ADS7924 ADC"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

No buffer support yet. So drop these for now.

> +	help
> +	  If you say yes here you get support for Texas Instruments ADS7924
> +	  4 channels, 12-bit I2C ADC chip.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads7924.
> +
>  config TI_ADS7950
>  	tristate "Texas Instruments ADS7950 ADC driver"
>  	depends on SPI && GPIOLIB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 6e08415c3f3a..1e5bdf47a091 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) +=3D ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) +=3D ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) +=3D ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) +=3D ti-ads1015.o
> +obj-$(CONFIG_TI_ADS7924) +=3D ti-ads7924.o
>  obj-$(CONFIG_TI_ADS7950) +=3D ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) +=3D ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) +=3D ti-ads8688.o
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> new file mode 100644
> index 000000000000..e9ca7a045d18
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -0,0 +1,514 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Texas Instruments ADS7924 ADC, 12-bit, 4-Channels, I2C
> + *
> + * iio/adc/ti-ads7924.c
> + * Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> + * Copyright 2022 DimOnOff
> + *
> + * based on iio/adc/ti-ads1015.c
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * Datasheets: https://www.ti.com/lit/gpn/ads7924
Add as a tag to the tag block of the patch description.

Datasheet: https://www.ti.com/lit/gpn/ads7924
on the line above your signoff.
There are some automated tools that will pick this up I think.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/i2c.h>
> +#include <linux/property.h>

hmm. you include property.h then use the of ones...

> +#include <linux/regmap.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>

Put this block in alphabetical order.

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/iio/sysfs.h>

Don't think that's used.  Normally only needed for custom attributes.

> +#include <linux/iio/buffer.h>

Not currently used.

> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define ADS7924_DRV_NAME "ads7924"
> +
> +#define ADS7924_CHANNELS 4
> +
> +/* Registers. */
> +#define ADS7924_MODECNTRL_REG	0x00
> +#define ADS7924_INTCNTRL_REG	0x01
> +#define ADS7924_DATA0_U_REG	0x02
> +#define ADS7924_DATA0_L_REG	0x03
> +#define ADS7924_DATA1_U_REG	0x04
> +#define ADS7924_DATA1_L_REG	0x05
> +#define ADS7924_DATA2_U_REG	0x06
> +#define ADS7924_DATA2_L_REG	0x07
> +#define ADS7924_DATA3_U_REG	0x08
> +#define ADS7924_DATA3_L_REG	0x09
> +#define ADS7924_ULR0_REG	0x0A
> +#define ADS7924_LLR0_REG	0x0B
> +#define ADS7924_ULR1_REG	0x0C
> +#define ADS7924_LLR1_REG	0x0D
> +#define ADS7924_ULR2_REG	0x0E
> +#define ADS7924_LLR2_REG	0x0F
> +#define ADS7924_ULR3_REG	0x10
> +#define ADS7924_LLR3_REG	0x11
> +#define ADS7924_INTCONFIG_REG	0x12
> +#define ADS7924_SLPCONFIG_REG	0x13
> +#define ADS7924_ACQCONFIG_REG	0x14
> +#define ADS7924_PWRCONFIG_REG	0x15
> +#define ADS7924_RESET_REG	0x16
> +

Comment syntax as below.

> +/* Register address INC bit: when set to '1', the register address is
> + * automatically incremented after every register read which allows conv=
enient
> + * reading of multiple registers. Set INC to '0' when reading a single r=
egister.
> + */
> +#define ADS7924_AUTO_INCREMENT_BIT	BIT(7)
> +
> +#define ADS7924_MODECNTRL_MODE_SHIFT	2
> +#define ADS7924_MODECNTRL_MODE_MASK	GENMASK(7, ADS7924_MODECNTRL_MODE_SH=
IFT)
> +
> +#define ADS7924_MODECNTRL_SEL_SHIFT	0

As below, don't provide a _SHIFT macro for any of these.
The MASK should be the only one needed as it implicitly contains the shift =
anyway.

> +#define ADS7924_MODECNTRL_SEL_MASK	GENMASK(1, ADS7924_MODECNTRL_SEL_SHIF=
T)
> +
> +#define ADS7924_CFG_INTPOL_BIT		1
> +#define ADS7924_CFG_INTTRIG_BIT		0
> +
> +#define ADS7924_CFG_INTPOL_MASK		BIT(ADS7924_CFG_INTPOL_BIT)
> +#define ADS7924_CFG_INTTRIG_MASK	BIT(ADS7924_CFG_INTTRIG_BIT)
> +
> +/* Interrupt pin polarity */
> +#define ADS7924_CFG_INTPOL_LOW		0
> +#define ADS7924_CFG_INTPOL_HIGH		1
> +
> +/* Interrupt pin signaling */
> +#define ADS7924_CFG_INTTRIG_LEVEL	0
> +#define ADS7924_CFG_INTTRIG_EDGE	1
> +
> +/* Mode control values */
> +#define ADS7924_MODECNTRL_IDLE			0x00
> +#define ADS7924_MODECNTRL_AWAKE			0x20
> +#define ADS7924_MODECNTRL_MANUAL_SINGLE		0x30
> +#define ADS7924_MODECNTRL_MANUAL_SCAN		0x32
> +#define ADS7924_MODECNTRL_AUTO_SINGLE		0x31
> +#define ADS7924_MODECNTRL_AUTO_SCAN		0x33
> +#define ADS7924_MODECNTRL_AUTO_SINGLE_SLEEP	0x39
> +#define ADS7924_MODECNTRL_AUTO_SCAN_SLEEP	0x3B
> +#define ADS7924_MODECNTRL_AUTO_BURST_SLEEP	0x3F
> +
> +#define ADS7924_ACQTIME_SHIFT	0
> +#define ADS7924_ACQTIME_MASK	GENMASK(4, ADS7924_ACQTIME_SHIFT)
> +
> +#define ADS7924_PWRUPTIME_SHIFT	0

No point in providing shift. The mask definition should always be sufficient
if using FIELD_GET / FIELD_PREP()

> +#define ADS7924_PWRUPTIME_MASK	GENMASK(4, ADS7924_PWRUPTIME_SHIFT)
> +
> +/* The power-up time is allowed to elapse whenever the device has been s=
hutdown
Comment syntax
/*
 * The power-up....

> + * in idle mode. Power-up time can allow external circuits, such as an
> + * operational amplifier, between the MUXOUT and ADCIN pins to turn on.
> + * The nominal time programmed by the PUTIME[4:0] register bits is given=
 by:
> + *     t PU =3D PWRUPTIME[4:0] =C3=97 2 =CE=BCs
> + * If a power-up time is not required, set the bits to '0' to effectivel=
y bypass.
> + */
> +#define ADS7924_PWRUPTIME_US 0 /* Bypass (0us). */
> +
> +/* Acquisition Time. Minimum is 6us. */
> +#define ADS7924_ACQTIME_US 6 /* Disable (6us). */

Disable?  Strange comment for something called acquisition time.

> +
> +/* The conversion time is always 4=CE=BCs and cannot be programmed by th=
e user. */
> +#define ADS7924_CONVTIME_US 4
> +
> +#define ADS7924_TOTAL_CONVTIME (ADS7924_PWRUPTIME_US + ADS7924_ACQTIME_U=
S + \
> +				ADS7924_CONVTIME_US)

Postfix this with _US as well.  It's good habit to put units in defines, so
do it everywhere it makes sense.

> +
> +#define ADS7924_SLEEP_DELAY_MS		2000
> +
> +enum ads7924_channels {
> +	ADS7924_CH0,
> +	ADS7924_CH1,
> +	ADS7924_CH2,
> +	ADS7924_CH3,
> +	ADS7924_TIMESTAMP,
> +};
> +
> +#define ADS7924_V_CHAN(_chan, _addr) {				\
> +	.type =3D IIO_VOLTAGE,					\
> +	.indexed =3D 1,						\
> +	.address =3D _addr,					\
> +	.channel =3D _chan,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), 		\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
> +	.scan_index =3D _addr,					\
> +	.scan_type =3D {						\
> +		.sign =3D 's',					\
> +		.realbits =3D 12,					\

You are using the shift element which is fine, but I think the majority of =
this
isn't yet used as no buffer support. As such, I'd drop anything you aren't
using for now. Add it back if you add buffered support in future.

> +		.storagebits =3D 16,				\
> +		.shift =3D 4,					\
> +		.endianness =3D IIO_CPU,				\

It's big endian off the devices, so that's how you should present it
to userspace via a buffered interface (this scan_type entry has no
standard meaning except for buffered interfaces).

> +	},							\
> +	.datasheet_name =3D "AIN"#_chan,				\
> +}
> +
> +/* To map a channel with its corresponding data register (MSB). */
> +static const unsigned int ads7924_channel_data_msb_regs[] =3D {
> +	ADS7924_DATA0_U_REG,
> +	ADS7924_DATA1_U_REG,
> +	ADS7924_DATA2_U_REG,
> +	ADS7924_DATA3_U_REG

It's possible this driver might one day support more elements in here (maybe
there is an 8 channel otherwise compatible part), so add a trailing comma.

Generally the only time we don't ask for trailing commas is after NULL term=
inators
or other entries that will by definition always be the last element.

> +};
> +


> +static const struct iio_chan_spec ads7924_channels[] =3D {
> +	ADS7924_V_CHAN(0, ADS7924_CH0),
> +	ADS7924_V_CHAN(1, ADS7924_CH1),
> +	ADS7924_V_CHAN(2, ADS7924_CH2),
> +	ADS7924_V_CHAN(3, ADS7924_CH3),
> +	IIO_CHAN_SOFT_TIMESTAMP(ADS7924_TIMESTAMP),

Timestamp doesn't do anything useful until you support buffered modes.
So drop it for now.

> +};
> +
> +static
> +int ads7924_get_adc_result(struct ads7924_data *data, int chan, int *val)
> +{
> +	int ret;
> +	__be16 be_val;
> +
> +	if (chan < 0 || chan >=3D ADS7924_CHANNELS)
> +		return -EINVAL;
> +
> +	if (data->conv_invalid) {
> +		int conv_time;
> +
> +		conv_time =3D ADS7924_TOTAL_CONVTIME;
> +		/* Allow 10% for internal clock inaccuracy. */
> +		conv_time +=3D conv_time / 10;
> +		usleep_range(conv_time, conv_time + 1);
> +		data->conv_invalid =3D false;
> +	}
> +
> +	ret =3D regmap_raw_read(data->regmap, ADS7924_AUTO_INCREMENT_BIT |
> +			      ads7924_channel_data_msb_regs[chan],
> +			      &be_val, sizeof(be_val));
> +	if (ret)
> +		return ret;
> +
> +	*val =3D be16_to_cpu(be_val);
> +	*val =3D *val >> ads7924_channels[chan].scan_type.shift;
> +
> +	return ret;
> +}
> +
> +static int ads7924_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret, vref_uv;
> +	struct ads7924_data *data =3D iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			break;
> +
> +		ret =3D ads7924_get_adc_result(data, chan->address, val);
> +		if (ret < 0)

Check the error code after iio_device_release_direct / mutex_unlock()
That way you can return directly.

Note, if you add support later for buffered mode, taking a local lock
outside of claiming direct mode can deadlock.  You are better off
moving the mutex_lock/unlock inside iio_device_claim_direct_mode()

As a side note, iio_device_claim_direct_mode() only does something useful
if you are supporting buffered mode... So for now it shouldn't really
be in this driver at all.  The point of that call is protect against
transitions into buffered modes whilst a call is flight that might
make a mess of that transition or be affected by it.

> +			dev_dbg(data->dev, "%s error1\n", __func__);
> +		else
> +			ret =3D IIO_VAL_INT;
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		break;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		vref_uv =3D regulator_get_voltage(data->vref_reg);
> +		if (vref_uv < 0) {
> +			/* dummy regulator "get_voltage" returns -EINVAL */
> +			ret =3D -EINVAL;
> +		} else {
> +			*val =3D  vref_uv / 1000; /* Convert reg voltage to mV */
> +			*val2 =3D chan->scan_type.realbits; /* Data bits */
> +			ret =3D IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&data->lock);

You only need the lock for the INFO_RAW switch branch as far as I can see.
Hence good to reduce it's scope to just that.  It may make sense to factor
out the code there to a separate function to simplify the error paths
(a goto out of a switch is a bit nasty to read)

> +
> +	return ret;
> +}
> +
> +static const struct iio_info ads7924_info =3D {
> +	.read_raw	=3D ads7924_read_raw,
> +};
> +
> +static int ads7924_of_parse_channel_config(struct iio_dev *indio_dev,
> +					   struct device_node *np)
> +{
> +	struct ads7924_data *priv =3D iio_priv(indio_dev);
> +	struct device *dev =3D priv->dev;
> +	struct device_node *child;
> +	int num_channels;
> +	unsigned int channel =3D 0;
> +	int ret;
> +
> +	num_channels =3D of_get_available_child_count(np);

As mentioned below, this should be changed to use the generic firmware
property accessors in include/linux/property.h
Amongst other things that lets us use the driver with various software
added properties (e.g. if it's on a daughter board etc) or via ACPI
and the PRP0001 magic ID.

> +	if (!num_channels) {
> +		dev_err(dev, "no channel children\n");
> +		return -ENODEV;
> +	}
> +	dev_dbg(dev, "found %d ADC channels\n", num_channels);
> +
> +	for_each_available_child_of_node(np, child) {
> +		ret =3D of_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			goto err;
> +
> +		if (channel >=3D ADS7924_CHANNELS) {
> +			dev_err(dev, "invalid channel index %d\n", channel);
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +err:
> +	of_node_put(child);
> +
> +	return ret;
> +}
> +
> +static int ads7924_set_conv_mode(struct ads7924_data *data, int mode)
> +{
> +	/* When switching between modes, be sure to first select the Awake mode

IIO comment syntax is the most common one in kernel code (a few exceptions =
exist
for historical reasons).  Anyhow.

	/*
	 * When switching...
	 * ...
	 */

> +	 * and then switch to the desired mode. This procedure ensures the
> +	 * internal control logic is properly synchronized.
> +	 */
> +	if (mode !=3D ADS7924_MODECNTRL_IDLE) {
> +		int ret;
> +
> +		ret =3D regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> +					 ADS7924_MODECNTRL_MODE_MASK,
> +					 ADS7924_MODECNTRL_AWAKE <<
> +					 ADS7924_MODECNTRL_MODE_SHIFT);
Use FIELD_PREP()

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> +				  ADS7924_MODECNTRL_MODE_MASK,
> +				  mode << ADS7924_MODECNTRL_MODE_SHIFT);
> +}

...

> +
> +static int ads7924_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads7924_data *data;
> +	struct device *dev =3D &client->dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);

Once you've dropped remove after taking all the calls dev managed
you can drop this as I don't think it's used elswhere.

> +
> +	data =3D iio_priv(indio_dev);
> +
> +	data->dev =3D dev;
> +
> +	/* Initialize the reset GPIO as output with an initial value of 0. */
> +	data->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LO=
W);
> +	if (IS_ERR(data->reset_gpio))
> +		return PTR_ERR(data->reset_gpio);
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name =3D ADS7924_DRV_NAME;

I'd rather see the string here. There is no particular reason why it should
be the driver name.

> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels =3D ads7924_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(ads7924_channels);
> +	indio_dev->info =3D &ads7924_info;
> +
> +	ret =3D ads7924_of_parse_channel_config(indio_dev, dev->of_node);

We shouldn't see device tree specific handling in a modern driver.
Use the generic accessors in include/linux/property.h

> +	if (ret < 0)
> +		return ret;
> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &ads7924_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "Failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	data->vref_reg =3D devm_regulator_get(dev, "vref");
> +	if (IS_ERR(data->vref_reg)) {
> +		dev_err(dev, "devm_regulator_get() failed\n");
> +		return PTR_ERR(data->vref_reg);

This is an example of a call that can defer so you should definitely
be using dev_err_probe() as we want the resulting debug info.
It's good practice to just use that everwhere in probe() functions.

> +	}
> +
> +	ret =3D regulator_enable(data->vref_reg);
> +	if (ret) {
> +		dev_err(dev, "regulator_enable() failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, ads7924_reg_disable, data->vref_r=
eg);
> +	if (ret) {
> +		dev_err(dev, "devm_add_action_or_reset() failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D ads7924_reset(indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to reset device\n");
> +		return ret;
> +	}
> +
> +	ret =3D ads7924_set_conv_mode(data,
> +				    ADS7924_MODECNTRL_AUTO_SCAN);
> +	if (ret)
> +		return ret;

You set this, but whilst you have it set back to idle in remove()
you don't do that in the error paths for this function.
If you change to registering the switch to IDLE to a devm_add_action_or_res=
et()
callback then it will get automatically called in both paths.

> +
> +	/* Disable signal acquire time. */
> +	ret =3D regmap_update_bits(data->regmap, ADS7924_ACQCONFIG_REG,
> +				 ADS7924_ACQTIME_MASK, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Disable signal acquire time failed\n");
> +		return ret;
> +	}
> +
> +	/* Disable power-up time. */
> +	ret =3D regmap_update_bits(data->regmap, ADS7924_PWRCONFIG_REG,
> +				 ADS7924_PWRUPTIME_MASK, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Disable power-up time failed\n");
> +		return ret;
> +	}
> +
> +	data->conv_invalid =3D true;
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register IIO device\n");

For errors in probe function use the cleaner (and deferred probe aware)
		return dev_err_probe(dev, ret, "Failed to register IIO device\n");

Same for all other error messages in probe().

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ads7924_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct ads7924_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	iio_device_unregister(indio_dev);
Having made the changes suggested below, you can call devm_iio_device_regis=
ter()
and avoid need for this call.

> +
> +	ret =3D ads7924_set_conv_mode(data, ADS7924_MODECNTRL_IDLE);

I would suggest wrapping this call up in a callback registered
with devm_add_action_or_reset()  That will allow you to
drop the remove function entirely. It also simplifies error handling.

> +	if (ret)
> +		dev_warn(&client->dev, "Failed to power down (%pe)\n",
> +			 ERR_PTR(ret));
> +}
> +
> +static const struct of_device_id ads7924_of_match[] =3D {

strange though it may seem, you also need the legacy
i2c_device_id table. There are a couple of reasons why:

1) It's the table used to generate the  module aliases to make
   autoprobing of the module used (there was an attempt to do that
   via the of_device_id table, but for a reason I can't remember it
   didn't work out.
2) There are fun routes via which that old school table is still used.

Hence for now we are in the slightly silly position of having to provide
both.

> +	{ .compatible =3D "ti,ads7924", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ads7924_of_match);
> +
> +static struct i2c_driver ads7924_driver =3D {
> +	.driver =3D {
> +		.name =3D ADS7924_DRV_NAME,
With the other use inline, just put the string here as well.
Saves a reviewer having to check the define is reasonable.

> +		.of_match_table =3D ads7924_of_match,
> +	},
> +	.probe_new	=3D ads7924_probe,
> +	.remove		=3D ads7924_remove,
> +};
> +
> +module_i2c_driver(ads7924_driver);
> +
> +MODULE_AUTHOR("Hugo Villeneuve <hvilleneuve@dimonoff.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADS7924 ADC I2C driver");
> +MODULE_LICENSE("GPL");

