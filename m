Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52986A92BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCCIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCCIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:38:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8F344B1;
        Fri,  3 Mar 2023 00:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677832674; x=1709368674;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=99a0egF5HzTdYJhqz5GN8l1ewoGU6i01RW0IKv7vsvA=;
  b=nz/s68GvlPOHQ7gF7By2SbBLhmAFMQUDNewcbaOqJAC7ymYjA0VF2ZgL
   8dTuBpRh+1C6VTjFp8qU5njUetnvT60fsTfAc0aT00SN2iCketG5WEpwd
   5+LgSsOCM8bD6PdK3ykjQCCqJiRUjaWpAYjf77hdHJG3ATuF0AVfkzGPi
   YW9WvOFNBKWXnIf42qh6n82fDpWOB02PVqhvC3aoG2kgKzdiIV4bHRIQU
   fnlrk5tvgA+Tp7AhJH2H1+P5aoorlU8g3S9rhu4Qj6H1qHApIdV34Ewna
   hL9ETzqrDV/dCam0uQNQJBayIo1tbdhMOfouK/o5ztTukzRmxwAsplgWb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="314650837"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="314650837"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="707745336"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="707745336"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.227])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:37:00 -0800
Message-ID: <ce9e7b04-7030-a34a-eadf-56a914dcaaf1@intel.com>
Date:   Fri, 3 Mar 2023 10:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-cadence: Add debug option for
 sdhci-cadence driver
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-7-pmalgujar@marvell.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230227183151.27912-7-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/23 20:31, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Use Kernel config CONFIG_MMC_DEBUG to support dumping PHY and host
> controller register configuration for debug.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 154 +++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index badff2df70b904779c70775b02b40086780b118d..c448a100f32c8c44a0da7c71c2aa5d25ac5a4b44 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -115,6 +115,10 @@
>  #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY		GENMASK(15, 8)
>  #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY		GENMASK(7, 0)
>  
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0				0x201C
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1				0x2020
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2				0x2024
> +
>  #define SDHCI_CDNS_SD6_PHY_CTRL					0x2080
>  #define	SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING		GENMASK(9, 4)
>  
> @@ -968,6 +972,154 @@ static void sdhci_cdns_sd6_calc_phy(struct sdhci_cdns_sd6_phy *phy)
>  	}
>  }
>  
> +#ifdef CONFIG_MMC_DEBUG

At this point this might as well be instead:

#if defined(DEBUG) || IS_ENABLED(CONFIG_DYNAMIC_DEBUG)

