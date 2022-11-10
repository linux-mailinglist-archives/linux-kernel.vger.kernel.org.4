Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CEF6243A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKJNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKJNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:53:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607BAF592;
        Thu, 10 Nov 2022 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668088426; x=1699624426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0Abq70Kn2U1rDgLG0Udj/GQ3BRJ3ke8UA44CN7SjzI=;
  b=iOsgZ8oLZUITI/32aw9Cp2s7I152Udldny4C2l1MRqIpYMy8eFSCmwTe
   7VsVGCqIh7MzAg76jd1ceUnmXl7g29nMxNDccRSMjfYtBTF01P+3Q1f3O
   pahoejTNpuJq5jBTmTwuazR6HzwsTL1wjtYbAkz1olGY2UAkgMOB9p7VI
   mQxpcya9o2uglaiQ6cb7UHt1Q0rII3giEF3OIAwRzHUU4Xreb37yW1OZ1
   wTZBC0LiYpOu5kxSVJ5UITHWYuZ5o7dqP9wUkVqqdUZLis1GTfNIU32D2
   wy19Rnuf9KmoXb06TYTcSDS5BhYf/c7MSa8UFDTZibU8/Wk+/434bPDg4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="298808932"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="298808932"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 05:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="726389441"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="726389441"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2022 05:53:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot7zy-00A9tQ-2O;
        Thu, 10 Nov 2022 15:53:42 +0200
Date:   Thu, 10 Nov 2022 15:53:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpiolib: of: Prepare of_gpiochip_add() /
 of_gpiochip_remove() for fwnode
Message-ID: <Y20CZtHkaLmQj+IP@smile.fi.intel.com>
References: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com>
 <Y2z7IJv2IQy+Mlsh@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2z7IJv2IQy+Mlsh@orome>
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

On Thu, Nov 10, 2022 at 02:22:40PM +0100, Thierry Reding wrote:
> On Tue, Nov 08, 2022 at 03:38:52PM +0200, Andy Shevchenko wrote:

...

> > +	np = to_of_node(chip->fwnode);
> 
> This breaks a number of GPIO controllers on Tegra where chip->fwnode
> ends up never getting set. I also see this break drivers like the MFD-
> based gpio-max77620, so I don't think this is anything specific to the
> Tegra drivers.
> 
> Looking at how fwnode handling works, it seems like we're checking the
> wrong value here, since chip->fwnode is only for explicit overrides of
> the fwnode value.
> 
> The below patch fixes the regression for me:

Thank you! Can you submit it as a formal fix? (Also see below)
Of if Bart prefers I can respin fixed verison. Bart?

...

> -       np = to_of_node(chip->fwnode);
> +       np = to_of_node(chip->gpiodev->dev.fwnode);

dev_fwnode(&chip->gpiodev->dev)

...


Your report makes me wonder if I can Cc you the patch that changes that logic,
so you can help with a testing on OF platforms.

-- 
With Best Regards,
Andy Shevchenko


