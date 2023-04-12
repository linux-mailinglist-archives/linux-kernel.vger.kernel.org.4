Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2566DF6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjDLNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjDLNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:12:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744647D98;
        Wed, 12 Apr 2023 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305158; x=1712841158;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=qVeWbHRGAIqEz1jKdfVOjBtuxglS/VhwueX2ULE6zhM=;
  b=H0s7p+S3RzvWK6vhX0YG4JW9WrOME8T2Xkp9C7CggliDmN544VWU2u27
   LIQ1wKqAj+UGDz9tabogcXTbiN8vvqVWaSU7Ej9QxireN+YoFde4F90Kl
   iyUyJaw6O+QDabdiDniV+hFOY9DYzeaFbMgwu4YshtypddNVVHerrFUNM
   WxRsHUVNohPeasf2DOXHOT25X8vdqK2BSLS0GF6Ceu5n263MUgRwZc1KV
   kbKFrlyHprwr8wysCVE3lXEkZYo0ia8D/+/z+c0Lbd+2jf3aPGS0IpOzg
   yzmmYpRI5I2CzU+sWRsgBf4gnATO32GC6pXDRGSL3eqyTSNsBPvRnG2xf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="430176770"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="430176770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800311881"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800311881"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:12:34 -0700
Message-ID: <4ca03e58-b1a7-cd97-17fd-f63d86949990@intel.com>
Date:   Wed, 12 Apr 2023 16:12:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 22/23] mmc: sdhci-pci: add UHS-II support framework
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-23-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-23-victor.shih@genesyslogic.com.tw>
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
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> This patch prepares for adding UHS-II support at a specific UHS-II
> capable sdhci-pci controller, GL9755 for now.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
>  drivers/mmc/host/sdhci-pci.h      |  3 +++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 01975d145200..6b5109f7feef 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -40,6 +40,7 @@
>  #include "sdhci.h"
>  #include "sdhci-cqhci.h"
>  #include "sdhci-pci.h"
> +#include "sdhci-uhs2.h"
>  
>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
>  
> @@ -2155,7 +2156,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
>  	if (scratch == (u32)-1)
>  		dead = 1;
>  
> -	sdhci_remove_host(slot->host, dead);
> +	if (slot->chip->fixes && slot->chip->fixes->remove_host)
> +		slot->chip->fixes->remove_host(slot, dead);
> +	else
> +		sdhci_remove_host(slot->host, dead);
>  
>  	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
>  		slot->chip->fixes->remove_slot(slot, dead);
> @@ -2163,6 +2167,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
>  	sdhci_free_host(slot->host);
>  }
>  
> +int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
> +{
> +	return sdhci_uhs2_add_host(slot->host);

This patch does not compile because uhs2 functions
cannot be called yet because config MMC_SDHCI_UHS2
is not yet selected.

Please ensure all patches compile before submitting.

> +}
> +
> +void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
> +{
> +	sdhci_uhs2_remove_host(slot->host, dead);
> +}
> +
>  static void sdhci_pci_runtime_pm_allow(struct device *dev)
>  {
>  	pm_suspend_ignore_children(dev, 1);
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 3661a224fb04..7f4a981c0e63 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -140,6 +140,7 @@ struct sdhci_pci_fixes {
>  	int			(*probe_slot) (struct sdhci_pci_slot *);
>  	int			(*add_host) (struct sdhci_pci_slot *);
>  	void			(*remove_slot) (struct sdhci_pci_slot *, int);
> +	void			(*remove_host) (struct sdhci_pci_slot *, int);
>  
>  #ifdef CONFIG_PM_SLEEP
>  	int			(*suspend) (struct sdhci_pci_chip *);
> @@ -184,6 +185,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>  	return (void *)slot->private;
>  }
>  
> +int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
> +void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
>  #ifdef CONFIG_PM_SLEEP
>  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
>  #endif

