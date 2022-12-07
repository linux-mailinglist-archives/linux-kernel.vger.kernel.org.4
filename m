Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588E16458F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLGLY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiLGLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:24:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737705FB5;
        Wed,  7 Dec 2022 03:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670412258; x=1701948258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SuQ8yuiWhHDzditx1nUGiURlloenwuWIKeWRYDjW8+M=;
  b=eWi2zqSSzwK3hhGE5/++vv1U8FkO3QTrd5SZPEINEPiUe9/QA+Atc26z
   rnlOYUef0WN6anj29qw/Fsy3uEwPAbOeTFwwJhNwDYsZpnwh4TC7estzN
   Oo0uw6UiJKjrO6lkHGJjh8gdMd2a1b6kRE4fzaxrfNLIxLwHZc+TOaxHj
   6qfRpoZSz76wfyLtypHEitcbtZL87Zl9tpBKqu068eFaBXxvsfMChi3te
   QGkzgmi8aHL+p/xKyjX+0qi8bHLS8h6xMDgdJmLPbmgRPJ+mj2O2RYFjU
   EGBY17y5ky7pigcunqcLoDlzR0X5L27HZL1Bl0ekG8gykyxWSKCnCpzEi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343898077"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343898077"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648701494"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="648701494"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2022 03:24:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2sX4-005jvP-1U;
        Wed, 07 Dec 2022 13:24:10 +0200
Date:   Wed, 7 Dec 2022 13:24:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     outreachy@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: drivers: mfd: Add MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y5B32hSYKYsYwzfr@smile.fi.intel.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
 <20221207090906.5896-2-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207090906.5896-2-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 12:08:40PM +0300, Okan Sahin wrote:
> This patch adds MFD driver for MAX77541/MAX77540 to enable its sub
> devices.
> 
> The MAX77541 is a multi-function devices. It includes
> buck converter and ADC.
> 
> The MAX77540 is a high-efficiency buck converter
> with two 3A switching phases.
> 
> They have same regmap except for ADC part of MAX77541.

Same comment as per patch 2.

...

> +	help
> +	  Say yes here to add support for Analog Devices
> +	  MAX77541 and MAX77540 Power Management ICs.
> +	  This driver provides common support for accessing the device;
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.

Arbitrary line lengths.

...

> +		return devm_mfd_add_devices(dev, -1, max77540_devs, ARRAY_SIZE(max77540_devs),

There is a definition for -1, use it.

> +					    NULL, 0, NULL);

...

> +		return devm_mfd_add_devices(dev, -1, max77541_devs, ARRAY_SIZE(max77541_devs),

Ditto.

> +					    NULL, 0, NULL);

...

> +	chip_id = to_i2c_driver(client->dev.driver)->id_table;

> +	if (!chip_data) {
> +		chip_data = (void *)i2c_match_id(chip_id, client)->driver_data;


> +	}

We have a new helper for this.

...

> +		return dev_err_probe(me->dev,  PTR_ERR(me->regmap),
> +					"Failed to allocate register map\n");

Wrong indentation.

...

> +

Redundant blank line.

> +module_i2c_driver(max77541_i2c_driver);

...

> +MODULE_VERSION("1.0");

Why?

...

Missing inclusions:
 - bits.h
 - types.h

Missing forward declarations for:
	struct device
	struct regmap
	struct regmap_irq_chip_data
	...

> +/*      REGISTERS       */

...

> +#define MAX77541_REGMAP_IRQ_REG(_mask)	\
> +	{ .mask = (_mask),  }

When {} are on one line, the trailing comma inside is not needed.

...

> +enum mx_range {
> +	LOW_RANGE,
> +	MID_RANGE,
> +	HIGH_RANGE,

> +	RESERVED

Is it terminator?

> +};

...

> +struct max77541_dev {

> +	void *pdata;

Why do you need this?

> +	struct device *dev;

Isn't it the same as dev inside regmap?

> +	struct regmap_irq_chip_data *irq_data;
> +	struct regmap_irq_chip_data *irq_buck;
> +	struct regmap_irq_chip_data *irq_topsys;
> +	struct regmap_irq_chip_data *irq_adc;

> +	struct i2c_client *i2c;

Is this is really needed? Perhaps regmap below provides what you need, no?

> +	struct regmap *regmap;
> +
> +	u8 type;
> +};

-- 
With Best Regards,
Andy Shevchenko


