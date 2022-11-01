Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412B3615056
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKARPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiKARPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:15:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDB12BC4;
        Tue,  1 Nov 2022 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322893; x=1698858893;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=irOJ4SA5EAUgqC4jj7uhQ3qZtk3dePPGOrs7+s7tSQc=;
  b=OmDjLo08CnFRPuFLG3OaiZGd4J7tV8yQ8yVkXme5km2JldmSHZkRSRaM
   cr9Op4+vMXDh0wHKHOKkH93WX2BW60ie4U/VIDYp/RiCBzeJhGgtHFsmZ
   16Y6h4pGpiNMYqNnoG41UnLyrwHuMAVbgMBN4jkx/9Sle2rwxbLvAP9Rm
   okc+tcaztvdeTuE6t+6H4AkCxlgntKHJoNQhwrlOjk79fH6gqGoTpyYOo
   9Pf0T9cAQRI4SBq9svfa6/94ZHmb3XMWt4USnZV96uXRSbIDFx5uuYBM4
   +rQSIc6c60CZJ6BrF4rYNyCZanI39m6M0mKlrQejG8/Cbl+Ibb1iUca9F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373408400"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373408400"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:14:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665220178"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665220178"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:14:49 -0700
Message-ID: <7d4f7f9e-a54c-c00e-2da7-c3e6dfd79869@intel.com>
Date:   Tue, 1 Nov 2022 19:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 17/26] mmc: sdhci-uhs2: add clock operations
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-18-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-18-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 36 +++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 9ceae552c323..afaca5d96938 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/ktime.h>
>  #include <linux/module.h>
>  
>  #include "sdhci.h"
> @@ -403,6 +404,37 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	if (read_poll_timeout_atomic(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
> +				     10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
> +		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
> +		sdhci_dumpregs(host);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -560,6 +592,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  
>  	if (!host->mmc_host_ops.uhs2_detect_init)
>  		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> +	if (!host->mmc_host_ops.uhs2_disable_clk)
> +		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
> +	if (!host->mmc_host_ops.uhs2_enable_clk)
> +		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;

As mentioned before ->uhs2_disable_clk() and ->uhs2_enable_clk()
are never called.

>  
>  	return 0;
>  }

