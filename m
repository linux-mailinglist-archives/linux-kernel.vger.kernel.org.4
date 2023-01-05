Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C865F5C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjAEV2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbjAEV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:28:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC96319C;
        Thu,  5 Jan 2023 13:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672954117; x=1704490117;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=GRblnjyG5tlHFl08K5fEJXs/iWbjW/lO8c0EVyXTEmI=;
  b=AWAOT6qpYJEsYf6RP9ZC9Goetzwsm8KuYVxrit3E4hKa6GPMDkhkghYx
   gSVPQfYd+MQ5aTnLf4xGE0Onlv6o3FUsps5gUF+u2vytgSCCttiCMXm0X
   ewxLa4Vr5KB6JS6XFoVTKEbN4v/E+FoJGZbG2NGCm+/FCE7XldqnQD6gp
   ENBStzZDJtjtgWe9hWaJwaJAhk6KQ104k6+DkPiiYQzOjQki6Ady0px2M
   jaY6lmON1qiOorMUIIGLa16p0nA02oucwLxkOzM/cjkk5/PpRF9E8eEys
   7hDfSwIci1ZVV8aGZByzsWG7kgeBExYWzfASMFkYBdO4uUe7QgoNy1Qrc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408583355"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408583355"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:28:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="744403342"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="744403342"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:28:33 -0800
Message-ID: <d032a567-51ed-44b4-6040-1d721ac00d09@intel.com>
Date:   Thu, 5 Jan 2023 23:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 17/24] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-18-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-18-victor.shih@genesyslogic.com.tw>
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
> This is a sdhci version of mmc's uhs2_set_reg operation.
> UHS-II interface (related registers) will be initialised here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 92 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 11 +++++
>  2 files changed, 103 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c7e411fa0a6e..de15a6559702 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -276,6 +276,48 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	sdhci_set_clock(host, host->clock);
>  }
>  
> +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> +{
> +	u32 value;
> +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
> +	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
> +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> +	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
> +	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
> +
> +	/* Set Gen Settings */
> +	value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
> +	sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
> +
> +	/* Set PHY Settings */
> +	value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
> +		FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
> +	if (host->mmc->flags & MMC_UHS2_SPEED_B)
> +		value |= SDHCI_UHS2_PHY_SET_SPEED_B;
> +	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> +
> +	/* Set LINK-TRAN Settings */
> +	value = FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc->uhs2_caps.max_retry_set) |
> +		FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_caps.n_fcu_set);
> +	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> +	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_uhs2_tran_set_1_reg);
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
> @@ -361,6 +403,55 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
>  	return 0;
>  }
>  
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
> +
> +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int err = 0;
> +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
> +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> +
> +	DBG("Begin uhs2 control, act %d.\n", op);
> +
> +	switch (op) {
> +	case UHS2_PHY_INIT:
> +		err = sdhci_uhs2_do_detect_init(mmc);
> +		break;
> +	case UHS2_SET_CONFIG:
> +		sdhci_uhs2_set_config(host);
> +		break;
> +	case UHS2_ENABLE_INT:
> +		sdhci_uhs2_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> +		break;
> +	case UHS2_DISABLE_INT:
> +		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> +		break;
> +	case UHS2_SET_SPEED_B:
> +		sdhci_writeb(host, SDHCI_UHS2_PHY_SET_SPEED_B, sdhci_uhs2_phy_set_reg);
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
> +	return err;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -489,6 +580,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		sdhci_uhs2_start_signal_voltage_switch;
>  	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
> +	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
>  
>  	return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 49bbdc155b2b..3656e66fcca7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -234,6 +234,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
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

Not used anymore

> +
>  static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  {
>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {

