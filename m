Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67582717773
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjEaHBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjEaHBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:01:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3281B7;
        Wed, 31 May 2023 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685516476; x=1717052476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7AV3KIc9JV2XIy25hkDnLwlQTDbFCbXIu3YVekxdXlI=;
  b=KpNLIkSvzVyGlevZVeKwEwiKtiXlU3fmyhBj5HOl8u7bYri/6uh3C5z9
   KDWR5B3PX1rx6GjF6U5xRnst+4AAlKzyJ2d/R2AaIgVpAS6W6TV5PqZMp
   MeAUf/4nMmMAd1ibTpAvysq3HpbTXCfH0dlc0+54zEaBvUOa7KbZQ+bDj
   cwE1gxfZim448L8Gz+I3hyHRLq/iyHMPkSgiVd29nemeHHB5SD4XzLODa
   SPN5hf1MI3GG190xoam/R/pFhLN3mJSL2Rgth699bwAY3QJT590QAj5AT
   dPhOnFY1/BKDV9/R9k/lF8DHPegBf11Uxq4gviqU9sFKClhyoQjQxx0xd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="355165796"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="355165796"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776652926"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="776652926"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.175])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:01:12 -0700
Message-ID: <7c185eb3-5775-af7c-3035-2799e3395c33@intel.com>
Date:   Wed, 31 May 2023 10:01:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/3] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz
 and enable SSC for GL9767
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230530095308.8165-1-victorshihgli@gmail.com>
 <20230530095308.8165-3-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230530095308.8165-3-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/23 12:53, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Set GL9767 SDR104's clock to 205MHz and enable SSC feature
> depend on register 0x888 BIT(1).
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 135 ++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 3ed207b89d1a..178253a7e86f 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -158,6 +158,12 @@
>  #define   GLI_9767_VHS_REV_M	  0x1
>  #define   GLI_9767_VHS_REV_W	  0x2
>  
> +#define PCIE_GLI_9767_COM_MAILBOX		0x888
> +#define   PCIE_GLI_9767_COM_MAILBOX_SSC_EN	  BIT(1)
> +
> +#define PCIE_GLI_9767_CFG		0x8A0
> +#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
> @@ -175,6 +181,16 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
>  
> +#define PCIE_GLI_9767_SD_PLL_CTL			0x938
> +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV		  GENMASK(9, 0)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV		  GENMASK(15, 12)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN		  BIT(16)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_EN		  BIT(19)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING	  GENMASK(28, 24)
> +
> +#define PCIE_GLI_9767_SD_PLL_CTL2		0x93C
> +#define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM	  GENMASK(31, 16)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> @@ -753,6 +769,123 @@ static inline void gl9767_vhs_write(struct pci_dev *pdev)
>  	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, vhs_value);
>  }
>  
> +static bool gl9767_ssc_enable(struct pci_dev *pdev)
> +{
> +	u32 value;
> +	u8 enable;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_COM_MAILBOX, &value);
> +	enable = FIELD_GET(PCIE_GLI_9767_COM_MAILBOX_SSC_EN, value);
> +
> +	gl9767_vhs_read(pdev);
> +
> +	return enable;
> +}
> +
> +static void gl9767_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
> +{
> +	u32 pll;
> +	u32 ssc;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, &ssc);
> +	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING |
> +		 PCIE_GLI_9767_SD_PLL_CTL_SSC_EN);
> +	ssc &= ~PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM;
> +	pll |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING, step) |
> +	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_EN, enable);
> +	ssc |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM, ppm);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, ssc);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> +
> +	gl9767_vhs_read(pdev);
> +}
> +
> +static void gl9767_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
> +{
> +	u32 pll;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> +	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV |
> +		 PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV |
> +		 PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN);
> +	pll |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV, ldiv) |
> +	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV, pdiv) |
> +	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN, dir);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> +
> +	gl9767_vhs_read(pdev);
> +
> +	/* wait for pll stable */
> +	mdelay(1);

So long as SDHCI_QUIRK_CLOCK_BEFORE_RESET is not used, it is OK
to sleep here, so msleep() or usleep_range()

> +}
> +
> +static void gl9767_set_ssc_pll_205mhz(struct pci_dev *pdev)
> +{
> +	bool enable = gl9767_ssc_enable(pdev);
> +
> +	/* set pll to 205MHz and ssc */
> +	gl9767_set_ssc(pdev, enable, 0x1F, 0xF5C3);
> +	gl9767_set_pll(pdev, 0x1, 0x246, 0x0);
> +}
> +
> +static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
> +{
> +	u32 pll;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> +	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN | PCIE_GLI_9767_SD_PLL_CTL_SSC_EN);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> +
> +	gl9767_vhs_read(pdev);
> +}
> +
> +static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct mmc_ios *ios = &host->mmc->ios;
> +	struct pci_dev *pdev;
> +	u32 value;
> +	u16 clk;
> +
> +	pdev = slot->chip->pdev;
> +	host->mmc->actual_clock = 0;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +	gl9767_disable_ssc_pll(pdev);
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> +		host->mmc->actual_clock = 205000000;
> +		gl9767_set_ssc_pll_205mhz(pdev);
> +	}
> +
> +	sdhci_enable_clk(host, clk);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +	gl9767_vhs_read(pdev);
> +}
> +
>  static void gli_set_9767(struct sdhci_host *host)
>  {
>  	u32 value;
> @@ -1293,7 +1426,7 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  };
>  
>  static const struct sdhci_ops sdhci_gl9767_ops = {
> -	.set_clock		 = sdhci_set_clock,
> +	.set_clock		 = sdhci_gl9767_set_clock,
>  	.enable_dma		 = sdhci_pci_enable_dma,
>  	.set_bus_width		 = sdhci_set_bus_width,
>  	.reset			 = sdhci_gl9767_reset,