> +
> +static
> +void sdhci_cdns_sd6_phy_dump(struct sdhci_cdns_sd6_phy *phy,
> +			     struct sdhci_host *host)
> +{
> +	dev_dbg(mmc_dev(host->mmc), "PHY Timings\n");
> +	dev_dbg(mmc_dev(host->mmc), "mode %d t_sdclk %d\n", phy->mode,
> +		phy->t_sdclk);
> +
> +	dev_dbg(mmc_dev(host->mmc), "cp_clk_wr_delay %d\n",
> +		phy->settings.cp_clk_wr_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_clk_wrdqs_delay %d\n",
> +		phy->settings.cp_clk_wrdqs_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_data_select_oe_end %d\n",
> +		phy->settings.cp_data_select_oe_end);
> +	dev_dbg(mmc_dev(host->mmc), "cp_dll_bypass_mode %d\n",
> +		phy->settings.cp_dll_bypass_mode);
> +	dev_dbg(mmc_dev(host->mmc), "cp_dll_locked_mode %d\n",
> +		phy->settings.cp_dll_locked_mode);
> +	dev_dbg(mmc_dev(host->mmc), "cp_dll_start_point %d\n",
> +		phy->settings.cp_dll_start_point);
> +	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_always_on %d\n",
> +		phy->settings.cp_io_mask_always_on);
> +	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_end %d\n",
> +		phy->settings.cp_io_mask_end);
> +	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_start %d\n",
> +		phy->settings.cp_io_mask_start);
> +	dev_dbg(mmc_dev(host->mmc), "cp_rd_del_sel %d\n",
> +		phy->settings.cp_rd_del_sel);
> +	dev_dbg(mmc_dev(host->mmc), "cp_read_dqs_cmd_delay %d\n",
> +		phy->settings.cp_read_dqs_cmd_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_read_dqs_delay %d\n",
> +		phy->settings.cp_read_dqs_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_sw_half_cycle_shift %d\n",
> +		phy->settings.cp_sw_half_cycle_shift);
> +	dev_dbg(mmc_dev(host->mmc), "cp_sync_method %d\n",
> +		phy->settings.cp_sync_method);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_ext_lpbk_dqs %d\n",
> +		phy->settings.cp_use_ext_lpbk_dqs);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_lpbk_dqs %d\n",
> +		phy->settings.cp_use_lpbk_dqs);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_phony_dqs %d\n",
> +		phy->settings.cp_use_phony_dqs);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_phony_dqs_cmd %d\n",
> +		phy->settings.cp_use_phony_dqs_cmd);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_extended_rd_mode %d\n",
> +		phy->settings.sdhc_extended_rd_mode);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_extended_wr_mode %d\n",
> +		phy->settings.sdhc_extended_wr_mode);
> +
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_hcsdclkadj %d\n",
> +		phy->settings.sdhc_hcsdclkadj);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_idelay_val %d\n",
> +		phy->settings.sdhc_idelay_val);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_rdcmd_en %d\n",
> +		phy->settings.sdhc_rdcmd_en);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_rddata_en %d\n",
> +		phy->settings.sdhc_rddata_en);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_rw_compensate %d\n",
> +		phy->settings.sdhc_rw_compensate);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_sdcfsh %d\n",
> +		phy->settings.sdhc_sdcfsh);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_sdcfsl %d\n",
> +		phy->settings.sdhc_sdcfsl);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrcmd0_dly %d %d\n",
> +		phy->settings.sdhc_wrcmd0_dly,
> +		phy->settings.sdhc_wrcmd0_sdclk_dly);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrcmd1_dly %d %d\n",
> +		phy->settings.sdhc_wrcmd1_dly,
> +		phy->settings.sdhc_wrcmd1_sdclk_dly);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrdata0_dly %d %d\n",
> +		phy->settings.sdhc_wrdata0_dly,
> +		phy->settings.sdhc_wrdata0_sdclk_dly);
> +
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrdata1_dly %d %d\n",
> +		phy->settings.sdhc_wrdata1_dly,
> +		phy->settings.sdhc_wrdata1_sdclk_dly);
> +	dev_dbg(mmc_dev(host->mmc), "hs200_tune_val %d\n",
> +		phy->settings.hs200_tune_val);
> +}
> +
> +static
> +void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv, struct sdhci_host *host)
> +{
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +	int id;
> +
> +	sdhci_cdns_sd6_phy_dump(phy);
> +
> +	dev_dbg(mmc_dev(host->mmc), "Host controller Register Dump\n");
> +	for (id = 0; id < 14; id++) {
> +		dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
> +			readl(priv->hrs_addr + (id * 4)));
> +	}
> +
> +	id = 29;
> +	dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
> +		readl(priv->hrs_addr + (id * 4)));
> +	id = 30;
> +	dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
> +		readl(priv->hrs_addr + (id * 4)));
> +
> +	for (id = 0; id < 27; id++) {
> +		dev_dbg(mmc_dev(host->mmc), "SRS%d 0x%x\n", id,
> +			readl(priv->hrs_addr + 0x200 + (id * 4)));
> +	}
> +
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQS_TIMING 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DQS_TIMING));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GATE_LPBK 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_GATE_LPBK));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_MASTER 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_MASTER));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_SLAVE 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_SLAVE));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_CTRL 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GPIO_CTRL0 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_GPIO_CTRL0));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQ_TIMING 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DQ_TIMING));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2));
> +}
> +
> +#else
> +
> +static inline void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv,
> +				       struct sdhci_host *host)
> +{
> +}
> +
> +#endif
> +
>  static
>  int sdhci_cdns_sd6_get_delay_params(struct device *dev,
>  				    struct sdhci_cdns_priv *priv)
> @@ -1319,6 +1471,8 @@ static void sdhci_cdns_sd6_set_clock(struct sdhci_host *host,
>  		pr_debug("%s: phy init failed\n", __func__);
>  
>  	sdhci_set_clock(host, clock);
> +
> +	sdhci_cdns_sd6_dump(priv, host);
>  }
>  
>  static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,

