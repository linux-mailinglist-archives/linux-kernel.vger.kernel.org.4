Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1776DF6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDLNOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDLNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:14:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81068A4C;
        Wed, 12 Apr 2023 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305246; x=1712841246;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=tkZafILnrNqb7bAKqTVOtj7LKjXJAf+lQXg47JBZ8xU=;
  b=SgoibCK6YXwiwofZsf6i2/9KhEhtG5q7exz+JJYot5pM+Zhy5yFkYz0H
   79hEEWtri2yAwnKHC1o6SlPzc2VOtYZUVeqlvlJP3oUNywjz8u8zMzepS
   IZsUT/0OEq4eQPXjsSsYbmej0MdCtXsTEWhmw+x+elduQ6XFzijaHnicX
   OCCvqk3g30d3NOeG6xHeAn+fYHUhGAGxgV1tl0qSZxPHMihJTNLLCpIgu
   vlc8r6UW14cKOMEG+U4BbY/vHNuYSBthYZjimFpCAVK3b/tfVAATgbqKj
   G+m0fMS+JUyJ/xvCnOS+KtfctOQbQdQzroT1lQOVlmvUKOd0ujq6lpN5S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332586929"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332586929"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639228745"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639228745"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:11:24 -0700
Message-ID: <d92adcc7-5303-5d2c-0d41-f28143b3e469@intel.com>
Date:   Wed, 12 Apr 2023 16:11:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 16/23] mmc: sdhci-uhs2: add clock operations
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-17-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-17-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/23 13:55, Victor Shih wrote:
> This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index e2972be1889f..71ac76065886 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/iopoll.h>
>  #include <linux/bitfield.h>
> +#include <linux/ktime.h>

There is no ktime in this patch

>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -328,6 +329,37 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	return 0;
>  }
>  
> +static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	u32 val;
> +	/* 20ms */
> +	int timeout_us = 20000;

Let's put the comment on the end and put the lines in
descending line length i.e.

	int timeout_us = 20000; /* 20ms */
	u32 val;

> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	if (read_poll_timeout_atomic(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
> +				     10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {

atomic does not seem to be needed here

> +		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
> +		sdhci_dumpregs(host);
> +		return 1;

		return -EIO;

> +	}
> +	return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *

