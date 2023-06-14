Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54872F81C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbjFNInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243736AbjFNInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:43:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180631FD8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:43:06 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 00E6F6606F14;
        Wed, 14 Jun 2023 09:43:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686732184;
        bh=6uVfeatlzvMAEsJTJA8N8knEwkO5HphmlTF6SqKsb/Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D+2scB27lmKFEFbVBYab3ouWwoRR6ELxOzBm6W2BQ8H5fhIvNEWeYCnv75F8McvEF
         VCfZVRsNS1lyd0Ii/zlY/ZcyY8Z176Ba9kaid0qGnz/3yGxOC5rUnaOjnZKvPkTaDA
         RYoMNoZYuT589f7ZYUEejvWCbGkGpYlZJ3gSQ64BtY6d2VAzl/2BmpdtXFjBH3Jsnf
         rtYKmmXuPACRhzyl5w8La0CzvjXBFw3U2ov54FkLLrYp1x2oOgNoNysxU2aQF4Yod0
         daVCnNHER71AX3EIacbKYDtmNYLJ1QYT5kRR7LOaKQXmtM8ezcnD2ocphiGVjimXHq
         TYttZY9hQD55Q==
Message-ID: <7d125255-513b-c5e7-3b9c-57131deab49c@collabora.com>
Date:   Wed, 14 Jun 2023 10:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/4] drm/mediatek: Add cnt checking for coverity issue
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
 <20230613113210.24949-3-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230613113210.24949-3-jason-jh.lin@mediatek.com>
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
> CERT-C Characters and Strings (CERT STR31-C)
> all_drm_priv[cnt] evaluates to an address that could be at negative
> offset of an array.
> 
> In mtk_drm_get_all_drm_priv():
> Guarantee that storage for strings has sufficient space for character
> data and the null terminator.
> 
> So change cnt to unsigned int and check its max value.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")

Fixes tag goes before your S-o-b tag.

Anyway,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 6dcb4ba2466c..fc217e0acd45 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -354,7 +354,7 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
>   	const struct of_device_id *of_id;
>   	struct device_node *node;
>   	struct device *drm_dev;
> -	int cnt = 0;
> +	unsigned int cnt = 0;
>   	int i, j;
>   
>   	for_each_child_of_node(phandle->parent, node) {
> @@ -375,6 +375,9 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
>   		all_drm_priv[cnt] = dev_get_drvdata(drm_dev);
>   		if (all_drm_priv[cnt] && all_drm_priv[cnt]->mtk_drm_bound)
>   			cnt++;
> +
> +		if (cnt == MAX_CRTC) > +			break;
>   	}
>   
>   	if (drm_priv->data->mmsys_dev_num == cnt) {


