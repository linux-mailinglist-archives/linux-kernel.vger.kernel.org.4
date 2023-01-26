Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9567CCA9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjAZNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjAZNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:50:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965756D5D1;
        Thu, 26 Jan 2023 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674741027; x=1706277027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlgYQhKUCyUyofX5/Q0/LeI2rqHQc2RokDpL4ImiC20=;
  b=NS6JaZpAElnWFp/DNF3cZR5MtYR8d60wTaGi9V/EgkC7GKo87do4g3/J
   KZ5sX9aLSRvoJLWF0oECwNHj8WgmG+UNnYsldg1tVR8p4uujtOUkgMCkn
   1oSZDt6BAyJUJMpL/Cphw7PqSwiVFb8rKKatQSAgv7qdrhgZHNihSlxgE
   gHgtHIVsGElIae3MkL74gN1CsiLUe5O5MHtQ/EVL9fz+/WecBymmf0F83
   8VoWuAtyShRp+UCuIx3m/lSybDTJSfzCVDM6s3s9iYi+l9vKMiUeVZwmJ
   XSd7+SPWGbu8DNNRHDZo75c6kCyqbmCDKuLO9gbtwkKYyxH186RTFCFli
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307160294"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="307160294"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:50:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656185209"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="656185209"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2023 05:50:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL2dk-00FQI3-26;
        Thu, 26 Jan 2023 15:50:08 +0200
Date:   Thu, 26 Jan 2023 15:50:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] gpiolib: remove gpio_set_debounce
Message-ID: <Y9KFENOgVGC2bUAj@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126132801.2042371-5-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:27:57PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gpio_set_debounce() only has a single user, which is trivially
> converted to gpiod_set_debounce().

Also need to mention the gpio_cansleep() removal.

P.S. Fun fact that I was yesterday thinking about the pretty much
the same change, except intrusive conversion of the user.

...

>  Documentation/driver-api/gpio/legacy.rst |  2 --

Documentation/translations/zh_CN/driver-api/gpio/legacy.rst:222:                gpio_set_debounce()
Documentation/translations/zh_TW/gpio.txt:229:  gpio_set_debounce()


>  drivers/input/touchscreen/ads7846.c      | 24 +++++++++++++-----------
>  include/linux/gpio.h                     | 22 ----------------------

...

>  #include <linux/of_gpio.h>

Do we need this?

>  #include <linux/of_device.h>
> +#include <linux/gpio/consumer.h>

>  #include <linux/gpio.h>

And this?

-- 
With Best Regards,
Andy Shevchenko


