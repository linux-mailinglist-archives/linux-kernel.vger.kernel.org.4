Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617FC615060
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiKARQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiKARPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:15:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488911E3F1;
        Tue,  1 Nov 2022 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322923; x=1698858923;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=zVHriQNNgceV67nghX9qVhthFM9YSTVRkgc2OwY3WZo=;
  b=iTduPlWSBSfcSW7/t5o4cbtu5Jpi1K92hXq38ly+GcI5z2UFANO5YfxK
   gluqjfqyVqtuuIVAxfeafgNAoxDsXwlAWXLGj5vwYxp7DiIlMvb3meD0H
   4hQ48kzQ+933D/1JcfCauWdaKj1dBe42gJnw4htcCBpmXNnH84qkmljGN
   xA02BzaNav6uTKyVCN+q00Ml2K6cPBs1LlOUNj+W79ouovAEu7cZNXkCw
   DdFVcmfx9cWH6vX9zeHqqllqQSp8FUIlmzpvsw94cgADa5zJgkY2a3NDx
   LN3ADjV7ZcMas2QDao1HFZS8/jWUJ1tUAvkdYiyRKf754VPbMPXddG397
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="335863402"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="335863402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:15:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665220361"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665220361"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:15:18 -0700
Message-ID: <c364e412-b91c-b838-9923-bee94677d398@intel.com>
Date:   Tue, 1 Nov 2022 19:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 19/26] mmc: sdhci-uhs2: add request() and others
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-20-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-20-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> This is a sdhci version of mmc's request operation.
> It covers both UHS-I and UHS-II.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 475 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      |  91 ++++---
>  drivers/mmc/host/sdhci.h      |  17 ++
>  3 files changed, 550 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c9d59b8ac37f..41b089ccc200 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
>  #include <linux/module.h>
> +#include <linux/mmc/mmc.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -537,6 +538,479 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
>  	return err;
>  }
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Core functions                                                            *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static void sdhci_uhs2_prepare_data(struct sdhci_host *host,
> +				    struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_initialize_data(host, data);
> +
> +	sdhci_prepare_dma(host, data);
> +
> +	sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
> +	sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
> +}
> +
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +static void sdhci_uhs2_external_dma_prepare_data(struct sdhci_host *host,
> +						 struct mmc_command *cmd)
> +{
> +	if (!sdhci_external_dma_setup(host, cmd)) {
> +		__sdhci_external_dma_prepare_data(host, cmd);
> +	} else {
> +		sdhci_external_dma_release(host);
> +		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> +		       mmc_hostname(host->mmc));
> +		sdhci_uhs2_prepare_data(host, cmd);
> +	}
> +}
> +#else
> +static inline void sdhci_uhs2_external_dma_prepare_data(struct sdhci_host *host,
> +							struct mmc_command *cmd)
> +{
> +	/* This should never happen */
> +	WARN_ON_ONCE(1);
> +}
> +
> +static inline void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +						   struct mmc_command *cmd)
> +{
> +}
> +#endif /* CONFIG_MMC_SDHCI_EXTERNAL_DMA */

Let's skip external DMA support to start with.

> +
> +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	__sdhci_finish_data_common(host);
> +
> +	/*
> +	 *  FIXME: Is this condition needed?
> +	    if (host->mmc->flags & MMC_UHS2_INITIALIZED)
> +	 */

No

