Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3977B6E09FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDMJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjDMJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:16:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0EF7D96;
        Thu, 13 Apr 2023 02:16:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E63FD6603209;
        Thu, 13 Apr 2023 10:16:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681377382;
        bh=HnC1sN+rFI+EKt7ygaCOOSIdTOH+pbUrW1hd8BTfTkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f4RbOarWR2nZ3WV1EOj/TWQerW3y0Bz1aZIV/NZK+5KoOBeAJZNhSrSBg7eur4/LP
         u5mZZFS2i+M420iGDpYlWR04CBmGgH3FQYoM3gmhKMcw1Byvgk5ryHHKYmVcWhMMv8
         XnZvvFLOmAVvthxGTigEdQIZIqhDGLc/gQtxmCIEqTsNPe2UShOeiKvuc62bZHI9Qp
         gvGwkLQAeOzhDOK5/KN63yM3MZ+lJMV2DHJwEVwlzGZ6FOMl6nz8TxAJcmlyxTYn+a
         SmiVx8XRfBLa4IB1hN5PCCIg/d7R3eYTyvlrfFJMck2JtmuFIKxtLgyeOmQymcYxkQ
         whd++jZs1wVyA==
Message-ID: <08a83611-ea00-e568-84fb-10483d7572c0@collabora.com>
Date:   Thu, 13 Apr 2023 11:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 10/13] media: verisilicon: Add Rockchip AV1 decoder
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
 <20230412115652.403949-11-benjamin.gaignard@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115652.403949-11-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 13:56, Benjamin Gaignard ha scritto:
> Implement AV1 stateless decoder for rockchip VPU981.
> It decode 8 and 10 bits AV1 bitstreams.
> AV1 scaling feature is done by the postprocessor.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> Changes in v6:
> - Fix frame-larger-than warning.
> 
>   drivers/media/platform/verisilicon/Makefile   |    1 +
>   .../media/platform/verisilicon/hantro_hw.h    |   64 +-
>   .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2024 +++++++++++++++++
>   .../verisilicon/rockchip_vpu981_regs.h        |  477 ++++
>   4 files changed, 2564 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>   create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
> 

..snip..

> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
> index d7641eced32e..25456fb960c8 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -37,6 +37,8 @@
>   
>   #define NUM_REF_PICTURES	(V4L2_HEVC_DPB_ENTRIES_NUM_MAX + 1)
>   
> +#define AV1_MAX_FRAME_BUF_COUNT	(V4L2_AV1_TOTAL_REFS_PER_FRAME + 1)
> +
>   struct hantro_dev;
>   struct hantro_ctx;
>   struct hantro_buf;
> @@ -250,23 +252,81 @@ struct hantro_vp9_dec_hw_ctx {
>   };
>   
>   /**
> - * hantro_av1_dec_hw_ctx
> + * struct hantro_av1_dec_ctrls
> + * @sequence:		AV1 Sequence
> + * @tile_group_entry:	AV1 Tile Group entry
> + * @frame:		AV1 Frame Header OBU
> + * @film_grain:		AV1 Film Grain
> + */
> +struct hantro_av1_dec_ctrls {
> +	const struct v4l2_ctrl_av1_sequence *sequence;
> +	const struct v4l2_ctrl_av1_tile_group_entry *tile_group_entry;
> +	const struct v4l2_ctrl_av1_frame *frame;
> +	const struct v4l2_ctrl_av1_film_grain *film_grain;
> +};
> +
> +struct hantro_av1_frame_ref {
> +	int width;
> +	int height;
> +	int mi_cols;
> +	int mi_rows;

I wonder if we can save some memory here, if w/h/mi_c/mi_r can never be
negative, it would be possible to change them to a unsigned type, in which
case, a u16 would probably be fine at least for width and height as I would
never expect a resolution of more than 65535x65535.

Even a s16 would probably be fine, anyway - but that's your call.

P.S.: If this is a structure coming from the HW instead, all members shall
use fixed size type!

..snip..

> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> new file mode 100644
> index 000000000000..b9fc70f606a3
> --- /dev/null
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> @@ -0,0 +1,2024 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, Collabora

Shouldn't this be   2023, Collabora Ltd.   ? :-)

> + *
> + * Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> + */
> +
> +#include <media/v4l2-mem2mem.h>
> +#include "hantro.h"
> +#include "hantro_v4l2.h"
> +#include "rockchip_vpu981_regs.h"
> +

..snip..

> +
> +static int rockchip_vpu981_av1_tile_log2(int target)
> +{
> +	int k;
> +
> +	/*
> +	 * returns the smallest value for k such that 1 << k is greater
> +         * than or equal to target

Spaces -> tabs here, please.

> +	 */
> +	for (k = 0; (1 << k) < target; k++);
> +
> +	return k;
> +}
> +

..snip..

> +static void rockchip_vpu981_av1_dec_set_tile_info(struct hantro_ctx *ctx)
> +{
> +	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
> +	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
> +	const struct v4l2_av1_tile_info *tile_info = &ctrls->frame->tile_info;
> +	const struct v4l2_ctrl_av1_tile_group_entry *group_entry =
> +	    ctrls->tile_group_entry;
> +	int context_update_y =
> +	    tile_info->context_update_tile_id / tile_info->tile_cols;
> +	int context_update_x =
> +	    tile_info->context_update_tile_id % tile_info->tile_cols;
> +	int context_update_tile_id =
> +	    context_update_x * tile_info->tile_rows + context_update_y;
> +	u8 *dst = av1_dec->tile_info.cpu;
> +	struct hantro_dev *vpu = ctx->dev;
> +	int tile0, tile1;
> +
> +	memset(dst, 0, av1_dec->tile_info.size);
> +
> +	for (tile0 = 0; tile0 < tile_info->tile_cols; tile0++) {
> +		for (tile1 = 0; tile1 < tile_info->tile_rows; tile1++) {
> +			int tile_id = tile1 * tile_info->tile_cols + tile0;
> +			u32 start, end;
> +			u32 y0 =
> +			    tile_info->height_in_sbs_minus_1[tile1] + 1;
> +			u32 x0 = tile_info->width_in_sbs_minus_1[tile0] + 1;
> +
> +			// tile size in SB units (width,height)

Please be consistent with comments style.
You used C-style before, so please do the same here.

> +			*dst++ = x0;
> +			*dst++ = 0;
> +			*dst++ = 0;
> +			*dst++ = 0;
> +			*dst++ = y0;
> +			*dst++ = 0;
> +			*dst++ = 0;
> +			*dst++ = 0;
> +
> +			// tile start position
> +			start = group_entry[tile_id].tile_offset - group_entry[0].tile_offset;
> +			*dst++ = start & 255;
> +			*dst++ = (start >> 8) & 255;
> +			*dst++ = (start >> 16) & 255;
> +			*dst++ = (start >> 24) & 255;
> +
> +			// # of bytes in tile data

s/#/number/g

> +			end = start + group_entry[tile_id].tile_size;
> +			*dst++ = end & 255;
> +			*dst++ = (end >> 8) & 255;
> +			*dst++ = (end >> 16) & 255;
> +			*dst++ = (end >> 24) & 255;
> +		}
> +	}
> +
> +	hantro_reg_write(vpu, &av1_multicore_expect_context_update,
> +			 !!(context_update_x == 0));

fits in one line of 96 columns

> +	hantro_reg_write(vpu, &av1_tile_enable,
> +			 !!((tile_info->tile_cols > 1) || (tile_info->tile_rows > 1)));
> +	hantro_reg_write(vpu, &av1_num_tile_cols_8k, tile_info->tile_cols);
> +	hantro_reg_write(vpu, &av1_num_tile_rows_8k, tile_info->tile_rows);
> +	hantro_reg_write(vpu, &av1_context_update_tile_id,
> +			 context_update_tile_id);

ditto

> +	hantro_reg_write(vpu, &av1_tile_transpose, 1);
> +	if (rockchip_vpu981_av1_tile_log2(tile_info->tile_cols) ||
> +	    rockchip_vpu981_av1_tile_log2(tile_info->tile_rows))
> +		hantro_reg_write(vpu, &av1_dec_tile_size_mag, tile_info->tile_size_bytes - 1);
> +	else
> +		hantro_reg_write(vpu, &av1_dec_tile_size_mag, 3);
> +
> +	hantro_write_addr(vpu, AV1_TILE_BASE, av1_dec->tile_info.dma);
> +}
> +

..snip..


> +static void rockchip_vpu981_av1_dec_update_prob(struct hantro_ctx *ctx)
> +{
> +	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
> +	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
> +	const struct v4l2_ctrl_av1_frame *frame = ctrls->frame;
> +	bool frame_is_intra = IS_INTRA(frame->frame_type);
> +	struct av1cdfs *out_cdfs = (struct av1cdfs *)av1_dec->prob_tbl_out.cpu;
> +	int i;
> +
> +	if (frame->flags & V4L2_AV1_FRAME_FLAG_DISABLE_FRAME_END_UPDATE_CDF)
> +		return;
> +
> +	for (i = 0; i < NUM_REF_FRAMES; i++) {
> +		if (frame->refresh_frame_flags & (1 << i)) {

You can use the BIT() macro here:

if (frame->refresh_frame_flags & BIT(i)) {

> +			struct mvcdfs stored_mv_cdf;
> +
> +			rockchip_av1_get_cdfs(ctx, i);
> +			stored_mv_cdf = av1_dec->cdfs->mv_cdf;
> +			*av1_dec->cdfs = *out_cdfs;
> +			if (frame_is_intra) {
> +				av1_dec->cdfs->mv_cdf = stored_mv_cdf;
> +				*av1_dec->cdfs_ndvc = out_cdfs->mv_cdf;
> +			}
> +			rockchip_av1_store_cdfs(ctx,
> +						frame->refresh_frame_flags);
> +			break;
> +		}
> +	}
> +}

..snip..

> +
> +static void rockchip_vpu981_av1_dec_set_cdef(struct hantro_ctx *ctx)
> +{
> +	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
> +	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
> +	const struct v4l2_ctrl_av1_frame *frame = ctrls->frame;
> +	const struct v4l2_av1_cdef *cdef = &frame->cdef;
> +	struct hantro_dev *vpu = ctx->dev;
> +	u32 luma_pri_strength = 0;
> +	u16 luma_sec_strength = 0;
> +	u32 chroma_pri_strength = 0;
> +	u16 chroma_sec_strength = 0;
> +	int i;
> +
> +	hantro_reg_write(vpu, &av1_cdef_bits, cdef->bits);
> +	hantro_reg_write(vpu, &av1_cdef_damping, cdef->damping_minus_3);
> +
> +	for (i = 0; i < (1 << cdef->bits); i++) {

for (i = 0; i < BIT(cdef->bits); i++) {

> +		luma_pri_strength |= cdef->y_pri_strength[i] << (i * 4);
> +		if (cdef->y_sec_strength[i] == 4)
> +			luma_sec_strength |= 3 << (i * 2);
> +		else
> +			luma_sec_strength |= cdef->y_sec_strength[i] << (i * 2);
> +
> +		chroma_pri_strength |= cdef->uv_pri_strength[i] << (i * 4);
> +		if (cdef->uv_sec_strength[i] == 4)
> +			chroma_sec_strength |= 3 << (i * 2);
> +		else
> +			chroma_sec_strength |= cdef->uv_sec_strength[i] << (i * 2);
> +	}
> +
> +	hantro_reg_write(vpu, &av1_cdef_luma_primary_strength,
> +			 luma_pri_strength);
> +	hantro_reg_write(vpu, &av1_cdef_luma_secondary_strength,
> +			 luma_sec_strength);
> +	hantro_reg_write(vpu, &av1_cdef_chroma_primary_strength,
> +			 chroma_pri_strength);
> +	hantro_reg_write(vpu, &av1_cdef_chroma_secondary_strength,
> +			 chroma_sec_strength);
> +
> +	hantro_write_addr(vpu, AV1_CDEF_COL, av1_dec->cdef_col.dma);
> +}
> +

..snip..

> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
> new file mode 100644
> index 000000000000..182e6c830ff6
> --- /dev/null
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
> @@ -0,0 +1,477 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022, Collabora
> + *
> + * Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> + */
> +
> +#ifndef _ROCKCHIP_VPU981_REGS_H_
> +#define _ROCKCHIP_VPU981_REGS_H_
> +
> +#include "hantro.h"
> +
> +#define AV1_SWREG(nr)	((nr) * 4)
> +
> +#define AV1_DEC_REG(b, s, m) \
> +	((const struct hantro_reg) { \
> +		.base = AV1_SWREG(b), \
> +		.shift = s, \
> +		.mask = m, \
> +	})
> +
> +#define AV1_REG_INTERRUPT		AV1_SWREG(1)
> +#define AV1_REG_INTERRUPT_DEC_RDY_INT	BIT(12)
> +
> +#define AV1_REG_CONFIG			AV1_SWREG(2)
> +#define AV1_REG_CONFIG_DEC_CLK_GATE_E	BIT(10)
> +
> +#define av1_dec_e			AV1_DEC_REG(1, 0, 0x1)

I personally dislike definitions in lowercase, but it's like that across
the entire driver and we must keep consistency, so it's fine.

Regards,
Angelo
