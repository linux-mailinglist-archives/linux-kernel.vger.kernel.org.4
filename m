Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5072E69E01A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjBUMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjBUMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:17:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16429E32;
        Tue, 21 Feb 2023 04:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676981830; x=1708517830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uzVFzirXSv25kiPnI1/UuQaCx9NtBbad4el4UtQ8pe0=;
  b=nNgqwfG71vygG0xR+spoLVmsHWlB17enGDm6wnZdvPJHxTE+Ti7i7zjh
   1/suefmJ9z+XRW2m+cWYtNgpBDy1k7f1d73uNndXyIKpb+fX1fEc79GmJ
   Zri72FeIDqZQ7tBqtT2t997Vvr/99+ClP2FDH3es5dCh7W0XSGvEcL0dm
   rD+UW5y1boQ7Y+d/IHVO7V6x/WhHYcW5jWpcsbIe7w7afb0sKGcySuu4S
   1KL6ZUwrhxP0bwypYqaiE0rhalrfdPNKIL7EnXpv8K9lTQKXDHjkBLRU1
   iS761+5TLLqydDRCQD8x9w1/ca37rHomvOz4B+Gcc3076aE4dyGI2OceH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331281052"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="331281052"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 04:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="664957815"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="664957815"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2023 04:13:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pURWo-009wk6-2R;
        Tue, 21 Feb 2023 14:13:50 +0200
Date:   Tue, 21 Feb 2023 14:13:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y/S1ftKmV92TL8VO@smile.fi.intel.com>
References: <20230221103926.49597-1-okan.sahin@analog.com>
 <20230221103926.49597-6-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221103926.49597-6-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:39:13PM +0300, Okan Sahin wrote:
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

Extra space in the Subject.

...

> +#include <linux/of_device.h>

Why?

...

> +static const struct regmap_config max77541_regmap_config = {
> +	.reg_bits   = 8,
> +	.val_bits   = 8,

Do you need lock of regmap?

> +};

...

> +static const struct mfd_cell max77540_devs[] = {

> +	MFD_CELL_OF("max77540-regulator", NULL, NULL, 0, 0,
> +		    NULL),

Perfectly one line.

> +};

> +static const struct mfd_cell max77541_devs[] = {
> +	MFD_CELL_OF("max77541-regulator", NULL, NULL, 0, 0,
> +		    NULL),
> +	MFD_CELL_OF("max77541-adc", NULL, NULL, 0, 0,
> +		    NULL),

Ditto.

> +};

...

> +	if (max77541->chip->id == MAX77541) {
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

> +static const struct i2c_device_id max77541_i2c_id[];

What for?

...

> +	if (dev->of_node)
> +		max77541->chip  = of_device_get_match_data(dev);
> +	else
> +		max77541->chip  = (struct chip_info *)
> +					i2c_match_id(max77541_i2c_id,
> +						     client)->driver_data;

Oh. Please use

	const struct i2c_device_id *id = i2c_client_get_device_id(client);
	...
	max77541->chip  = device_get_match_data(dev); // needs property.h
	if (!max77541->chip)
		max77541->chip  = (struct chip_info *)id->driver_data;

> +	if (!max77541->chip)
> +		return -EINVAL;

...

> +#ifndef __MAX77541_MFD_H__
> +#define __MAX77541_MFD_H__

Can we go towards consistency in this?
Seems to me the most used patter so far is

#ifndef __LINUX_MFD_MAX77541_H

-- 
With Best Regards,
Andy Shevchenko


