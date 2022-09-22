Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473355E6145
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiIVLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIVLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:37:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D358991B;
        Thu, 22 Sep 2022 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663846632; x=1695382632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VNcLEZj8h1+OGTQyLG9ZyCCScG0b6Yd3fVm8/6Qu2gY=;
  b=mG403/TXlZRtp3Wf3u4eSp+RN1IWYXTmaxOpzc5SMGghzJ5aAlJQjoJ6
   P5hJnEaHwyiYEKJk/2PJ2bs9X5nb2xfMTXwi8TdL6aG0kaQak9CZoihgO
   VBcFXDKWkku4Iki49BSB9UTjUrBOFdt4XnSsczOHS6QVFbC/pDkrBxxqf
   sCTmiMtNXHBitB/6IINlvrKuG5HtTFb4838NFjeUWg2FqAd0MmOcK8hZB
   7GLrbdODTLZZn9cmRdbr1OwdD0o3ltzuN1RcrzeFXpDjBt7S5rtjTLDmP
   Qw3IG08YcbQ/CrEqPYASDwEO92Bd3ejFuufHVqgY5etnVkY4epkO2RjC3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297870744"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297870744"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:37:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762151764"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:37:08 -0700
Message-ID: <8baa26d8-af6f-c7d2-a87a-a9803eb1f275@intel.com>
Date:   Thu, 22 Sep 2022 14:37:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/4] mmc: sdhci-tegra: Add support to program MC stream
 ID
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <20220920123752.21027-1-pshete@nvidia.com>
 <20220920123752.21027-2-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220920123752.21027-2-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/22 15:37, Prathamesh Shete wrote:
> SMMU clients are supposed to program stream ID from
> their respective address spaces instead of MC override.
> Define NVQUIRK_PROGRAM_STREAMID and use it to program
> SMMU stream ID from the SDMMC client address space.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index a6c5bbae77b4..4d32b5bfc424 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -25,6 +25,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ktime.h>
> +#include <linux/iommu.h>
>  
>  #include <soc/tegra/common.h>
>  
> @@ -94,6 +95,8 @@
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
>  
> +#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
> +
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
> @@ -121,6 +124,7 @@
>  #define NVQUIRK_HAS_TMCLK				BIT(10)
>  
>  #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
> +#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
>  
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -128,6 +132,8 @@
>  #define SDHCI_TEGRA_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
>  					 SDHCI_TRNS_BLK_CNT_EN | \
>  					 SDHCI_TRNS_DMA)
> +#define SDHCI_TEGRA_STREAMID_MASK			0xff
> +#define SDHCI_TEGRA_WRITE_STREAMID_SHIFT		0x8
>  
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> @@ -177,6 +183,7 @@ struct sdhci_tegra {
>  	bool enable_hwcq;
>  	unsigned long curr_clk_rate;
>  	u8 tuned_tap_delay;
> +	u32 streamid;
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -1564,6 +1571,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>  		    NVQUIRK_ENABLE_SDR50 |
>  		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_PROGRAM_STREAMID |
>  		    NVQUIRK_HAS_TMCLK,
>  	.min_tap_delay = 95,
>  	.max_tap_delay = 111,
> @@ -1636,6 +1644,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_tegra *tegra_host;
> +	struct iommu_fwspec *fwspec;
>  	struct clk *clk;
>  	int rc;
>  
> @@ -1775,6 +1784,23 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto err_add_host;
>  
> +	/* Program MC streamID for DMA transfers */
> +	if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +		fwspec = dev_iommu_fwspec_get(&pdev->dev);
> +		if (fwspec == NULL) {
> +			dev_warn(mmc_dev(host->mmc),
> +				"iommu fwspec is NULL, continue without stream ID\n");
> +		} else {
> +			tegra_host->streamid = fwspec->ids[0] & 0xffff;

As the robot pointed out 'ids' does not necessarily exist.  Looking at
include/linux/iommu.h, it seems to depend on CONFIG_IOMMU_API

> +			tegra_sdhci_writel(host, (tegra_host->streamid &
> +						SDHCI_TEGRA_STREAMID_MASK) |
> +						((tegra_host->streamid <<
> +						SDHCI_TEGRA_WRITE_STREAMID_SHIFT)
> +						& SDHCI_TEGRA_STREAMID_MASK),
> +						SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +		}
> +	}
> +
>  	return 0;
>  
>  err_add_host:
> @@ -1861,6 +1887,8 @@ static int sdhci_tegra_suspend(struct device *dev)
>  static int sdhci_tegra_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
>  	ret = mmc_gpio_set_cd_wake(host->mmc, false);
> @@ -1871,6 +1899,13 @@ static int sdhci_tegra_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* Re-program MC streamID for DMA transfers */
> +	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +		tegra_sdhci_writel(host, tegra_host->streamid |
> +					(tegra_host->streamid << 8),
> +					SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +	}
> +
>  	ret = sdhci_resume_host(host);
>  	if (ret)
>  		goto disable_clk;

