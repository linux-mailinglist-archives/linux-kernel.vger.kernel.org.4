Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9825EC94C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiI0QVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiI0QU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:20:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74AE62E6;
        Tue, 27 Sep 2022 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295657; x=1695831657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fPmwcwWibusnzVeAPQ/NG5NTj0eFT7ARGzWz5OODo54=;
  b=huzWHl8eoA6IzbJu4ZOQV8zEZUeKnj5WpVn6HsDLU1NYK8aOlgTjFeAz
   PvhqpRrmOt8bSFnZuWuw2UnjGdatf6AXGtJJT4kUSSXxXF/fh6Z7kQgr/
   bah457eeH+6GkopLrYaEk00tJTNyXKLpDYXqZG0TMqf3p3VAwZUuz9RY2
   XIcsReYMpF90rDpgwG69OpNxJ4ay+LpQUEcenBlvLlNd3E2gbYOgnSRve
   RjVGFNFto7zlhEJCK+ie1sMi632T3KcUz8UinOrsPOcd31WhG3RLM5n4d
   D2fCV4LJNGJhtuEjUHDpunbrmiTh/MmIRQIRJcTJ1NauBAghG+vkYU7KJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281080399"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="281080399"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="616886251"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="616886251"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2022 09:20:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odDKG-008Wi6-0z;
        Tue, 27 Sep 2022 19:20:52 +0300
Date:   Tue, 27 Sep 2022 19:20:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <YzMi5M9kOTv6uJY6@smile.fi.intel.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
 <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:46:11AM -0700, Dmitry Torokhov wrote:
> The driver is using of_device_id/of_match_ptr() and therefore needs
> to include of.h header. We used to get this definition indirectly via
> inclusion of matrix_keypad.h from twl.h, but we are cleaning up
> matrix_keypad.h from unnecessary includes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2: adjusted patch description
> 
>  drivers/iio/adc/twl4030-madc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index f8f8aea15612..c279c4f2c9b7 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -30,6 +30,7 @@
>  #include <linux/types.h>
>  #include <linux/gfp.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 

-- 
With Best Regards,
Andy Shevchenko


