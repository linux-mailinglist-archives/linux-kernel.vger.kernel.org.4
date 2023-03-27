Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90E46CAD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjC0ScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0ScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:32:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE030F2;
        Mon, 27 Mar 2023 11:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2325D61476;
        Mon, 27 Mar 2023 18:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE078C433D2;
        Mon, 27 Mar 2023 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941934;
        bh=+Mk0pjh0wJ3hTFRbtAIuBDh/ZYce47JBxftVw5y2atg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBUTmFmVbFbSrmJtcmyQERwSPVg1qVIlVtGepAvFbWFOJUtiUTkjDmMUB560hWevI
         16gDyl7D6lwnuQhyFYOONKB++0YB5Frd+g9JTfXdgBI38rmtKpz5f1H28XI4lwYXSU
         4Rcn5fhZYqfB1HlonoFo3rKH3T9kN/6DNmxoiRnBk5l2/3BHwCRV/+G1GyAhFQA7FY
         yVKYp0S9SaNrMo+8U0IxZQQ9JWJoYpaZECnNT8opE4J1t1Dd0PgksRkmwRuFgToITm
         /yD/4LO6pZW/c7VUx95otyo2HGU69vlgnRJCd3xEuEYQsVnNYWWWkE+peaDSOPl2WG
         i8zju8I4/fQLA==
Date:   Mon, 27 Mar 2023 11:32:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mmc: sdhci-msm: Switch to the new ICE API
Message-ID: <20230327183211.GA73752@sol.localdomain>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327134734.3256974-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:47:33PM +0300, Abel Vesa wrote:
> Now that there is a new dedicated ICE driver, drop the sdhci-msm ICE
> implementation and use the new ICE api provided by the Qualcomm soc
> driver ice. The platforms that already have ICE support will use the
> API as library since there will not be a devicetree node, but instead
> they have reg range. In this case, the of_qcom_ice_get will return an
> ICE instance created for the consumer's device. But if there are
> platforms that do not have ice reg in the consumer devicetree node
> and instead provide a dedicated ICE devicetree node, theof_qcom_ice_get
> will look up the device based on qcom,ice property and will get the ICE
> instance registered by the probe function of the ice driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v3 (RFC) is here:
> https://lore.kernel.org/all/20230313115202.3960700-7-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * added back the checks for and the setting of MMC_CAP2_CRYPTO 
>  * added enable/resume/suspend implementation for !CONFIG_MMC_CRYPTO
>  * dropped cfg->crypto_cap_idx argument from qcom_ice_program_key
> 
> Changes since v2:
>  * added the suspend API call for ICE
>  * kept old wrappers over ICE API in
> 
> Changes since v1:
>  * Added a check for supported algorithm and key size
>    and passed the ICE defined values for algorithm and key size
>  * Added call to evict function
> 
>  drivers/mmc/host/Kconfig     |   2 +-
>  drivers/mmc/host/sdhci-msm.c | 220 +++++++----------------------------
>  2 files changed, 46 insertions(+), 176 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4745fe217ade..09f837df5435 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -549,7 +549,7 @@ config MMC_SDHCI_MSM
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_SDHCI_IO_ACCESSORS
>  	select MMC_CQHCI
> -	select QCOM_SCM if MMC_CRYPTO
> +	select QCOM_INLINE_CRYPTO_ENGINE if MMC_CRYPTO
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in Qualcomm SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ac81d57a3df..1a6e63b7af12 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -19,6 +19,8 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>  
> +#include <soc/qcom/ice.h>
> +
>  #include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -258,12 +260,14 @@ struct sdhci_msm_variant_info {
>  struct sdhci_msm_host {
>  	struct platform_device *pdev;
>  	void __iomem *core_mem;	/* MSM SDCC mapped address */
> -	void __iomem *ice_mem;	/* MSM ICE mapped address (if available) */
>  	int pwr_irq;		/* power irq */
>  	struct clk *bus_clk;	/* SDHC bus voter clock */
>  	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
> -	/* core, iface, cal, sleep, and ice clocks */
> -	struct clk_bulk_data bulk_clks[5];
> +	/* core, iface, cal and sleep clocks */
> +	struct clk_bulk_data bulk_clks[4];
> +#ifdef CONFIG_MMC_CRYPTO
> +	struct qcom_ice *ice;
> +#endif

Similarly to the UFS patch, it is not clear that the calls to
clk_prepare_enable() and clk_disable_unprepare() on the ICE clock are paired up
anymore, with qcom_ice_enable() in particular seeming to be unpaired.  Perhaps
it should continue to be enabled / disabled at the same time as the other host
controller clocks are enabled / disabled?

Also, are you sure that the ICE clock is actually being found?
drivers/soc/qcom/ice.c does:

        engine->core_clk = devm_clk_get(dev, NULL);
        if (IS_ERR(engine->core_clk))
                return ERR_CAST(engine->core_clk);

It is not clear how that can get the clock named "ice" from the device tree.

- Eric
