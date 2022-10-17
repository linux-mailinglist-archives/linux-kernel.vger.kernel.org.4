Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1278B600A85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiJQJZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiJQJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:24:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90C9264BA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665998688; x=1697534688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wh8emsgrObrMqNkJoRJnJr3GCUPybdTK/EPvNZeLNo8=;
  b=XU+HDEocNeDfVihbQxiHutgkFElU1kvaHIDjSnFzIkGfW92Y4Fn+wiPx
   JI0+scZw7JNepqSyTWKMsJJZ0ZnKKaDDKf8xSNnWyN9gJc9rZnXLUfrTc
   2W+wnyuyQu/9EwovSZEVa7LKnfefM3AqIDqiQw/AtUOzvBgxBokUdjQTt
   B+UQ9s2z012R1whnaD/HUTcXDsE7uI19JTsr9ZNuEKHonKFfs7g0h/isU
   XKfpLMIkB202DCgqSp0WdJJHaxWWN/pVgQsiqbGr4Jy6NOpO2oI1CR4xB
   MfzVSFI/M3m59EcaoOPZ2KmLimFflcYIC2OBGAoY6cFEfe5xOpesoSfcs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305740185"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305740185"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="753570687"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="753570687"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2022 02:24:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okMMW-008g12-2c;
        Mon, 17 Oct 2022 12:24:44 +0300
Date:   Mon, 17 Oct 2022 12:24:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] driver core: allow kobj_to_dev() to take a const
 pointer
Message-ID: <Y00fXHoJc9mPH4/A@smile.fi.intel.com>
References: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 12:41:26PM +0200, Greg Kroah-Hartman wrote:
> If a const * to a kobject is passed to kobj_to_dev(), we want to return
> back a const * to a device as the driver core shouldn't be modifying a
> constant structure.  But when dealing with container_of() the pointer
> const attribute is cast away, so we need to manually handle this by
> determining the type of the pointer passed in to know the type of the
> pointer to pass out.
> 
> Luckily _Generic can do this type of magic, and as the kernel now
> supports C11 it is availble to us to handle this type of build-time type
> detection.

I was following this in your branch and I find it good,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2 - use _Generic() to make this type safe as pointed out by Sakari
> 
>  include/linux/device.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 424b55df0272..023ea50b1916 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -680,11 +680,27 @@ struct device_link {
>  	bool supplier_preactivated; /* Owned by consumer probe. */
>  };
>  
> -static inline struct device *kobj_to_dev(struct kobject *kobj)
> +static inline struct device *__kobj_to_dev(struct kobject *kobj)
>  {
>  	return container_of(kobj, struct device, kobj);
>  }
>  
> +static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
> +{
> +	return container_of(kobj, const struct device, kobj);
> +}
> +
> +/*
> + * container_of() will happily take a const * and spit back a non-const * as it
> + * is just doing pointer math.  But we want to be a bit more careful in the
> + * driver code, so manually force any const * of a kobject to also be a const *
> + * to a device.
> + */
> +#define kobj_to_dev(kobj)					\
> +	_Generic((kobj),					\
> +		 const struct kobject *: __kobj_to_dev_const,	\
> +		 struct kobject *: __kobj_to_dev)(kobj)
> +
>  /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
>   *			 by an IOMMU
> -- 
> 2.38.0
> 

-- 
With Best Regards,
Andy Shevchenko