> +	__sdhci_finish_mrq(host, data->mrq);
> +}
> +
> +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
> +					 struct mmc_command *cmd)
> +{
> +	u16 mode;
> +	struct mmc_data *data = cmd->data;
> +	u16 arg;
> +
> +	if (!data) {
> +		/* clear Auto CMD settings for no data CMDs */
> +		arg = cmd->uhs2_cmd->arg;
> +		if ((((arg & 0xF) << 8) | ((arg >> 8) & 0xFF)) ==

Please don't open code byte-swapping

This should be an inline function so it can be used again
further below:

#define UHS2_ARG_IOADR_MASK 0xfff

static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
{
	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
}


> +		       UHS2_DEV_CMD_TRANS_ABORT) {

Please wrap at 100 columns instead of 80, here and elsewhere.

> +			mode =  0;
> +		} else {
> +			mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
> +			if (cmd->opcode == MMC_STOP_TRANSMISSION ||
> +			    cmd->opcode == MMC_ERASE)
> +				mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
> +			else
> +				/* send status mode */
> +				if (cmd->opcode == MMC_SEND_STATUS)
> +					mode = 0;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_MMC_DEBUG))

Please don't use CONFIG_MMC_DEBUG

> +			DBG("UHS2 no data trans mode is 0x%x.\n", mode);
> +
> +		sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +		return;
> +	}
> +
> +	WARN_ON(!host->data);
> +
> +	mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
> +	if (data->flags & MMC_DATA_WRITE)
> +		mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
> +
> +	if (data->blocks == 1 &&
> +	    data->blksz != 512 &&
> +	    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
> +	    cmd->opcode != MMC_WRITE_BLOCK) {
> +		mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
> +		mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
> +	}
> +
> +	if (host->flags & SDHCI_REQ_USE_DMA)
> +		mode |= SDHCI_UHS2_TRNS_DMA;
> +
> +	if ((host->mmc->uhs2_ios.is_2L_HD_mode) && !cmd->uhs2_tmode0_flag)
> +		mode |= SDHCI_UHS2_TRNS_2L_HD;
> +
> +	sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG))

Please don't use CONFIG_MMC_DEBUG

> +		DBG("UHS2 trans mode is 0x%x.\n", mode);
> +}
> +
> +static void __sdhci_uhs2_send_command(struct sdhci_host *host,
> +				      struct mmc_command *cmd)
> +{
> +	int i, j;
> +	int cmd_reg;
> +
> +	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {

Not necessary to check MMC_UHS2_INITIALIZED here

> +		if (!cmd->uhs2_cmd) {
> +			pr_err("%s: fatal error, no uhs2_cmd!\n",
> +			       mmc_hostname(host->mmc));
> +			return;
> +		}
> +	}
> +
> +	i = 0;
> +	sdhci_writel(host,
> +		     ((u32)cmd->uhs2_cmd->arg << 16) |
> +				(u32)cmd->uhs2_cmd->header,
> +		     SDHCI_UHS2_CMD_PACKET + i);
> +	i += 4;
> +
> +	/*
> +	 * Per spec, playload (config) should be MSB before sending out.
> +	 * But we don't need convert here because had set payload as
> +	 * MSB when preparing config read/write commands.
> +	 */
> +	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
> +		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j),
> +			     SDHCI_UHS2_CMD_PACKET + i);
> +		i += 4;
> +	}
> +
> +	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
> +		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {

Please don't use CONFIG_MMC_DEBUG

> +		DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
> +		for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
> +			DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
> +			    sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
> +	}
> +
> +	cmd_reg = cmd->uhs2_cmd->packet_len <<
> +		SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT;
> +	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
> +		cmd_reg |= SDHCI_UHS2_COMMAND_DATA;
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmd_reg |= SDHCI_UHS2_COMMAND_CMD12;
> +
> +	/* UHS2 Native ABORT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    ((((cmd->uhs2_cmd->arg & 0xF) << 8) |
> +	    ((cmd->uhs2_cmd->arg >> 8) & 0xFF)) == UHS2_DEV_CMD_TRANS_ABORT))

 From above, can use (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT)

> +		cmd_reg |= SDHCI_UHS2_COMMAND_TRNS_ABORT;
> +
> +	/* UHS2 Native DORMANT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    ((((cmd->uhs2_cmd->arg & 0xF) << 8) |
> +	     ((cmd->uhs2_cmd->arg >> 8) & 0xFF)) ==
> +				UHS2_DEV_CMD_GO_DORMANT_STATE))

 From above, can use (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_GO_DORMANT_STATE)

> +		cmd_reg |= SDHCI_UHS2_COMMAND_DORMANT;
> +
> +	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> +
> +	sdhci_writew(host, cmd_reg, SDHCI_UHS2_COMMAND);
> +}
> +
> +static bool sdhci_uhs2_send_command(struct sdhci_host *host,
> +				    struct mmc_command *cmd)
> +{
> +	int flags;
> +	u32 mask;
> +	unsigned long timeout;
> +
> +	WARN_ON(host->cmd);
> +
> +	/* Initially, a command has no error */
> +	cmd->error = 0;
> +
> +	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
> +		return sdhci_send_command(host, cmd);

No check necessary, can remove, and please do not export
sdhci_send_command().

