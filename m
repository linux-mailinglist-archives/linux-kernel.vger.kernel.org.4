Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE872F820
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbjFNInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243721AbjFNIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:43:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1101FD2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:43:12 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E3D0D6606F45;
        Wed, 14 Jun 2023 09:43:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686732191;
        bh=8BBsxp6XAIVhovJ5Yvw4wMPhV32ZZO8+LeDwZAeuWYA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LieUGfRuNhr8GWkSmH3/jw5KsDhdxA5H2yINUAvxnkgQES6eDdAqxapFOjQWdFBmI
         F7x4pZWoxNCjO0OKjqTs4AZa82yEr8u5DpK4+ekFjY8mHoVuhxCp8UhPqhd+gAr4yB
         kqgz4QLERqNf45ARzlnEQkM5teUwPMm5mbWgXQS41Xxh65Ti5O04moBunyHVlOplL2
         7LgeiXEj8kemBw0Og9Q83K8QK8fA7OjyjR4TOarE5/FCdqB7VT5K6LZWiFD9FSN9jL
         qSOlkHQ/ioebGtmZV4gziiiX3TsaXc7VZkDe7VQH19B5+oOBX/KqVrKhV8sGaFG24D
         wEcKiT+0h1TcA==
Message-ID: <0f17e59f-21d6-bdf6-99a7-4f4e91f698ba@collabora.com>
Date:   Wed, 14 Jun 2023 10:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/4] drm/mediatek: Add casting before assign
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230613113210.24949-1-jason-jh.lin@mediatek.com>
 <20230613113210.24949-4-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230613113210.24949-4-jason-jh.lin@mediatek.com>
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

Il 13/06/23 13:32, Jason-JH.Lin ha scritto:
> 1. Add casting before assign to avoid the unintentional integer
>     overflow or unintended sign extension.
> 2. Add a int varriable for multiplier calculation instead of calculating
>     different types multiplier with dma_addr_t varriable directly.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Fixes: 1a64a7aff8da ("drm/mediatek: Fix cursor plane no update")
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c   |  2 +-
>   drivers/gpu/drm/mediatek/mtk_drm_plane.c | 22 +++++++++++++---------
>   2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> index a25b28d3ee90..0c7878bc0b37 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -121,7 +121,7 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
>   	int ret;
>   
>   	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> -	args->size = args->pitch * args->height;
> +	args->size = (__u64)args->pitch * args->height;

We could avoid explicit casting here if you do

	args->size = args->pitch;
	args->size *= args->height;

>   
>   	mtk_gem = mtk_drm_gem_create(dev, args->size, false);
>   	if (IS_ERR(mtk_gem))
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index 31f9420aff6f..1cd41454d545 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -145,6 +145,7 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
>   	dma_addr_t addr;
>   	dma_addr_t hdr_addr = 0;
>   	unsigned int hdr_pitch = 0;
> +	int offset;

...but offset can never be negative, can it?
in that case, this should be unsigned int.

>   
>   	gem = fb->obj[0];
>   	mtk_gem = to_mtk_gem_obj(gem);
> @@ -154,8 +155,10 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
>   	modifier = fb->modifier;
>   
>   	if (modifier == DRM_FORMAT_MOD_LINEAR) {
> -		addr += (new_state->src.x1 >> 16) * fb->format->cpp[0];
> -		addr += (new_state->src.y1 >> 16) * pitch;
> +		offset = (new_state->src.x1 >> 16) * fb->format->cpp[0];
> +		addr += offset;
> +		offset = (new_state->src.y1 >> 16) * pitch;
> +		addr += offset;
>   	} else {
>   		int width_in_blocks = ALIGN(fb->width, AFBC_DATA_BLOCK_WIDTH)
>   				      / AFBC_DATA_BLOCK_WIDTH;
> @@ -163,21 +166,22 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
>   				       / AFBC_DATA_BLOCK_HEIGHT;
>   		int x_offset_in_blocks = (new_state->src.x1 >> 16) / AFBC_DATA_BLOCK_WIDTH;
>   		int y_offset_in_blocks = (new_state->src.y1 >> 16) / AFBC_DATA_BLOCK_HEIGHT;
> -		int hdr_size;
> +		int hdr_size, hdr_offset;
>   
>   		hdr_pitch = width_in_blocks * AFBC_HEADER_BLOCK_SIZE;
>   		pitch = width_in_blocks * AFBC_DATA_BLOCK_WIDTH *
>   			AFBC_DATA_BLOCK_HEIGHT * fb->format->cpp[0];
>   
>   		hdr_size = ALIGN(hdr_pitch * height_in_blocks, AFBC_HEADER_ALIGNMENT);
> +		hdr_offset = hdr_pitch * y_offset_in_blocks +
> +			AFBC_HEADER_BLOCK_SIZE * x_offset_in_blocks;
> +		hdr_addr = addr + hdr_offset;
>   
> -		hdr_addr = addr + hdr_pitch * y_offset_in_blocks +
> -			   AFBC_HEADER_BLOCK_SIZE * x_offset_in_blocks;
>   		/* The data plane is offset by 1 additional block. */
> -		addr = addr + hdr_size +
> -		       pitch * y_offset_in_blocks +
> -		       AFBC_DATA_BLOCK_WIDTH * AFBC_DATA_BLOCK_HEIGHT *
> -		       fb->format->cpp[0] * (x_offset_in_blocks + 1);
> +		offset = pitch * y_offset_in_blocks +
> +			 AFBC_DATA_BLOCK_WIDTH * AFBC_DATA_BLOCK_HEIGHT *
> +			 fb->format->cpp[0] * (x_offset_in_blocks + 1);
> +		addr = addr + hdr_size + offset;
>   	}
>   
>   	mtk_plane_state->pending.enable = true;

