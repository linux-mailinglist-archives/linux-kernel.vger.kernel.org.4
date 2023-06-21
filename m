Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD06F73855C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjFUNgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjFUNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:36:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD719B1;
        Wed, 21 Jun 2023 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687354564; x=1718890564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MO5jQHVrWgoYawifJrECYV/hrpZREDclWzjSKISkgyw=;
  b=CfbIiRLm9fmXuwnpViccfcl76E/XEC9heJdGeYRZFancyF4wdZTTzAx4
   Gt/8lAmzVtnbZv6b+doTGZz/JuZW6r5lPaK+Ciiw/RzD4uF4CUmcFNpS8
   se5ruhisnsNlSdEvy9v7eKwshELI8yzblHAv8FgZlhpV73Mo6o8c+qGeK
   D+sJqKS2LCHtJRm5uL9M2y6XFNvOgooTEapEXRx8+ohXn8MYzga7s3MEw
   PV3IjDJYWJRzsOlWG6OvQyUq1TtKDvhmmGNdqYJXHHI3EpMMQTWFs55xU
   wwZ5cFai1BOPXO/YbeDmAkACaCntmvS1N6kOcOnwwQyYWtVHVtdek8Fhb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389674899"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="389674899"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804381308"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="804381308"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2023 06:36:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBy09-005Van-02;
        Wed, 21 Jun 2023 16:36:01 +0300
Date:   Wed, 21 Jun 2023 16:36:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: mcp23s08: check return value of
 devm_kasprintf()
Message-ID: <ZJL8wPGxs9SDquQi@smile.fi.intel.com>
References: <20230621100409.1608395-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621100409.1608395-1-claudiu.beznea@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:04:09PM +0300, Claudiu Beznea wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 0f04a81784fe ("pinctrl: mcp23s08: Split to three parts: core, I²C, SPI")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Changes in v2:
> - use independent checks for devm_kasprintf()
> 
>  drivers/pinctrl/pinctrl-mcp23s08_spi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-mcp23s08_spi.c b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
> index 9ae10318f6f3..ea059b9c5542 100644
> --- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
> +++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
> @@ -91,18 +91,28 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
>  		mcp->reg_shift = 0;
>  		mcp->chip.ngpio = 8;
>  		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s08.%d", addr);
> +		if (!mcp->chip.label)
> +			return -ENOMEM;
>  
>  		config = &mcp23x08_regmap;
>  		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
> +		if (!name)
> +			return -ENOMEM;
> +
>  		break;
>  
>  	case MCP_TYPE_S17:
>  		mcp->reg_shift = 1;
>  		mcp->chip.ngpio = 16;
>  		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s17.%d", addr);
> +		if (!mcp->chip.label)
> +			return -ENOMEM;
>  
>  		config = &mcp23x17_regmap;
>  		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
> +		if (!name)
> +			return -ENOMEM;
> +
>  		break;
>  
>  	case MCP_TYPE_S18:
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


