Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F46B817D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCMTMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:12:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB174DF3;
        Mon, 13 Mar 2023 12:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8195DB811F6;
        Mon, 13 Mar 2023 19:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7487DC433D2;
        Mon, 13 Mar 2023 19:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734722;
        bh=IVDgfKAQZ0w5301p0w3BbGALyvvYzkF8QyVAt5Y/nIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Odakj7/vYDs35YmtBP3vZyH4iq7V+YQwNLC21xdCSEbDGUxzCmQ1OMtdGr85MnQZS
         U+JFUJ3Hn12loJqLSiJVn67FN3Y8brW//6ty5+o78UqIGSItramVn3lrtgFjj9F81F
         0cRcc9s/YtphtBsQNvAon4Gz2Zz7rFdxuNQxEYX8MICZbIEQGS6NwnTL3BqeXhBp2O
         TdRIOgflS2NZyhnfohqahNPSO3kv1UWDKDBVn4n/wKm5xEVgKXEDbNi2ByypaToEJy
         UoAbaHX+id+TPaxgut7WOI2V+q2d3dNKOBbOAUGjINsqwOYCGrpVp02sMM45/yujNS
         3Aar9Jk2s1nMQ==
Date:   Mon, 13 Mar 2023 12:11:59 -0700
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
Subject: Re: [RFC PATCH v3 6/7] mmc: sdhci-msm: Switch to the new ICE API
Message-ID: <ZA91f2De7QmeMUZn@sol.localdomain>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
 <20230313115202.3960700-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313115202.3960700-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:52:01PM +0200, Abel Vesa wrote:
>  static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  			      struct cqhci_host *cq_host)
>  {
>  	struct mmc_host *mmc = msm_host->mmc;
>  	struct device *dev = mmc_dev(mmc);
> -	struct resource *res;
> -
> -	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
> -		return 0;
> -
> -	res = platform_get_resource_byname(msm_host->pdev, IORESOURCE_MEM,
> -					   "ice");
> -	if (!res) {
> -		dev_warn(dev, "ICE registers not found\n");
> -		goto disable;
> -	}
> +	int ret = 0;
>  
> -	if (!qcom_scm_ice_available()) {
> -		dev_warn(dev, "ICE SCM interface not found\n");
> -		goto disable;
> +	if (cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS) {
> +		msm_host->ice = of_qcom_ice_get(dev);
> +		if (IS_ERR(msm_host->ice))
> +			ret = PTR_ERR(msm_host->ice);
>  	}
>  
> -	msm_host->ice_mem = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(msm_host->ice_mem))
> -		return PTR_ERR(msm_host->ice_mem);
> -
> -	if (!sdhci_msm_ice_supported(msm_host))
> -		goto disable;
> -
> -	mmc->caps2 |= MMC_CAP2_CRYPTO;
> -	return 0;
> -
> -disable:
> -	dev_warn(dev, "Disabling inline encryption support\n");
> -	return 0;
> -}

It looks like the line 'mmc->caps2 |= MMC_CAP2_CRYPTO;' got lost?  This patch
can't work without it.

- Eric
