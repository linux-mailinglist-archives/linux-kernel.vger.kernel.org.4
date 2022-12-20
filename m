Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900E46521DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLTN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:58:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFD1ADB6;
        Tue, 20 Dec 2022 05:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671544696; x=1703080696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ENqNGBGxElEKmjL75RbPPosjyOCqTtL2c+cIIbN8kI=;
  b=N6xhxa/02pZBmbg+pq0mXXz3i74NnCKzZLAzu5Ae/0EyoneJMrfxggLJ
   t09i9w8QRrffXdsXYxLVltW9yaFkzPCiK3Caa/ctOq2l/o/9ch3IDrN3V
   //tnrkbKjTA3fymgcP4NAY7zi32tB8dBUc5RT2xitaI8h8OXh2jp79ieM
   pUa+BX0p3EyV/jMBDuUcewEgDKt64aoyO9gW4WTdA4QqGLG7VyxVaPHmb
   DhINaMu4e6Tsz+x3Ah1BPTkfB1CPh/ta+mxL+jxRhGgEjDLmLqvV1XVtt
   eU9rDuzl8dnmKCCqOpxwohpTU7mHWtM2xS37jk81OMqiYm2ec9VMQYr01
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="317253079"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="317253079"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 05:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="775319334"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="775319334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2022 05:58:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7d8G-00CtU8-0T;
        Tue, 20 Dec 2022 15:58:12 +0200
Date:   Tue, 20 Dec 2022 15:58:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] gpiolib: of: remove of_get_gpio[_flags]() and
 of_get_named_gpio_flags()
Message-ID: <Y6G/cypRVrpmjeqI@smile.fi.intel.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219192016.1396950-4-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:20:15AM -0800, Dmitry Torokhov wrote:
> There are no more users of these APIs in the mainline kernel, remove
> them. This leaves of_get_named_gpio() as the only legacy OF-specific
> API.

...

> -	desc = of_get_named_gpiod_flags(np, list_name, index, flags);
> +	desc = of_get_named_gpiod_flags(np, propname, index, NULL);

I didn't get it. The commit message and the subject says there are no more
users of these APIs, why is it still here? How is it compiled?

-- 
With Best Regards,
Andy Shevchenko


