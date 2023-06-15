Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242573160C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbjFOLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbjFOLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:04:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70502949;
        Thu, 15 Jun 2023 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686827081; x=1718363081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H57pO/CEX076YrnRSou7G/dJnvK+TLW2RxUg15snHvk=;
  b=U4VOXo2RwCfIegJF5pSmdAWjmWtPjvekpTWZmFkYn1uBMwZRCCIqbTFz
   DFp7jTyBhIIS/oVVp7aFSuxTaTsBndcdNGLwUFBeAWId494fqZx0Zc6vV
   ZmESZui1VsPg9oa3AMq7rykvnAELLEVZZVydneyKToRcmBnOpeNmwigxe
   uMflVmlGMA0KmI48HDoH5YNh0CLbTO9X3JOq2sKMtULHY/0Q2jKb9zGVO
   itorUHQDbU582HAf5Xdi6tnBsKzWgWKNRHv96SK/eirOdvk2iGSt9Q4ku
   ZcaOYjAk3LyTtFl/PcqhWkRK0BP1MbOTfco4w+0HtRlpTrTB64i5+fUWV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362262543"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="362262543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 04:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="689747450"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="689747450"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 04:04:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9klt-003vLk-2f;
        Thu, 15 Jun 2023 14:04:09 +0300
Date:   Thu, 15 Jun 2023 14:04:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pinctrl: microchip-sgpio: check return value of
 devm_kasprintf()
Message-ID: <ZIrwKaNwEuO/Wgxs@smile.fi.intel.com>
References: <20230615105333.585304-1-claudiu.beznea@microchip.com>
 <20230615105333.585304-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615105333.585304-3-claudiu.beznea@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:53:32PM +0300, Claudiu Beznea wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 7e5ea974e61c ("pinctrl: pinctrl-microchip-sgpio: Add pinctrl driver for Microsemi Serial GPIO")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-microchip-sgpio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> index 4794602316e7..666d8b7cdbad 100644
> --- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
> +++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> @@ -818,6 +818,9 @@ static int microchip_sgpio_register_bank(struct device *dev,
>  	pctl_desc->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%sput",
>  					 dev_name(dev),
>  					 bank->is_input ? "in" : "out");
> +	if (!pctl_desc->name)
> +		return -ENOMEM;
> +
>  	pctl_desc->pctlops = &sgpio_pctl_ops;
>  	pctl_desc->pmxops = &sgpio_pmx_ops;
>  	pctl_desc->confops = &sgpio_confops;
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


