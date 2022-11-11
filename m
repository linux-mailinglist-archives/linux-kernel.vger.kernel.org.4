Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E462594C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiKKLZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiKKLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:25:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7FC60EBB;
        Fri, 11 Nov 2022 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668165951; x=1699701951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=073BabzyP7Q387pgTQPUA7z0Dqu1AHe4kpWDDx08pSg=;
  b=TyYpgW7Nx1KwFob2aDTHTNF4H45q6CGsDqqDXcD26uOgWnAgRj9cIlL1
   8gV8SqEkfrLp6EwA58mz5FQqf+Q3mhBindFvusnorC7/mPEu2V9rALgmx
   QSk9UI4Z/2bRBz8PejGxSgwwCtPiAquvZqYb+4S+CTsfRgsExXsZ2bwM/
   nIR8I61MlfR5jp/LAKxgNvWl+xDgQw1xszpQ93Y2llr67E2oNg5YfWpZz
   qDRfbcqdbls2VW0pAe1EGJzzlhCgfmvbX/8z+egQb3Jf7XuSBPbsSnV+F
   PHD9yblvfPcEAPZi5CMkoA84Qjf0SqnW2Qn77N2cBJzJ0Pah30mflS8Or
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="311583484"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="311583484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812415062"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="812415062"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2022 03:25:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otSAN-00Afa1-0W;
        Fri, 11 Nov 2022 13:25:47 +0200
Date:   Fri, 11 Nov 2022 13:25:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gazzillo <paul@pgazz.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1]: iio: light: rpr0521: add missing Kconfig
 dependencies
Message-ID: <Y24xOvNVsuLsbBXX@smile.fi.intel.com>
References: <20221110144448.wexu6neb67krqhla@device>
 <20221110214729.ls5ixav5kxpeftk7@device>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110214729.ls5ixav5kxpeftk7@device>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:47:29PM -0500, Paul Gazzillo wrote:
> Fix an implicit declaration of function error for rpr0521 under some configs
> 
> When CONFIG_RPR0521 is enabled without CONFIG_IIO_TRIGGERED_BUFFER,
> the build results in "implicit declaration of function" errors, e.g.,
>   drivers/iio/light/rpr0521.c:434:3: error: implicit declaration of function
>            'iio_trigger_poll_chained' [-Werror=implicit-function-declaration]
>     434 |   iio_trigger_poll_chained(data->drdy_trigger0);
>         |   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> This fix adds select dependencies to RPR0521's configuration declaration.
> 
> Signed-off-by: Paul Gazzillo <paul@pgazz.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216678

No need to create a bugzilla report on such tiny issues that do actually not
affect the working configurations.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
> V1 -> V2: Cleaned up commit message per reviewer comments and added link
>           to bug report.
> 
>  drivers/iio/light/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 7cf6e8490123..0d4447df7200 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -293,6 +293,8 @@ config RPR0521
>  	tristate "ROHM RPR0521 ALS and proximity sensor driver"
>  	depends on I2C
>  	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here if you want to build support for ROHM's RPR0521
>  	  ambient light and proximity sensor device.
> -- 
> 2.25.1

-- 
With Best Regards,
Andy Shevchenko