> +
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmd->flags |= MMC_RSP_BUSY;
> +
> +	mask = SDHCI_CMD_INHIBIT;
> +
> +	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
> +		return false;
> +
> +	host->cmd = cmd;
> +	host->data_timeout = 0;
> +	if (sdhci_data_line_cmd(cmd)) {
> +		WARN_ON(host->data_cmd);
> +		host->data_cmd = cmd;
> +		__sdhci_uhs2_set_timeout(host);
> +	}
> +
> +	if (cmd->data) {
> +		if (host->use_external_dma)

Let's skip external DMA support for now

> +			sdhci_uhs2_external_dma_prepare_data(host, cmd);
> +		else
> +			sdhci_uhs2_prepare_data(host, cmd);
> +	}
> +
> +	sdhci_uhs2_set_transfer_mode(host, cmd);
> +
> +	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> +		WARN_ONCE(1, "Unsupported response type!\n");
> +		/*
> +		 * This does not happen in practice because 136-bit response
> +		 * commands never have busy waiting, so rather than complicate
> +		 * the error path, just remove busy waiting and continue.
> +		 */
> +		cmd->flags &= ~MMC_RSP_BUSY;
> +	}
> +
> +	if (!(cmd->flags & MMC_RSP_PRESENT))
> +		flags = SDHCI_CMD_RESP_NONE;
> +	else if (cmd->flags & MMC_RSP_136)
> +		flags = SDHCI_CMD_RESP_LONG;
> +	else if (cmd->flags & MMC_RSP_BUSY)
> +		flags = SDHCI_CMD_RESP_SHORT_BUSY;
> +	else
> +		flags = SDHCI_CMD_RESP_SHORT;
> +
> +	if (cmd->flags & MMC_RSP_CRC)
> +		flags |= SDHCI_CMD_CRC;
> +	if (cmd->flags & MMC_RSP_OPCODE)
> +		flags |= SDHCI_CMD_INDEX;
> +
> +	timeout = jiffies;
> +	if (host->data_timeout)
> +		timeout += nsecs_to_jiffies(host->data_timeout);
> +	else if (!cmd->data && cmd->busy_timeout > 9000)
> +		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> +	else
> +		timeout += 10 * HZ;
> +	sdhci_mod_timer(host, cmd->mrq, timeout);
> +
> +	if (host->use_external_dma)
> +		sdhci_external_dma_pre_transfer(host, cmd);
> +
> +	__sdhci_uhs2_send_command(host, cmd);
> +
> +	return true;
> +}
> +
> +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> +				     struct mmc_command *cmd,
> +				     unsigned long flags)
> +	__releases(host->lock)
> +	__acquires(host->lock)
> +{
> +	struct mmc_command *deferred_cmd = host->deferred_cmd;
> +	int timeout = 10; /* Approx. 10 ms */
> +	bool present;
> +
> +	while (!sdhci_uhs2_send_command(host, cmd)) {
> +		if (!timeout--) {
> +			pr_err("%s: Controller never released inhibit bit(s).\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			cmd->error = -EIO;
> +			return false;
> +		}
> +
> +		spin_unlock_irqrestore(&host->lock, flags);
> +
> +		usleep_range(1000, 1250);
> +
> +		present = host->mmc->ops->get_cd(host->mmc);
> +
> +		spin_lock_irqsave(&host->lock, flags);
> +
> +		/* A deferred command might disappear, handle that */
> +		if (cmd == deferred_cmd && cmd != host->deferred_cmd)
> +			return true;
> +
> +		if (sdhci_present_error(host, cmd, present))
> +			return false;
> +	}
> +
> +	if (cmd == host->deferred_cmd)
> +		host->deferred_cmd = NULL;
> +
> +	return true;
> +}
> +
> +static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +	u8 resp;
> +	u8 ecode;
> +	bool bReadA0 = 0;
> +	int i;
> +
> +	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
> +		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> +		if (resp & UHS2_RES_NACK_MASK) {
> +			ecode = (resp >> UHS2_RES_ECODE_POS) &
> +				UHS2_RES_ECODE_MASK;
> +			pr_err("%s: NACK is got, ECODE=0x%x.\n",
> +			       mmc_hostname(host->mmc), ecode);
> +		}
> +		bReadA0 = 1;
> +	}
> +
> +	if (cmd->uhs2_resp &&
> +	    cmd->uhs2_resp_len && cmd->uhs2_resp_len <= 20) {
> +		/* Get whole response of some native CCMD, like
> +		 * DEVICE_INIT, ENUMERATE.
> +		 */
> +		for (i = 0; i < cmd->uhs2_resp_len; i++)
> +			cmd->uhs2_resp[i] =
> +				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
> +	} else {
> +		/* Get SD CMD response and Payload for some read
> +		 * CCMD, like INQUIRY_CFG.
> +		 */
> +		/* Per spec (p136), payload field is divided into
> +		 * a unit of DWORD and transmission order within
> +		 * a DWORD is big endian.
> +		 */
> +		if (!bReadA0)
> +			sdhci_readl(host, SDHCI_UHS2_RESPONSE);
> +		for (i = 4; i < 20; i += 4) {
> +			cmd->resp[i / 4 - 1] =
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i) << 24) |
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i + 1)
> +					<< 16) |
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i + 2)
> +					<< 8) |
> +				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i + 3);
> +		}
> +	}
> +}
> +
> +static void sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +
> +	/* FIXME: Is this check necessary? */

