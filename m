Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E065F5D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjAEVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjAEVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:30:41 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D63D671BC;
        Thu,  5 Jan 2023 13:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672954237; x=1704490237;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=FFE0XiWRyofddQ/OX6bQ1eRX0FhkGMGTtPKvw1Ai3z8=;
  b=oFttxz4x4Zqm32IlYJw+DO4AAtb085Oi5eQhzFp0zhuTg8Onh5Ykv8zf
   jrecgfz/tGunPbxeb7OnC32CIh1OV/QAAzeG3iohZnTXXoDAPpKxDMknA
   kh0WMwi4MdEIDTRXVqhFUhLXycTUfJ8fQwISo4FEdA5Tnr81ROZTDiiNs
   A8KKyH2bg229YFrxTKf43K2QlXi/Rtf4K+2jE/sIaakj2inIJo70up/eg
   T+csKISYGemae1D2R/MH63zWJUMMO6EoYSExddT+a4QnRrc4HtxJQb+sm
   uquvT5ZooaAeomzmeUMc/NPFsYpOesA+/YzhgYOVkkeabsxJ4Lwg/XiHe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305850284"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="305850284"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:30:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="779776806"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="779776806"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:30:33 -0800
Message-ID: <9e15d6a8-6e98-4322-b3b9-0d8b0296dc63@intel.com>
Date:   Thu, 5 Jan 2023 23:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 20/24] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-21-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-21-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 11:00, Victor Shih wrote:
> This is a UHS-II version of sdhci's add_host/remove_host operation.
> Any sdhci drivers which are capable of handling UHS-II cards must
> call those functions instead of the corresponding sdhci's.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 171 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   2 +
>  drivers/mmc/host/sdhci.c      |  28 ++++--
>  drivers/mmc/host/sdhci.h      |  12 +++
>  4 files changed, 204 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 769cf88b21cf..5349173b4f90 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -17,6 +17,7 @@
>  #include <linux/ktime.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/dmaengine.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -1015,6 +1016,176 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
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
> +		mmc->ocr_avail_uhs2 |= MMC_VDD2_165_195;
> +		/*
> +		 * UHS2 doesn't require this. Only UHS-I bus needs to set
> +		 * max current.
> +		 */
> +		mmc->max_current_180_vdd2 = (max_current_caps2 &
> +					SDHCI_MAX_CURRENT_VDD2_180_MASK) *
> +					SDHCI_MAX_CURRENT_MULTIPLIER;
> +	} else {
> +		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
> +
> +static int __sdhci_uhs2_add_host(struct sdhci_host *host)
> +{
> +	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI;
> +	struct mmc_host *mmc = host->mmc;
> +	int ret;
> +
> +	if ((mmc->caps2 & MMC_CAP2_CQE) &&
> +	    (host->quirks & SDHCI_QUIRK_BROKEN_CQE)) {
> +		mmc->caps2 &= ~MMC_CAP2_CQE;
> +		mmc->cqe_ops = NULL;
> +	}
> +
> +	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
> +	if (!host->complete_wq)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&host->complete_work, host->complete_work_fn);
> +
> +	timer_setup(&host->timer, sdhci_timeout_timer, 0);
> +	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> +
> +	init_waitqueue_head(&host->buf_ready_int);
> +
> +	sdhci_init(host, 0);
> +
> +	ret = request_threaded_irq(host->irq, sdhci_irq,
> +				   host->thread_irq_fn,
> +				   IRQF_SHARED,	mmc_hostname(mmc), host);
> +	if (ret) {
> +		pr_err("%s: Failed to request IRQ %d: %d\n",
> +		       mmc_hostname(mmc), host->irq, ret);
> +		goto unwq;
> +	}
> +
> +	ret = mmc_add_host(mmc);
> +		if (ret)
> +			return 1;
> +
> +	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
> +		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
> +		host->use_external_dma ? "External DMA" :
> +		(host->flags & SDHCI_USE_ADMA) ?
> +		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
> +		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
> +
> +	sdhci_enable_card_detection(host);
> +
> +	return 0;
> +
> +unwq:
> +	destroy_workqueue(host->complete_wq);
> +
> +	return ret;
> +}
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
> +		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> +
> +	/* overwrite ops */
> +	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
> +		sdhci_uhs2_host_ops_init(host);
> +
> +	host->complete_work_fn = sdhci_uhs2_complete_work;
> +	host->thread_irq_fn    = sdhci_uhs2_thread_irq;
> +
> +	ret = __sdhci_uhs2_add_host(host);

Please just use __sdhci_add_host() and __sdhci_uhs2_add_host()
is not needed. i.e.

	/* LED support not implemented for UHS2 */
	host->quirks |= SDHCI_QUIRK_NO_LED;

	ret = __sdhci_add_host(host);

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
> index 64b7f356c9fc..b2048c48d056 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -182,5 +182,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> +int sdhci_uhs2_add_host(struct sdhci_host *host);
> +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6c67b79102eb..82ad35f4d1b4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -175,10 +175,11 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
>  
> -static void sdhci_enable_card_detection(struct sdhci_host *host)
> +void sdhci_enable_card_detection(struct sdhci_host *host)
>  {
>  	sdhci_set_card_detection(host, true);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_enable_card_detection);

sdhci_enable_card_detection() does not need to be exported
when __sdhci_uhs2_add_host() is not needed anymore

