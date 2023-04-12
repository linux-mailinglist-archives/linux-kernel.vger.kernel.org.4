Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1C6DF6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDLNNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDLNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:12:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88483FA;
        Wed, 12 Apr 2023 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305144; x=1712841144;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=EgQz3m8MrTqcSPbtQcIzNvrOtHwj90y9UXUgCA55/tk=;
  b=Peff0HRYIi4OQRoxfmFcux9kkt9m58Jms01cucs14ZZ0xXfsfXkQzOMx
   wOC/d6I/cyZ+hKOd63RDGndn+znFct9W9c6jex73oaGm9EDW75GMlzCPV
   1VjthVVe4ihSnLjZ7YKPiwQZskYRC0GQphl1K3GGjRNDGxqvyzWHKGoAR
   Dz4+YLMdmScRTFxLeVzTJO4Yv8BL+whTyFZaUG6XWtuGqRAiyh3nP2GEH
   c3ZQRRuxNsrt8eDBcR3VjhIGy2zIDH6fVuVAAGBAuLnQ6cq4EWx4rFQeu
   adstMpMdX2prsjjgPlMntHEZ743VNUHRYTznJlMOAHy2AKC/KiT52OvLn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="430176714"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="430176714"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800311859"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800311859"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:12:21 -0700
Message-ID: <201a16a1-b3bb-8aa9-af42-9683986be417@intel.com>
Date:   Wed, 12 Apr 2023 16:12:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 20/23] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-21-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-21-victor.shih@genesyslogic.com.tw>
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
> This is a UHS-II version of sdhci's add_host/remove_host operation.
> Any sdhci drivers which are capable of handling UHS-II cards must
> call those functions instead of the corresponding sdhci's.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 119 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   2 +
>  drivers/mmc/host/sdhci.c      |   7 +-
>  drivers/mmc/host/sdhci.h      |   3 +
>  4 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 63f4bfce70b8..610780d425bc 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -17,6 +17,7 @@
>  #include <linux/ktime.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/host.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -1004,6 +1005,124 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +/*****************************************************************************\
> + *
> + * Device allocation/registration                                            *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static int __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)

Always returns 0, so change return type to 'void'

> +{
> +	struct mmc_host *mmc;
> +	u32 max_current_caps2;
> +
> +	if (host->version < SDHCI_SPEC_400)
> +		return 0;
> +
> +	mmc = host->mmc;
> +
> +	/* Support UHS2 */
> +	if (caps1 & SDHCI_SUPPORT_UHS2)
> +		mmc->caps2 |= MMC_CAP2_SD_UHS2;
> +
> +	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
> +
> +	if ((caps1 & SDHCI_CAN_VDD2_180) &&
> +	    !max_current_caps2 &&
> +	    !IS_ERR(mmc->supply.vmmc2)) {
> +		/* UHS2 - VDD2 */
> +		int curr = regulator_get_current_limit(mmc->supply.vmmc2);
> +
> +		if (curr > 0) {
> +			/* convert to SDHCI_MAX_CURRENT format */
> +			curr = curr / 1000;  /* convert to mA */
> +			curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
> +			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
> +			max_current_caps2 = curr;
> +		}
> +	}
> +
> +	if (caps1 & SDHCI_CAN_VDD2_180) {
> +		mmc->ocr_avail_uhs2 |= MMC_VDD_165_195;
> +		/*
> +		 * UHS2 doesn't require this. Only UHS-I bus needs to set
> +		 * max current.
> +		 */
> +		mmc->max_current_180_vdd2 = (max_current_caps2 &
> +					SDHCI_MAX_CURRENT_VDD2_180_MASK) *
> +					SDHCI_MAX_CURRENT_MULTIPLIER;

max_current_180_vdd2 is not used.  Does it have a purpose?

> +	} else {
> +		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
> +
> +static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> +{
> +	if (!sdhci_uhs2_mode(host))
> +		return;
> +
> +	if (!dead)
> +		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
> +}
> +
> +int sdhci_uhs2_add_host(struct sdhci_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	int ret;
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	if (host->version >= SDHCI_SPEC_400) {
> +		ret = __sdhci_uhs2_add_host_v4(host, host->caps1);
> +		if (ret)
> +			goto cleanup;
> +	}
> +
> +	if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
> +		/* host doesn't want to enable UHS2 support */
> +		/* FIXME: Do we have to do some cleanup here? */

Please do not leave FIXMEs

> +		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> +
> +	/* overwrite ops */
> +	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
> +		sdhci_uhs2_host_ops_init(host);
> +
> +	host->complete_work_fn = sdhci_uhs2_complete_work;
> +	host->thread_irq_fn    = sdhci_uhs2_thread_irq;
> +
> +	/* LED support not implemented for UHS2 */
> +	host->quirks |= SDHCI_QUIRK_NO_LED;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup2;
> +
> +	return 0;
> +
> +cleanup2:
> +	if (host->version >= SDHCI_SPEC_400)
> +		__sdhci_uhs2_remove_host(host, 0);
> +cleanup:
> +	sdhci_cleanup_host(host);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
> +
> +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> +{
> +	__sdhci_uhs2_remove_host(host, dead);
> +
> +	sdhci_remove_host(host, dead);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
> +
>  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index f733c733c692..5b5b4a8d4f27 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -185,5 +185,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> +int sdhci_uhs2_add_host(struct sdhci_host *host);
> +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b3cf4a26eed5..d976d3a6ff8d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4105,6 +4105,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  
>  	host->max_timeout_count = 0xE;
>  
> +	host->complete_work_fn = sdhci_complete_work;
> +	host->thread_irq_fn    = sdhci_thread_irq;
> +
>  	return host;
>  }
>  
> @@ -4854,7 +4857,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>  	if (!host->complete_wq)
>  		return -ENOMEM;
>  
> -	INIT_WORK(&host->complete_work, sdhci_complete_work);
> +	INIT_WORK(&host->complete_work, host->complete_work_fn);
>  
>  	timer_setup(&host->timer, sdhci_timeout_timer, 0);
>  	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> @@ -4863,7 +4866,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>  
>  	sdhci_init(host, 0);
>  
> -	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
> +	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
>  				   IRQF_SHARED,	mmc_hostname(mmc), host);
>  	if (ret) {
>  		pr_err("%s: Failed to request IRQ %d: %d\n",
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 9e9158f811b1..e16267f5a3c0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -627,6 +627,9 @@ struct sdhci_host {
>  	struct timer_list timer;	/* Timer for timeouts */
>  	struct timer_list data_timer;	/* Timer for data timeouts */
>  
> +	void		(*complete_work_fn)(struct work_struct *work);
> +	irqreturn_t	(*thread_irq_fn)(int irq, void *dev_id);
> +
>  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
>  	struct dma_chan *rx_chan;
>  	struct dma_chan *tx_chan;

