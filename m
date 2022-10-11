Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1D5FAD03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJKGpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJKGpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:45:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6844374E3E;
        Mon, 10 Oct 2022 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665470739; x=1697006739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=si5VE5ZcSlm29/bPYZs5mwa8FUz5kdWbOjuHeRZXMKI=;
  b=DlvOflaB6n83DqnKZvhdv/pyG3HarivbxBRntnmITe2al/1DsmqcZyUl
   cz1CjxToLURjUZNKcH12iCzKU/E15sc7qOeI+VuPa9homQ+9sZKGCakr9
   BT3FB2UfJ4AxK2j4d9Gbkd+tbA9n6wjDFuaHPOXVTEO32NaA51V0zyXzR
   +txXQc5DcLb3yvGQR22mA28PLtkhk+xhlbrdtGVHaynLH8J+1Wec3qDdD
   e/O0kTtJWLPCQnPQsidPEJyqHIjQxA6aqiNlXyN2n1cyscMh0qpDtg4xe
   kTb086jBafjxeJuWIsYZ+j88JN+h2280c84BP+jViHO1bKPdbL1HgRzWm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="306047034"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="306047034"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:45:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="871396331"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="871396331"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.214])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:45:18 -0700
Message-ID: <beae901e-0fcd-c4ae-8a6e-a1a4357078da@intel.com>
Date:   Tue, 11 Oct 2022 09:45:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix minimum clock limit
To:     Wenchao Chen <wenchao.chen666@gmail.com>, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
References: <20221011063043.11074-1-wenchao.chen666@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221011063043.11074-1-wenchao.chen666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 09:30, Wenchao Chen wrote:
> From: Wenchao Chen <wenchao.chen@unisoc.com>
> 
> The minimum clock supported by SPRD Host is 100000.

Commit messages are better if they say why a change
is being made.

This begs the question, was there a problem with 400 kHz?
Are there cases that benefit from this change?
Should it have a fixes tag,cc stable?

> 
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/sdhci-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 46c55ab4884c..b92a408f138d 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -309,7 +309,7 @@ static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
>  
>  static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
>  {
> -	return 400000;
> +	return 100000;
>  }
>  
>  static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,

