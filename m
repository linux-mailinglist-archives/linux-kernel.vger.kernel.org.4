Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD42602BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJRM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJRM3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:29:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377A3EA7;
        Tue, 18 Oct 2022 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666096172; x=1697632172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PaE+ltoOm4ofs4LgjGMXlY2Byk9Xcbkppn+A/cYaqjM=;
  b=Y9IvJopAe+JXXpohSP6ERAgDC/rins/fwzUjgkXZP0qwvhjJcsZciglX
   ut1YLKUxr59ogh2IqWDrE3yD7sslxSq6qi2CMs4Y6l7DxxeeXmkPxJ4JI
   KynLlCDrOneDmecXi1NKZo7HAJb10qtnznk8EQXeHyWESDbG849UKygnx
   HNXDyFqMxmRCySptB3KnPGU5apacmaRpMRUpvD8CQ5XaVzmThDm7yPorf
   34Vs05XDO7BKqg626l5a4BziAFVsCkPDUDNVjIBPho5/xZoxHcqwgis84
   WxS6IDPk9JILcvEUdgez/5ztK4epzhiHJelrQLseEGTB63boe/yYUol/J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="304826541"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="304826541"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 05:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="659768037"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="659768037"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 05:29:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oklio-009M5d-2g;
        Tue, 18 Oct 2022 15:29:26 +0300
Date:   Tue, 18 Oct 2022 15:29:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pinctrl-intel tree
Message-ID: <Y06cJt+naCww8p5O@smile.fi.intel.com>
References: <20221018131330.75fc1807@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018131330.75fc1807@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:13:30PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pinctrl-intel tree, today's linux-next build (arm64
> defconfig) failed like this:
> 
> 
> Presumably caused by commit
> 
>   e6b665a1c9ae ("pinctrl: Clean up headers")
> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 18 Oct 2022 13:06:39 +1100
> Subject: [PATCH] fix up for "pinctrl: Clean up headers"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/pinctrl/pinctrl-zynqmp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index 1a94db1ffa4f..f2be341f73e1 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -18,6 +18,7 @@
>  #include <linux/firmware/xlnx-zynqmp.h>
>  
>  #include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>

Right, thank you for the fix, I'll incorporate it into the original patch.


-- 
With Best Regards,
Andy Shevchenko


