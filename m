Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E067F688789
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjBBTcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBBTcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:32:02 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3937264B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:31:59 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id o66so2318314oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czGjRCrCK6e9yW0qm2IQKBxoTDKPxeODrjgrPg7ScQY=;
        b=EUqM8exLUpUSvPdAe4vKYSzAirC6ZM0iGPdSWFXfokx2zAB8qU//a02Jfu3y6D8n23
         HdpSDfh330ytfGvAZjXIQVlv2t89sPlwx6UZ+t0WD5QhBR5sL5wELQJbmjlOdjulMyii
         YlYRE39uI2KICLqniqiCXqN107N4RaSLud+wV+n8R0v8+aSoG/kNmhsb0zECdrB9kn6R
         /BxS0qb8HOPRYuslDdYaVIxRbrx8LiZVTSpm+GCw0U5vm7xd2kMQW5BQiKVYHQ+WaG4W
         f9mnO/WOvYS2VEL4ZE10cgqHOblF8cAUKS8E/hheyS0RUIvuMvZezURaDL/e7m1qXuwd
         97qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czGjRCrCK6e9yW0qm2IQKBxoTDKPxeODrjgrPg7ScQY=;
        b=I8eYgOFvyVtSvGf5YGsI721BIIEiwrsXeb4nf7QTg6Dv/603QmeVK7sgHe3dD5XgKO
         HEyxadLMUCuZ3FjiYGFC6/UNsYrtUei1Cy7kpCiNH6KnFiYKLAGtPFs/3bUkHuizKRXW
         5YPJ8bUDjAsLx7zowRTVvU8UiEmW9iXYoagGisKLQgnN1wOXDFS3KTGQynPjoANIKsqW
         VzqzBpOk1oK7tXP834cvbK79UHwuwnlz4dYyTVQGYaAOO/3iDMWZRJG3C9gtoFPArltZ
         5dZ1a0l2VD7PlHSIEm0Xt+mNCAH8/5+KYiNmmwXMQ/3ERXd1WbdsA9/GH68ceVM9oKxl
         Xgfg==
X-Gm-Message-State: AO0yUKWHurZiiUrMHCzBhKcrQSXCdMA2uM0YxoI5267rspFtnygXN4+n
        tmpLP9Sz3oYLoKAWAfItPUgIvQ==
X-Google-Smtp-Source: AK7set+YTonpPTFI0B8pCVkQDlJ19P7C2BZL1HG/+XZdpZY7fVrI89+0CUE8XflSMgeyb/B93bnl8Q==
X-Received: by 2002:aca:3d0b:0:b0:360:d0db:d3c8 with SMTP id k11-20020aca3d0b000000b00360d0dbd3c8mr2819438oia.2.1675366318978;
        Thu, 02 Feb 2023 11:31:58 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.239])
        by smtp.gmail.com with ESMTPSA id a26-20020a056808099a00b00378ce4197casm43798oic.8.2023.02.02.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:31:57 -0800 (PST)
Date:   Thu, 02 Feb 2023 16:31:45 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v7 4/5] media: verisilicon: Do not change context bit
 depth before validating the format
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Message-Id: <XWWGPR.PR59XJGA0QXK3@vanguardiasur.com.ar>
In-Reply-To: <20230131130327.776899-5-benjamin.gaignard@collabora.com>
References: <20230131130327.776899-1-benjamin.gaignard@collabora.com>
        <20230131130327.776899-5-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,


On Tue, Jan 31 2023 at 02:03:26 PM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> It is needed to check if the proposed pixels format is valid before
> updating context bit depth and other internal states.
> Stop using ctx->bit_depth to check format depth match and return
> result to the caller.
> 
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> version 7:
> - Change HANTRO_DEFAULT_BIT_DEPTH value to 8.
> - Simplify hantro_check_depth_match logic.
> - Keep ctx->bit_depth as integer value because it is use
>   to compute buffers size for hevc.
> 
>  .../platform/verisilicon/hantro_postproc.c    |  2 +-
>  .../media/platform/verisilicon/hantro_v4l2.c  | 45 
> ++++++++++---------
>  .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
>  3 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c 
> b/drivers/media/platform/verisilicon/hantro_postproc.c
> index 09d8cf942689..6437423ccf3a 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -197,7 +197,7 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  	unsigned int i, buf_size;
> 
>  	/* this should always pick native format */
> -	fmt = hantro_get_default_fmt(ctx, false);
> +	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth);
>  	if (!fmt)
>  		return -EINVAL;
>  	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c 
> b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index e60151a8a401..6c5f4351b257 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -28,6 +28,8 @@
>  #include "hantro_hw.h"
>  #include "hantro_v4l2.h"
> 
> +#define HANTRO_DEFAULT_BIT_DEPTH 0

^^^
This is still not correct.

The ctx->bit_depth should always be a valid value,
even in the reset state (at open() time).

Also, I think your series takes care of HEVC, but the exact
same changes are needed for VP9, as far as I can see.

Thanks,
Ezequiel


