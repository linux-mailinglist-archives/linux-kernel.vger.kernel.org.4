Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586C06F31CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjEAOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAOEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:04:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E01B7;
        Mon,  1 May 2023 07:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D67C60FF8;
        Mon,  1 May 2023 14:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF21C433EF;
        Mon,  1 May 2023 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682949870;
        bh=78yIab+V+s8o+3/mj4WPzECXpgFCyjANFazcqVYmfE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fwSHeg2YshTX9LP7STk7OdWzp07m6aTRUMD2C5mNtrO2o+8f3XvLgrY/3JzMTtkWv
         ZX/mvho332fst4H87rvKhkHVNVhUWXoQztgDtho6xJSWYT/gAeivVdDZjwR81fpGtw
         SCqLDi+XNu6cBHd/Acv6gHARm5Xd9yh5CaK9Rczs8d8/Xa6QkzRY3PxVZA615yZFaC
         4cQ6ku3Q7GrfJ5I/w3X6vvPQU1+7u8EUsn5ImXu3F28n64+ZsIXYXPGaYMcR+qTP1U
         KI0T8Gc+7AeYfkM1GWEYCDIDGaGfoB3gQgokPKmH8zYtqKhMbwmAKmGI8qjD05rnco
         sR8QPlPa9K08Q==
Date:   Mon, 1 May 2023 15:20:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230501152014.7789aa42@jic23-huawei>
In-Reply-To: <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
        <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 11:08:17 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> Add initial support for the ROHM BU27008 color sensor.
>  - raw_read() of RGB and clear channels
>  - triggered buffer w/ DRDY interrtupt
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

Mostly trivial stuff, but some confusion has occurred with respect to the
two interrupts involve in an IIO trigger.  Specifically the pollfunc stuff
occurs on the downward side of the irqchip that hides on the consumer side
of an IIO trigger) and is set up by devm_iio_trigered_buffer_setup() not
of the interrupt that calls iio_trigger_poll[_nested]()

Jonathan

> 
> ---
> Revision history
> v2 => v3:
>  - drop bits.h
>  - drop unnecessary comma after compatible
>  - Styling / cleaning
>  - Simplify sleep time computation
>  - rename bu27008_get_int_time() => bu27008_get_int_time_us()
> 
> v1 => v2:
> - Fix buffered data demuxing
> - Use generic trigger functions instead of rolling own ones
> - Drop unnecessary locking
> - Use generic iio_validate_own_trigger()
> - Some other more trivial fixes for review comments
> - use defines for [enable/disable] [measurement/data-ready IRQ] reg values
>   and use regmap_update_bits() directly instead of regamap_[set/clear]_bits()
> ---
>  drivers/iio/light/Kconfig        |  14 +
>  drivers/iio/light/Makefile       |   1 +
>  drivers/iio/light/rohm-bu27008.c | 963 +++++++++++++++++++++++++++++++
>  3 files changed, 978 insertions(+)
>  create mode 100644 drivers/iio/light/rohm-bu27008.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 6fa31fcd71a1..7888fc439b2f 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -289,6 +289,20 @@ config JSA1212
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called jsa1212.
>  
> +config ROHM_BU27008
> +	tristate "ROHM BU27008 color (RGB+C/IR) sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_GTS_HELPER
> +	help
> +	  Enable support for the ROHM BU27008 color sensor.
> +	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,
> +	  blue, clear and IR) with four configurable channels. Red and
> +	  green being always available and two out of the rest three
> +	  (blue, clear, IR) can be selected to be simultaneously measured.
> +	  Typical application is adjusting LCD backlight of TVs,
> +	  mobile phones and tablet PCs.
> +
>  config ROHM_BU27034
>  	tristate "ROHM BU27034 ambient light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 985f6feaccd4..881173952301 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_NOA1305)		+= noa1305.o
>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_PA12203001)	+= pa12203001.o
>  obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o
> +obj-$(CONFIG_ROHM_BU27008)	+= rohm-bu27008.o

Numeric order in Makefile as well as Kconfig.

