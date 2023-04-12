Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB26DF69A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDLNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjDLNMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:12:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D773872B5;
        Wed, 12 Apr 2023 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305131; x=1712841131;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=IaE9TIar/8Q/f49TcghnfQBPGlqCwtawgbt18XgPPGA=;
  b=ImD/k0kA6QAqssn56fiVabs1Qtr1MaixUb6PEjjuFhxhatF3uDOSfeBh
   tej/blzGfwjn2r/aPWwmJVB9q70LRoQE3LFjuaTqA6MHkZKI+c6xUahgB
   vli313G2fz29PGcunD5tCXo8gRi9j3yvHimaWHyO4B2AM7jiqCqADpPMZ
   vnueNQLDO/hGQ2jorlGW/qDFQHor2rSyKe7sKJ1Is3VL5rhKJvVBpv03O
   FzlW5amtZQDVtG1TMhyvvAa0eVfEVUngG/b2Xm8NfrEpEOdq5PSudQdtK
   sStMjy5VDvA/Lu5qshVUTAK13gXx+Lozmio0NAiYEQKj3KOdzbgkcXtEb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="430176656"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="430176656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800311851"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800311851"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:12:08 -0700
Message-ID: <2773a596-146c-ba28-8100-69d9a91db1ff@intel.com>
Date:   Wed, 12 Apr 2023 16:12:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 19/23] mmc: sdhci-uhs2: add irq() and others
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-20-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-20-victor.shih@genesyslogic.com.tw>
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
> This is a UHS-II version of sdhci's request() operation.
> It handles UHS-II related command interrupts and errors.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 215 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   3 +
>  drivers/mmc/host/sdhci.c      | 106 +++++++++--------
>  drivers/mmc/host/sdhci.h      |   5 +
>  4 files changed, 283 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index a9655b9546ea..63f4bfce70b8 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -789,6 +789,221 @@ static void sdhci_uhs2_finish_command(struct sdhci_host *host)
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
> +	if (host->flags & SDHCI_REQ_USE_DMA)
> +		sdhci_request_done_dma(host, mrq);
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
> +		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
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
> +
> +	if (!sdhci_uhs2_mode(host)) {
> +		sdhci_complete_work(work);
> +		return;
> +	}
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
> +	if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
> +		if (!host->cmd) {
> +			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		host->cmd->error = -EILSEQ;
> +		if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
> +			host->cmd->error = -ETIMEDOUT;
> +	}
> +
> +	if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
> +		if (!host->data) {
> +			pr_err("%s: Got data interrupt 0x%08x but no data.\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +
> +		if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
> +			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			host->data->error = -ETIMEDOUT;
> +		} else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
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
> +	if (!sdhci_uhs2_mode(host))
> +		goto out;
> +
> +	if (intmask & SDHCI_INT_ERROR) {
> +		uhs2mask = sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
> +		if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
> +			goto cmd_irq;
> +
> +		/* Clear error interrupts */
> +		sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
> +			     SDHCI_UHS2_INT_STATUS);
> +
> +		/* Handle error interrupts */
> +		__sdhci_uhs2_irq(host, uhs2mask);
> +
> +		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 errors */
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
> +		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 commands */
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
> +
> +	if (!sdhci_uhs2_mode(host))
> +		return sdhci_thread_irq(irq, dev_id);
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
> index 33e03b1b2b80..f733c733c692 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -182,5 +182,8 @@ bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
> +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);

Should forward declare 'struct mmc_request' like 'struct mmc_host'

> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 55725edd4b91..b3cf4a26eed5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -47,6 +47,8 @@
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
>  
> +static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> +

Should not have been removed in previous patch.

>  void sdhci_dumpregs(struct sdhci_host *host)
>  {
>  	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
> @@ -1495,7 +1497,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
>  }
>  
> -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
>  		((mrq->cmd && mrq->cmd->error) ||
> @@ -1503,8 +1505,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
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
> @@ -1524,6 +1527,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);
>  
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
> @@ -3106,6 +3110,55 @@ static const struct mmc_host_ops sdhci_ops = {
>   *                                                                           *
>  \*****************************************************************************/
>  
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

host->mmc->parent -> mmc_dev(host->mmc)

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

host->mmc->parent -> mmc_dev(host->mmc)

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
>  static bool sdhci_request_done(struct sdhci_host *host)
>  {
>  	unsigned long flags;
> @@ -3170,48 +3223,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
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
> @@ -3226,7 +3238,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  	return false;
>  }
>  
> -static void sdhci_complete_work(struct work_struct *work)
> +void sdhci_complete_work(struct work_struct *work)
>  {
>  	struct sdhci_host *host = container_of(work, struct sdhci_host,
>  					       complete_work);
> @@ -3234,6 +3246,7 @@ static void sdhci_complete_work(struct work_struct *work)
>  	while (!sdhci_request_done(host))
>  		;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_complete_work);
>  
>  static void sdhci_timeout_timer(struct timer_list *t)
>  {
> @@ -3689,7 +3702,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  	return result;
>  }
>  
> -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  {
>  	struct sdhci_host *host = dev_id;
>  	struct mmc_command *cmd;
> @@ -3719,6 +3732,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  
>  	return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
>  
>  /*****************************************************************************\
>   *                                                                           *
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 775407dad8da..9e9158f811b1 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -833,6 +833,8 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
>  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
>  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
>  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_data_common(struct sdhci_host *host);
> @@ -862,6 +864,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_complete_work(struct work_struct *work);
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  			   dma_addr_t addr, int len, unsigned int cmd);
>  

