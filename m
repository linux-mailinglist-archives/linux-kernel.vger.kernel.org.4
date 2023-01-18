Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF44E6716F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjARJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjARI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:59:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A78611DE;
        Wed, 18 Jan 2023 00:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674029980; x=1705565980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RNq2iIuPm+2/Woqz849r4QT1JASJeQWrk6QFhE+mRIE=;
  b=geVaqhbDk2ty72s6HG0Uj7+DydHpNdZa4Q+FwhGuoYFt71IE5TFvHpPG
   wzJtswMCCkLB4P2tzb3mKbFhvGgjKf0EBz4Fq2YzB5C1UxnlQvstZtZMI
   7TSYzvwL8rshKAX1IXinbYldLwTClmXi8VXyo8Hh5rXaQH0rbe/0fJtMH
   ZMe+q73HGGfYApNab72jLwZP8ZnPDgzoLTVOR/iukaBOn8gjMHetADynR
   ORK30GtPQx65CAIPSFDN1yiE0InYR3g4Vog6kuiZMvMfpt/t7qYitDvHq
   zI7Q8uOtQ6mSxvaDYLkyWbDQrFrkKrfMsKq29InmUCH015GazUAVUU44z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411168569"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411168569"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 00:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="690091014"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="690091014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2023 00:19:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI3fS-00B0f0-12;
        Wed, 18 Jan 2023 10:19:34 +0200
Date:   Wed, 18 Jan 2023 10:19:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y8erlpofdk24vwCC@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118063822.14521-4-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:38:10AM +0300, Okan Sahin wrote:
> Regulator driver for both MAX77541 and MAX77540.
> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery
> and 5VDC systems.
> 
> The MAX77540 is a high-efficiency step-down converter
> with two 3A switching phases.

...

> + * Copyright (c) 2022 Analog Devices, Inc.

Happy New Year!

...

> +static int max77541_regulator_probe(struct platform_device *pdev)
> +{
> +	struct max77541 *max77541 = dev_get_drvdata(pdev->dev.parent);
> +	struct regulator_config config = {};
> +	const struct regulator_desc *desc;
> +	struct device *dev = &pdev->dev;

You may rearrange this a bit

	struct max77541 *max77541 = dev_get_drvdata(dev->parent);

> +	struct regulator_dev *rdev;
> +	int i;

> +	config.dev = pdev->dev.parent;

dev->parent

> +
> +	if (max77541->id == MAX77540)
> +		desc = max77540_regulators_desc;
> +	else if (max77541->id == MAX77541)
> +		desc = max77541_regulators_desc;
> +	else
> +		return -EINVAL;
> +
> +	for (i = 0; i < MAX77541_MAX_REGULATORS; i++) {

> +		rdev = devm_regulator_register(dev,
> +					       &desc[i], &config);

This is perfectly one line.

> +		if (IS_ERR(rdev))
> +			return dev_err_probe(dev, PTR_ERR(rdev),
> +					     "Failed to register regulator\n");
> +	}
> +
> +	return 0;
> +}

...

> +static const struct of_device_id max77541_regulator_of_id[] = {
> +	{
> +		.compatible = "adi,max77540-regulator",
> +		.data = (void *)MAX77540,
> +	},
> +	{
> +		.compatible = "adi,max77541-regulator",
> +		.data = (void *)MAX77541,
> +	},
> +	{ /* sentinel */  }

As pointed out, better to use pointers directly.

> +};

-- 
With Best Regards,
Andy Shevchenko


