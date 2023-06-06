Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB9723A75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjFFHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjFFHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B104A171C;
        Tue,  6 Jun 2023 00:46:05 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDA906602242;
        Tue,  6 Jun 2023 08:46:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037564;
        bh=Xj/YzqlcIkt3jhCkHHErOm6l0WDZaX4f/CZ5gHWORZg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xt81lzTgfOicvnysLgvfrBou5Y5prRstHiVOjJ/6J8bUw05nnx3VFtrovb9OIHG8B
         eslHTzO5k1qepn4SHZUKpS/xkhqkcNlJ3cgjhfqR2MU3uzARHeYbzmxWNVu2RG23Ce
         f+vl5Oco8TiYjgxJFPFosusLXqyvvNlY+oGQik+gblphHMTr+WK4m94IL8tgxu6tvz
         vzDmRMmvTH3gh/d0BRi6llCwliLXVmykgbdixm70U1AtGaVEyCsU4eyo2GdfaUPtV7
         QdKiXOFM3Gg1+0HViiqBTNEd5c4ttforhUk4pLMDAKYpm3qdTmu64eGJmqJMYQtXBg
         3HiM3uDkGv6Xw==
Message-ID: <d9f506ff-d088-98d0-7f4b-d1f9db93d3e6@collabora.com>
Date:   Tue, 6 Jun 2023 09:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Content-Language: en-US
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230605121442.23622-1-wenbin.mei@mediatek.com>
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


     /*
      * On MediaTek SoCs the MSDC controller's CQE uses msdc_hclk as ITCFVAL
      * so we multiply/divide the HCLK frequency by ITCFMUL to calculate the
      * Send Status Command Idle Timer (CIT) value.
      */

The proposed comment increases readability.

Cheers,
Angelo
