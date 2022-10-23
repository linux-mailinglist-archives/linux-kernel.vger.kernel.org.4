Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F9609280
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 13:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJWLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJWLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 07:42:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C13961DA4;
        Sun, 23 Oct 2022 04:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 048BBB80D63;
        Sun, 23 Oct 2022 11:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC64BC433D6;
        Sun, 23 Oct 2022 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666525363;
        bh=b/VcidjqnQGCq8a9FcswtbUyPavQK+ifWkADAVJe2b8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cb3h7brR1LUH1ltlF3LxCOpKf84pzdzOWPBLDBueK13qO7URM41ILSu+V6oRkC2vo
         m8OJriQBYPQoHD9V1rwK1kCvbDXJa+7PQ2338I0RgmUDEwMcMDg+wv1T9qKfujOUNc
         E8qjUwI9VZNSqZdOcsBLYZSUz33Hvzl2r36OQ0ylW0VXFGjhw9APgWIMt04wL6YVae
         +9ghb9Fxk3tfYgZ1bJME2B2TcmgnkOQT0mDrkAdOr8DKMMCPvw3bsOjeMXqjNV/2NB
         iA52CbqKHvcee52/c7NLPNCPkkQbdOC5hUI7anUlHj9PWm65BwdJLeTZkKa0fCt+aU
         lKNXgIBB/UQ3g==
Date:   Sun, 23 Oct 2022 12:43:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221023124316.239427a7@jic23-huawei>
In-Reply-To: <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
        <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 14:22:49 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g), and probably some other cool features.
> 
> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 
> Important things to be added include the double-tap, motion
> detection and wake-up as well as the runtime power management.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

A few things from me on this read through to add to those last few comments
from Andy.

Thanks,

Jonathan


> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> new file mode 100644
> index 000000000000..6510f8d62b85
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -0,0 +1,51 @@

> +
> +MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(KIONIX_ACCEL);
Not sure why I didn't noticed this before, but after various debates we
ended up prefixing namespaces to limit them to IIO. Also, there are other kionix
drivers already and may be more in future. Better to limit this to scope of this
driver, 

IIO_KX022A 

seems like a reaonsable choice.

> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> new file mode 100644
> index 000000000000..7fe3b0aba1fe
> --- /dev/null

> +
> +#define KX022A_ACCEL_CHAN(axis, index)						\
Trivial: Not always easy to spot odd alignment of \ in patches but in this case I doubt the
one above is in a sensible place wrt to the others!

> +{								\
> +	.type = IIO_ACCEL,					\
> +	.modified = 1,						\
> +	.channel2 = IIO_MOD_##axis,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.info_mask_shared_by_type_available =			\
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.ext_info = kx022a_ext_info,				\
> +	.address = KX022A_REG_##axis##OUT_L,			\
> +	.scan_index = index,					\
> +	.scan_type = {                                          \
> +		.sign = 's',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_LE,				\
> +	},							\
> +}
>
...

> +
> +static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> +			       bool irq)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u16 buffer[KX022A_FIFO_LENGTH * 3];
> +	uint64_t sample_period;
> +	int count, fifo_bytes;
> +	bool renable = false;
> +	int64_t tstamp;
> +	int ret, i;
> +
> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> +	if (ret) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	/* Let's not overflow if we for some reason get bogus value from i2c */
> +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> +
> +	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
> +		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> +
> +	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> +	if (!count)
> +		return 0;
> +
> +	/*
> +	 * If we are being called from IRQ handler we know the stored timestamp
> +	 * is fairly accurate for the last stored sample. Otherwise, if we are
> +	 * called as a result of a read operation from userspace and hence
> +	 * before the watermark interrupt was triggered, take a timestamp
> +	 * now. We can fall anywhere in between two samples so the error in this
> +	 * case is at most one sample period.
> +	 */
> +	if (!irq) {
> +		/*
> +		 * We need to have the IRQ disabled or we risk of messing-up
> +		 * the timestamps. If we are ran from IRQ, then the
> +		 * IRQF_ONESHOT has us covered - but if we are ran by the
> +		 * user-space read we need to disable the IRQ to be on a safe
> +		 * side. We do this usng synchronous disable so that if the
> +		 * IRQ thread is being ran on other CPU we wait for it to be
> +		 * finished.
> +		 */
> +		disable_irq(data->irq);
> +		renable = true;
> +
> +		data->old_timestamp = data->timestamp;
> +		data->timestamp = iio_get_time_ns(idev);
> +	}
> +
> +	/*
> +	 * Approximate timestamps for each of the sample based on the sampling
> +	 * frequency, timestamp for last sample and number of samples.
> +	 *
> +	 * We'd better not use the current bandwidth settings to compute the
> +	 * sample period. The real sample rate varies with the device and
> +	 * small variation adds when we store a large number of samples.
> +	 *
> +	 * To avoid this issue we compute the actual sample period ourselves
> +	 * based on the timestamp delta between the last two flush operations.
> +	 */
> +	if (data->old_timestamp) {
> +		sample_period = data->timestamp - data->old_timestamp;
> +		do_div(sample_period, count);
> +	} else {
> +		sample_period = data->odr_ns;
> +	}
> +	tstamp = data->timestamp - (count - 1) * sample_period;
> +
> +	if (samples && count > samples) {
> +		/*
> +		 * Here we leave some old samples to the buffer. We need to
> +		 * adjust the timestamp to match the first sample in the buffer
> +		 * or we will miscalculate the sample_period at next round.
> +		 */
> +		data->timestamp -= (count - samples) * sample_period;
> +		count = samples;
> +	}
> +
> +	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
> +	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
> +				buffer, fifo_bytes);
> +	if (ret)
> +		goto renable_out;
> +
> +	for (i = 0; i < count; i++) {
> +		u16 *sam = &buffer[i * 3];
> +		__le16 *chs;
> +		int bit;
> +
> +		chs = &data->scan.channels[0];
> +		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
> +			memcpy(&chs[bit], &sam[bit], sizeof(*chs));

Why memcpying from a u16 array to an __le16 array?
buffer should probably also be __le16  and then you can just use
an assignment rather than a memcpy

> +
> +		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> +
> +		tstamp += sample_period;
> +	}
> +
> +	ret = count;
> +
> +renable_out:
> +	if (renable)
> +		enable_irq(data->irq);
> +
> +	return ret;
> +}


