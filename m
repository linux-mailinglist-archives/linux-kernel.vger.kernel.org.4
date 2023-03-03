Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB56A9306
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCCItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCCItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:49:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F513514;
        Fri,  3 Mar 2023 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677833342; x=1709369342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6rTwrOI/tuS1GxwGUbnWM4lVg98m0wk78qCUYrXxZTg=;
  b=L7A9BfQWZHfg+puafQU3TIfeUTRfzjQ/VnU8WQqS3VNAMTkhvimTdHd8
   4XZxYV9PURElbNuWr803fxNDF6f90UYfNX9bF8DyuL5LLvgxxL8EQYM17
   pOv/LEf/fAx+K3YeDwpHBwc+KAixcA5YVilbbFm+hDZ6HQZPi7fI0muE3
   g5jjmbqFtveY/3r7ahhfuIUFaDUVJs2LIasTGFF9FJ6Fv4SpZ2vzKDFX/
   1EMD7TGBj/OQGeJ/kgp5xmxu8Tq1GOTispzJImoCEws+4onMSh3p8H29k
   G8eODWfRaZHaYEWhLudPtLmAtWgXT+8wLsR3gcAPkSEe4goIQivHivLf8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="362590510"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="362590510"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="675289443"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="675289443"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.227])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:48:54 -0800
