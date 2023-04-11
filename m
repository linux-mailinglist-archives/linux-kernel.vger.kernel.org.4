Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3436C6DDAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDKMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDKMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675226BE;
        Tue, 11 Apr 2023 05:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E388861E22;
        Tue, 11 Apr 2023 12:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF141C433D2;
        Tue, 11 Apr 2023 12:33:50 +0000 (UTC)
Message-ID: <42eefb17-6121-9cd0-4616-4af3045ec087@xs4all.nl>
Date:   Tue, 11 Apr 2023 14:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 09/13] media: verisilicon: Add Rockchip AV1 decoder
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
 <20230330154043.1250736-10-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230330154043.1250736-10-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 30/03/2023 17:40, Benjamin Gaignard wrote:
> Implement AV1 stateless decoder for rockchip VPU981.
> It decode 8 and 10 bits AV1 bitstreams.
> AV1 scaling feature is done by the postprocessor.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/Makefile   |    1 +
>  .../media/platform/verisilicon/hantro_hw.h    |   64 +-
>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2024 +++++++++++++++++
>  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++++
>  4 files changed, 2564 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
> 

<snip>

> +static void rockchip_vpu981_av1_dec_set_tile_info(struct hantro_ctx *ctx)
> +{
> +	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
> +	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
> +	struct v4l2_av1_tile_info tile_info = ctrls->frame->tile_info;

I get this warning:

drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c: In function 'rockchip_vpu981_av1_dec_set_tile_info':
drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:635:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  635 | }
      | ^

The cause is this tile_info struct that is on the stack.

Does this have to be a copy? Or can it be a pointer to ctrls->frame->tile_info?

> +	const struct v4l2_ctrl_av1_tile_group_entry *group_entry =
> +	    ctrls->tile_group_entry;
> +	int context_update_y =
> +	    tile_info.context_update_tile_id / tile_info.tile_cols;
> +	int context_update_x =
> +	    tile_info.context_update_tile_id % tile_info.tile_cols;
> +	int context_update_tile_id =
> +	    context_update_x * tile_info.tile_rows + context_update_y;
> +	u8 *dst = av1_dec->tile_info.cpu;
> +	struct hantro_dev *vpu = ctx->dev;
> +	int tile0, tile1;
> +
> +	memset(dst, 0, av1_dec->tile_info.size);
> +
> +	for (tile0 = 0; tile0 < tile_info.tile_cols; tile0++) {
> +		for (tile1 = 0; tile1 < tile_info.tile_rows; tile1++) {
> +			int tile_id = tile1 * tile_info.tile_cols + tile0;
> +			u32 start, end;
> +			u32 y0 =
> +			    tile_info.height_in_sbs_minus_1[tile1] + 1;
> +			u32 x0 = tile_info.width_in_sbs_minus_1[tile0] + 1;
> +
> +			// tile size in SB units (width,height)
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
> +	hantro_reg_write(vpu, &av1_tile_enable,
> +			 !!((tile_info.tile_cols > 1) || (tile_info.tile_rows > 1)));
> +	hantro_reg_write(vpu, &av1_num_tile_cols_8k, tile_info.tile_cols);
> +	hantro_reg_write(vpu, &av1_num_tile_rows_8k, tile_info.tile_rows);
> +	hantro_reg_write(vpu, &av1_context_update_tile_id,
> +			 context_update_tile_id);
> +	hantro_reg_write(vpu, &av1_tile_transpose, 1);
> +	if (rockchip_vpu981_av1_tile_log2(tile_info.tile_cols) ||
> +	    rockchip_vpu981_av1_tile_log2(tile_info.tile_rows))
> +		hantro_reg_write(vpu, &av1_dec_tile_size_mag, tile_info.tile_size_bytes - 1);
> +	else
> +		hantro_reg_write(vpu, &av1_dec_tile_size_mag, 3);
> +
> +	hantro_write_addr(vpu, AV1_TILE_BASE, av1_dec->tile_info.dma);
> +}

Regards,

	Hans

