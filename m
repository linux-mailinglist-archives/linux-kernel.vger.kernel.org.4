Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D956CFDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjC3IPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC3IPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:15:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925BE40C9;
        Thu, 30 Mar 2023 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680164137; x=1711700137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y59aS2iwIzFygngRIrw4Fw3tE/XzmwJj81XtUjvAhBE=;
  b=Dnute8G+JxWI6+DZ2oBzpJILz1//RM/wP+FMAur85F4ubizrifKGCwpD
   LQp8XzhNaB8Gh/NN0iZQPlYdy9g+07GwMYS2QBge2q0O/CK9T9rqz0H18
   nXmk7JWgEi6n4ipusGzT2raaoQITNHwPt3z4dfvmwLfeXYNKnOJyzaj1d
   oLg0GUUzDHZzVSERRBtOIm1jEIDlyQT+jvI0qbztJD/lOJ2LbYUeycRY9
   bM1SgVmnz+C8zbp8+3TgtvbNaxyYzLFGRQcbOnzC9zGhGxCcVtR2w2Z3u
   Zgm4r2p893FPeAXnxoQKWPdNWKoyYKF5FQybvtla1onRyk+Rky7PecTcK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342714662"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="342714662"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 01:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687144010"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687144010"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.32.122])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 01:15:32 -0700
Message-ID: <e806aad7-68f7-9e1d-7383-32b70d6afac2@intel.com>
Date:   Thu, 30 Mar 2023 11:15:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-arasan: Add support for eMMC5.1 on
 Xilinx Versal Net platform
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, saikrishna12468@gmail.com,
        Swati Agarwal <swati.agarwal@amd.com>
References: <20230330065240.3532010-1-sai.krishna.potthuri@amd.com>
 <20230330065240.3532010-3-sai.krishna.potthuri@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230330065240.3532010-3-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/23 09:52, Sai Krishna Potthuri wrote:
