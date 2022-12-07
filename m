Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3564590E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLGLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLGLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:30:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221748401;
        Wed,  7 Dec 2022 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670412624; x=1701948624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kh4y6l6w9SxnJx5xFBJLdTUfM4uJK7lKR1XZ4zn7eHc=;
  b=gR+j7MNPRcvLGUula5OrV8AG48OpuYijt2nQcMbdILnUdzBXq/H/EI2x
   FXOEc/SONQlf3VdCbHt/LPE1uD/uS441HxkeO34r+NWfZaN206sjwqK25
   w/VQX4Gf9LGLJVgyw5i4eIaxpdOqrLO0L30IBgdFCMNsgKLwGiaLgg8wX
   ceOhidlWKDm8LLfARkEWXEYm6kOjJ9msr7YdQIGMeyUMrRBjBvvRDUBW2
   3vf3CJ1dblmGSkMJYs0SoYvlSSasCDSWWBsyWgeownkCwCXLyhbX843C4
   3eSWZxe8PaH0sUoTv3ua7tEGqv4MeOP5fKA3BS5/T22Be3Y3F00aqnbZg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381161641"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="381161641"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820928509"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="820928509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 03:30:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2scz-005k27-02;
        Wed, 07 Dec 2022 13:30:17 +0200
Date:   Wed, 7 Dec 2022 13:30:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     outreachy@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: drivers: iio: adc: Adc MAX77541 ADC Support
Message-ID: <Y5B5SHMHZoV5eMAt@smile.fi.intel.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
 <20221207090906.5896-6-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207090906.5896-6-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 12:08:44PM +0300, Okan Sahin wrote:
> This patch add adc support for MAX77541.
> 
> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature

Same comment as per patch 2.

...

> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>

> +#include <include/linux/mfd/max77541.h>

Hmm...

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>

...

> +enum {
> +	MAX77541_ADC_CH1_I = 0,
> +	MAX77541_ADC_CH2_I,
> +	MAX77541_ADC_CH3_I,
> +	MAX77541_ADC_CH6_I,
> +
> +	MAX77541_ADC_IRQMAX_I,

If it's a terminator, drop the trailing comma.

> +};

...

> +	case MAX77541_ADC_TEMP:
> +		*val = -273;

I believe we have definition for this in units.h. Can you use it?

> +		*val2 = 0;
> +		return IIO_VAL_INT_PLUS_MICRO;


> +	}
> +}

...

> +		*val = 0;
> +
> +		if (reg_val == LOW_RANGE)
> +			*val2 = 6250;
> +		else if (reg_val == MID_RANGE)
> +			*val2 = 12500;
> +		else if (reg_val == HIGH_RANGE)
> +			*val2 = 25000;
> +		else
> +			return -EINVAL;

Can it be provided as a table?

...

> +		*val = 0;
> +
> +		if (reg_val == LOW_RANGE)
> +			*val2 = 6250;
> +		else if (reg_val == MID_RANGE)
> +			*val2 = 12500;
> +		else if (reg_val == HIGH_RANGE)
> +			*val2 = 25000;
> +		else
> +			return -EINVAL;

Ditto.

...

> +

Redundant blank line.

> +module_platform_driver(max77541_adc_driver);

-- 
With Best Regards,
Andy Shevchenko


