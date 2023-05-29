Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BFE714727
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjE2Jgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjE2Jgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:36:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A74AF;
        Mon, 29 May 2023 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685353002; x=1716889002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hmf/8aka1XiBaUJVjY5MRBF0dikx8R1Qc4mvzR1omTU=;
  b=hC2c504cvrY/yUgicgfIBgF6EZCRaSCLVEqVvJZikryIqC91+/cs8ukh
   i3XCwkzmxaWyu3ZSbe7wHIH+uXbgUhbuCZ2J7ymDBFnYc1xjT5LUxybjC
   n+OjoEA1LgKkPeSIiuGB5sU4Ddl4ucZN+v0mshQziETn6zIpJBFB3CTe3
   OHOE0kLsq7xUOngApkt0vUd3bUAkBBHjFucrZjq4MheAa53WxdeX6RdLt
   iTCU71jrJCVaetmTMHe9YSsYQ7woFRPH92LivsrCUIA4nUUqeojS2qNyM
   Yuee40M9hmqwfYkgCa3Uh8ij8yJt2vswpZN+XXMhcqVcapSu35BqCwMKB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="352171972"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="352171972"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 02:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="952682286"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="952682286"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.110])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 02:36:38 -0700
Message-ID: <8e8f7a8c-bb7d-3e8a-7c3e-af95f4effe4e@intel.com>
Date:   Mon, 29 May 2023 12:36:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V1 3/3] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
 <20230512104559.11218-4-victor.shih@genesyslogic.com.tw>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230512104559.11218-4-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/23 13:45, Victor Shih wrote:
> Add support SD Express card for GL9767. The workflow of the
> SD Express card in GL9767 is as below.
> 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> 2. If card is inserted, Host send CMD8 to ask the capabilities
>    of the card.
> 3. If the card has PCIe capability and write protect is not
>    enable, then init_sd_express() will be invoked.

Could explain about why not write protect

> 4. GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
>    handover control to NVMe driver.
> 5. If card is removed, GL9767 will return to SD mode.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

As Ben pointed out, please try to use the same email address
for From: and Signed-off-by:

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 115 +++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 300512740cb0..a0f9c24439be 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -158,6 +158,13 @@
>  #define   GLI_9767_VHS_REV_M	  0x1
>  #define   GLI_9767_VHS_REV_W	  0x2
>  
> +#define PCIE_GLI_9767_CFG		0x8A0
> +#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
> +
> +#define PCIE_GLI_9767_COMBO_MUX_CTL			0x8C8
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
> @@ -175,6 +182,27 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
>  
> +#define PCIE_GLI_9767_SDHC_CAP			0x91C
> +#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
> +
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
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIMER	  GENMASK(1, 0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2				0x954
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN	  GENMASK(1, 0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  GENMASK(1, 0)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> @@ -774,6 +802,91 @@ static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
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
> +	if (sdhci_check_ro(host)) {

I think mmc->get_ro(mmc) would be fine here instead.

> +		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
> +		return 0;
> +	}
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +	value &= ~GLI_9767_VHS_REV;
> +	value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
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
> +	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIMER;
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
> +	sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +	value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +
> +	for (i = 0; i < 10; i++) {
> +		mdelay(10);

This should be msleep() or usleep_range()

> +		pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
> +		if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE) {
> +			pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2,
> +					       value);
> +			break;
> +		}
> +	}
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
> +	if ((value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) == PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) {
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +		value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
> +		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +	} else {
> +		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
> +	}
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +	value &= ~GLI_9767_VHS_REV;
> +	value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> +
> +	return 0;
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
> @@ -806,6 +919,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
>  	gl9767_hw_setting(slot);
>  	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
> +	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
>  	sdhci_enable_v4_mode(host);
>  
>  	return 0;

