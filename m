Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D20729242
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjFIIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbjFIIGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:06:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA3B3AA4;
        Fri,  9 Jun 2023 01:05:59 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C3446606F1F;
        Fri,  9 Jun 2023 09:05:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686297958;
        bh=C23uMLkfLKdYz/PwXDJEsdRNny6ubZDBihQ94h8gE24=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ktpdm7Hc7GhzjkguSPs6WKKGOBLLdgzk/JGnMZOwNzTsc2lfGK0fBhH5DG8rz4njL
         TSWQQaUbrc6Rn1a/LFAF2PoUvps9SbSubDFmR9ulsfk+44QsZiEydWxT5xC9sxJOhQ
         M8dfFUhG/MDSVoQxhuKXbS4WKPgE7LzXy++I9f9STxBrlF5bePXuzg/0DMvjW/VGoT
         Trbr75HIDPmkW3/ul1iUE7BLy1SQd04pb84cu33g9plguWDizLRc/CSvcqclcqSpYO
         cuj8UrzrifKzuXIGhXEVpSL67YORfNQ1jDavVWM8tZ3F1Ro0O0Z9b1QzXT5SDa+4D+
         ZG5tCQDxu/7cg==
Message-ID: <631ec4da-a194-4de0-9f41-0b2d816c40ad@collabora.com>
Date:   Fri, 9 Jun 2023 10:05:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mmc: mtk-sd: include bitfield header and fix incompatible
 pointer types
Content-Language: en-US
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20230609074840.4520-1-wenbin.mei@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609074840.4520-1-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/23 09:48, Wenbin Mei ha scritto:
> The following error appeared due to the patch:
> 364dae3e80a4 "mmc: mtk-sd: reduce CIT for better performance"
> 
> drivers/mmc/host/mtk-sd.c: In function 'msdc_cqe_cit_cal':
> drivers/mmc/host/cqhci.h:27:41: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
> 
> drivers/mmc/host/mtk-sd.c:2471:3: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
>      2471 |                 do_div(hclk_freq, 1000);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
>       238 |                 __rem = __div64_32(&(n), __base);       \
> include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
>       213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> ...
> 
> This patch corrects the issue.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Fixes: 364dae3e80a4 ("mmc: mtk-sd: reduce CIT for better performance")

Fixes tags go before others... anyway:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/mmc/host/cqhci.h  | 1 +
>   drivers/mmc/host/mtk-sd.c | 5 ++---
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index e35c655edefc..1a12e40a02e6 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -5,6 +5,7 @@
>   #define LINUX_MMC_CQHCI_H
>   
>   #include <linux/compiler.h>
> +#include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/spinlock_types.h>
>   #include <linux/types.h>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b582f19f82f2..99317fd9f084 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2456,15 +2456,14 @@ static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
>   	struct mmc_host *mmc = mmc_from_priv(host);
>   	struct cqhci_host *cq_host = mmc->cqe_private;
>   	u8 itcfmul;
> -	unsigned long hclk_freq;
> -	u64 value;
> +	u64 hclk_freq, value;
>   
>   	/*
>   	 * On MediaTek SoCs the MSDC controller's CQE uses msdc_hclk as ITCFVAL
>   	 * so we multiply/divide the HCLK frequency by ITCFMUL to calculate the
>   	 * Send Status Command Idle Timer (CIT) value.
>   	 */
> -	hclk_freq = clk_get_rate(host->h_clk);
> +	hclk_freq = (u64)clk_get_rate(host->h_clk);
>   	itcfmul = CQHCI_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
>   	switch (itcfmul) {
>   	case 0x0:
