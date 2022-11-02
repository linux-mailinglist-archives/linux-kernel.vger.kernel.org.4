Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29E6161CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKBLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKBLda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:33:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307726AF1;
        Wed,  2 Nov 2022 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667388809; x=1698924809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iy88QQ7Z//07Xm3MwcqNIgUXmw+eTUK/8hLerX9AViY=;
  b=Zy0uMG6TuFcuS6RVSpj4DiFxrNyY1LQ9ZXpL1zl9SW6ChwsyCgjjKogA
   oYfZUKqgkxAs8LGyBRqxMvhMZZp2/bGlimkeFOctyXkUyuzUi3KJdFkZY
   3jhzsTA5MmRfXeyJRxfKZXY0AUPFP8yELZ7KIqiF/mMUYcZ4u1W5MvOm4
   fpI2qxCsZEsPUlNhgtTBFV9kJWatuCzgTknj7Rq7mDGaC04i2dit8uJW+
   PrYb9XK/aCKew4+NTsz6cc0euNQ5NEvg3ZpM9z+8Df94wbP7Q42NRv8EV
   0uYVpW1kNOvAMM4tkOYyXNo6n26v+ShHknBrs3UBb6waDl+UCjgTCtbKx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373607109"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="373607109"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723522734"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="723522734"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 04:33:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqBzp-0069Yl-1b;
        Wed, 02 Nov 2022 13:33:25 +0200
Date:   Wed, 2 Nov 2022 13:33:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 09/30] ACPI: sysfs: Use kstrtobool() instead of
 strtobool()
Message-ID: <Y2JVhffdmXkkrIRN@smile.fi.intel.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <57396f1eacfacdb589127499f8ff64225a39e110.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57396f1eacfacdb589127499f8ff64225a39e110.1667336095.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:13:57PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
> 
> The last patch of the serie removes the definition of strtobool().
> 
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/acpi/sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index cc2fe0618178..2d81c742e4d2 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/kstrtox.h>
>  #include <linux/moduleparam.h>
>  
>  #include "internal.h"
> @@ -992,7 +993,7 @@ static ssize_t force_remove_store(struct kobject *kobj,
>  	bool val;
>  	int ret;
>  
> -	ret = strtobool(buf, &val);
> +	ret = kstrtobool(buf, &val);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.34.1
> 
> 

-- 
With Best Regards,
Andy Shevchenko


