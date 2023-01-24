Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98406679515
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjAXKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAXKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:22:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34502ED5D;
        Tue, 24 Jan 2023 02:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674555760; x=1706091760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sUU7MOHTnJghBqZkG5w1EGUITK+XSb5q9ldAgzSWs5s=;
  b=R9n+WQ9cAxm768YMnwFAlBCBW30xqnyTYtlDeoxLADF9oyugKmMzLvLj
   j11EZXg4GLlfCN7aHbMPh4UcJJLMltoFUhmBoNfIScFifRedXryysEqaf
   NYZnX+PB5YNuxGUrHAmrBSpW4cOZnPxFkamU7dReceKUGRWnChJ0lBy5Y
   AUcQ2VxqWA6X77rGKO2jk3TSneFzQ/z8Ohni05nFWJvW6iyogxRtFaxAU
   8+RLqTv2Mzi4lzDTgBaWtY4j2HwkgtSnfmPuy2PlbwSx4XkF/OVtYkX02
   qWbzEJPYxxRuHeeGCbQp9/k1Sn/nsruGkJGZI+KiEFrpj2iqvkyHLAr4F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326300222"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="326300222"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 02:22:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="770252433"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="770252433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2023 02:22:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKGRm-00EHud-2j;
        Tue, 24 Jan 2023 12:22:34 +0200
Date:   Tue, 24 Jan 2023 12:22:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: Add support for AMS TCS3490 light sensor
Message-ID: <Y8+xamtH/U4vK75e@smile.fi.intel.com>
References: <20230123231028.26073-1-markuss.broks@gmail.com>
 <20230123231028.26073-3-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123231028.26073-3-markuss.broks@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:10:25AM +0200, Markuss Broks wrote:
> Add a driver for AMS TCS3490 Color Light-to-Digital Converter. This
> device provides color and IR (red, green, blue, clear and IR) light
> sensing. The color sensing can be used for light source detection and
> color temperature measurements.

...

> +AMS TCS3490 DRIVER
> +M:	Markuss Broks <markuss.broks@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained

> +F:	Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml

Shouldn't actually be added with the schema patch?

> +F:	drivers/iio/light/tcs3490.c

I dunno what's the rules but it feels a bit inconsistent in case the schema
will leave while driver got, for example, rewritten (as brand new) and reverted
(as old one). In such (quite unlikely) circumstances we may end up with the
dangling file.

Rob, Krzysztof, Jonathan, what is yours take from this?

...

> +config TCS3490
> +	tristate "AMS TCS3490 color light-to-digital converter"

> +	depends on I2C

Hmm... Where is the select REGMAP_I2C?

> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here if you have an AMS TCS3490 color light-to digital converter
> +	  which provides RGB color and IR light sensing.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tcs3490.

...

> +struct tcs3490 {

> +	struct i2c_client *client;

Why do you need this?

> +	struct regmap *regmap;
> +	struct regulator *vdd_supply;
> +};

...

> +static const struct regmap_config tcs3490_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,

Seems you are using regmap internal serialization, but does it guarantee the
serialization on the transaction level? Or why is it not a problem?

> +};

...

> +	do {
> +		usleep_range(3000, 4000);
> +
> +		ret = regmap_read(data->regmap, TCS3490_STATUS, &status);
> +		if (ret)
> +			return ret;
> +		if (status & TCS3490_STATUS_RGBC_VALID)
> +			break;
> +	} while (--tries);
> +
> +	if (!tries)
> +		return -ETIMEDOUT;

regmap_read_poll_timeout()?

...

> +	ret = regmap_read(data->regmap, chan->address, &val_l);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, chan->address + 1, &val_h);
> +	if (ret)
> +		return ret;

Why not a bulk read into __le16 val?

> +	*val = (val_h << 8) | val_l;

Use le16_to_cpu().

> +	ret = regmap_write(data->regmap, TCS3490_ENABLE, TCS3490_SUSPEND);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Can be simply

	return regmap_write(...);

> +}

...

> +static int tcs3490_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tcs3490 *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = tcs3490_read_channel(data, chan, val);
> +		if (ret < 0)
> +			return ret;

> +		ret = IIO_VAL_INT;
> +		break;

return directly.

> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = tcs3490_get_gain(data, val);

Missing error check.

> +		ret = IIO_VAL_INT;
> +		break;

Return directly.

> +	default:
> +		ret = -EINVAL;
> +		break;

Ditto.

> +	}

> +	if (ret < 0)
> +		return ret;
> +	return IIO_VAL_INT;

Redundant, see above.

> +}

...

> +static const struct of_device_id tcs3490_of_match[] = {
> +	{ .compatible = "ams,tcs3490", },

Inner comma is not needed.

> +	{ },

Terminator entries should go without a comma.

> +};

...

> +static struct i2c_driver tcs3490_driver = {
> +	.driver = {
> +		.name = "tcs3490",
> +		.of_match_table = of_match_ptr(tcs3490_of_match),

Kill of_match_ptr(). Its usage is wrong in 99% of the cases.

> +	},
> +	.probe_new = tcs3490_probe,
> +};

> +

Redundant blank line.

> +module_i2c_driver(tcs3490_driver);

-- 
With Best Regards,
Andy Shevchenko


