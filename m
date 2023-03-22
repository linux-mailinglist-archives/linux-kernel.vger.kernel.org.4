Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C836C4FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCVP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCVP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:58:48 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5165F36FE7;
        Wed, 22 Mar 2023 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Khd9ZkkHV56yKylwQkQUjI8LC8lCPiD84A4vvthz0NM=; b=Ym5UsdJU+V8MwR6QVIemE10FSk
        ctO4TuyLB1J4sjdIGDcbc7k0SNq+ZHCC4aIkVPuZftYgnH/BwmdragB3qwnMi7+xDiO/AS73WhNHo
        lr5+fTrh+pH88TZfnAp32Q569SqQc0c1IzpdowK7PFX+B68vSpigjOezGW3pECjbOljPNtId/fX8E
        YTEKcLkWqDtOqVA+L8AwN3+X8kSu8KRI1E7EfKdqthZT6KqERDXkE4XR/KrQ3Run3/8Ww5drCW+eM
        S00flVqp6sQ4FLZQqQeR9aShTQGCrMbSRpQBgnbDSHlwO9j4ofZfjTeOuOHESjr7F8RS0OTOfil5D
        uURTjkkQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pf0rJ-000Ihk-MW; Wed, 22 Mar 2023 16:58:41 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pf0rJ-000QwQ-Bx; Wed, 22 Mar 2023 16:58:41 +0100
Message-ID: <826f5de9-3aeb-6f7a-59e6-0504f8e92180@metafoo.de>
Date:   Wed, 22 Mar 2023 08:58:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] iio: max597x: Add support for max597x
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Lee Jones <lee@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26851/Wed Mar 22 08:22:49 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This looks really good. A few minor comments inline.

On 3/22/23 05:43, Naresh Solanki wrote:
> [...]
> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long info)
> +{
> +	int ret;
> +	struct max597x_iio *data = iio_priv(iio_dev);
> +	unsigned int reg_l, reg_h;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(data->regmap, chan->address, &reg_l);
> +		if (ret < 0)
> +			return ret;
> +		ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
> +		if (ret < 0)
> +			return ret;
Is there any chance of a race condition of getting inconsistent data 
when splitting this over two reads? I.e. registers being updated with 
new values in between the two reads.
> +		*val = (reg_h << 2) | (reg_l & 3);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +
> +		switch (chan->address) {
> +		case MAX5970_REG_CURRENT_L(0):
> +			fallthrough;

`fallthrough` should not be needed for multiple case statements right on top of each other with no code in between. Same below

> +		case MAX5970_REG_CURRENT_L(1):
> +			/* in A, convert to mA */
> +			*val = data->irng[chan->channel] * 1000;
> +			*val2 =
> +			    data->shunt_micro_ohms[chan->channel] * ADC_MASK;
ADC_MASK should really have a MAX5970_ prefix, but I guess it is defined 
in max597x.h
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case MAX5970_REG_VOLTAGE_L(0):
> +			fallthrough;
> +		case MAX5970_REG_VOLTAGE_L(1):
> +			/* in uV, convert to mV */
> +			*val = data->mon_rng[chan->channel];
> +			*val2 = ADC_MASK * 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
> +		break;
> +	}
> +	return -EINVAL;
> +}
> [..]
> +static int max597x_iio_probe(struct platform_device *pdev)
> +{
> +	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
> +	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct iio_dev *indio_dev;
> +	struct max597x_iio *priv;
> +	int ret, i;
> +
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	if (!max597x || !max597x->num_switches)
> +		return -EPROBE_DEFER;
> +
> +	/* registering iio */
> +	indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
For the devm allocations we should be using &pdev->dev and not the I2C 
device, since this is the device to which the allocations belong and 
where they should be freed when the device is removed.
> +	if (!indio_dev) {
> +		dev_err(&i2c->dev, "failed allocating iio device\n");
Consider using dev_err_probe() for error message printing. This will 
give a consistent formatting of the messages. Also again use &pdev->dev 
instead of I2C device to get the right device listed in the error messages.
> +		return -ENOMEM;
> +	}
> +	indio_dev->name = dev_name(&i2c->dev);
The IIO ABI wants the type of the chip for the name. E.g. "max5970", 
using dev_name() of the parent I2C device will result in something else.
> [...]
