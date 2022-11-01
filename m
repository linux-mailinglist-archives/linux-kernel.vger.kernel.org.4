Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1661505D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKARQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiKARPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:15:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA71A616C;
        Tue,  1 Nov 2022 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322938; x=1698858938;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=lqxwp8kWyS0zgb3uKCh5PiYPqEPws8U/5VSSVUCBt50=;
  b=YPVKoUvw4tZHUy9ki2prx4JlIahirPBb4bLUhb0nDEvnYBRNwelZdvlS
   b3hkCGewk3Gw7EoUsYqnjNo4y8TB8o+dlw2s2h27JcUKgh8qGeqCmSWdg
   THpdhR1zVDnSPyStN8gUQvahmPrYwmizkdtZEAVFKw6ViVBtn1FzJnRdV
   Nem0A3mJj+DWcyBvwCsJzKHCmiVGzNXPsuv7rh8n+vBFWepyi0VUN4GgR
   8lyDv1ydlYyKM7PKXV7BResUktZBkjLFKZruM7mduXqi5WuNV/cXEKTuY
   nxXRIKXUOapJdoypREB521AAA4XH7/7rmAmQYwOjbpki2hoj8ZrvXN2ex
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="288906100"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="288906100"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:15:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665220477"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665220477"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:15:34 -0700
Message-ID: <3fb7dacf-f8a5-f06c-f386-b1b32aa36969@intel.com>
Date:   Tue, 1 Nov 2022 19:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 20/26] mmc: sdhci-uhs2: add irq() and others
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-21-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-21-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> This is a UHS-II version of sdhci's request() operation.
> It handles UHS-II related command interrupts and errors.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 237 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   3 +
>  drivers/mmc/host/sdhci.c      | 106 ++++++++-------
>  drivers/mmc/host/sdhci.h      |   5 +
>  4 files changed, 304 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 41b089ccc200..883e18d849ad 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
>  #include <linux/ktime.h>
>  #include <linux/module.h>
>  #include <linux/mmc/mmc.h>
> @@ -582,6 +583,12 @@ static inline void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
>  						   struct mmc_command *cmd)
>  {
>  }
> +
> +static inline struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
> +							  struct mmc_data *data)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_MMC_SDHCI_EXTERNAL_DMA */
>  
>  static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> @@ -940,6 +947,236 @@ static void sdhci_uhs2_finish_command(struct sdhci_host *host)
>  		__sdhci_finish_mrq(host, cmd->mrq);
>  }
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Request done                                                              *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> +{
> +	unsigned long flags;
> +	struct mmc_request *mrq;
> +	int i;
> +
> +	/* FIXME: UHS2_INITIALIZED, instead? */
> +	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
> +		return sdhci_request_done(host);

Please do not put this check here, and sdhci_request_done()
does not need to be exported.

> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> +		mrq = host->mrqs_done[i];
> +		if (mrq)
> +			break;
> +	}
> +
> +	if (!mrq) {
> +		spin_unlock_irqrestore(&host->lock, flags);
> +		return true;
> +	}
> +
> +	/*
> +	 * Always unmap the data buffers if they were mapped by
> +	 * sdhci_prepare_data() whenever we finish with a request.
> +	 * This avoids leaking DMA mappings on error.
> +	 */
> +	if (host->flags & SDHCI_REQ_USE_DMA) {
> +		struct mmc_data *data = mrq->data;
> +
> +		if (host->use_external_dma && data &&
> +		    (mrq->cmd->error || data->error)) {
> +			struct dma_chan *chan = sdhci_external_dma_channel(host, data);
> +
> +			host->mrqs_done[i] = NULL;
> +			spin_unlock_irqrestore(&host->lock, flags);
> +			dmaengine_terminate_sync(chan);
> +			spin_lock_irqsave(&host->lock, flags);
> +			sdhci_set_mrq_done(host, mrq);
> +		}
> +
> +		sdhci_request_done_dma(host, mrq);
> +	}
> +
> +	/*
> +	 * The controller needs a reset of internal state machines
> +	 * upon error conditions.
> +	 */
> +	if (sdhci_needs_reset(host, mrq)) {
> +		/*
> +		 * Do not finish until command and data lines are available for
> +		 * reset. Note there can only be one other mrq, so it cannot
> +		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> +		 * would both be null.
> +		 */
> +		if (host->cmd || host->data_cmd) {
> +			spin_unlock_irqrestore(&host->lock, flags);
> +			return true;
> +		}
> +
> +		/* Some controllers need this kick or reset won't work here */
> +		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> +			/* This is to force an update */
> +			host->ops->set_clock(host, host->clock);
> +
> +		host->ops->uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +		host->pending_reset = false;
> +	}
> +
> +	host->mrqs_done[i] = NULL;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	if (host->ops->request_done)
> +		host->ops->request_done(host, mrq);
> +	else
> +		mmc_request_done(host->mmc, mrq);
> +
> +	return false;
> +}
> +
> +static void sdhci_uhs2_complete_work(struct work_struct *work)
> +{
> +	struct sdhci_host *host = container_of(work, struct sdhci_host,
> +					       complete_work);

Put a check for UHS2 mode here:

	if (sdhci_uhs2_mode(host)) {
		sdhci_complete_work(work);
		return;
	}

> +
> +	while (!sdhci_uhs2_request_done(host))
> +		;
> +}
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Interrupt handling                                                        *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +
> +	DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
> +	    mmc_hostname(host->mmc), uhs2mask);
> +
> +	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK) {
> +		if (!host->cmd) {
> +			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		host->cmd->error = -EILSEQ;
> +		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
> +			host->cmd->error = -ETIMEDOUT;
> +	}
> +
> +	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK) {
> +		if (!host->data) {
> +			pr_err("%s: Got data interrupt 0x%08x but no data.\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +
> +		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT) {
> +			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			host->data->error = -ETIMEDOUT;
> +		} else if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_ADMA) {
> +			pr_err("%s: ADMA error = 0x %x\n",
> +			       mmc_hostname(host->mmc),
> +			       sdhci_readb(host, SDHCI_ADMA_ERROR));
> +			host->data->error = -EIO;
> +		} else {
> +			host->data->error = -EILSEQ;
> +		}
> +	}
> +
> +	if (host->data && host->data->error)
> +		sdhci_uhs2_finish_data(host);
> +	else
> +		sdhci_finish_mrq(host, cmd->mrq);
> +}
> +
> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	u32 mask = intmask, uhs2mask;
> +
> +	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
> +		goto out;
> +
> +	if (intmask & SDHCI_INT_ERROR) {
> +		uhs2mask = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS);
> +		if (!(uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK))
> +			goto cmd_irq;
> +
> +		/* Clear error interrupts */
> +		sdhci_writel(host, uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK,
> +			     SDHCI_UHS2_ERR_INT_STATUS);
> +
> +		/* Handle error interrupts */
> +		__sdhci_uhs2_irq(host, uhs2mask);
> +
> +		/* Caller, shdci_irq(), doesn't have to care UHS-2 errors */
> +		intmask &= ~SDHCI_INT_ERROR;
> +		mask &= SDHCI_INT_ERROR;
> +	}
> +
> +cmd_irq:
> +	if (intmask & SDHCI_INT_CMD_MASK) {
> +		/* Clear command interrupt */
> +		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
> +
> +		/* Handle command interrupt */
> +		if (intmask & SDHCI_INT_RESPONSE)
> +			sdhci_uhs2_finish_command(host);
> +
> +		/* Caller, shdci_irq(), doesn't have to care UHS-2 command */
> +		intmask &= ~SDHCI_INT_CMD_MASK;
> +		mask &= SDHCI_INT_CMD_MASK;
> +	}
> +
> +	/* Clear already-handled interrupts. */
> +	sdhci_writel(host, mask, SDHCI_INT_STATUS);
> +
> +out:
> +	return intmask;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
> +
> +static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
> +{
> +	struct sdhci_host *host = dev_id;
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	u32 isr;

Put a check for UHS2 mode here:

	if (sdhci_uhs2_mode(host))
		return sdhci_uhs2_thread_irq(irq, dev_id);

> +
> +	while (!sdhci_uhs2_request_done(host))
> +		;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	isr = host->thread_isr;
> +	host->thread_isr = 0;
> +
> +	cmd = host->deferred_cmd;
> +	if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
> +		sdhci_finish_mrq(host, cmd->mrq);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> +		struct mmc_host *mmc = host->mmc;
> +
> +		mmc->ops->card_event(mmc);
> +		mmc_detect_change(mmc, msecs_to_jiffies(200));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 23368448ccd4..d32a8602d045 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -217,5 +217,8 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
>  			  unsigned short vdd);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
> +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 407169468927..e44ede049559 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1268,11 +1268,12 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
>  	return ret;
>  }
>  
> -static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
> -						   struct mmc_data *data)
> +struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
> +					    struct mmc_data *data)
>  {
>  	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_channel);
>  
>  int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> @@ -1522,7 +1523,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
>  }
>  
> -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
>  		((mrq->cmd && mrq->cmd->error) ||
> @@ -1530,8 +1531,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
>  		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
>  }
> +EXPORT_SYMBOL_GPL(sdhci_needs_reset);
>  
> -static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
> +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	int i;
>  
> @@ -1551,6 +1553,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);
>  
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
> @@ -3103,7 +3106,56 @@ static const struct mmc_host_ops sdhci_ops = {
>   *                                                                           *
>  \*****************************************************************************/
>  
> -static bool sdhci_request_done(struct sdhci_host *host)
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
> +{
> +	struct mmc_data *data = mrq->data;
> +
> +	if (data && data->host_cookie == COOKIE_MAPPED) {
> +		if (host->bounce_buffer) {
> +			/*
> +			 * On reads, copy the bounced data into the
> +			 * sglist
> +			 */
> +			if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
> +				unsigned int length = data->bytes_xfered;
> +
> +				if (length > host->bounce_buffer_size) {
> +					pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
> +					       mmc_hostname(host->mmc),
> +					       host->bounce_buffer_size,
> +					       data->bytes_xfered);
> +					/* Cap it down and continue */
> +					length = host->bounce_buffer_size;
> +				}
> +				dma_sync_single_for_cpu(
> +					host->mmc->parent,
> +					host->bounce_addr,
> +					host->bounce_buffer_size,
> +					DMA_FROM_DEVICE);
> +				sg_copy_from_buffer(data->sg,
> +					data->sg_len,
> +					host->bounce_buffer,
> +					length);
> +			} else {
> +				/* No copying, just switch ownership */
> +				dma_sync_single_for_cpu(
> +					host->mmc->parent,
> +					host->bounce_addr,
> +					host->bounce_buffer_size,
> +					mmc_get_dma_dir(data));
> +			}
> +		} else {
> +			/* Unmap the raw data */
> +			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> +				     data->sg_len,
> +				     mmc_get_dma_dir(data));
> +		}
> +		data->host_cookie = COOKIE_UNMAPPED;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
> +
> +bool sdhci_request_done(struct sdhci_host *host)
>  {
>  	unsigned long flags;
>  	struct mmc_request *mrq;
> @@ -3167,48 +3219,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  			sdhci_set_mrq_done(host, mrq);
>  		}
>  
> -		if (data && data->host_cookie == COOKIE_MAPPED) {
> -			if (host->bounce_buffer) {
> -				/*
> -				 * On reads, copy the bounced data into the
> -				 * sglist
> -				 */
> -				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
> -					unsigned int length = data->bytes_xfered;
> -
> -					if (length > host->bounce_buffer_size) {
> -						pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
> -						       mmc_hostname(host->mmc),
> -						       host->bounce_buffer_size,
> -						       data->bytes_xfered);
> -						/* Cap it down and continue */
> -						length = host->bounce_buffer_size;
> -					}
> -					dma_sync_single_for_cpu(
> -						mmc_dev(host->mmc),
> -						host->bounce_addr,
> -						host->bounce_buffer_size,
> -						DMA_FROM_DEVICE);
> -					sg_copy_from_buffer(data->sg,
> -						data->sg_len,
> -						host->bounce_buffer,
> -						length);
> -				} else {
> -					/* No copying, just switch ownership */
> -					dma_sync_single_for_cpu(
> -						mmc_dev(host->mmc),
> -						host->bounce_addr,
> -						host->bounce_buffer_size,
> -						mmc_get_dma_dir(data));
> -				}
> -			} else {
> -				/* Unmap the raw data */
> -				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> -					     data->sg_len,
> -					     mmc_get_dma_dir(data));
> -			}
> -			data->host_cookie = COOKIE_UNMAPPED;
> -		}
> +		sdhci_request_done_dma(host, mrq);
>  	}
>  
>  	host->mrqs_done[i] = NULL;
> @@ -3222,6 +3233,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_request_done);
>  
>  static void sdhci_complete_work(struct work_struct *work)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 1a9924e7972d..49de8fdbd7a3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -861,8 +861,11 @@ int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd);
>  void sdhci_external_dma_release(struct sdhci_host *host);
>  void __sdhci_external_dma_prepare_data(struct sdhci_host *host, struct mmc_command *cmd);
>  void sdhci_external_dma_pre_transfer(struct sdhci_host *host, struct mmc_command *cmd);
> +struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data);
>  #endif
>  bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq);
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_data_common(struct sdhci_host *host);
> @@ -895,6 +898,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
> +bool sdhci_request_done(struct sdhci_host *host);
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  			   dma_addr_t addr, int len, unsigned int cmd);
>  

