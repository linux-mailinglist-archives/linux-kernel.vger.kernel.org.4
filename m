Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612526C19FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjCTPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjCTPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:41:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69641399C8;
        Mon, 20 Mar 2023 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679326367; x=1710862367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kgkj6Y8F+5Jx6zTUBcgjZbkpzW1rHfF/zDqpvU7TZ9Q=;
  b=gZgfANx+OoPM4sPSKewq9yha07+D0tP+XyQbH9Q7HXWRbZgC5CdI7O5f
   0ZciB5DshVLGqSd9xnj+ACEt3mEKK8SrVkixXLjw8hfMJmYFDF8liSrc5
   SqVMDZvJTRh+WwBmtlTUhcH9oVF4pnJjGeH2KxQSDZFvriVvory3q+tb4
   pIyR5g+C1PmqoXKHz73TZdVnXDZKFZu7TXOIV690h4nZeIYHxnxFfkWy3
   kh3E5EszYbyzIvp4RE7YOFTYeGqQFL4BjVOnAABVjg/totCfdGwDHjt1V
   warYSQvIokyI/ptgDhTBwikSLrqXtLOtbprpagNdsqJHzqRaaM+aLol3y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341055247"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="341055247"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 08:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674427438"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="674427438"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2023 08:32:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peHUk-006KXt-2i;
        Mon, 20 Mar 2023 17:32:22 +0200
Date:   Mon, 20 Mar 2023 17:32:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Drop map from handle_mask_sync() parameters
Message-ID: <ZBh8hgdRq+kydPBw@smile.fi.intel.com>
References: <cover.1679323449.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679323449.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:50:14AM -0400, William Breathitt Gray wrote:
> Changes in v3:
>  - Inline dio48gpio->map usage in dio48e_handle_mask_sync() to avoid
>    redefining map parameter
> 
> Remove the map parameter from the struct regmap_irq_chip callback
> handle_mask_sync() because it can be passed via the irq_drv_data
> parameter instead. The gpio-104-dio-48e driver is the only consumer of
> this callback and is thus updated accordingly.
> 
> A couple pending patchsets also utilize handle_mask_sync() [0][1], so
> it'll be useful to merge the changes in this series first to avoid
> subsequent noise adjusting the dependent drivers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I believe this should go to the immutable branch somewhere, so GPIO and regmap
subsystems can pull from.

> [0] https://lore.kernel.org/r/cover.1677515341.git.william.gray@linaro.org/
> [1] https://lore.kernel.org/r/cover.1678106722.git.william.gray@linaro.org/
> 
> William Breathitt Gray (2):
>   gpio: 104-dio-48e: Implement struct dio48e_gpio
>   regmap-irq: Drop map from handle_mask_sync() parameters
> 
>  drivers/base/regmap/regmap-irq.c |  5 ++---
>  drivers/gpio/gpio-104-dio-48e.c  | 37 +++++++++++++++++++++-----------
>  include/linux/regmap.h           |  3 +--
>  3 files changed, 28 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 03810031c91dfe448cd116ee987d5dc4139006f4
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