>  obj-$(CONFIG_RPR0521)		+= rpr0521.o
>  obj-$(CONFIG_SI1133)		+= si1133.o
>  obj-$(CONFIG_SI1145)		+= si1145.o
> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> new file mode 100644
> index 000000000000..2728e6d5a321
> --- /dev/null
> +++ b/drivers/iio/light/rohm-bu27008.c

> +
> +enum {
> +	BU27008_RED,	/* Always data0 */
> +	BU27008_GREEN,	/* Always data1 */
> +	BU27008_BLUE,	/* data2, configurable (blue / clear) */
> +	BU27008_CLEAR,	/* data2 or data3 */
> +	BU27008_IR,	/* data3 */
> +	BU27008_NUM_CHANS
> +};
> +
> +enum {
> +	BU27008_DATA0, /* Always RED */
> +	BU27008_DATA1, /* Always GREEN */
> +	BU27008_DATA2, /* Blue or Clear */
> +	BU27008_DATA3, /* IR or Clear */
> +	BU27008_NUM_HW_CHANS
> +};
> +
> +/* We can always measure red and green at same time */
> +#define ALWAYS_SCANNABLE (BIT(BU27008_RED) | BIT(BU27008_GREEN))
> +
> +/* We use these data channel configs. Ensure scan_masks below follow them too */
> +#define BU27008_BLUE2_CLEAR3		0x0 /* buffer is R, G, B, C */
> +#define BU27008_CLEAR2_IR3		0x1 /* buffer is R, G, C, IR */
> +#define BU27008_BLUE2_IR3		0x2 /* buffer is R, G, B, IR */
> +
> +static const unsigned long bu27008_scan_masks[] = {
> +	/* buffer is R, G, B, C */
> +	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_CLEAR),
> +	/* buffer is R, G, C, IR */
> +	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_IR),
> +	/* buffer is R, G, B, IR */
> +	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR),
> +	0
> +};


> +
> +static int bu27008_get_int_time_sel(struct bu27008_data *data, int *sel)
> +{
> +	int ret, val;
> +
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &val);
> +	*sel = FIELD_GET(BU27008_MASK_MEAS_MODE, val);
> +
> +	return ret;
> +}
> +
> +static int bu27008_set_int_time_sel(struct bu27008_data *data, int sel)
> +{
> +	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL1,
> +				  BU27008_MASK_MEAS_MODE, sel);
> +}
> +
> +static int bu27008_get_int_time_us(struct bu27008_data *data)
> +{
> +	int ret, sel;
> +
> +	ret = bu27008_get_int_time_sel(data, &sel);
> +	if (ret)
> +		return ret;
> +
> +	return iio_gts_find_int_time_by_sel(&data->gts,
> +					    sel & BU27008_MASK_MEAS_MODE);

sel already masked in bu27008_get_int_time_sel(). No point in doing it again
(was going to say use FIELD_GET() but then noticed you did above!)

> +}

> +
> +static int bu27008_try_find_new_time_gain(struct bu27008_data *data, int val,
> +					  int val2, int *gain_sel)
> +{
> +	/* Could not support new scale with existing int-time */

I'd move that above the function and change it to
	/* Called if the new scale could not be supported with existing int-time */
Down here it is not clear that this applies to the whole funciton.


> +	int i, ret, new_time_sel;
> +
> +	for (i = 0; i < data->gts.num_itime; i++) {
> +		new_time_sel = data->gts.itime_table[i].sel;
> +		ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
> +					new_time_sel, val, val2 * 1000, gain_sel);
> +		if (!ret)
> +			break;
> +	}
> +	if (i == data->gts.num_itime) {
> +		dev_err(data->dev, "Can't support scale %u %u\n", val,
> +			val2);

Line wrapping inconsistent.  I like short lines with appropriate flexibility where
longer ones are more readable. However, I am fairly sure this one fits under 80
chars as a single line.

> +
> +		return -EINVAL;
> +	}
> +
> +	return bu27008_set_int_time_sel(data, new_time_sel);
> +}
> +
> +static int bu27008_set_scale(struct bu27008_data *data,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2)
> +{
> +	int ret, gain_sel, time_sel;
> +
> +	if (chan->scan_index == BU27008_IR)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +
> +	ret = bu27008_get_int_time_sel(data, &time_sel);
> +	if (ret < 0)
> +		goto unlock_out;
> +
> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
> +						val, val2 * 1000, &gain_sel);
> +	if (ret)
> +		ret = bu27008_try_find_new_time_gain(data, val, val2, &gain_sel);

