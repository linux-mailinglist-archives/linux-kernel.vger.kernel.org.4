Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72C722744
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjFENWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjFENWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:22:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA092;
        Mon,  5 Jun 2023 06:22:26 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19AD96600873;
        Mon,  5 Jun 2023 14:22:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685971344;
        bh=RG2Kt3+4ozztoOhFlOmXapSwh5NhAbY+1RJEl2K4ozQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OLA2OivJ25y09pO+roLeddFRMu6LSd1Q0PEIDu/YaOtKkWMXj/njES/CulZwRSwHI
         7u+WQO2fJhhMEUKC81vvztQV9L66KTH8o8c3SZAnImqnEhC3rPwQOKiqMJmx0XrrXt
         kRkVGrAcD5R6eJef2Q6uh20WDD7IdWBawBAcD6/nBM4+Ijsrf+msjsntus73NId2Az
         fhF2ydFVx/6JIkjzjGQIMtBsCfyTil0xk5RAf+ay3eqA2U72ZaW6i3OaCK3bDcJbMb
         fGPn+4ncia+2b84m71876OcGpByXHDPjzpAjuoxo29GIDMHf5mbTNhT9Lc2qt+bJBh
         x3MSkF7CjDPxg==
Message-ID: <2ef5a7e5-3772-f7ed-9aad-f51c53a7a24b@collabora.com>
Date:   Mon, 5 Jun 2023 15:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230605121442.23622-1-wenbin.mei@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230605121442.23622-1-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/06/23 14:14, Wenbin Mei ha scritto:
> CQHCI_SSC1 indicates to CQE the polling period to use when using periodic
> SEND_QUEUE_STATUS(CMD13) polling.
> Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
> frequency to get the actual time.
> The default value 0x1000 that corresponds to 150us for MediaTek SoCs, let's
> decrease it to 0x40 that corresponds to 2.35us, which can improve the
> performance of some eMMC devices.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

You haven't addressed all my comments. Is there any reason for that?

Regards,
Angelo

> ---
>   drivers/mmc/host/cqhci.h  |  1 +
>   drivers/mmc/host/mtk-sd.c | 45 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387ed90eb..292b89ebd978 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -23,6 +23,7 @@
>   /* capabilities */
>   #define CQHCI_CAP			0x04
>   #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
> +#define CQHCI_CAP_ITCFMUL(x)		(((x) & GENMASK(15, 12)) >> 12)
>   
>   /* configuration */
>   #define CQHCI_CFG			0x08
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index edade0e54a0c..9f540973caff 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -473,6 +473,7 @@ struct msdc_host {
>   	struct msdc_tune_para def_tune_para; /* default tune setting */
>   	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
>   	struct cqhci_host *cq_host;
> +	u32 cq_ssc1_time;
>   };
>   
>   static const struct mtk_mmc_compatible mt2701_compat = {
> @@ -2450,9 +2451,48 @@ static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
>   	}
>   }
>   
> +static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
> +{
> +	struct mmc_host *mmc = mmc_from_priv(host);
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	u8 itcfmul;
> +	u64 hclk_freq;
> +	u64 value;
> +
> +	/* Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
> +	 * frequency to get the actual time for CIT.
> +	 */
> +	hclk_freq = clk_get_rate(host->h_clk);
> +	itcfmul = CQHCI_CAP_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
> +	switch (itcfmul) {
> +	case 0x0:
> +		do_div(hclk_freq, 1000);
> +		break;
> +	case 0x1:
> +		do_div(hclk_freq, 100);
> +		break;
> +	case 0x2:
> +		do_div(hclk_freq, 10);
> +		break;
> +	case 0x3:
> +		break;
> +	case 0x4:
> +		hclk_freq = hclk_freq * 10;
> +		break;
> +	default:
> +		host->cq_ssc1_time = 0x40;
> +		return;
> +	}
> +
> +	value = hclk_freq * timer_ns;
> +	do_div(value, 1000000000);
> +	host->cq_ssc1_time = value;
> +}
> +
>   static void msdc_cqe_enable(struct mmc_host *mmc)
>   {
>   	struct msdc_host *host = mmc_priv(mmc);
> +	struct cqhci_host *cq_host = mmc->cqe_private;
>   
>   	/* enable cmdq irq */
>   	writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
> @@ -2462,6 +2502,9 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>   	msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
>   	/* default read data timeout 1s */
>   	msdc_set_timeout(host, 1000000000ULL, 0);
> +
> +	/* Set the send status command idle timer */
> +	cqhci_writel(cq_host, host->cq_ssc1_time, CQHCI_SSC1);
>   }
>   
>   static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> @@ -2803,6 +2846,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   		/* cqhci 16bit length */
>   		/* 0 size, means 65536 so we don't have to -1 here */
>   		mmc->max_seg_size = 64 * 1024;
> +		/* Reduce CIT to 0x40 that corresponds to 2.35us */
> +		msdc_cqe_cit_cal(host, 2350);
>   	}
>   
>   	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,

