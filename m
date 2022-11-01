Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8D615059
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKARQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKARPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:15:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803541CFE7;
        Tue,  1 Nov 2022 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322908; x=1698858908;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=zyrXWXLjW8cwxg3xwjBVHuKYuGZ3fwqkBGoqR4Zbnlg=;
  b=Ut/uAc/u4WYg3Iwf9t07r5nq293WPHW7IjgX2I2WQY1fUl/opI/bc75r
   V6CIigWgqowEQsL3JENCw+4mHlbfL7XtGiOOseYCEMlElIjQqziStkPt3
   gw49qmnijV1nVxQ0GfXUS+KlgfvT7Y40qLl/xd/TP6E6LAqAR+4wI9/VE
   EyidqDRLPqPVo69IBkfSmNCRaV1rN2262/by5q5uxtCguv+sHlcHk8cBJ
   86QycmPUwIA7GxkcPEq26zi+eh76KBH+a4Re+ZJOuHKblNNJCFQHHqFEG
   wA1x4kOE1/Sgf1sNqEUMTPfpsOjHQnRNKFd/cQjmqkxBZaGdJ9uB5x1c0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="306810372"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="306810372"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:15:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665220258"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665220258"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:15:04 -0700
Message-ID: <e935fe27-ea94-366f-4fd4-f40b05af30b8@intel.com>
Date:   Tue, 1 Nov 2022 19:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 18/26] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-19-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-19-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> This is a sdhci version of mmc's uhs2_set_reg operation.
> UHS-II interface (related registers) will be initialised here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 103 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      |  12 ++++
>  drivers/mmc/host/sdhci.h      |   1 +
>  3 files changed, 116 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index afaca5d96938..c9d59b8ac37f 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -350,6 +350,53 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> +{
> +	u32 value;
> +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> +	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
> +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> +	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
> +	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
> +
> +	/* Set Gen Settings */
> +	sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
> +		SDHCI_UHS2_GEN_SET_N_LANES_POS, sdhci_uhs2_gen_set_reg);
> +
> +	/* Set PHY Settings */
> +	value = (host->mmc->uhs2_caps.n_lss_dir_set <<
> +			SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
> +		(host->mmc->uhs2_caps.n_lss_sync_set <<
> +			SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
> +	if (host->mmc->flags & MMC_UHS2_SPEED_B)
> +		value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
> +	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> +
> +	/* Set LINK-TRAN Settings */
> +	value = (host->mmc->uhs2_caps.max_retry_set <<
> +			SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
> +		(host->mmc->uhs2_caps.n_fcu_set <<
> +			SDHCI_UHS2_TRAN_SET_N_FCU_POS);
> +	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> +	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
> +		     sdhci_uhs2_tran_set_1_reg);
> +}
> +
> +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> +{
> +	u32 val;
> +	/* 100ms */
> +	int timeout = 100000;
> +
> +	if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
> +				     100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> +		pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
> +		sdhci_dumpregs(host);
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> @@ -435,6 +482,61 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
>  	return 0;
>  }
>  
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
> +
> +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	int err = 0;
> +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> +
> +	DBG("Begin %s, act %d.\n", __func__, op);

DBG already has __func__.  Please also check other DBG that
have duplicate __func__

> +
> +	spin_lock_irqsave(&host->lock, flags);

This all relates to initialization or reinitialization, so I suspect
the spinlock is not needed here.  What could it be racing with?

> +
> +	switch (op) {
> +	case UHS2_PHY_INIT:
> +		err = sdhci_uhs2_do_detect_init(mmc);
> +		break;
> +	case UHS2_SET_CONFIG:
> +		sdhci_uhs2_set_config(host);
> +		break;
> +	case UHS2_ENABLE_INT:
> +		sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> +		break;
> +	case UHS2_DISABLE_INT:
> +		sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> +		break;
> +	case UHS2_SET_SPEED_B:
> +		sdhci_writeb(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
> +			     sdhci_uhs2_phy_set_reg);
> +		break;
> +	case UHS2_CHECK_DORMANT:
> +		err = sdhci_uhs2_check_dormant(host);
> +		break;
> +	case UHS2_DISABLE_CLK:
> +		err = sdhci_uhs2_disable_clk(mmc);
> +		break;
> +	case UHS2_ENABLE_CLK:
> +		err = sdhci_uhs2_enable_clk(mmc);
> +		break;
> +	case UHS2_POST_ATTACH_SD:
> +		host->ops->uhs2_post_attach_sd(host);
> +		break;
> +	default:
> +		pr_err("%s: input sd uhs2 operation %d is wrong!\n",
> +		       mmc_hostname(host->mmc), op);
> +		err = -EIO;
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return err;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -589,6 +691,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		sdhci_uhs2_start_signal_voltage_switch;
>  	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
> +	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
>  
>  	if (!host->mmc_host_ops.uhs2_detect_init)
>  		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index de47c71995fb..b9db2e976010 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -236,6 +236,18 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_reset);
>  
> +void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> +{
> +	u32 ier;
> +
> +	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
> +	ier &= ~clear;
> +	ier |= set;
> +	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_clear_set_irqs);

This might as well be in sdhci-uhs2.c since that is the only
place that calls it.  Then there is no need to export it.

> +
>  static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  {
>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 22d7f47862ae..f049331bd0bc 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -869,6 +869,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
> +void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);

