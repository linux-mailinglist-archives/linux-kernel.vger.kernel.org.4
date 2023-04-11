Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA8D6DD7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDKKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDKKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:14:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918C3C2A;
        Tue, 11 Apr 2023 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681208081; x=1712744081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bDBts12O8Hga+LiDSp0Aczq4WnDcr6E4Vx4zdmSN5JE=;
  b=GZsVUypiwqVUm83Q2FazKAqswpiTNor4wMTXSeiKEwnZjevipAc3oWZ5
   0auEzsqCPGmTwcquxdYF7txlj770FN308rb9kMnNxC/7hELWwxOg6uV6C
   cxbFMIh8skyksWthuN09V4FPEdYalJDzDRmBAkcu8wvI30MVGurOMRpFM
   R7edw96Q40ArCfyvdkHlLdkkOe9bll0q7UpC1LA6WLuoZEhcuHITENxdR
   SiqrIMx2WZlhLaj9+7L2kbM9v91QnZVINGJ0YCcw0QHo4p0GVAE2ynndQ
   nNAJS1Xo76tU0Pk2y4WVdmJezgWa8d64ujxgnY4e0Hniux2PUGXFFDUvN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341070733"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341070733"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 03:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="862816046"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="862816046"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.57])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 03:14:37 -0700
Message-ID: <3c57dc23-5b97-7cc1-8d88-1bed91119bea@intel.com>
Date:   Tue, 11 Apr 2023 13:14:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 3/3] mmc: sdhci-of-arasan: Skip setting clock delay for
 400KHz
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, saikrishna12468@gmail.com
References: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
 <20230403102551.3763054-4-sai.krishna.potthuri@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230403102551.3763054-4-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/04/23 13:25, Sai Krishna Potthuri wrote:
> Clock delay settings are not defined for 400KHz, so add frequency check
> to skip calling the clock delay settings when frequency is <=400KHz.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c3fecb8ba66e..d9a29c346745 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -413,7 +413,7 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  
>  	/* Set the Input and Output Clock Phase Delays */
> -	if (clk_data->set_clk_delays)
> +	if (clk_data->set_clk_delays && clock > PHY_CLK_TOO_SLOW_HZ)
>  		clk_data->set_clk_delays(host);
>  
>  	if (sdhci_arasan->internal_phy_reg && clock >= MIN_PHY_CLK_HZ) {

