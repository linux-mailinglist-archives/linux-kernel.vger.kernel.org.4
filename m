Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09D86177A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKCH0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:26:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF111FCC;
        Thu,  3 Nov 2022 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667460400; x=1698996400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CpHE2G3QqVHDnZPkmkc79VUG/Cc/JYnEKcdUn1Ya+JU=;
  b=ZRWfnHrPRVCnzvn5EG1SLYSBglUyb+0jPNb5URPHfXJLAV0AKnKB8Kie
   9vYxjgyc2LIeHGwfR6I3NjrAzKf94Xc4iHVYpesd5vd/XBwwrcQF1NmqT
   +s2hzDfxpaAfidZUNHsfiB1PCVwOtMClfdxV8SG9fzi+6BeaxtH4QUVCc
   Mf3tmWZ58SpX5ggp9b55EFrQWfFIz6UhhEQHFqqrPx3AclKwDTQL7Fv2d
   jcMVrTOmvzXEhA5+QFFwnLyM8kId6W96gEdlxhquG5I7RQjqVGE3O9HqT
   /Q1eo1uxO+dmusbXl03VS0gTAZrpbi6w2Bn3nE0AbBWONh9mshuQ48X+l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="292928552"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="292928552"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="629244123"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="629244123"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2022 00:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9479D155; Thu,  3 Nov 2022 09:26:58 +0200 (EET)
Date:   Thu, 3 Nov 2022 09:26:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: intel: Use temporary variable for struct
 device
Message-ID: <Y2NtQgRwkUlU5bMw@black.fi.intel.com>
References: <20221102152915.22995-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152915.22995-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 02, 2022 at 05:29:14PM +0200, Andy Shevchenko wrote:
> Use temporary variable for struct device to make code neater.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index fe5bf2184cbf..e15629348cb5 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -1522,14 +1522,15 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
>  int intel_pinctrl_probe(struct platform_device *pdev,
>  			const struct intel_pinctrl_soc_data *soc_data)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct intel_pinctrl *pctrl;
>  	int i, ret, irq;
>  
> -	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
> +	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);

IMHO &pdev->dev is neater and saves an extra line. I would agree if this
would be something like &foo->bar->baz->dev but it is not.

Anyway, no feelings about this so feel free to add,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

for both patches.
