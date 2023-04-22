Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA646EBAC3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDVRxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDVRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56021211D;
        Sat, 22 Apr 2023 10:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E59116091F;
        Sat, 22 Apr 2023 17:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A24C433EF;
        Sat, 22 Apr 2023 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682186010;
        bh=fPoF9s5UE6QAjkCKhn/BGCrF6ucRv3YJBUZBqq0vX8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ASuCRNjGIFm5WeFlZWsXFjMnL6LS9Yj05fqvWwgfqqq1crGV6gEHWZXKuiriYVBZ/
         0AVdTWEKFSaaZuogpw3EnWQ5LRbdjS/DsNqwqV1s7TpMV3+VsKvjT9XlgSFXQRY6YL
         N4WXJJXrCe3Fw8luu/rjuDWv/uEUZ9Hb5PxQ49zXBoOIGXoM++Q4yRmMbZqt1hXwzY
         Ly7IfsZgdiTanIawlXvrX4Kw49csTCBEtq+QglagdbrhXuWq+PoNs21GH2llY2hlPQ
         byt0nDG0SrOtnlCQsIGI4TmP+98lCtVnFqpeeQe2xIZ9tw7dMQ4SPJzRdNMQuUnAPJ
         4b2UGJnaNm2bA==
Date:   Sat, 22 Apr 2023 19:09:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add support for TI OPT4001 light
 sensor
Message-ID: <20230422190906.36623838@jic23-huawei>
In-Reply-To: <20230323-add-opt4001-driver-v2-2-0bae0398669d@axis.com>
References: <20230323-add-opt4001-driver-v2-0-0bae0398669d@axis.com>
        <20230323-add-opt4001-driver-v2-2-0bae0398669d@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 12:36:27 +0200
Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com> wrote:

> This driver uses the continuous mode of the chip and integration
> time can be configured through sysfs.
> The constants for calculating lux value differs between packaging
> so it uses different compatible string for the two versions
> "ti,opt4001-picostar" and "ti,opt4001-sot-5x3" since the device id
> is the same.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt4001
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>

A few minor comments inline.

Thanks,

Jonathan

> +/* The different packaging of OPT4001 has different constants used when calculating
/*
 * The different...

For IIO multiline comments. This is not consistent across different kernel subsystems but
tends to be consistent within one.

> + * lux values.
> + */
> +struct opt4001_chip_info {
> +	int mul;
> +	int div;
> +	const char *name;
> +};


> +
> +static int opt4001_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct opt4001_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = opt4001_read_lux_value(indio_dev, val, val2);

As below. Early returns make for easier to review code as we don't need to go
see if there is any cleanup when there isn't any to be done.

> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = opt4001_int_time_reg[chip->light_settings.int_time][0];
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int opt4001_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct opt4001_chip *chip = iio_priv(indio_dev);
> +	int int_time;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		int_time = opt4001_als_time_to_index(val2);
> +		if (int_time < 0) {
Early returns make this easier to review + shorten it a little.

> +			ret = int_time;
			return int_time;
> +		} else {
		}

		and you can drop indent on next bit.

> +			chip->light_settings.int_time = int_time;
> +			ret = opt4001_set_conf(chip);
			return opt...;
> +		}
> +

> +		break;
> +	default:
> +		ret = -EINVAL;
		return -EINVAL;

> +	}
> +
> +	return ret;
No need for this as can't reach here after above changes.

> +}
> +

> +static int opt4001_probe(struct i2c_client *client)
> +{
> +	struct opt4001_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	uint dev_id;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	ret = devm_regulator_get_enable(&client->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to enable vdd supply\n");
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &opt4001_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> +				     "regmap initialization failed\n");
> +	chip->client = client;
> +
> +	indio_dev->info = &opt4001_info_no_irq;
> +
> +	ret = regmap_reinit_cache(chip->regmap, &opt4001_regmap_config);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to reinit regmap cache\n");
> +
> +	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &dev_id);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +			"Failed to read the device ID register\n");
> +
> +	dev_id = FIELD_GET(OPT4001_DEVICE_ID_MASK, dev_id);
> +	if (dev_id != OPT4001_DEVICE_ID_VAL) {
> +		dev_err(&client->dev, "Device ID: %#04x unknown\n", dev_id);
> +		return -EINVAL;

Warn only on a failure to match and don't error out.
The reason for this is DT fallback compatibles. They only work to enable
a newer part compatible with older driver support if the older driver doesn't
error out on an ID miss match.   So the most we can do is warn that we don't
know what the device is, but then assume the dt compatible or similar is
correct.

> +	}
> +
> +	chip->chip_info = device_get_match_data(&client->dev);
> +
> +	indio_dev->channels = opt4001_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = chip->chip_info->name;
> +
> +	ret = opt4001_load_defaults(chip);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to set sensor defaults\n");
> +
> +	ret = devm_add_action_or_reset(&client->dev,
> +					opt4001_chip_off_action,
> +					chip);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to setup power off action %d\n",
> +			ret);
Trivial, but in probe you can always use dev_err_probe() whether or not there
is any chance of a defer.  That simplifies this to
		return dev_err_probe(&client->dev, ret, "..");

Which is slightly nicer.  Added bonus is reviewer doesn't need to think if
something might defer or not.

> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

