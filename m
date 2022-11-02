Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B274F616112
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiKBKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKBKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:42:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079CDA8;
        Wed,  2 Nov 2022 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667385751; x=1698921751;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=41ekdGX94sGrdL7Y9CpsvKlQT10EsJz+L8UI/Z/dwJk=;
  b=A+9R/7mAHMwWhSyBkC6Gv4H1Zzne1TyOaIiMrllnhjU2fxG5lnzmz0y9
   wtq70KQ7oXou5eVkDQsio+gOn1yZiEJqX/aJLXGAFQSBWNCV+zIlsa7+2
   EUuicjEPIQpiYYAZkO/ruhUZHiE1Yd/u39OY5fAuEIYJceRAZndZcH57B
   d+ERUbHBnj7wxFr24ONxL/kqv6f5a7T+xX465bvrzSFlm1UpNjQjcbf4K
   FK54g9ZBRmnbbYlMxQYYba1sB/VMk+ubE6YmnXuEiidDTBWRD+XafNyUv
   Bgz5uRwM/To3TTd/LEyTiW0QqIfkLTUWZbr+J3DlNevg/4KmCNRVks05g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="311091757"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="311091757"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:42:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="963479750"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="963479750"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.170])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:42:29 -0700
Message-ID: <bc14b1e4-2034-c70d-66b9-47da89726037@intel.com>
Date:   Wed, 2 Nov 2022 12:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] mmc: sdhci_am654: Use dev_err_probe() for mmc_of_parse()
 return code
Content-Language: en-US
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101105242.2019036-1-matthias.schiffer@ew.tq-group.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221101105242.2019036-1-matthias.schiffer@ew.tq-group.com>
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

On 1/11/22 12:52, Matthias Schiffer wrote:
> Checking phandle references like mmc-pwrseq can result in -EPROBE_DEFER.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8f1023480e12..4e17efa8ab97 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -835,7 +835,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret) {
> -		dev_err(dev, "parsing dt failed (%d)\n", ret);
> +		dev_err_probe(dev, ret, "parsing dt failed\n");
>  		goto pm_runtime_put;
>  	}
>  