> +int kx022a_probe_internal(struct device *dev)
> +{
> +	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> +	struct iio_trigger *indio_trig;
> +	struct fwnode_handle *fwnode;
> +	struct kx022a_data *data;
> +	struct regmap *regmap;
> +	unsigned int chip_id;
> +	struct iio_dev *idev;
> +	int ret, irq;
> +	char *name;
> +
> +	regmap = dev_get_regmap(dev, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "no regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(idev);
> +
> +	/*
> +	 * VDD is the analog and digital domain voltage supply and
> +	 * IO_VDD is the digital I/O voltage supply.
> +	 */
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> +
> +	if (chip_id != KX022A_ID) {
> +		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> +		return -EINVAL;
> +	}
> +
> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq > 0) {
> +		data->inc_reg = KX022A_REG_INC1;
> +		data->ien_reg = KX022A_REG_INC4;
> +
> +		if (fwnode_irq_get_byname(fwnode, "INT2") > 0)
> +			dev_warn(dev, "Only one IRQ supported\n");

Why?  If you get the both, only the first one will be used by the driver.
Not really worth warning about the lack of features... 

> +	} else {
> +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> +		if (irq <= 0)
> +			return dev_err_probe(dev, irq, "No suitable IRQ\n");
> +
> +		data->inc_reg = KX022A_REG_INC5;
> +		data->ien_reg = KX022A_REG_INC6;
> +	}
> +
> +	data->regmap = regmap;
> +	data->dev = dev;
> +	data->irq = irq;
> +	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
> +	mutex_init(&data->mutex);
> +
> +	idev->channels = kx022a_channels;
> +	idev->num_channels = ARRAY_SIZE(kx022a_channels);
> +	idev->name = "kx022-accel";
> +	idev->info = &kx022a_info;
> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	idev->available_scan_masks = kx022a_scan_masks;
> +
> +	/* Read the mounting matrix, if present */
> +	ret = iio_read_mount_matrix(dev, &data->orientation);
> +	if (ret)
> +		return ret;
> +
> +	/* The sensor must be turned off for configuration */
> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = kx022a_chip_init(data);
> +	if (ret) {
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +
> +	ret = kx022a_turn_on_unlock(data);
> +	if (ret)
> +		return ret;
> +
> +	udelay(100);
> +	ret = devm_iio_triggered_buffer_setup_ext(dev, idev,
> +						  &iio_pollfunc_store_time,
> +						  kx022a_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN,
> +						  &kx022a_buffer_ops,
> +						  kx022a_fifo_attributes);
> +
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL\n");
> +	indio_trig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d", idev->name,
> +					    iio_device_id(idev));
> +	if (!indio_trig)
> +		return -ENOMEM;
> +
> +	data->trig = indio_trig;
> +
> +	indio_trig->ops = &kx022a_trigger_ops;
> +	iio_trigger_set_drvdata(indio_trig, data);
> +
> +	ret = devm_iio_trigger_register(dev, indio_trig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Trigger registration failed\n");
> +
> +	ret = devm_iio_device_register(data->dev, idev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	/*
> +	 * No need to check for NULL. request_threadedI_irq() defaults to
Why I?

> +	 * dev_name() should the alloc fail.
> +	 */
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
> +			      dev_name(data->dev));
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
> +					&kx022a_irq_thread_handler,
> +					IRQF_ONESHOT, name, idev);

You are requesting the irq 'after' exposing the userspace interfaces.
Technically that potentially introduces a race as we might in theory successfully
trigger an interrupt before requesting it.

Obviously that would be challenging to pull off given likely short window, but
good to close it anyway!  Rule of thumb is that devm_iio_device_register()
is always the last thing to call in problem.  The very rare exceptions need
a comment to explain why they are there...

Note that the devm_iio_trigger_register() also exposes the userspace part of the
trigger so if you allow that to be used by other drivers you'd need the irq registration
before that as well.

> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(kx022a_probe_internal, KIONIX_ACCEL);
> +
> +MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");

