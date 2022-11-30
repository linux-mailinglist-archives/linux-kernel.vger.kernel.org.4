Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2963D960
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiK3PYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiK3PYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:24:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9551769F1;
        Wed, 30 Nov 2022 07:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669821858; x=1701357858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oti4OnCEJPQwwRBrgmf0ykISS2XQFxLXOCWscviFvv8=;
  b=GyMUdYR6FVBH+jEaAd2qXzGsmcjIKBaT4cZu30K111zEFnTb94t4gHIf
   N2DpJZ81l/BBJX4RI/0rpRhmTmg/MB1PCU7+8ak7NI/iY+GyuDLAkZpjm
   0Cg/uI3jOI1ci/dHnPrJJ2V5YWeiguPb12A0Qsm6q+NDFXiPr6d6qtFZG
   v8HBnaHr8RavFQvW5BzaJWqb62pW2YVS/1DNaTksdQuUZcaSs/A42s5Rx
   gB9iID2AouTYWWUzdzNN3//4DCwn4jGNjNfe2m9N00H83dlcNtKl99JSS
   ufQyTJ1fh69fkKnUa5RvDOzxfyQWoBUZBuxih7vJ4Hm4S0bnrUXYdALcG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342343336"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="342343336"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:23:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733020433"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="733020433"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.75])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:23:50 -0800
Message-ID: <6e259e6d-3821-0f2c-f308-5f5eb6550b6d@intel.com>
Date:   Wed, 30 Nov 2022 17:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2] mmc: sdhci-sprd: Fix no reset data and command after
 voltage switch
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        gengcixi@gmail.com
References: <20221130121328.25553-1-wenchao.chen@unisoc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221130121328.25553-1-wenchao.chen@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/22 14:13, Wenchao Chen wrote:
> After switching the voltage, no reset data and command will cause
> CMD2 timeout.
> 
> Fixes: 29ca763fc26f ("mmc: sdhci-sprd: Add pin control support for voltage switch")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> 
> v1 -> v2:
> There is no need to wait for the state of the pin to stabilize.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index b92a408f138d..bec3f9e3cd3f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -470,7 +470,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  	}
>  
>  	if (IS_ERR(sprd_host->pinctrl))
> -		return 0;
> +		goto reset;
>  
>  	switch (ios->signal_voltage) {
>  	case MMC_SIGNAL_VOLTAGE_180:
> @@ -498,6 +498,8 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	/* Wait for 300 ~ 500 us for pin state stable */
>  	usleep_range(300, 500);
> +
> +reset:
>  	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  
>  	return 0;

