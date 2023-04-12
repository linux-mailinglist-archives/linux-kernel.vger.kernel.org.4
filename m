Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0D6DF691
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjDLNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDLNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:10:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CB17D98;
        Wed, 12 Apr 2023 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305039; x=1712841039;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=BRXVLSuXsvz0CRk3kP+DzHsqIj3BzwxOiuq0hpkZpXs=;
  b=Av9oH+d3Z8zjTKqqPz2yr6NuH3/fCUOcovZeKZAjUZeQV8np99wK5HNS
   Q+SOkDLbb1ttYDD/alrR8YckE0RmzCk0L0EemHcxnAMybUou0cnGCKKax
   HNqq/zCITPh2lwuqu022GaAMXGNfZTEtCQp/ceZyNJxUzTNTPQ+vytsnp
   MvOau4e6YsS2WLI9+MARSvkmWwfKxE+j/PYimTdFCEPLioBsqUYrwghic
   M1nQbGR++WHstG8Utd7QeQA14fXSW6lxj6bQOIhHuFdlpoK2oLVMjc066
   4nQYhAYW/s1/EcNALf6T5Is8Fyh47MoGI9Sc6YQymc2V3XcWxiUoJLXJq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343895014"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343895014"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758224063"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758224063"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:35 -0700
Message-ID: <ef06dc89-2de2-7607-2938-a5d76875310b@intel.com>
Date:   Wed, 12 Apr 2023 16:10:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 13/23] mmc: sdhci-uhs2: add set_timeout()
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-14-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-14-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/23 13:55, Victor Shih wrote:
> This is a UHS-II version of sdhci's set_timeout() operation.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>  2 files changed, 73 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 388d87537847..e2e9ce51b768 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/iopoll.h>
> +#include <linux/bitfield.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -144,6 +145,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
>  	}
>  }
>  
> +static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
> +{
> +	u8 count;
> +	unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
> +	/* timeout in us */
> +	cmd_res_timeout = 5 * 1000;
> +	dead_lock_timeout = 1 * 1000 * 1000;

Initialization should be combined with declaration,
and by descending line length looks neater i.e.

	unsigned int dead_lock_timeout = 1 * 1000 * 1000;
	unsigned int cmd_res_timeout = 5 * 1000;
	unsigned int current_timeout;
	u8 count;

> +
> +	/*
> +	 * Figure out needed cycles.
> +	 * We do this in steps in order to fit inside a 32 bit int.
> +	 * The first step is the minimum timeout, which will have a
> +	 * minimum resolution of 6 bits:
> +	 * (1) 2^13*1000 > 2^22,
> +	 * (2) host->timeout_clk < 2^16
> +	 *     =>
> +	 *     (1) / (2) > 2^6
> +	 */
> +	count = 0;
> +	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> +	while (current_timeout < cmd_res_timeout) {
> +		count++;
> +		current_timeout <<= 1;
> +		if (count >= 0xF)
> +			break;
> +	}
> +
> +	if (count >= 0xF) {
> +		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
> +		    mmc_hostname(host->mmc), count);
> +		count = 0xE;
> +	}
> +	*cmd_res = count;
> +
> +	count = 0;
> +	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> +	while (current_timeout < dead_lock_timeout) {
> +		count++;
> +		current_timeout <<= 1;
> +		if (count >= 0xF)
> +			break;
> +	}
> +
> +	if (count >= 0xF) {
> +		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
> +		    mmc_hostname(host->mmc), count);
> +		count = 0xE;
> +	}
> +	*dead_lock = count;
> +
> +	return count;
> +}
> +
> +static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
> +{
> +	u8 cmd_res, dead_lock;
> +
> +	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> +	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
> +	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> +}
> +
> +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	__sdhci_set_timeout(host, cmd);
> +
> +	if (sdhci_uhs2_mode(host))
> +		__sdhci_uhs2_set_timeout(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 6834893eee85..fc03a178b676 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -180,5 +180,6 @@ struct sdhci_host;
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);

Really should forward declare 'struct mmc_command' as was done
for 'struct sdhci_host'

>  
>  #endif /* __SDHCI_UHS2_H */

