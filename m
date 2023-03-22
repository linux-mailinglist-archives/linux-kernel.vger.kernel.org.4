Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A996C4C54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCVNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCVNuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:50:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33D5982D;
        Wed, 22 Mar 2023 06:49:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A70B066030AF;
        Wed, 22 Mar 2023 13:49:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679492975;
        bh=k+p/TCLm1pU60S6WbL0PB2Wsj8ktyGE4is14E/7Ssi0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NR9PRTxii7LTFiTCoWxJrKwkQ4O5KiU/uySb2c0w68SB+wTAfo/fb0zrq2fM1DFA0
         sPRSmGZ/8zDbw8HqYMWG/58ipbxA1EOZ/OOlqX9cN0Nkb8iOPeUCX+ravrs0vEkE8R
         +5KZjXAqRXm731h3qI61uM3kpcnsG9CNnEbaLkpXU07QrQQqZPgse1qXWKHpSQ+Vba
         4UK5qlRM5mgAcNSQIcoBmyJn6+kkebIFSs4RibT1APSmmk76CLzFov65z4nUscRWSx
         lThcuBVkNNipzC+PRr2IWNn2OBzfvlvMJVlxBwHvz5O0Q3ujaPWBCJ2ZdpZXmzuhPG
         lDcfKJm6pZJYA==
Message-ID: <4da63f5b-87f3-89be-31fc-f574a1d7c9bd@collabora.com>
Date:   Wed, 22 Mar 2023 14:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2,2/7] media: mediatek: vcodec: Add debug params to
 control different log level
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230322094617.19410-1-yunfei.dong@mediatek.com>
 <20230322094617.19410-3-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230322094617.19410-3-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/03/23 10:46, Yunfei Dong ha scritto:
> Add parameter mtk_vcodec_dbg to open each codec log.
> Add parameter mtk_v4l2_dbg_level to open each instance log according to
> the parameter value.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        |  2 ++
>   .../mediatek/vcodec/mtk_vcodec_util.c         |  8 ++++++
>   .../mediatek/vcodec/mtk_vcodec_util.h         | 25 ++++++++++++++++---
>   3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> index fb9edd379af5..b5093e4e4aa2 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> @@ -20,6 +20,8 @@ void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
>   			IS_ERR(vcodec_dev->dbgfs.vcodec_root));
>   
>   	vcodec_root = vcodec_dev->dbgfs.vcodec_root;
> +	debugfs_create_x32("mtk_v4l2_dbg_level", 0644, vcodec_root, &mtk_v4l2_dbg_level);
> +	debugfs_create_x32("mtk_vcodec_dbg", 0644, vcodec_root, &mtk_vcodec_dbg);
>   }
>   EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_init);
>   
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> index ace78c4b5b9e..f214e6f67005 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> @@ -13,6 +13,14 @@
>   #include "mtk_vcodec_drv.h"
>   #include "mtk_vcodec_util.h"
>   
> +#if defined(CONFIG_DEBUG_FS)
> +int mtk_vcodec_dbg;
> +EXPORT_SYMBOL(mtk_vcodec_dbg);
> +
> +int mtk_v4l2_dbg_level;
> +EXPORT_SYMBOL(mtk_v4l2_dbg_level);
> +#endif
> +
>   void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
>   					unsigned int reg_idx)
>   {
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index 71956627a0e2..938f03cab3c9 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -35,15 +35,34 @@ struct mtk_vcodec_dev;
>   	pr_err("[MTK_VCODEC][ERROR][%d]: " fmt "\n",		\
>   	       ((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
>   
> +#if defined(CONFIG_DEBUG_FS)
> +extern int mtk_v4l2_dbg_level;
> +extern int mtk_vcodec_dbg;
>   
> -#define mtk_v4l2_debug(level, fmt, args...) pr_debug(fmt, ##args)
> +#define mtk_v4l2_debug(level, fmt, args...)				 \
> +	do {								 \
> +		if (mtk_v4l2_dbg_level >= level)			 \
> +			pr_info("[MTK_V4L2] level=%d %s(),%d: " fmt "\n", \

These shall still be *debug* and not *info*, even if you're controlling the
log level from debugfs, as these are anyway debugging prints which can be
automatically optimized out for a kernel build with *no debug at all*.

The loglevel control is a commodity that should be meant to avoid too much
spam for readability and/or selectively enable "components" logging, because
then there's also the tracing framework providing maximum verbosity.

Besides, I'd be happy if this finally becomes dev_dbg instead of pr_debug.

Regards,
Angelo


