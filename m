Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1B729498
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjFIJRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbjFIJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:17:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35649E4;
        Fri,  9 Jun 2023 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686301972; x=1717837972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=93ZLQ7GbcuEOHJKm+7M5gk5bDuq5Blp9uV7UhfBhj4A=;
  b=HhejTqtc4i7S4SOSttA1aIzTacVZ0gj2jiKx0E3DZ14UqFN3Q5HB7VzK
   DYhXAxcG2YkZLSiaJZx0MyBujFNpE22kkO71+uQhGptRWDRlf+g2ICGRb
   O6irkZLj4gc1Xsj57OOEQNbSaMI23ncYixoDQG8zeR6MCn6FuVFkZjqh2
   T3OYgWTeDKId2poFYQZHppK3pbx4fye2t7oc6RbAbpqHOx/wdm3RyZADM
   F3Siu/juVSMFz5MUI4VvBtEo302ZXewuwtFU+9dT1SNKhpxHjBlXlPKre
   QkC1qtv02t/uc8uUn5Cwr3Yuvq/9O/XhW/azFVD8kXkAZeNDiZvs7DNHY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342230798"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342230798"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="775428713"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="775428713"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:12:19 -0700
Message-ID: <c68b7198-9e1e-41cf-44bd-42205fdb7cea@intel.com>
Date:   Fri, 9 Jun 2023 12:12:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] mmc: mtk-sd: include bitfield header and fix incompatible
 pointer types
Content-Language: en-US
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20230609074840.4520-1-wenbin.mei@mediatek.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230609074840.4520-1-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/06/23 10:48, Wenbin Mei wrote:
> The following error appeared due to the patch:
> 364dae3e80a4 "mmc: mtk-sd: reduce CIT for better performance"
> 
> drivers/mmc/host/mtk-sd.c: In function 'msdc_cqe_cit_cal':
> drivers/mmc/host/cqhci.h:27:41: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
> 
> drivers/mmc/host/mtk-sd.c:2471:3: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
>     2471 |                 do_div(hclk_freq, 1000);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
>      238 |                 __rem = __div64_32(&(n), __base);       \
> include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
>      213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> ...
> 
> This patch corrects the issue.

It doesn't look like Ulf has done a pull request for the original
patch, so it might be better to submit a new version of that.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Fixes: 364dae3e80a4 ("mmc: mtk-sd: reduce CIT for better performance")
> ---
>  drivers/mmc/host/cqhci.h  | 1 +
>  drivers/mmc/host/mtk-sd.c | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index e35c655edefc..1a12e40a02e6 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -5,6 +5,7 @@
>  #define LINUX_MMC_CQHCI_H
>  
>  #include <linux/compiler.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/spinlock_types.h>
>  #include <linux/types.h>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b582f19f82f2..99317fd9f084 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2456,15 +2456,14 @@ static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
>  	struct mmc_host *mmc = mmc_from_priv(host);
>  	struct cqhci_host *cq_host = mmc->cqe_private;
>  	u8 itcfmul;
> -	unsigned long hclk_freq;
> -	u64 value;
> +	u64 hclk_freq, value;
>  
>  	/*
>  	 * On MediaTek SoCs the MSDC controller's CQE uses msdc_hclk as ITCFVAL
>  	 * so we multiply/divide the HCLK frequency by ITCFMUL to calculate the
>  	 * Send Status Command Idle Timer (CIT) value.
>  	 */
> -	hclk_freq = clk_get_rate(host->h_clk);
> +	hclk_freq = (u64)clk_get_rate(host->h_clk);
>  	itcfmul = CQHCI_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
>  	switch (itcfmul) {
>  	case 0x0:

