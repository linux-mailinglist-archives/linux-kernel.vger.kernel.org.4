Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72B6650A31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiLSKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:36:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F92716;
        Mon, 19 Dec 2022 02:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671446171; x=1702982171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aHkzNEK8QmfP/Y9hBaXuqD6yX42n5U+gyda2XKBux6w=;
  b=YNKB6uh1gxofSC0Aq+Dv4vEu+uuHfPs/GGZUncShfHoFEHO+RNn8nbSB
   Z28a31hwD40UlQlnIiKysmMAJGYajs9P+TzSHhepoM4i/a3bYQf096CRm
   Z8jPXrc48i+/pBhBfPSVXR8sHLqiQGw4/31yCKdss/jiUtCqMr+PwV/y/
   3P2Bu2xC2JTjp3JMcrKKGQpBHd8Gz0DRXfv8j4c2LBNB4jk4pOWn7pI1W
   9KXOz+NFCniOTSCC/70hMmjweCM4P+vmG5xLnleG9Uzu+Cj8aBqjfH9se
   5o//khyv7pUINAruuwylH5eDR4CIYl7jz5uclpOCBoJpqopEEaoEavasx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="321214564"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="321214564"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 02:36:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="774884353"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774884353"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.197])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 02:36:07 -0800
Message-ID: <852db20c-7913-bb6a-8019-b02d07241960@intel.com>
Date:   Mon, 19 Dec 2022 12:36:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] mmc: sdhci-sprd: disable polling scan for sdio card
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        wenchao.chen666@gmail.com
References: <20221219084754.11070-1-wenchao.chen@unisoc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221219084754.11070-1-wenchao.chen@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/22 10:47, Wenchao Chen wrote:
> Enable polling will increase the power consumption of the host.
> 
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/sdhci-sprd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 525f979e2a97..113a5c77578f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -696,6 +696,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_cleanup_host;
>  
> +	if ((host->mmc->caps2 & MMC_CAP2_NO_SD) &&
> +			(host->mmc->caps2 & MMC_CAP2_NO_MMC))
> +		host->mmc->caps &= ~MMC_CAP_NEEDS_POLL;

How is MMC_CAP_NEEDS_POLL getting set? SDHCI won't set it for
non-removable cards.  Is it removable?

> +
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  

