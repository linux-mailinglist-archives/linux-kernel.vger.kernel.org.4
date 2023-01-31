Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7668284F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAaJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjAaJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:10:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D4474E1;
        Tue, 31 Jan 2023 01:08:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5fGP4mjFz68916;
        Tue, 31 Jan 2023 17:03:09 +0800 (CST)
Received: from localhost (10.45.154.62) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 09:06:46 +0000
Date:   Tue, 31 Jan 2023 09:06:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andreas Feldner <pelzi@flying-snail.de>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <harald@ccbib.org>
Subject: Re: [PATCH 1/2] iio: dht11: forked a driver version that polls
 sensor's signal from GPIO
Message-ID: <20230131090645.00006469@Huawei.com>
In-Reply-To: <Y9groXq2oI6lqFea@debian-qemu.internal.flying-snail.de>
References: <Y9groXq2oI6lqFea@debian-qemu.internal.flying-snail.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.154.62]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Mon, 30 Jan 2023 21:42:09 +0100
Andreas Feldner <pelzi@flying-snail.de> wrote:

> On a BananaPi M2 Zero, the existing, IRQ based dht11 driver is not working,
> but missing most IRQs. Following the hints in Harald Geyer's comments I
> tried to implement a version of the driver that is polling the GPIO
> sensor in a busy loop, not using IRQ altogether.
> 
> This version is actually working fair enough on this board, yielding a
> valid result at every 2 or 3 read attempts.
> 
> I used the "compatible" string to allow selection of the required driver.
> To select this forked driver, give compatible="dht11-poll" instead of
> compatible="dht11" in the device tree (overlay).
> 
> Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
Hi Andreas,

Whilst this is potentially interesting as a PoC, we aren't going to take
a second driver upstream for the same part.

So if this is going to go forwards it would need to be integrated with
the existing driver with selection via whether an IRQ is provided in DT.

However, a driver that only reads successfully after a few goes and relies
on rapidly polling is not something I'm keen on merging. Whether it works
at all will likely be dependent on the precise platform and what else is
running.

A few quick comments inline.

I've not looked at the algorithm so this is all more superficial stuff.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/Kconfig         |  10 +
>  drivers/iio/humidity/Makefile        |   1 +
>  drivers/iio/humidity/dht11_polling.c | 348 +++++++++++++++++++++++++++
>  3 files changed, 359 insertions(+)
>  create mode 100644 drivers/iio/humidity/dht11_polling.c
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 2de5494e7c22..7b06b06181d4 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -25,6 +25,16 @@ config DHT11
>  	  Other sensors should work as well as long as they speak the
>  	  same protocol.
>  
> +config DHT11_POLLING
> +	tristate "DHT11 (and compatible) sensors driver using polling"
> +	depends on GPIOLIB || COMPILE_TEST
> +	help
> +	  This driver supports reading data via a single GPIO line.
> +          This version does not require the line to generate

Odd alignment.

> +          interrupts. It is required to read DHT11/22 signals on
> +          some boards that fail to generate IRQ quickly enough.
> +          This driver is tested with DHT22 on a BananaPI M2 Zero.
> +
>  config HDC100X
>  	tristate "TI HDC100x relative humidity and temperature sensor"
>  	depends on I2C
> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> index f19ff3de97c5..908e5ecebb27 100644
> --- a/drivers/iio/humidity/Makefile
> +++ b/drivers/iio/humidity/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_AM2315) += am2315.o
>  obj-$(CONFIG_DHT11) += dht11.o
> +obj-$(CONFIG_DHT11_POLLING) += dht11_polling.o
>  obj-$(CONFIG_HDC100X) += hdc100x.o
>  obj-$(CONFIG_HDC2010) += hdc2010.o
>  obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
> diff --git a/drivers/iio/humidity/dht11_polling.c b/drivers/iio/humidity/dht11_polling.c
> new file mode 100644
> index 000000000000..ea41548144b0
> --- /dev/null
> +++ b/drivers/iio/humidity/dht11_polling.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DHT11/DHT22 polling version of the bit banging GPIO driver.
> + *
> + * Copyright (c) Andreas Feldner <pelzi@flying-snail.de>
> + * based on work Copyright (c) Harald Geyer <harald@ccbib.org>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/wait.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/timekeeping.h>

