Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A694F642A11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLEOBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiLEOBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:01:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A9912776;
        Mon,  5 Dec 2022 06:01:33 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EAA96601E6A;
        Mon,  5 Dec 2022 14:01:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670248891;
        bh=rC8AWaMkj6jL9tBLy544uoByGzNsAgwTTbsHvW13wjY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DoKLkzE55yiXld463vrqnTy6JekyIpCZK77Vei8mWx0Yjqzf2Coi+F6FzRculJICZ
         peLeplcOYdUHEpbSUDS9SAg/PZJ5kjI9PB1hkZeKJEwhnskwzhF9A2p+Ho+0MK1S3Z
         BlMyui0tZe8vx8lXPeF+SuauD7rPsuCqIQXOGQc97bAoSdnX7ntJXqoF/6RO7rGwCA
         znYLcSGAyok4Bgh/1fWBZOWTk2MKRjv4+2dIZsNTM33+GrjYJGiKZ3HjR9phXnmD7X
         SVFkrQKYNF2mw5RehbBt7BciLhiouLV3SCSVQo7Tu3u1gG57gDcP3s6tiZX8yz1Pey
         EdxJkM1c9JS4g==
Message-ID: <d5bcc6aa-bdb5-9705-a7dd-79a276f4ea01@collabora.com>
Date:   Mon, 5 Dec 2022 15:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Add recovery mechanism for dma read
 timeout
Content-Language: en-US
To:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221205082419.29170-1-bayi.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221205082419.29170-1-bayi.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/12/22 09:24, Bayi Cheng ha scritto:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> The state machine of MTK spi nor controller may be disturbed by some
> glitch signals from the relevant BUS during dma read, Although the
> possibility of causing the dma read to fail is next to nothing,
> However, if error-handling is not implemented, which makes the feature
> somewhat risky.
> 
> Add an error-handling mechanism here, reset the state machine and
> re-read the data when an error occurs.
> 
> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
> ---
> Change in v1:
>    -Reset the state machine when dma read fails and read again.
> ---
> ---
>   drivers/spi/spi-mtk-nor.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index d167699a1a96..c77d79da9a4c 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -80,6 +80,9 @@
>   #define MTK_NOR_REG_DMA_FADR		0x71c
>   #define MTK_NOR_REG_DMA_DADR		0x720
>   #define MTK_NOR_REG_DMA_END_DADR	0x724
> +#define MTK_NOR_REG_CG_DIS		0x728
> +#define MTK_NOR_SFC_SW_RST		BIT(2)
> +
>   #define MTK_NOR_REG_DMA_DADR_HB		0x738
>   #define MTK_NOR_REG_DMA_END_DADR_HB	0x73c
>   
> @@ -616,7 +619,18 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>   			mtk_nor_set_addr(sp, op);
>   			return mtk_nor_read_pio(sp, op);
>   		} else {
> -			return mtk_nor_read_dma(sp, op);
> +			ret = mtk_nor_read_dma(sp, op);
> +			if (ret) {
> +				dev_err(sp->dev, "try to read again\n");
> +				mtk_nor_rmw(sp, MTK_NOR_REG_CG_DIS, 0, MTK_NOR_SFC_SW_RST);
> +				mb(); /* flush previous writes */
> +				mtk_nor_rmw(sp, MTK_NOR_REG_CG_DIS, MTK_NOR_SFC_SW_RST, 0);
> +				mb(); /* flush previous writes */
> +				writel(MTK_NOR_ENABLE_SF_CMD, sp->base + MTK_NOR_REG_WP);

 From what I understand, you're introducing a way to perform a flush+reset on
the controller.

At this point, I'd put that in a separate function like `mtk_nor_reset()`, as
to both increase readability and to possibly reuse it somewhere else in the
future, if needed.

So this would become...

		} else {
			ret = mtk_nor_read_dma(sp, op);
			if (unlikely(ret)) {
				/* Handle rare bus glitch */
				mtk_nor_reset(sp);
				mtk_nor_setup_bus(sp, op);
				return mtk_nor_read_dma(sp, op);
			}
			return ret;
		}

...or something alike :-)

Regards,
Angelo

