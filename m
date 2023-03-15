Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3053F6BADB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjCOKa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjCOKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:30:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44276041;
        Wed, 15 Mar 2023 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678876222; x=1710412222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=koy75pOMUC4CmOYWRalv4I1n/wTrUR2dXgcn0rQObpo=;
  b=SE8yTPoNsnHjf+R+EWNn+Npzj/N8XZ8L4bQTT9nvAm0F9g2DXZZO6fHj
   PL9XN6lqF5Cg9ymts8Pgwn+LYzt3KRHY9bW9PJHBuYICm9zY2JeIU4lbg
   juBNvPHKC/XNDm+KrEda9kVV5fryd3OVeBw2DL0MPVWKK81azxt+0pdOw
   S6iCMyYJMrLknKO6r5tDznukdCGyaeO4OBGJQIKDEE1/7/KhbqU1uoGy4
   3VmA/fYpvwRBm0DNZ0lK3z0AZ5Ss1bBoTzwRg52fFIyxc0ZWDR8Zx/CGa
   QFS8QAGnz+3mkX18k592ZgwjdQzKAhzuNRKc57Dg0sGd5RnS+8CiQVC82
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="335153206"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="335153206"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 03:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="629411290"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="629411290"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 03:30:19 -0700
Message-ID: <fe0ea8fa-6b24-6bec-1957-5057e34c3c60@intel.com>
Date:   Wed, 15 Mar 2023 12:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit
 for data
Content-Language: en-US
To:     Georgii Kruglov <georgy.kruglov@yandex.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230314220619.41242-1-georgy.kruglov@yandex.ru>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230314220619.41242-1-georgy.kruglov@yandex.ru>
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

On 15/03/23 00:06, Georgii Kruglov wrote:
> If spec_reg is equal to 'SDHCI_PRESENT_STATE', esdhc_readl_fixup()
> fixes up register value and returns it immediately. As a result, the
> further block
> (spec_reg == SDHCI_PRESENT_STATE)
>     &&(esdhc->quirk_ignore_data_inhibit == true),
> is never executed.
> 
> The patch merges the second block into the first one.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1f1929f3f2fa ("mmc: sdhci-of-esdhc: add quirk to ignore command inhibit for data")
> Signed-off-by: Georgii Kruglov <georgy.kruglov@yandex.ru>

Minor comment, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 4712adac7f7c..cdbf1b6e1313 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -133,6 +133,7 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  			return ret;
>  		}
>  	}
> +
>  	/*
>  	 * The DAT[3:0] line signal levels and the CMD line signal level are
>  	 * not compatible with standard SDHC register. The line signal levels
> @@ -144,6 +145,16 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  		ret = value & 0x000fffff;
>  		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
>  		ret |= (value << 1) & SDHCI_CMD_LVL;
> +
> +		/*
> +		 * Some controllers have unreliable Data Line Active
> +		 * bit for commands with busy signal. This affects
> +		 * Command Inhibit (data) bit. Just ignore it since
> +		 * MMC core driver has already polled card status
> +		 * with CMD13 after any command with busy siganl.
> +		 */
> +		if (esdhc->quirk_ignore_data_inhibit == true)

Might as well drop the redundant '== true'

> +			ret &= ~SDHCI_DATA_INHIBIT;
>  		return ret;
>  	}
>  
> @@ -158,19 +169,6 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  		return ret;
>  	}
>  
> -	/*
> -	 * Some controllers have unreliable Data Line Active
> -	 * bit for commands with busy signal. This affects
> -	 * Command Inhibit (data) bit. Just ignore it since
> -	 * MMC core driver has already polled card status
> -	 * with CMD13 after any command with busy siganl.
> -	 */
> -	if ((spec_reg == SDHCI_PRESENT_STATE) &&
> -	(esdhc->quirk_ignore_data_inhibit == true)) {
> -		ret = value & ~SDHCI_DATA_INHIBIT;
> -		return ret;
> -	}
> -
>  	ret = value;
>  	return ret;
>  }

