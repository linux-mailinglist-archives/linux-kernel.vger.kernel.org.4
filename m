Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3119762B50B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiKPIX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiKPIXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:23:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970D2A711;
        Wed, 16 Nov 2022 00:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668586884; x=1700122884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6GA/Ve3243TSWaPP1ihLZxseiyBNLkJksN7iaHLvPsw=;
  b=n5XcS0d8ezXPvDQQnJKUEc0pgJTcQdZet6MZDiZMd8wChNibowT9fG1x
   5tmx/yaXDFuhmvYFREO6S3NdJjuC7aTRJKJIxR1mywFLXXHYrMCBB0NdV
   wNaEmWEKk0PSH4QdCtseEJPZ0hwsLhAe9uHmkA98gA18mbjb1zz8CSmCH
   FToj/1c+o3+xzklj9eG7HyaE1bC32EKXmchy3wlv2qpWzKuzzd/p2pNY6
   CEH69qA2+PJ9szSNBsz3bW1oPn64v2U4K4xS00O1fMl2B3zguufTpPzW7
   1lTBbDrw/juIEDVQUwelPmUOTSakqdrLrJ2BhRxQR9dkQvkHsRWPcnj0f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="310112136"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="310112136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="708070099"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="708070099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 00:21:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovDfO-00D2WJ-0G;
        Wed, 16 Nov 2022 10:21:06 +0200
Date:   Wed, 16 Nov 2022 10:21:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] pwm: Don't initialize list head before calling
 list_add()
Message-ID: <Y3SdcQFRDySk3+9f@smile.fi.intel.com>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115211515.3750209-5-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:15:15PM +0100, Uwe Kleine-König wrote:
> list_add() just overwrites the members of the element to add (here:
> chip->list) without any checks, even in the DEBUG_LIST case. So save the
> effort to initialize the list.

This is good patch. I agree with it.

The cause of this code appearing either some older changes, or cargo cult
of the trick similar to when list_del_init() is used against a list node.
(FYI: that trick is useful to simplify the check if the node in question
 belongs to any list, by calling list_empty() against _node_ pointer)

The _add_ case with initialization makes no sense to me,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this patch I'm not sure about. A quick grep shows there are (only?) 40
> more code locations that call INIT_LIST_HEAD just before list_add().
> In my understanding INIT_LIST_HEAD is only to initialize lists, but
> chip->list is not a list, but the data needed to track chip as a list
> member.
> 
> Best regards
> Uwe
> 
>  drivers/pwm/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index b43b24bd3c9f..61bacd8d9b44 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -299,7 +299,6 @@ int pwmchip_add(struct pwm_chip *chip)
>  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>  	}
>  
> -	INIT_LIST_HEAD(&chip->list);
>  	list_add(&chip->list, &pwm_chips);
>  
>  	mutex_unlock(&pwm_lock);
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


