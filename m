Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9A6AABBE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCDR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCDR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:58:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67AD9038;
        Sat,  4 Mar 2023 09:57:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D879B808D2;
        Sat,  4 Mar 2023 17:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933FDC433D2;
        Sat,  4 Mar 2023 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677952676;
        bh=c22VmOXtCWp19NR5qWXq8B8thkC+XNY/HmS2rJv/mfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kp6P2G07p5ui1mR7XpjTXs8SnDm+3uR5g4IUfkOShW/jHWik9km3ysyKXmk6Rdqao
         804Uoq9juqH/if0n7BAnnw3iDGWVzTbLZ5jBfpGyp9YwqFA0/JV7YX1Xe1ddoCpPtG
         lYauQuuL+Vb2Y3I8CSlAv3Zk68CFWXBPhoxlxlQLP5nVkrF2BHn8cVjI4yemjg3ER2
         HJplHLB9khHmSU2+1iw9WOzpSTaxVAo04t5QwqwuvjNvIIz4FEHDLUpirjt+C+hr4Z
         aZM3E33LitiJnY8kqWrj3OOfjPjn5+9ZMmG4o64fnqCTH9cj8nvQBg9fDwpjPElLoC
         AkcZp229syAPA==
Date:   Sat, 4 Mar 2023 17:57:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <20230304175751.2daae308@jic23-huawei>
In-Reply-To: <20230228063151.17598-2-mike.looijmans@topic.nl>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
        <20230228063151.17598-2-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 07:31:51 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Hi Mike,

A few minor things + one request for a test as trying to chase a possible
ref count overflow around the runtime_pm was giving me a enough of a headache
that it's easier to ask you just to poke it and see.  If it doesn't fail as
I expect I'll take a closer look!

Jonathan


> +static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
> +{
> +	int microvolts;
> +	int gain;
> +	int i;
> +
> +	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
> +	if (val)
> +		return -EINVAL;
> +
> +	microvolts = regulator_get_voltage(data->reg_vdd);
> +	/* Calculate: gain = ((microvolts / 1000) / (val2 / 1000000)) >> 15 */
> +	gain = ((microvolts + BIT(14)) >> 15) * 1000 / val2;
> +
> +	for (i = 0; i < 4; i++) {
> +		if (BIT(i) == gain) {
> +			ads1100_set_config_bits(data, ADS1100_PGA_MASK, i);
> +			return 0;
> +		}
> +	}
Andy's suggestion of something like..
	if (!gain)
		return -EINVAL;
	i = ffs(gain);
	if (i >= 4 || BIT(i) != gain)
		return -EINVAL;

	ads...

Is perhaps nicer than the loop.

	 
> +
> +	return -EINVAL;
> +}


> +static void ads1100_disable_continuous(void *data)
> +{
> +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
> +}
> +
> +static int ads1100_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads1100_data *data;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

You can avoid the slightly nasty mix of i2c_set_clientdata vs dev_get_drvdata()
below by taking advantage of the fact you have a local dev pointer.

	dev_set_drvdata(dev, indio_dev);
and no confusing mix is left.  Of course it's doing the same thing but to my
mind slightly nicer to use the same one.

> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "ads1100";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &ads1100_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ads1100_info;
> +
> +	data->reg_vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->reg_vdd))
> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> +				     "Failed to get vdd regulator\n");
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret < 0)
> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> +				     "Failed to enable vdd regulator\n");
> +
> +	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
> +	if (ret)
> +		return ret;

Please could you check a subtle interaction of runtime pm and this devm managed
flow.

I think we can hit the following flow.
1) In runtime suspend (wait long enough for this to happen).
2) Unbind the driver (rmmod will do)
3) During the unbind we exit suspend then enter it again before we call remove
   (that's just part of the normal remove flow).
4) We then end up calling regulator disable when it's already disabled.

We've traditionally avoided that by having the remove explicitly call
pm_runtime_get_sync() before we then disable runtime pm.  I don't
think that happens with devm_pm_runtime_enable() but I could be missing
a path where it does.

If the sequence goes wrong you should get a warning about an unbalanced regulator
disable.  The fix would be an extra devm_add_action_or_reset() before the
devm_iio_device_register() below that just calls pm_runtime_get_sync()
to force the state to on.

Gah. These subtle paths always give me a headache.
We don't normally have too much problem with this because many
runtime_resume / suspend functions don't change reference counts.



> +
> +	ret = ads1100_setup(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to communicate with device\n");
> +
> +	ret = devm_add_action_or_reset(dev, ads1100_disable_continuous, data);
> +	if (ret)
> +		return ret;
> +
> +	ads1100_calc_scale_avail(data);
> +
> +	pm_runtime_set_autosuspend_delay(dev, ADS1100_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static int ads1100_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

Fine to just short cut this dance with 
struct iio_dev *indio_dev = dev_get_drvdata(dev);

It's a bit nasty from a readability point of view, but the pattern is
so common we've kind of gotten used to it.



> +	struct ads1100_data *data = iio_priv(indio_dev);

As you don't need the indio_dev, can combine all this into

	struct ads110_data *data = iio_priv(dev_get_drvdata(dev));

> +
> +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
> +	regulator_disable(data->reg_vdd);
> +
> +	return 0;
> +}
> +
> +static int ads1100_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

As above.

> +	struct ads1100_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to enable Vdd\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * We'll always change the mode bit in the config register, so there is
> +	 * no need here to "force" a write to the config register. If the device
> +	 * has been power-cycled, we'll re-write its config register now.
> +	 */
> +	return ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_CONTINUOUS);
> +}
> +

