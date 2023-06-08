Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0305672799C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjFHIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjFHIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:08:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F261B198B;
        Thu,  8 Jun 2023 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686211697; x=1717747697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJ6pKH3So3jM6qCUXzy5YtQH9yot8OdCrGhKXRP0YeQ=;
  b=cJECKiDaAdj8Vi+bDHfa3v3K3OSPAYdJQ70VeuV69Pk9Mlb3EjBr9WhK
   PG8aM2UvEb+k6d8YU5zTp4mQ9C8BXRtThjGRCwqBjYUbRckom0ZDYeZz1
   /bstwYG9lupGVFFKHtIUPYCgscENeY2T3FYVnsiNhZZenYpzGH8F9gN3K
   PNAubG49dm2YWiRXf2H+FTN0XCY5Wc+8/jEbe9uttV6wX1daSzcNsfS1h
   SJ0LHlnsNb9EFnvQfNY9OqtkiQ2ojCkSi/yRPzTpgggqh6NQ6rsRUC9Ff
   GVzg/89Kg5nIyjyWMsdLpd70i10Cnj1XndEIjmLU7PCCYB+GdRw0mfMlU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443612702"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="443612702"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="703983431"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="703983431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2023 01:08:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 836B534F; Thu,  8 Jun 2023 11:08:21 +0300 (EEST)
Date:   Thu, 8 Jun 2023 11:08:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 1/4] pinctrl: intel: optimize set_mux hook
Message-ID: <20230608080821.GF45886@black.fi.intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
 <20230608070017.28072-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608070017.28072-2-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:30:14PM +0530, Raag Jadav wrote:
> Utilize a temporary variable for common shift operation
> inside ->set_mux() hook and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-3 (-3)
> Function                                     old     new   delta
> intel_pinmux_set_mux                         245     242      -3
> Total: Before=10472, After=10469, chg -0.03%

Shouldn't the compiler be able to optimize this if you ask with the -Ox
options?

I don't really see much benefit for "optimizations" like this. That said
using temporary variable here improves readability so this one is
acceptable by me. As long as you change the commit message accordingly.

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index c7a71c49df0a..e8adf2580321 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -411,18 +411,19 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
>  	/* Now enable the mux setting for each pin in the group */
>  	for (i = 0; i < grp->grp.npins; i++) {
>  		void __iomem *padcfg0;
> -		u32 value;
> +		u32 value, pmode;
>  
>  		padcfg0 = intel_get_padcfg(pctrl, grp->grp.pins[i], PADCFG0);
> -		value = readl(padcfg0);
>  
> +		value = readl(padcfg0);
>  		value &= ~PADCFG0_PMODE_MASK;
>  
>  		if (grp->modes)
> -			value |= grp->modes[i] << PADCFG0_PMODE_SHIFT;
> +			pmode = grp->modes[i];
>  		else
> -			value |= grp->mode << PADCFG0_PMODE_SHIFT;
> +			pmode = grp->mode;
>  
> +		value |= pmode << PADCFG0_PMODE_SHIFT;
>  		writel(value, padcfg0);
>  	}
>  
> -- 
> 2.17.1
