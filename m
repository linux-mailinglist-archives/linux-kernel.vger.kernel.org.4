Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DBA6C4A02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCVMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:12:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1A52F5C;
        Wed, 22 Mar 2023 05:12:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0D7F66018CB;
        Wed, 22 Mar 2023 12:12:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679487147;
        bh=ZOtaZyVnu/uBtZEaZewxTNOHLS2qqXJGInNUpjI+hIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZUNaB6uMVZimiXGmerDGwTb7om+tBBR/ewI16XEqa2Z/heAJ5OUIB1lmtrX+Dn0xW
         IPwyMi7ezC1Tx4Ft9mNmJ98n29+tfe9npY1Mpons7T0uU+3k2XW1jo4DimmW9fT5Qy
         0+/d2irC6l91QqIEMijH/QAJAS1+Usj9aXUMiqYlcjbOIzqPqji4GItD951SgKnbV7
         Li/Iik6D+BkpLzp69IrNtL/NPpdjcQ4Y4UITzOl6615blAbifAAByZWRpQhXZYK5jK
         Ih6FbIETmnYb20nOxD7JeE6Eet+HNptpwihq+/ESBHsj+Ffo9xGIOuuuS4u220q7Z7
         PsN7bmSTzZLyQ==
Message-ID: <66cb5a95-4646-87d1-0acf-ebd473f3c653@collabora.com>
Date:   Wed, 22 Mar 2023 13:12:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2,5/7] media: mediatek: vcodec: Get get each instance
 format type
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
 <20230322094617.19410-6-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230322094617.19410-6-yunfei.dong@mediatek.com>
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
> Adding echo command to get capture and output queue format
> type:'echo -format > vdec'
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 48 +++++++++++++++++++
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  1 +
>   2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> index 19a1dc068efd..1b1b4301a83d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> @@ -10,6 +10,48 @@
>   #include "mtk_vcodec_drv.h"
>   #include "mtk_vcodec_util.h"
>   
> +static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_ctx *ctx, char *buf,
> +					   int *used, int total)
> +{
> +	int curr_len;
> +
> +	switch (ctx->current_codec) {
> +	case V4L2_PIX_FMT_H264_SLICE:
> +		curr_len = snprintf(buf + *used, total - *used,
> +				    "\toutput format: h264 slice\n");

Isn't this the same information that's also given by the VIDIOC_ENUM_FMT ioctl?

Check functions v4l_enum_fmt(), v4l_fill_fmtdesc().

Regards,
Angelo

