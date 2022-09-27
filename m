Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C55EBFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiI0KXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiI0KXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:23:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41D2D33E8;
        Tue, 27 Sep 2022 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664274229; x=1695810229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ofx1Bmq4kGC4d7mEXYqs/xwy7YNmj9WK6n97eV1vIn4=;
  b=HJwwmOWrBwCa7dOYwXMOyhudlZI5PSCcQAGjEAknvqiMGGKIdhYUUJpS
   AUwZ1nzyrPUVbjs84MQfHNkVTjde+SROzgB6WFZ9Wyb/rFtGEnZzgsPsO
   lPmPl9cVii13bnryda1rLNB+xwLIrfAkdpMhg1OdQwg7nQITXqo3a1vBd
   SuIzAWSE8WUDy78tOIwG936qkRVEhMeiS2RkSu2TLFT2xnipd8RJNOrI7
   2C0ERvA8GY3WH4QDyOayYFONGwq0VDSBxcHa1og1BKTZ3zP+g3FMsjf2z
   +jhXf9UZ6QznEBZwXPyCemtG75oAQf6vPT3iXod1b1MdfkjWunwz65KZO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280999870"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="280999870"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 03:23:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="623709159"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="623709159"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 03:23:45 -0700
Message-ID: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
Date:   Tue, 27 Sep 2022 13:23:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <91f09a39-57fa-06a9-6e9e-b3e768d9e26a@intel.com>
 <20220927100946.19482-1-pshete@nvidia.com>
 <20220927100946.19482-3-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220927100946.19482-3-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/22 13:09, Prathamesh Shete wrote:
> In case of error condition to avoid system crash
> Tegra SDMMC controller requires CMD and DAT resets
> issued together. SDHCI controller FSM goes into
> bad state due to rapid SD card hot-plug event.
> Issuing reset on the CMD FSM before DATA FSM results
> in kernel panic, hence add support to issue CMD and
> DAT resets together.
> This is applicable to Tegra186 and later chips.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ++-
>  drivers/mmc/host/sdhci.c       | 8 +++++++-
>  drivers/mmc/host/sdhci.h       | 2 ++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 46f37cc26dbb..61dc5ee0726d 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1536,7 +1536,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
>  	.ops  = &tegra186_sdhci_ops,
>  };
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2b5dda521b0e..5123ec3fc74a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -266,12 +266,14 @@ enum sdhci_reset_reason {
>  	SDHCI_RESET_FOR_TUNING_ABORT,
>  	SDHCI_RESET_FOR_CARD_REMOVED,
>  	SDHCI_RESET_FOR_CQE_RECOVERY,
> +	SDHCI_RESET_FOR_CMD_DAT_TOGETHER,
>  };
>  
>  static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
>  {
>  	switch (reason) {
>  	case SDHCI_RESET_FOR_INIT:
> +	case SDHCI_RESET_FOR_CMD_DAT_TOGETHER:
>  		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  		break;
>  	case SDHCI_RESET_FOR_REQUEST_ERROR:
> @@ -3084,7 +3086,11 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  			/* This is to force an update */
>  			host->ops->set_clock(host, host->clock);
>  
> -		sdhci_reset_for(host, REQUEST_ERROR);
> +		if (host->quirks2 &
> +			SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER)
> +			sdhci_reset_for(host, CMD_DAT_TOGETHER);
> +		else
> +			sdhci_reset_for(host, REQUEST_ERROR);

This is what I am trying to avoid because it is inconsistent.
Consider:
 - why is the quirk needed for some REQUEST_ERRORs but not others?
 - or why is the quirk not needed for all CMD / DAT resets?

So, I was expecting the quirk to be applied in sdhci_reset_for_reason()
not here.

>  
>  		host->pending_reset = false;
>  	}
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d750c464bd1e..6a5766774b05 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -478,6 +478,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Issue CMD and DATA reset together */
> +#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */

