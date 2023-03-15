Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B396BAD93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjCOKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCOKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:24:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4A35AD;
        Wed, 15 Mar 2023 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678875844; x=1710411844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xYkvbs2h0q7JWA1b+nO3YwUaWDYJLNgu/dGPXzcBNk8=;
  b=ftWacGeqTmC5kZ0MJVePQJj3yWLT7mSVPKlycQTbiVGVIkvlF6gTzd3B
   T7MBr0jC7+K4f9IexJH7iuuLDjewSAt4TMjMbyGpOCtS38G/ukthMeAdw
   zqizWK769DUx1Od54xTDU38sSQZzIHOs7FJUPNvMwCevv/QdrV4GNzdpD
   bQCVnPZebWnqZaRb+o9LpQevuIS9xD4nIo4rHhU1tq9tcqY6vDY006qNv
   X4yfzPQUP3Rsh5fNJCB1Xa8r/sbveyU6KLdb+h6/qs4t+sdVAPQHd4wZ2
   rwXinqwmQNNzP9dsLM+UMI7Mnw/6Jd2y2F9zmvxZzmBGv35SUhgLmFWMS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340029683"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340029683"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 03:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="925293739"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925293739"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 03:23:50 -0700
Message-ID: <08ce7ccc-5590-1adb-bba9-71e6051e7058@intel.com>
Date:   Wed, 15 Mar 2023 12:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH -next] mmc: sdhci-of-aspeed: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, ulf.hansson@linaro.org
Cc:     andrew@aj.id.au, oel@jms.id.au, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
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

On 15/03/23 07:50, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ba6677bf7372..25b4073f698b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -547,8 +547,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	sdc->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sdc->regs = devm_ioremap_resource(&pdev->dev, sdc->res);
> +	sdc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &sdc->res);
>  	if (IS_ERR(sdc->regs)) {
>  		ret = PTR_ERR(sdc->regs);
>  		goto err_clk;

