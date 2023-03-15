Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F06BA6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjCOFXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOFWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:22:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC765FE80;
        Tue, 14 Mar 2023 22:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678857600; x=1710393600;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=astQPGzGHW7+JVDf7KUorERJGzE4FnQeRFYQrFkd7VQ=;
  b=a+27hdqHcs7p4eqCEw1uPHZdwIz+Eh00TXD97D/QYtki/kEmjC1fuw0F
   MAM4sQlIaYARyrbbmt6nliJeJTvWvatEW8Ffzv/fM9Wk0uGoQ8+wkMxPV
   jKS0AXBnW1QPdHNqV75inxtPf6x7+UlTdILKAMj57UGZHpIMg+xKjHHlk
   LkVHWgbo1eSGY6A49eraLmu+FPFC7JYxa86yHJDg9qP2mU3E4Ehh4/PGw
   NAhZXtUHO6G9AW7n8/PeU4va19QIXTjXK4A0U62Um/C+5wy9kYKVTUQxJ
   GPm5Zpex4taByz83FJSkaOOdU95uhHNpRRk4TREfKulzp5NkQl1pg5dvq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339978375"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="339978375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 22:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656629282"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="656629282"
Received: from ksurkov-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.200])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 22:18:32 -0700
Message-ID: <68f33889-e343-4d36-f6a7-f742128b45ef@intel.com>
Date:   Wed, 15 Mar 2023 07:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] mmc: sdhci: drop useless sdhci_get_compatibility() !OF
 stub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/23 22:39, Krzysztof Kozlowski wrote:
> The sdhci_get_compatibility() uses OF functions which have stubs for !OF
> case, thus entire CONFIG_OF ifdef can be dropped.  This also fixes
> !CONFIG_OF W=1 warning:
> 
>   drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for ‘sdhci_get_compatibility’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> Changes since v1:
> 1. Drop the stub (Ulf)
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 328b132bbe57..673e750a8490 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -54,7 +54,6 @@ static bool sdhci_wp_inverted(struct device *dev)
>  #endif /* CONFIG_PPC */
>  }
>  
> -#ifdef CONFIG_OF
>  static void sdhci_get_compatibility(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> @@ -72,9 +71,6 @@ static void sdhci_get_compatibility(struct platform_device *pdev)
>  	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }
> -#else
> -void sdhci_get_compatibility(struct platform_device *pdev) {}
> -#endif /* CONFIG_OF */
>  
>  void sdhci_get_property(struct platform_device *pdev)
>  {

