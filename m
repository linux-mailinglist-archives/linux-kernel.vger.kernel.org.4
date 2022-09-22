Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21125E612F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiIVLeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiIVLd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:33:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7AE21D4;
        Thu, 22 Sep 2022 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663846438; x=1695382438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=scPFUuWd4dXehmWCDyPhwyYEXQRF9fa/4bJpP2nc7xo=;
  b=anF/qATwr3+6yY0k+K5hixPB0O+xBODuFJgpwHTgkgTRovcjdyzTzgYK
   LmiphPN+Lmq1nG6+Jinwp/q3EPzKhYEetpC5ECSQa49979KfdKaDBjLNl
   mUcc2kNisu7wj2jsv/lqNA79+OsFvFCg+zd2GZXDS6VuBkmN9oe8BfoWq
   V4LMBJz7PLMH40MsU4lTcvYo9mpZKh64S2kpBe4y/nNC7yE3Zp4zKbCWx
   Gcn7pI4sM4av2bniBtz8XnCKD/9x+qOu9dBriDbqENfy9sRQxWWblNCOE
   w60JP4WofiXABL50DKldpGOP8r+4mtCBpwHN1fg2lppaXIVGkAqs3Svzq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301118662"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301118662"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:33:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570927907"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:33:51 -0700
Message-ID: <31458181-a30f-8f85-f19c-084fdda5106b@intel.com>
Date:   Thu, 22 Sep 2022 14:33:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/4] mmc: sdhci-tegra: Use actual clock rate for SW
 tuning correction
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <20220920123752.21027-1-pshete@nvidia.com>
 <20220920123752.21027-4-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220920123752.21027-4-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/22 15:37, Prathamesh Shete wrote:
> Ensure tegra_host member "curr_clk_rate" holds the actual clock rate
> instead of requested clock rate for proper use during tuning correction
> algorithm. Actual clk rate may not be the same as the requested clk
> frequency depending on the parent clock source set. Tuning correction
> algorithm depends on certain parameters which are sensitive to current
> clk rate. If the host clk is selected instead of the actual clock rate,
> tuning correction algorithm may end up applying invalid correction,
> which could result in errors
> 
> Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 58449e010a9b..10f6df070456 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -780,7 +780,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
>  			host_clk, err);
>  
> -	tegra_host->curr_clk_rate = host_clk;
> +	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
>  	if (tegra_host->ddr_signaling)
>  		host->max_clk = host_clk;
>  	else

