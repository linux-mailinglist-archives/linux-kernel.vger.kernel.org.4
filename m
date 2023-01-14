Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9969C66AB1F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 12:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjANLKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 06:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjANLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:10:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32483659C;
        Sat, 14 Jan 2023 03:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673694611; x=1705230611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1D9B8ljJa6po90IaZ02YVMuX7qkhTni5DjgRb5YMNqQ=;
  b=WAJs3Owsz0w4NEf/mdJL3acf/VV7z7dIReXyfy/VXqXDGOkvi5DBo4ov
   muaxAhJ6X4dFDnjsZ3NyrZ90IhCsYDEOIMX8UufdRhXjAeo0MuCFmyT1u
   Y3O4kSoFCOz7TIEXJNPpMgj9BumL2DGpJ5j3yuuKlvHenPoGqaTY9HZVh
   GN6AVRDXsNFpRGaRhFZQ10DtRJqX/mmaGN/hz9HUcf4D2mPzzQJqJ41cm
   j5hmAc8tmnPjagI2Ww9JAXY2hYrCrSz2kuC4uP/PVar+jwoupOXIc+QnC
   8jsh7GcEE3Cl4dWmLm8q+SsY9zupTuiL/GWzsal0pjk8kFgtA1Jvx6f0i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322883538"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="322883538"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 03:10:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="690765249"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="690765249"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2023 03:10:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGeQG-0097Yz-0e;
        Sat, 14 Jan 2023 13:10:04 +0200
Date:   Sat, 14 Jan 2023 13:10:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v3 2/4] pinctrl: bcm2835: Remove of_node_put() in
 bcm2835_of_gpio_ranges_fallback()
Message-ID: <Y8KNi0HfqN4qksgI@smile.fi.intel.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
 <20230113215352.44272-3-andriy.shevchenko@linux.intel.com>
 <55a87b32-803a-ceb3-4c31-ac818fe69596@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a87b32-803a-ceb3-4c31-ac818fe69596@i2se.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:03:07PM +0100, Stefan Wahren wrote:
> Am 13.01.23 um 22:53 schrieb Andy Shevchenko:
> > Remove wrong of_node_put() in bcm2835_of_gpio_ranges_fallback(),
> > there is no counterpart of_node_get() for it.
> > 
> > Fixes: d2b67744fd99 ("pinctrl: bcm2835: implement hook for missing gpio-ranges")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> thanks for fixing. It seems that i got confused by function name and usage
> in other driver.

You're welcome! Would be nice if you or somebody else have a chance to test
the series.

> Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


