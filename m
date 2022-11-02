Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9F616045
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKBJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBJ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:57:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B91F9EC;
        Wed,  2 Nov 2022 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667383037; x=1698919037;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y4JaRDQ1UjEawhCzQ3jBuUwFG5WGst8q8wXZ5tjw4Xw=;
  b=h3fkaLGkPKt5+hHpCDo02ZbcAz84gadkMICUHMFsM01COQFSuudxuqVn
   56Apw7D35Q2CxKS9Y/Nxz2eGgeTAsZPdgtIfSfVTOSwqQgVz4lQI5n71W
   WI8AokK+rpIJ6Evj3PkV2Ipprtc+Ylx4RrzdM59PBY4xmwi8oxcEVqwpt
   Gfis4XpM7F0VpTe1s5hE1fPsUY+Jv5+B/+RnfGDcVJYhgNJhgbhbGK/zm
   sKytwKUTwDN+TXJekhXfwHJh9HZbZpVgx2Wsy9X0FIQkIaFCPnRuuTR4Z
   gP7w9tXFKYTUzfo2dM8mVgaZBmFTH/gAWiIPbBmHF0lJUq0cIWwecbvTO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371453206"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371453206"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 02:57:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636722728"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="636722728"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.170])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 02:57:14 -0700
Message-ID: <54973f0b-33ab-6cbb-82ce-be769fe82bd9@intel.com>
Date:   Wed, 2 Nov 2022 11:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support for dynamic
 configuration
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, saikrishna12468@gmail.com,
        git@amd.com
References: <20221019054857.8286-1-sai.krishna.potthuri@amd.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019054857.8286-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 08:48, Sai Krishna Potthuri wrote:
> Add dynamic configuration support for Xilinx ZynqMP which takes care of
> configuring the SD secure space configuration registers using EEMI APIs,
> performing SD reset assert and deassert.
> High level sequence:
> - Check for the PM dynamic configuration support, if no error proceed with
> SD dynamic configurations(next steps) otherwise skip the dynamic
> configuration.
> - Put the SD Controller in reset.
> - Configure SD Fixed configurations.
> - Configure the SD Slot Type.
> - Configure the BASE_CLOCK.
> - Configure the 8-bit support.
> - Bring the SD Controller out of reset.
> - Wait for 1msec delay.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Can we get an Ack from xilinx folks?

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 69 ++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 3997cad1f793..f051f3802aff 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/of.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
>  
> @@ -1521,6 +1522,65 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
>  	return 0;
>  }
>  
> +static int sdhci_zynqmp_set_dynamic_config(struct device *dev,
> +					   struct sdhci_arasan_data *sdhci_arasan)
> +{
> +	struct sdhci_host *host = sdhci_arasan->host;
> +	struct clk_hw *hw = &sdhci_arasan->clk_data.sdcardclk_hw;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	const char *clk_name = clk_hw_get_name(hw);
> +	u32 mhz, node_id = !strcmp(clk_name, "clk_out_sd0") ? NODE_SD_0 : NODE_SD_1;
> +	struct reset_control *rstc;
> +	int ret;
> +
> +	/* Obtain SDHC reset control */
> +	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rstc)) {
> +		dev_err(dev, "Cannot get SDHC reset.\n");
> +		return PTR_ERR(rstc);
> +	}
> +
> +	ret = reset_control_assert(rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_FIXED, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_EMMC_SEL,
> +				      !!(host->mmc->caps & MMC_CAP_NONREMOVABLE));
> +	if (ret)
> +		return ret;
> +
> +	mhz = DIV_ROUND_CLOSEST_ULL(clk_get_rate(pltfm_host->clk), 1000000);
> +	if (mhz > 100 && mhz <= 200)
> +		mhz = 200;
> +	else if (mhz > 50 && mhz <= 100)
> +		mhz = 100;
> +	else if (mhz > 25 && mhz <= 50)
> +		mhz = 50;
> +	else
> +		mhz = 25;
> +
> +	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_BASECLK, mhz);
> +	if (ret)
> +		return ret;
> +
> +	ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_8BIT,
> +				      !!(host->mmc->caps & MMC_CAP_8_BIT_DATA));
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(rstc);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 1500);
> +
> +	return 0;
> +}
> +
>  static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>  {
>  	struct sdhci_host *host = sdhci_arasan->host;
> @@ -1685,6 +1745,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto unreg_clk;
>  	}
>  
> +	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
> +		ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_SET_SD_CONFIG);
> +		if (!ret) {
> +			ret = sdhci_zynqmp_set_dynamic_config(dev, sdhci_arasan);
> +			if (ret)
> +				goto unreg_clk;
> +		}
> +	}
> +
>  	sdhci_arasan->phy = ERR_PTR(-ENODEV);
>  	if (of_device_is_compatible(np, "arasan,sdhci-5.1")) {
>  		sdhci_arasan->phy = devm_phy_get(dev, "phy_arasan");