>  static int hantro_set_fmt_out(struct hantro_ctx *ctx,
>  			      struct v4l2_pix_format_mplane *pix_mp);
>  static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
> @@ -76,17 +78,16 @@ int hantro_get_format_depth(u32 fourcc)
>  }
> 
>  static bool
> -hantro_check_depth_match(const struct hantro_ctx *ctx,
> -			 const struct hantro_fmt *fmt)
> +hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
>  {
> -	int fmt_depth, ctx_depth = 8;
> +	int fmt_depth, depth = 8;
> 
>  	if (!fmt->match_depth && !fmt->postprocessed)
>  		return true;
> 
>  	/* 0 means default depth, which is 8 */
> -	if (ctx->bit_depth)
> -		ctx_depth = ctx->bit_depth;
> +	if (bit_depth)
> +		depth = bit_depth;
> 
>  	fmt_depth = hantro_get_format_depth(fmt->fourcc);
> 
> @@ -95,9 +96,9 @@ hantro_check_depth_match(const struct hantro_ctx 
> *ctx,
>  	 * It may be possible to relax that on some HW.
>  	 */
>  	if (!fmt->match_depth)
> -		return fmt_depth <= ctx_depth;
> +		return fmt_depth <= depth;
> 
> -	return fmt_depth == ctx_depth;
> +	return fmt_depth == depth;
>  }
> 
>  static const struct hantro_fmt *
> @@ -119,7 +120,7 @@ hantro_find_format(const struct hantro_ctx *ctx, 
> u32 fourcc)
>  }
> 
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, 
> int bit_depth)
>  {
>  	const struct hantro_fmt *formats;
>  	unsigned int i, num_fmts;
> @@ -128,7 +129,7 @@ hantro_get_default_fmt(const struct hantro_ctx 
> *ctx, bool bitstream)
>  	for (i = 0; i < num_fmts; i++) {
>  		if (bitstream == (formats[i].codec_mode !=
>  				  HANTRO_MODE_NONE) &&
> -		    hantro_check_depth_match(ctx, &formats[i]))
> +		    hantro_check_depth_match(&formats[i], bit_depth))
>  			return &formats[i];
>  	}
>  	return NULL;
> @@ -203,7 +204,7 @@ static int vidioc_enum_fmt(struct file *file, 
> void *priv,
> 
>  		if (skip_mode_none == mode_none)
>  			continue;
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j == f->index) {
>  			f->pixelformat = fmt->fourcc;
> @@ -223,7 +224,7 @@ static int vidioc_enum_fmt(struct file *file, 
> void *priv,
>  	for (i = 0; i < num_fmts; i++) {
>  		fmt = &formats[i];
> 
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j == f->index) {
>  			f->pixelformat = fmt->fourcc;
> @@ -291,7 +292,7 @@ static int hantro_try_fmt(const struct hantro_ctx 
> *ctx,
> 
>  	fmt = hantro_find_format(ctx, pix_mp->pixelformat);
>  	if (!fmt) {
> -		fmt = hantro_get_default_fmt(ctx, coded);
> +		fmt = hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH);
>  		pix_mp->pixelformat = fmt->fourcc;
>  	}
> 
> @@ -379,7 +380,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  	const struct hantro_fmt *vpu_fmt;
>  	struct v4l2_pix_format_mplane fmt;
> 
> -	vpu_fmt = hantro_get_default_fmt(ctx, true);
> +	vpu_fmt = hantro_get_default_fmt(ctx, true, 
> HANTRO_DEFAULT_BIT_DEPTH);
>  	if (!vpu_fmt)
>  		return;
> 
> @@ -392,15 +393,15 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  		hantro_set_fmt_out(ctx, &fmt);
>  }
> 
> -static void
> -hantro_reset_raw_fmt(struct hantro_ctx *ctx)
> +int
> +hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
>  {
>  	const struct hantro_fmt *raw_vpu_fmt;
>  	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
> 
> -	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
> +	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth);
>  	if (!raw_vpu_fmt)
> -		return;
> +		return -EINVAL;
> 
>  	if (ctx->is_encoder)
>  		encoded_fmt = &ctx->dst_fmt;
> @@ -411,15 +412,15 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  	raw_fmt.width = encoded_fmt->width;
>  	raw_fmt.height = encoded_fmt->height;
>  	if (ctx->is_encoder)
> -		hantro_set_fmt_out(ctx, &raw_fmt);
> +		return hantro_set_fmt_out(ctx, &raw_fmt);
>  	else
> -		hantro_set_fmt_cap(ctx, &raw_fmt);
> +		return hantro_set_fmt_cap(ctx, &raw_fmt);
>  }
> 
>  void hantro_reset_fmts(struct hantro_ctx *ctx)
>  {
>  	hantro_reset_encoded_fmt(ctx);
> -	hantro_reset_raw_fmt(ctx);
> +	hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
>  }
> 
>  static void
> @@ -519,7 +520,7 @@ static int hantro_set_fmt_out(struct hantro_ctx 
> *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (!ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx);
> +		hantro_reset_raw_fmt(ctx, 
> hantro_get_format_depth(pix_mp->pixelformat));
> 
>  	/* Colorimetry information are always propagated. */
>  	ctx->dst_fmt.colorspace = pix_mp->colorspace;
> @@ -582,7 +583,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx 
> *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx);
> +		hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
> 
>  	/* Colorimetry information are always propagated. */
>  	ctx->src_fmt.colorspace = pix_mp->colorspace;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h 
> b/drivers/media/platform/verisilicon/hantro_v4l2.h
> index 64f6f57e9d7a..9ea2fef57dcd 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
> @@ -21,9 +21,10 @@
>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
> 
> +int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth);
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, 
> int bit_depth);
> 
>  #endif /* HANTRO_V4L2_H_ */
> --
> 2.34.1
> 


