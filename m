Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346B36997B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBPOma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjBPOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:42:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66165311C3;
        Thu, 16 Feb 2023 06:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676558545; x=1708094545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5bVsjkDJKcW49tiFh1Ukt7n2ye4PhDRhCc+U/ksoYtI=;
  b=d9LuPDKhPFqx5PY+u513CitQKeEtceahP41j1jLfmA0REPp2uQVDTwEc
   NOOsWQ4r58vRHZvTTxe7XpLvqONVux6XuY77AMbsjPY/f3mpdGIY1MJBZ
   TMAJWyC+6nbDLSfSQOyIsPUhDWbq9nSdPDO2QKudtVBqcLjcJJtCSn0NN
   G6oMoKp2Ujt5nN9Oelrn08xZHHOn4Oca2Emjyn1EnrCzx7U5NbOncPPoX
   JeHru6IrUts0MeiTmHxJlRqDAnLSspzGWsTqyG6TozIHisASknVZTtT3G
   GNI65RxP1Mry+hY34qmkI2wLk1cEdH5L06QMrDI9s2zESfMUXErvOEGw0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359161965"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="359161965"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 06:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="844165526"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="844165526"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2023 06:42:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSfSm-007p7Z-2f;
        Thu, 16 Feb 2023 16:42:20 +0200
Date:   Thu, 16 Feb 2023 16:42:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH] gpio: sim: fix a memory leak
Message-ID: <Y+5AzMxlTC7X2UsM@smile.fi.intel.com>
References: <20230216141555.116219-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216141555.116219-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:15:55PM +0100, Bartosz Golaszewski wrote:
> Fix an inverted logic bug in gpio_sim_remove_hogs() that leads to GPIO
> hog structures never being freed.

Ha-ha, I stared to this code, and in the head I was "okay, this loop is until
chip_label is *not* NULL, so should be fine".

At the same time, "! is hard to process", see for example
2754435d4c82 ("ACPI / battery: get rid of negations in conditions")
which I had suggested.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. But my patch I mentioned looks also good to have, no?

> Fixes: cb8c474e79be ("gpio: sim: new testing module")
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpio-sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 60514bc5454f..9e3893b19e4f 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -736,7 +736,7 @@ static void gpio_sim_remove_hogs(struct gpio_sim_device *dev)
>  
>  	gpiod_remove_hogs(dev->hogs);
>  
> -	for (hog = dev->hogs; !hog->chip_label; hog++) {
> +	for (hog = dev->hogs; hog->chip_label; hog++) {
>  		kfree(hog->chip_label);
>  		kfree(hog->line_name);
>  	}
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