No

> +	if (!(host->mmc->flags & MMC_UHS2_SUPPORT)) {
> +		sdhci_finish_command(host);

Please do not export sdhci_finish_command()

> +		return;
> +	}
> +
> +	__sdhci_uhs2_finish_command(host);
> +
> +	host->cmd = NULL;
> +
> +	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
> +		mmc_command_done(host->mmc, cmd->mrq);
> +
> +	/*
> +	 * The host can send and interrupt when the busy state has
> +	 * ended, allowing us to wait without wasting CPU cycles.
> +	 * The busy signal uses DAT0 so this is similar to waiting
> +	 * for data to complete.
> +	 *
> +	 * Note: The 1.0 specification is a bit ambiguous about this
> +	 *       feature so there might be some problems with older
> +	 *       controllers.
> +	 */
> +	if (cmd->flags & MMC_RSP_BUSY) {
> +		if (cmd->data) {
> +			DBG("Cannot wait for busy signal when also doing a data transfer");
> +		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> +			   cmd == host->data_cmd) {
> +			/* Command complete before busy is ended */
> +			return;
> +		}
> +	}
> +
> +	/* Processed actual command. */
> +	if (host->data && host->data_early)
> +		sdhci_uhs2_finish_data(host);
> +
> +	if (!cmd->data)
> +		__sdhci_finish_mrq(host, cmd->mrq);
> +}
> +
> +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	bool present;
> +
> +	/* FIXME: check more flags? */

No, it's fine.

> +	if (!(sdhci_uhs2_mode(host))) {
> +		sdhci_request(mmc, mrq);
> +		return;
> +	}

We need to clear the stop cmd and sbc to prevent the
driver using them.

	mrq->stop = NULL;
	mrq->sbc = NULL;
	if (mrq->data)
		mrq->data->stop = NULL;

