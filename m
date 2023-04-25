Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5BC6EE808
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjDYTJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDYTJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:09:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375C4EC5;
        Tue, 25 Apr 2023 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682449742; x=1713985742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IkzakWAuXj34HRebZUnZn8CkJY1BxzjaueXh9MF6O2U=;
  b=jErurDDwYsl7/cSN9UUbREl/QR8iqm9Kg0MyP0kHvdDJRJtr6acEJ/pH
   fmZpNPVPi21tFQRQoE5UVXrwuNHW5xtK7FIIJVsB/eCqUR7r4sH83zaw7
   CkVtJyYq8kwHS9V8kZuKiEZgrp0cYgq0VQWOVgeJ3dVaLOaG8PvhSMzmQ
   lRxSkBn1/Q0snjAfAIgahRvBYVasMoJphu9xjcgXX1VGUFwrL/Su5P1Zr
   Rc0j5fxN+B2IeHR1Qr774PlmUyiOnrHnLvus36LJJbAzMaFZnnc/R57xC
   BFC3jr4tkJdMOn8nlaEaskaMjf1mnyg0rxGSgk37km5CK5RSINouVb6iL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="346896026"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="346896026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 12:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="805185256"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="805185256"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.232])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 12:04:26 -0700
Message-ID: <80f4ba1d-ab8f-ce22-267e-0d49c8b90a1e@intel.com>
Date:   Tue, 25 Apr 2023 22:04:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] mmc: sdhci-cadence: Fix an error handling path in
 sdhci_cdns_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Brad Larson <blarson@amd.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <f61599a9ef23767c2d66e5af9c975f05ef1cec6b.1682430069.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <f61599a9ef23767c2d66e5af9c975f05ef1cec6b.1682430069.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/23 16:41, Christophe JAILLET wrote:
> If devm_reset_control_get_optional_exclusive() fails, some resources still
> need to be released. So branch to the error handling path instead of
> returning directly.
> 
> Fixes: aad53d4ee756 ("mmc: sdhci-cadence: Support mmc hardware reset")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index b24aa27da50c..d2f625054689 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -540,9 +540,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	if (host->mmc->caps & MMC_CAP_HW_RESET) {
>  		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
> -		if (IS_ERR(priv->rst_hw))
> -			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> -					     "reset controller error\n");
> +		if (IS_ERR(priv->rst_hw)) {
> +			ret = dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> +					    "reset controller error\n");
> +			goto free;
> +		}
>  		if (priv->rst_hw)
>  			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
>  	}

