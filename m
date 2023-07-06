Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4126749C63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGFMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGFMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:48:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8A1FFC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:47:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0609C6606FBA;
        Thu,  6 Jul 2023 13:47:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688647651;
        bh=zXq0RxESpSkRSGtoAWJi6JGEGgsz7+mOEqGxgmgm5F0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QWRwQrxYxEJii4Oy32ULOt49iEq2NvCXfSWiYq1uVb0ISH25jO1fQqLl8XZ7p0na0
         8W5v74OYEWDgDegmPjTOu/5iqn+Kb9WXI1KNGWOTUf1DMqn7xJoDBLh2BRXyT9suYS
         2kMgqKdIITNXxzNuBra3luErq+Gy9f+0aN1fvHy4DH6yV0unaiwLQUlFsOXVQukhRW
         TQqSUfpI88zRTyUVdjkv2KCos8Mh6/OlGTTT2YIEOBoq5sjlesR3FdnSs8ObjigLyr
         iS1svXJgKtFT8XOwDk9AuxqfPPdT1flRG+LiPrmhami61Vm74IZcxr8KA45UZ0WNQr
         hUBpKoXlctegw==
Message-ID: <be63fd1b-7659-75b8-e037-38528e8a8276@collabora.com>
Date:   Thu, 6 Jul 2023 14:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/mediatek: Fix potential memory leak if vmap() fail
Content-Language: en-US
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230626185801.684451-1-suijingfeng@loongson.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230626185801.684451-1-suijingfeng@loongson.cn>
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

Il 26/06/23 20:58, Sui Jingfeng ha scritto:
> Also return -ENOMEM if such a failure happens, the implement should take
> responsibility for the error handling.
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

This commit needs a Fixes tag. Please add the relevant one and resend.

Thanks,
Angelo

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> index a25b28d3ee90..9f364df52478 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -247,7 +247,11 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>   
>   	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
>   			       pgprot_writecombine(PAGE_KERNEL));
> -
> +	if (!mtk_gem->kvaddr) {
> +		kfree(sgt);
> +		kfree(mtk_gem->pages);
> +		return -ENOMEM;
> +	}
>   out:
>   	kfree(sgt);
>   	iosys_map_set_vaddr(map, mtk_gem->kvaddr);