Message-ID: <7dcd46c0-4dff-d566-7dc0-2f210ac1b8bd@intel.com>
Date:   Fri, 3 Mar 2023 10:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/6] mmc: sdhci-cadence: SD6 controller support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-4-pmalgujar@marvell.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230227183151.27912-4-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/23 20:31, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> Add support for SD6 controller and related ops along with
> support for HS400 and HS400ES emmc modes.
> Updated HS200 tuning values and support to read tune configuration
> from FDT and support to configure and read host side drive strength,
> slew from device tree.
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
> v2 ---> v3
> - Removed value stored to 'clk_wr_delay' which was never read
> - Removed some whitespace changes
> v1 ---> v2
> - Separated out the reformating and renaming of code as
>   preparation patch to add SD6 support
> - Used proper property names as per dtschema
> - Fixed issues related to PTR_ERR and unreachable code
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 1260 +++++++++++++++++++++++++++++-
>  1 file changed, 1255 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 4f7e63c90e3d68da338b8964f08b7c65ebaf1ffd..4b32757dd3750af6428e0d4177b419b3a9e8696d 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,8 +15,20 @@
>  
>  #include "sdhci-pltfm.h"
>  
> +#define SDMCLK_MAX_FREQ		200000000
> +
> +#define DEFAULT_CMD_DELAY		16
> +#define SDHCI_CDNS_TUNE_START		16
> +#define SDHCI_CDNS_TUNE_STEP		6
> +#define SDHCI_CDNS_TUNE_ITERATIONS	40
> +
> +#define SDHCI_CDNS_HRS00			0x00
> +#define SDHCI_CDNS_HRS00_SWR			BIT(0)
> +
> +#define SDHCI_CDNS_HRS02			0x08		/* PHY access port */
> +#define SDHCI_CDNS_HRS04			0x10		/* PHY access port */
> +
>  /* SD 4.0 Controller HRS - Host Register Set (specific to Cadence) */
> -#define SDHCI_CDNS_HRS04			0x10	/* PHY access port */
>  #define SDHCI_CDNS_SD4_HRS04_ACK		BIT(26)
>  #define SDHCI_CDNS_SD4_HRS04_RD			BIT(25)
>  #define SDHCI_CDNS_SD4_HRS04_WR			BIT(24)
> @@ -29,12 +41,89 @@
>  #define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13, 8)
>  #define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
>  #define   SDHCI_CDNS_HRS06_MODE_SD		0x0
> +#define SDHCI_CDNS_HRS06_MODE_LEGACY		0x1
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>  
> +/* SD 6.0 Controller HRS - Host Register Set (Specific to Cadence) */
> +#define SDHCI_CDNS_SD6_HRS04_ADDR		GENMASK(15, 0)
> +
> +#define SDHCI_CDNS_HRS05			0x14
> +
> +#define SDHCI_CDNS_HRS07			0x1C
> +#define	SDHCI_CDNS_HRS07_RW_COMPENSATE		GENMASK(20, 16)
> +#define	SDHCI_CDNS_HRS07_IDELAY_VAL		GENMASK(4, 0)
> +
> +#define SDHCI_CDNS_HRS09			0x24
> +#define	SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
> +#define	SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
> +#define	SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
> +#define	SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
> +#define	SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
> +#define	SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
> +
> +#define SDHCI_CDNS_HRS10			0x28
> +#define	SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
> +
> +#define SDHCI_CDNS_HRS11			0x2c
> +/*Reset related*/
> +#define SDHCI_CDNS_SRS11_SW_RESET_ALL		BIT(24)
> +#define SDHCI_CDNS_SRS11_SW_RESET_CMD		BIT(25)
> +#define SDHCI_CDNS_SRS11_SW_RESET_DAT		BIT(26)
> +
> +#define SDHCI_CDNS_HRS16			0x40
> +#define SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY	GENMASK(31, 28)
> +#define SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY	GENMASK(27, 24)
> +#define SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY	GENMASK(23, 20)
> +#define SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY	GENMASK(19, 16)
> +#define SDHCI_CDNS_HRS16_WRDATA1_DLY		GENMASK(15, 12)
> +#define SDHCI_CDNS_HRS16_WRDATA0_DLY		GENMASK(11, 8)
> +#define SDHCI_CDNS_HRS16_WRCMD1_DLY		GENMASK(7, 4)
> +#define SDHCI_CDNS_HRS16_WRCMD0_DLY		GENMASK(3, 0)
> +
> +/* PHY registers for SD6 controller */
> +#define SDHCI_CDNS_SD6_PHY_DQ_TIMING				0x2000
> +#define	SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON		BIT(31)
> +#define	SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_END		GENMASK(29, 27)
> +#define	SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_START		GENMASK(26, 24)
> +#define	SDHCI_CDNS_SD6_PHY_DQ_TIMING_DATA_SELECT_OE_END		GENMASK(2, 0)
> +
> +#define SDHCI_CDNS_SD6_PHY_DQS_TIMING				0x2004
> +#define	SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS		BIT(22)
> +#define	SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_LPBK_DQS		BIT(21)
> +#define	SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_PHONY_DQS		BIT(20)
> +#define	SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD		BIT(19)
> +
> +#define SDHCI_CDNS_SD6_PHY_GATE_LPBK				0x2008
> +#define	SDHCI_CDNS_SD6_PHY_GATE_LPBK_SYNC_METHOD		BIT(31)
> +#define	SDHCI_CDNS_SD6_PHY_GATE_LPBK_SW_HALF_CYCLE_SHIFT	BIT(28)
> +#define	SDHCI_CDNS_SD6_PHY_GATE_LPBK_RD_DEL_SEL			GENMASK(24, 19)
> +#define	SDHCI_CDNS_SD6_PHY_GATE_LPBK_GATE_CFG_ALWAYS_ON		BIT(6)
> +
> +#define SDHCI_CDNS_SD6_PHY_DLL_MASTER				0x200C
> +#define	SDHCI_CDNS_SD6_PHY_DLL_MASTER_BYPASS_MODE		BIT(23)
> +#define	SDHCI_CDNS_SD6_PHY_DLL_MASTER_PHASE_DETECT_SEL		GENMASK(22, 20)
> +#define	SDHCI_CDNS_SD6_PHY_DLL_MASTER_DLL_LOCK_NUM		GENMASK(18, 16)
> +#define	SDHCI_CDNS_SD6_PHY_DLL_MASTER_DLL_START_POINT		GENMASK(7, 0)
> +
> +#define SDHCI_CDNS_SD6_PHY_DLL_SLAVE				0x2010
> +#define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_CMD_DELAY		GENMASK(31, 24)
> +#define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WRDQS_DELAY		GENMASK(23, 16)
> +#define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY		GENMASK(15, 8)
> +#define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY		GENMASK(7, 0)
> +
> +#define SDHCI_CDNS_SD6_PHY_CTRL					0x2080
> +#define	SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING		GENMASK(9, 4)
> +
> +#define SDHCI_CDNS_SD6_PHY_GPIO_CTRL0				0x2088
> +#define SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_DRV			GENMASK(6, 5)
> +#define SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_DRV_OVR_EN		BIT(4)
> +#define SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_SLEW			GENMASK(2, 1)
> +#define SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_SLEW_OVR_EN		BIT(0)
> +
>  /* SRS - Slot Register Set (SDHCI-compatible) */
>  #define SDHCI_CDNS_SRS_BASE		0x200
>  
> @@ -59,6 +148,10 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> +static int tune_val_start = SDHCI_CDNS_TUNE_START;
> +static int tune_val_step = SDHCI_CDNS_TUNE_STEP;
> +static int max_tune_iter = SDHCI_CDNS_TUNE_ITERATIONS;
> +
>  struct sdhci_cdns_priv;
>  
>  struct sdhci_cdns_sd4_phy_param {
> @@ -109,6 +202,558 @@ static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
>  	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
>  };
>  
> +enum sdhci_cdns_sd6_phy_lock_mode {
> +	SDHCI_CDNS_SD6_PHY_LOCK_MODE_FULL_CLK = 0,
> +	SDHCI_CDNS_SD6_PHY_LOCK_MODE_HALF_CLK = 2,
> +	SDHCI_CDNS_SD6_PHY_LOCK_MODE_SATURATION = 3,
> +};
> +
> +struct sdhci_cdns_sd6_phy_timings {
> +	u32 t_cmd_output_min;
> +	u32 t_cmd_output_max;
> +	u32 t_dat_output_min;
> +	u32 t_dat_output_max;
> +	u32 t_cmd_input_min;
> +	u32 t_cmd_input_max;
> +	u32 t_dat_input_min;
> +	u32 t_dat_input_max;
> +	u32 t_sdclk_min;
> +	u32 t_sdclk_max;
> +};
> +
> +struct sdhci_cdns_sd6_phy_delays {
> +	u32 phy_sdclk_delay;
> +	u32 phy_cmd_o_delay;
> +	u32 phy_dat_o_delay;
> +	u32 iocell_input_delay;
> +	u32 iocell_output_delay;
> +	u32 delay_element_org;
> +	u32 delay_element;
> +};
> +
> +struct sdhci_cdns_sd6_phy_settings {
> +	/* SDHCI_CDNS_SD6_PHY_DLL_SLAVE */
> +	u32 cp_read_dqs_cmd_delay;
> +	u32 cp_read_dqs_delay;
> +	u32 cp_clk_wr_delay;
> +	u32 cp_clk_wrdqs_delay;
> +
> +	/* SDHCI_CDNS_SD6_PHY_DLL_MASTER */
> +	u32 cp_dll_bypass_mode;
> +	u32 cp_dll_start_point;
> +
> +	/* SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0 */
> +	u32 cp_dll_locked_mode;
> +
> +	/* SDHCI_CDNS_SD6_PHY_GATE_LPBK */
> +	u32 cp_gate_cfg_always_on;
> +	u32 cp_sync_method;
> +	u32 cp_rd_del_sel;
> +	u32 cp_sw_half_cycle_shift;
> +	u32 cp_underrun_suppress;
> +
> +	/* SDHCI_CDNS_SD6_PHY_DQ_TIMING */
> +	u32 cp_io_mask_always_on;
> +	u32 cp_io_mask_end;
> +	u32 cp_io_mask_start;
> +	u32 cp_data_select_oe_end;
> +
> +	/* SDHCI_CDNS_SD6_PHY_DQS_TIMING */
> +	u32 cp_use_ext_lpbk_dqs;
> +	u32 cp_use_lpbk_dqs;
> +	u8 cp_use_phony_dqs;
> +	u8 cp_use_phony_dqs_cmd;
> +
> +	/* HRS 09 */
> +	u8 sdhc_extended_rd_mode;
> +	u8 sdhc_extended_wr_mode;
> +	u32 sdhc_rdcmd_en;
> +	u32 sdhc_rddata_en;
> +
> +	/* HRS10 */
> +	u32 sdhc_hcsdclkadj;
> +
> +	/* HRS 07 */
> +	u32 sdhc_idelay_val;
> +	u32 sdhc_rw_compensate;
> +
> +	/* SRS 11 */
> +	u32 sdhc_sdcfsh;
> +	u32 sdhc_sdcfsl;
> +
> +	/* HRS 16 */
> +	u32 sdhc_wrcmd0_dly;
> +	u32 sdhc_wrcmd0_sdclk_dly;
> +	u32 sdhc_wrcmd1_dly;
> +	u32 sdhc_wrcmd1_sdclk_dly;
> +	u32 sdhc_wrdata0_dly;
> +	u32 sdhc_wrdata0_sdclk_dly;
> +	u32 sdhc_wrdata1_dly;
> +	u32 sdhc_wrdata1_sdclk_dly;
> +
> +	u32 hs200_tune_val;
> +	u32 drive;
> +	u32 slew;
> +};
> +
> +struct sdhci_cdns_sd6_phy_intermediate_results {
> +	u32 t_sdmclk_calc;
> +	u32 dll_max_value;
> +};
> +
> +struct sdhci_cdns_sd6_phy {
> +	struct sdhci_cdns_sd6_phy_timings t;
> +	struct sdhci_cdns_sd6_phy_delays d;
> +	u32 t_sdmclk;
> +	struct sdhci_cdns_sd6_phy_settings settings;
> +	struct sdhci_cdns_sd6_phy_intermediate_results vars;
> +	bool ddr;
> +	bool tune_cmd;
> +	bool tune_dat;
> +	bool strobe_cmd;
> +	bool strobe_dat;
> +	int mode;
> +	int t_sdclk;
> +};
> +
> +static void init_hs(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 2000, .t_cmd_output_max = t_sdclk - 6000,
> +		.t_dat_output_min = 2000, .t_dat_output_max = t_sdclk - 6000,
> +		.t_cmd_input_min = 14000, .t_cmd_input_max = t_sdclk + 2500,
> +		.t_dat_input_min = 14000, .t_dat_input_max = t_sdclk + 2500,
> +		.t_sdclk_min = 1000000 / 50, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_uhs_sdr12(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 800, .t_cmd_output_max = t_sdclk - 3000,
> +		.t_dat_output_min = 800, .t_dat_output_max = t_sdclk - 3000,
> +		.t_cmd_input_min = 14000, .t_cmd_input_max = t_sdclk + 1500,
> +		.t_dat_input_min = 14000, .t_dat_input_max = t_sdclk + 1500,
> +		.t_sdclk_min = 1000000 / 25, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_uhs_sdr25(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 800, .t_cmd_output_max = t_sdclk - 3000,
> +		.t_dat_output_min = 800, .t_dat_output_max = t_sdclk - 3000,
> +		.t_cmd_input_min = 14000, .t_cmd_input_max = t_sdclk + 1500,
> +		.t_dat_input_min = 14000, .t_dat_input_max = t_sdclk + 1500,
> +		.t_sdclk_min = 1000000 / 50, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_uhs_sdr50(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 800, .t_cmd_output_max = t_sdclk - 3000,
> +		.t_dat_output_min = 800, .t_dat_output_max = t_sdclk - 3000,
> +		.t_cmd_input_min = 7500, .t_cmd_input_max = t_sdclk + 1500,
> +		.t_dat_input_min = 7500, .t_dat_input_max = t_sdclk + 1500,
> +		.t_sdclk_min = 1000000 / 100, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_uhs_sdr104(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 800, .t_cmd_output_max = t_sdclk - 1400,
> +		.t_dat_output_min = 800, .t_dat_output_max = t_sdclk - 1400,
> +		.t_cmd_input_min = 1000, .t_cmd_input_max = t_sdclk + 1000,
> +		.t_dat_input_min = 1000, .t_dat_input_max = t_sdclk + 1000,
> +		.t_sdclk_min = 1000000 / 200, .t_sdclk_max = 1000000 / 100
> +	};
> +}
> +
> +static void init_uhs_ddr50(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 800, .t_cmd_output_max = t_sdclk - 3000,
> +		.t_dat_output_min = 800, .t_dat_output_max = t_sdclk - 3000,
> +		.t_cmd_input_min = 13700, .t_cmd_input_max = t_sdclk + 1500,
> +		.t_dat_input_min = 7000, .t_dat_input_max = t_sdclk + 1500,
> +		.t_sdclk_min = 1000000 / 50, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_emmc_legacy(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 3000, .t_cmd_output_max = t_sdclk - 3000,
> +		.t_dat_output_min = 3000, .t_dat_output_max = t_sdclk - 3000,
> +		.t_cmd_input_min = 11700, .t_cmd_input_max = t_sdclk + 8300,
> +		.t_dat_input_min = 11700, .t_dat_input_max = t_sdclk + 8300,
> +		.t_sdclk_min = 1000000 / 25, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_emmc_sdr(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 3000, .t_cmd_output_max = t_sdclk - 3000,
> +		.t_dat_output_min = 3000, .t_dat_output_max = t_sdclk - 3000,
> +		.t_cmd_input_min = 13700, .t_cmd_input_max = t_sdclk + 2500,
> +		.t_dat_input_min = 13700, .t_dat_input_max = t_sdclk + 2500,
> +		.t_sdclk_min = 1000000 / 50, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_emmc_ddr(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 3000, .t_cmd_output_max = t_sdclk - 3000,
> +		.t_dat_output_min = 2500, .t_dat_output_max = t_sdclk - 2500,
> +		.t_cmd_input_min = 13700, .t_cmd_input_max = t_sdclk + 2500,
> +		.t_dat_input_min = 7000, .t_dat_input_max = t_sdclk + 1500,
> +		.t_sdclk_min = 1000000 / 50, .t_sdclk_max = 1000000 / 0.4
> +	};
> +}
> +
> +static void init_emmc_hs200(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 800, .t_cmd_output_max = t_sdclk - 1400,
> +		.t_dat_output_min = 800, .t_dat_output_max = t_sdclk - 1400,
> +		.t_cmd_input_min = 1000, .t_cmd_input_max = t_sdclk + 1000,
> +		.t_dat_input_min = 1000, .t_dat_input_max = t_sdclk + 1000,
> +		.t_sdclk_min = 1000000 / 200, .t_sdclk_max = 1000000 / 100
> +	};
> +}
> +
> +/* HS400 and HS400ES */
> +static void init_emmc_hs400(struct sdhci_cdns_sd6_phy_timings *t, int t_sdclk)
> +{
> +	*t = (struct sdhci_cdns_sd6_phy_timings){
> +		.t_cmd_output_min = 800, .t_cmd_output_max = t_sdclk - 1400,
> +		.t_dat_output_min = 400, .t_dat_output_max = t_sdclk - 400,
> +		.t_cmd_input_min = 1000, .t_cmd_input_max = t_sdclk + 1000,
> +		.t_dat_input_min = 1000, .t_dat_input_max = t_sdclk + 1000,
> +		.t_sdclk_min = 1000000 / 200, .t_sdclk_max = 1000000 / 100
> +	};
> +}
> +
> +static void (*init_timings[])(struct sdhci_cdns_sd6_phy_timings*, int) = {
> +	&init_hs, &init_emmc_legacy, &init_emmc_sdr,
> +	&init_emmc_ddr, &init_emmc_hs200, &init_emmc_hs400,
> +	&init_uhs_sdr12, &init_uhs_sdr25, &init_uhs_sdr50,
> +	&init_uhs_sdr104, &init_uhs_ddr50
> +};
> +
> +static u32 read_dqs_cmd_delay, clk_wrdqs_delay, clk_wr_delay, read_dqs_delay;
> +
> +static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host, unsigned int timing);
> +
> +static int sdhci_cdns_sd6_phy_lock_dll(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	u32 delay_element = phy->d.delay_element_org;
> +	u32 delay_elements_in_sdmclk;
> +	enum sdhci_cdns_sd6_phy_lock_mode mode;
> +
> +	delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk, delay_element);
> +	if (delay_elements_in_sdmclk > 256) {
> +		delay_element *= 2;
> +		delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk,
> +							delay_element);
> +
> +		if (delay_elements_in_sdmclk > 256)
> +			return -1;
> +
> +		mode = SDHCI_CDNS_SD6_PHY_LOCK_MODE_HALF_CLK;
> +		phy->vars.dll_max_value = 127;
> +	} else {
> +		mode = SDHCI_CDNS_SD6_PHY_LOCK_MODE_FULL_CLK;
> +		phy->vars.dll_max_value = 255;
> +	}
> +
> +	phy->vars.t_sdmclk_calc = delay_element * delay_elements_in_sdmclk;
> +	phy->d.delay_element = delay_element;
> +	phy->settings.cp_dll_locked_mode = mode;
> +	phy->settings.cp_dll_bypass_mode = 0;
> +
> +	return 0;
> +}
> +
> +static void sdhci_cdns_sd6_phy_dll_bypass(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	phy->vars.dll_max_value = 256;
> +	phy->settings.cp_dll_bypass_mode = 1;
> +	phy->settings.cp_dll_locked_mode =
> +		SDHCI_CDNS_SD6_PHY_LOCK_MODE_SATURATION;
> +}
> +
> +static void sdhci_cdns_sd6_phy_configure_dll(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	if (phy->settings.sdhc_extended_wr_mode == 0) {
> +		if (sdhci_cdns_sd6_phy_lock_dll(phy) == 0)
> +			return;
> +	}
> +	sdhci_cdns_sd6_phy_dll_bypass(phy);
> +}
> +
> +static void sdhci_cdns_sd6_phy_calc_out(struct sdhci_cdns_sd6_phy *phy,
> +					bool cmd_not_dat)
> +{
> +	u32 wr0_dly = 0, wr1_dly = 0, output_min, output_max, phy_o_delay,
> +	    clk_wr_delay = 0, wr0_sdclk_dly = 0, wr1_sdclk_dly = 0;
> +	bool data_ddr = phy->ddr && !cmd_not_dat;
> +	int t;
> +
> +	if (cmd_not_dat) {
> +		output_min = phy->t.t_cmd_output_min;
> +		output_max = phy->t.t_cmd_output_max;
> +		phy_o_delay = phy->d.phy_cmd_o_delay;
> +	} else {
> +		output_min = phy->t.t_dat_output_min;
> +		output_max = phy->t.t_dat_output_max;
> +		phy_o_delay = phy->d.phy_dat_o_delay;
> +	}
> +
> +	if (data_ddr) {
> +		wr0_sdclk_dly = 1;
> +		wr1_sdclk_dly = 1;
> +	}
> +
> +	t = phy_o_delay - phy->d.phy_sdclk_delay - output_min;
> +	if (t < 0 && phy->settings.sdhc_extended_wr_mode == 1) {
> +		u32 n_half_cycle = DIV_ROUND_UP(-t * 2, phy->t_sdmclk);
> +
> +		wr0_dly = (n_half_cycle + 1) / 2;
> +		if (data_ddr)
> +			wr1_dly = (n_half_cycle + 1) / 2;
> +		else
> +			wr1_dly = (n_half_cycle + 1) % 2 + wr0_dly - 1;
> +	}
> +
> +	if (phy->settings.sdhc_extended_wr_mode == 0) {
> +		u32 out_hold, out_setup, out_hold_margin;
> +		u32 n;
> +
> +		if (!data_ddr)
> +			wr0_dly = 1;
> +
> +		out_setup = output_max;
> +		out_hold = output_min;
> +		out_hold_margin = DIV_ROUND_UP(out_setup - out_hold, 4);
> +		out_hold += out_hold_margin;
> +
> +		if (phy->settings.cp_dll_bypass_mode == 0)
> +			n = DIV_ROUND_UP(256 * out_hold, phy->vars.t_sdmclk_calc);
> +		else
> +			n = DIV_ROUND_UP(out_hold, phy->d.delay_element) - 1;
> +
> +		if (n <= phy->vars.dll_max_value)
> +			clk_wr_delay = n;
> +		else
> +			clk_wr_delay = 255;
> +	} else {
> +		/*  sdhc_extended_wr_mode = 1 - PHY IO cell work in SDR mode */
> +		clk_wr_delay = 0;
> +	}
> +
> +	if (cmd_not_dat) {
> +		phy->settings.sdhc_wrcmd0_dly = wr0_dly;
> +		phy->settings.sdhc_wrcmd1_dly = wr1_dly;
> +		phy->settings.cp_clk_wrdqs_delay = clk_wr_delay;
> +		phy->settings.sdhc_wrcmd0_sdclk_dly = wr0_sdclk_dly;
> +		phy->settings.sdhc_wrcmd1_sdclk_dly = wr1_sdclk_dly;
> +	} else {
> +		phy->settings.sdhc_wrdata0_dly = wr0_dly;
> +		phy->settings.sdhc_wrdata1_dly = wr1_dly;
> +		phy->settings.cp_clk_wr_delay = clk_wr_delay;
> +		phy->settings.sdhc_wrdata0_sdclk_dly = wr0_sdclk_dly;
> +		phy->settings.sdhc_wrdata1_sdclk_dly = wr1_sdclk_dly;
> +	}
> +}
> +
> +static void sdhci_cdns_sd6_phy_calc_cmd_out(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	sdhci_cdns_sd6_phy_calc_out(phy, true);
> +}
> +
> +static void sdhci_cdns_sd6_phy_calc_cmd_in(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	phy->settings.cp_io_mask_end =
> +		((phy->d.iocell_output_delay + phy->d.iocell_input_delay) * 2)
> +		/ phy->t_sdmclk;
> +
> +	if (phy->settings.cp_io_mask_end >= 8)
> +		phy->settings.cp_io_mask_end = 7;
> +
> +	if (phy->strobe_cmd && phy->settings.cp_io_mask_end > 0)
> +		phy->settings.cp_io_mask_end--;
> +
> +	if (phy->strobe_cmd) {
> +		phy->settings.cp_use_phony_dqs_cmd = 0;
> +		phy->settings.cp_read_dqs_cmd_delay = 64;
> +	} else {
> +		phy->settings.cp_use_phony_dqs_cmd = 1;
> +		phy->settings.cp_read_dqs_cmd_delay = 0;
> +	}
> +
> +	if ((phy->mode == MMC_TIMING_MMC_HS400 && !phy->strobe_cmd) ||
> +	    phy->mode == MMC_TIMING_MMC_HS200)
> +		phy->settings.cp_read_dqs_cmd_delay =
> +			phy->settings.hs200_tune_val;
> +}
> +
> +static void sdhci_cdns_sd6_phy_calc_dat_in(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	u32 hcsdclkadj = 0;
> +
> +	if (phy->strobe_dat) {
> +		phy->settings.cp_use_phony_dqs = 0;
> +		phy->settings.cp_read_dqs_delay = 64;
> +	} else {
> +		phy->settings.cp_use_phony_dqs = 1;
> +		phy->settings.cp_read_dqs_delay = 0;
> +	}
> +
> +	if (phy->mode == MMC_TIMING_MMC_HS200)
> +		phy->settings.cp_read_dqs_delay =
> +			phy->settings.hs200_tune_val;
> +
> +	if (phy->strobe_dat) {
> +		/* dqs loopback input via IO cell */
> +		hcsdclkadj += phy->d.iocell_input_delay;
> +		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod; delay of hic_dll_dqs_nand2 */
> +		hcsdclkadj += phy->d.delay_element / 2;
> +		/* delay line */
> +		hcsdclkadj += phy->t_sdclk / 2;
> +		/* PHY FIFO write pointer */
> +		hcsdclkadj += phy->t_sdclk / 2 + phy->d.delay_element;
> +		/* 1st synchronizer */
> +		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk)
> +			* phy->t_sdmclk - hcsdclkadj;
> +		/*
> +		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
> +		 * + PHY rddata registered, + FIFO 1st ciu_en
> +		 */
> +		hcsdclkadj += 5 * phy->t_sdmclk;
> +		/* FIFO 2st ciu_en */
> +		hcsdclkadj += phy->t_sdclk;
> +
> +		hcsdclkadj /= phy->t_sdclk;
> +	} else {
> +		u32 n;
> +
> +		/* rebar PHY delay */
> +		hcsdclkadj += 2 * phy->t_sdmclk;
> +		/* rebar output via IO cell */
> +		hcsdclkadj += phy->d.iocell_output_delay;
> +		/* dqs loopback input via IO cell */
> +		hcsdclkadj += phy->d.iocell_input_delay;
> +		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod delay of hic_dll_dqs_nand2 */
> +		hcsdclkadj += phy->d.delay_element / 2;
> +		/* dll: one delay element between SIGI_0 and SIGO_0 */
> +		hcsdclkadj += phy->d.delay_element;
> +		/* dfi_dqs_in: mem_dqs_delayed -> clk_dqs delay of hic_dll_dqs_nand2 */
> +		hcsdclkadj += phy->d.delay_element / 2;
> +		/* deskew DLL: clk_dqs -> clk_dqN: one delay element */
> +		hcsdclkadj += phy->d.delay_element;
> +
> +		if (phy->t_sdclk == phy->t_sdmclk)
> +			n = (hcsdclkadj - 2 * phy->t_sdmclk) / phy->t_sdclk;
> +		else
> +			n = hcsdclkadj / phy->t_sdclk;
> +
> +		/* phase shift within one t_sdclk clock cycle caused by rebar - lbk dqs delay */
> +		hcsdclkadj = hcsdclkadj % phy->t_sdclk;
> +		/* PHY FIFO write pointer */
> +		hcsdclkadj += phy->t_sdclk / 2;
> +		/* 1st synchronizer */
> +		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk)
> +			* phy->t_sdmclk - hcsdclkadj;
> +		/*
> +		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
> +		 * + PHY rddata registered
> +		 */
> +		hcsdclkadj += 4 * phy->t_sdmclk;
> +
> +		if ((phy->t_sdclk / phy->t_sdmclk) > 1) {
> +			u32 tmp1, tmp2;
> +
> +			tmp1 = hcsdclkadj;
> +			tmp2 = (hcsdclkadj / phy->t_sdclk) * phy->t_sdclk
> +				+ phy->t_sdclk - phy->t_sdmclk;
> +			if (tmp1 == tmp2)
> +				tmp2 += phy->t_sdclk;
> +
> +			/* FIFO aligns to clock cycle before ciu_en */
> +			hcsdclkadj += tmp2 - tmp1;
> +		}
> +
> +		/* FIFO 1st ciu_en */
> +		hcsdclkadj += phy->t_sdmclk;
> +		/* FIFO 2nd ciu_en */
> +		hcsdclkadj += phy->t_sdclk;
> +
> +		hcsdclkadj /= phy->t_sdclk;
> +
> +		hcsdclkadj += n;
> +
> +		if ((phy->t_sdclk / phy->t_sdmclk) >= 2) {
> +			if (phy->mode == MMC_TIMING_UHS_DDR50 ||
> +			    phy->mode == MMC_TIMING_MMC_DDR52)
> +				hcsdclkadj -= 2;
> +			else
> +				hcsdclkadj -= 1;
> +		} else if ((phy->t_sdclk / phy->t_sdmclk) == 1) {
> +			hcsdclkadj += 2;
> +		}
> +
> +		if (phy->tune_dat)
> +			hcsdclkadj -= 1;
> +	}
> +
> +	if (hcsdclkadj > 15)
> +		hcsdclkadj = 15;
> +
> +	phy->settings.sdhc_hcsdclkadj = hcsdclkadj;
> +}
> +
> +static void sdhci_cdns_sd6_phy_calc_dat_out(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	sdhci_cdns_sd6_phy_calc_out(phy, false);
> +}
> +
> +static void sdhci_cdns_sd6_phy_calc_io(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	u32 rw_compensate;
> +
> +	rw_compensate = (phy->d.iocell_input_delay + phy->d.iocell_output_delay)
> +		/ phy->t_sdmclk + phy->settings.sdhc_wrdata0_dly + 5 + 3;
> +
> +	phy->settings.sdhc_idelay_val = (2 * phy->d.iocell_input_delay)
> +		/ phy->t_sdmclk;
> +
> +	phy->settings.cp_io_mask_start = 0;
> +	if (phy->t_sdclk == phy->t_sdmclk && rw_compensate > 10)
> +		phy->settings.cp_io_mask_start = 2 * (rw_compensate - 10);
> +
> +	if (phy->mode == MMC_TIMING_UHS_SDR104)
> +		phy->settings.cp_io_mask_start++;
> +
> +	if (phy->t_sdclk == phy->t_sdmclk && phy->mode == MMC_TIMING_UHS_SDR50)
> +		phy->settings.cp_io_mask_start++;
> +
> +	phy->settings.sdhc_rw_compensate = rw_compensate;
> +}
> +
> +static void sdhci_cdns_sd6_phy_calc_settings(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	sdhci_cdns_sd6_phy_calc_cmd_out(phy);
> +	sdhci_cdns_sd6_phy_calc_cmd_in(phy);
> +	sdhci_cdns_sd6_phy_calc_dat_out(phy);
> +	sdhci_cdns_sd6_phy_calc_dat_in(phy);
> +	sdhci_cdns_sd6_phy_calc_io(phy);
> +}
> +
>  static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
>  					u8 addr, u8 data)
>  {
> @@ -183,7 +828,276 @@ static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
>  		if (ret)
>  			return ret;
>  	}
> +	return 0;
> +}
> +
> +static u32 sdhci_cdns_sd6_read_phy_reg(struct sdhci_cdns_priv *priv,
> +				       u32 addr)
> +{
> +	writel(FIELD_PREP(SDHCI_CDNS_SD6_HRS04_ADDR, addr),
> +	       priv->hrs_addr + SDHCI_CDNS_HRS04);
> +	return readl(priv->hrs_addr + SDHCI_CDNS_HRS05);
> +}
> +
> +static void sdhci_cdns_sd6_write_phy_reg(struct sdhci_cdns_priv *priv,
> +					 u32 addr, u32 data)
> +{
> +	writel(FIELD_PREP(SDHCI_CDNS_SD6_HRS04_ADDR, addr),
> +	       priv->hrs_addr + SDHCI_CDNS_HRS04);
> +	writel(data, priv->hrs_addr + SDHCI_CDNS_HRS05);
> +}
> +
> +static int sdhci_cdns_sd6_dll_reset(struct sdhci_cdns_priv *priv, bool reset)
> +{
> +	u32 reg;
> +	int ret = 0;
> +
> +	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
> +	if (reset)
> +		reg &= ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
> +	else
> +		reg |= SDHCI_CDNS_HRS09_PHY_SW_RESET;
> +
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
> +
> +	if (!reset)
> +		ret = readl_poll_timeout(priv->hrs_addr + SDHCI_CDNS_HRS09,
> +					 reg,
> +					 (reg &
> +					  SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE),
> +					 0, 0);
> +
> +	return ret;
> +}
> +
> +static void sdhci_cdns_sd6_calc_phy(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	if (phy->mode == MMC_TIMING_MMC_HS) {
> +		phy->settings.cp_clk_wr_delay = 0;
> +		phy->settings.cp_clk_wrdqs_delay = 0;
> +		phy->settings.cp_data_select_oe_end = 1;
> +		phy->settings.cp_dll_bypass_mode = 1;
> +		phy->settings.cp_dll_locked_mode = 3;
> +		phy->settings.cp_dll_start_point = 4;
> +		phy->settings.cp_gate_cfg_always_on = 1;
> +		phy->settings.cp_io_mask_always_on = 0;
> +		phy->settings.cp_io_mask_end = 0;
> +		phy->settings.cp_io_mask_start = 0;
> +		phy->settings.cp_rd_del_sel = 52;
> +		phy->settings.cp_read_dqs_cmd_delay = 0;
> +		phy->settings.cp_read_dqs_delay = 0;
> +		phy->settings.cp_sw_half_cycle_shift = 0;
> +		phy->settings.cp_sync_method = 1;
> +		phy->settings.cp_underrun_suppress = 1;
> +		phy->settings.cp_use_ext_lpbk_dqs = 1;
> +		phy->settings.cp_use_lpbk_dqs = 1;
> +		phy->settings.cp_use_phony_dqs = 1;
> +		phy->settings.cp_use_phony_dqs_cmd = 1;
> +		phy->settings.sdhc_extended_rd_mode = 1;
> +		phy->settings.sdhc_extended_wr_mode = 1;
> +		phy->settings.sdhc_hcsdclkadj = 2;
> +		phy->settings.sdhc_idelay_val = 0;
> +		phy->settings.sdhc_rdcmd_en = 1;
> +		phy->settings.sdhc_rddata_en = 1;
> +		phy->settings.sdhc_rw_compensate = 9;
> +		phy->settings.sdhc_sdcfsh = 0;
> +		phy->settings.sdhc_sdcfsl = 4;
> +		phy->settings.sdhc_wrcmd0_dly = 1;
> +		phy->settings.sdhc_wrcmd0_sdclk_dly = 0;
> +		phy->settings.sdhc_wrcmd1_dly = 0;
> +		phy->settings.sdhc_wrcmd1_sdclk_dly = 0;
> +		phy->settings.sdhc_wrdata0_dly = 1;
> +		phy->settings.sdhc_wrdata0_sdclk_dly = 0;
> +		phy->settings.sdhc_wrdata1_dly = 0;
> +		phy->settings.sdhc_wrdata1_sdclk_dly = 0;
> +	}
> +}
> +
> +static
> +int sdhci_cdns_sd6_get_delay_params(struct device *dev,
> +				    struct sdhci_cdns_priv *priv)
> +{
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +	int ret;
> +
> +	of_property_read_u32(dev->of_node, "cdns,iocell-input-delay-ps",
> +			     &phy->d.iocell_input_delay);
> +	of_property_read_u32(dev->of_node, "cdns,iocell-output-delay-ps",
> +			     &phy->d.iocell_output_delay);
> +	of_property_read_u32(dev->of_node, "cdns,delay-element-ps",
> +			     &phy->d.delay_element);
> +	ret = of_property_read_u32(dev->of_node, "cdns,read-dqs-cmd-delay-ps",
> +				   &phy->settings.cp_read_dqs_cmd_delay);
> +	if (ret)
> +		phy->settings.cp_read_dqs_cmd_delay = DEFAULT_CMD_DELAY;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,tune-val-start-ps",
> +				   &tune_val_start);
> +	if (ret)
> +		tune_val_start = SDHCI_CDNS_TUNE_START;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,tune-val-step-ps",
> +				   &tune_val_step);
> +	if (ret)
> +		tune_val_step = SDHCI_CDNS_TUNE_STEP;
> +
> +	read_dqs_cmd_delay = phy->settings.cp_read_dqs_cmd_delay;
> +	clk_wrdqs_delay = phy->settings.cp_clk_wrdqs_delay;
> +	clk_wr_delay = phy->settings.cp_clk_wr_delay;
> +	read_dqs_delay = phy->settings.cp_read_dqs_delay;
> +	return 0;
> +}
> +
> +static int sdhci_cdns_sd6_phy_init(struct sdhci_cdns_priv *priv)
> +{
> +	int ret;
> +	u32 reg;
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +
> +	sdhci_cdns_sd6_dll_reset(priv, true);
> +
> +	reg = sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQS_TIMING);
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_LPBK_DQS;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_PHONY_DQS;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS,
> +			phy->settings.cp_use_ext_lpbk_dqs);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_LPBK_DQS,
> +			phy->settings.cp_use_lpbk_dqs);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_PHONY_DQS,
> +			  phy->settings.cp_use_phony_dqs);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD,
> +			  phy->settings.cp_use_phony_dqs_cmd);
> +	sdhci_cdns_sd6_write_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQS_TIMING, reg);
> +
> +	reg = sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GATE_LPBK);
> +	reg &= ~SDHCI_CDNS_SD6_PHY_GATE_LPBK_SYNC_METHOD;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_GATE_LPBK_SW_HALF_CYCLE_SHIFT;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_GATE_LPBK_RD_DEL_SEL;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_GATE_LPBK_GATE_CFG_ALWAYS_ON;
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_GATE_LPBK_SYNC_METHOD,
> +			phy->settings.cp_sync_method);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_GATE_LPBK_SW_HALF_CYCLE_SHIFT,
> +			phy->settings.cp_sw_half_cycle_shift);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_GATE_LPBK_RD_DEL_SEL,
> +			phy->settings.cp_rd_del_sel);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_GATE_LPBK_GATE_CFG_ALWAYS_ON,
> +			phy->settings.cp_gate_cfg_always_on);
> +	sdhci_cdns_sd6_write_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GATE_LPBK, reg);
> +
> +	reg = 0x0;
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_MASTER_BYPASS_MODE,
> +			 phy->settings.cp_dll_bypass_mode);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_MASTER_PHASE_DETECT_SEL, 2);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_MASTER_DLL_LOCK_NUM, 0);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_MASTER_DLL_START_POINT,
> +			phy->settings.cp_dll_start_point);
> +	sdhci_cdns_sd6_write_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_MASTER, reg);
> +
> +	reg = 0x0;
> +	reg = FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_CMD_DELAY,
> +			 phy->settings.cp_read_dqs_cmd_delay);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WRDQS_DELAY,
> +			  phy->settings.cp_clk_wrdqs_delay);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY,
> +			  phy->settings.cp_clk_wr_delay);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY,
> +			  phy->settings.cp_read_dqs_delay);
> +	sdhci_cdns_sd6_write_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_SLAVE, reg);
> +
> +	reg = sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL);
> +	reg &= ~SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING;
> +	sdhci_cdns_sd6_write_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL, reg);
> +
> +	reg = sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GPIO_CTRL0);
> +	reg &= ~0x77;
> +	reg |= SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_DRV_OVR_EN |
> +		SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_SLEW_OVR_EN;
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_DRV,
> +		phy->settings.drive);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_GPIO_CTRL0_SLEW,
> +		phy->settings.slew);
> +	sdhci_cdns_sd6_write_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GPIO_CTRL0, reg);
> +
> +	ret = sdhci_cdns_sd6_dll_reset(priv, false);
> +	if (ret)
> +		return ret;
> +
> +	reg = sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQ_TIMING);
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_END;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_START;
> +	reg &= ~SDHCI_CDNS_SD6_PHY_DQ_TIMING_DATA_SELECT_OE_END;
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON,
> +			phy->settings.cp_io_mask_always_on);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_END,
> +			  phy->settings.cp_io_mask_end);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQ_TIMING_IO_MASK_START,
> +			  phy->settings.cp_io_mask_start);
> +	reg |= FIELD_PREP(SDHCI_CDNS_SD6_PHY_DQ_TIMING_DATA_SELECT_OE_END,
> +			phy->settings.cp_data_select_oe_end);
> +	sdhci_cdns_sd6_write_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQ_TIMING, reg);
> +
> +	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
> +	if (phy->settings.sdhc_extended_wr_mode)
> +		reg |= SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
> +	else
> +		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
> +
> +	if (phy->settings.sdhc_extended_rd_mode)
> +		reg |= SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
> +	else
> +		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
> +
> +	if (phy->settings.sdhc_rddata_en)
> +		reg |= SDHCI_CDNS_HRS09_RDDATA_EN;
> +	else
> +		reg &= ~SDHCI_CDNS_HRS09_RDDATA_EN;
> +
> +	if (phy->settings.sdhc_rdcmd_en)
> +		reg |= SDHCI_CDNS_HRS09_RDCMD_EN;
> +	else
> +		reg &= ~SDHCI_CDNS_HRS09_RDCMD_EN;
> +
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
> +
> +	writel(0x30004, priv->hrs_addr + SDHCI_CDNS_HRS02);
> +
> +	reg = 0x0;
> +	reg = FIELD_PREP(SDHCI_CDNS_HRS10_HCSDCLKADJ, phy->settings.sdhc_hcsdclkadj);
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS10);
> +
> +	if (phy->mode != MMC_TIMING_MMC_HS && phy->mode != MMC_TIMING_MMC_DDR52) {
> +		reg = 0x0;
> +		reg = FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY,
> +				 phy->settings.sdhc_wrdata1_sdclk_dly);
> +		reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY,
> +				  phy->settings.sdhc_wrdata0_sdclk_dly);
> +		reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY,
> +				  phy->settings.sdhc_wrcmd1_sdclk_dly);
> +		reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY,
> +				  phy->settings.sdhc_wrcmd0_sdclk_dly);
> +		reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_DLY,
> +				  phy->settings.sdhc_wrdata1_dly);
> +		reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_DLY,
> +				  phy->settings.sdhc_wrdata0_dly);
> +		reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_DLY,
> +				  phy->settings.sdhc_wrcmd1_dly);
> +		reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_DLY,
> +				  phy->settings.sdhc_wrcmd0_dly);
> +	} else {
> +		reg = 0x202;
> +	}
>  
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS16);
> +
> +	reg = 0x0;
> +	reg = FIELD_PREP(SDHCI_CDNS_HRS07_RW_COMPENSATE,
> +			 phy->settings.sdhc_rw_compensate);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS07_IDELAY_VAL,
> +			 phy->settings.sdhc_idelay_val);
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS07);
>  	return 0;
>  }
>  
> @@ -194,6 +1108,19 @@ static void *sdhci_cdns_priv(struct sdhci_host *host)
>  	return sdhci_pltfm_priv(pltfm_host);
>  }
>  
> +static int sdhci_cdns_sd6_set_tune_val(struct sdhci_host *host,
> +				       unsigned int val)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +
> +	phy->settings.hs200_tune_val = val;
> +	phy->settings.cp_read_dqs_cmd_delay = val;
> +	phy->settings.cp_read_dqs_delay = val;
> +
> +	return sdhci_cdns_sd6_phy_init(priv);
> +}
> +
>  static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  {
>  	/*
> @@ -203,6 +1130,11 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  	return host->max_clk;
>  }
>  
> +static unsigned int sdhci_cdns_get_max_clock(struct sdhci_host *host)
> +{
> +	return SDMCLK_MAX_FREQ;
> +}
> +
>  static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
>  {
>  	u32 tmp;
> @@ -222,6 +1154,118 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>  	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>  
> +static int sdhci_cdns_sd6_phy_update_timings(struct sdhci_host *host)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +	int t_sdmclk = phy->t_sdmclk;
> +	int mode;
> +
> +	mode = sdhci_cdns_sd6_get_mode(host, host->mmc->ios.timing);
> +	/* initialize input */
> +	init_timings[mode](&phy->t, phy->t_sdclk);
> +
> +	phy->mode = host->mmc->ios.timing;
> +	phy->strobe_dat = false;
> +
> +	switch (phy->mode) {
> +	case MMC_TIMING_UHS_SDR104:
> +		phy->tune_cmd = true;
> +		phy->tune_dat = true;
> +		break;
> +	case MMC_TIMING_UHS_DDR50:
> +		phy->ddr = true;
> +		break;
> +	case MMC_TIMING_MMC_DDR52:
> +		phy->ddr = true;
> +		break;
> +	case MMC_TIMING_MMC_HS200:
> +		phy->tune_dat = true;
> +		phy->tune_cmd = true;
> +		break;
> +	case MMC_TIMING_MMC_HS400:
> +		phy->tune_cmd = true;
> +		phy->ddr = true;
> +		phy->strobe_dat = true;
> +		break;
> +	}
> +
> +	if (priv->enhanced_strobe)
> +		phy->strobe_cmd = true;
> +
> +	phy->d.phy_sdclk_delay = 2 * t_sdmclk;
> +	phy->d.phy_cmd_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
> +	phy->d.phy_dat_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
> +
> +	if (phy->t_sdclk == phy->t_sdmclk) {
> +		phy->settings.sdhc_extended_wr_mode = 0;
> +		phy->settings.sdhc_extended_rd_mode = 0;
> +	} else {
> +		phy->settings.sdhc_extended_wr_mode = 1;
> +		phy->settings.sdhc_extended_rd_mode = 1;
> +	}
> +
> +	phy->settings.cp_gate_cfg_always_on = 1;
> +
> +	sdhci_cdns_sd6_phy_configure_dll(phy);
> +
> +	sdhci_cdns_sd6_phy_calc_settings(phy);
> +
> +	return 0;
> +}
> +
> +static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host,
> +				   unsigned int timing)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	u32 mode;
> +
> +	switch (timing) {
> +	case MMC_TIMING_MMC_HS:
> +		mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
> +		break;
> +	case MMC_TIMING_MMC_DDR52:
> +		mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
> +		break;
> +	case MMC_TIMING_MMC_HS200:
> +		mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
> +		break;
> +	case MMC_TIMING_MMC_HS400:
> +		if (priv->enhanced_strobe)
> +			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
> +		else
> +			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
> +		break;
> +	case MMC_TIMING_SD_HS:
> +		mode = SDHCI_CDNS_HRS06_MODE_SD;
> +		break;
> +	default:
> +		mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
> +		break;
> +	}
> +
> +	return mode;
> +}
> +
> +static void sdhci_cdns_sd6_set_clock(struct sdhci_host *host,
> +				     unsigned int clock)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +
> +	phy->t_sdclk = DIV_ROUND_DOWN_ULL(1e12, clock);
> +
> +	pr_debug("%s %d %d\n", __func__, phy->mode, clock);
> +
> +	if (sdhci_cdns_sd6_phy_update_timings(host))
> +		pr_debug("%s: update timings failed\n", __func__);
> +
> +	if (sdhci_cdns_sd6_phy_init(priv))
> +		pr_debug("%s: phy init failed\n", __func__);
> +
> +	sdhci_set_clock(host, clock);
> +}
> +
>  static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
>  				    struct sdhci_cdns_priv *priv)
>  {
> @@ -243,6 +1287,106 @@ static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int sdhci_cdns_sd6_phy_probe(struct platform_device *pdev,
> +				    struct sdhci_cdns_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_cdns_sd6_phy *phy;
> +	u32 val;
> +	struct clk *clk;
> +	int ret;
> +	const char *mode_name;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	clk = devm_clk_get(dev, "sdmclk");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "sdmclk get error\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	val = clk_get_rate(clk);
> +	phy->t_sdmclk = DIV_ROUND_DOWN_ULL(1e12, val);
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,host_slew",
> +				   &phy->settings.slew);
> +	if (ret)
> +		phy->settings.slew = 3;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,host_drive",
> +				   &phy->settings.drive);
> +	if (ret)
> +		phy->settings.drive = 2;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,iocell-input-delay",
> +				   &phy->d.iocell_input_delay);
> +	if (ret)
> +		phy->d.iocell_input_delay = 2500;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,iocell-output-delay",
> +				   &phy->d.iocell_output_delay);
> +	if (ret)
> +		phy->d.iocell_output_delay = 2500;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,delay-element",
> +				   &phy->d.delay_element);
> +	if (ret)
> +		phy->d.delay_element = 24;
> +
> +	ret = of_property_read_string_index(dev->of_node, "cdns,mode", 0,
> +					    &mode_name);
> +	if (!ret) {
> +		if (!strcmp("emmc_sdr", mode_name))
> +			phy->mode = MMC_TIMING_MMC_HS;
> +		else if (!strcmp("emmc_ddr", mode_name))
> +			phy->mode = MMC_TIMING_MMC_DDR52;
> +		else if (!strcmp("emmc_hs200", mode_name))
> +			phy->mode = MMC_TIMING_MMC_HS200;
> +		else if (!strcmp("emmc_hs400", mode_name))
> +			phy->mode = MMC_TIMING_MMC_HS400;
> +		else if (!strcmp("sd_hs", mode_name))
> +			phy->mode = MMC_TIMING_SD_HS;
> +		else
> +			phy->mode = MMC_TIMING_MMC_HS;
> +	} else {
> +		phy->mode = MMC_TIMING_MMC_HS;
> +	}
> +
> +	phy->d.delay_element_org = phy->d.delay_element;
> +	phy->d.iocell_input_delay = 650;
> +	phy->d.iocell_output_delay = 1800;
> +
> +	switch (phy->mode) {
> +	case MMC_TIMING_MMC_HS:
> +		phy->t_sdclk =  10000;
> +		break;
> +	case MMC_TIMING_MMC_DDR52:
> +		phy->t_sdclk = 10000;
> +		break;
> +	case MMC_TIMING_MMC_HS200:
> +		phy->t_sdclk = 5000;
> +		break;
> +	case MMC_TIMING_MMC_HS400:
> +		phy->t_sdclk = 5000;
> +		break;
> +	case MMC_TIMING_SD_HS:
> +		phy->t_sdclk = 100000;
> +		break;
> +	default:
> +		phy->t_sdclk = 10000;
> +		break;
> +	}
> +
> +	priv->phy = phy;
> +
> +	sdhci_cdns_sd6_get_delay_params(dev, priv);
> +
> +	sdhci_cdns_sd6_calc_phy(phy);
> +	return 0;
> +}
> +
>  static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
>  {
>  	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> @@ -276,6 +1420,58 @@ static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val
>  	return 0;
>  }
>  
> +/*
> + * In SD mode, software must not use the hardware tuning and instead perform
> + * an almost identical procedure to eMMC.
> + */
> +static int sdhci_cdns_sd6_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	int cur_streak = 0;
> +	int max_streak = 0;
> +	int end_of_streak = 0;
> +	int i, midpoint, iter = 0;
> +
> +	/*
> +	 * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
> +	 * The delay is set by probe, based on the DT properties.
> +	 */
> +	if (host->timing != MMC_TIMING_MMC_HS200 &&
> +	    host->timing != MMC_TIMING_UHS_SDR104)
> +		return 0;
> +
> +	for (i = tune_val_start; iter < max_tune_iter; iter++, i += tune_val_step) {
> +		if (priv->cdns_data->set_tune_val(host, i) ||
> +		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
> +			cur_streak = 0;
> +		} else { /* good */
> +			cur_streak++;
> +			if (cur_streak > max_streak) {
> +				max_streak = cur_streak;
> +				end_of_streak = i;
> +				pr_debug("%s (%d-%d = %d)", __func__,
> +					 end_of_streak - ((cur_streak - 1) * tune_val_step),
> +					 end_of_streak, cur_streak);
> +			} else {
> +				pr_debug("%s (%d-%d)", __func__,
> +					 i - ((cur_streak - 1) * tune_val_step), i);
> +			}
> +		}
> +	}
> +
> +	if (!max_streak) {
> +		dev_err(mmc_dev(host->mmc), "no tuning point found\n");
> +		return -EIO;
> +	}
> +
> +	pr_debug("max_streak: %d-%d", end_of_streak - ((max_streak - 1) * tune_val_step),
> +		 end_of_streak);
> +
> +	midpoint = end_of_streak - (((max_streak - 1) * tune_val_step) / 2);
> +
> +	return priv->cdns_data->set_tune_val(host, midpoint);
> +}
> +
>  /*
>   * In SD mode, software must not use the hardware tuning and instead perform
>   * an almost identical procedure to eMMC.
> @@ -338,11 +1534,15 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		else
>  			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
>  		break;
> -	default:
> +	case MMC_TIMING_SD_HS:
>  		mode = SDHCI_CDNS_HRS06_MODE_SD;
>  		break;
> +	default:
> +		mode = SDHCI_CDNS_HRS06_MODE_LEGACY;
> +		break;
>  	}
>  
> +	pr_debug("%s mode %d timing %d\n", __func__, mode, timing);
>  	sdhci_cdns_set_emmc_mode(priv, mode);
>  
>  	/* For SD, fall back to the default handler */
> @@ -350,6 +1550,24 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> +static void sdhci_cdns_sd6_set_uhs_signaling(struct sdhci_host *host,
> +					     unsigned int timing)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +
> +	sdhci_cdns_set_uhs_signaling(host, timing);
> +
> +	if ((phy->mode == -1) || (phy->t_sdclk == -1))
> +		return;
> +
> +	if (sdhci_cdns_sd6_phy_update_timings(host))
> +		pr_debug("%s: update timings failed\n", __func__);
> +
> +	if (sdhci_cdns_sd6_phy_init(priv))
> +		pr_debug("%s: phy init failed\n", __func__);
> +}
> +
>  static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> @@ -359,6 +1577,16 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>  };
>  
> +static const struct sdhci_ops sdhci_cdns_sd6_ops = {
> +	.get_max_clock = sdhci_cdns_get_max_clock,
> +	.set_clock = sdhci_cdns_sd6_set_clock,
> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.platform_execute_tuning = sdhci_cdns_sd6_execute_tuning,
> +	.set_uhs_signaling = sdhci_cdns_sd6_set_uhs_signaling,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
>  	.ops = &sdhci_cdns_sd4_ops,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> @@ -372,17 +1600,32 @@ static const struct sdhci_pltfm_data sdhci_cdns_sd4_pltfm_data = {
>  	.ops = &sdhci_cdns_sd4_ops,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_cdns_sd6_pltfm_data = {
> +	.ops = &sdhci_cdns_sd6_ops,
> +};
> +
>  static const struct sdhci_cdns_data sdhci_cdns_sd4_data = {
>  	.phy_init = sdhci_cdns_sd4_phy_init,
>  	.set_tune_val = sdhci_cdns_sd4_set_tune_val,
>  };
>  
> +static const struct sdhci_cdns_data sdhci_cdns_sd6_data = {
> +	.phy_init = sdhci_cdns_sd6_phy_init,
> +	.set_tune_val = sdhci_cdns_sd6_set_tune_val,
> +};
> +
>  static const struct sdhci_cdns_of_data sdhci_cdns_sd4_of_data = {
>  	.pltfm_data = &sdhci_cdns_sd4_pltfm_data,
>  	.cdns_data = &sdhci_cdns_sd4_data,
>  	.phy_probe = sdhci_cdns_sd4_phy_probe,
>  };
>  
> +static const struct sdhci_cdns_of_data sdhci_cdns_sd6_of_data = {
> +	.pltfm_data = &sdhci_cdns_sd6_pltfm_data,
> +	.cdns_data = &sdhci_cdns_sd6_data,
> +	.phy_probe = sdhci_cdns_sd6_phy_probe,
> +};
> +
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
> @@ -412,7 +1655,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	int ret;
>  	struct device *dev = &pdev->dev;
> -	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;

This change affects all devicesnot just v6

>  
>  	clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(clk))
> @@ -437,6 +1679,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	pltfm_host = sdhci_priv(host);
>  	pltfm_host->clk = clk;
>  
> +	host->clk_mul = 0;
> +	host->max_clk = SDMCLK_MAX_FREQ;
> +	host->quirks |=  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
> +	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;

These changes affects all devicesnot just v6

>  	priv = sdhci_pltfm_priv(pltfm_host);
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
> @@ -444,8 +1690,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
> -	sdhci_enable_v4_mode(host);
> -	__sdhci_read_caps(host, &version, NULL, NULL);
>  
>  	sdhci_get_of_property(pdev);
>  
> @@ -461,6 +1705,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> +	sdhci_enable_v4_mode(host);
> +	__sdhci_read_caps(host, NULL, NULL, NULL);
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto free;
> @@ -516,6 +1762,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "cdns,sd4hc",
>  		.data = &sdhci_cdns_sd4_of_data,
>  	},
> +	{
> +		.compatible = "cdns,sd6hc",
> +		.data = &sdhci_cdns_sd6_of_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);

