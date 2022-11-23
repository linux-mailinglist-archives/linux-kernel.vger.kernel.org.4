Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAB636785
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiKWRph convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 12:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiKWRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:45:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739398FB09;
        Wed, 23 Nov 2022 09:45:32 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHT6v3bT1z67Mdh;
        Thu, 24 Nov 2022 01:45:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:45:30 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:45:29 +0000
Date:   Wed, 23 Nov 2022 17:45:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ciprian Regus <ciprian.regus@analog.com>
CC:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] drivers: iio: dac: Add AD5754 DAC driver
Message-ID: <20221123174528.00001207@Huawei.com>
In-Reply-To: <20221118172407.765423-3-ciprian.regus@analog.com>
References: <20221118172407.765423-1-ciprian.regus@analog.com>
        <20221118172407.765423-3-ciprian.regus@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 19:24:07 +0200
Ciprian Regus <ciprian.regus@analog.com> wrote:

> The AD5724/AD5734/AD5754 are quad, 12-/14-/16-bit, serial input, voltage
> output DACs. The devices operate from single-supply voltages from +4.5 V
> up to +16.5 V or dual-supply voltages from ±4.5 V up to ±16.5 V. The
> input coding is user-selectable twos complement or offset binary for a
> bipolar output (depending on the state of Pin BIN/2sComp), and straight
> binary for a unipolar output.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5724_5734_5754.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5722_5732_5752.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5724r_5734r_5754r.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5722R_5732R_5752R.pdf
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Hi Ciprian,

Took another look and found a few more things given you'll be spinning
again for the dt binding.

Only significant one is the handling of error returns form the optional regulator.

Jonathan

> diff --git a/drivers/iio/dac/ad5754.c b/drivers/iio/dac/ad5754.c
> new file mode 100644
> index 000000000000..81cfda2efa0f
> --- /dev/null
> +++ b/drivers/iio/dac/ad5754.c
> @@ -0,0 +1,672 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Analog Devices, Inc.
> + * Author: Ciprian Regus <ciprian.regus@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/linear_range.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define AD5754_INT_VREF_mV			2500
> +#define AD5754_FRAME_SIZE			3
> +#define AD5754_MAX_CHANNELS			4
> +#define AD5754_MAX_RESOLUTION			16
> +#define uV_PER_mV				1000
In common with units.h probably better to spell out than mix case
(as someone will come along and 'fix' this for you ;)

#define MICROVOLT_PER_MILLIVOLT

Or just use MICRO/MILLI inline from units.h and rely on compiler
work the maths out for you.


> +
> +static const struct iio_chan_spec ad5754_2_channels[2] = {
> +		AD5754_CHANNEL(0),
> +		AD5754_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec ad5754_4_channels[4] = {
> +		AD5754_CHANNEL(0),
> +		AD5754_CHANNEL(1),
> +		AD5754_CHANNEL(2),
> +		AD5754_CHANNEL(3),

Why the double tab for alignment of these?

> +};
..

> +
> +static int ad5754_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ad5754_state *st = context;
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->buff,
> +		.len = 3,
> +	};
> +
> +	st->buff[0] = reg;
> +	put_unaligned_be16(val, &st->buff[1]);
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);

spi_write()?
Same thing under the hood but slightly shorter code here.

> +};


> +
> +static int ad5754_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5754_state *st;
> +	int ret;
> +

> +
> +	st->vref_reg = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(st->vref_reg)) {

Subtle corner here.
The return may not indicate that vref was not provided, it might return
-EPROBEDEFER for example to indicate that we need to back off until
another driver is loaded.

As such, you need separate handling for -ENODEV (I think that's the return
for not specified) which is what you have here, and other error codes which
should be a probe failure via a dev_err_probe() to deal with the deferred case
debug info.

> +		if (!st->chip_info->internal_vref)
> +			return dev_err_probe(dev, PTR_ERR(st->vref_reg),
> +					     "Failed to get the vref regulator\n");
> +
> +		ret = regmap_update_bits(st->regmap,
> +					 AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +					 AD5754_INT_REF_MASK,
> +					 FIELD_PREP(AD5754_INT_REF_MASK, 1));
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(dev, ad5754_disable_int_ref, st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regulator_enable(st->vref_reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable the vref regulator\n");
> +
> +		ret = devm_add_action_or_reset(dev, ad5754_regulator_disable, st->vref_reg);
> +		if (ret)
> +			return ret;
> +	}
...

> +static const struct spi_device_id ad5754_id[] = {
> +	{ "ad5722", (kernel_ulong_t)&ad5754_chip_info_data[AD5722], },
> +	{ "ad5732", (kernel_ulong_t)&ad5754_chip_info_data[AD5732], },
> +	{ "ad5752", (kernel_ulong_t)&ad5754_chip_info_data[AD5752], },
> +	{ "ad5724", (kernel_ulong_t)&ad5754_chip_info_data[AD5724], },
> +	{ "ad5734", (kernel_ulong_t)&ad5754_chip_info_data[AD5734], },
> +	{ "ad5754", (kernel_ulong_t)&ad5754_chip_info_data[AD5754], },
> +	{ "ad5722r", (kernel_ulong_t)&ad5754_chip_info_data[AD5722R], },
> +	{ "ad5732r", (kernel_ulong_t)&ad5754_chip_info_data[AD5732R], },
> +	{ "ad5752r", (kernel_ulong_t)&ad5754_chip_info_data[AD5752R], },
> +	{ "ad5724r", (kernel_ulong_t)&ad5754_chip_info_data[AD5724R], },
> +	{ "ad5734r", (kernel_ulong_t)&ad5754_chip_info_data[AD5734R], },
> +	{ "ad5754r", (kernel_ulong_t)&ad5754_chip_info_data[AD5754R], },
> +	{}
> +};
> +
> +static const struct of_device_id ad5754_dt_id[] = {
> +	{
> +		.compatible = "adi,ad5722",
> +		.data = &ad5754_chip_info_data[AD5722],

Whatever order you end up with in the DT binding after Krzysztof's review
replicate here and for the spi_device_ids above.

> +	}, {
> +		.compatible = "adi,ad5732",
> +		.data = &ad5754_chip_info_data[AD5732],
> +	}, {
> +		.compatible = "adi,ad5752",
> +		.data = &ad5754_chip_info_data[AD5752],
> +	}, {
> +		.compatible = "adi,ad5724",
> +		.data = &ad5754_chip_info_data[AD5724],
> +	}, {
> +		.compatible = "adi,ad5734",
> +		.data = &ad5754_chip_info_data[AD5734],
> +	}, {
> +		.compatible = "adi,ad5754",
> +		.data = &ad5754_chip_info_data[AD5754],
> +	}, {
> +		.compatible = "adi,ad5722r",
> +		.data = &ad5754_chip_info_data[AD5722R],
> +	}, {
> +		.compatible = "adi,ad5732r",
> +		.data = &ad5754_chip_info_data[AD5732R],
> +	}, {
> +		.compatible = "adi,ad5752r",
> +		.data = &ad5754_chip_info_data[AD5752R],
> +	}, {
> +		.compatible = "adi,ad5724r",
> +		.data = &ad5754_chip_info_data[AD5724R],
> +	}, {
> +		.compatible = "adi,ad5734r",
> +		.data = &ad5754_chip_info_data[AD5734R],
> +	}, {
> +		.compatible = "adi,ad5754r",
> +		.data = &ad5754_chip_info_data[AD5754R],
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad5754_dt_id);

