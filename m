Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E56B3D61
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCJLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJLLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:11:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2AAF209B;
        Fri, 10 Mar 2023 03:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678446696; x=1709982696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kGzQUVv6UsDRDCHHTyUvwV4Iq1BLrr/jOo6saAGlNRQ=;
  b=iTX30Do5YgP53/EHJgnX4RqMOFPcpS4Qyu1iffDX/Z7oLp0AHEOfkYXK
   /dsuUyfPUV5EinjKiVY7XCxLFN0vWBkDVlbQE4gTHqv07aLf9EZRZdLHc
   jMRur82TZBwlbzPzpBllOzBJdvE6BOGOCq7EeUhPOkNf//eGJe+LHGt4j
   QO14w6MAvxzDxWP8IeFayZc3pBKfVilwEKwp9zYbwifuF3pWSGv6o2Med
   +01dFHu4WGAP4GBIo19vqkn0w/jAqoD+7QYSuRkJUMhGdlgmOBoz2nXhd
   edO+fxy7H+WlA+X9JiWC1dCgkMFe4jqIR4+41Cr7NbNra6BLcCHRfuMpJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399303440"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399303440"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:11:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="671051054"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="671051054"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:11:19 -0800
Message-ID: <8efb1736-7bbb-3ec6-d7f0-fc781edb6a4c@intel.com>
Date:   Fri, 10 Mar 2023 13:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v10 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-15-blarson@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230306040739.51488-15-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/23 06:07, Brad Larson wrote:
> Add support for mmc hardware reset using a reset-controller
> that would need to be enabled in the device tree with
> a supporting driver.  The default is disabled for all
> existing designs.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> v9 changes:
> - Previously patch 17/17
> - Changed delay after reset_control_assert() from 9 to 3 usec
> - Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()
> 
> ---
>  drivers/mmc/host/sdhci-cadence.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 31c77d32aa7d..d13081da5e30 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -12,6 +12,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/reset.h>
>  
>  #include "sdhci-pltfm.h"
>  
> @@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
>  	spinlock_t wrlock;	/* write lock */
>  	bool enhanced_strobe;
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
> +	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
>  	struct sdhci_cdns_phy_param phy_params[];
>  };
> @@ -460,6 +462,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
>  }
>  
> +static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +
> +	dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
> +
> +	reset_control_assert(priv->rst_hw);
> +	/* For eMMC, minimum is 1us but give it 3us for good measure */
> +	udelay(3);
> +
> +	reset_control_deassert(priv->rst_hw);
> +	/* For eMMC, minimum is 200us but give it 300us for good measure */
> +	usleep_range(300, 1000);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> @@ -523,6 +541,15 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> +	if (host->mmc->caps & MMC_CAP_HW_RESET) {
> +		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
> +		if (IS_ERR(priv->rst_hw))
> +			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> +					     "reset controller error\n");
> +		if (priv->rst_hw)
> +			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
> +	}
> +
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto free;

