Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71545EDAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiI1K46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiI1K42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:56:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0E86815;
        Wed, 28 Sep 2022 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664362519; x=1695898519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+TDYU5QRU25pQvN+YMj7pXbvJFKo81V/+d6Y8svzz8o=;
  b=XYU9ho0qIA97cm2c3qYKuV2a6CX1h+NADEZ3/LI3/Ju7F+PwfUK9aQzv
   AhHezHAQi4MOci/uaTy3Cc80NHt+7YtyqOywWO7fQj70QWWd7vDfFDV5K
   HXrMhVRF77lgnY/2k0UkM74mVBUH1Vu0eCqvOFhU4H4prwuq4FoeexazQ
   VsSKFrBVRv1X0GeWbbfdwQk9zpYAovgG6Sk3D/NuFoEkJOJUrzIDjaYx5
   gL8o1AlCVC4fQuqhB++rlSqIT8g6vGDeUdKJKahipdOWVamidPo9HbCyF
   45BWP3qw9LNlOGAXJ/fG05qv7cPJt1I5fSCxMfxJo8ElbSkroeMoEm/Ny
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="284701871"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="284701871"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="764245401"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="764245401"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 03:52:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odUgN-008uE2-0V;
        Wed, 28 Sep 2022 13:52:51 +0300
Date:   Wed, 28 Sep 2022 13:52:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: Increase maximum number of trip points
Message-ID: <YzQngo1g9XrbvpoP@smile.fi.intel.com>
References: <20220927154709.5479-1-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927154709.5479-1-sumeet.r.pawnikar@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 09:17:09PM +0530, Sumeet Pawnikar wrote:
> On one of the Chrome system, if we define more than 12 trip points,
> probe for thermal sensor fails with
> "int3403 thermal: probe of INTC1046:03 failed with error -22"
> and throws an error as
> "thermal_sys: Error: Incorrect number of thermal trips".
> 
> The thermal_zone_device_register() interface needs maximum
> number of trip points supported in a zone as an argument.
> This number can't exceed THERMAL_MAX_TRIPS, which is currently
> set to 12. To address this issue, THERMAL_MAX_TRIPS value
> has to be increased.
> 
> This interface also has an argument to specify a mask of trips
> which are writable. This mask is defined as an int.
> This mask sets the ceiling for increasing maximum number of
> supported trips. With the current implementation, maximum number
> of trips can be supported is 31.
> 
> Also, THERMAL_MAX_TRIPS macro is used in one place only.
> So, remove THERMAL_MAX_TRIPS macro and compare num_trips
> directly with using a macro BITS_PER_TYPE(int)-1.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 15 ++++++++++++++-
>  include/linux/thermal.h        |  2 --
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 50d50cec7774..589dd82fe10c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1212,7 +1212,20 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if (num_trips > THERMAL_MAX_TRIPS || num_trips < 0 || mask >> num_trips) {
> +	/*
> +	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
> +	 * For example, shifting by 32 will result in compiler warning:
> +	 * warning: right shift count >= width of type [-Wshift-count- overflow]
> +	 *
> +	 * Also "mask >> num_trips" will always be true with 32 bit shift.
> +	 * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
> +	 * mask >> 32 = 0x80000000
> +	 * This will result in failure for the below condition.
> +	 *
> +	 * Check will be true when the bit 31 of the mask is set.
> +	 * 32 bit shift will cause overflow of 4 byte integer.
> +	 */
> +	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
>  		pr_err("Incorrect number of thermal trips\n");
>  		return ERR_PTR(-EINVAL);
>  	}
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 1386c713885d..c05f5c78a0f2 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -17,8 +17,6 @@
>  #include <linux/workqueue.h>
>  #include <uapi/linux/thermal.h>
>  
> -#define THERMAL_MAX_TRIPS	12
> -
>  /* invalid cooling state */
>  #define THERMAL_CSTATE_INVALID -1UL
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


