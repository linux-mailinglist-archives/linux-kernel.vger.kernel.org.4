Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFCF617B85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKCLbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKCLbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:31:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6541B11838;
        Thu,  3 Nov 2022 04:31:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D7B1FB;
        Thu,  3 Nov 2022 04:31:10 -0700 (PDT)
Received: from [10.57.37.13] (unknown [10.57.37.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795133F5A1;
        Thu,  3 Nov 2022 04:31:00 -0700 (PDT)
Message-ID: <43093374-6b18-6e3b-dd80-008e1c2b245e@arm.com>
Date:   Thu, 3 Nov 2022 11:30:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v10 3/4] mmc: sdhci-tegra: Add support to program MC
 stream ID
Content-Language: en-GB
To:     Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, iommu@lists.linux.dev, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
 <20221103043852.24718-3-pshete@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221103043852.24718-3-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-03 04:38, Prathamesh Shete wrote:
> SMMU clients are supposed to program stream ID from
> their respective address spaces instead of MC override.
> Define NVQUIRK_PROGRAM_STREAMID and use it to program
> SMMU stream ID from the SDMMC client address space.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index a6c5bbae77b4..e44060cceb68 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -25,6 +25,8 @@
>   #include <linux/mmc/slot-gpio.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/ktime.h>
> +#include <linux/iommu.h>
> +#include <linux/bitops.h>
>   
>   #include <soc/tegra/common.h>
>   
> @@ -94,6 +96,8 @@
>   #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>   #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
>   
> +#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
> +
>   #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
>   #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
>   #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
> @@ -121,6 +125,7 @@
>   #define NVQUIRK_HAS_TMCLK				BIT(10)
>   
>   #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
> +#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
>   
>   /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>   #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -177,6 +182,7 @@ struct sdhci_tegra {
>   	bool enable_hwcq;
>   	unsigned long curr_clk_rate;
>   	u8 tuned_tap_delay;
> +	u32 streamid;
>   };
>   
>   static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -1564,6 +1570,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
>   		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>   		    NVQUIRK_ENABLE_SDR50 |
>   		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_PROGRAM_STREAMID |
>   		    NVQUIRK_HAS_TMCLK,
>   	.min_tap_delay = 95,
>   	.max_tap_delay = 111,
> @@ -1630,6 +1637,29 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
>   	return ret;
>   }
>   
> +/* Program MC streamID for DMA transfers */
> +static void program_stream_id(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	struct iommu_fwspec *fwspec;
> +
> +	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +		fwspec = dev_iommu_fwspec_get(dev);
> +		if (!fwspec) {
> +			dev_warn(mmc_dev(host->mmc),
> +				"iommu fwspec is NULL, continue without stream ID\n");

Not sure that really warrants a warning - if there's no IOMMU driver 
present then StreamIDs are going to be irrelevant anyway. And repeating 
the same warning on every PM resume seems even less useful.

> +		} else {
> +			tegra_host->streamid = fwspec->ids[0] & 0xff;
> +			tegra_sdhci_writel(host, tegra_host->streamid |

Why bother storing streamid in tegra_host if it's never consumed from 
anywhere other than the same place it's assigned?

Robin.

> +						FIELD_PREP(GENMASK(15, 8),
> +						tegra_host->streamid),
> +						SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +		}
> +	}
> +}
> +
>   static int sdhci_tegra_probe(struct platform_device *pdev)
>   {
>   	const struct sdhci_tegra_soc_data *soc_data;
> @@ -1775,6 +1805,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>   	if (rc)
>   		goto err_add_host;
>   
> +	program_stream_id(&pdev->dev);
> +
>   	return 0;
>   
>   err_add_host:
> @@ -1871,6 +1903,8 @@ static int sdhci_tegra_resume(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> +	program_stream_id(dev);
> +
>   	ret = sdhci_resume_host(host);
>   	if (ret)
>   		goto disable_clk;
