Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3AA617A24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKCJnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKCJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:43:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B65FE01D;
        Thu,  3 Nov 2022 02:43:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 502116602910;
        Thu,  3 Nov 2022 09:43:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667468624;
        bh=WzJl4BXFZRLkOk01bt0LBwgsiwnE8Tpr5KVb5Ed86K4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NaPeZEpZbFjEIt3jYG2wvn6z3NUPQRFSdWgpzTyAHzNlRJhaAFdJkikbizVhs7Byl
         3tyIfSkeK3MhkRWZehuPSamIlQuBEXeAYSQWYYSXKUYox/3MFAR7S71Bwt3WB19lpc
         4GJ8F3R6ZlyG+SA6FKmJ6C0DVY8fveeQ8SnZ340JNYNxczpi2RzhzzP3JSCCkV4fSq
         +kjhNPeGOwrqONsuzP6yyIDXbtoWY6QoEuYtBuzMC7aNSlVkReVVGQ7W4U/Lavlanp
         6tkuZDYZ4C+XOOmLDr+faXNsOG3xAgnkBPwtz9hYuaM3F8qqu3ll2g5gfucgLO57p3
         L3anbGiWaI6jg==
Message-ID: <10529948-a9b8-2121-7adb-0e94cf3cbf6a@collabora.com>
Date:   Thu, 3 Nov 2022 10:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Content-Language: en-US
To:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
 <20221103052843.2025-2-bayi.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221103052843.2025-2-bayi.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/11/22 06:28, Bayi Cheng ha scritto:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> The timeout value of the current dma read is unreasonable. For example,
> If the spi flash clock is 26Mhz, It will takes about 1.3ms to read a
> 4KB data in spi mode. But the actual measurement exceeds 50s when a
> dma read timeout is encountered.
> 
> In order to be more accurately, It is necessary to use msecs_to_jiffies,
> After modification, the measured timeout value is about 130ms.
> 
> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
> ---
>   drivers/spi/spi-mtk-nor.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index d167699a1a96..3d989db80ee9 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -354,7 +354,7 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
>   			    dma_addr_t dma_addr)
>   {
>   	int ret = 0;
> -	ulong delay;
> +	ulong delay, timeout;
>   	u32 reg;
>   
>   	writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
> @@ -376,15 +376,16 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
>   	mtk_nor_rmw(sp, MTK_NOR_REG_DMA_CTL, MTK_NOR_DMA_START, 0);
>   
>   	delay = CLK_TO_US(sp, (length + 5) * BITS_PER_BYTE);
> +	timeout = (delay + 1) * 100;
>   
>   	if (sp->has_irq) {
>   		if (!wait_for_completion_timeout(&sp->op_done,
> -						 (delay + 1) * 100))
> +		    msecs_to_jiffies(max_t(size_t, timeout / 1000, 10))))

You're giving a `size_t` variable to msecs_to_jiffies(), but checking `jiffies.h`,
this function takes a `const unsigned int` param.
Please change the type to match that.

Aside from that, your `timeout` variable contains a timeout in microseconds and
this means that actually using msecs_to_jiffies() is suboptimal here.

Please use usecs_to_jiffies() instead.

Regards,
Angelo

