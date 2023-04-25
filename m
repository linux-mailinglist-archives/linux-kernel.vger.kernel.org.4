Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C956EE5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjDYQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjDYQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29850D32E;
        Tue, 25 Apr 2023 09:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B38562FEF;
        Tue, 25 Apr 2023 16:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F71C433EF;
        Tue, 25 Apr 2023 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682441126;
        bh=qYtsjfSRntrlmz1GTt2T8BgY9lhfCMy/SrYFUoTQYUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1oAKYCWZkbEklSOb9TjwWy1eGKuLANnf0EaJ4XStPOZ4gjng24xqcONsf1G38fHP
         3nnwkv3KmrFHb8BrcVKuxGq1/j8PneneImOVXxO7Lj6Dr0ejE2MpVLVo35xqq5G9Yw
         d4SXskBwxVIoMXqTKuy4rqquTtPnPU9nfnkPT8OtNOM1ny0G8fP6oa+OiaDjXYYo6M
         cv8N86e4uhmOBrY1eBBJMaq80c5pr1iSuy0dkwu4Vl9llUtasoO3TzkTRwxJEex8bF
         pO+IP79uRWqRzaeeoKXMh4fGTRIZI0AXFgBeN5WDlyqagmn8v66YYmIa8J6064sbZ3
         75rg/C6Bbq55g==
Date:   Tue, 25 Apr 2023 18:45:22 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230425164522.sljcniui5ox5yx3l@intel.intel>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

[...]

> +static int bu27008_get_int_time(struct bu27008_data *data)

this is providing the time in 'us' if I understood correctly.

Can you add it at the end of the function to make it clear?
bu27008_get_int_time_us().

No need to resend it just for this.

> +{
> +	int ret, sel;
> +
> +	ret = bu27008_get_int_time_sel(data, &sel);
> +	if (ret)
> +		return ret;
> +
> +	return iio_gts_find_int_time_by_sel(&data->gts,
> +					    sel & BU27008_MASK_MEAS_MODE);
> +}

[...]

> +static int bu27008_try_set_int_time(struct bu27008_data *data, int int_time_new)
> +{
> +	int ret, old_time_sel, new_time_sel,  old_gain, new_gain;
> +
> +	mutex_lock(&data->mutex);
> +
> +	ret = bu27008_get_int_time_sel(data, &old_time_sel);
> +	if (ret < 0)
> +		goto unlock_out;
> +
> +	if (!iio_gts_valid_time(&data->gts, int_time_new)) {
> +		dev_dbg(data->dev, "Unsupported integration time %u\n",
> +			int_time_new);
> +
> +		ret = -EINVAL;
> +		goto unlock_out;
> +	}
> +	new_time_sel = iio_gts_find_sel_by_int_time(&data->gts, int_time_new);
> +	if (new_time_sel == old_time_sel) {
> +		ret = 0;

ret is already '0' here.

> +		goto unlock_out;
> +	}

[...]

> +static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan, int *val, int *val2)
> +{
> +	int ret, int_time;
> +
> +	ret = bu27008_chan_cfg(data, chan);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27008_meas_set(data, BU27008_MEAS_EN);
> +	if (ret)
> +		return ret;
> +
> +	int_time = bu27008_get_int_time(data);
> +	if (int_time < 0)
> +		int_time = 400000;
> +
> +	msleep((int_time + 500) / 1000);

What is this 500 doing? Is it making a real difference? it's
0.5ms.

What's the minimum int_time? Can we set a minimum, as well, just
for the sake of the msleep?

> +	ret = bu27008_chan_read_data(data, chan->address, val);
> +	if (!ret)
> +		ret = IIO_VAL_INT;

[...]

> +static int bu27008_set_scale(struct bu27008_data *data,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2)
> +{
> +	int ret, gain_sel, time_sel, i;
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
> +

extra line here.

> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
> +						val, val2 * 1000, &gain_sel);
> +	if (ret) {
> +		/* Could not support new scale with existing int-time */
> +		int new_time_sel;
> +
> +		for (i = 0; i < data->gts.num_itime; i++) {
> +			new_time_sel = data->gts.itime_table[i].sel;
> +			ret = iio_gts_find_gain_sel_for_scale_using_time(
> +				&data->gts, new_time_sel, val, val2 * 1000,
> +				&gain_sel);
> +			if (!ret)
> +				break;
> +		}
> +		if (i == data->gts.num_itime) {
> +			dev_err(data->dev, "Can't support scale %u %u\n", val,
> +				val2);
> +
> +			ret = -EINVAL;
> +			goto unlock_out;
> +		}
> +
> +		ret = bu27008_set_int_time_sel(data, new_time_sel);
> +		if (ret)
> +			goto unlock_out;
> +	}

just a nit: I see you got tight here and goto's are not made only
for error handling. You could:

	if (!ret)
		goto something;

	/*
	 * everything that you have inside the 'if (ret)' with
	 * one level of indentation less
	 */

   something:
	ret = bu27008_write_gain_sel(data, gain_sel);

	/* ... */

free to ignore this comment, though, I just saw that there are a
few cases where you can save some indentation above.

> +
> +	ret = bu27008_write_gain_sel(data, gain_sel);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}

[...]

> +static int bu27008_chip_init(struct bu27008_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
> +			   BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> +
> +	/*
> +	 * The data-sheet does not tell how long performing the IC reset takes.
> +	 * However, the data-sheet says the minimum time it takes the IC to be
> +	 * able to take inputs after power is applied, is 100 uS. I'd assume
> +	 * > 1 mS is enough.
> +	 */
> +	msleep(1);

please use usleep_range().

> +
> +	return ret;
> +}

[...]

> +static irqreturn_t bu27008_trigger_handler(int irq, void *p)

Do we really need to be in atomic context here? Can this be
handled from a thread?

> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct bu27008_data *data = iio_priv(idev);
> +	struct {
> +		__le16 chan[BU27008_NUM_HW_CHANS];
> +		s64 ts __aligned(8);
> +	} raw;
> +	int ret, dummy;
> +
> +	memset(&raw, 0, sizeof(raw));
> +
> +	/*
> +	 * After some measurements, it seems reading the
> +	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line
> +	 */
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL3, &dummy);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, &raw.chan,
> +			       sizeof(raw.chan));
> +	if (ret < 0)
> +		goto err_read;
> +
> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}

[...]

> +static int bu27008_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct iio_trigger *itrig;
> +	struct bu27008_data *data;
> +	struct regmap *regmap;
> +	unsigned int part_id, reg;
> +	struct iio_dev *idev;
> +	char *name;
> +	int ret;
> +
> +	if (!i2c->irq)
> +		dev_warn(dev, "No IRQ configured\n");

[...]

> +	if (i2c->irq) {

e.g.:


	if (!i2c->irq) {
		dev_warn(dev, "No IRQ configured\n");
		goto no_irq;
	}

	/* ... */

or, if you don't like the goto used like this...

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
> +	}

	} else {
		dev_warn(dev, "No IRQ configured\n");
	}

and save the first 'if' of this function.

> +
> +	ret = devm_iio_device_register(dev, idev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	return ret;
> +}

[...]

Andi