>  
>  static void sdhci_disable_card_detection(struct sdhci_host *host)
>  {
> @@ -369,7 +370,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>  
> -static void sdhci_init(struct sdhci_host *host, int soft)
> +void sdhci_init(struct sdhci_host *host, int soft)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  	unsigned long flags;
> @@ -395,6 +396,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  		mmc->ops->set_ios(mmc, &mmc->ios);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_init);

Does not need to be exported when __sdhci_uhs2_add_host()
is not needed anymore

>  
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
> @@ -458,7 +460,7 @@ static void sdhci_led_control(struct led_classdev *led,
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> -static int sdhci_led_register(struct sdhci_host *host)
> +int sdhci_led_register(struct sdhci_host *host)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  
> @@ -475,14 +477,16 @@ static int sdhci_led_register(struct sdhci_host *host)
>  
>  	return led_classdev_register(mmc_dev(mmc), &host->led);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_led_register);

sdhci_led_register does not need export

>  
> -static void sdhci_led_unregister(struct sdhci_host *host)
> +void sdhci_led_unregister(struct sdhci_host *host)
>  {
>  	if (host->quirks & SDHCI_QUIRK_NO_LED)
>  		return;
>  
>  	led_classdev_unregister(&host->led);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_led_unregister);

sdhci_led_unregister does not need export

>  
>  static inline void sdhci_led_activate(struct sdhci_host *host)
>  {
> @@ -3265,7 +3269,7 @@ void sdhci_complete_work(struct work_struct *work)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_complete_work);
>  
> -static void sdhci_timeout_timer(struct timer_list *t)
> +void sdhci_timeout_timer(struct timer_list *t)
>  {
>  	struct sdhci_host *host;
>  	unsigned long flags;
> @@ -3286,8 +3290,9 @@ static void sdhci_timeout_timer(struct timer_list *t)
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_timeout_timer);

sdhci_timeout_timer() does not need export
when __sdhci_uhs2_add_host() is not needed anymore

>  
> -static void sdhci_timeout_data_timer(struct timer_list *t)
> +void sdhci_timeout_data_timer(struct timer_list *t)
>  {
>  	struct sdhci_host *host;
>  	unsigned long flags;
> @@ -3318,6 +3323,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_timeout_data_timer);

sdhci_timeout_data_timer() does not need export
when __sdhci_uhs2_add_host() is not needed anymore

>  
>  /*****************************************************************************\
>   *                                                                           *
> @@ -3577,7 +3583,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
>  		data->host_cookie == COOKIE_MAPPED);
>  }
>  
> -static irqreturn_t sdhci_irq(int irq, void *dev_id)
> +irqreturn_t sdhci_irq(int irq, void *dev_id)
>  {
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS] = {0};
>  	irqreturn_t result = IRQ_NONE;
> @@ -3718,6 +3724,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  
>  	return result;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_irq);

sdhci_irq() does not need export
when __sdhci_uhs2_add_host() is not needed anymore

>  
>  irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  {
> @@ -4122,6 +4129,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  
>  	host->max_timeout_count = 0xE;
>  
> +	host->complete_work_fn = sdhci_complete_work;
> +	host->thread_irq_fn    = sdhci_thread_irq;
> +
>  	return host;
>  }
>  
> @@ -4874,7 +4884,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>  	if (!host->complete_wq)
>  		return -ENOMEM;
>  
> -	INIT_WORK(&host->complete_work, sdhci_complete_work);
> +	INIT_WORK(&host->complete_work, host->complete_work_fn);
>  
>  	timer_setup(&host->timer, sdhci_timeout_timer, 0);
>  	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> @@ -4883,7 +4893,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>  
>  	sdhci_init(host, 0);
>  
> -	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
> +	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
>  				   IRQF_SHARED,	mmc_hostname(mmc), host);
>  	if (ret) {
>  		pr_err("%s: Failed to request IRQ %d: %d\n",
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 4979af7cabca..5f090b5ecc61 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -629,6 +629,9 @@ struct sdhci_host {
>  	struct timer_list timer;	/* Timer for timeouts */
>  	struct timer_list data_timer;	/* Timer for data timeouts */
>  
> +	void		(*complete_work_fn)(struct work_struct *work);
> +	irqreturn_t	(*thread_irq_fn)(int irq, void *dev_id);
> +
>  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
>  	struct dma_chan *rx_chan;
>  	struct dma_chan *tx_chan;
> @@ -832,6 +835,12 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  }
>  
>  bool sdhci_data_line_cmd(struct mmc_command *cmd);
> +void sdhci_enable_card_detection(struct sdhci_host *host);
> +void sdhci_init(struct sdhci_host *host, int soft);
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> +int sdhci_led_register(struct sdhci_host *host);
> +void sdhci_led_unregister(struct sdhci_host *host);
> +#endif

Export of sdhci_led_register and sdhci_led_unregister
is not needed

>  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
>  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
>  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> @@ -875,6 +884,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
>  void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
>  void sdhci_complete_work(struct work_struct *work);
> +void sdhci_timeout_timer(struct timer_list *t);
> +void sdhci_timeout_data_timer(struct timer_list *t);

sdhci_timeout_timer() and sdhci_timeout_data_timer()
do not need export when __sdhci_uhs2_add_host()
is not needed anymore

> +irqreturn_t sdhci_irq(int irq, void *dev_id);

sdhci_irq() does not need export
when __sdhci_uhs2_add_host() is not needed anymore

>  irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  			   dma_addr_t addr, int len, unsigned int cmd);

