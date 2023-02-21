Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060669DFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjBUMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjBUMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:01:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0729419;
        Tue, 21 Feb 2023 04:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676980832; x=1708516832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RaLi51DyYBmxV5gHO49rYM3qINAD1mFdPqb9+oXxEmk=;
  b=Dk7EkvDcciRfWwO0txtI+fZBOsqw1crTAZoREDm/j66dmq3/nGBHu9ZU
   7QJtXN1tGmED1jYsREvR8/F/mMHjFkh1EksPX0mc1U2ald/37v7hX21id
   VzY4s+ulkaIZZlV8KFnDYSlBqzHYTY1TE63ETq8mwDVAAudVDV9b5FoZh
   44yYS104bU/h1UH5gC/T/jp2hF1ee2nhtEQVL+1uOhKD2utHUSFaNDcDl
   sLdXConAjeBdT+YvPVH61hWpDxQ3ObkxljB96IVHwnNqaMz8pBvhl35tx
   kWnT6BAXo+N7kwRGe3ypv+4kzBHxb3Hj6upIBmAuDqUGCE8/v4F9i/wL0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="397299078"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="397299078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 03:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="814484410"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814484410"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2023 03:59:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pURJD-009wVc-2M;
        Tue, 21 Feb 2023 13:59:47 +0200
Date:   Tue, 21 Feb 2023 13:59:47 +0200
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
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: adc: max77541: Add ADI MAX77541 ADC Support
Message-ID: <Y/SyM/r4BUiUivu5@smile.fi.intel.com>
References: <20230221103926.49597-1-okan.sahin@analog.com>
 <20230221103926.49597-4-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221103926.49597-4-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:39:11PM +0300, Okan Sahin wrote:
> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.

...

> +#include <linux/bitfield.h>

> +#include <linux/i2c.h>

Unused header.

> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#include <linux/mfd/max77541.h>

-- 
With Best Regards,
Andy Shevchenko


