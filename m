Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F365F5C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbjAEV3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjAEV3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:29:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4E631BD;
        Thu,  5 Jan 2023 13:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672954169; x=1704490169;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=3wU6x90ba/ia1u6uNLXApEw/RYizM5t2kudzaW2OW2s=;
  b=YHVEdAf4vt3j4ceDXK9MkuwsxuKKn9K5sx+JbgTpUZETUPQOshcVf62D
   U2Sz56Oos6uacwr3qYPS64/V82L8OxmHWYY2E0gPbVVjbjvQchDA2C/2/
   rC18lcZxwGnW8NxheK4zbCYtfBkN0MZLnLjLVLIbOsySnQ7MFsfO211SF
   en3DCVo3SFb1p3noeuVOdqNneqxXEuC+v6BkMcJ6w2M5SzVTbB9Rpiaxl
   cEPKsw+rNf4A7PBfMMw01MKWRe8NhVRFy7aSGafR6iMQoKIHiWFZEd4HZ
   pcXoIxSzrYmwMRX5nw/WH0M6lspHKCZ/8lCwdv3TAt2STrrEV1Xivb7pH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408583482"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408583482"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:29:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="744403563"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="744403563"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:29:25 -0800
Message-ID: <ef458f9f-5557-43d0-1c4a-51b87a666e21@intel.com>
Date:   Thu, 5 Jan 2023 23:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 18/24] mmc: sdhci-uhs2: add request() and others
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-19-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-19-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 11:00, Victor Shih wrote:
> This is a sdhci version of mmc's request operation.
> It covers both UHS-I and UHS-II.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 418 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      |  78 ++++---
>  drivers/mmc/host/sdhci.h      |  14 ++
>  3 files changed, 481 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index de15a6559702..7a34f66c4215 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -15,6 +15,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/bitfield.h>
>  #include <linux/ktime.h>
> +#include <linux/mmc/mmc.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -25,6 +26,8 @@
>  #define SDHCI_UHS2_DUMP(f, x...) \
>  	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
>  
> +#define UHS2_ARG_IOADR_MASK 0xfff
> +
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  {
>  	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
> @@ -59,6 +62,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> +{
> +	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
> +}
> +
>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
>  					    struct regulator *supply,
>  					    unsigned short vdd_bit)
> @@ -452,6 +460,415 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
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
> +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	__sdhci_finish_data_common(host);
> +
> +	__sdhci_finish_mrq(host, data->mrq);
> +}
> +
> +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
> +					 struct mmc_command *cmd)
> +{
> +	u16 mode;
> +	struct mmc_data *data = cmd->data;
> +
> +	if (!data) {
> +		/* clear Auto CMD settings for no data CMDs */
> +		if (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT) {
> +			mode =  0;
> +		} else {
> +			mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
> +			if (cmd->opcode == MMC_STOP_TRANSMISSION || cmd->opcode == MMC_ERASE)
> +				mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
> +			else
> +				/* send status mode */
> +				if (cmd->opcode == MMC_SEND_STATUS)
> +					mode = 0;
> +		}
> +
> +		DBG("UHS2 no data trans mode is 0x%x.\n", mode);
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
> +	DBG("UHS2 trans mode is 0x%x.\n", mode);
> +}
> +
> +static void __sdhci_uhs2_send_command(struct sdhci_host *host,
> +				      struct mmc_command *cmd)
> +{
> +	int i, j;
> +	int cmd_reg;
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
> +		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
> +		i += 4;
> +	}
> +
> +	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
> +		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> +
> +	DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
> +	for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
> +		DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
> +		    sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
> +
> +	cmd_reg = FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_cmd->packet_len);
> +	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
> +		cmd_reg |= SDHCI_UHS2_CMD_DATA;
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmd_reg |= SDHCI_UHS2_CMD_CMD12;
> +
> +	/* UHS2 Native ABORT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT))
> +		cmd_reg |= SDHCI_UHS2_CMD_TRNS_ABORT;
> +
> +	/* UHS2 Native DORMANT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_GO_DORMANT_STATE))
> +		cmd_reg |= SDHCI_UHS2_CMD_DORMANT;
> +
> +	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> +
> +	sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
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
> +	if (cmd->data)
> +		sdhci_uhs2_prepare_data(host, cmd);
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
> +	if (host->mmc->card) {
> +		if (host->mmc->card->uhs2_state & MMC_UHS2_INITIALIZED) {
> +			resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> +			if (resp & UHS2_RES_NACK_MASK) {
> +				ecode = (resp >> UHS2_RES_ECODE_POS) & UHS2_RES_ECODE_MASK;
> +				pr_err("%s: NACK is got, ECODE=0x%x.\n",
> +				mmc_hostname(host->mmc), ecode);
> +			}
> +			bReadA0 = 1;
> +		}
> +	}
> +
> +	if (cmd->uhs2_resp &&
> +	    cmd->uhs2_resp_len && cmd->uhs2_resp_len <= 20) {
> +		/* Get whole response of some native CCMD, like
> +		 * DEVICE_INIT, ENUMERATE.
> +		 */
> +		for (i = 0; i < cmd->uhs2_resp_len; i++)
> +			cmd->uhs2_resp[i] = sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
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
> +	if (!(sdhci_uhs2_mode(host))) {
> +		sdhci_request(mmc, mrq);
> +		return;
> +	}
> +
> +	mrq->stop = NULL;
> +	mrq->sbc = NULL;
> +	if (mrq->data)
> +		mrq->data->stop = NULL;
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
> @@ -581,6 +998,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  		sdhci_uhs2_start_signal_voltage_switch;
>  	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
>  	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
> +	host->mmc_host_ops.request = sdhci_uhs2_request;
>  
>  	return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3656e66fcca7..c547fc3b8b47 100644
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
> @@ -424,7 +423,7 @@ static void __sdhci_led_activate(struct sdhci_host *host)
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>  
> -static void __sdhci_led_deactivate(struct sdhci_host *host)
> +void __sdhci_led_deactivate(struct sdhci_host *host)
>  {
>  	u8 ctrl;
>  
> @@ -435,6 +434,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
>  	ctrl &= ~SDHCI_CTRL_LED;
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_led_deactivate);

