Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F8680D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjA3MTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjA3MTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:19:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574CC113F4;
        Mon, 30 Jan 2023 04:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675081183; x=1706617183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1A64CrXlXmsDMcdRzJ5WPL9hxJ1L8uyWxo/3ACh4mhY=;
  b=FgtHq8/Em6Jk+gFThhyWfq7fVf88Ex8zuDu4cNRQBx9egHqkKYTXjc8g
   t7AURGuM9O8b2c0u+CT1yNBJDPIG1xhQxFwfugGLp6mPytXfiYtsayQ70
   Rat7NRPzZhEaJXGo6FZTM0m2yVBsCrQZ4pLLTeExd3U5eKBZU1/X8lAL4
   ama8AFXZSDVbstIkls0SLKg2Jn0M/D7bbKRYrCJg4V/5rppCfRSThCeVF
   DYPurnvrkLm1XPmxxhdwwETSZJh3bjrgekyS9mJhP6ENYwc9vLJ1Ssmip
   JRfPEq6tv0PuMdpVInKElTl4ok7QzYeGSUJE6RDD/8XRtKIPl+EVMDw9z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="311162631"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="311162631"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:19:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="909475875"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="909475875"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jan 2023 04:19:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMT8N-00HLD7-0F;
        Mon, 30 Jan 2023 14:19:39 +0200
Date:   Mon, 30 Jan 2023 14:19:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ye.xingchen@zte.com.cn
Cc:     dmitry.torokhov@gmail.com, jonathan.cameron@huawei.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: =?iso-8859-1?Q?st-keysc?=
 =?iso-8859-1?Q?an_-_Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresourc?=
 =?iso-8859-1?B?ZSgp?=
Message-ID: <Y9e12m28aOMlTs0c@smile.fi.intel.com>
References: <202301281611305841413@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281611305841413@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:11:30PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

...

> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
> +	keypad_data->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);

Why?

What we need here is simple devm_platform_ioremap_resource().

-- 
With Best Regards,
Andy Shevchenko


