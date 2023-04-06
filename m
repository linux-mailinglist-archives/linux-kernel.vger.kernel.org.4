Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE56DA296
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjDFUXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbjDFUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA267976B;
        Thu,  6 Apr 2023 13:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72BEA6434E;
        Thu,  6 Apr 2023 20:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE1BC433D2;
        Thu,  6 Apr 2023 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680812552;
        bh=QbU1tiiVtHmL+PJo3an08Q0eap2Dp32ICrXVxmaFXMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OTyOeiezNd9LajC1COfog+DUblRjvVWaWdgSE/lh87jYEAg0XWWIlzI44HlLh5Rs5
         K4Oe+I6TEL7tgVRZbgOEOpWU7nPh/6jRRa9sfhogVV9bsTJIt/Q/ktHis3mhRPBcoj
         uWdebuQBK+1WHU8qaILAHsncwVGDbE0XNVeYDUAUrlRrrzfJP3r+6cT0Ra+Vj1RVFi
         jAhfooNC9IAFxgw/7Q4jFMfauJQML0of5074/Yog2DLxSmTd+rzHSlLfdzE5+CWiLo
         lM3740EvfiGjstKT8J9TOrTXqC3mpibEGeZZUo9OglYfD/bZOvVAYRz9arLNYQXbvG
         5BLNVFSt02/Pw==
Date:   Thu, 6 Apr 2023 13:22:30 -0700
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
Subject: Re: [PATCH v5 5/6] mmc: sdhci-msm: Switch to the new ICE API
Message-ID: <20230406202230.GB20288@sol.localdomain>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
 <20230403200530.2103099-6-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403200530.2103099-6-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:05:29PM +0300, Abel Vesa wrote:
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ac81d57a3df..1a6e63b7af12 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -19,6 +19,8 @@
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>  
> +#include <soc/qcom/ice.h>

The include of <linux/firmware/qcom/qcom_scm.h> should be removed.

>  static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  			      struct cqhci_host *cq_host)
>  {
>  	struct mmc_host *mmc = msm_host->mmc;
>  	struct device *dev = mmc_dev(mmc);
> -	struct resource *res;
>  
>  	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
>  		return 0;
>  
> -	res = platform_get_resource_byname(msm_host->pdev, IORESOURCE_MEM,
> -					   "ice");
> -	if (!res) {
> -		dev_warn(dev, "ICE registers not found\n");
> -		goto disable;
> -	}
> -
> -	if (!qcom_scm_ice_available()) {
> -		dev_warn(dev, "ICE SCM interface not found\n");
> -		goto disable;
> +	msm_host->ice = of_qcom_ice_get(dev);
> +	if (msm_host->ice == ERR_PTR(-EOPNOTSUPP)) {
> +		dev_warn(dev, "Disabling inline encryption support\n");
> +		msm_host->ice = NULL;
>  	}
>  
> -	msm_host->ice_mem = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(msm_host->ice_mem))
> -		return PTR_ERR(msm_host->ice_mem);
> -
> -	if (!sdhci_msm_ice_supported(msm_host))
> -		goto disable;
> +	if (IS_ERR(msm_host->ice))
> +		return PTR_ERR(msm_host->ice);
>  
>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
> -	return 0;
>  
> -disable:
> -	dev_warn(dev, "Disabling inline encryption support\n");
>  	return 0;
>  }

This is sometimes setting MMC_CAP2_CRYPTO when ICE is unsupported.

BTW, it would be better to set not msm_host->ice until it's known that it will
have a valid value:

	ice = of_qcom_ice_get(dev);
	if (ice == ERR_PTR(-EOPNOTSUPP)) {
		dev_warn(dev, "Disabling inline encryption support\n");
		return 0;
	}
	if (IS_ERR_OR_NULL(ice))
		return PTR_ERR_OR_ZERO(ice);

	msm_host->ice = ice;
	mmc->caps2 |= MMC_CAP2_CRYPTO;
	return 0;

- Eric
