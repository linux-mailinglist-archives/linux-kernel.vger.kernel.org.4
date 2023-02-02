Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F89687ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjBBNho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBBNhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:37:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001F79CA6;
        Thu,  2 Feb 2023 05:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675345059; x=1706881059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNsHPoLmzNmFWV96A75FXJ5j6D1Zh89HMU5oA0Mj6NU=;
  b=G0AdybbEalquGCbHndHM+Da12x4PLQ2oW6PwzclxB446eC5FOk7r7jF4
   8pjDjmHX87D052JiY7rOI+xUShRQol/BQwrHiQgkLZTiKLO3XVM2HsZI1
   HzAAaow116m3IWhV4DVsEydvVc2G0x84NjpqXUJiJafTpaebtvdn8h4yx
   xLABDysiX7F0shBU53xGKH1HbKYXefWX8ToZ0w36Ez4mVNR3PaTunJFW0
   HAm/wVYjW4YS9Saij/reUqPXIEgcj+VwnCByDkTaAyNiiH9EaLOxcMGsp
   z68bJm6UHQeWqt1Lg+PiFptNzQIwN9Gy/4HF/6T1Y45LY4fzM2+ngCsL8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="329733207"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="329733207"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 05:37:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="728859963"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="728859963"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2023 05:37:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pNZmN-001Bwx-32;
        Thu, 02 Feb 2023 15:37:31 +0200
Date:   Thu, 2 Feb 2023 15:37:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/5] drivers: iio: adc: Add ADI MAX77541 ADC Support
Message-ID: <Y9u8m3EHux2b5Gip@smile.fi.intel.com>
References: <20230201103534.108136-1-okan.sahin@analog.com>
 <20230201103534.108136-4-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201103534.108136-4-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:35:16PM +0300, Okan Sahin wrote:
> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.

...

> +struct max77541_adc_iio {
> +	struct regmap	*regmap;
> +};

Is it really needed? See below.

...

> +enum max77541_adc_channel {
> +	MAX77541_ADC_VSYS_V = 0,

0 is the default in C enums, why do you need this explicitly? If these are
HW related, you need to assign them all to be crystal clear.

> +	MAX77541_ADC_VOUT1_V,
> +	MAX77541_ADC_VOUT2_V,
> +	MAX77541_ADC_TEMP,
> +};

...

> +		reg_val = FIELD_GET(MAX77541_BITS_MX_CFG1_RNG, reg_val);

> +

Redundant blank line.

> +		switch (reg_val) {
> +		case LOW_RANGE:
> +			*val = 6;
> +			*val2 = 250000;
> +			break;
> +		case MID_RANGE:
> +			*val = 12;
> +			*val2 = 500000;
> +			break;
> +		case HIGH_RANGE:
> +			*val = 25;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}

...

	struct regmap **regmap;

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));

sizeof(*regmap)

> +	if (!indio_dev)
> +		return -ENOMEM;

> +	info = iio_priv(indio_dev);

	regmap = iio_priv(...);

> +	info->regmap = dev_get_regmap(dev->parent, NULL);

	*regmap = ...;

It won't probably gain anything in the code generation or memory footprint,
so up to you. But in general depending on API it might be a benefit.

...

> +static const struct platform_device_id max77541_adc_platform_id[] = {
> +	{ "max77541-adc", },

Inner comma is not needed.

> +	{  /* sentinel */  }
> +};

-- 
With Best Regards,
Andy Shevchenko


