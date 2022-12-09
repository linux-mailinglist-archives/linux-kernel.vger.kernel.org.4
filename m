Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8335647E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLIHXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLIHXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:23:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0A5B1F4;
        Thu,  8 Dec 2022 23:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670570593; x=1702106593;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XPPDfsuC7Y1m/jmxmWIq0LVJoHQFxJM6TafM/RGZGhM=;
  b=WRi5c4+wWVgB/hjIRBONBAEQ1Wn6VwQG89J5DN7wPKQk5RZof0rH5VlX
   KUz+IkbYh/UAVF3u0aTpQwz15vyio5TyfbdLfZDwJT3A+C2DUGkZoQGIe
   +4/smAzJdhWzR2L0aJaAPx1H1zATdU4ROqLiHn70fgyE90h9FsVTwB27w
   MgJ7B+aX/19F4Pd7hMcS01vEGUVR7rILDCYMNJH2Qh/to0gh/nExoD1Jx
   6wpQ0KZ6ZodmjV41PWFz9eSHx8fkBm5+pqb9fqfe0BBYN7b951kmZXpIB
   eH29hAj+FYLgvXlMCk8NbzkH1OiNq0M3be0CXu+TGNqVij1Fu7vRIVF7u
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="381707921"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="381707921"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 23:23:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="715935677"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="715935677"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.86])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 23:23:08 -0800
Message-ID: <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
Date:   Fri, 9 Dec 2022 09:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
 <20221205105931.410686-4-vadym.kochan@plvision.eu>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221205105931.410686-4-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 12:59, Vadym Kochan wrote:
> There is a limitation on AC5 SoC that mmc controller
> can't have DMA access over 2G memory, so use SDMA with
> a bounce buffer. Swiotlb can't help because on arm64 arch
> it reserves memblock's at the end of the memory.
> 
> Additionally set mask to 34 bit since on AC5 SoC RAM starts
> at 0x2_00000000.

Can you explain more about how a 34-bit DMA mask works when
SDMA only supports 32-bit addresses?

> 
> Co-developed-by: Elad Nachman <enachman@marvell.com>
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 08e838400b52..5f3db0425674 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -13,7 +13,9 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/ktime.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pm.h>
> @@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
>  		return pltfm_host->clock;
>  }
>  
> +static int xenon_set_dma_mask(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_host *mmc = host->mmc;
> +	struct device *dev = mmc_dev(mmc);
> +
> +	if (priv->hw_version == XENON_AC5) {
> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> +
> +		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> +	}
> +
> +	return sdhci_set_dma_mask(host);
> +}
> +
>  static const struct sdhci_ops sdhci_xenon_ops = {
>  	.voltage_switch		= xenon_voltage_switch,
>  	.set_clock		= sdhci_set_clock,
> @@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
>  	.reset			= xenon_reset,
>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
>  	.get_max_clock		= xenon_get_max_clock,
> +	.set_dma_mask		= xenon_set_dma_mask,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
> @@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
>  	xenon_disable_sdhc(host, sdhc_id);
>  }
>  
> +static int xenon_ac5_probe(struct sdhci_host *host)
> +{
> +	struct sysinfo si;
> +
> +	si_meminfo(&si);
> +
> +	if ((si.totalram * si.mem_unit) > SZ_2G)
> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +	return 0;
> +}
> +
>  static int xenon_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (priv->hw_version == XENON_AC5) {
> +		err = xenon_ac5_probe(host);
> +		if (err)
> +			goto err_clk_axi;
> +	}
> +
>  	err = mmc_of_parse(host->mmc);
>  	if (err)
>  		goto err_clk_axi;
> @@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 3e9c6c908a79..0460d97aad26 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -57,7 +57,8 @@ enum xenon_variant {
>  	XENON_A3700,
>  	XENON_AP806,
>  	XENON_AP807,
> -	XENON_CP110
> +	XENON_CP110,
> +	XENON_AC5
>  };
>  
>  struct xenon_priv {