> +
> +	/* Firstly check card presence */
> +	present = mmc->ops->get_cd(mmc);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (sdhci_present_error(host, mrq->cmd, present))
> +		goto out_finish;
> +
> +	cmd = mrq->cmd;
> +
> +	if (!sdhci_uhs2_send_command(host, cmd))
> +		goto out_finish;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return;
> +
> +out_finish:
> +	sdhci_finish_mrq(host, mrq);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_request);
> +
> +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!host->mmc->flags & MMC_UHS2_SUPPORT)
> +		return sdhci_request_atomic(mmc, mrq);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (sdhci_present_error(host, mrq->cmd, true)) {
> +		sdhci_finish_mrq(host, mrq);
> +		goto out_finish;
> +	}
> +
> +	cmd = mrq->cmd;
> +
> +	/*
> +	 * The HSQ may send a command in interrupt context without polling
> +	 * the busy signaling, which means we should return BUSY if controller
> +	 * has not released inhibit bits to allow HSQ trying to send request
> +	 * again in non-atomic context. So we should not finish this request
> +	 * here.
> +	 */
> +	if (!sdhci_uhs2_send_command(host, cmd))
> +		ret = -EBUSY;
> +
> +out_finish:
> +	spin_unlock_irqrestore(&host->lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_request_atomic);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -692,6 +1166,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  		sdhci_uhs2_start_signal_voltage_switch;
>  	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
>  	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
> +	host->mmc_host_ops.request = sdhci_uhs2_request;
>  
>  	if (!host->mmc_host_ops.uhs2_detect_init)
>  		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b9db2e976010..407169468927 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -47,8 +47,6 @@
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
>  
> -static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> -
>  void sdhci_dumpregs(struct sdhci_host *host)
>  {
>  	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
> @@ -147,10 +145,11 @@ void sdhci_enable_v4_mode(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
>  
> -static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
> +bool sdhci_data_line_cmd(struct mmc_command *cmd)
>  {
>  	return cmd->data || cmd->flags & MMC_RSP_BUSY;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
>  
>  static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>  {
> @@ -409,7 +408,7 @@ static void sdhci_reinit(struct sdhci_host *host)
>  		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  }
>  
> -static void __sdhci_led_activate(struct sdhci_host *host)
> +void __sdhci_led_activate(struct sdhci_host *host)
>  {
>  	u8 ctrl;
>  
> @@ -420,8 +419,9 @@ static void __sdhci_led_activate(struct sdhci_host *host)
>  	ctrl |= SDHCI_CTRL_LED;
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_led_activate);

The LED functions like __sdhci_led_activate() are not being used
and don't need to be exported.

>  
> -static void __sdhci_led_deactivate(struct sdhci_host *host)
> +void __sdhci_led_deactivate(struct sdhci_host *host)
>  {
>  	u8 ctrl;
>  
> @@ -432,6 +432,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
>  	ctrl &= ~SDHCI_CTRL_LED;
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_led_deactivate);
>  
>  #if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  static void sdhci_led_control(struct led_classdev *led,
> @@ -510,14 +511,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
>  
>  #endif
>  
> -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> -			    unsigned long timeout)
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> +		     unsigned long timeout)
>  {
>  	if (sdhci_data_line_cmd(mrq->cmd))
>  		mod_timer(&host->data_timer, timeout);
>  	else
>  		mod_timer(&host->timer, timeout);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_mod_timer);
>  
>  static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
>  {
> @@ -1098,8 +1100,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  		__sdhci_set_timeout(host, cmd);
>  }
>  
> -static void sdhci_initialize_data(struct sdhci_host *host,
> -				  struct mmc_data *data)
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data)
>  {
>  	WARN_ON(host->data);
>  
> @@ -1112,6 +1113,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
>  	host->data_early = 0;
>  	host->data->bytes_xfered = 0;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_initialize_data);
>  
>  static inline void sdhci_set_block_info(struct sdhci_host *host,
>  					struct mmc_data *data)
> @@ -1134,12 +1136,8 @@ static inline void sdhci_set_block_info(struct sdhci_host *host,
>  	}
>  }
>  
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
>  {
> -	struct mmc_data *data = cmd->data;
> -
> -	sdhci_initialize_data(host, data);
> -
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>  		struct scatterlist *sg;
>  		unsigned int length_mask, offset_mask;
> @@ -1224,6 +1222,16 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	sdhci_set_transfer_irqs(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
> +
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_initialize_data(host, data);
> +
> +	sdhci_prepare_dma(host, data);
>  
>  	sdhci_set_block_info(host, data);
>  }
> @@ -1266,8 +1274,7 @@ static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
>  	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
>  }
>  
> -static int sdhci_external_dma_setup(struct sdhci_host *host,
> -				    struct mmc_command *cmd)
> +int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int ret, i;
>  	enum dma_transfer_direction dir;
> @@ -1320,8 +1327,9 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_setup);
>  
> -static void sdhci_external_dma_release(struct sdhci_host *host)
> +void sdhci_external_dma_release(struct sdhci_host *host)
>  {
>  	if (host->tx_chan) {
>  		dma_release_channel(host->tx_chan);
> @@ -1335,9 +1343,10 @@ static void sdhci_external_dma_release(struct sdhci_host *host)
>  
>  	sdhci_switch_external_dma(host, false);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_release);
>  
> -static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> -					      struct mmc_command *cmd)
> +void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +				       struct mmc_command *cmd)
>  {
>  	struct mmc_data *data = cmd->data;
>  
> @@ -1348,6 +1357,7 @@ static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  
>  	sdhci_set_block_info(host, data);
>  }
> +EXPORT_SYMBOL(__sdhci_external_dma_prepare_data);
>  
>  static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  					    struct mmc_command *cmd)
> @@ -1362,8 +1372,8 @@ static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  	}
>  }
>  
> -static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> -					    struct mmc_command *cmd)
> +void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +				     struct mmc_command *cmd)
>  {
>  	struct dma_chan *chan;
>  
> @@ -1374,6 +1384,7 @@ static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
>  	if (chan)
>  		dma_async_issue_pending(chan);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_pre_transfer);
>  
>  #else
>  
> @@ -1425,11 +1436,11 @@ static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
>  	return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>  }
>  
> -static inline bool sdhci_manual_cmd23(struct sdhci_host *host,
> -				      struct mmc_request *mrq)
> +bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	return mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_manual_cmd23);