Strangely I ran into this one yesterday. Should include
linux/ktime.h to get linux/timekeeping.h otherwise you'll get
build errors on a few architectures.

> +
> +#include <linux/iio/iio.h>
> +
> +#define DRIVER_NAME	"dht11_poll"
> +
> +#define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
> +
> +#define DHT11_EDGES_PREAMBLE 2
> +#define DHT11_BITS_PER_READ 40
> +/*
> + * Note that when reading the sensor actually 84 edges are detected, but
> + * since the last edge is not significant, we only store 83:
> + */
> +#define DHT11_EDGES_PER_READ (2 * DHT11_BITS_PER_READ + \
> +			      DHT11_EDGES_PREAMBLE + 1)
> +
> +/*
> + * Data transmission timing:
> + * Data bits are encoded as pulse length (high time) on the data line.
> + * 0-bit: 22-30uS -- typically 26uS (AM2302)
> + * 1-bit: 68-75uS -- typically 70uS (AM2302)
> + * The actual timings also depend on the properties of the cable, with
> + * longer cables typically making pulses shorter.
> + *
> + * Our decoding depends on the time resolution of the system:
> + * timeres > 34uS ... don't know what a 1-tick pulse is
> + * 34uS > timeres > 30uS ... no problem (30kHz and 32kHz clocks)
> + * 30uS > timeres > 23uS ... don't know what a 2-tick pulse is
> + * timeres < 23uS ... no problem
> + *
> + * Luckily clocks in the 33-44kHz range are quite uncommon, so we can
> + * support most systems if the threshold for decoding a pulse as 1-bit
> + * is chosen carefully. If somebody really wants to support clocks around
> + * 40kHz, where this driver is most unreliable, there are two options.
> + * a) select an implementation using busy loop polling on those systems
> + * b) use the checksum to do some probabilistic decoding
> + */
> +#define DHT11_START_TRANSMISSION_MIN	18000  /* us */
> +#define DHT11_START_TRANSMISSION_MAX	20000  /* us */
> +#define DHT11_MIN_TIMERES	34000  /* ns */
> +#define DHT11_THRESHOLD		49000  /* ns */
> +#define DHT11_AMBIG_LOW		23000  /* ns */
> +#define DHT11_AMBIG_HIGH	30000  /* ns */
> +
> +struct dht11 {
> +	struct device			*dev;
> +
> +	struct gpio_desc		*gpiod;
> +
> +	bool				complete;
> +	/* The iio sysfs interface doesn't prevent concurrent reads: */
> +	struct mutex			lock;
> +
> +	s64				timestamp;
> +	int				temperature;
> +	int				humidity;
> +
> +	/* num_edges: -1 means "no transmission in progress" */
> +	int				num_edges;
> +	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];

spacing after {

> +};
> +
> +/*
> + * dht11_edges_print: show the data as actually received by the
> + *                    driver.
> + */
> +static void dht11_edges_print(struct dht11 *dht11)
> +{
> +	int i;
> +
> +	dev_dbg(dht11->dev, "%d edges detected:\n", dht11->num_edges);
> +	for (i = 1; i < dht11->num_edges; ++i) {
> +		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
> +			dht11->edges[i].ts - dht11->edges[i - 1].ts,
> +			dht11->edges[i - 1].value ? "high" : "low");
> +	}
> +}
> +
> +static unsigned char dht11_decode_byte(char *bits)
> +{
> +	unsigned char ret = 0;
> +	int i;
> +
> +	for (i = 0; i < 8; ++i) {
> +		ret <<= 1;
> +		if (bits[i])
> +			++ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int dht11_decode(struct dht11 *dht11, int offset)
> +{
> +	int i, t;
> +	char bits[DHT11_BITS_PER_READ];
> +	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
> +
> +	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
> +		t = dht11->edges[offset + 2 * i + 1].ts -
> +			dht11->edges[offset + 2 * i].ts;
> +		if (!dht11->edges[offset + 2 * i].value) {
> +			dev_info(dht11->dev,
> +				 "lost synchronisation at edge %d using offset %d\n",
> +				 offset + 2 * i, offset);
> +			return -EIO;
> +		}
> +		bits[i] = t > DHT11_THRESHOLD;
> +	}
> +
> +	hum_int = dht11_decode_byte(bits);
> +	hum_dec = dht11_decode_byte(&bits[8]);
> +	temp_int = dht11_decode_byte(&bits[16]);
> +	temp_dec = dht11_decode_byte(&bits[24]);
> +	checksum = dht11_decode_byte(&bits[32]);
> +
> +	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum) {
> +		dev_info(dht11->dev, "invalid checksum using offset %d\n", offset);
> +		return -EIO;
> +	}
> +
> +	dht11->timestamp = ktime_get_boottime_ns();
> +	if (hum_int < 4) {  /* DHT22: 100000 = (3*256+232)*100 */
> +		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
> +					((temp_int & 0x80) ? -100 : 100);
> +		dht11->humidity = ((hum_int << 8) + hum_dec) * 100;
> +	} else if (temp_dec == 0 && hum_dec == 0) {  /* DHT11 */
> +		dht11->temperature = temp_int * 1000;
> +		dht11->humidity = hum_int * 1000;
> +	} else {
> +		dev_err(dht11->dev,
> +			"Don't know how to decode data: %d %d %d %d\n",
> +			hum_int, hum_dec, temp_int, temp_dec);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * IRQ handler called on GPIO edges
> + */
> +static void dht11_handle_edge(struct dht11 *dht11, int value)
> +{
> +	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> +		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
> +		dht11->edges[dht11->num_edges++].value = value;
> +
> +		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
> +			dht11->complete = !0;
> +	}
> +}
> +
> +static int dht11_read_raw(struct iio_dev *iio_dev,
> +			  const struct iio_chan_spec *chan,
> +			  int *val, int *val2, long m)
> +{
> +	struct dht11 *dht11 = iio_priv(iio_dev);
> +	int ret, timeres, offset, value_prev, num_samples;
> +	u64 startstamp;
> +
> +	mutex_lock(&dht11->lock);
> +
> +	startstamp = ktime_get_boottime_ns();
> +	if (dht11->timestamp + DHT11_DATA_VALID_TIME < startstamp) {
> +		timeres = ktime_get_resolution_ns();
> +		dev_dbg(dht11->dev, "current timeresolution: %dns\n", timeres);
> +		if (timeres > DHT11_MIN_TIMERES) {
> +			dev_err(dht11->dev, "timeresolution %dns too low\n",
> +				timeres);
> +			/* In theory a better clock could become available
Comment syntax for IIO multiline comments is
			/*
			 * In theory...

> +			 * at some point ... and there is no error code
> +			 * that really fits better.

Hmm. I'd just error out without implying it's worth a retry.
Chances of better clock becoming available is low.
If you want to do this, do it at probe and defer probing perhaps.

> +			 */
> +			ret = -EAGAIN;
> +			goto err;
> +		}
> +		if (timeres > DHT11_AMBIG_LOW && timeres < DHT11_AMBIG_HIGH)
> +			dev_warn(dht11->dev,
> +				 "timeresolution: %dns - decoding ambiguous\n",
> +				 timeres);
> +
> +		dht11->complete = 0;
> +
> +		dht11->num_edges = 0;
> +		ret = gpiod_direction_output(dht11->gpiod, 0);
> +		if (ret)
> +			goto err;
> +		usleep_range(DHT11_START_TRANSMISSION_MIN,
> +			     DHT11_START_TRANSMISSION_MAX);
> +		value_prev = 0;
> +		ret = gpiod_direction_input(dht11->gpiod);
> +		if (ret)
> +			goto err;
> +
> +		num_samples = 0;
> +		while (!dht11->complete) {
> +			int value = gpiod_get_value_cansleep(dht11->gpiod);
> +
> +			if (value >= 0 && value != value_prev) {
> +				dht11_handle_edge(dht11, value);
> +				value_prev = value;
> +				num_samples = 1;
> +			} else if (value < 0) {
> +				ret = value;
> +				break;
> +			} else {
> +				num_samples++;
> +				if ((num_samples % 1000) == 0) {
> +					dev_warn(dht11->dev, "No edge detected during 1000 reads, aborting polling.\n");
> +					ret = -ETIMEDOUT;
> +					dht11_handle_edge(dht11, value);
> +					break;
> +				}
> +			}
> +		}
> +
> +		dht11_edges_print(dht11);
> +
> +		if (dht11->num_edges < 2 * DHT11_BITS_PER_READ) {
> +			dev_err(dht11->dev, "Only %d signal edges detected\n",
> +				dht11->num_edges);
> +			ret = -ETIMEDOUT;
> +		} else {
> +			/* there is a chance we only missed out the preamble! */
> +			ret = 0;
> +		}
> +		if (ret < 0)
> +			goto err;
> +
> +		offset = dht11->num_edges - 2 * DHT11_BITS_PER_READ;
> +
> +		for (; offset >= 0; offset--) {
> +			if (dht11->edges[offset].value)
> +				ret = dht11_decode(dht11, offset);
> +			else
> +				ret = -EIO;
> +			if (!ret)
> +				break;
> +		}
> +
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = IIO_VAL_INT;
> +	if (chan->type == IIO_TEMP)

Switch statement would be cleaner here even if more lines of code.

> +		*val = dht11->temperature;
> +	else if (chan->type == IIO_HUMIDITYRELATIVE)
> +		*val = dht11->humidity;
> +	else
> +		ret = -EINVAL;
> +err:
> +	dht11->num_edges = -1;
> +	mutex_unlock(&dht11->lock);
> +	return ret;
> +}
> +
> +static const struct iio_info dht11_iio_info = {
> +	.read_raw		= dht11_read_raw,
> +};
> +
> +static const struct iio_chan_spec dht11_chan_spec[] = {
> +	{ .type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), },
> +	{ .type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), }
> +};
> +
> +static const struct of_device_id dht11_dt_ids[] = {
> +	{ .compatible = "dht11-poll", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dht11_dt_ids);
> +
> +static int dht11_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dht11 *dht11;
> +	struct iio_dev *iio;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
> +	if (!iio) {
> +		dev_err(dev, "Failed to allocate IIO device\n");
> +		return -ENOMEM;
> +	}
> +
> +	dht11 = iio_priv(iio);
> +	dht11->dev = dev;
> +	dht11->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
> +	if (IS_ERR(dht11->gpiod))
> +		return PTR_ERR(dht11->gpiod);
> +
> +	dht11->timestamp = ktime_get_boottime_ns() - DHT11_DATA_VALID_TIME - 1;
> +	dht11->num_edges = -1;
> +
> +	platform_set_drvdata(pdev, iio);

Is this used?

> +
> +	dht11->complete = 0;
> +	mutex_init(&dht11->lock);
> +	iio->name = pdev->name;

Hard code the name here as it's easier than us figuring out what
this ends up as. 

> +	iio->info = &dht11_iio_info;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->channels = dht11_chan_spec;
> +	iio->num_channels = ARRAY_SIZE(dht11_chan_spec);
> +
> +	return devm_iio_device_register(dev, iio);
> +}
> +
> +static struct platform_driver dht11_driver = {
> +	.driver = {
> +		.name	= DRIVER_NAME,

Don't try to align values, it goes wrong far too often as drivers
are extended.  Also better to have the name directly here.


> +		.of_match_table = dht11_dt_ids,
> +	},
> +	.probe  = dht11_probe,
> +};
> +
> +module_platform_driver(dht11_driver);
> +
> +MODULE_AUTHOR("Andreas Feldner <pelzi@flying-snail.de>");
> +MODULE_DESCRIPTION("DHT11 polling humidity/temperature sensor driver");
> +MODULE_LICENSE("GPL v2");

