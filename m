Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395AF717D08
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjEaKRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjEaKRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:17:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC77112E;
        Wed, 31 May 2023 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685528255; x=1717064255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GsRG6ay/Z5AWKb+TAcbamET7NWSodf69kvrk6lV1EMA=;
  b=BwQkHcOVxfuMyuMBdLRRbX344cfGDMr29yPdAwdAI9Z+eKoX+G4OFXV1
   QyTBKh2AylMifoD2BcoE59L5E67WT67XER6QipUsNM4H33DfqHcPQ563v
   OupO1ICyrXkI5IO6UunDpurp67PWwygW7cG+IS8z/1AJ4w73fSGHkTMV3
   wljhitng0nN72Ik0lZeRkWHw+2holD7+nbOumG6d6L22HBG/w9FLhaxiV
   BJMX3U99rJrNZdTZ83wkV7JOjp2iTPkwVy3ZD1OxhehEWfjG7Kf40UZT8
   f/iufz1V9bEGZlkez1CSGFTWSE6v+Nc8H4ENudN8wd0GTmi+Qkx8lre9i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="335541073"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="335541073"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="831166226"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="831166226"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.175])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:17:31 -0700
Message-ID: <387a2f61-a732-fc6e-d221-97eed4624929@intel.com>
Date:   Wed, 31 May 2023 13:17:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V3 3/3] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230531095721.392664-1-victorshihgli@gmail.com>
 <20230531095721.392664-4-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230531095721.392664-4-victorshihgli@gmail.com>
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

On 31/05/23 12:57, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Add support SD Express card for GL9767. The workflow of the
> SD Express card in GL9767 is as below.
> 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> 2. If card is inserted, Host send CMD8 to ask the capabilities
>    of the card.
> 3. If the card has PCIe capability, then init_sd_express()
>    will be invoked.
> 4. If the card has been put in write protect state then the
>    SD features supported by SD mode but not supported by
>    PCIe mode, therefore GL9767 switch to SD mode.
> 5. If the card has not been put in write protect state then
>    GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
>    handover control to NVMe driver.
> 6. If card is removed, GL9767 will return to SD mode.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 113 +++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 392a106cea18..bd5185476d0f 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -164,6 +164,10 @@
>  #define PCIE_GLI_9767_CFG		0x8A0
>  #define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
>  
> +#define PCIE_GLI_9767_COMBO_MUX_CTL			0x8C8
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
> @@ -181,6 +185,9 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
>  
> +#define PCIE_GLI_9767_SDHC_CAP			0x91C
> +#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
> +
>  #define PCIE_GLI_9767_SD_PLL_CTL			0x938
>  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV		  GENMASK(9, 0)
>  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV		  GENMASK(15, 12)
> @@ -191,6 +198,23 @@
>  #define PCIE_GLI_9767_SD_PLL_CTL2		0x93C
>  #define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM	  GENMASK(31, 16)
>  
> +#define PCIE_GLI_9767_SD_EXPRESS_CTL			0x940
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE		  BIT(0)
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
> +
> +#define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME	  GENMASK(23, 16)
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE	  0x64
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2			0x950
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE	  BIT(0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2				0x954
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN	  BIT(0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  BIT(0)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> @@ -935,6 +959,93 @@ static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
>  	gli_set_9767(host);
>  }
>  
> +static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev;
> +	u32 value;
> +	int i;
> +
> +	pdev = slot->chip->pdev;
> +
> +	if (mmc->ops->get_ro(mmc)) {
> +		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
> +		return 0;
> +	}
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value);
> +	value &= ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
> +	value &= ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
> +	value |= FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME,
> +			    PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
> +	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, &value);
> +	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, &value);
> +	value |= PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +	value = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	value &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> +	sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> +
> +	value = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +	value |= ((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);

Sorry I didn't notice this before but these VDD2 bits should be
defined:


diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f4f2085c274c..f219bdea8f28 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -99,6 +99,13 @@
 #define  SDHCI_POWER_180	0x0A
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
+/*
+ * VDD2 - UHS2 or PCIe/NVMe
+ * VDD2 power on/off and voltage select
+ */
+#define  SDHCI_VDD2_POWER_ON	0x10
+#define  SDHCI_VDD2_POWER_120	0x80
+#define  SDHCI_VDD2_POWER_180	0xA0
 
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 


> +	sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +	value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +
> +	for (i = 0; i < 2; i++) {
> +		msleep(10);
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
> +		if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE) {
> +			pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2,
> +					       value);
> +			break;
> +		}
> +	}
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
> +	if (value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) {
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +		value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
> +		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +	} else {
> +		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
> +
> +		value = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +		value &= ~((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);

See above

> +		sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> +
> +		value = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		value |= (SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> +		sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> +	}
> +
> +	gl9767_vhs_read(pdev);
> +
> +	return 0;
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
> @@ -967,6 +1078,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
>  	gl9767_hw_setting(slot);
>  	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
> +	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
>  	sdhci_enable_v4_mode(host);
>  
>  	return 0;

