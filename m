Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9CC682C05
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjAaL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjAaL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:57:03 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144924CE60
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:56:59 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so922391otq.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uD6oK65t6jXXcWfZrvpRpdrNskxqShxAuqpD0uHN5U4=;
        b=CghLv7Tu61rvA4eeDPHt5DbSyC/+9UooxEd8oPKmT43MZHk0rBppfVz2PR+lng68ML
         68YlflrVu1XgHIX5anEo7incbqRpAalDsRvoBUSMnGjWoqG5UEEpeIoDlG7rKr1E4Q/H
         RW/2d+LXEj4Zd8MU6AC8xkl6aKk4VnkNDDHr3aFmMfh2ALh36NywKj8BSdCDOVz/SBkI
         GndKHI61FqxTF9vpMTtoJtNhb7pmSTQpITUHC+LGQVrFGLzQXDPq0hLgPECdqoO5pmCC
         Kyv2Gr9FKnFOaqKdojnPMJGNzLftJ4MwWOyCa6IkIOyGplG/AYZaXzSUwdo6cz1k5Kjm
         3ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uD6oK65t6jXXcWfZrvpRpdrNskxqShxAuqpD0uHN5U4=;
        b=vIqAYuIyTGylpbud98L9u23ZOv22PZjUbz1bLeoA0T+2IiUG8E7AwR9u/MpPopsWE6
         RHq0rDXU4ZGhmTyycsGz84c/zHNBRExfXcKqKjucbqaN3+fSXeUt6xnZ+pIxT9qYwq11
         189sL5psrOHdrwb2OJDRHG3kFvW14B9u8ZBNO0DUKolTKqbcHmRQWiEp35gNdG9wwLnt
         LFl8F7rzrkgn5zJJXrbZx3hsHzQdtz+CMi33Z1DAbgOxlH12SNHkGsVtkAUcU8pISoh/
         fZrDJGSZbwCsLBby5fjD5fr06D5Jeh7SnuSpZZjWD5okJc1Pm+MSjnYw4oja24JNUrFf
         2DJw==
X-Gm-Message-State: AO0yUKV35FQ+Mjc70nj4kVMOr5Ra+MzjCg/n4y/1jV7CMaIYeul/FGx5
        ZOcvCGmYQHKZ4x2Zr/jsLsNaaSEiHs4J2CWZ
X-Google-Smtp-Source: AK7set/LEWxhDzV+atwOMYN4ZCyMjKMP4Vk1bwGCEL+B62LezD044elD3w/8seDqhRIyNkoIDkR35g==
X-Received: by 2002:a9d:590e:0:b0:68b:c889:b0d9 with SMTP id t14-20020a9d590e000000b0068bc889b0d9mr1659171oth.3.1675166218288;
        Tue, 31 Jan 2023 03:56:58 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.239])
        by smtp.gmail.com with ESMTPSA id bi7-20020a056830378700b0068bb73bd95esm4697777otb.58.2023.01.31.03.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:56:57 -0800 (PST)
Date:   Tue, 31 Jan 2023 08:56:45 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v6 4/5] media: verisilicon: Do not change context bit
 depth before validating the format
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Message-Id: <LIMCPR.RP375QDMFOPN2@vanguardiasur.com.ar>
In-Reply-To: <20230130135802.744743-5-benjamin.gaignard@collabora.com>
References: <20230130135802.744743-1-benjamin.gaignard@collabora.com>
        <20230130135802.744743-5-benjamin.gaignard@collabora.com>
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

On Mon, Jan 30 2023 at 02:58:01 PM +0100, Benjamin Gaignard 
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
> +#define  HANTRO_DEFAULT_BIT_DEPTH 0
> +

The default bit_depth should be 8,
since 0 is not a valid value.

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

This should be removed, since now bit_depth will always
be 8 or 10.

> +	if (bit_depth)
> +		depth = bit_depth;
> 

Ditto.

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

Given hantro_reset_raw_fmt sets the state, I suspect it will be better
to store ctx->bit_depth here.

This will also take care of the bit_depth initialization,
at open() time, which is done with hantro_reset_fmts().

In fact, if you want this to be extra robust replace
the integer bit_depth with an enum type, and so we will
guarantee only valid values, 8 or 10 are ever used.

Thanks!
Ezequiel

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


