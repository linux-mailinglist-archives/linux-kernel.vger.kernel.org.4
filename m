Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CC7363BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFTGqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:46:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522141712;
        Mon, 19 Jun 2023 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687243564; x=1718779564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+qSYtA8xbUVpV06M/SxZn+r0MlQpfExMc6QxspAaFYs=;
  b=eYwEdU3j3/SzmJeMJ6TOKq/YplheFvlHDyhzP2XTerg4nNjMCKUrya7E
   vZnvIixUoq15qsUHmbDKIh21BfEN56sj62CTvISpeXMwyOE3sJyzUnBiI
   wPRKSs91nZTQpIOJUScd1PWCqJSsycmJgFnQEIXdf7D52//9uy+8Jv1Ba
   TMGthIsX4mSCyoqVQuDXyAk5m+QWC6i32ILAEKb+kX7LqTRhvuFfA5+ds
   R4aykvRSSLifbJFZi62C6F2He1FDiX0aY2coIscAJF9PJwhy/pUutUpsX
   ORe0V+LPwZpdhOKd9mrGw3mcEKlrP/WyZ3Hf0FnPwBN1dya5djY1rbLOO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="363205506"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="363205506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="779275102"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="779275102"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.49])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:46:00 -0700
Message-ID: <ca7ab0c2-2b4a-280b-71e5-5b34125d4a3e@intel.com>
Date:   Tue, 20 Jun 2023 09:45:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] CMDQ feature is introduced to eMMC standard in v5.1,
 which can be used to improve performance.
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, jh80.chung@samsung.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.tai@realtek.com
References: <20230616063731.17591-1-jyanchou@realtek.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230616063731.17591-1-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/23 09:37, Jyan Chou wrote:
> We add the mmc driver for the Synopsys DesignWare mmc host controller
> with cmdq support that can implement this feature.

Why not add CQHCI support to dw_mmc.c ?

It does not usually require that many changes, for example:

commit 88bd652b3c74997bb436adf6131acf445066243e
Author: Chun-Hung Wu <chun-hung.wu@mediatek.com>
Date:   Mon Jul 20 08:42:38 2020 +0800

    mmc: mediatek: command queue support
    
    Support command queue for mt6779 platform.
    a. Add msdc_set_busy_timeout() to calculate emmc write timeout.
    b. Connect mtk msdc driver to cqhci driver through
       host->cq_host->ops = &msdc_cmdq_ops;
    c. msdc_cmdq_irq() will link up with cqchi_irq(). Besides, it provides
       more irq error messages like RSPCRCERR/CMDTO/DATACRCERR/DATTMO.
    d. Select kernel config MMC_CQHCI for MMC_MTK
    
    Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
    Acked-by: Yong Mao <yong.mao@mediatek.com>
    Link: https://lore.kernel.org/r/1595205759-5825-4-git-send-email-chun-hung.wu@mediatek.com
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>



> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> ---
>  drivers/mmc/host/Kconfig      |   11 +
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/dw_mmc_cqe.c | 1823 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc_cqe.h |  444 ++++++++
>  4 files changed, 2279 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.h
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9f793892123c..b8c7727b1897 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -762,6 +762,17 @@ config MMC_DW_PLTFM
>  
>  	  If unsure, say Y.
>  
> +config MMC_DW_CQE
> +	tristate "Synopsys DesignWare Memory Card with CQE Interface"
> +	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +	select MMC_CQHCI
> +	help
> +	  This selects support for the Synopsys DesignWare Mobile Storage IP
> +	  block. It provides host support for SD and MMC interfaces, and adds
> +	  the support of cmdq.
> +
> +	  If unsure, say N.
> +
>  config MMC_DW_BLUEFIELD
>  	tristate "BlueField specific extensions for Synopsys DW Memory Card Interface"
>  	depends on MMC_DW
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index a693fa3d3f1c..7fa1411692e8 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
>  obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
>  obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
>  obj-$(CONFIG_MMC_DW_STARFIVE)	+= dw_mmc-starfive.o
> +obj-$(CONFIG_MMC_DW_CQE)                += dw_mmc_cqe.o
>  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
>  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
>  obj-$(CONFIG_MMC_VUB300)	+= vub300.o
> diff --git a/drivers/mmc/host/dw_mmc_cqe.c b/drivers/mmc/host/dw_mmc_cqe.c
> new file mode 100644
> index 000000000000..c50a6c71a362
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc_cqe.c
> @@ -0,0 +1,1823 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Synopsys DesignWare Multimedia Card Interface driver with CMDQ support
> + *  (Based on Synopsys DesignWare Multimedia Card Interface driver)
> + *
> + * Copyright (c) 2023 Realtek Semiconductor Corp
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/blkdev.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/seq_file.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +
> +#include "dw_mmc_cqe.h"
> +#include "cqhci.h"
> +
> +#define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
> +#define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
> +#define DW_MCI_CMDQ_DISABLED	0x30f0001
> +#define DW_MCI_CMDQ_ENABLED	0x30f0101
> +#define DW_MCI_POWEROFF		0x3220301
> +#define DW_MCI_DESC_LEN		0x100000
> +#define DW_MCI_MAX_SCRIPT_BLK	128
> +#define DW_MCI_TIMEOUT_MS	3000
> +#define DW_MCI_TIMEOUT_us	3000000
> +#define TUNING_ERR		531
> +#define DW_MCI_NOT_READY	9999
> +
> +DECLARE_COMPLETION(dw_mci_wait);
> +
> +
> +#if defined(CONFIG_DEBUG_FS)
> +static int dw_mci_cqe_req_show(struct seq_file *s, void *v)
> +{
> +	struct dw_mci_slot *slot = s->private;
> +	struct mmc_request *mrq;
> +	struct mmc_command *cmd;
> +	struct mmc_command *stop;
> +	struct mmc_data	*data;
> +
> +	/* Make sure we get a consistent snapshot */
> +	spin_lock_bh(&slot->host->lock);
> +	mrq = slot->mrq;
> +
> +	if (mrq) {
> +		cmd = mrq->cmd;
> +		data = mrq->data;
> +		stop = mrq->stop;
> +
> +		if (cmd)
> +			seq_printf(s,
> +				   "CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
> +				   cmd->opcode, cmd->arg, cmd->flags,
> +				   cmd->resp[0], cmd->resp[1], cmd->resp[2],
> +				   cmd->resp[2], cmd->error);
> +		if (data)
> +			seq_printf(s, "DATA %u / %u * %u flg %x err %d\n",
> +				   data->bytes_xfered, data->blocks,
> +				   data->blksz, data->flags, data->error);
> +		if (stop)
> +			seq_printf(s,
> +				   "CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
> +				   stop->opcode, stop->arg, stop->flags,
> +				   stop->resp[0], stop->resp[1], stop->resp[2],
> +				   stop->resp[2], stop->error);
> +	}
> +
> +	spin_unlock_bh(&slot->host->lock);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(dw_mci_cqe_req);
> +#endif /* defined(CONFIG_DEBUG_FS) */
> +
> +static int dw_mci_cqe_regs_show(struct dw_mci *host,
> +				struct mmc_command *cmd, u32 cmd_flags)
> +{
> +	dev_err(host->dev, "opcode = %d, arg = 0x%x, cmdflags = 0x%x\n",
> +				cmd->opcode, cmd->arg, cmd_flags);
> +	dev_err(host->dev, "status_int = 0x%x\n", host->normal_interrupt);
> +	dev_err(host->dev, "error_int = 0x%x\n", host->error_interrupt);
> +	dev_err(host->dev, "auto_error_int = 0x%x\n", host->auto_error_interrupt);
> +	dev_err(host->dev, "pstate_reg = 0x%x\n", mci_readl(host, PSTATE_REG));
> +	dev_err(host->dev, "host_ctrl_1 = 0x%x\n", mci_readb(host, HOST_CTRL1_R));
> +	dev_err(host->dev, "xfer_mode_r = 0x%x\n", mci_readw(host, XFER_MODE_R));
> +
> +	return 0;
> +}
> +
> +static void dw_mci_cqe_dumpregs(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +
> +	dev_info(host->dev, "%s: cmd idx 0x%08x\n", __func__, mci_readw(host, CMD_R));
> +}
> +
> +static void dw_mci_cqe_set_tran_desc(u8 *desc,
> +					dma_addr_t addr,
> +					int len,
> +					bool end,
> +					bool dma64)
> +{
> +	__le32 *attr = (__le32 __force *)desc;
> +
> +	*attr = (CQHCI_VALID(1) |
> +		 CQHCI_END(end ? 1 : 0) |
> +		 CQHCI_INT(0) |
> +		 CQHCI_ACT(0x4) |
> +		 CQHCI_DAT_LENGTH(len));
> +
> +	if (dma64) {
> +		__le64 *dataddr = (__le64 __force *)(desc + 4);
> +
> +		dataddr[0] = cpu_to_le64(addr);
> +	} else {
> +		__le32 *dataddr = (__le32 __force *)(desc + 4);
> +
> +		dataddr[0] = cpu_to_le32(addr);
> +	}
> +}
> +
> +static void dw_mci_cqe_setup_tran_desc(struct mmc_data *data,
> +				      struct cqhci_host *cq_host,
> +				      u8 *desc,
> +				      int sg_count)
> +{
> +	struct scatterlist *sg;
> +	u32 cur_blk_cnt, remain_blk_cnt;
> +	unsigned int begin, end;
> +	int i, len;
> +	bool last = false;
> +	bool dma64 = cq_host->dma64;
> +	dma_addr_t addr;
> +
> +	for_each_sg(data->sg, sg, sg_count, i) {
> +		addr = sg_dma_address(sg);
> +		len = sg_dma_len(sg);
> +		remain_blk_cnt  = len >> 9;
> +
> +		while (remain_blk_cnt) {
> +			/*DW_MCI_MAX_SCRIPT_BLK is tha max for each descriptor record*/
> +			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
> +				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
> +			else
> +				cur_blk_cnt = remain_blk_cnt;
> +
> +			/* In Synopsys DesignWare Databook Page 84,
> +			 * They mentioned the DMA 128MB restriction
> +			 */
> +			begin = addr / SZ_128M;
> +			end = (addr + cur_blk_cnt * SZ_512) / SZ_128M;
> +
> +			if (begin != end)
> +				cur_blk_cnt = (end * SZ_128M - addr) / SZ_512;
> +
> +			if ((i+1) == sg_count && (remain_blk_cnt == cur_blk_cnt))
> +				last = true;
> +
> +			dw_mci_cqe_set_tran_desc(desc, addr,
> +					(cur_blk_cnt << 9), last, dma64);
> +
> +			addr = addr + (cur_blk_cnt << 9);
> +			remain_blk_cnt -= cur_blk_cnt;
> +			desc += cq_host->trans_desc_len;
> +		}
> +	}
> +}
> +
> +static void dw_mci_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +
> +	/*clear data path SW_RST_R.SW_RST_DAT = 1*/
> +	mci_writeb(host, SW_RST_R, SDMMC_RST_DAT);
> +	/*0x9801200c*/
> +	mci_writew(host, XFER_MODE_R,
> +		((1 << SDMMC_MULTI_BLK_SEL) | SDMMC_BLOCK_COUNT_ENABLE | SDMMC_DMA_ENABLE));
> +
> +	/*Set DMA_SEL to ADMA2 only mode in the HOST_CTRL1_R*/
> +	mci_writeb(host, HOST_CTRL1_R,
> +		(mci_readb(host, HOST_CTRL1_R) & 0xe7) | (SDMMC_ADMA2_32 << SDMMC_DMA_SEL));
> +	mci_writew(host, BLOCKSIZE_R, 0x200);
> +	mci_writew(host, BLOCKCOUNT_R, 0);
> +
> +	/*Set SDMASA_R (while using 32 bits) to 0*/
> +	mci_writel(host, SDMASA_R, 0);
> +	/*we set this register additionally to enhance the IO perofrmance*/
> +
> +	cqhci_writel(host->cqe, 0x10, CQHCI_SSC1);
> +	cqhci_writel(host->cqe, 0, CQHCI_CTL);
> +
> +	if (cqhci_readl(host->cqe, CQHCI_CTL) && CQHCI_HALT) {
> +		dev_err(host->dev, "%s: cqhci: CQE failed to exit halt state\n",
> +			mmc_hostname(mmc));
> +	}
> +
> +	/*cmdq interrupt mode*/
> +	dw_mci_clr_signal_int(host);
> +	dw_mci_en_cqe_int(host);
> +}
> +
> +static const struct cqhci_host_ops dw_mci_cqhci_host_ops = {
> +	.enable = dw_mci_cqe_enable,
> +	.dumpregs = dw_mci_cqe_dumpregs,
> +	.setup_tran_desc = dw_mci_cqe_setup_tran_desc,
> +};
> +
> +void dw_mci_cqe_wait_done(struct dw_mci *host, u32 *addr,
> +		      u32 mask, u32 value)
> +{
> +	int n = 0;
> +
> +	while (1) {
> +		if (((*addr) & mask) == value)
> +			break;
> +
> +		/*error interrupt detected*/
> +		if ((mci_readw(host, NORMAL_INT_STAT_R) & SDMMC_ERR_INTERRUPT) != 0)
> +			break;
> +
> +		if (n++ > DW_MCI_TIMEOUT_us) {
> +			dev_err(host->dev, "opcode = %d, *addr = 0x%x, mask = 0x%x, value = 0x%x\n",
> +				host->opcode, readl(addr), mask, value);
> +			break;
> +		}
> +		udelay(1);
> +	}
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_wait_done);
> +
> +static void dw_mci_cqe_reset(struct dw_mci *host)
> +{
> +	/*check the cmd line*/
> +	if (mci_readw(host, ERROR_INT_STAT_R) & SDMMC_CMD_ERR) {
> +		/*Perform a software reset*/
> +		mci_writeb(host, SW_RST_R, SDMMC_RST_CMD);
> +		dw_mci_cqe_wait_done(host, (u32 *)(host->regs + SDMMC_CLK_CTRL_R), BIT(25), 0);
> +	}
> +	/*check data line*/
> +	if (mci_readw(host, ERROR_INT_STAT_R) & SDMMC_DATA_ERR) {
> +		mci_writeb(host, SW_RST_R, SDMMC_RST_DAT);
> +		dw_mci_cqe_wait_done(host, (u32 *)(host->regs + SDMMC_CLK_CTRL_R), BIT(26), 0);
> +	}
> +}
> +
> +static void dw_mci_cqe_read_rsp(struct dw_mci *host, struct mmc_command *cmd, u32 *rsp)
> +{
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +	if (cmd->flags & MMC_RSP_PRESENT) {
> +		if (cmd->flags & MMC_RSP_136) {
> +			if (drv_data && drv_data->shift_rsp) {
> +				drv_data->shift_rsp(host, cmd, cmd->resp);
> +			} else {
> +				/*R2 long response*/
> +				u32 rsp_tmp[4];
> +
> +				rsp_tmp[3] = mci_readl(host, RESP01_R);
> +				rsp_tmp[2] = mci_readl(host, RESP23_R);
> +				rsp_tmp[1] = mci_readl(host, RESP45_R);
> +				rsp_tmp[0] = mci_readl(host, RESP67_R);
> +			}
> +		} else {
> +			/*Short response*/
> +			rsp[0] = rsp[1] = rsp[2] = rsp[3] = 0;
> +			rsp[0] = mci_readl(host, RESP01_R);
> +		}
> +	}
> +}
> +
> +static u32 dw_mci_cqe_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	u32 cmdr;
> +
> +	cmd->error = -EINPROGRESS;
> +
> +    /* our ip design puts resp in bit 8-135, so we need to shift 8 bits*/
> +	if (host->shift)
> +		cmdr = (cmd->opcode << 8);
> +	else
> +		cmdr = cmd->opcode;
> +
> +	if (cmd->flags & MMC_RSP_PRESENT) {
> +		if (cmd->flags & MMC_RSP_136)
> +			cmdr |= SDMMC_RESP_LEN_136;
> +		else {
> +			if (cmd->flags & MMC_RSP_BUSY)
> +				cmdr |= SDMMC_RESP_LEN_48B;
> +			else
> +				cmdr |= SDMMC_RESP_LEN_48;
> +		}
> +	}
> +
> +	cmdr |= SDMMC_CMD_CHK_RESP_CRC;
> +	if (cmd->opcode == MMC_GO_IDLE_STATE ||
> +	   cmd->opcode == MMC_SEND_OP_COND ||
> +	   (cmd->opcode == MMC_SELECT_CARD && cmd->flags == (MMC_RSP_NONE | MMC_CMD_AC)))
> +		cmdr &= ~SDMMC_CMD_CHK_RESP_CRC;
> +
> +	cmdr |= SDMMC_CMD_IDX_CHK_ENABLE;
> +	if (cmd->opcode == MMC_GO_IDLE_STATE ||
> +	   cmd->opcode == MMC_SEND_OP_COND ||
> +	   cmd->opcode == MMC_SEND_CSD ||
> +	   cmd->opcode == MMC_SEND_CID ||
> +	   cmd->opcode == MMC_ALL_SEND_CID ||
> +	   (cmd->opcode == MMC_SELECT_CARD && cmd->flags == (MMC_RSP_NONE | MMC_CMD_AC)))
> +		cmdr &= ~SDMMC_CMD_IDX_CHK_ENABLE;
> +
> +	if (cmd->data)
> +		cmdr |= SDMMC_DATA;
> +
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmdr |= (SDMMC_ABORT_CMD << 6);
> +
> +	return cmdr;
> +}
> +
> +static int dw_mci_cqe_start_command(struct dw_mci *host,
> +				 struct mmc_command *cmd, u32 cmd_flags)
> +{
> +	int err = 0;
> +	unsigned long end = 0;
> +	unsigned long flags;
> +	bool xfer_flag = false;
> +
> +	host->cmd = cmd;
> +
> +	switch (cmd->opcode) {
> +	case MMC_READ_SINGLE_BLOCK:
> +	case MMC_READ_MULTIPLE_BLOCK:
> +	case MMC_WRITE_BLOCK:
> +	case MMC_WRITE_MULTIPLE_BLOCK:
> +	case MMC_SEND_EXT_CSD:
> +	case MMC_GEN_CMD:
> +	case MMC_SLEEP_AWAKE:
> +	case MMC_SWITCH:
> +	case MMC_SET_WRITE_PROT:
> +	case MMC_CLR_WRITE_PROT:
> +	case MMC_SEND_WRITE_PROT:
> +	case MMC_ERASE:
> +	case MMC_SEND_TUNING_BLOCK_HS200:
> +		xfer_flag = true;
> +		break;
> +	default:
> +		xfer_flag = false;
> +	}
> +
> +	host->int_waiting = &dw_mci_wait;
> +	end = jiffies + msecs_to_jiffies(DW_MCI_TIMEOUT_MS);
> +	mod_timer(&host->timer, end);
> +
> +	if (host->int_waiting) {
> +		dw_mci_clr_signal_int(host);
> +		dw_mci_clr_int(host);
> +
> +		/*command with data, r1b case*/
> +		if (xfer_flag == 1)
> +			dw_mci_en_xfer_int(host);
> +		else
> +			dw_mci_en_cd_int(host);
> +
> +		/*If we use cmd23, we cannot send auto stop command*/
> +		if (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
> +		    cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
> +			if (host->is_sbc) {
> +				mci_writew(host, XFER_MODE_R,
> +					mci_readw(host, XFER_MODE_R) & ~BIT(SDMMC_AUTO_CMD_ENABLE));
> +					host->is_sbc = 0;
> +			}
> +		}
> +
> +		host->opcode = cmd->opcode;
> +		host->arg = cmd->arg;
> +
> +		spin_lock_irqsave(&host->irq_lock, flags);
> +		mci_writew(host, CMD_R, cmd_flags);
> +		spin_unlock_irqrestore(&host->irq_lock, flags);
> +
> +		wait_for_completion(host->int_waiting);
> +
> +		if (xfer_flag == 1)
> +			dw_mci_cqe_wait_done(host,
> +				(u32 *)(host->regs + SDMMC_NORMAL_INT_STAT_R),
> +				SDMMC_XFER_COMPLETE, SDMMC_XFER_COMPLETE);
> +		else
> +			dw_mci_cqe_wait_done(host,
> +				(u32 *)(host->regs + SDMMC_NORMAL_INT_STAT_R),
> +				SDMMC_CMD_COMPLETE, SDMMC_CMD_COMPLETE);
> +
> +		if (host->normal_interrupt & SDMMC_ERR_INTERRUPT) {
> +			if (host->tuning == 1)
> +				dev_info(host->dev, "Tuning error ... keep tuning\n");
> +			else
> +				dw_mci_cqe_regs_show(host, cmd, cmd_flags);
> +			err = -1;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static void dw_mci_cqe_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
> +{
> +
> +	struct mmc_command stop;
> +	u32 cmdr;
> +	/*Stop command only use after data command*/
> +	if (!cmd->data)
> +		return;
> +
> +	memset(&stop, 0, sizeof(struct mmc_command));
> +
> +	if (cmd->opcode == MMC_READ_SINGLE_BLOCK ||
> +	    cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
> +	    cmd->opcode == MMC_WRITE_BLOCK ||
> +	    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
> +	    cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> +	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200) {
> +		stop.opcode = MMC_STOP_TRANSMISSION;
> +		stop.arg = 0;
> +		stop.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +	} else if (cmd->opcode == SD_IO_RW_EXTENDED) {
> +		stop.opcode = SD_IO_RW_DIRECT;
> +		stop.arg |= (1 << 31) | (0 << 28) | (SDIO_CCCR_ABORT << 9) |
> +			    ((cmd->arg >> 28) & 0x7);
> +		stop.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
> +	} else {
> +		return;
> +	}
> +
> +	cmdr = (stop.opcode << 8) | SDMMC_RESP_LEN_48 |
> +		SDMMC_CMD_CHK_RESP_CRC | SDMMC_CMD_IDX_CHK_ENABLE;
> +	cmdr |= (SDMMC_ABORT_CMD << 6);
> +	mci_writew(host, XFER_MODE_R, 0);
> +	mci_writel(host, ARGUMENT_R, stop.arg);
> +	dw_mci_cqe_start_command(host, &stop, cmdr);
> +}
> +
> +static int dw_mci_cqe_wait_while_busy(struct dw_mci *host, u32 *status)
> +{
> +	struct mmc_command cmd;
> +	u32 cmdr;
> +	u32 cur_state;
> +	unsigned long timeend;
> +	int err = 0;
> +
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +
> +	timeend = jiffies + msecs_to_jiffies(600);
> +
> +	do {
> +		cmd.opcode = MMC_SEND_STATUS;
> +		cmd.arg = 1 << 16;
> +		cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> +		cmd.data = NULL;
> +
> +		cmdr = (cmd.opcode << 8) | SDMMC_RESP_LEN_48 |
> +			SDMMC_CMD_CHK_RESP_CRC | SDMMC_CMD_IDX_CHK_ENABLE;
> +
> +		mci_writew(host, XFER_MODE_R, 0);
> +		mci_writel(host, ARGUMENT_R, cmd.arg);
> +
> +		err = dw_mci_cqe_start_command(host, &cmd, cmdr);
> +		if (err) {
> +			dw_mci_cqe_reset(host);
> +			break;
> +		}
> +		dw_mci_cqe_read_rsp(host, &cmd, cmd.resp);
> +
> +		*status = cmd.resp[0];
> +		cur_state = R1_CURRENT_STATE(cmd.resp[0]);
> +		err = -DW_MCI_NOT_READY;
> +		if (cur_state == R1_STATE_TRAN) {
> +			if (cmd.resp[0] & R1_READY_FOR_DATA) {
> +				err = 0;
> +				break;
> +			}
> +		}
> +	} while (time_before(jiffies, timeend));
> +
> +	return err;
> +
> +}
> +
> +static void dw_mci_cqe_stop_dma(struct dw_mci *host, struct mmc_data *data)
> +{
> +	u32 dir = 0;
> +
> +	if (data->flags & MMC_DATA_READ)
> +		dir = DMA_FROM_DEVICE;
> +	else
> +		dir = DMA_TO_DEVICE;
> +
> +	dma_unmap_sg(mmc_dev(host->slot->mmc), data->sg, data->sg_len, dir);
> +	host->sg = NULL;
> +}
> +
> +static void dw_mci_cqe_prepare_desc64(struct dw_mci *host, struct mmc_data *data,
> +					struct scatterlist *sg)
> +{
> +	dev_info(host->dev, "Currently, the 64bit DMA mode is not implemented yet.\n");
> +}
> +
> +
> +static void dw_mci_cqe_prepare_desc32(struct dw_mci *host, struct mmc_data *data,
> +					struct scatterlist *sg)
> +{
> +	u32  blk_cnt, cur_blk_cnt, remain_blk_cnt;
> +	u32  tmp_val;
> +	u32 *desc_base = host->sg_cpu;
> +	u32  dma_len = 0;
> +	u32  dma_addr;
> +	u32  i;
> +	unsigned int begin, end;
> +
> +	for (i = 0; i < host->dma_nents; i++, sg++) {
> +		dma_len = sg_dma_len(sg);
> +
> +		/*blk_cnt must be the multiple of 512(0x200)*/
> +		if (dma_len < SZ_512)
> +			blk_cnt = 1;
> +		else
> +			blk_cnt  = dma_len >> 9;
> +
> +		remain_blk_cnt  = blk_cnt;
> +		dma_addr = sg_dma_address(sg);
> +
> +		while (remain_blk_cnt) {
> +			/*DW_MCI_MAX_SCRIPT_BLK is the max
> +			 * for each descriptor record
> +			 */
> +			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
> +				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
> +			else
> +				cur_blk_cnt = remain_blk_cnt;
> +
> +			/* In Synopsys DesignWare Databook Page 84,
> +			 * They mentioned the DMA 128MB restriction
> +			 */
> +			begin = dma_addr / SZ_128M;
> +			end = (dma_addr + cur_blk_cnt * SZ_512) / SZ_128M;
> +
> +			/*If begin and end in the different 128MB memory zone*/
> +			if (begin != end)
> +				cur_blk_cnt = (end * SZ_128M - dma_addr) / SZ_512;
> +
> +			if (dma_len < SZ_512)
> +				tmp_val = ((dma_len) << 16) | VALID(0x1) | ACT(0x4);
> +			else
> +				tmp_val = ((cur_blk_cnt & 0x7f) << 25) | VALID(0x1) | ACT(0x4);
> +
> +			/*Last descriptor*/
> +			if (i == host->dma_nents - 1 && remain_blk_cnt == cur_blk_cnt)
> +				tmp_val |= END(0x1);
> +
> +			desc_base[0] =  tmp_val;
> +			desc_base[1] =  dma_addr;
> +
> +			dma_addr = dma_addr + (cur_blk_cnt << 9);
> +			remain_blk_cnt -= cur_blk_cnt;
> +			desc_base += 2;
> +		}
> +	}
> +}
> +
> +static void dw_mci_cqe_pre_req(struct mmc_host *mmc,
> +			   struct mmc_request *mrq)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	struct mmc_data *data = mrq->data;
> +	unsigned int sg_len;
> +
> +	if (!slot->host->use_dma || !data)
> +		return;
> +
> +	/* This data might be unmapped at this time */
> +	data->host_cookie = COOKIE_UNMAPPED;
> +
> +	sg_len = dma_map_sg(host->dev,
> +			    data->sg,
> +			    data->sg_len,
> +			    mmc_get_dma_dir(data));
> +	if (sg_len < 0)
> +		data->host_cookie = COOKIE_UNMAPPED;
> +}
> +
> +static void dw_mci_cqe_post_req(struct mmc_host *mmc,
> +			    struct mmc_request *mrq,
> +			    int err)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct mmc_data *data = mrq->data;
> +
> +	if (!slot->host->use_dma || !data)
> +		return;
> +
> +	if (data->host_cookie != COOKIE_UNMAPPED)
> +		dma_unmap_sg(slot->host->dev,
> +			     data->sg,
> +			     data->sg_len,
> +			     mmc_get_dma_dir(data));
> +	data->host_cookie = COOKIE_UNMAPPED;
> +}
> +
> +static int dw_mci_cqe_get_cd(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	int gpio_cd = mmc_gpio_get_cd(mmc);
> +	int present = -1;
> +
> +	/* Use platform get_cd function, else try onboard card detect */
> +	if (((mmc->caps & MMC_CAP_NEEDS_POLL)
> +		|| !mmc_card_is_removable(mmc))) {
> +		present = 1;
> +
> +		if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
> +			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
> +				dev_info(&mmc->class_dev,
> +					"card is polling.\n");
> +			} else {
> +				dev_info(&mmc->class_dev,
> +					"card is non-removable.\n");
> +			}
> +			set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +		}
> +
> +		return present;
> +	} else if (gpio_cd >= 0) {
> +		present = gpio_cd;
> +	} else {
> +		/*SD card detect using IP regs is todo*/
> +		dev_err(&mmc->class_dev, "SD card detect using IP regs is ToDo.\n");
> +	}
> +
> +	spin_lock_bh(&host->lock);
> +
> +	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
> +		dev_dbg(&mmc->class_dev, "card is present\n");
> +	else if (!present &&
> +		!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
> +		dev_dbg(&mmc->class_dev, "card is not present\n");
> +
> +	spin_unlock_bh(&host->lock);
> +
> +	return present;
> +}
> +
> +static void dw_mci_cqe_submit_data_dma(struct dw_mci *host)
> +{
> +	if (host->dma_64bit_address == 1)
> +		dw_mci_cqe_prepare_desc64(host, host->data, host->sg);
> +	else
> +		dw_mci_cqe_prepare_desc32(host, host->data, host->sg);
> +
> +}
> +
> +static void dw_mci_cqe_submit_data(struct dw_mci *host, struct mmc_data *data)
> +{
> +	u32 dir = 0;
> +
> +	host->sg = NULL;
> +	host->data = data;
> +
> +	if (data->flags & MMC_DATA_READ)
> +		dir = DMA_FROM_DEVICE;
> +	else
> +		dir = DMA_TO_DEVICE;
> +
> +	host->dma_nents = dma_map_sg(mmc_dev(host->slot->mmc),
> +					data->sg, data->sg_len, dir);
> +	host->sg = data->sg;
> +
> +	host->using_dma = 1;
> +
> +	dw_mci_cqe_submit_data_dma(host);
> +}
> +
> +static void dw_mci_cqe_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> +{
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	unsigned int clock = slot->clock;
> +	u32 div = 0;
> +
> +	slot->mmc->actual_clock = 0;
> +
> +	if (clock != host->current_speed || force_clkinit) {
> +		div = host->bus_hz / clock;
> +		if (host->bus_hz % clock)
> +			div += 1;
> +
> +		if (clock != slot->__clk_old) {
> +			/* Silent the verbose log if calling from PM context */
> +			dev_info(&slot->mmc->class_dev,
> +				"Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
> +				slot->id, host->bus_hz, clock, host->bus_hz / div, div);
> +		}
> +
> +		slot->__clk_old = clock;
> +		slot->mmc->actual_clock = host->bus_hz / div;
> +
> +		if (drv_data && drv_data->set_ios)
> +			drv_data->set_ios(slot, &slot->mmc->ios);
> +	}
> +}
> +
> +
> +static void dw_mci_cqe_err_handle(struct dw_mci *host, struct mmc_command *cmd)
> +{
> +	u32 status = 0;
> +	int err = 0;
> +	int rty_cnt = 0;
> +	int pstat_rty = 0;
> +
> +	do {
> +		mci_writew(host, ERROR_INT_STAT_R,
> +			mci_readw(host, ERROR_INT_STAT_R) & 0xffff);
> +		/*synchronous abort: stop host dma*/
> +		mci_writeb(host, BGAP_CTRL_R, SDMMC_STOP_BG_REQ);
> +		dw_mci_cqe_wait_done(host,
> +			(u32 *)(host->regs + SDMMC_NORMAL_INT_STAT_R),
> +				SDMMC_XFER_COMPLETE, SDMMC_XFER_COMPLETE);
> +
> +		mci_writew(host, NORMAL_INT_STAT_R, SDMMC_XFER_COMPLETE);
> +
> +		do {
> +			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
> +				dw_mci_cqe_prep_stop_abort(host, cmd);
> +				mdelay(1);
> +
> +				err = dw_mci_cqe_wait_while_busy(host, &status);
> +
> +				rty_cnt++;
> +				if (rty_cnt > 100) {
> +					if (err == -DW_MCI_NOT_READY)
> +						dev_err(host->dev, "status check failed, err = %d, status = 0x%x\n",
> +							err, status);
> +						break;
> +				}
> +			} else {
> +				break;
> +			}
> +		} while (err);
> +
> +		mci_writeb(host, SW_RST_R, SDMMC_RST_CMD | SDMMC_RST_DAT);
> +		dw_mci_cqe_wait_done(host, (u32 *)(host->regs + SDMMC_CLK_CTRL_R),
> +				(BIT(25)|BIT(26)), 0);
> +		dw_mci_cqe_wait_done(host, (u32 *)(host->regs + SDMMC_PSTATE_REG),
> +				(SDMMC_CMD_INHIBIT | SDMMC_CMD_INHIBIT_DAT), 0);
> +		udelay(40);
> +
> +		pstat_rty++;
> +		if (pstat_rty > 5000) {
> +			dev_err(host->dev, "wait pstate register data line ready timeout\n");
> +			break;
> +		}
> +	} while ((mci_readl(host, PSTATE_REG) & 0xf00000) != 0xf00000 ||
> +		(mci_readl(host, PSTATE_REG) & 0xf0) != 0xf0);
> +}
> +
> +static void dw_mci_cqe_send_stop_abort(struct dw_mci *host,
> +			      struct dw_mci_slot *slot,
> +			      struct mmc_command *cmd)
> +{
> +	dw_mci_cqe_reset(host);
> +
> +	if (cmd->data)
> +		dw_mci_cqe_err_handle(host, cmd);
> +	else
> +		return;
> +}
> +
> +static u32 dw_mci_cqe_prepare_data_flags(struct mmc_command *cmd)
> +{
> +	u32 dataflags;
> +	int read_flag = 1;
> +	int mul_blk_flag = 0;
> +	int auto_stop_flag = 0;
> +
> +	if (cmd->opcode == MMC_WRITE_BLOCK ||
> +	   cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
> +	   cmd->opcode == MMC_LOCK_UNLOCK ||
> +	   (cmd->opcode == MMC_GEN_CMD && cmd->arg == 0))
> +		read_flag = 0;
> +
> +	if (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
> +	   cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
> +		mul_blk_flag = 1;
> +		auto_stop_flag = 1;
> +	}
> +
> +	dataflags = (mul_blk_flag << SDMMC_MULTI_BLK_SEL) |
> +		    (read_flag << SDMMC_DATA_XFER_DIR) |
> +		    (auto_stop_flag << SDMMC_AUTO_CMD_ENABLE) |
> +		    (SDMMC_BLOCK_COUNT_ENABLE) |
> +		    (SDMMC_DMA_ENABLE);
> +
> +	return dataflags;
> +}
> +
> +static int dw_mci_cqe_command_complete(struct dw_mci *host, u16 interrupt,
> +					int *cmd_error)
> +{
> +	if (interrupt & (SDMMC_CMD_IDX_ERR | SDMMC_CMD_END_BIT_ERR
> +		| SDMMC_CMD_CRC_ERR)) {
> +		if (host->tuning)
> +			*cmd_error = -TUNING_ERR;
> +		else
> +			*cmd_error = -EILSEQ;
> +	} else if (interrupt & SDMMC_CMD_TOUT_ERR) {
> +		if (host->tuning)
> +			*cmd_error = -TUNING_ERR;
> +		else
> +			*cmd_error = -ETIMEDOUT;
> +	} else {
> +		*cmd_error = 0;
> +	}
> +
> +	return *cmd_error;
> +}
> +
> +static int dw_mci_cqe_data_complete(struct dw_mci *host, u16 interrupt,
> +					int *data_error)
> +{
> +	if (interrupt & (SDMMC_DATA_END_BIT_ERR | SDMMC_DATA_CRC_ERR)) {
> +		if (host->tuning)
> +			*data_error = -TUNING_ERR;
> +		else
> +			*data_error = -EILSEQ;
> +	} else if (interrupt & SDMMC_DATA_TOUT_ERR) {
> +		if (host->tuning)
> +			*data_error = -TUNING_ERR;
> +		else
> +			*data_error = -ETIMEDOUT;
> +	} else if (interrupt & SDMMC_ADMA_ERR) {
> +		*data_error = -EIO;
> +	} else {
> +		*data_error = 0;
> +	}
> +
> +	return *data_error;
> +}
> +
> +static void __dw_mci_cqe_start_request(struct dw_mci *host,
> +				   struct dw_mci_slot *slot,
> +				   struct mmc_command *cmd)
> +{
> +	struct mmc_data *data;
> +	u32 cmdflags;
> +	u32 dataflags;
> +	int ret = 0;
> +
> +	data = cmd->data;
> +
> +	if (data) {
> +		mci_writew(host, BLOCKCOUNT_R, data->blocks);
> +		mci_writel(host, BLOCKSIZE_R, data->blksz);
> +		mci_writel(host, ADMA_SA_LOW_R, host->sg_dma);
> +
> +		dataflags = dw_mci_cqe_prepare_data_flags(cmd);
> +
> +		mci_writew(host, XFER_MODE_R, dataflags);
> +	} else {
> +		if (cmd->opcode == MMC_SET_BLOCK_COUNT)
> +			host->is_sbc = 1;
> +		else
> +			host->is_sbc = 0;
> +
> +		mci_writew(host, XFER_MODE_R, 0);
> +	}
> +
> +	mci_writel(host, ARGUMENT_R, cmd->arg);
> +
> +	cmdflags = dw_mci_cqe_prepare_command(slot->mmc, cmd);
> +
> +	if (data) {
> +		data->bytes_xfered = 0;
> +		if (host->use_dma == TRANS_MODE_DMA) {
> +			dw_mci_cqe_submit_data(host, data);
> +			wmb(); /* drain writebuffer */
> +		} else {
> +			/*Using PIO mode*/
> +			dev_err(host->dev, "pio mode is not supported currently\n");
> +		}
> +	}
> +
> +	ret = dw_mci_cqe_start_command(host, cmd, cmdflags);
> +
> +	if (ret == 0) {
> +		dw_mci_cqe_read_rsp(host, cmd, cmd->resp);
> +
> +		if (data)
> +			data->bytes_xfered += (data->blocks * data->blksz);
> +	}
> +
> +	dw_mci_cqe_command_complete(host, host->error_interrupt, &cmd->error);
> +	if (data) {
> +		dw_mci_cqe_data_complete(host, host->error_interrupt, &data->error);
> +		if (host->use_dma == TRANS_MODE_DMA)
> +			dw_mci_cqe_stop_dma(host, data);
> +		else {
> +			/*Using PIO mode*/
> +			dev_err(host->dev, "pio mode is not supported currently\n");
> +		}
> +	}
> +
> +	if (ret != 0)
> +		dw_mci_cqe_send_stop_abort(host, slot, cmd);
> +
> +	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
> +		/*
> +		 * If cmd11 needs to be dealt with specially, put in here.
> +		 */
> +	}
> +}
> +
> +static void dw_mci_cqe_start_request(struct dw_mci *host,
> +				 struct dw_mci_slot *slot)
> +{
> +	struct mmc_request *mrq = slot->mrq;
> +
> +	if (mrq->sbc)
> +		__dw_mci_cqe_start_request(host, slot, mrq->sbc);
> +
> +	if (mrq->cmd)
> +		__dw_mci_cqe_start_request(host, slot, mrq->cmd);
> +}
> +
> +static int dw_mci_switch(struct mmc_host *mmc,
> +			 u8 set,
> +			 u8 index,
> +			 u8 value,
> +			 unsigned int timeout_ms)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	struct mmc_command cmd;
> +	int err = 0;
> +	u32 cmdr;
> +
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +
> +	cmd.opcode		= MMC_SWITCH;
> +	cmd.arg			= (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +				(index << 16) |
> +				(value << 8) |
> +				set;
> +	cmd.flags		= MMC_CMD_AC|MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> +	cmd.data		= NULL;
> +
> +	cmdr = (cmd.opcode << 8) | SDMMC_RESP_LEN_48B |
> +		SDMMC_CMD_CHK_RESP_CRC | SDMMC_CMD_IDX_CHK_ENABLE;
> +
> +	mci_writew(host, XFER_MODE_R, 0);
> +	mci_writel(host, ARGUMENT_R, cmd.arg);
> +
> +	err = dw_mci_cqe_start_command(host, &cmd, cmdr);
> +
> +	if (err) {
> +		dev_err(host->dev, "interrupt status reg :0x%x, error reg : 0x%x\n",
> +			host->normal_interrupt, host->error_interrupt);
> +	}
> +
> +	return err;
> +}
> +
> +static int dw_mci_cqe_switch(struct mmc_host *mmc, bool enable)
> +{
> +	struct mmc_card *card = mmc->card;
> +	int ret = 0;
> +	u8 val = enable ? EXT_CSD_CMDQ_MODE_ENABLED : 0;
> +
> +	if (!card->ext_csd.cmdq_support) {
> +		dev_err(&mmc->class_dev, "The device card does not support cqe mode\n");
> +		return 0;
> +	}
> +
> +	ret = dw_mci_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
> +			    EXT_CSD_CMDQ_MODE_EN, val,
> +			    card->ext_csd.generic_cmd6_time);
> +	if (ret) {
> +		dev_err(&mmc->class_dev, "cmdq mode %sable failed %d\n",
> +			enable ? "en" : "dis", ret);
> +		goto out;
> +	} else {
> +		card->ext_csd.cmdq_en = enable;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static void dw_mci_cqe_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	int ret;
> +	u32 status = 0;
> +
> +	WARN_ON(slot->mrq);
> +
> +	/*
> +	 * The check for card presence and queueing of the request must be
> +	 * atomic, otherwise the card could be removed in between and the
> +	 * request wouldn't fail until another card was inserted.
> +	 */
> +
> +	if (!dw_mci_cqe_get_cd(mmc)) {
> +		mrq->cmd->error = -ENOMEDIUM;
> +		mmc_request_done(mmc, mrq);
> +		return;
> +	}
> +
> +	down_write(&host->cr_rw_sem);
> +
> +	/*cmdq case needs extra check*/
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if ((host->cqe) == NULL) {
> +			dev_err(host->dev, "dw_mci_request_cqe not done yet\n");
> +			mdelay(2);
> +		}
> +
> +		if (mmc->cqe_on == false && host->cqe->activated == true
> +			&& slot->switch_partition == 0)
> +			cqhci_deactivate(mmc);
> +
> +		if (mrq->cmd->opcode == MMC_SWITCH && mrq->cmd->arg == DW_MCI_CMDQ_DISABLED)
> +			slot->switch_partition = 1;
> +
> +		/* we do not need to disable cmdq if it is rpmb request
> +		 * because rpmb has been changed to rpmb partition in block.c
> +		 * Also, we do not need to disable cmdq if this command is disable/enable cmdq
> +		 */
> +		if (mmc->card && mmc->card->ext_csd.cmdq_en == 1
> +			&& slot->switch_partition == 0
> +			&& host->cmd_atomic == false) {
> +			ret = dw_mci_cqe_switch(mmc, false);
> +
> +			if (mrq->cmd->opcode == MMC_SLEEP_AWAKE ||
> +				(mrq->cmd->opcode == MMC_SELECT_CARD
> +					&& mrq->cmd->arg == 0) || (mrq->cmd->opcode == MMC_SWITCH
> +					&& mrq->cmd->arg == DW_MCI_POWEROFF))
> +				host->cqe_reenable = 0;
> +			else
> +				host->cqe_reenable = 1;
> +
> +			if (ret)
> +				dev_err(host->dev, "disable cmdq failed !\n");
> +
> +			dw_mci_cqe_wait_while_busy(host, &status);
> +		}
> +
> +		if (mrq->cmd->opcode == MMC_SWITCH
> +			&& mrq->cmd->arg == DW_MCI_CMDQ_ENABLED)
> +			slot->switch_partition = 0;
> +
> +		if (mrq->cmd->opcode == MMC_ERASE_GROUP_START) {
> +			host->cmd_atomic = true;
> +			host->cqe_reenable = 0;
> +		}
> +
> +		if (host->cmd_atomic == true
> +			&& mrq->cmd->opcode == MMC_SEND_STATUS) {
> +			host->cmd_atomic = false;
> +			host->cqe_reenable = 1;
> +		}
> +	}
> +
> +	slot->mrq = mrq;
> +	host->mrq = mrq;
> +
> +	dw_mci_cqe_start_request(host, slot);
> +
> +	tasklet_schedule(&host->tasklet);
> +
> +	/*cmdq case needs extra check*/
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE) &&
> +		host->cqe_reenable == 1) {
> +		if (mmc->card && mmc->card->ext_csd.cmdq_en == 0) {
> +			ret = dw_mci_cqe_switch(mmc, true);
> +			host->cqe_reenable = 0;
> +			if (ret)
> +				dev_err(host->dev, "switch cmdq failed !\n");
> +			dw_mci_cqe_wait_while_busy(host, &status);
> +		}
> +	}
> +
> +	up_write(&host->cr_rw_sem);
> +}
> +
> +static void dw_mci_cqe_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
> +
> +	switch (ios->timing) {
> +	case MMC_TIMING_MMC_HS400:
> +		mci_writew(host, HOST_CTRL2_R,
> +			(mci_readw(host, HOST_CTRL2_R)
> +				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_HS400);
> +		break;
> +	case MMC_TIMING_MMC_HS200:
> +		mci_writew(host, HOST_CTRL2_R,
> +			(mci_readw(host, HOST_CTRL2_R)
> +				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_HS200);
> +		break;
> +	case MMC_TIMING_MMC_HS:
> +		mci_writew(host, HOST_CTRL2_R,
> +			(mci_readw(host, HOST_CTRL2_R)
> +				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_SDR);
> +		break;
> +	default:
> +		/*MMC_TIMING_LEGACY case*/
> +		mci_writew(host, HOST_CTRL2_R,
> +			(mci_readw(host, HOST_CTRL2_R)
> +				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_LEGACY);
> +	}
> +
> +	slot->clock = ios->clock;
> +
> +	if (drv_data && drv_data->set_ios)
> +		drv_data->set_ios(slot, ios);
> +
> +	switch (ios->bus_width) {
> +	case MMC_BUS_WIDTH_4:
> +		mci_writeb(host, HOST_CTRL1_R,
> +			(mci_readb(host, HOST_CTRL1_R) &
> +			(SDMMC_EXT_DAT_XFER_MASK & SDMMC_DAT_XFER_WIDTH_MASK))
> +				|SDMMC_BUS_WIDTH_4);
> +		break;
> +	case MMC_BUS_WIDTH_8:
> +		mci_writeb(host, HOST_CTRL1_R,
> +			(mci_readb(host, HOST_CTRL1_R) &
> +				SDMMC_EXT_DAT_XFER_MASK) | SDMMC_BUS_WIDTH_8);
> +		break;
> +	default:
> +		/* set default 1 bit mode */
> +		mci_writeb(host, HOST_CTRL1_R,
> +			(mci_readb(host, HOST_CTRL1_R) &
> +				(SDMMC_EXT_DAT_XFER_MASK &
> +				SDMMC_DAT_XFER_WIDTH_MASK)) | SDMMC_BUS_WIDTH_1);
> +	}
> +}
> +
> +static int dw_mci_cqe_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +	if (drv_data && drv_data->switch_voltage)
> +		return drv_data->switch_voltage(mmc, ios);
> +
> +	return 0;
> +}
> +
> +static int dw_mci_cqe_get_ro(struct mmc_host *mmc)
> +{
> +	int read_only;
> +	int gpio_ro = mmc_gpio_get_ro(mmc);
> +
> +	/* Use platform get_ro function, else try on board write protect */
> +	if (gpio_ro >= 0)
> +		read_only = gpio_ro;
> +	else
> +		/*Need to read the IP register to judge if ro*/
> +		dev_err(&mmc->class_dev, "IP get_ro feature is not implemented currently.\n");
> +
> +	dev_dbg(&mmc->class_dev, "card is %s\n",
> +		read_only ? "read-only" : "read-write");
> +
> +	return read_only;
> +}
> +
> +static int dw_mci_cqe_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int err = -EINVAL;
> +
> +	if (drv_data && drv_data->execute_tuning)
> +		err = drv_data->execute_tuning(slot, opcode);
> +	return err;
> +
> +}
> +
> +static int dw_mci_cqe_prepare_hs400_tuning(struct mmc_host *mmc,
> +				       struct mmc_ios *ios)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +	if (drv_data && drv_data->prepare_hs400_tuning)
> +		return drv_data->prepare_hs400_tuning(host, ios);
> +
> +	return 0;
> +}
> +
> +static void dw_mci_cqe_hs400_complete(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +	if (drv_data && drv_data->hs400_complete)
> +		drv_data->hs400_complete(mmc);
> +}
> +
> +static void dw_mci_cqe_init_card(struct mmc_host *mmc, struct mmc_card *card)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +	/*
> +	 * Add any quirks for this synopsys IP here or
> +	 * deal with something special for some specific
> +	 * vendors' SOC platform by calling drv_data->init_card().
> +	 */
> +	if (drv_data && drv_data->init_card)
> +		drv_data->init_card(mmc, card);
> +}
> +
> +static const struct mmc_host_ops dw_mci_ops = {
> +	.request		= dw_mci_cqe_request,
> +	.pre_req		= dw_mci_cqe_pre_req,
> +	.post_req		= dw_mci_cqe_post_req,
> +	.set_ios		= dw_mci_cqe_set_ios,
> +	.get_ro			= dw_mci_cqe_get_ro,
> +	.get_cd			= dw_mci_cqe_get_cd,
> +	.execute_tuning		= dw_mci_cqe_execute_tuning,
> +	.start_signal_voltage_switch = dw_mci_cqe_switch_voltage,
> +	.init_card		= dw_mci_cqe_init_card,
> +	.prepare_hs400_tuning	= dw_mci_cqe_prepare_hs400_tuning,
> +	.hs400_complete         = dw_mci_cqe_hs400_complete,
> +};
> +
> +static void dw_mci_cqe_tasklet_func(unsigned long priv)
> +{
> +	struct dw_mci *host = (struct dw_mci *)priv;
> +	struct mmc_host *prev_mmc = host->slot->mmc;
> +	struct mmc_request *mrq;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +
> +	host->cmd = NULL;
> +	host->data = NULL;
> +	mrq = host->mrq;
> +	host->slot->mrq = NULL;
> +	host->mrq = NULL;
> +
> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +
> +	mmc_request_done(prev_mmc, mrq);
> +}
> +
> +static irqreturn_t dw_mci_cqe_interrupt(int irq, void *dev_id)
> +{
> +	struct dw_mci *host = dev_id;
> +	struct mmc_host *mmc = host->slot->mmc;
> +	struct cqhci_host *cq_host = NULL;
> +	int cmd_error = 0, data_error = 0;
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE))
> +		cq_host = mmc->cqe_private;
> +
> +	dw_mci_get_int(host);
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if (mmc->cqe_on == false && cq_host->activated == false)
> +			dw_mci_clr_signal_int(host);
> +	} else {
> +		dw_mci_clr_signal_int(host);
> +	}
> +	/*if run the cmdq mode*/
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE) &&
> +		mmc->cqe_on == true && cq_host->activated == true) {
> +		if (host->normal_interrupt & SDMMC_ERR_INTERRUPT) {
> +			dev_err(host->dev, "cmdq error: interrupt status=%08x, error interrupt=0x%08x, CQIS=0x%x, CQTCN=0x%x\n",
> +				host->normal_interrupt, host->error_interrupt,
> +				readl(host->cqe->mmio + CQHCI_IS),
> +				readl(host->cqe->mmio + CQHCI_TCN));
> +
> +			dw_mci_cqe_command_complete(host, host->error_interrupt, &cmd_error);
> +			dw_mci_cqe_data_complete(host, host->error_interrupt, &data_error);
> +		}
> +		cqhci_irq(mmc, (u32)(host->normal_interrupt), cmd_error, data_error);
> +		dw_mci_clr_int(host);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (host->int_waiting) {
> +		del_timer(&host->timer);
> +		complete(host->int_waiting);
> +	}
> +
> +	return IRQ_HANDLED;
> +
> +}
> +
> +static void dw_mci_cqe_setup(struct dw_mci *host)
> +{
> +	mci_writeb(host, SW_RST_R, (SDMMC_RST_ALL|SDMMC_RST_CMD|SDMMC_RST_DAT));
> +	mci_writeb(host, TOUT_CTRL_R, 0xe);
> +	mci_writew(host, HOST_CTRL2_R, SDMMC_HOST_VER4_ENABLE|SDMMC_SIGNALING_EN);
> +	mci_writew(host, NORMAL_INT_STAT_EN_R, 0xffff);
> +	mci_writew(host, ERROR_INT_STAT_EN_R, SDMMC_ALL_ERR_STAT_EN);
> +	/*Card detect will be enabled in the last*/
> +	mci_writew(host, NORMAL_INT_SIGNAL_EN_R,
> +		(~(SDMMC_CARD_INSERTION_SIGNAL_EN | SDMMC_CARD_REMOVAL_SIGNAL_EN |
> +			SDMMC_CARD_INTERRUPT_SIGNAL_EN) & 0xffff));
> +	mci_writew(host, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN);
> +	mci_writeb(host, CTRL_R, SDMMC_RST_N_OE|SDMMC_RST_N|SDMMC_CARD_IS_EMMC);
> +	mci_writeb(host, HOST_CTRL1_R,
> +		(mci_readb(host, HOST_CTRL1_R)&0xe7) | (SDMMC_ADMA2_32 << SDMMC_DMA_SEL));
> +	mci_writeb(host, MSHC_CTRL_R, mci_readb(host, MSHC_CTRL_R) & (~SDMMC_CMD_CONFLICT_CHECK));
> +	mci_writew(host, CLK_CTRL_R, mci_readw(host, CLK_CTRL_R)|SDMMC_INTERNAL_CLK_EN);
> +}
> +
> +static int dw_mci_cqe_init_slot_caps(struct dw_mci_slot *slot)
> +{
> +	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	struct mmc_host *mmc = slot->mmc;
> +	int ctrl_id;
> +
> +	if (host->pdata->caps)
> +		mmc->caps = host->pdata->caps;
> +
> +	if (host->pdata->pm_caps)
> +		mmc->pm_caps = host->pdata->pm_caps;
> +
> +	if (host->dev->of_node) {
> +		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
> +		if (ctrl_id < 0)
> +			ctrl_id = 0;
> +	} else {
> +		ctrl_id = to_platform_device(host->dev)->id;
> +	}
> +
> +	if (drv_data && drv_data->caps) {
> +		if (ctrl_id >= drv_data->num_caps) {
> +			dev_err(host->dev, "invalid controller id %d\n",
> +				ctrl_id);
> +			return -EINVAL;
> +		}
> +		mmc->caps |= drv_data->caps[ctrl_id];
> +	}
> +
> +	if (drv_data && drv_data->shift_rsp)
> +		host->shift = 1;
> +	else
> +		host->shift = 0;
> +
> +	if (host->pdata->caps2)
> +		mmc->caps2 = host->pdata->caps2;
> +
> +	mmc->f_min = DW_MCI_FREQ_MIN;
> +	if (!mmc->f_max)
> +		mmc->f_max = DW_MCI_FREQ_MAX;
> +
> +	/* Process SDIO IRQs through the sdio_irq_work. */
> +	if (mmc->caps & MMC_CAP_SDIO_IRQ)
> +		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> +
> +	return 0;
> +}
> +
> +static int dw_mci_cqe_init_slot(struct dw_mci *host)
> +{
> +	struct mmc_host *mmc;
> +	struct dw_mci_slot *slot;
> +	int ret;
> +
> +	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
> +	if (!mmc)
> +		return -ENOMEM;
> +
> +	slot = mmc_priv(mmc);
> +	slot->id = 0;
> +	slot->sdio_id = host->sdio_id0 + slot->id;
> +	slot->mmc = mmc;
> +	slot->switch_partition = 0;
> +	slot->host = host;
> +	host->slot = slot;
> +
> +	mmc->ops = &dw_mci_ops;
> +
> +	/*if there are external regulators, get them*/
> +	ret = mmc_regulator_get_supply(mmc);
> +	if (ret)
> +		goto err_host_allocated;
> +
> +	if (!mmc->ocr_avail)
> +		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +
> +	dev_info(host->dev, "regulator support volage ocr_avail=0x%x\n",
> +			mmc->ocr_avail);
> +
> +	ret = mmc_of_parse(mmc);
> +	if (ret)
> +		goto err_host_allocated;
> +
> +	ret = dw_mci_cqe_init_slot_caps(slot);
> +	if (ret)
> +		goto err_host_allocated;
> +
> +	/* Useful defaults if platform data is unset. */
> +	if (host->use_dma == TRANS_MODE_DMA) {
> +		mmc->max_segs = 256;
> +		mmc->max_blk_size = 512;
> +		mmc->max_seg_size = 0x1000;
> +		mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
> +		mmc->max_blk_count = mmc->max_req_size / 512;
> +	} else {
> +		dev_info(host->dev, "dw-mmc-cqe pio mode is ToDo.\n");
> +		/* To DO, TRANS_MODE_PIO */
> +	}
> +
> +	dw_mci_cqe_get_cd(mmc);
> +
> +	ret = mmc_add_host(mmc);
> +	if (ret)
> +		goto err_host_allocated;
> +
> +	return 0;
> +
> +err_host_allocated:
> +	mmc_free_host(mmc);
> +	return ret;
> +}
> +
> +static void dw_mci_cqe_cleanup_slot(struct dw_mci_slot *slot)
> +{
> +	/* Debugfs stuff is cleaned up by mmc core */
> +	mmc_remove_host(slot->mmc);
> +	slot->host->slot = NULL;
> +	mmc_free_host(slot->mmc);
> +}
> +
> +static void dw_mci_cqe_init_dma(struct dw_mci *host)
> +{
> +	host->use_dma = TRANS_MODE_DMA;
> +
> +	/* Determine which DMA interface to use */
> +	/* using 32bit DMA by default,
> +	 * user can modify this setting by drv_data->init()
> +	 */
> +	if (host->use_dma == TRANS_MODE_DMA) {
> +		host->dma_64bit_address = 0;
> +		dev_info(host->dev, "IDMAC supports 32-bit address mode.\n");
> +	}
> +
> +	/* Alloc memory for sg translation */
> +	host->sg_cpu = dma_alloc_coherent(host->dev,
> +						DW_MCI_DESC_LEN,
> +						&host->sg_dma, GFP_KERNEL);
> +	if (!host->sg_cpu) {
> +		dev_err(host->dev,
> +			"%s: could not alloc DMA memory\n",
> +			__func__);
> +		goto no_dma;
> +	}
> +
> +	return;
> +
> +no_dma:
> +	dev_info(host->dev, "Using PIO mode.\n");
> +	host->use_dma = TRANS_MODE_PIO;
> +}
> +
> +#ifdef CONFIG_OF
> +static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_board *pdata;
> +	struct device *dev = host->dev;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int ret;
> +	u32 clock_frequency;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* find reset controller when exist */
> +	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
> +	if (IS_ERR(pdata->rstc)) {
> +		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	device_property_read_u32(dev, "card-detect-delay",
> +		&pdata->detect_delay_ms);
> +
> +	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
> +		pdata->bus_hz = clock_frequency;
> +
> +	if (drv_data && drv_data->parse_dt) {
> +		ret = drv_data->parse_dt(host);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	return pdata;
> +}
> +
> +#else /* CONFIG_OF */
> +static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +#endif /* CONFIG_OF */
> +
> +static void dw_mci_cqe_cto_timer(struct timer_list *t)
> +{
> +	struct dw_mci *host = from_timer(host, t, timer);
> +
> +	if (host->int_waiting) {
> +		dev_err(host->dev, "fired, opcode=%d, arg=0x%x, irq status=0x%x, err irq=0x%x, auto err irq=0x%x\n",
> +				host->opcode, host->arg,
> +			host->normal_interrupt, host->error_interrupt,
> +			host->auto_error_interrupt);
> +
> +		dw_mci_clr_signal_int(host);
> +		dw_mci_get_int(host);
> +
> +		complete(host->int_waiting);
> +	}
> +}
> +
> +
> +static void dw_mci_cqe_enable_cd(struct dw_mci *host)
> +{
> +	/*
> +	 * No need for CD if all slots have a non-error GPIO
> +	 * as well as broken card detection is found.
> +	 */
> +	if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL
> +		|| !mmc_card_is_removable(host->slot->mmc))
> +		return;
> +}
> +
> +static void dw_mci_cqhci_init(struct dw_mci *host)
> +{
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		host->cqe = cqhci_pltfm_init(host->pdev);
> +		if (PTR_ERR(host->cqe) == -EINVAL ||
> +		   PTR_ERR(host->cqe) == -ENOMEM ||
> +		   PTR_ERR(host->cqe) == -EBUSY) {
> +			dev_err(host->dev,
> +				"Unable to get the cmdq related attribute,err = %ld\n",
> +				PTR_ERR(host->cqe));
> +			host->cqe = 0;
> +			host->pdata->caps2 &= ~(MMC_CAP2_CQE|MMC_CAP2_CQE_DCMD);
> +		} else {
> +			host->cqe->ops = &dw_mci_cqhci_host_ops;
> +			cqhci_init(host->cqe, host->slot->mmc, 0);
> +		}
> +	}
> +}
> +
> +int dw_mci_cqe_probe(struct dw_mci *host)
> +{
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int ret = 0;
> +
> +	if (!host->pdata) {
> +		host->pdata = dw_mci_cqe_parse_dt(host);
> +		if (PTR_ERR(host->pdata) == -EPROBE_DEFER) {
> +			return -EPROBE_DEFER;
> +		} else if (IS_ERR(host->pdata)) {
> +			dev_err(host->dev, "platform data not available\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	host->biu_clk = devm_clk_get(host->dev, "biu");
> +	if (IS_ERR(host->biu_clk)) {
> +		dev_dbg(host->dev, "biu clock not available\n");
> +	} else {
> +		ret = clk_prepare_enable(host->biu_clk);
> +		if (ret) {
> +			dev_err(host->dev, "failed to enable biu clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	host->ciu_clk = devm_clk_get(host->dev, "ciu");
> +	if (IS_ERR(host->ciu_clk)) {
> +		dev_dbg(host->dev, "ciu clock not available\n");
> +		host->bus_hz = host->pdata->bus_hz;
> +	} else {
> +		ret = clk_prepare_enable(host->ciu_clk);
> +		if (ret) {
> +			dev_err(host->dev, "failed to enable ciu clock\n");
> +			goto err_clk_biu;
> +		}
> +
> +		if (host->pdata->bus_hz) {
> +			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
> +			if (ret)
> +				dev_warn(host->dev,
> +					"Unable to set bus rate to %uHz\n",
> +					 host->pdata->bus_hz);
> +		}
> +		host->bus_hz = clk_get_rate(host->ciu_clk);
> +	}
> +
> +	if (!host->bus_hz) {
> +		dev_err(host->dev,
> +			"Platform data must supply bus speed\n");
> +		ret = -ENODEV;
> +		goto err_clk_ciu;
> +	}
> +
> +	if (!IS_ERR(host->pdata->rstc)) {
> +		reset_control_assert(host->pdata->rstc);
> +		usleep_range(10, 50);
> +		reset_control_deassert(host->pdata->rstc);
> +	}
> +
> +	timer_setup(&host->timer, dw_mci_cqe_cto_timer, 0);
> +
> +	spin_lock_init(&host->lock);
> +	spin_lock_init(&host->irq_lock);
> +	init_rwsem(&host->cr_rw_sem);
> +	tasklet_init(&host->tasklet, dw_mci_cqe_tasklet_func, (unsigned long)host);
> +
> +	host->cqe_reenable = 0;
> +	host->cmd_atomic = false;
> +
> +	/*pio mode's parameters should be initialized here*/
> +
> +	/*Initialize the eMMC IP related attribute*/
> +	dw_mci_cqe_setup(host);
> +
> +	dw_mci_cqe_init_dma(host);
> +
> +	/* This flag will be set 1 when doing tuning,
> +	 * we add this flag because
> +	 * some vendors might use other cmd instead of 21
> +	 * to tune phase under high speed interface.
> +	 * we use this flag to recognize if the system is under tuning stage.
> +	 */
> +	host->tuning = 0;
> +
> +	/*Timing_setting is to avoid sending command
> +	 *before setting phase in hs200, hs400
> +	 */
> +	host->current_speed = 0;
> +
> +	/*Do the rest of init for specific*/
> +	if (drv_data && drv_data->init) {
> +		ret = drv_data->init(host);
> +		if (ret) {
> +			dev_err(host->dev,
> +				"implementation specific init failed\n");
> +			goto err_dmaunmap;
> +		}
> +	}
> +
> +	ret = dw_mci_cqe_init_slot(host);
> +	if (ret) {
> +		dev_err(host->dev, "slot 0 init failed\n");
> +		goto err_dmaunmap;
> +	}
> +
> +	ret = devm_request_irq(host->dev, host->irq, dw_mci_cqe_interrupt,
> +				host->irq_flags, "dw-mci-cqe", host);
> +	if (ret)
> +		goto err_dmaunmap;
> +
> +	/*After the slot initialization,
> +	 *now we have mmc data and can initialize cmdq if user enabled
> +	 */
> +	dw_mci_cqhci_init(host);
> +
> +	/* Now that slots are all setup, we can enable card detect */
> +	dw_mci_cqe_enable_cd(host);
> +
> +	return 0;
> +
> +err_dmaunmap:
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);
> +err_clk_ciu:
> +	clk_disable_unprepare(host->ciu_clk);
> +
> +err_clk_biu:
> +	clk_disable_unprepare(host->biu_clk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_probe);
> +
> +void dw_mci_cqe_remove(struct dw_mci *host)
> +{
> +	dev_dbg(host->dev, "remove slot\n");
> +	if (host->slot)
> +		dw_mci_cqe_cleanup_slot(host->slot);
> +
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);
> +
> +	clk_disable_unprepare(host->ciu_clk);
> +	clk_disable_unprepare(host->biu_clk);
> +
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_remove);
> +
> +#ifdef CONFIG_PM
> +int dw_mci_cqe_runtime_suspend(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if (host->slot) {
> +			dev_info(host->dev, "cqe suspend\n");
> +			ret = cqhci_suspend(host->slot->mmc);
> +			if (ret) {
> +				dev_err(host->dev, "cqe suspend failed\n");
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	ret = pm_runtime_force_suspend(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_runtime_suspend);
> +
> +int dw_mci_cqe_runtime_resume(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int ret = 0;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret) {
> +		dev_err(host->dev, "pm_runtime_force_resume failed\n");
> +		return ret;
> +	}
> +
> +	dw_mci_cqe_setup(host);
> +	if (drv_data && drv_data->init) {
> +		ret = drv_data->init(host);
> +		if (ret)
> +			dev_err(host->dev, "implementation specific init failed\n");
> +	}
> +
> +	init_completion(host->int_waiting);
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if (host->slot) {
> +			dev_info(host->dev, "cqe resume\n");
> +			ret = cqhci_resume(host->slot->mmc);
> +			if (ret)
> +				dev_err(host->dev, "cqe resume failed\n");
> +		}
> +	}
> +
> +	dw_mci_cqe_setup_bus(host->slot, true);
> +	dw_mci_cqe_enable_cd(host);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_runtime_resume);
> +#endif /* CONFIG_PM */
> +
> +static int __init dw_mci_cqe_init(void)
> +{
> +	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
> +	return 0;
> +}
> +
> +static void __exit dw_mci_cqe_exit(void)
> +{
> +}
> +
> +module_init(dw_mci_cqe_init);
> +module_exit(dw_mci_cqe_exit);
> +
> +MODULE_DESCRIPTION("DW Multimedia Card CMDQ Interface driver");
> +MODULE_AUTHOR("<jyanchou@realtek.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/host/dw_mmc_cqe.h b/drivers/mmc/host/dw_mmc_cqe.h
> new file mode 100644
> index 000000000000..ef52b67aceb6
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc_cqe.h
> @@ -0,0 +1,444 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *  Copyright (C) 2023 Realtek Semiconductors, All Rights Reserved.
> + *
> + */
> +
> +#ifndef __DW_MMC_CQE_H
> +#define __DW_MMC_CQE_H
> +
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/mmc/core.h>
> +#include <linux/reset.h>
> +#include <linux/scatterlist.h>
> +
> +struct dw_mci {
> +	spinlock_t              lock;
> +	spinlock_t              irq_lock;
> +	struct tasklet_struct   tasklet;
> +	struct rw_semaphore     cr_rw_sem;
> +
> +	void __iomem            *regs;
> +	resource_size_t         phy_regs;
> +
> +	struct mmc_request      *mrq;
> +	struct mmc_command      *cmd;
> +	struct mmc_command	stop_abort;
> +	struct mmc_data         *data;
> +
> +	struct clk              *biu_clk;
> +	struct clk              *ciu_clk;
> +	struct dw_mci_slot      *slot;
> +	struct timer_list       timer;
> +	struct completion	*int_waiting;
> +
> +	unsigned int		*desc_vaddr;
> +	unsigned int            *sg_cpu;
> +	dma_addr_t              sg_dma;
> +	int                     use_dma;
> +
> +	struct platform_device  *pdev;
> +	struct device           *dev;
> +	struct dw_mci_board     *pdata;
> +	const struct dw_mci_drv_data    *drv_data;
> +	void                    *priv;
> +
> +	u32			opcode;
> +	u32			arg;
> +	u16                     normal_interrupt;
> +	u16                     error_interrupt;
> +	u16                     auto_error_interrupt;
> +
> +	u32                     bus_hz;
> +	u32			current_speed;
> +	u32			stop_cmdr;
> +	bool			is_sbc;
> +	int			dma_64bit_address;
> +	int			using_dma;
> +
> +	unsigned long           irq_flags; /* IRQ flags */
> +	int                     irq;
> +	int                     sdio_id0;
> +
> +	struct scatterlist	*sg;
> +	u32			dma_nents;
> +
> +	u8			tuning;
> +	u8			cqe_reenable;
> +	bool			cmd_atomic;
> +	bool			shift;
> +	struct cqhci_host       *cqe;
> +};
> +
> +enum {
> +	TRANS_MODE_PIO = 0,
> +	TRANS_MODE_DMA,
> +};
> +
> +enum dw_mci_cookie {
> +	COOKIE_UNMAPPED,
> +	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of dwmmc */
> +	COOKIE_MAPPED,		/* mapped by prepare_data() of dwmmc */
> +};
> +/* eMMC control register definition */
> +#define SDMMC_SDMASA_R				0x000
> +#define SDMMC_BLOCKSIZE_R			0x004
> +#define SDMMC_BLOCKCOUNT_R			0x006
> +#define SDMMC_ARGUMENT_R			0x008
> +#define SDMMC_XFER_MODE_R			0x00c
> +#define SDMMC_CMD_R				0x00e
> +#define SDMMC_RESP01_R				0x010
> +#define SDMMC_RESP23_R				0x014
> +#define SDMMC_RESP45_R				0x018
> +#define SDMMC_RESP67_R				0x01c
> +#define SDMMC_BUF_DATA_R			0x020
> +#define SDMMC_PSTATE_REG			0x024
> +#define SDMMC_HOST_CTRL1_R			0x028
> +#define SDMMC_PWR_CTRL_R			0x029
> +#define SDMMC_BGAP_CTRL_R			0x02a
> +#define SDMMC_CLK_CTRL_R			0x02c
> +#define SDMMC_TOUT_CTRL_R			0x02e
> +#define SDMMC_SW_RST_R				0x02f
> +#define SDMMC_NORMAL_INT_STAT_R			0x030
> +#define SDMMC_ERROR_INT_STAT_R			0x032
> +#define SDMMC_NORMAL_INT_STAT_EN_R		0x034
> +#define SDMMC_ERROR_INT_STAT_EN_R		0x036
> +#define SDMMC_NORMAL_INT_SIGNAL_EN_R		0x038
> +#define SDMMC_ERROR_INT_SIGNAL_EN_R		0x03a
> +#define SDMMC_AUTO_CMD_STAT_R			0x03c
> +#define SDMMC_HOST_CTRL2_R			0x03e
> +#define SDMMC_ADMA_ERR_STAT_R			0x054
> +#define SDMMC_ADMA_SA_LOW_R			0x058
> +
> +#define SDMMC_MSHC_CTRL_R			0x208
> +#define SDMMC_CTRL_R				0x22c
> +
> +#define SDMMC_CMD_CONFLICT_CHECK		BIT(0)
> +#define CMD_IDX_MASK(x)				((x >> 8)&0x3f)
> +
> +/*0xc*/
> +#define SDMMC_MULTI_BLK_SEL			5
> +#define SDMMC_DATA_XFER_DIR			4
> +#define SDMMC_BLOCK_COUNT_ENABLE		BIT(1)
> +#define SDMMC_DMA_ENABLE			BIT(0)
> +#define SDMMC_AUTO_CMD_ENABLE			2
> +#define SDMMC_AUTO_CMD_DISABLED			0x0
> +#define SDMMC_AUTO_CMD12_ENABLED		0x1
> +#define SDMMC_AUTO_CMD23_ENABLED		0x2
> +#define SDMMC_AUTO_CMD_SEL			0x3
> +
> +/*0xe*/
> +#define SDMMC_RESP_TYPE_SELECT			0
> +#define SDMMC_CMD_TYPE				6
> +#define SDMMC_NO_RESP				0x0
> +#define SDMMC_RESP_LEN_136			0x1
> +#define SDMMC_RESP_LEN_48			0x2
> +#define SDMMC_RESP_LEN_48B			0x3
> +#define SDMMC_CMD_CHK_RESP_CRC			BIT(3)
> +#define SDMMC_CMD_IDX_CHK_ENABLE		BIT(4)
> +#define SDMMC_DATA				BIT(5)
> +#define SDMMC_ABORT_CMD				0x3
> +#define SDMMC_RESUME_CMD			0x2
> +#define SDMMC_SUSPEND_CMD			0x1
> +#define SDMMC_NORMAL_CMD			0x0
> +
> +/*0x24 PSTATE*/
> +#define SDMMC_CMD_INHIBIT			BIT(0)
> +#define SDMMC_CMD_INHIBIT_DAT			BIT(1)
> +#define SDMMC_DAT_3_0				(0xf << 20)
> +#define SDMMC_DAT_7_4				(0xf << 4)
> +
> +/*0x28*/
> +#define SDMMC_DMA_SEL				3
> +#define SDMMC_SDMA				(0x0)
> +#define SDMMC_ADMA2_32				(0x2)
> +#define SDMMC_ADMA2_64				(0x3)
> +#define SDMMC_EXT_DAT_XFER			BIT(5)
> +#define SDMMC_EXT_DAT_XFER_MASK			(~SDMMC_EXT_DAT_XFER & 0xff)
> +#define SDMMC_HIGH_SPEED_EN			BIT(2)
> +#define SDMMC_HIGH_SPEED_MASK			((~BIT(2)) & 0xff)
> +#define SDMMC_UHS_MODE_SEL_MASK			((~(BIT(0)|BIT(1)|BIT(2))) & 0xffff)
> +#define SDMMC_DAT_XFER_WIDTH			BIT(1)
> +#define SDMMC_DAT_XFER_WIDTH_MASK		(~SDMMC_DAT_XFER_WIDTH & 0xff)
> +#define SDMMC_BUS_WIDTH_8			SDMMC_EXT_DAT_XFER
> +#define SDMMC_BUS_WIDTH_4			SDMMC_DAT_XFER_WIDTH
> +#define SDMMC_BUS_WIDTH_1			0
> +#define SDMMC_DMA_SEL_CLR			(0xff & (~(0x3<<SDMMC_DMA_SEL)))
> +#define SDMMC_DATA_XFER_CLR			((0xff & (~SDMMC_EXT_DAT_XFER)) \
> +						& (~SDMMC_DAT_XFER_WIDTH))
> +
> +/*0x2a*/
> +#define SDMMC_STOP_BG_REQ			BIT(0)
> +
> +/*0x2f SW_RST_R*/
> +#define SDMMC_RST_DAT			BIT(2)
> +#define SDMMC_RST_CMD			BIT(1)
> +#define SDMMC_RST_ALL			BIT(0)
> +
> +/*0x30 status bitmap*/
> +#define SDMMC_STATUS_ALL			0xffff
> +#define SDMMC_ERR_INTERRUPT			BIT(15)
> +#define SDMMC_CQE_EVENT				BIT(14)
> +#define SDMMC_FX_EVENT				BIT(13)
> +#define SDMMC_RE_TUNE_EVENT			BIT(12)
> +#define SDMMC_INT_C				BIT(11)
> +#define SDMMC_INT_B				BIT(10)
> +#define SDMMC_INT_A				BIT(9)
> +#define SDMMC_CARD_INTERRUPT			BIT(8)
> +#define SDMMC_CARD_REMOVAL			BIT(7)
> +#define SDMMC_CARD_INSERTION			BIT(6)
> +#define SDMMC_BUF_RD_READY			BIT(5)
> +#define SDMMC_BUF_WR_READY			BIT(4)
> +#define SDMMC_DMA_INTERRPT			BIT(3)
> +#define SDMMC_BGAP_EVENT			BIT(2)
> +#define SDMMC_XFER_COMPLETE			BIT(1)
> +#define SDMMC_CMD_COMPLETE			BIT(0)
> +
> +/*0x32 error bitmap*/
> +#define SDMMC_VENDOR_ERR3			BIT(15)
> +#define SDMMC_VENDOR_ERR2			BIT(14)
> +#define SDMMC_VENDOR_ERR1			BIT(13)
> +#define SDMMC_BOOT_ACK_ERR			BIT(12)
> +#define SDMMC_RESP_ERR				BIT(11)
> +#define SDMMC_TUNING_ERR			BIT(10)
> +#define SDMMC_ADMA_ERR				BIT(9)
> +#define SDMMC_AUTO_CMD_ERR			BIT(8)
> +#define SDMMC_CUR_LMT_ERR			BIT(7)
> +#define SDMMC_DATA_END_BIT_ERR			BIT(6)
> +#define SDMMC_DATA_CRC_ERR			BIT(5)
> +#define SDMMC_DATA_TOUT_ERR			BIT(4)
> +#define SDMMC_CMD_IDX_ERR			BIT(3)
> +#define SDMMC_CMD_END_BIT_ERR			BIT(2)
> +#define SDMMC_CMD_CRC_ERR			BIT(1)
> +#define SDMMC_CMD_TOUT_ERR			BIT(0)
> +#define SDMMC_CMD_ERR                           (SDMMC_AUTO_CMD_ERR| \
> +						SDMMC_CMD_IDX_ERR|SDMMC_CMD_END_BIT_ERR| \
> +						SDMMC_CMD_CRC_ERR|SDMMC_CMD_TOUT_ERR)
> +#define SDMMC_DATA_ERR				(SDMMC_ADMA_ERR| \
> +						SDMMC_DATA_END_BIT_ERR| \
> +						SDMMC_DATA_CRC_ERR|SDMMC_DATA_TOUT_ERR)
> +
> +/*0x34 status enable bitmap*/
> +#define SDMMC_CQE_EVENT_STAT_EN			BIT(14)
> +#define SDMMC_FX_EVENT_STAT_EN			BIT(13)
> +#define SDMMC_RE_TUNE_EVENT_STAT_EN		BIT(12)
> +#define SDMMC_INT_C_STAT_EN			BIT(11)
> +#define SDMMC_INT_B_STAT_EN			BIT(10)
> +#define SDMMC_INT_A_STAT_EN			BIT(9)
> +#define SDMMC_CARD_INTERRUPT_STAT_EN		BIT(8)
> +#define SDMMC_CARD_REMOVAL_STAT_EN		BIT(7)
> +#define SDMMC_CARD_INSERTION_STAT_EN		BIT(6)
> +#define SDMMC_BUF_RD_READY_STAT_EN		BIT(5)
> +#define SDMMC_BUF_WR_READY_STAT_EN		BIT(4)
> +#define SDMMC_DMA_INTERRPT_STAT_EN		BIT(3)
> +#define SDMMC_BGAP_EVENT_STAT_EN		BIT(2)
> +#define SDMMC_XFER_COMPLETE_STAT_EN		BIT(1)
> +#define SDMMC_CMD_COMPLETE_STAT_EN		BIT(0)
> +
> +/*0x36 error status enable bitmap*/
> +#define SDMMC_VENDOR_ERR_STAT_EN3		BIT(15)
> +#define SDMMC_VENDOR_ERR_STAT_EN2		BIT(14)
> +#define SDMMC_VENDOR_ERR_STAT_EN1		BIT(13)
> +#define SDMMC_BOOT_ACK_ERR_STAT_EN		BIT(12)
> +#define SDMMC_RESP_ERR_STAT_EN			BIT(11)
> +#define SDMMC_TUNING_ERR_STAT_EN		BIT(10)
> +#define SDMMC_ADMA_ERR_STAT_EN			BIT(9)
> +#define SDMMC_AUTO_CMD_ERR_STAT_EN		BIT(8)
> +#define SDMMC_CUR_LMT_ERR_STAT_EN		BIT(7)
> +#define SDMMC_DATA_END_BIT_ERR_STAT_EN		BIT(6)
> +#define SDMMC_DATA_CRC_ERR_STAT_EN		BIT(5)
> +#define SDMMC_DATA_TOUT_ERR_STAT_EN		BIT(4)
> +#define SDMMC_CMD_IDX_ERR_STAT_EN		BIT(3)
> +#define SDMMC_CMD_END_BIT_ERR_STAT_EN		BIT(2)
> +#define SDMMC_CMD_CRC_ERR_STAT_EN		BIT(1)
> +#define SDMMC_CMD_TOUT_ERR_STAT_EN		BIT(0)
> +
> +/*0x38 signal interrupt enable*/
> +#define SDMMC_CQE_EVENT_SIGNAL_EN		BIT(14)
> +#define SDMMC_FX_EVENT_SIGNAL_EN		BIT(13)
> +#define SDMMC_RE_TUNE_EVENT_SIGNAL_EN		BIT(12)
> +#define SDMMC_INT_C_SIGNAL_EN			BIT(11)
> +#define SDMMC_INT_B_SIGNAL_EN			BIT(10)
> +#define SDMMC_INT_A_SIGNAL_EN			BIT(9)
> +#define SDMMC_CARD_INTERRUPT_SIGNAL_EN		BIT(8)
> +#define SDMMC_CARD_REMOVAL_SIGNAL_EN		BIT(7)
> +#define SDMMC_CARD_INSERTION_SIGNAL_EN		BIT(6)
> +#define SDMMC_BUF_RD_READY_SIGNAL_EN		BIT(5)
> +#define SDMMC_BUF_WR_READY_SIGNAL_EN		BIT(4)
> +#define SDMMC_DMA_INTERRPT_SIGNAL_EN		BIT(3)
> +#define SDMMC_BGAP_EVENT_SIGNAL_EN		BIT(2)
> +#define SDMMC_XFER_COMPLETE_SIGNAL_EN		BIT(1)
> +#define SDMMC_CMD_COMPLETE_SIGNAL_EN		BIT(0)
> +#define SDMMC_NORMAL_INT_SIGNAL_CMD_EN_R	(~(BIT(6) | BIT(7) | BIT(8) | BIT(1)) & 0xffff)
> +#define SDMMC_NORMAL_INT_SIGNAL_DAT_EN_R	(~(BIT(6) | BIT(7) | BIT(8) | BIT(0)) & 0xffff)
> +#define SDMMC_NORMAL_INT_SIGNAL_CQE_EN_R	(~(BIT(6) | BIT(7) | BIT(8) | \
> +						BIT(1) | BIT(0)) & 0xffff)
> +
> +/*0x3a error ssignal enable bitmap*/
> +#define SDMMC_VENDOR_ERR_SIGNAL_EN3		BIT(15)
> +#define SDMMC_VENDOR_ERR_SIGNAL_EN2		BIT(14)
> +#define SDMMC_VENDOR_ERR_SIGNAL_EN1		BIT(13)
> +#define SDMMC_BOOT_ACK_ERR_SIGNAL_EN		BIT(12)
> +#define SDMMC_RESP_ERR_SIGNAL_EN		BIT(11)
> +#define SDMMC_TUNING_ERR_SIGNAL_EN		BIT(10)
> +#define SDMMC_ADMA_ERR_SIGNAL_EN		BIT(9)
> +#define SDMMC_AUTO_CMD_ERR_SIGNAL_EN		BIT(8)
> +#define SDMMC_CUR_LMT_ERR_SIGNAL_EN		BIT(7)
> +#define SDMMC_DATA_END_BIT_ERR_SIGNAL_EN	BIT(6)
> +#define SDMMC_DATA_CRC_ERR_SIGNAL_EN		BIT(5)
> +#define SDMMC_DATA_TOUT_ERR_SIGNAL_EN		BIT(4)
> +#define SDMMC_CMD_IDX_ERR_SIGNAL_EN		BIT(3)
> +#define SDMMC_CMD_END_BIT_ERR_SIGNAL_EN		BIT(2)
> +#define SDMMC_CMD_CRC_ERR_SIGNAL_EN		BIT(1)
> +#define SDMMC_CMD_TOUT_ERR_STAT_EN		BIT(0)
> +
> +#define SDMMC_ALL_NORMAL_STAT_EN		(0xfeff)
> +#define SDMMC_ALL_ERR_STAT_EN			(0xffff)
> +					/*enablle all error initerrupt in 0x36*/
> +#define SDMMC_ALL_SIGNAL_STAT_EN                (0xfeff)
> +#define SDMMC_ALL_ERR_SIGNAL_EN			(0xffff)
> +					/*enable all signal error interrupt in 0x3a*/
> +
> +/*0x3e*/
> +#define SDMMC_LEGACY				0x0
> +#define SDMMC_SDR				0x1
> +#define SDMMC_HS200				0x3
> +#define SDMMC_DDR				0x4
> +#define SDMMC_HS400				0x7
> +#define SDMMC_HOST_VER4_ENABLE			BIT(12)
> +#define SDMMC_SIGNALING_EN			BIT(3)
> +
> +/*0x22c*/
> +#define SDMMC_RST_N_OE				BIT(3)
> +#define SDMMC_RST_N				BIT(2)
> +#define SDMMC_CARD_IS_EMMC			BIT(0)
> +
> +#define SDMMC_INTERNAL_CLK_EN			BIT(0)
> +#define SDMMC_PLL_USABLE			BIT(0)
> +
> +#define VALID(x)			((x & 1) << 0)
> +#define END(x)				((x & 1) << 1)
> +#define INT(x)				((x & 1) << 2)
> +#define ACT(x)				((x & 0x7) << 3)
> +#define DAT_LENGTH(x)			((x & 0xFFFF) << 16)
> +
> +
> +/* Register access macros */
> +#define mci_readl(dev, reg)                     \
> +	readl_relaxed((dev)->regs + SDMMC_##reg)
> +#define mci_writel(dev, reg, value)                     \
> +	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
> +
> +#define mci_readw(dev, reg)                     \
> +	readw_relaxed((dev)->regs + SDMMC_##reg)
> +#define mci_writew(dev, reg, value)                     \
> +	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
> +
> +#define mci_readb(dev, reg)                     \
> +	readb_relaxed((dev)->regs + SDMMC_##reg)
> +#define mci_writeb(dev, reg, value)                     \
> +	writeb_relaxed((value), (dev)->regs + SDMMC_##reg)
> +
> +#define dw_mci_get_int(dev)    \
> +	do {    \
> +		dev->normal_interrupt = mci_readw(dev, NORMAL_INT_STAT_R);   \
> +		dev->error_interrupt = mci_readw(dev, ERROR_INT_STAT_R);   \
> +		dev->auto_error_interrupt = mci_readw(dev, AUTO_CMD_STAT_R);     \
> +	} while (0)
> +
> +/*clear status register, we always keep the card interrupt*/
> +#define dw_mci_clr_int(dev)                                             \
> +	do {                                                            \
> +		mci_writew(dev, ERROR_INT_STAT_R, mci_readw(dev, ERROR_INT_STAT_R) & 0xffff); \
> +		mci_writew(dev, NORMAL_INT_STAT_R, mci_readw(dev, NORMAL_INT_STAT_R) & 0xffff); \
> +	} while (0)
> +
> +/*mask all emmc interrupts*/
> +#define dw_mci_clr_signal_int(dev)    \
> +	do {      \
> +		mci_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
> +			mci_readw(dev, NORMAL_INT_SIGNAL_EN_R) & (BIT(6)|BIT(7))); \
> +		mci_writew(dev, ERROR_INT_SIGNAL_EN_R, 0); \
> +	} while (0)
> +
> +/*for cmdq, we do not need cmd and xfer done, only cqe event*/
> +#define dw_mci_en_cqe_int(dev)  \
> +	do { \
> +		mci_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
> +			mci_readw(dev, NORMAL_INT_SIGNAL_EN_R)|SDMMC_NORMAL_INT_SIGNAL_CQE_EN_R); \
> +		mci_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
> +	} while (0)
> +
> +/*used for data, r1b case, we mask cmd done interrupt*/
> +#define dw_mci_en_xfer_int(dev)  \
> +	do {  \
> +		mci_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
> +			mci_readw(dev, NORMAL_INT_SIGNAL_EN_R)|SDMMC_NORMAL_INT_SIGNAL_DAT_EN_R); \
> +		mci_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
> +	} while (0)
> +
> +/*used for none-stream case (cmd w/wo/ resp)*/
> +#define dw_mci_en_cd_int(dev)  \
> +	do {    \
> +		mci_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
> +			mci_readw(dev, NORMAL_INT_SIGNAL_EN_R)|SDMMC_NORMAL_INT_SIGNAL_CMD_EN_R); \
> +		mci_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
> +	} while (0)
> +
> +extern int dw_mci_cqe_probe(struct dw_mci *host);
> +extern void dw_mci_cqe_remove(struct dw_mci *host);
> +#ifdef CONFIG_PM
> +extern int dw_mci_cqe_runtime_suspend(struct device *device);
> +extern int dw_mci_cqe_runtime_resume(struct device *device);
> +#endif
> +irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error, int data_error);
> +
> +/* Board platform data */
> +struct dw_mci_board {
> +	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
> +	u32 caps;       /* Capabilities */
> +	u32 caps2;      /* More capabilities */
> +	u32 pm_caps;    /* PM capabilities */
> +
> +	/* delay in mS before detecting cards after interrupt */
> +	u32 detect_delay_ms;
> +
> +	struct reset_control *rstc;
> +};
> +
> +struct dw_mci_slot {
> +	struct mmc_host         *mmc;
> +	struct dw_mci           *host;
> +
> +	struct mmc_request      *mrq;
> +
> +	unsigned int            clock;
> +	unsigned int            __clk_old;
> +
> +	unsigned long           flags;
> +#define DW_MMC_CARD_PRESENT     1
> +	int                     id;
> +	int                     sdio_id;
> +	u8                      switch_partition;
> +};
> +
> +struct dw_mci_drv_data {
> +	unsigned long   *caps;
> +	u32             num_caps;
> +	int             (*init)(struct dw_mci *host);
> +	void            (*set_ios)(struct dw_mci_slot *slot, struct mmc_ios *ios);
> +	int             (*parse_dt)(struct dw_mci *host);
> +	int             (*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
> +	int             (*prepare_hs400_tuning)(struct dw_mci *host,
> +					struct mmc_ios *ios);
> +	int             (*switch_voltage)(struct mmc_host *mmc,
> +					struct mmc_ios *ios);
> +	void            (*hs400_complete)(struct mmc_host *mmc);
> +	void		(*init_card)(struct mmc_host *host,
> +					struct mmc_card *card);
> +	void            (*shift_rsp)(struct dw_mci *host, struct mmc_command *cmd, u32 *rsp);
> +};
> +
> +void dw_mci_cqe_wait_done(struct dw_mci *host, u32 *addr, u32 mask, u32 value);
> +#endif