Also don't see sdhci_manual_cmd23() being used.
Please check what is being exported.

>  
>  static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>  					 struct mmc_command *cmd,
> @@ -1541,7 +1552,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
>  }
>  
> -static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	if (host->cmd && host->cmd->mrq == mrq)
>  		host->cmd = NULL;
> @@ -1565,15 +1576,17 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  	if (!sdhci_has_requests(host))
>  		sdhci_led_deactivate(host);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);
>  
> -static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	__sdhci_finish_mrq(host, mrq);
>  
>  	queue_work(host->complete_wq, &host->complete_work);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
>  
> -static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
> +void __sdhci_finish_data_common(struct sdhci_host *host)
>  {
>  	struct mmc_command *data_cmd = host->data_cmd;
>  	struct mmc_data *data = host->data;
> @@ -1607,6 +1620,14 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
>  		data->bytes_xfered = 0;
>  	else
>  		data->bytes_xfered = data->blksz * data->blocks;
> +}
> +EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
> +
> +static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	__sdhci_finish_data_common(host);
>  
>  	/*
>  	 * Need to send CMD12 if -
> @@ -1645,12 +1666,13 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
>  	}
>  }
>  
> -static void sdhci_finish_data(struct sdhci_host *host)
> +void sdhci_finish_data(struct sdhci_host *host)
>  {
>  	__sdhci_finish_data(host, false);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_data);

Also don't see sdhci_finish_data() being used.
Please check what is being exported.

>  
> -static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> +bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int flags;
>  	u32 mask;
> @@ -1692,8 +1714,6 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  			sdhci_prepare_data(host, cmd);
>  	}
>  
> -	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> -
>  	sdhci_set_transfer_mode(host, cmd);
>  
>  	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> @@ -1737,13 +1757,16 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	if (host->use_external_dma)
>  		sdhci_external_dma_pre_transfer(host, cmd);
>  
> +	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);

If this move of "sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT)"
is intentional, it should be a separate patch.

> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_send_command);

It is not necessary to export sdhci_send_command()

>  
> -static bool sdhci_present_error(struct sdhci_host *host,
> -				struct mmc_command *cmd, bool present)
> +bool sdhci_present_error(struct sdhci_host *host,
> +			 struct mmc_command *cmd, bool present)
>  {
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		cmd->error = -ENOMEDIUM;
> @@ -1752,6 +1775,7 @@ static bool sdhci_present_error(struct sdhci_host *host,
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_present_error);
>  
>  static bool sdhci_send_command_retry(struct sdhci_host *host,
>  				     struct mmc_command *cmd,
> @@ -1815,7 +1839,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> -static void sdhci_finish_command(struct sdhci_host *host)
> +void sdhci_finish_command(struct sdhci_host *host)
>  {
>  	struct mmc_command *cmd = host->cmd;
>  
> @@ -1868,6 +1892,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  			__sdhci_finish_mrq(host, cmd->mrq);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_command);

It is not necessary to export sdhci_finish_command()

>  
>  static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f049331bd0bc..1a9924e7972d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -850,8 +850,25 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +bool sdhci_data_line_cmd(struct mmc_command *cmd);
>  void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
>  void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_external_dma_release(struct sdhci_host *host);
> +void __sdhci_external_dma_prepare_data(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_external_dma_pre_transfer(struct sdhci_host *host, struct mmc_command *cmd);
> +#endif
> +bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq);
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void __sdhci_finish_data_common(struct sdhci_host *host);
> +bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_finish_command(struct sdhci_host *host);
> +bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cmd, bool present);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);

