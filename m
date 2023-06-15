Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0424731610
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbjFOLFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbjFOLFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:05:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF8270B;
        Thu, 15 Jun 2023 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686827104; x=1718363104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qfEAhnudYzkVSbuLjZT1BqT67D+oNWgnEV4GkiNwhPU=;
  b=I1bbIL9q6bTlLyKOFsLMxPS3k6gvggO50UpSKwRHEdhjT1i8k85/xBX3
   E+/4vUn2SalyAyNnxgNuYNc47necm87WqiQm2DuZgKP3BkaB9xqM93cS1
   8fImWTiMgfZJIiLAJMx+4l3G5CFz+q1hPnWapjoCw3q0dL2Z/uNgSnJM/
   Mwdlmt1mpcniuGN0EknUlAQoL6OAtr81FipGO3cbyr3MvuyP6EpxF8BcN
   sdsBPnxHc5hHhxcEEAGi/4NMKmc6hqCpoNwIQnfV6DSB6zWJWd6WlwOkx
   8PTOVj3mBu2lhJTEpPa+QqIGrx9c0LZIFUebtjCbrImL5BiMy4v0e6w/i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338506450"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="338506450"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 04:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="856908300"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="856908300"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2023 04:04:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9kmV-003vM8-2n;
        Thu, 15 Jun 2023 14:04:47 +0300
Date:   Thu, 15 Jun 2023 14:04:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pinctrl: at91-pio4: check return value of
 devm_kasprintf()
Message-ID: <ZIrwT6ib13SneacJ@smile.fi.intel.com>
References: <20230615105333.585304-1-claudiu.beznea@microchip.com>
 <20230615105333.585304-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615105333.585304-4-claudiu.beznea@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:53:33PM +0300, Claudiu Beznea wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
> Depends-on: 1c4e5c470a56 ("pinctrl: at91: use devm_kasprintf() to avoid potential leaks")
> Depends-on: 5a8f9cf269e8 ("pinctrl: at91-pio4: use proper format specifier for unsigned int")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-at91-pio4.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index e40487be2038..fc7d7155bb8d 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -1146,6 +1146,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
>  		/* Pin naming convention: P(bank_name)(bank_pin_number). */
>  		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%u",
>  						  bank + 'A', line);
> +		if (!pin_desc[i].name)
> +			return -ENOMEM;
>  
>  		group->name = group_names[i] = pin_desc[i].name;
>  		group->pin = pin_desc[i].number;
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


