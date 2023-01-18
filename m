Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55C6716C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjARI7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjARI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:58:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174830FE;
        Wed, 18 Jan 2023 00:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674029785; x=1705565785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKWlSVG3dqnPnAUFE6fQ5nT8l9dHU1tiOB4s5k2oa6k=;
  b=OcCUN875IwHcZYuXlAr5iAsmbEaXzuBtevZaRRZQAVWFluVXJxxWPZmi
   5sYyrkwPB8lp4S91zYxEeXKgpsVeo6WdbrsPyeHsEF49caLHjPEcHRWC7
   QRYulXclQ1R0F3AG1TolWFGMoVLUH/dqFDTVZ5qdc1eRv6t+U3PywRPXe
   TsidG8wBDyKM6EdOfatTfWSNf3ptePpTgslW3MEPkd/46rHnRV8xc+2mM
   2KI4Mn+B0Spfvbv4yR/VUYYEWKTkuRGASpVQm81vjUJAH8khbA+vHMY2t
   DKnl39zutuF+Mo53MJkmipLn24qDC+xeDYzgY8VbY9l9Wceo+WlRUMsya
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304609429"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304609429"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 00:16:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="661623777"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="661623777"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2023 00:16:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI3cH-00B0bA-17;
        Wed, 18 Jan 2023 10:16:17 +0200
Date:   Wed, 18 Jan 2023 10:16:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] drivers: mfd: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y8eq0GtVZfVdNKYn@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-2-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118063822.14521-2-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:38:08AM +0300, Okan Sahin wrote:
> MFD driver for MAX77541/MAX77540 to enable its sub
> devices.
> 
> The MAX77541 is a multi-function devices. It includes
> buck converter and ADC.
> 
> The MAX77540 is a high-efficiency buck converter
> with two 3A switching phases.
> 
> They have same regmap except for ADC part of MAX77541.

...

> +/*
> + * Copyright (c) 2022 Analog Devices, Inc.

Happy New Year!

> + * Mfd core driver for the MAX77540 and MAX77541

MFD

> + */

...

> +	ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED, 0,
> +				       &max77541_buck_irq_chip,
> +				       &max77541->irq_buck);
> +	if (ret)
> +		return ret;
> +
> +	if (max77541->id == MAX77541) {
> +		ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
> +					       IRQF_ONESHOT | IRQF_SHARED, 0,
> +					       &max77541_adc_irq_chip,
> +					       &max77541->irq_adc);
> +		if (ret)
> +			return ret;
> +	}

> +	return ret;

return 0;

...

> +		return devm_mfd_add_devices(dev, -1, max77540_devs,

PLATFORM_DEVID_NONE ?

> +					    ARRAY_SIZE(max77540_devs),
> +					    NULL, 0, NULL);

...

> +		return devm_mfd_add_devices(dev, -1, max77541_devs,

Ditto.

> +					    ARRAY_SIZE(max77541_devs),
> +					    NULL, 0, NULL);

...

> +static int max77541_i2c_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)

No id, please. I.o.w. you should use ->probe_new().

> +{
> +	struct device *dev = &client->dev;
> +	struct max77541 *max77541;
> +	const void *match;
> +
> +	max77541 = devm_kzalloc(&client->dev, sizeof(*max77541), GFP_KERNEL);
> +	if (!max77541)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, max77541);
> +	max77541->i2c = client;
> +
> +	match = device_get_match_data(dev);
> +	if (match)
> +		max77541->id = (enum max7754x_ids)match;

This is dangerous if your enum has 0 as a valid value.
Instead, use pointers in the driver_data, like

	&chip_info chip[MAX77540]

> +	else if (id)
> +		max77541->id = id->driver_data;

> +	else

It's better to check the ID range here.
Or since the change recommended above, check for NULL.

> +		return -ENODEV;
> +
> +	max77541->chip = &chip[max77541->id];
> +
> +	max77541->regmap = devm_regmap_init_i2c(client,
> +						&max77541_regmap_config);
> +	if (IS_ERR(max77541->regmap))
> +		return dev_err_probe(dev, PTR_ERR(max77541->regmap),
> +				     "Failed to allocate register map\n");
> +
> +	return max77541_pmic_setup(dev);
> +}

...

> +/*BITS OF REGISTERS*/

Missing spaces.

-- 
With Best Regards,
Andy Shevchenko


