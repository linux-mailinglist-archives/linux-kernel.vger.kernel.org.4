Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B659D5EC32F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiI0Mp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiI0Mpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:45:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254B51406F7;
        Tue, 27 Sep 2022 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664282753; x=1695818753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4sq1AHyWFyOqVpjRETvsq1ss7KGQ2KV4EhyDYN3JmJg=;
  b=I7yjHeho+za68gzOwraRmsxbgUx2YpejdX8V+q8S2tYNMVCmqWhO+LMp
   XRHbpru5G+uQV1WlnrhWjqABEqDNdh83KwfghtlBJrJCaL6rPTFG7vb54
   TtTzsykrzPnA5FObh8SVPcryoOAtI0S8ytxVV9Y6o1+MUpSuh67k5pDve
   oE2nsGat0d2HgDnVbqDq9XAFfKOnbsDcRpRRwvwJxdpHj+hBTOMYcn98r
   bLN6xYAwfwszE1VdjbCiEieGXI7YkNPoslMGRAdgnAxx2Kqbw7PaO4w16
   N343ydjGmDdwKHdfXTRieo/8feyegJ/BsrpTjpRK4JITqGw5b9U54zEAT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363143665"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="363143665"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:45:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="763863509"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="763863509"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:45:49 -0700
Message-ID: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
Date:   Tue, 27 Sep 2022 15:45:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 2/3] mmc: sdhci-tegra: Add support to program MC stream
 ID
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
 <20220927111314.32229-1-pshete@nvidia.com>
 <20220927111314.32229-2-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220927111314.32229-2-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/22 14:13, Prathamesh Shete wrote:
> SMMU clients are supposed to program stream ID from
> their respective address spaces instead of MC override.
> Define NVQUIRK_PROGRAM_STREAMID and use it to program
> SMMU stream ID from the SDMMC client address space.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 47 ++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index a6c5bbae77b4..46f37cc26dbb 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -25,6 +25,9 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ktime.h>
> +#ifdef CONFIG_IOMMU_API
> +#include <linux/iommu.h>
> +#endif
>  
>  #include <soc/tegra/common.h>
>  
> @@ -94,6 +97,8 @@
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
>  
> +#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
> +
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
> @@ -121,6 +126,7 @@
>  #define NVQUIRK_HAS_TMCLK				BIT(10)
>  
>  #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
> +#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
>  
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -128,6 +134,8 @@
>  #define SDHCI_TEGRA_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
>  					 SDHCI_TRNS_BLK_CNT_EN | \
>  					 SDHCI_TRNS_DMA)
> +#define SDHCI_TEGRA_STREAMID_MASK			0xff
> +#define SDHCI_TEGRA_WRITE_STREAMID_SHIFT		0x8
>  
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> @@ -177,6 +185,9 @@ struct sdhci_tegra {
>  	bool enable_hwcq;
>  	unsigned long curr_clk_rate;
>  	u8 tuned_tap_delay;
> +#ifdef CONFIG_IOMMU_API
> +	u32 streamid;
> +#endif
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -1564,6 +1575,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>  		    NVQUIRK_ENABLE_SDR50 |
>  		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_PROGRAM_STREAMID |
>  		    NVQUIRK_HAS_TMCLK,
>  	.min_tap_delay = 95,
>  	.max_tap_delay = 111,
> @@ -1636,6 +1648,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_tegra *tegra_host;
> +#ifdef CONFIG_IOMMU_API
> +	struct iommu_fwspec *fwspec;
> +#endif

Move this below

>  	struct clk *clk;
>  	int rc;
>  
> @@ -1775,6 +1790,25 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto err_add_host;
>  
> +	/* Program MC streamID for DMA transfers */
> +#ifdef CONFIG_IOMMU_API
> +	if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {

Can put it here

		struct iommu_fwspec *fwspec;


> +		fwspec = dev_iommu_fwspec_get(&pdev->dev);
> +		if (fwspec == NULL) {
> +			dev_warn(mmc_dev(host->mmc),
> +				"iommu fwspec is NULL, continue without stream ID\n");
> +		} else {
> +			tegra_host->streamid = fwspec->ids[0] & 0xffff;
> +			tegra_sdhci_writel(host, (tegra_host->streamid &
> +						SDHCI_TEGRA_STREAMID_MASK) |
> +						((tegra_host->streamid <<
> +						SDHCI_TEGRA_WRITE_STREAMID_SHIFT)
> +						& SDHCI_TEGRA_STREAMID_MASK),
> +						SDHCI_TEGRA_CIF2AXI_CTRL_0);

This is hard to read.  Maybe use GENMASK and FIELD_PREP, or if the bytes
need swapping, one of the byte swapping macros.

Also, isn't this always zero ?

	((tegra_host->streamid << SDHCI_TEGRA_WRITE_STREAMID_SHIFT) & SDHCI_TEGRA_STREAMID_MASK),


> +		}
> +	}
> +#endif
> +
>  	return 0;
>  
>  err_add_host:
> @@ -1861,6 +1895,10 @@ static int sdhci_tegra_suspend(struct device *dev)
>  static int sdhci_tegra_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +#ifdef CONFIG_IOMMU_API
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +#endif
>  	int ret;
>  
>  	ret = mmc_gpio_set_cd_wake(host->mmc, false);
> @@ -1871,6 +1909,15 @@ static int sdhci_tegra_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* Re-program MC streamID for DMA transfers */
> +#ifdef CONFIG_IOMMU_API
> +	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +		tegra_sdhci_writel(host, tegra_host->streamid |
> +					(tegra_host->streamid << 8),

This looks like it ought to be the same calculation as above ?

> +					SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +	}
> +#endif
> +
>  	ret = sdhci_resume_host(host);
>  	if (ret)
>  		goto disable_clk;

