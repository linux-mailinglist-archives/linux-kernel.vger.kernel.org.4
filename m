Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2E74DAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGJQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjGJQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:02:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679FC3;
        Mon, 10 Jul 2023 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004976; x=1720540976;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hMjsqrMiTm4+WAwSsHhItZpaMi8BgFLqT6Cd9UFm7bk=;
  b=EmYuFOJ2FTqp1wDJkEj2h4cRY6ZJVZQwthLMKD3MLGsRlcq5QB5kxvmy
   rxZGVMisfOtCS5BbMZUE9hCGTBZpTIZ+elW/Mw0uNxQZxmJ0bdHLlwv2e
   L+eUdVuMTnFesN+/5CeljXPqrf8K1YGi4cN+sNa8OAIxEJTmgD3BfNyyw
   qnMNyFE6r6yvBBMHigOMJlcHKYxC2ZacviS8PXHSZNMBD6uejWHWRIR1d
   seUt/m95v4hNYqJt1TIbXdqtoic9yW5yQf0OzSugK7HXyKvlxfNiKVUEt
   EEiqJOVOLj2CPDasmpU9pAhtRrfjuGPayp7yLGWP1kDdAllFfVXIKgJcP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364421404"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364421404"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834320624"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834320624"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.97])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:02:39 -0700
