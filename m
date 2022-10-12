Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA35FC423
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJLLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJLLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:10:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4169A926A;
        Wed, 12 Oct 2022 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665573042; x=1697109042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7v71ZQ6SrTwwIFCLSZGjWB6QaC6SnhQ7675+Q8eeQw=;
  b=mmiwtnkgTXD1KCWWETqWuvuGBaBcjyZDeQ/0v3ASFyVNzwoCALJXh2XE
   2SNl+QjU6JzHyLrktY6Sn8rhQRMqlY9BMQRFYB60WC9Ua+FcLxupwav3T
   IJZKySypD0eFk+dtSC+6VI+d8yG5Bg4OjENH4dXOjYJKW/GIO1/F4TiFz
   GzZju+vqgFZTK22ym8gSNbkSRgeMGz2yXUlhsfY7P9APRax2fKQo+gMVd
   QDL87MkZUB26XYgTQm0MhLS0OE5XrFJ7LmvUkHVJLVMPXL625HzLK7BNn
   BUxJiMTKXTEA0kS4T4jNUTzEQ6+j05dFG45/MPghNWrHuKIW700B1enQt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="288032305"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="288032305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 04:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="659892843"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="659892843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 12 Oct 2022 04:10:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oiZdG-005nZ6-0q;
        Wed, 12 Oct 2022 14:10:38 +0300
Date:   Wed, 12 Oct 2022 14:10:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 6/7] gpiolib: of: factor out code overriding gpio line
 polarity
Message-ID: <Y0agrWGm5CR3Rk5e@smile.fi.intel.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-6-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v1-6-e01d9d3e7b29@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:19:34PM -0700, Dmitry Torokhov wrote:
> There are several instances where we use a separate property to
> override polarity specified in gpio property. Factor it out into
> a separate function.

...

>  static void of_gpio_flags_quirks(const struct device_node *np,
>  				 const char *propname,
>  				 enum of_gpio_flags *flags,
> @@ -145,7 +167,7 @@ static void of_gpio_flags_quirks(const struct device_node *np,
>  	     (!(strcmp(propname, "enable-gpio") &&
>  		strcmp(propname, "enable-gpios")) &&
>  	      of_device_is_compatible(np, "regulator-gpio")))) {
> -		bool active_low = !of_property_read_bool(np,
> +		bool active_high = of_property_read_bool(np,

Defining

	bool active_high;

at the top of the function will save you a few ugly indented code lines here
and in the next patch.

-- 
With Best Regards,
Andy Shevchenko


