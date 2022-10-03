Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD725F303E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJCMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:23:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6C371BC;
        Mon,  3 Oct 2022 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664799829; x=1696335829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gsnnsafqx7vzUkIw3OoEr70TsXPk52RYOnSoQmDkoSE=;
  b=Y3LhgqKI9T/Bu3Co5QGYJugyGRbzjRKx2KVMm0uKS54Eb1zyoSieGqsM
   PxOZ9CDOf23u0a6Ht9RlknpeGAxm8bobYzsg5K2ugkap8nmPzBui9cmJM
   /uwUfmf55ywdngO6u+DIzsiwRdNCISWRoz0E6N1axN3CAxPJfwFoAZa5z
   F2bH2Oz+LvLW4yTGMafMnir4epEHYV/Jo4QblfBkWqbb/iTxO3/xw0DCC
   CNrgk0IfGZCBwU0s7ntdFCkoNcfrtjLiQgTrZ4/Np5ukx4usUlIi5lx9W
   mxepg3ZLUdT+egrLJtCv2Up05PwP++xsQty1Z3dua+NCusvT5hINWHTdO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="329013902"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="329013902"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 05:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="654333747"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="654333747"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2022 05:23:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ofKU3-001WbA-3B;
        Mon, 03 Oct 2022 15:23:43 +0300
Date:   Mon, 3 Oct 2022 15:23:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH] mfd: Add support for UP board CPLD/FPGA
Message-ID: <YzrUT9JlIEjIfTMG@smile.fi.intel.com>
References: <20221001090547.24899-1-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001090547.24899-1-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 05:05:47PM +0800, chengwei wrote:
> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control, onboard LEDs or CEC) through an on-board FPGA.
> 
> This mfd driver implements the line protocol to read and write registers
> from the FPGA through regmap. The register address map is also included.
> 
> The UP boards come with a few FPGA-controlled onboard LEDs:
> * UP Board: yellow, green, red
> * UP Squared: blue, yellow, green, red
> 
> The UP Boards provide a few I/O pin headers (for both GPIO and
> functions), including a 40-pin Raspberry Pi compatible header.
> 
> This patch implements support for the FPGA-based pin controller that
> manages direction and enable state for those header pins.
> 
> Partial support UP boards:
> * UP core + CREX
> * UP core + CRST02

...

> +config LEDS_UPBOARD
> +	tristate "LED support for the UP board"
> +	depends on LEDS_CLASS
> +	depends on MFD_UPBOARD_FPGA
> +	help
> +	  This option enables support for the UP board LEDs. The UP boards come
> +	  with a few FPGA-controlled onboard LEDs. The UP Squared includes 4 LEDs
> +	  (yellow, green, red and blue) on the underside of the board which are
> +	  controlled by the pin control FPGA on the board

What would be the module name?

Also take care in every comment and text of the English grammar and
punctuation. (Here, for example, the trailing period is missed)

...

> +// SPDX-License-Identifier: GPL-2.0-only

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

This text is redundant as far as SPDX is provided.

...

> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/upboard-fpga.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

Instead of implying the headers by kernel.h, please revisit this list and add
what you are using (like container_of.h, types.h, etc).

...

> +struct upboard_led {
> +	struct regmap_field *field;
> +	struct led_classdev cdev;
> +};

If you put cdev as a first member it may decrease a code size, but check this
with bloat-o-meter.

...

> +static enum led_brightness upboard_led_brightness_get(struct led_classdev
> +						      *cdev)

Wrong indentation. Why not to put on one line?
Same Q to other similar places.

...

> +static int __init upboard_led_probe(struct platform_device *pdev)

__init ?! Haven't your linker issued a warning about section mismatches?

...

> +	struct upboard_fpga * const fpga = dev_get_drvdata(pdev->dev.parent);

fpga is a confusing name since we have the fpga framework in the Linux kernel.
I believe you are talking about cpld, which suits here better.

...

> +	struct upboard_led_data * const pdata = pdev->dev.platform_data;

dev_get_platdata()

...

> +	if (!fpga || !pdata)
> +		return -EINVAL;

When is this true?

...

> +	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "upboard:%s:",
> +					pdata->colour);

> +

Redundant blank line.

> +	if (!led->cdev.name)
> +		return -ENOMEM;

...

> +static struct platform_driver upboard_led_driver = {
> +	.driver = {
> +		.name = "upboard-led",
> +	},
> +};

> +

Ditto.

> +module_platform_driver_probe(upboard_led_driver, upboard_led_probe);

> +MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
> +MODULE_DESCRIPTION("UP Board LED driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:upboard-led");

> +

Why is this?

...

> +config MFD_UPBOARD_FPGA
> +	tristate "Support for the UP board FPGA"
> +	select MFD_CORE
> +	help
> +	  Select this option to enable the UP and UP^2 on-board FPGA. The UP
> +	  board implements certain features (pin control, onboard LEDs or CEC)
> +	  through an on-board FPGA. This mfd driver implements the line protocol
> +	  to read and write registers from the FPGA through regmap.

Module name?

...

And seems so on as per LED driver...

I stop my review here. This submission needs more work.

-- 
With Best Regards,
Andy Shevchenko


