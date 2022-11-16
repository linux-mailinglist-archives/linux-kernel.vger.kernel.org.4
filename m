Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE762C073
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiKPOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiKPOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:07:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D8DDEA4;
        Wed, 16 Nov 2022 06:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668607458; x=1700143458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZOmbfFA9MpXojKad9z8Mmz7PrFNz8/hAL3rc0Yat6aI=;
  b=LDJNyXFBw5LhiB/iJ/qRWeEvzaQJ1mQWI/tj+nqsUZnG7T9lAqHIQ+66
   9sGWpndXt6qbHh3IJDam9Eczbz5JEPwf3xq1YMBSvD+qSoZnqJmMqf8G9
   OUSYWSceiY35wa5wZ3IRFyrtSxo1ra2sQHEuUADtRCxUfc6Cngr9oKEMO
   DQYyzFapqFtIpYfoHb524hhmss7nfi04hk2cBK+dbaoMfROh46oi/zgda
   CYstrOK6ANj/uNj9ZZmjvgw8A1zL7RdhO87RsfYpUEqfJiy9pn7/hmJ+1
   Ez597CdGdXkI5QBeeKKMKXK6+TZl7wE+hdp1YE5Tj7s/wi37gQtTNQgFV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="310177876"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="310177876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:04:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633638476"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633638476"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2022 06:04:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovJ1Q-00D9ao-1x;
        Wed, 16 Nov 2022 16:04:12 +0200
Date:   Wed, 16 Nov 2022 16:04:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] pwm: Mark free pwm IDs as used in alloc_pwms()
Message-ID: <Y3Tt3IvCchpZotk9@smile.fi.intel.com>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115211515.3750209-4-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:15:14PM +0100, Uwe Kleine-König wrote:
> alloc_pwms() only identified a free range of IDs and this range was marked
> as used only later by pwmchip_add(). Instead let alloc_pwms() already do
> the marking (which makes the function actually allocating the range and so
> justifies the function name). This way access to the allocated_pwms
> bitfield is limited to two functions only.

Let's assume that developers will be cautious about properly freeing allocated
resources.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 2338119a09d8..b43b24bd3c9f 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -51,6 +51,8 @@ static int alloc_pwms(unsigned int count)
>  	if (start + count > MAX_PWMS)
>  		return -ENOSPC;
>  
> +	bitmap_set(allocated_pwms, start, count);
> +
>  	return start;
>  }
>  
> @@ -297,8 +299,6 @@ int pwmchip_add(struct pwm_chip *chip)
>  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>  	}
>  
> -	bitmap_set(allocated_pwms, chip->base, chip->npwm);
> -
>  	INIT_LIST_HEAD(&chip->list);
>  	list_add(&chip->list, &pwm_chips);
>  
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


