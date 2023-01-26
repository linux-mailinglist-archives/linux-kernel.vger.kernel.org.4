Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49867CE00
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjAZO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjAZO0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:26:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614BE64D9B;
        Thu, 26 Jan 2023 06:25:56 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3ACD66602D35;
        Thu, 26 Jan 2023 14:24:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674743073;
        bh=jZLZz1sJIqshnxO6ri0Zy5I0ab3cJATthNe1kU/yfNQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nsankNL5xUw5oFW6kfARNiIKi/PfUUWDT+rAzA3yFXWFgnZ7IPEErasM7KF4rRElQ
         YxLw2+Hl4T9/rQdIdcg9phVzxvBXuy1nxlY+vXlLksrDk5hWps3z/jdm9cE2Lh4K0+
         jqoiDe1v7Eh1JnEJjFeG5LMai1Mg4Xrc8cpOGXxo9YAYBmDb5pAT7sD74A42eZqqQQ
         jaT8Hb2OgmkO3vH68djTWUgdqIkYTkhJjGacS9rB1PWZsfLxUXcDkidrtz/waaXvNR
         owPxZ2x3roA7tIb77VlNdX45Gw9YAcbb7dHJScFT77ni8Hfcf7cqWDvH64j1pQHxtv
         3AKzyOzZGdHtA==
Message-ID: <76a3cde17a0b05ca563af0a2a89870d4c4ad966f.camel@collabora.com>
Subject: Re: [PATCH v4 1/2] media: verisilicon: Do not change context bit
 depth before validating the format
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Date:   Thu, 26 Jan 2023 09:24:21 -0500
In-Reply-To: <20230125172755.1498973-2-benjamin.gaignard@collabora.com>
References: <20230125172755.1498973-1-benjamin.gaignard@collabora.com>
         <20230125172755.1498973-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 25 janvier 2023 =C3=A0 18:27 +0100, Benjamin Gaignard a =C3=A9c=
rit=C2=A0:
> It is needed to check if the proposed pixels format is valid before
> updating context bit depth and other internal states.
> Stop using ctx->bit_depth to check format depth match and return
> result to the caller.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

I'm not sure if the fixes tag will do a great job, but blame indicated that=
 it
fixes. Ezequiel, can you provide your feedback on if we need a Fixes and wh=
ich
hash should be point to ? My quick blame says this:

Fixes: 953aaa1492c5 ("media: rockchip/vpu: Prepare things to support decode=
rs")

> ---
> version 4:
> - Change hantro_check_depth_match() prototype to avoid using
>   ctx->bit_depth
> - Return the result of hantro_reset_raw_fmt() to the caller.
>=20
>  .../platform/verisilicon/hantro_postproc.c    |  2 +-
>  .../media/platform/verisilicon/hantro_v4l2.c  | 53 +++++++++----------
>  .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
>  3 files changed, 28 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drive=
rs/media/platform/verisilicon/hantro_postproc.c
> index 09d8cf942689..6437423ccf3a 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -197,7 +197,7 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  	unsigned int i, buf_size;
> =20
>  	/* this should always pick native format */
> -	fmt =3D hantro_get_default_fmt(ctx, false);
> +	fmt =3D hantro_get_default_fmt(ctx, false, ctx->bit_depth);
>  	if (!fmt)
>  		return -EINVAL;
>  	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..2475bc05dee9 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -76,17 +76,16 @@ int hantro_get_format_depth(u32 fourcc)
>  }
> =20
>  static bool
> -hantro_check_depth_match(const struct hantro_ctx *ctx,
> -			 const struct hantro_fmt *fmt)
> +hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
>  {
> -	int fmt_depth, ctx_depth =3D 8;
> +	int fmt_depth, depth =3D 8;
> =20
>  	if (!fmt->match_depth && !fmt->postprocessed)
>  		return true;
> =20
>  	/* 0 means default depth, which is 8 */
> -	if (ctx->bit_depth)
> -		ctx_depth =3D ctx->bit_depth;
> +	if (bit_depth)
> +		depth =3D bit_depth;
> =20
>  	fmt_depth =3D hantro_get_format_depth(fmt->fourcc);
> =20
> @@ -95,9 +94,9 @@ hantro_check_depth_match(const struct hantro_ctx *ctx,
>  	 * It may be possible to relax that on some HW.
>  	 */
>  	if (!fmt->match_depth)
> -		return fmt_depth <=3D ctx_depth;
> +		return fmt_depth <=3D depth;
> =20
> -	return fmt_depth =3D=3D ctx_depth;
> +	return fmt_depth =3D=3D depth;
>  }
> =20
>  static const struct hantro_fmt *
> @@ -119,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 =
fourcc)
>  }
> =20
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int=
 bit_depth)
>  {
>  	const struct hantro_fmt *formats;
>  	unsigned int i, num_fmts;
> @@ -128,7 +127,7 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx, =
bool bitstream)
>  	for (i =3D 0; i < num_fmts; i++) {
>  		if (bitstream =3D=3D (formats[i].codec_mode !=3D
>  				  HANTRO_MODE_NONE) &&
> -		    hantro_check_depth_match(ctx, &formats[i]))
> +		    hantro_check_depth_match(&formats[i], bit_depth))
>  			return &formats[i];
>  	}
>  	return NULL;
> @@ -203,7 +202,7 @@ static int vidioc_enum_fmt(struct file *file, void *p=
riv,
> =20
>  		if (skip_mode_none =3D=3D mode_none)
>  			continue;
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j =3D=3D f->index) {
>  			f->pixelformat =3D fmt->fourcc;
> @@ -223,7 +222,7 @@ static int vidioc_enum_fmt(struct file *file, void *p=
riv,
>  	for (i =3D 0; i < num_fmts; i++) {
>  		fmt =3D &formats[i];
> =20
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j =3D=3D f->index) {
>  			f->pixelformat =3D fmt->fourcc;
> @@ -291,7 +290,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ct=
x,
> =20
>  	fmt =3D hantro_find_format(ctx, pix_mp->pixelformat);
>  	if (!fmt) {
> -		fmt =3D hantro_get_default_fmt(ctx, coded);
> +		fmt =3D hantro_get_default_fmt(ctx, coded, 0);
>  		pix_mp->pixelformat =3D fmt->fourcc;
>  	}
> =20
> @@ -379,15 +378,12 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  	const struct hantro_fmt *vpu_fmt;
>  	struct v4l2_pix_format_mplane *fmt;
> =20
> -	vpu_fmt =3D hantro_get_default_fmt(ctx, true);
> +	vpu_fmt =3D hantro_get_default_fmt(ctx, true, 0);
> =20
> -	if (ctx->is_encoder) {
> -		ctx->vpu_dst_fmt =3D vpu_fmt;
> +	if (ctx->is_encoder)
>  		fmt =3D &ctx->dst_fmt;
> -	} else {
> -		ctx->vpu_src_fmt =3D vpu_fmt;
> +	else
>  		fmt =3D &ctx->src_fmt;
> -	}
> =20
>  	hantro_reset_fmt(fmt, vpu_fmt);
>  	fmt->width =3D vpu_fmt->frmsize.min_width;
> @@ -398,20 +394,21 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  		hantro_set_fmt_out(ctx, fmt);
>  }
> =20
> -static void
> -hantro_reset_raw_fmt(struct hantro_ctx *ctx)
> +int
> +hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
>  {
>  	const struct hantro_fmt *raw_vpu_fmt;
>  	struct v4l2_pix_format_mplane *raw_fmt, *encoded_fmt;
> =20
> -	raw_vpu_fmt =3D hantro_get_default_fmt(ctx, false);
> +	raw_vpu_fmt =3D hantro_get_default_fmt(ctx, false, bit_depth);
> +
> +	if (!raw_vpu_fmt)
> +		return -EINVAL;
> =20
>  	if (ctx->is_encoder) {
> -		ctx->vpu_src_fmt =3D raw_vpu_fmt;
>  		raw_fmt =3D &ctx->src_fmt;
>  		encoded_fmt =3D &ctx->dst_fmt;
>  	} else {
> -		ctx->vpu_dst_fmt =3D raw_vpu_fmt;
>  		raw_fmt =3D &ctx->dst_fmt;
>  		encoded_fmt =3D &ctx->src_fmt;
>  	}
> @@ -420,15 +417,15 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  	raw_fmt->width =3D encoded_fmt->width;
>  	raw_fmt->height =3D encoded_fmt->height;
>  	if (ctx->is_encoder)
> -		hantro_set_fmt_out(ctx, raw_fmt);
> +		return hantro_set_fmt_out(ctx, raw_fmt);
>  	else
> -		hantro_set_fmt_cap(ctx, raw_fmt);
> +		return hantro_set_fmt_cap(ctx, raw_fmt);
>  }
> =20
>  void hantro_reset_fmts(struct hantro_ctx *ctx)
>  {
>  	hantro_reset_encoded_fmt(ctx);
> -	hantro_reset_raw_fmt(ctx);
> +	hantro_reset_raw_fmt(ctx, 0);
>  }
> =20
>  static void
> @@ -528,7 +525,7 @@ static int hantro_set_fmt_out(struct hantro_ctx *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (!ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx);
> +		hantro_reset_raw_fmt(ctx, hantro_get_format_depth(pix_mp->pixelformat)=
);
> =20
>  	/* Colorimetry information are always propagated. */
>  	ctx->dst_fmt.colorspace =3D pix_mp->colorspace;
> @@ -591,7 +588,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx);
> +		hantro_reset_raw_fmt(ctx, 0);
> =20
>  	/* Colorimetry information are always propagated. */
>  	ctx->src_fmt.colorspace =3D pix_mp->colorspace;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.h
> index 64f6f57e9d7a..9ea2fef57dcd 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
> @@ -21,9 +21,10 @@
>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
> =20
> +int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth);
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int=
 bit_depth);
> =20
>  #endif /* HANTRO_V4L2_H_ */