Obviously it is code that doesn't make any functional difference, but I'd prefer to see
	if (ret) {
		ret = bu27....
		if (ret)
			goto unlock_out;
	}
	ret = bu27008_write_gain_sel();

so that each error path is out of line, but the good path is the linear flow.

> +
> +	if (!ret)
> +		ret = bu27008_write_gain_sel(data, gain_sel);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bu27008_write_raw(struct iio_dev *idev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +	int ret;
> +
> +	/*
> +	 * We should not allow changing scale when measurement is ongoing.

"We should" is a statement of a desire, whereas here you want to say it
is prevented.

	 * Do not allow changing scale when measurement is ongoing as
	 * doing so could make values in the buffer inconsistent.
	 */

> +	 * This could make values in buffer inconsistent.
> +	 */
> +	ret = iio_device_claim_direct_mode(idev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = bu27008_set_scale(data, chan, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val)
> +			ret = -EINVAL;
> +		else
> +			ret = bu27008_try_set_int_time(data, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	iio_device_release_direct_mode(idev);
> +
> +	return ret;
> +}


> +static irqreturn_t bu27008_irq_thread_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct bu27008_data *data = iio_priv(idev);
> +
> +	iio_trigger_poll_nested(data->trig);

See below but this is what alerted me to something unusual.
It never makes sense to have iio_trigger_poll_nested() called unless
there is a check on whether it should be called!  If there isn't
iio_trigger_poll() in the top half is the right thing to do.

> +
> +	return IRQ_HANDLED;
> +}
> +


> +static int bu27008_probe(struct i2c_client *i2c)
> +{

...

> +
> +	if (i2c->irq) {
> +		ret = devm_iio_triggered_buffer_setup(dev, idev,
> +						      &iio_pollfunc_store_time,
> +						      bu27008_trigger_handler,
> +						      &bu27008_buffer_ops);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL\n");
> +
> +		itrig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d",
> +					       idev->name, iio_device_id(idev));
> +		if (!itrig)
> +			return -ENOMEM;
> +
> +		data->trig = itrig;
> +
> +		itrig->ops = &bu27008_trigger_ops;
> +		iio_trigger_set_drvdata(itrig, data);
> +
> +		name = devm_kasprintf(dev, GFP_KERNEL, "%s-bu27008",
> +				      dev_name(dev));
> +
> +		ret = devm_request_threaded_irq(dev, i2c->irq,
> +						iio_pollfunc_store_time,

This is on the wrong irq.  iio_pollfunc_store_time is used with the trigger not
here.  Basically what happens is the caller of iio_poll_trigger() fires the input
to a software irq chip that then signals all the of the downstream irqs (which
are the individual consumers of the triggers).  If that's triggered from the
top half / non threaded bit of the interrupt the iio_pollfunc_store_time()
will be called in that non threaded context before the individual threads
for the trigger consumer are started.

If there is nothing to do in the actual interrupt as it's a data ready
only signal, then you should just call iio_trigger_poll() in the top half and
use devm_request_irq() only as there is no thread in this interrupt (though
there is one for the interrupt below the software interrupt chip).


> +						&bu27008_irq_thread_handler,
> +						IRQF_ONESHOT, name, idev->pollfunc);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Could not request IRQ\n");
> +
> +
> +		ret = devm_iio_trigger_register(dev, itrig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Trigger registration failed\n");
> +	} else {
> +		dev_warn(dev, "No IRQ configured\n");

Why is it a warning?  Either driver works without an IRQ, or it doesn't.
dev_dbg() or dev_info() at most.

> +	}
> +
> +	ret = devm_iio_device_register(dev, idev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	return ret;
> +}

