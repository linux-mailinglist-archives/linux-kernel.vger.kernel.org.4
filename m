Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF36DF6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDLNOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDLNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:14:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA18685;
        Wed, 12 Apr 2023 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305252; x=1712841252;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=yZyJFZAL074BD+FQEoGfACS+GdNdPY39QiXtWVhgOAc=;
  b=ZRGST8rAjAN1i5HXj4+Ypj6t72zMLaROvFfslIPHSDYDeR3cEiGdlGg0
   iLvnM05W/bfMgRjAGI2PoXDdFZiCaT76J56RSZnk2TRJ+W2HIreDJk94h
   wnwdtEBcFjZ8YPxiHB1+RrhuJVPiORHmwPGjCGzbv0swkqYDOGncOh38A
   /itkhIVyscJ586b1pDL0sOBd5qqjeG/yk9n8jfAjjbd67gVqKhgOqWtTm
   WFCZg8uUwfCu0lh6I9yRDpFs8ETWDnfoTIKM1ir5p7SN9eTw8aJ9cVmDk
   /Kp4MX4iGFbchk4lC2B8A8MqE97p6eg5JFewrs4bGw2zu0P0Nbk/YJhv6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332587051"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332587051"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639228769"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639228769"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:11:38 -0700
Message-ID: <402b9e3e-7d30-bf80-1ebe-708821e55983@intel.com>
Date:   Wed, 12 Apr 2023 16:11:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 17/23] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-18-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-18-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/23 13:55, Victor Shih wrote:
> This is a sdhci version of mmc's uhs2_set_reg operation.
> UHS-II interface (related registers) will be initialised here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 89 +++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 71ac76065886..6fe394b1a7be 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -278,6 +278,49 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

Perhaps line these up and lose the parentheses.

	u16 sdhci_uhs2_gen_set_reg    = sdhci_uhs2_set_ptr;
	u16 sdhci_uhs2_phy_set_reg    = sdhci_uhs2_set_ptr + 4;
	u16 sdhci_uhs2_tran_set_reg   = sdhci_uhs2_set_ptr + 8;
	u16 sdhci_uhs2_tran_set_1_reg = sdhci_uhs2_set_ptr + 12;

> +
> +	/* Set Gen Settings */
> +	value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
> +	sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
> +
> +	/* Set PHY Settings */
> +	value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
> +		FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
> +	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD)
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

atomic not needed

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
> @@ -360,6 +403,51 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
>  	return 0;
>  }
>  
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
> +
> +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_ios *ios = &mmc->ios;
> +	int err = 0;
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
> +	case UHS2_CHECK_DORMANT:
> +		err = sdhci_uhs2_check_dormant(host);
> +		break;
> +	case UHS2_DISABLE_CLK:
> +		err = sdhci_uhs2_disable_clk(mmc);
> +		break;
> +	case UHS2_ENABLE_CLK:
> +		err = sdhci_uhs2_enable_clk(mmc);
> +		break;
> +	case UHS2_SET_IOS:
> +		err = sdhci_uhs2_set_ios(mmc, ios);
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
> @@ -487,6 +575,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		sdhci_uhs2_start_signal_voltage_switch;
> +	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
>  
>  	return 0;
>  }