> From: Swati Agarwal <swati.agarwal@amd.com>
> 
> Add support for eMMC5.1 on Xilinx Versal Net platform
> - Add new compatible string(xlnx,versal-net-emmc).
> - Add support for PHY which is part of Host Controller register space.
> - Add DLL and Delay Chain mode support and corresponding tap delays for
> all eMMC modes.
> - Add Strobe select tap for HS400 mode.
> 
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 237 ++++++++++++++++++++++++++++-
>  1 file changed, 236 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index deb67daf179f..d9a29c346745 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -41,11 +41,41 @@
>  #define VENDOR_ENHANCED_STROBE		BIT(0)
>  
>  #define PHY_CLK_TOO_SLOW_HZ		400000
> +#define MIN_PHY_CLK_HZ			50000000
>  
>  #define SDHCI_ITAPDLY_CHGWIN		0x200
>  #define SDHCI_ITAPDLY_ENABLE		0x100
>  #define SDHCI_OTAPDLY_ENABLE		0x40
>  
> +#define PHY_CTRL_REG1			0x270
> +#define PHY_CTRL_ITAPDLY_ENA_MASK	BIT(0)
> +#define PHY_CTRL_ITAPDLY_SEL_MASK	GENMASK(5, 1)
> +#define PHY_CTRL_ITAPDLY_SEL_SHIFT	1
> +#define PHY_CTRL_ITAP_CHG_WIN_MASK	BIT(6)
> +#define PHY_CTRL_OTAPDLY_ENA_MASK	BIT(8)
> +#define PHY_CTRL_OTAPDLY_SEL_MASK	GENMASK(15, 12)
> +#define PHY_CTRL_OTAPDLY_SEL_SHIFT	12
> +#define PHY_CTRL_STRB_SEL_MASK		GENMASK(23, 16)
> +#define PHY_CTRL_STRB_SEL_SHIFT		16
> +#define PHY_CTRL_TEST_CTRL_MASK		GENMASK(31, 24)
> +
> +#define PHY_CTRL_REG2			0x274
> +#define PHY_CTRL_EN_DLL_MASK		BIT(0)
> +#define PHY_CTRL_DLL_RDY_MASK		BIT(1)
> +#define PHY_CTRL_FREQ_SEL_MASK		GENMASK(6, 4)
> +#define PHY_CTRL_FREQ_SEL_SHIFT		4
> +#define PHY_CTRL_SEL_DLY_TX_MASK	BIT(16)
> +#define PHY_CTRL_SEL_DLY_RX_MASK	BIT(17)
> +#define FREQSEL_200M_170M		0x0
> +#define FREQSEL_170M_140M	        0x1
> +#define FREQSEL_140M_110M	        0x2
> +#define FREQSEL_110M_80M	        0x3
> +#define FREQSEL_80M_50M			0x4
> +#define FREQSEL_275M_250M		0x5
> +#define FREQSEL_250M_225M		0x6
> +#define FREQSEL_225M_200M		0x7
> +#define PHY_DLL_TIMEOUT_MS		100
> +
>  /* Default settings for ZynqMP Clock Phases */
>  #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
>  #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
> @@ -53,6 +83,11 @@
>  #define VERSAL_ICLK_PHASE {0, 132, 132, 0, 132, 0, 0, 162, 90, 0, 0}
>  #define VERSAL_OCLK_PHASE {0,  60, 48, 0, 48, 72, 90, 36, 60, 90, 0}
>  
> +#define VERSAL_NET_EMMC_ICLK_PHASE {0, 0, 0, 0, 0, 0, 0, 0, 39, 0, 0}
> +#define VERSAL_NET_EMMC_OCLK_PHASE {0, 113, 0, 0, 0, 0, 0, 0, 113, 79, 45}
> +
> +#define VERSAL_NET_PHY_CTRL_STRB90_STRB180_VAL		0X77
> +
>  /*
>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
> @@ -135,6 +170,7 @@ struct sdhci_arasan_clk_data {
>   * @clk_ahb:		Pointer to the AHB clock
>   * @phy:		Pointer to the generic phy
>   * @is_phy_on:		True if the PHY is on; false if not.
> + * @internal_phy_reg:	True if the PHY is within the Host controller.
>   * @has_cqe:		True if controller has command queuing engine.
>   * @clk_data:		Struct for the Arasan Controller Clock Data.
>   * @clk_ops:		Struct for the Arasan Controller Clock Operations.
> @@ -147,6 +183,7 @@ struct sdhci_arasan_data {
>  	struct clk	*clk_ahb;
>  	struct phy	*phy;
>  	bool		is_phy_on;
> +	bool		internal_phy_reg;
>  
>  	bool		has_cqe;
>  	struct sdhci_arasan_clk_data clk_data;
> @@ -207,6 +244,61 @@ static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
>  	.hiword_update = false,
>  };
>  
> +static void sdhci_arasan_phy_set_delaychain(struct sdhci_host *host, bool enable)
> +{
> +	u32 reg;
> +
> +	reg = readl(host->ioaddr + PHY_CTRL_REG2);
> +	if (enable)
> +		reg |= (PHY_CTRL_SEL_DLY_TX_MASK | PHY_CTRL_SEL_DLY_RX_MASK);
> +	else
> +		reg &= ~(PHY_CTRL_SEL_DLY_TX_MASK | PHY_CTRL_SEL_DLY_RX_MASK);
> +
> +	writel(reg, host->ioaddr + PHY_CTRL_REG2);
> +}
> +
> +static int sdhci_arasan_phy_set_dll(struct sdhci_host *host, bool enable)
> +{
> +	u32 reg;
> +
> +	reg = readl(host->ioaddr + PHY_CTRL_REG2);
> +	if (enable)
> +		reg |= PHY_CTRL_EN_DLL_MASK;
> +	else
> +		reg &= ~PHY_CTRL_EN_DLL_MASK;
> +
> +	writel(reg, host->ioaddr + PHY_CTRL_REG2);
> +
> +	if (!enable)
> +		return 0;
> +
> +	return readl_relaxed_poll_timeout(host->ioaddr + PHY_CTRL_REG2, reg,
> +					  (reg & PHY_CTRL_DLL_RDY_MASK), 10,
> +					  1000 * PHY_DLL_TIMEOUT_MS);
> +}
> +
> +static void sdhci_arasan_phy_dll_set_freq(struct sdhci_host *host, int clock)
> +{
> +	u32 reg, freq_sel, freq;
> +
> +	freq = DIV_ROUND_CLOSEST(clock, 1000000);
> +	if (freq <= 200 && freq > 170)
> +		freq_sel = FREQSEL_200M_170M;
> +	else if (freq <= 170 && freq > 140)
> +		freq_sel = FREQSEL_170M_140M;
> +	else if (freq <= 140 && freq > 110)
> +		freq_sel = FREQSEL_140M_110M;
> +	else if (freq <= 110 && freq > 80)
> +		freq_sel = FREQSEL_110M_80M;
> +	else
> +		freq_sel = FREQSEL_80M_50M;
> +
> +	reg = readl(host->ioaddr + PHY_CTRL_REG2);
> +	reg &= ~PHY_CTRL_FREQ_SEL_MASK;
> +	reg |= (freq_sel << PHY_CTRL_FREQ_SEL_SHIFT);
> +	writel(reg, host->ioaddr + PHY_CTRL_REG2);
> +}
> +
>  /**
>   * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
>   *
> @@ -321,11 +413,24 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  
>  	/* Set the Input and Output Clock Phase Delays */
> -	if (clk_data->set_clk_delays)
> +	if (clk_data->set_clk_delays && clock > PHY_CLK_TOO_SLOW_HZ)

This change looks like it would affect other devices than 
"xlnx,versal-net-emmc", in which case it should be a separate
patch?

>  		clk_data->set_clk_delays(host);
>  
> +	if (sdhci_arasan->internal_phy_reg && clock >= MIN_PHY_CLK_HZ) {
> +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +		sdhci_arasan_phy_set_dll(host, 0);
> +		sdhci_arasan_phy_set_delaychain(host, 0);
> +		sdhci_arasan_phy_dll_set_freq(host, clock);
> +	} else if (sdhci_arasan->internal_phy_reg) {
> +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +		sdhci_arasan_phy_set_delaychain(host, 1);
> +	}
> +
>  	sdhci_set_clock(host, clock);
>  
> +	if (sdhci_arasan->internal_phy_reg && clock >= MIN_PHY_CLK_HZ)
> +		sdhci_arasan_phy_set_dll(host, 1);
> +
>  	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE)
>  		/*
>  		 * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
> @@ -897,6 +1002,101 @@ static const struct clk_ops versal_sampleclk_ops = {
>  	.set_phase = sdhci_versal_sampleclk_set_phase,
>  };
>  
> +static int sdhci_versal_net_emmc_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct sdhci_arasan_clk_data *clk_data =
> +		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
> +	struct sdhci_arasan_data *sdhci_arasan =
> +		container_of(clk_data, struct sdhci_arasan_data, clk_data);
> +	struct sdhci_host *host = sdhci_arasan->host;
> +	u8 tap_delay, tap_max = 0;
> +
> +	switch (host->timing) {
> +	case MMC_TIMING_MMC_HS:
> +	case MMC_TIMING_MMC_DDR52:
> +		tap_max = 16;
> +		break;
> +	case MMC_TIMING_MMC_HS200:
> +	case MMC_TIMING_MMC_HS400:
> +		 /* For 200MHz clock, 32 Taps are available */
> +		tap_max = 32;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	tap_delay = (degrees * tap_max) / 360;
> +
> +	/* Set the Clock Phase */
> +	if (tap_delay) {
> +		u32 regval;
> +
> +		regval = sdhci_readl(host, PHY_CTRL_REG1);
> +		regval |= PHY_CTRL_OTAPDLY_ENA_MASK;
> +		sdhci_writel(host, regval, PHY_CTRL_REG1);
> +		regval &= ~PHY_CTRL_OTAPDLY_SEL_MASK;
> +		regval |= tap_delay << PHY_CTRL_OTAPDLY_SEL_SHIFT;
> +		sdhci_writel(host, regval, PHY_CTRL_REG1);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops versal_net_sdcardclk_ops = {
> +	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
> +	.set_phase = sdhci_versal_net_emmc_sdcardclk_set_phase,
> +};
> +
> +static int sdhci_versal_net_emmc_sampleclk_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct sdhci_arasan_clk_data *clk_data =
> +		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
> +	struct sdhci_arasan_data *sdhci_arasan =
> +		container_of(clk_data, struct sdhci_arasan_data, clk_data);
> +	struct sdhci_host *host = sdhci_arasan->host;
> +	u8 tap_delay, tap_max = 0;
> +	u32 regval;
> +
> +	switch (host->timing) {
> +	case MMC_TIMING_MMC_HS:
> +	case MMC_TIMING_MMC_DDR52:
> +		tap_max = 32;
> +		break;
> +	case MMC_TIMING_MMC_HS400:
> +		/* Strobe select tap point for strb90 and strb180 */
> +		regval = sdhci_readl(host, PHY_CTRL_REG1);
> +		regval &= ~PHY_CTRL_STRB_SEL_MASK;
> +		regval |= VERSAL_NET_PHY_CTRL_STRB90_STRB180_VAL << PHY_CTRL_STRB_SEL_SHIFT;
> +		sdhci_writel(host, regval, PHY_CTRL_REG1);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	tap_delay = (degrees * tap_max) / 360;
> +
> +	/* Set the Clock Phase */
> +	if (tap_delay) {
> +		regval = sdhci_readl(host, PHY_CTRL_REG1);
> +		regval |= PHY_CTRL_ITAP_CHG_WIN_MASK;
> +		sdhci_writel(host, regval, PHY_CTRL_REG1);
> +		regval |= PHY_CTRL_ITAPDLY_ENA_MASK;
> +		sdhci_writel(host, regval, PHY_CTRL_REG1);
> +		regval &= ~PHY_CTRL_ITAPDLY_SEL_MASK;
> +		regval |= tap_delay << PHY_CTRL_ITAPDLY_SEL_SHIFT;
> +		sdhci_writel(host, regval, PHY_CTRL_REG1);
> +		regval &= ~PHY_CTRL_ITAP_CHG_WIN_MASK;
> +		sdhci_writel(host, regval, PHY_CTRL_REG1);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops versal_net_sampleclk_ops = {
> +	.recalc_rate = sdhci_arasan_sampleclk_recalc_rate,
> +	.set_phase = sdhci_versal_net_emmc_sampleclk_set_phase,
> +};
> +
>  static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
>  {
>  	u16 clk;
> @@ -1107,7 +1307,17 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>  			clk_data->clk_phase_out[i] = versal_oclk_phase[i];
>  		}
>  	}
> +	if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-emmc")) {
> +		u32 versal_net_iclk_phase[MMC_TIMING_MMC_HS400 + 1] =
> +			VERSAL_NET_EMMC_ICLK_PHASE;
> +		u32 versal_net_oclk_phase[MMC_TIMING_MMC_HS400 + 1] =
> +			VERSAL_NET_EMMC_OCLK_PHASE;
>  
> +		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> +			clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
> +			clk_data->clk_phase_out[i] = versal_net_oclk_phase[i];
> +		}
> +	}
>  	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
>  				 "clk-phase-legacy");
>  	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
> @@ -1225,6 +1435,14 @@ static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
>  			SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_arasan_versal_net_pdata = {
> +	.ops = &sdhci_arasan_ops,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +			SDHCI_QUIRK2_STOP_WITH_TC |
> +			SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
> +};
> +
>  static const struct sdhci_arasan_clk_ops zynqmp_clk_ops = {
>  	.sdcardclk_ops = &zynqmp_sdcardclk_ops,
>  	.sampleclk_ops = &zynqmp_sampleclk_ops,
> @@ -1245,6 +1463,16 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
>  	.clk_ops = &versal_clk_ops,
>  };
>  
> +static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
> +	.sdcardclk_ops = &versal_net_sdcardclk_ops,
> +	.sampleclk_ops = &versal_net_sampleclk_ops,
> +};
> +
> +static struct sdhci_arasan_of_data sdhci_arasan_versal_net_data = {
> +	.pdata = &sdhci_arasan_versal_net_pdata,
> +	.clk_ops = &versal_net_clk_ops,
> +};
> +
>  static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
>  	.soc_ctl_map = &intel_keembay_soc_ctl_map,
>  	.pdata = &sdhci_keembay_emmc_pdata,
> @@ -1314,6 +1542,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>  		.compatible = "xlnx,versal-8.9a",
>  		.data = &sdhci_arasan_versal_data,
>  	},
> +	{
> +		.compatible = "xlnx,versal-net-emmc",
> +		.data = &sdhci_arasan_versal_net_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> @@ -1788,6 +2020,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>  	}
>  
> +	if (of_device_is_compatible(np, "xlnx,versal-net-emmc"))
> +		sdhci_arasan->internal_phy_reg = true;
> +
>  	ret = sdhci_arasan_add_host(sdhci_arasan);
>  	if (ret)
>  		goto err_add_host;

