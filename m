Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8E6A2F8E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBZM7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBZM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:59:44 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72BDBF5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:59:39 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a14-20020a056830100e00b00690ed91749aso2170480otp.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DW3nkP0pOQJnDemoTdr9m+O5gWpfXFzJ/39exQqJRaA=;
        b=uaRh19DJLS/ThLLVmWAy5yYBhRnqxQaxK5w0ZNduU94/Qq7MnxvA+MLymmQW6PXE88
         VtOxGZhKDrwY+SLRWgF6dGMOwM5O2xdYGRav4yxBBVhZ5bcwxiUiLVLi2KXn4gyuO1uU
         v8p+PB61XlJgEv9BkbxM6xMERcSSeXavy/mwL2mDaskZo3+SfP3l7Bqj0sWq+T6j5rxA
         2Vbh3sVPmVYPCO7eyUFyzmVGQx40PrpJWn1IGOMaa+bY+2XxRmvvLWe1ZAvkqPrq2Lnp
         HxEaEPhBxlN95DGhH/jsySUBttyqmYM4x7A4wfA0fEaFh8njKzM4droIcwK84YZuEU8e
         h3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DW3nkP0pOQJnDemoTdr9m+O5gWpfXFzJ/39exQqJRaA=;
        b=rojbG7mtZ3OQOftSqMN7hKHj69V+LbF2tY0tYjdFcozguC6ue6ynKxkTX9RKhlSwmr
         jWqYMY3s4Val6mFr+k0qg/rsySahjIYcBM+yNHlF1iaGMpSXAE+UMcAHHExfRKJBEq+F
         trXtdoCHP2lotPb3kzAy/CiYl6JvTFLaGn9ptj5scvs85gvLwAfrz2vyFjhpgudgpSG4
         E7PeshqueAatYjUxxQpJRf+19dLc1gR8acWF/V62o6SHl8zxXT19w1EUjouYMUn7oG2v
         lNu9yYYMAFdgUtOhlEU93Ga5O6iCJW/R4Hr16V7IecDPV4+nrOirvbixFWxzbKAPoB5O
         TGQA==
X-Gm-Message-State: AO0yUKWL1qDworMvSB9qCdIpimYsAXJMaxJ8l77DwE4x9t6/AvwVRa2r
        Hg2ABFa+fZMjyL+sIGSTW4G2pA==
X-Google-Smtp-Source: AK7set8ICehBwDksb4lgfEZjpxNUaz1kfIOZ+u5dQeDv6QsTqIfCaMBty4w8gZDsqmJSIhsG97oFAA==
X-Received: by 2002:a05:6830:2470:b0:686:40e1:2bf3 with SMTP id x48-20020a056830247000b0068640e12bf3mr10316722otr.0.1677416378983;
        Sun, 26 Feb 2023 04:59:38 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.26])
        by smtp.gmail.com with ESMTPSA id do11-20020a0568300e0b00b0068bcef4f543sm1584023otb.21.2023.02.26.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 04:59:38 -0800 (PST)
Date:   Sun, 26 Feb 2023 09:59:24 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v9 4/6] media: verisilicon: Do not change context bit
 depth before validating the format
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, robert.mader@collabora.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Message-Id: <0RUOQR.EG49FVA79PZJ1@vanguardiasur.com.ar>
In-Reply-To: <20230220104849.398203-5-benjamin.gaignard@collabora.com>
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
        <20230220104849.398203-5-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Feb 20 2023 at 11:48:47 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> It is needed to check if the proposed pixels format is valid before
