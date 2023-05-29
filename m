Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F9714C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjE2PAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjE2PA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:00:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A597E4;
        Mon, 29 May 2023 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685372427; x=1716908427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AOOSBy8j9IN+drBBdgWRoFkQWz5B0UzI5mBVYtiFNf8=;
  b=Y2104u2/k2BhaXFEHqB64F4dbKMczWdB3OpQyLdqsagiwmWCxVCmA8a+
   VMi2MEa7PPhNQZ41Y1IDJyzA4O3czqlDALaSTBqK8xHEUXWMy8eRIC1Mp
   7VFBTL2CqLFTLt+KgAe0G3H4a7lCFcfixA3jGjrBJGnb/2WBnor1kgAKI
   qxoL/nViUWw2IQ2BBLmrQWtIVN95i2wwTvBoXo8jZnEy+gU5zQcEt0BSC
   XckT/pdLiUbRX5Xbe3AbqJWgYRB9cGCg0iqlvXtwJXNxYjpXg0oRfDy2v
   5sURaUpB9DbGkLGxfpTgVRVmk5p8Q6W8Xz/nSfQDXACkal9uZH/MIDDjZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344219462"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="344219462"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830417944"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="830417944"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.110])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:00:23 -0700
Message-ID: <985a5616-9f98-9ff1-7007-d0ac77a40014@intel.com>
Date:   Mon, 29 May 2023 18:00:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
 when 64bit DMA mode is used.
Content-Language: en-US
To:     Chevron Li <chevron_li@126.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shaper.liu@bayhubtech.com, justin.wang@bayhubtech.com,
        Chevron Li <chevron.li@bayhubtech.com>
References: <20230523111114.18124-1-chevron_li@126.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230523111114.18124-1-chevron_li@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/23 14:11, Chevron Li wrote:
> From: Chevron Li <chevron.li@bayhubtech.com>
> 
> Bayhub SD host has hardware limitation:
> 1.The upper 32bit address is inhibited to be written at SD Host Register
>   [03E][13]=0 (32bits addressing) mode, is admitted to be written only at
>   SD Host Register [03E][13]=1 (64bits addressing) mode.
> 2.Because of above item#1, need to configure SD Host Register [03E][13] to
>   1(64bits addressing mode) before set 64bit ADMA system address's higher
>   32bits SD Host Register [05F~05C] if 64 bits addressing mode is used.
> 
> The hardware limitation is reasonable for below reasons:
> 1.Normal flow should set DMA working mode first, then do
>   DMA-transfer-related configuration, such as system address.
> 2.The hardware limitation may avoid the software to configure wrong higher
>   32bit address at 32bits addressing mode although it is redundant.
> 
> The change that set 32bits/64bits addressing mode before set ADMA address,
>   has no side-effect to other host IPs for below reason:
> The setting order is reasonable and standard: DMA Mode setting first and
>   then DMA address setting. It meets all DMA setting sequence.
> 
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>

It should be OK.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Change in V1:
> Set dma mode configure before set dma address
> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3241916141d7..ff41aa56564e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1167,6 +1167,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  		}
>  	}
>  
> +	sdhci_config_dma(host);
> +
>  	if (host->flags & SDHCI_REQ_USE_DMA) {
>  		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
>  
> @@ -1186,8 +1188,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  		}
>  	}
>  
> -	sdhci_config_dma(host);
> -
>  	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
>  		int flags;
>  
> 
> base-commit: cc3c44c9fda264c6d401be04e95449a57c1231c6

