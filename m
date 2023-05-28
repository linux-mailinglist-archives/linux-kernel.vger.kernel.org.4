Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15D77140FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjE1W24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjE1W2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:28:54 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD68BD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 15:28:51 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 0366b633-fda7-11ed-a9de-005056bdf889;
        Mon, 29 May 2023 01:28:48 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 01:28:47 +0300
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <ZHPVn4xzErSZfqVy@surfacebook>
References: <ZGNpZM137jF5yzie@arbad>
 <ZGNp3SqyOJeEcLsj@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGNp3SqyOJeEcLsj@arbad>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 16, 2023 at 01:32:45PM +0200, Andreas Klinger kirjoitti:
> Honeywell mprls0025pa is a series of pressure sensors.
> 
> Add initial I2C support.
> 
> Note:
> - IIO buffered mode is supported
> - SPI mode is not supported

...

> + * Data sheet:

Datasheet

> + *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
> + *    products/sensors/pressure-sensors/board-mount-pressure-sensors/
> + *    micropressure-mpr-series/documents/
> + *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf

Is it URL? Can we have it clickable, i.e. unwrapped?

...

Missing bits.h

> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/units.h>

...

> +/*
> + * support _RAW sysfs interface:

Support

> + *
> + * Calculation formula from the datasheet:
> + * pressure = (press_cnt - outputmin) * scale + pmin
> + * with:
> + * * pressure	- measured pressure in Pascal
> + * * press_cnt	- raw value read from sensor
> + * * pmin	- minimum pressure range value of sensor (data->pmin)
> + * * pmax	- maximum pressure range value of sensor (data->pmax)
> + * * outputmin	- minimum numerical range raw value delivered by sensor
> + *						(mpr_func_spec.output_min)
> + * * outputmax	- maximum numerical range raw value delivered by sensor
> + *						(mpr_func_spec.output_max)
> + * * scale	- (pmax - pmin) / (outputmax - outputmin)
> + *
> + * formula of the userspace:
> + * pressure = (raw + offset) * scale
> + *
> + * Values given to the userspace in sysfs interface:
> + * * raw	- press_cnt
> + * * offset	- (-1 * outputmin) - pmin / scale
> + *                note: With all sensors from the datasheet pmin = 0
> + *                which reduces the offset to (-1 * outputmin)
> + */

...

> +/*
> + * transfer function A: 10%   to 90%   of 2^24
> + * transfer function B:  2.5% to 22.5% of 2^24
> + * transfer function C: 20%   to 80%   of 2^24
> + */

Kernel doc?

> +enum mpr_func_id {
> +	MPR_FUNCTION_A,
> +	MPR_FUNCTION_B,
> +	MPR_FUNCTION_C,
> +};

...

> +struct mpr_func_spec {
> +	u32			output_min;
> +	u32			output_max;
> +};

Can the linear_range.h be used for this?

...

> +struct mpr_data {
> +	struct i2c_client	*client;
> +	struct mutex		lock;		/*
> +						 * access to device during read
> +						 */
> +	u32			pmin;		/* minimal pressure in pascal */
> +	u32			pmax;		/* maximal pressure in pascal */
> +	enum mpr_func_id	function;	/* transfer function */
> +	u32			outmin;		/*
> +						 * minimal numerical range raw
> +						 * value from sensor
> +						 */
> +	u32			outmax;		/*
> +						 * maximal numerical range raw
> +						 * value from sensor
> +						 */
> +	int                     scale;          /* int part of scale */
> +	int                     scale2;         /* nano part of scale */
> +	int                     offset;         /* int part of offset */
> +	int                     offset2;        /* nano part of offset */
> +	struct gpio_desc	*gpiod_reset;	/* reset */
> +	int			irq;		/*
> +						 * end of conversion irq;
> +						 * used to distinguish between
> +						 * irq mode and reading in a
> +						 * loop until data is ready
> +						 */
> +	struct completion	completion;	/* handshake from irq to read */
> +	struct mpr_chan		chan;		/*
> +						 * channel values for buffered
> +						 * mode
> +						 */

Why not kernel doc?

> +};

...

> +static void mpr_reset(struct mpr_data *data)
> +{
> +	if (data->gpiod_reset) {

Actually this dups gpiod_*() checks, so only needed by udelay(). 

> +		gpiod_set_value(data->gpiod_reset, 0);
> +		udelay(10);
> +		gpiod_set_value(data->gpiod_reset, 1);

Why not sleeping for all of them?

> +	}
> +}

...

> +	if (ret != sizeof(wdata)) {
> +		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
> +							(u32)sizeof(wdata));

Casting? Use proper specifier, i.e. %zu.

> +		return -EIO;
> +	}

...

> +		/* wait until status indicates data is ready */
> +		for (i = 0; i < nloops; i++) {
> +			/*
> +			 * datasheet only says to wait at least 5 ms for the

Datasheet

> +			 * data but leave the maximum response time open
> +			 * --> let's try it nloops (10) times which seems to be
> +			 *     quite long
> +			 */
> +			usleep_range(5000, 10000);
> +			status = i2c_smbus_read_byte(data->client);
> +			if (status < 0) {
> +				dev_err(dev,
> +					"error while reading, status: %d\n",
> +					status);
> +				return status;
> +			}
> +			if (!(status & MPR_I2C_BUSY))
> +				break;
> +		}
> +		if (i == nloops) {
> +			dev_err(dev, "timeout while reading\n");
> +			return -ETIMEDOUT;
> +		}

iopoll.h provides a macro for this. Reduces codebase a lot in this case.

> +	}

...

> +		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
> +							(u32)sizeof(buf));

Use proper specifier.

...

> +	if (buf[0] & MPR_I2C_BUSY) {
> +		/*
> +		 * it should never be the case that status still indicates
> +		 * business
> +		 */
> +		dev_err(dev, "data still not ready: %08x\n", buf[0]);

Why 8? Is the buffer is of 32-bit values?

> +		return -ETIMEDOUT;
> +	}

...

> +err:

err_unlock:

> +	mutex_unlock(&data->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;

...

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM, "couldn't get iio_dev\n");

-ENOMEM shouldn't be without error message, we will get one in that case.

...

> +	if (dev_fwnode(dev)) {

Why not simply use defaults?

> +		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> +								&data->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmin-pascal could not be read\n");
> +		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> +								&data->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmax-pascal could not be read\n");
> +		ret = device_property_read_u32(dev,
> +				"honeywell,transfer-function", &data->function);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,transfer-function could not be read\n");
> +		if (data->function > MPR_FUNCTION_C)
> +			return dev_err_probe(dev, -EINVAL,

-ERANGE ?

> +				"honeywell,transfer-function %d invalid\n",
> +								data->function);
> +	} else {
> +		/* when loaded as i2c device we need to use default values */
> +		dev_notice(dev, "firmware node not found; using defaults\n");
> +		data->pmin = 0;
> +		data->pmax = 172369; /* 25 psi */
> +		data->function = MPR_FUNCTION_A;
> +	}

...

> +	/*
> +	 * multiply with NANO before dividing by scale and later divide by NANO

Multiply

> +	 * again.
> +	 */

...

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"iio triggered buffer setup failed\n");

One line?

...

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"unable to register iio device\n");

Ditto.

-- 
With Best Regards,
Andy Shevchenko


