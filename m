Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393E74DAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjGJQDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjGJQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:03:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F3187;
        Mon, 10 Jul 2023 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689005004; x=1720541004;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=snIf3bfKT0B5mujO7heoSOANx0kKguuphCxxFibr1xg=;
  b=N3A+60BVb/aHiCZ56W1UkTdVz9L6tMNHWRhBMC9dvKFCX4sDl9np6SM+
   4+iQHzrDmRIV22UCRE2UqHhv4PVTu9D+4qXc+QrQ4Np5BoCYDPLoIY95w
   SMXh6WxSrLpDF+bvxZvBaa5LyVlouyHLLOXZwvDYfo9lNDf3xJ83G7F5r
   aKsF3/igqBwl57x2a+3tkQrbphsCB0osuMPVXxM3sPSNVzbU8z6nNZFA1
   RFybQFVL0YR8VYy9BvlffDGkTu2rw3Q53bl+12hUJX9owJZ00AvXgPzWu
   h4h1Gab3P6zIxMGJj3v4qsfSBQTn2mFkRUYXAjjv9sbqe7qzrB7GRGFdb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364421685"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364421685"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834321001"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834321001"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.97])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:03:17 -0700
Message-ID: <5450f45b-a9ec-013b-201f-4393e5614d9d@intel.com>
Date:   Mon, 10 Jul 2023 19:03:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V8 19/23] mmc: sdhci-uhs2: add irq() and others
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-20-victorshihgli@gmail.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230621100151.6329-20-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/23 13:01, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a UHS-II version of sdhci's request() operation.
> It handles UHS-II related command interrupts and errors.
> 
> Updates in V8:
>  - Forward declare struct mmc_request in sdhci_uhs2.h.
>  - Remove forward declaration of sdhci_send_command().
>  - Use mmc_dev() to simplify code in sdhci_request_done_dma().
> 
> Updates in V7:
>  - Remove unnecessary functions.
>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_irq().
>  - Modify descriptions in sdhci_uhs2_irq().
>  - Cancel export state of some functions.
> 
> Updates in V6:
>  - Remove unnecessary functions.
>  - Add sdhci_uhs2_mode() in sdhci_uhs2_complete_work().
>  - Add sdhci_uhs2_mode() in sdhci_uhs2_thread_irq().
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 215 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   4 +
>  drivers/mmc/host/sdhci.c      | 102 ++++++++--------
>  drivers/mmc/host/sdhci.h      |   5 +
>  4 files changed, 280 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index ed0a41c97944..f92a5cd5800d 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -782,6 +782,221 @@ static void sdhci_uhs2_finish_command(struct sdhci_host *host)
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
> index a3641c5f8c77..3aa2cb4b39d6 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -176,11 +176,15 @@
>  
>  struct sdhci_host;
>  struct mmc_command;
> +struct mmc_request;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
> +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2f47c4f29bab..144445e9f875 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1497,7 +1497,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
>  }
>  
> -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
>  		((mrq->cmd && mrq->cmd->error) ||
> @@ -1505,8 +1505,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
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
> @@ -1526,6 +1527,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);

sdhci_set_mrq_done() does not seem to be used outside sdhci.c
so does not need exporting

>  
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
> @@ -3111,6 +3113,53 @@ static const struct mmc_host_ops sdhci_ops = {
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
> +				dma_sync_single_for_cpu(mmc_dev(host->mmc),
> +							host->bounce_addr,
> +							host->bounce_buffer_size,
> +							DMA_FROM_DEVICE);
> +				sg_copy_from_buffer(data->sg,
> +						    data->sg_len,
> +						    host->bounce_buffer,
> +						    length);
> +			} else {
> +				/* No copying, just switch ownership */
> +				dma_sync_single_for_cpu(mmc_dev(host->mmc),
> +							host->bounce_addr,
> +							host->bounce_buffer_size,
> +							mmc_get_dma_dir(data));
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
> @@ -3175,48 +3224,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
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
> @@ -3231,7 +3239,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  	return false;
>  }
>  
> -static void sdhci_complete_work(struct work_struct *work)
> +void sdhci_complete_work(struct work_struct *work)
>  {
>  	struct sdhci_host *host = container_of(work, struct sdhci_host,
>  					       complete_work);
> @@ -3239,6 +3247,7 @@ static void sdhci_complete_work(struct work_struct *work)
>  	while (!sdhci_request_done(host))
>  		;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_complete_work);
>  
>  static void sdhci_timeout_timer(struct timer_list *t)
>  {
> @@ -3694,7 +3703,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  	return result;
>  }
>  
> -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  {
>  	struct sdhci_host *host = dev_id;
>  	struct mmc_command *cmd;
> @@ -3724,6 +3733,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  
>  	return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
>  
>  /*****************************************************************************\
>   *                                                                           *
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 9a2bd319d94c..20eb0943b402 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -832,6 +832,8 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
>  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
>  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
>  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq);

sdhci_set_mrq_done() does not seem to be used outside sdhci.c
so does not need exporting

>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_data_common(struct sdhci_host *host);
> @@ -861,6 +863,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_complete_work(struct work_struct *work);
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  			   dma_addr_t addr, int len, unsigned int cmd);
>  

