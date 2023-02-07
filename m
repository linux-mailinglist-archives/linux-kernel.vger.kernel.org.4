Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C550A68D560
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjBGLZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjBGLZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:25:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D344CC0D;
        Tue,  7 Feb 2023 03:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675769152; x=1707305152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrrNI+sdxIjTYWRT6V5G7IQTzWtB4vK0l5iPif60BLQ=;
  b=EiHoHe0rzAUepEEITyLcReOEHVLPoABAu5Cf5CVcTmKCril5AcbwO05t
   d6pjdLo7FaK0o9AwU52nPfuVPDqlIZydhh/bG2k5Z/va/w0s31WJIfPzw
   tWa2zhbG3FZp4FoiLksb4PIQ4ketT5W54GN9IpKyG60LYMOfWeRDoEFuN
   jUrR260VUdj4KXvGQ/WHCwJiYGj2qJnvU5OLKTpS7ahyintuoOvjqc8Er
   svdLE3xpeqoO0GQRs3u2v1yCov/e5N+tvbsaAR88xIshrCqjJPCDYKRnn
   mr+4JSAw47hOVrwXwaq1YHrIWnBWolBERmuJlKw47CMe9lDQ2HDfDKgYg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309128481"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="309128481"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 03:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995697091"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="995697091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2023 03:25:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pPM6d-003aFX-1L;
        Tue, 07 Feb 2023 13:25:47 +0200
Date:   Tue, 7 Feb 2023 13:25:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] gpiolib: remove gpio_set_debounce
Message-ID: <Y+I1Orh74wR5Sese@smile.fi.intel.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
 <20230127101149.3475929-5-arnd@kernel.org>
 <Y9n8P1rP+cYyoNIH@google.com>
 <Y9qwJtOaKrgB5n+T@smile.fi.intel.com>
 <Y9q4d50lSdPn8myb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9q4d50lSdPn8myb@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:07:35AM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 01, 2023 at 08:32:06PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 31, 2023 at 09:44:31PM -0800, Dmitry Torokhov wrote:
> > > On Fri, Jan 27, 2023 at 11:11:46AM +0100, Arnd Bergmann wrote:

...

> > > > -	return !gpio_get_value(ts->gpio_pendown);
> > > > +	return !gpiod_get_value(ts->gpio_pendown);
> > > 
> > > No, we can not blindly do that without checking annotations on GPIOs.
> > 
> > But this is easy to fix, i.e. use raw API, no?
> 
> I'd rather not (I hope I can make this driver respect declared polarity
> at some point), so for debounce we could do:
> 
> 	gpiod_set_debounce(gpio_to_gpiod(), ...);
> 
> in ads7846 for now, and get rid of gpio_set_debounce() as a publc API.

This will work and we can keep it for a while (gpio_to_desc(), I believe you
meant this one, is part of the new API to keep this bridge for the cases like
this).

Arnd, are you going to send a v3? It would be really nice to have less
collisions next cycle if your series is applied.

-- 
With Best Regards,
Andy Shevchenko


