Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFC06DF68D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDLNKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjDLNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:10:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F0D8A79;
        Wed, 12 Apr 2023 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305013; x=1712841013;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=FbamDyUlA1QJgRV4UgkB/TOhIgvtaj6yOTEEAsKW8Gc=;
  b=Txb5dCzUBml/6BFMJXdB2oC4jxXY1Y7L23o4ptYzFKpv4ITitR7BnJmi
   VgZCRizHNZE/MukM2U623gep1mpL1I7SH/yBJNjt/kkMfEyCxt6Bah3Fr
   a6Q3kmEVjBUFxhWuwktWIklaCb4qXepH4o2nss02rvjBgTiRoo6m4Lt8L
   PlmscXvLuQ3uBqR5PsC+gzLwc2DkAIWsp7jievEYyj3ijsMiZCkdoPgF0
   fUDOr9Xjd6zVtEWw8m50RVVwcbOOjbvkhK4bJR0tKxi+/Xsg6H0VlP6/0
   LzKUdeotDBRoFQPqLbn5csievoijbl+JnXZtm1M+zOb+wKmDnPGuRPP+n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343894829"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343894829"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758223835"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758223835"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:09 -0700
Message-ID: <08355847-0639-3ac9-23b6-6788f3ca5400@intel.com>
Date:   Wed, 12 Apr 2023 16:10:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-11-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-11-victor.shih@genesyslogic.com.tw>
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
> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 524d7cb6f2fd..67621eaabafc 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -10,7 +10,9 @@
>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/iopoll.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -49,6 +51,50 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Low level functions                                                       *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> +{
> +	return host->mmc->flags & MMC_UHS2_SUPPORT;
> +}
> +
> +/**
> + * sdhci_uhs2_reset - invoke SW reset
> + * @host: SDHCI host
> + * @mask: Control mask
> + *
> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> + */
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> +{
> +	unsigned long timeout;
> +	u32 val;
> +
> +	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> +
> +	if (mask & SDHCI_UHS2_SW_RESET_FULL)
> +		host->clock = 0;
> +
> +	/* Wait max 100 ms */
> +	timeout = 100000;
> +
> +	/* hw clears the bit when it's done */
> +	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> +				     timeout, true, host, SDHCI_UHS2_SW_RESET)) {
> +		pr_err("%s: %s: Reset 0x%x never completed.\n",
> +					       __func__, mmc_hostname(host->mmc), (int)mask);

CHECK: Alignment should match open parenthesis
#70: FILE: drivers/mmc/host/sdhci-uhs2.c:89:
+               pr_err("%s: %s: Reset 0x%x never completed.\n",
+                                              __func__, mmc_hostname(host->mmc), (int)mask);

> +		pr_err("%s: clean reset bit\n",
> +					       mmc_hostname(host->mmc));

Line wrap not needed

> +		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index e948119348da..6834893eee85 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -178,5 +178,7 @@
>  struct sdhci_host;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +bool sdhci_uhs2_mode(struct sdhci_host *host);
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  
>  #endif /* __SDHCI_UHS2_H */

