Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB64E671707
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjARJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjARJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:04:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D538657;
        Wed, 18 Jan 2023 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674030234; x=1705566234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uCg/XfvJ6BeR1K9GEsz6JT/fUuIQzctB031i34I0db4=;
  b=g42dZGJjU1P/Lz5WiJpF/nNi5/bk4Ru+oL7LsiDoihGdZtQs5fg+zKRG
   mDMyXLBL0zl1o+6/u8mN/6IPjRs1XOngMdP+37jLBoESvtZ66lHJ5ID6G
   kpENdbpj2p4VsbagixwV8FZiBLdtCj3j4ITAzuSSOUdwXGBnTPyS0f7sx
   v7gcuBb1k6TwvtZxfB9/999NPjOsbfwEGjHawWrnvwsG1hTBDRSlDUk7o
   3hW2Ca/HnPJXh8M/BuHLRGQpQsXrUIZcl+OEwgfTYfnXwq9hI6VtK7IFz
   Cv0TJoRtRGgDfwp9MNTS/+c9TMftLVtYX1RFcwQlTfju5z3OhxbZ070j2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="389431277"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="389431277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 00:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="833474454"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="833474454"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2023 00:23:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI3jX-00B0ki-1g;
        Wed, 18 Jan 2023 10:23:47 +0200
Date:   Wed, 18 Jan 2023 10:23:47 +0200
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
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] drivers: iio: adc: Add ADI MAX77541 ADC Support
Message-ID: <Y8esk8ekNF6S/RVu@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-6-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118063822.14521-6-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:38:12AM +0300, Okan Sahin wrote:
> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.

...

> + * Copyright (c) 2022 Analog Devices, Inc.

HNY!

...

> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>

What for these two?
Make sure the list of inclusions is not semi-random.

> +#include <linux/units.h>

+ Blank line.

> +#include <linux/mfd/max77541.h>

...

> +		*val = DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
> +					 1725);

This is perfectly one line, please, reduce number of LoCs by unwrapping
such cases.

...

> +		if (ret)
> +			return ret;

+ Blank line.

> +		reg_val = FIELD_GET(MAX77541_BITS_MX_CFG1_RNG, reg_val);

-- 
With Best Regards,
Andy Shevchenko