Do not need to export __sdhci_led_deactivate

>  
>  #if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  static void sdhci_led_control(struct led_classdev *led,
> @@ -513,14 +513,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
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
> @@ -1087,8 +1088,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  		__sdhci_set_timeout(host, cmd);
>  }
>  
> -static void sdhci_initialize_data(struct sdhci_host *host,
> -				  struct mmc_data *data)
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data)
>  {
>  	WARN_ON(host->data);
>  
> @@ -1101,6 +1101,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
>  	host->data_early = 0;
>  	host->data->bytes_xfered = 0;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_initialize_data);
>  
>  static inline void sdhci_set_block_info(struct sdhci_host *host,
>  					struct mmc_data *data)
> @@ -1123,12 +1124,8 @@ static inline void sdhci_set_block_info(struct sdhci_host *host,
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
> @@ -1213,6 +1210,16 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
> @@ -1255,8 +1262,7 @@ static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
>  	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
>  }
>  
> -static int sdhci_external_dma_setup(struct sdhci_host *host,
> -				    struct mmc_command *cmd)
> +int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int ret, i;
>  	enum dma_transfer_direction dir;
> @@ -1309,8 +1315,9 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_setup);

Do not need to export sdhci_external_dma_setup

>  
> -static void sdhci_external_dma_release(struct sdhci_host *host)
> +void sdhci_external_dma_release(struct sdhci_host *host)
>  {
>  	if (host->tx_chan) {
>  		dma_release_channel(host->tx_chan);
> @@ -1324,9 +1331,10 @@ static void sdhci_external_dma_release(struct sdhci_host *host)
>  
>  	sdhci_switch_external_dma(host, false);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_release);

Do not need to export sdhci_external_dma_release

>  
> -static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> -					      struct mmc_command *cmd)
> +void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +				       struct mmc_command *cmd)
>  {
>  	struct mmc_data *data = cmd->data;
>  
> @@ -1337,6 +1345,7 @@ static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  
>  	sdhci_set_block_info(host, data);
>  }
> +EXPORT_SYMBOL(__sdhci_external_dma_prepare_data);

Do not need to export __sdhci_external_dma_prepare_data

>  
>  static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  					    struct mmc_command *cmd)
> @@ -1351,8 +1360,8 @@ static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
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
> @@ -1363,6 +1372,7 @@ static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
>  	if (chan)
>  		dma_async_issue_pending(chan);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_pre_transfer);

Do not need to export sdhci_external_dma_pre_transfer

>  
>  #else
>  
> @@ -1414,8 +1424,7 @@ static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
>  	return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>  }
>  
> -static inline bool sdhci_manual_cmd23(struct sdhci_host *host,
> -				      struct mmc_request *mrq)
> +static inline bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq)

Please do not make whitespace changes if nothing else changes

>  {
>  	return mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23);
>  }
> @@ -1530,7 +1539,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
>  }
>  
> -static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	if (host->cmd && host->cmd->mrq == mrq)
>  		host->cmd = NULL;
> @@ -1554,15 +1563,17 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
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
> @@ -1596,6 +1607,14 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
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
> @@ -1681,8 +1700,6 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  			sdhci_prepare_data(host, cmd);
>  	}
>  
> -	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> -
>  	sdhci_set_transfer_mode(host, cmd);
>  
>  	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> @@ -1725,13 +1742,15 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
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
>  
> -static bool sdhci_present_error(struct sdhci_host *host,
> -				struct mmc_command *cmd, bool present)
> +bool sdhci_present_error(struct sdhci_host *host,
> +			 struct mmc_command *cmd, bool present)
>  {
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		cmd->error = -ENOMEDIUM;
> @@ -1740,6 +1759,7 @@ static bool sdhci_present_error(struct sdhci_host *host,
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_present_error);
>  
>  static bool sdhci_send_command_retry(struct sdhci_host *host,
>  				     struct mmc_command *cmd,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c2f989dc2361..3b87fcae1294 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -831,6 +831,20 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +bool sdhci_data_line_cmd(struct mmc_command *cmd);
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_external_dma_release(struct sdhci_host *host);
> +void __sdhci_external_dma_prepare_data(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_external_dma_pre_transfer(struct sdhci_host *host, struct mmc_command *cmd);
> +#endif

external_dma fns do not need export

> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void __sdhci_finish_data_common(struct sdhci_host *host);
> +bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cmd, bool present);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);

