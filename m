Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0E686DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjBAScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjBAScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:32:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44E2D154;
        Wed,  1 Feb 2023 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276335; x=1706812335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lc3QJ57ZITulULY9CL129xfA2Shk7EL+Hu31oUiLs6o=;
  b=KEgzXxW+rLTMblTW9iitpm5iWv+xwsKd9jSjCW68M1bjL/5X4a0RXOh/
   +QPJrVGJZNmBMpTW3z3+cmNpYQtbSHS3wlZB//reqLFDBpEoNVddpbeNH
   IYNuSAiE9jOOWvU24866ZRQ+QNAcBdv1mfK9ePRh7X99ycM4ZgwG8IzNo
   bEpH6Ab8C7ZvBaJS7X3BKN7/oLRbwhbX9vncJZXzglpxlCNSBFCBDHpI6
   y0xSsNpVZdayJsy/1IICw/iVEMQ+/Qxh24Lkiv2p1yitGgLUfDbBPkFre
   wdAYJWhosYeze7Pnr/Q9yq9clE2/77UuuTNT6q5xLECePYlkI2EvGnl9V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="307892311"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="307892311"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658421522"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="658421522"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2023 10:32:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pNHtu-000pXF-1L;
        Wed, 01 Feb 2023 20:32:06 +0200
Date:   Wed, 1 Feb 2023 20:32:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] gpiolib: remove gpio_set_debounce
Message-ID: <Y9qwJtOaKrgB5n+T@smile.fi.intel.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
 <20230127101149.3475929-5-arnd@kernel.org>
 <Y9n8P1rP+cYyoNIH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9n8P1rP+cYyoNIH@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:44:31PM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 27, 2023 at 11:11:46AM +0100, Arnd Bergmann wrote:

...

> > -	return !gpio_get_value(ts->gpio_pendown);
> > +	return !gpiod_get_value(ts->gpio_pendown);
> 
> No, we can not blindly do that without checking annotations on GPIOs.

But this is easy to fix, i.e. use raw API, no?

> > +		ts->gpio_pendown = gpiod_get(&spi->dev, "pendown-gpio", GPIOD_IN);
> 
> Wrong name, you will be looking for "pendown-gpio-gpios".
> 
> Sorry, but I have to NAK this in the current form.

Oh, indeed. On top of that the conversion missing the label to be set.

-- 
With Best Regards,
Andy Shevchenko