Message-ID: <cf59220b-2aa7-b487-b469-f2e6260058b5@intel.com>
Date:   Mon, 10 Jul 2023 19:02:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V8 14/23] mmc: sdhci-uhs2: add set_ios()
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-15-victorshihgli@gmail.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230621100151.6329-15-victorshihgli@gmail.com>
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
> This is a sdhci version of mmc's set_ios operation.
> It covers both UHS-I and UHS-II.
> 
> Updates in V8:
>  - Add the judgment formula for MMC_TIMING_SPEED_A_HD,
>    MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
>    __sdhci_uhs2_set_ios().
>  - Add the switch case for MMC_TIMING_SPEED_A_HD,
>    MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
>    sdhci_get_preset_value().
>  - mmc_opt_regulator_set_ocr() to instead of
>    mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> 
> Updates in V7:
>  - Remove unnecessary functions.
> 
> Updates in V6:
>  - Modify return value in some functions.
>  - Remove unnecessary functions.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 94 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>  drivers/mmc/host/sdhci.c      | 56 +++++++++++++--------
>  drivers/mmc/host/sdhci.h      |  2 +
>  4 files changed, 132 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index d519e6ce6199..ad791c48f681 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -214,6 +214,70 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
>  
> +/**
> + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
> + * @host:	SDHCI host
> + * @clear:	bit-wise clear mask
> + * @set:	bit-wise set mask
> + *
> + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> + */
> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> +{
> +	u32 ier;
> +
> +	ier = sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
> +	ier &= ~clear;
> +	ier |= set;
> +	sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
> +	sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> +
> +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u8 cmd_res, dead_lock;
> +	u16 ctrl_2;
> +
> +	/* UHS2 Timeout Control */
> +	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> +
> +	/* change to use calculate value */
> +	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
> +
> +	sdhci_uhs2_clear_set_irqs(host,
> +				  SDHCI_UHS2_INT_CMD_TIMEOUT |
> +				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
> +				  0);
> +	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> +	sdhci_uhs2_clear_set_irqs(host, 0,
> +				  SDHCI_UHS2_INT_CMD_TIMEOUT |
> +				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
> +
> +	/* UHS2 timing. Note, UHS2 timing is disabled when powering off */
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	if (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
> +	    ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +	    ios->timing == MMC_TIMING_UHS2_SPEED_B ||
> +	    ios->timing == MMC_TIMING_UHS2_SPEED_B_HD)
> +		ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
> +	else
> +		ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +	host->timing = ios->timing;
> +
> +	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> +		sdhci_enable_preset_value(host, true);
> +
> +	if (host->ops->set_power)
> +		host->ops->set_power(host, ios->power_mode, ios->vdd);
> +	else
> +		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> +
> +	sdhci_set_clock(host, host->clock);
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> @@ -235,6 +299,36 @@ static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
>  	return sdhci_start_signal_voltage_switch(mmc, ios);
>  }
>  
> +static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> +		 mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd, ios->timing);
> +
> +	if (!sdhci_uhs2_mode(host)) {
> +		sdhci_set_ios(mmc, ios);
> +		return 0;
> +	}
> +
> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> +		return 0;
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD) {
> +		if (ios->power_mode == MMC_POWER_OFF) {
> +			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> +		}
> +		return -1;
> +	}
> +
> +	sdhci_set_ios_common(mmc, ios);
> +
> +	__sdhci_uhs2_set_ios(mmc, ios);
> +
> +	return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index ccf4e1834c2d..a3641c5f8c77 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -181,5 +181,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ef344d4edf8f..6e5a9d93a769 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -47,8 +47,6 @@
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
>  
> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> -
>  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
>  
>  void sdhci_dumpregs(struct sdhci_host *host)
> @@ -1877,6 +1875,12 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  	case MMC_TIMING_MMC_HS400:
>  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
>  		break;
> +	case MMC_TIMING_UHS2_SPEED_A:
> +	case MMC_TIMING_UHS2_SPEED_A_HD:
> +	case MMC_TIMING_UHS2_SPEED_B:
> +	case MMC_TIMING_UHS2_SPEED_B_HD:
> +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> +		break;
>  	default:
>  		pr_warn("%s: Invalid UHS-I mode selected\n",
>  			mmc_hostname(host->mmc));
> @@ -2323,24 +2327,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
>  	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
>  }
>  
> -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	bool reinit_uhs = host->reinit_uhs;
> -	bool turning_on_clk = false;
> -	u8 ctrl;
> -
> -	host->reinit_uhs = false;
> -
> -	if (ios->power_mode == MMC_POWER_UNDEFINED)
> -		return;
> -
> -	if (host->flags & SDHCI_DEVICE_DEAD) {
> -		if (!IS_ERR(mmc->supply.vmmc) &&
> -		    ios->power_mode == MMC_POWER_OFF)
> -			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> -		return;
> -	}
>  
>  	/*
>  	 * Reset the chip on each power off.
> @@ -2357,8 +2346,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		sdhci_enable_preset_value(host, false);
>  
>  	if (!ios->clock || ios->clock != host->clock) {
> -		turning_on_clk = ios->clock && !host->clock;
> -
>  		host->ops->set_clock(host, ios->clock);
>  		host->clock = ios->clock;
>  
> @@ -2374,6 +2361,32 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			mmc->max_busy_timeout /= host->timeout_clk;
>  		}
>  	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> +
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	bool reinit_uhs = host->reinit_uhs;
> +	bool turning_on_clk = false;
> +	u8 ctrl;
> +
> +	host->reinit_uhs = false;
> +
> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> +		return;
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD) {
> +		if (!IS_ERR(mmc->supply.vmmc) &&
> +		    ios->power_mode == MMC_POWER_OFF)
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		return;
> +	}
> +
> +	if (!ios->clock || ios->clock != host->clock)
> +		turning_on_clk = ios->clock && !host->clock;

This is simpler and then turning_on_clk need not be initialised earlier:

	turning_on_clk = ios->clock != host->clock && ios->clock && !host->clock;

> +
> +	sdhci_set_ios_common(mmc, ios);
>  
>  	if (host->ops->set_power)
>  		host->ops->set_power(host, ios->power_mode, ios->vdd);
> @@ -2957,7 +2970,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
>  
> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  {
>  	/* Host Controller v3.00 defines preset value registers */
>  	if (host->version < SDHCI_SPEC_300)
> @@ -2985,6 +2998,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  		host->preset_enabled = enable;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
>  
>  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>  				int err)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f3bd558b337f..03d29423a678 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -847,6 +847,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);