> updating context bit depth and other internal states.
> Stop using ctx->bit_depth to check format depth match and return
> result to the caller.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  .../platform/verisilicon/hantro_postproc.c    |  2 +-
>  .../media/platform/verisilicon/hantro_v4l2.c  | 51 
> ++++++++++---------
>  .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
>  3 files changed, 30 insertions(+), 26 deletions(-)
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
> index d94c99f875c8..d238d407f986 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -28,6 +28,8 @@
>  #include "hantro_hw.h"
>  #include "hantro_v4l2.h"
> 
> +#define  HANTRO_DEFAULT_BIT_DEPTH 8
> +
>  static int hantro_set_fmt_out(struct hantro_ctx *ctx,
>  			      struct v4l2_pix_format_mplane *pix_mp);
>  static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
> @@ -76,18 +78,13 @@ int hantro_get_format_depth(u32 fourcc)
>  }
> 
>  static bool
> -hantro_check_depth_match(const struct hantro_ctx *ctx,
> -			 const struct hantro_fmt *fmt)
> +hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
>  {
> -	int fmt_depth, ctx_depth = 8;
> +	int fmt_depth;
> 
>  	if (!fmt->match_depth && !fmt->postprocessed)
>  		return true;
> 
> -	/* 0 means default depth, which is 8 */
> -	if (ctx->bit_depth)
> -		ctx_depth = ctx->bit_depth;
> -
>  	fmt_depth = hantro_get_format_depth(fmt->fourcc);
> 
>  	/*
> @@ -95,9 +92,9 @@ hantro_check_depth_match(const struct hantro_ctx 
> *ctx,
>  	 * It may be possible to relax that on some HW.
>  	 */
>  	if (!fmt->match_depth)
> -		return fmt_depth <= ctx_depth;
> +		return fmt_depth <= bit_depth;
> 
> -	return fmt_depth == ctx_depth;
> +	return fmt_depth == bit_depth;
>  }
> 
>  static const struct hantro_fmt *
> @@ -119,7 +116,7 @@ hantro_find_format(const struct hantro_ctx *ctx, 
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
> @@ -128,7 +125,7 @@ hantro_get_default_fmt(const struct hantro_ctx 
> *ctx, bool bitstream)
>  	for (i = 0; i < num_fmts; i++) {
>  		if (bitstream == (formats[i].codec_mode !=
>  				  HANTRO_MODE_NONE) &&
> -		    hantro_check_depth_match(ctx, &formats[i]))
> +		    hantro_check_depth_match(&formats[i], bit_depth))
>  			return &formats[i];
>  	}
>  	return NULL;
> @@ -204,7 +201,7 @@ static int vidioc_enum_fmt(struct file *file, 
> void *priv,
> 
>  		if (skip_mode_none == mode_none)
>  			continue;
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j == f->index) {
>  			f->pixelformat = fmt->fourcc;
> @@ -224,7 +221,7 @@ static int vidioc_enum_fmt(struct file *file, 
> void *priv,
>  	for (i = 0; i < num_fmts; i++) {
>  		fmt = &formats[i];
> 
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j == f->index) {
>  			f->pixelformat = fmt->fourcc;
> @@ -292,7 +289,7 @@ static int hantro_try_fmt(const struct hantro_ctx 
> *ctx,
> 
>  	fmt = hantro_find_format(ctx, pix_mp->pixelformat);
>  	if (!fmt) {
> -		fmt = hantro_get_default_fmt(ctx, coded);
> +		fmt = hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH);
>  		pix_mp->pixelformat = fmt->fourcc;
>  	}
> 
> @@ -380,7 +377,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  	const struct hantro_fmt *vpu_fmt;
>  	struct v4l2_pix_format_mplane fmt;
> 
> -	vpu_fmt = hantro_get_default_fmt(ctx, true);
> +	vpu_fmt = hantro_get_default_fmt(ctx, true, 
> HANTRO_DEFAULT_BIT_DEPTH);
>  	if (!vpu_fmt)
>  		return;
> 
> @@ -393,15 +390,16 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
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
> +	int ret;
> 
> -	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
> +	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth);
>  	if (!raw_vpu_fmt)
> -		return;
> +		return -EINVAL;
> 
>  	if (ctx->is_encoder)
>  		encoded_fmt = &ctx->dst_fmt;
> @@ -412,15 +410,20 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  	raw_fmt.width = encoded_fmt->width;
>  	raw_fmt.height = encoded_fmt->height;
>  	if (ctx->is_encoder)
> -		hantro_set_fmt_out(ctx, &raw_fmt);
> +		ret = hantro_set_fmt_out(ctx, &raw_fmt);
>  	else
> -		hantro_set_fmt_cap(ctx, &raw_fmt);
> +		ret = hantro_set_fmt_cap(ctx, &raw_fmt);
> +
> +	if (!ret)
> +		ctx->bit_depth = bit_depth;
> +
> +	return ret;
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
> @@ -520,7 +523,7 @@ static int hantro_set_fmt_out(struct hantro_ctx 
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
> @@ -583,7 +586,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx 
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


