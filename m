Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB07D5EDEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiI1OSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiI1OS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:18:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872CA8960;
        Wed, 28 Sep 2022 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664374708; x=1695910708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EJh16eR+tKg6pE5ERnOaK8XXO+3MO7Hak0ng3v5+mXc=;
  b=Ux0qg6CTd7oDNUfNrUFGC6Lze+E9XjI+IdasuflujCXKRbwE9uFaigrf
   o/F8Y0q3WP/UIWyxjqqzdrv5ZamRJoqlQYOSFYPaqqY4LsoPJjCYu/0gl
   +NJ/Sa/Sr6Rb6ZBqWRKsxjagq0yJDX00VCkQmMOqKnYxvWiJIGvTwotnP
   GVV8nplhOKXWLZxsf4cyIkvqd7681s3TGWdZokGTOrHThjI89DeZUYkv5
   nhkDQqVnQefR4dG9KcOw+l3O5KOmxHeBaBtLHWZYRfLJG2cQzNbZcKAKU
   TZpbb3vUa9X0lcfLoL3BlXjk7RWmvNla0sFbDOjQ0+kjMS5PeBE1CknBT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="288771265"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="288771265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:18:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="617223882"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="617223882"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.24])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:18:24 -0700
Message-ID: <34f002a4-b811-106b-52b5-6041674b15e9@intel.com>
Date:   Wed, 28 Sep 2022 17:18:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v6 2/4] mmc: sdhci-tegra: Add support to program MC stream
 ID
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
 <20220928125648.19636-1-pshete@nvidia.com>
 <20220928125648.19636-2-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220928125648.19636-2-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/22 15:56, Prathamesh Shete wrote:
> SMMU clients are supposed to program stream ID from
> their respective address spaces instead of MC override.
> Define NVQUIRK_PROGRAM_STREAMID and use it to program
> SMMU stream ID from the SDMMC client address space.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

One observation below.

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index a6c5bbae77b4..60ce3e80f248 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -25,6 +25,10 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ktime.h>
> +#ifdef CONFIG_IOMMU_API
> +#include <linux/iommu.h>
> +#include <linux/bitops.h>
> +#endif
>  
>  #include <soc/tegra/common.h>
>  
> @@ -94,6 +98,8 @@
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
>  
> +#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
> +
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
> @@ -121,6 +127,7 @@
>  #define NVQUIRK_HAS_TMCLK				BIT(10)
>  
>  #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
> +#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
>  
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -177,6 +184,9 @@ struct sdhci_tegra {
>  	bool enable_hwcq;
>  	unsigned long curr_clk_rate;
>  	u8 tuned_tap_delay;
> +#ifdef CONFIG_IOMMU_API
> +	u32 streamid;
> +#endif
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -1564,6 +1574,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>  		    NVQUIRK_ENABLE_SDR50 |
>  		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_PROGRAM_STREAMID |
>  		    NVQUIRK_HAS_TMCLK,
>  	.min_tap_delay = 95,
>  	.max_tap_delay = 111,
> @@ -1775,6 +1786,25 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto err_add_host;
>  
> +	/* Program MC streamID for DMA transfers */
> +#ifdef CONFIG_IOMMU_API
> +	if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +		struct iommu_fwspec *fwspec;
> +
> +		fwspec = dev_iommu_fwspec_get(&pdev->dev);
> +		if (fwspec == NULL) {
> +			dev_warn(mmc_dev(host->mmc),
> +				"iommu fwspec is NULL, continue without stream ID\n");

It will still program a zero streamid upon resume.

> +		} else {
> +			tegra_host->streamid = fwspec->ids[0] & 0xff;
> +			tegra_sdhci_writel(host, tegra_host->streamid |
> +						FIELD_PREP(GENMASK(15, 8),
> +						tegra_host->streamid),
> +						SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +		}
> +	}
> +#endif
> +
>  	return 0;
>  
>  err_add_host:
> @@ -1861,6 +1891,10 @@ static int sdhci_tegra_suspend(struct device *dev)
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
> @@ -1871,6 +1905,16 @@ static int sdhci_tegra_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* Re-program MC streamID for DMA transfers */
> +#ifdef CONFIG_IOMMU_API
> +	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +		tegra_sdhci_writel(host, tegra_host->streamid |
> +					FIELD_PREP(GENMASK(15, 8),
> +					tegra_host->streamid),
> +					SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +	}
> +#endif
> +
>  	ret = sdhci_resume_host(host);
>  	if (ret)
>  		goto disable_clk;

