Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE9370EF86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjEXHgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbjEXHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:36:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C97131;
        Wed, 24 May 2023 00:35:59 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24E3766032B2;
        Wed, 24 May 2023 08:35:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684913758;
        bh=2P4uUVGWSU1yuuIGABANv5MaXiV9HCTbYclu2/IM3PI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BFGNHizBzrDirVgLuoG5p0bLgQGskneur9IIARgRKquZxXDqU5cbeqxLvmAelQpx2
         wIQOL1vD2uI6BZk5VzvitQonsIXe53UegCK/lnLH2qGKgOzMcfTFEeRlWvmrEyPkdF
         a3H2jcrI2lXF1T0ZdY/5IToW7eTbki7UDR2xDHulp3N3pcynSh/2H8g37ZfY8/7zFO
         ZS8ofYgPXodKinoxhur7XfqRDjxgHWP0WFwe6u+PJg8o6VVyuP2vXfoflUoFJ+BRde
         sSCzluBsADd0iaAaoVU3hgTDdQmE6fURduxAk9NQFRjKF+RoEYixtpgk/YK3YI/rqZ
         Np5iExasUbyoA==
Message-ID: <2dde9a06-1ed3-f95e-f11e-91b65c039c92@collabora.com>
Date:   Wed, 24 May 2023 09:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5,2/2] media: mediatek: vcodec: support stateless hevc
 decoder
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
References: <20230524021625.13708-1-yunfei.dong@mediatek.com>
 <20230524021625.13708-3-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230524021625.13708-3-yunfei.dong@mediatek.com>
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

Il 24/05/23 04:16, Yunfei Dong ha scritto:
> Add mediatek hevc decoder linux driver which use the stateless API in MT8195.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
>   .../media/platform/mediatek/vcodec/Makefile   |    1 +
>   .../vcodec/mtk_vcodec_dec_stateless.c         |   59 +-
>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
>   .../vcodec/vdec/vdec_hevc_req_multi_if.c      | 1101 +++++++++++++++++
>   .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
>   .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
>   6 files changed, 1166 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
> 

..snip..

> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
> new file mode 100644
> index 000000000000..9a96547af33c
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
> @@ -0,0 +1,1101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Yunfei Dong <yunfei.dong@mediatek.com>
> + */
> +

..snip..

> +
> +/**
> + * struct vdec_hevc_slice_share_info - shared information used to exchange
> + *                                     message between lat and core
> + *
> + * @sps:               sequence header information from user space
> + * @dec_params:        decoder params from user space
> + * @hevc_slice_params: decoder params used for hardware
> + * @trans_start:       trans start dma address
> + * @trans_end:         trans end dma address

Wrong documentation, there's no trans_start, trans_end, but just `trans`.

> + */
> +struct vdec_hevc_slice_share_info {
> +	struct v4l2_ctrl_hevc_sps sps;
> +	struct v4l2_ctrl_hevc_decode_params dec_params;
> +	struct vdec_hevc_slice_lat_dec_param hevc_slice_params;
> +	struct vdec_hevc_slice_mem trans;
> +};
> +
> +/**
> + * struct vdec_hevc_slice_inst - hevc decoder instance
> + *
> + * @slice_dec_num:      how many picture be decoded
> + * @ctx:                point to mtk_vcodec_ctx
> + * @pred_buf:           HW working predication buffer

pred_buf is not present in this structure; either add it and make use
of it, or remove the documentation for it.

> + * @mv_buf:             HW working motion vector buffer
> + * @vpu:                VPU instance
> + * @vsi:                vsi used for lat
> + * @vsi_core:           vsi used for core
> + * @wrap_addr:          wrap address used for hevc
> + *
> + * @hevc_slice_param:   the parameters that hardware use to decode
> + *
> + * @resolution_changed: resolution changed
> + * @realloc_mv_buf:     reallocate mv buffer
> + * @cap_num_planes:     number of capture queue plane
> + */
> +struct vdec_hevc_slice_inst {
> +	unsigned int slice_dec_num;
> +	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_mem mv_buf[HEVC_MAX_MV_NUM];
> +	struct vdec_vpu_inst vpu;
> +	struct vdec_hevc_slice_vsi *vsi;
> +	struct vdec_hevc_slice_vsi *vsi_core;
> +	struct mtk_vcodec_mem wrap_addr;
> +
> +	struct vdec_hevc_slice_lat_dec_param hevc_slice_param;
> +
> +	unsigned int resolution_changed;
> +	unsigned int realloc_mv_buf;
> +	unsigned int cap_num_planes;
> +};
> +
> +static unsigned int vdec_hevc_get_mv_buf_size(unsigned int width, unsigned int height)
> +{
> +	const int unit_size = (width / 16) * (height / 16) + 8;

This is supposed to be `const unsigned int`, otherwise you may overflow here (even
if it's unlikely to, but still....!)

> +
> +	return 64 * unit_size;
> +}
> +

..snip..

> +static int vdec_hevc_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
> +				      struct vdec_fb *fb, bool *res_chg)
> +{
> +	struct vdec_hevc_slice_inst *inst = h_vdec;
> +	struct vdec_vpu_inst *vpu = &inst->vpu;
> +

Please remove this extra empty line.

> +	int err, timeout = 0;
> +	unsigned int data[2];
> +	struct vdec_lat_buf *lat_buf;
> +	struct vdec_hevc_slice_share_info *share_info;
> +

...after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


