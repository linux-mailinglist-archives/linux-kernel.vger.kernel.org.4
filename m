Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF607196F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjFAJaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjFAJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:29:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D197;
        Thu,  1 Jun 2023 02:29:51 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A80E76606EBB;
        Thu,  1 Jun 2023 10:29:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685611790;
        bh=/99L0yDyxfKpGTLUsUvuTBXH57FzSAVPgswDfaicft0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Iz7Hpv/WW0Zq2RNh0iuM8jxPoqgrnBjPTKgILgEJD/MnGgAIULj4oLw/FYWaumWXj
         hAhmvW2hVxoGcwVLbyyRnSvtDqVsDGjC7w4g+0VqDiCNdXdHiZ5bE0saUfhs+pJ3z5
         I/Eiz3zVh2ha/ZtRsqMP3C81OvKxyhKiWqomw6tkdjrQebytlKpdv4wKHtp8Dqm3Aw
         gH3zrZ8zlIlCRBKXRfDBjCQkSI9D49FlPxXeIHfHMn0XQFMmPdGiCW4PnACyfO7WIM
         MbN7tn2pghUa4JuR5gSJII2OIhbq1gLT/MvpekRI6MqQNhZxGDVa1lV6iMOTiM0R+V
         xXKWkcmfGyFLw==
Message-ID: <ef3aaee1-e6ca-a89d-e002-42bf918736f4@collabora.com>
Date:   Thu, 1 Jun 2023 11:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/8] mediatek: vcodec: remove the dependency of debug log
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
 <20230601030256.29875-5-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601030256.29875-5-yunfei.dong@mediatek.com>
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

Il 01/06/23 05:02, Yunfei Dong ha scritto:
> 'mtk_vcodec_debug' and 'mtk_vcodec_err' depends on 'mtk_vcodec_ctx'
> to get the index of each instance, using the index directly instead
> of with 'mtk_vcodec_ctx'.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_util.h         |  36 +++--
>   .../vcodec/vdec/vdec_av1_req_lat_if.c         |  78 +++++------
>   .../mediatek/vcodec/vdec/vdec_h264_if.c       |  46 +++----
>   .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  32 ++---
>   .../vcodec/vdec/vdec_h264_req_multi_if.c      |  62 ++++-----
>   .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  54 ++++----
>   .../mediatek/vcodec/vdec/vdec_vp8_if.c        |  38 +++---
>   .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  36 ++---
>   .../mediatek/vcodec/vdec/vdec_vp9_if.c        | 128 +++++++++---------
>   .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  67 ++++-----
>   .../platform/mediatek/vcodec/vdec_vpu_if.c    |  48 +++----
>   .../mediatek/vcodec/venc/venc_h264_if.c       |  74 +++++-----
>   .../mediatek/vcodec/venc/venc_vp8_if.c        |  44 +++---
>   .../platform/mediatek/vcodec/venc_vpu_if.c    |  54 ++++----
>   14 files changed, 399 insertions(+), 398 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index ecb0bdf3a4f4..f018af38b39d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -31,42 +31,38 @@ struct mtk_vcodec_dev;
>   #define mtk_v4l2_err(fmt, args...)                \
>   	pr_err("[MTK_V4L2][ERROR] " fmt "\n", ##args)
>   
> -#define mtk_vcodec_err(h, fmt, args...)				\
> -	pr_err("[MTK_VCODEC][ERROR][%d]: " fmt "\n",		\
> -	       ((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
> +#define mtk_vcodec_err(inst_id, fmt, args...)                          \
> +	pr_err("[MTK_VCODEC][ERROR][%d]: " fmt "\n", inst_id, ##args)
>   

This *huge* cleanup (congrats btw!) would be a great occasion to change those
pr_err() to dev_err(). Can we do that?

Regards,
Angelo

