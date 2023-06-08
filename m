Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CC67279A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjFHIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjFHIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:10:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAD32680;
        Thu,  8 Jun 2023 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686211832; x=1717747832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vFrc17ES9ECx8YcA4w1ryVGKLMWOMSx1wl0ozY1JKrY=;
  b=m5SG4Ebqld3YXwg6hPVYyDGw3o/nFYDvK1+ZiUt2HS5MM9SCoN1FqXLi
   1f2zV5bh75oMlYOTeur5Y0VS4y8oiiEl7k3VtoygcFzz1aKBsy0+uGk5V
   f8h1LSOuY9EZ6leroBDbqqHQBuNIUkhiSc6KmuSctG5BnDIab5mASTQMG
   pf4pcuorAQPeJtB9bsCCR50etc/m8ZQVbxuA+NZshzZuIPhBwM77ZhQdZ
   qKDAbjTs/KHYBHcaoGjxxXPdsPQLTHaWuxk2bh3YUSjHmiVmPyLjbUa8r
   z7ng6jHVYuohFxDkWddbavDBV7vkQ5/6KbKlx26NoGRwytmJeKXYo3oCt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443613075"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="443613075"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="703984037"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="703984037"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2023 01:10:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8544F34F; Thu,  8 Jun 2023 11:10:36 +0300 (EEST)
Date:   Thu, 8 Jun 2023 11:10:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 4/4] pinctrl: intel: simplify exit path of
 gpio_request_enable hook
Message-ID: <20230608081036.GH45886@black.fi.intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
 <20230608070017.28072-5-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608070017.28072-5-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:30:17PM +0530, Raag Jadav wrote:
> Simplify exit path of ->gpio_request_enable() hook
> and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-36 (-36)
> Function                                     old     new   delta
> intel_gpio_request_enable                    186     150     -36
> Total: Before=10431, After=10395, chg -0.35%
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 1b5745202058..947797d87c93 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -489,20 +489,22 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
>  	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>  	void __iomem *padcfg0;
>  	unsigned long flags;
> +	int ret;
>  
>  	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
>  
> +	/* For positive cases */
> +	ret = 0;

You can set it

	int ret = 0;

and drop the useless comment.

> +
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	if (!intel_pad_owned_by_host(pctrl, pin)) {
> -		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out_unlock;
>  	}
>  
> -	if (!intel_pad_is_unlocked(pctrl, pin)) {
> -		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> -		return 0;
> -	}
> +	if (!intel_pad_is_unlocked(pctrl, pin))
> +		goto out_unlock;
>  
>  	/*
>  	 * If pin is already configured in GPIO mode, we assume that
> @@ -510,16 +512,15 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
>  	 * potential glitches on the pin. Otherwise, for the pin in
>  	 * alternative mode, consumer has to supply respective flags.
>  	 */
> -	if (intel_gpio_get_gpio_mode(padcfg0) == PADCFG0_PMODE_GPIO) {
> -		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> -		return 0;
> -	}
> +	if (intel_gpio_get_gpio_mode(padcfg0) == PADCFG0_PMODE_GPIO)
> +		goto out_unlock;
>  
>  	intel_gpio_set_gpio_mode(padcfg0);
>  
> +out_unlock:
>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int intel_gpio_set_direction(struct pinctrl_dev *pctldev,
> -- 
> 2.17.1
