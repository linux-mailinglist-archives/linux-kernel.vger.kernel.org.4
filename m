Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779C6A6F76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCAPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCAPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:30:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176886B2;
        Wed,  1 Mar 2023 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677684610; x=1709220610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=awaxUVG91j1W8d8/DcAgSZV/A41b8Ct2cTPB4FCsBhQ=;
  b=EPe20RfBcIL9inYMPY1C1Do52FwwmwKQ9RsDqk5UtJShjm7H/Ikml6C7
   nnjXFmccF2qRqekFtSCf34JHFHt78BfY8p7EM9tiIeJsMFraw8TpjQ2oa
   r/ABkm/yXpte7M5/lOJOVfpZJDioPZawxOjxWvjgyp3i2vP/qH9E1qy2O
   w5KnlInWrJ6rqRrk7Fb6h5wKNhaEoNsB9agcVuA+Gbap8CxNs4g+T16M6
   0gnW6g5ZPAfORH7bipYlwH0fNpAfVVI1oSCQNWzrq4g0jlWXUKVXBNhYF
   u66nL+FpkczPkI+6FVVAL8qDeiOfbNo8WZltJCoZIL1DnNjLnkH6RXwf6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318236341"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="318236341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817610698"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="817610698"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2023 07:30:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXOP5-00DoMH-2v;
        Wed, 01 Mar 2023 17:30:03 +0200
Date:   Wed, 1 Mar 2023 17:30:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228063151.17598-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 07:31:51AM +0100, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.

...

> +	/* Shift result to compensate for bit resolution vs. sample rate */
> +	value <<= 16 - ads1100_data_bits(data);
> +	*val = sign_extend32(value, 15);

Why not simply

	*val = sign_extend32(value, ads1100_data_bits(data) - 1);

?

(Double check for off-by-one usage)

...

> +	/* Calculate: gain = ((microvolts / 1000) / (val2 / 1000000)) >> 15 */

Can you use more math / plain English to describe the formula? Otherwise we can
see the very same in the code and point of the comment is doubtful.

> +	gain = ((microvolts + BIT(14)) >> 15) * 1000 / val2;

Something from units.h?

...

> +	for (i = 0; i < 4; i++) {
> +		if (BIT(i) == gain) {

ffs()/__ffs() (look at the documentation for the difference and use proper one).

> +			ads1100_set_config_bits(data, ADS1100_PGA_MASK, i);
> +			return 0;
> +		}
> +	}

...

> +	for (i = 0; i < size; ++i) {

Why pre-increment?

> +		if (ads1100_data_rate[i] == rate) {
> +			return ads1100_set_config_bits(
> +					data, ADS1100_DR_MASK,

Strange indentation.

> +					FIELD_PREP(ADS1100_DR_MASK, i));
> +		}

Do you need {} ?

> +	}

...

> +	int millivolts = regulator_get_voltage(data->reg_vdd) / 1000;

units.h?

...

> +		data->scale_avail[i * 2] = millivolts;

I would write ' * 2 + 0]', but it's up to you.

> +		data->scale_avail[i * 2 + 1] = 15 + i;

...

> +		*val = regulator_get_voltage(data->reg_vdd) / 1000;

units.h?

...

> +		*val = ads1100_data_rate[
> +				FIELD_GET(ADS1100_DR_MASK, data->config)];

Strange indentation, just use a single line.

...

> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)

Why ' < 0'?

> +		return dev_err_probe(dev, ret,
> +				     "Failed to register IIO device\n");

...

> +static int ads1100_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +
> +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
> +	regulator_disable(data->reg_vdd);

Wrong devm / non-devm ordering.

> +	return 0;
> +}

...

> +static const struct i2c_device_id ads1100_id[] = {
> +	{ "ads1100", },
> +	{ "ads1000", },

Inner commas are not needed.

> +	{}
> +};

...

> +static const struct of_device_id ads1100_of_match[] = {
> +	{ .compatible = "ti,ads1100", },
> +	{ .compatible = "ti,ads1000", },

Ditto.

> +	{}
> +};

...

> +

Redundant blank line.

> +module_i2c_driver(ads1100_driver);

-- 
With Best Regards,
Andy Shevchenko


