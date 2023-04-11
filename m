Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEAA6DDF90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDKPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDKPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:25:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71911A2;
        Tue, 11 Apr 2023 08:25:26 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B27866003B8;
        Tue, 11 Apr 2023 16:25:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681226725;
        bh=QrI5LXdUqCSUvlEYdIfpKAWJzTltfwj8W13yExy/6ts=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C15EErwW9Hul9r0WAFwEGAFgkbzgZ79gOp5pFP7ZxgotMxTqHCseg6bbeO2UENbAl
         O1HIMtWp65xu9vM53MCcA+U5x+gU3qvz15S66FlUGMAaI3jYvuFJOh7o7AizukJJjo
         +uO/p+fF7hKFZTfUVRfPHt2MP8o7BSyKQ3+84nY0UDTeBkNiI1fMpD2pg0EEdDJc+O
         frtOTM3mXodgobRwywZMFrC8EWlfKA+LaCVSgcV0eRe74P0RCU349GkctKajHC1UnT
         pAmDV7Q5YgJFMjMPE/OY1XVti3TN8TQY6tNSaLrAugN4G3JxQCbIxTniuMwAQyzcDj
         QGFOK02cuitsw==
Message-ID: <8725099bbc33e4c42ddc20ed73d8e32cc2348663.camel@collabora.com>
Subject: Re: [PATCH v5 12/13] media: verisilicon: Conditionally ignore
 native formats
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 11 Apr 2023 11:25:17 -0400
In-Reply-To: <20230330154043.1250736-13-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
         <20230330154043.1250736-13-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 30 mars 2023 =C3=A0 17:40 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> AV1 film grain feature requires to use the postprocessor to produce
> valid frames. In such case the driver shouldn't propose native pixels
> format but only post-processed pixels format.
> Additionally if when setting a control a value could change capture
> queue pixels formats it is needed to call hantro_reset_raw_fmt().
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro.h   |  3 +
>  .../media/platform/verisilicon/hantro_drv.c   | 14 +++--
>  .../platform/verisilicon/hantro_postproc.c    |  6 +-
>  .../media/platform/verisilicon/hantro_v4l2.c  | 57 +++++++++++++------
>  .../media/platform/verisilicon/hantro_v4l2.h  |  5 +-
>  5 files changed, 60 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/=
platform/verisilicon/hantro.h
> index a98cb40a8d3b..6523ffb74881 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -231,6 +231,8 @@ struct hantro_dev {
>   * @ctrl_handler:	Control handler used to register controls.
>   * @jpeg_quality:	User-specified JPEG compression quality.
>   * @bit_depth:		Bit depth of current frame
> + * @need_postproc:	Set to true if the bitstream features require to
> + *			use the post-processor.
>   *
>   * @codec_ops:		Set of operations related to codec mode.
>   * @postproc:		Post-processing context.
> @@ -261,6 +263,7 @@ struct hantro_ctx {
> =20
>  	const struct hantro_codec_ops *codec_ops;
>  	struct hantro_postproc_ctx postproc;
> +	bool need_postproc;
> =20
>  	/* Specific for particular codec modes. */
>  	union {
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index aef1de20fc5e..7dc9e71186b4 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -319,7 +319,7 @@ static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
>  		if (ctx->bit_depth =3D=3D bit_depth)
>  			return 0;
> =20
> -		return hantro_reset_raw_fmt(ctx, bit_depth);
> +		return hantro_reset_raw_fmt(ctx, bit_depth, false);

nit: My personal reference is to never add a boolean parameter (unless ther=
e is
only 1 parameter) to a function, as a reader will need to refer to the
definition to understand what the parameter is about. There is two easy fix=
:

1. Wrap the function with boolean into a wrapper:

/* The automatic postproc */
hantro_reset_raw_fmt()

/* The one that forces postproc */
hantro_reset_raw_fmt_forcing_postproc()

2. Use alias to true/false that gives it a readable meaning

#define HANTRO_FORCE_POSTPROC true
#define HANTRO_AUTO_POSTPROC false

One can also use an enum.

With or without this change (though I'd really like if it get cleanup later=
 as
follow up patches).

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>  	}
>  	default:
>  		return -EINVAL;
> @@ -343,7 +343,7 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
>  		if (ctx->bit_depth =3D=3D bit_depth)
>  			return 0;
> =20
> -		return hantro_reset_raw_fmt(ctx, bit_depth);
> +		return hantro_reset_raw_fmt(ctx, bit_depth, false);
>  	}
>  	default:
>  		return -EINVAL;
> @@ -363,11 +363,17 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl=
)
>  	case V4L2_CID_STATELESS_AV1_SEQUENCE:
>  	{
>  		int bit_depth =3D ctrl->p_new.p_av1_sequence->bit_depth;
> +		bool need_postproc =3D false;
> =20
> -		if (ctx->bit_depth =3D=3D bit_depth)
> +		if (ctrl->p_new.p_av1_sequence->flags
> +		    & V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT)
> +			need_postproc =3D true;
> +
> +		if (ctx->bit_depth =3D=3D bit_depth &&
> +		    ctx->need_postproc =3D=3D need_postproc)
>  			return 0;
> =20
> -		return hantro_reset_raw_fmt(ctx, bit_depth);
> +		return hantro_reset_raw_fmt(ctx, bit_depth, need_postproc);
>  	}
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drive=
rs/media/platform/verisilicon/hantro_postproc.c
> index bb16af50719d..22efa0347090 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -57,6 +57,10 @@ bool hantro_needs_postproc(const struct hantro_ctx *ct=
x,
>  {
>  	if (ctx->is_encoder)
>  		return false;
> +
> +	if (ctx->need_postproc)
> +		return true;
> +
>  	return fmt->postprocessed;
>  }
> =20
> @@ -197,7 +201,7 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  	unsigned int i, buf_size;
> =20
>  	/* this should always pick native format */
> -	fmt =3D hantro_get_default_fmt(ctx, false, ctx->bit_depth);
> +	fmt =3D hantro_get_default_fmt(ctx, false, ctx->bit_depth, false);
>  	if (!fmt)
>  		return -EINVAL;
>  	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index c218c9781e73..48b37b60c19b 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -31,15 +31,21 @@
>  #define  HANTRO_DEFAULT_BIT_DEPTH 8
> =20
>  static int hantro_set_fmt_out(struct hantro_ctx *ctx,
> -			      struct v4l2_pix_format_mplane *pix_mp);
> +			      struct v4l2_pix_format_mplane *pix_mp,
> +			      bool need_postproc);
>  static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
>  			      struct v4l2_pix_format_mplane *pix_mp);
> =20
>  static const struct hantro_fmt *
> -hantro_get_formats(const struct hantro_ctx *ctx, unsigned int *num_fmts)
> +hantro_get_formats(const struct hantro_ctx *ctx, unsigned int *num_fmts,=
 bool need_postproc)
>  {
>  	const struct hantro_fmt *formats;
> =20
> +	if (need_postproc) {
> +		*num_fmts =3D 0;
> +		return NULL;
> +	}
> +
>  	if (ctx->is_encoder) {
>  		formats =3D ctx->dev->variant->enc_fmts;
>  		*num_fmts =3D ctx->dev->variant->num_enc_fmts;
> @@ -108,7 +114,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 =
fourcc)
>  	const struct hantro_fmt *formats;
>  	unsigned int i, num_fmts;
> =20
> -	formats =3D hantro_get_formats(ctx, &num_fmts);
> +	formats =3D hantro_get_formats(ctx, &num_fmts, false);
>  	for (i =3D 0; i < num_fmts; i++)
>  		if (formats[i].fourcc =3D=3D fourcc)
>  			return &formats[i];
> @@ -121,18 +127,28 @@ hantro_find_format(const struct hantro_ctx *ctx, u3=
2 fourcc)
>  }
> =20
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int=
 bit_depth)
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream,
> +		       int bit_depth, bool need_postproc)
>  {
>  	const struct hantro_fmt *formats;
>  	unsigned int i, num_fmts;
> =20
> -	formats =3D hantro_get_formats(ctx, &num_fmts);
> +	formats =3D hantro_get_formats(ctx, &num_fmts, need_postproc);
> +	for (i =3D 0; i < num_fmts; i++) {
> +		if (bitstream =3D=3D (formats[i].codec_mode !=3D
> +				  HANTRO_MODE_NONE) &&
> +		    hantro_check_depth_match(&formats[i], bit_depth))
> +			return &formats[i];
> +	}
> +
> +	formats =3D hantro_get_postproc_formats(ctx, &num_fmts);
>  	for (i =3D 0; i < num_fmts; i++) {
>  		if (bitstream =3D=3D (formats[i].codec_mode !=3D
>  				  HANTRO_MODE_NONE) &&
>  		    hantro_check_depth_match(&formats[i], bit_depth))
>  			return &formats[i];
>  	}
> +
>  	return NULL;
>  }
> =20
> @@ -199,7 +215,7 @@ static int vidioc_enum_fmt(struct file *file, void *p=
riv,
>  	 */
>  	skip_mode_none =3D capture =3D=3D ctx->is_encoder;
> =20
> -	formats =3D hantro_get_formats(ctx, &num_fmts);
> +	formats =3D hantro_get_formats(ctx, &num_fmts, false);
>  	for (i =3D 0; i < num_fmts; i++) {
>  		bool mode_none =3D formats[i].codec_mode =3D=3D HANTRO_MODE_NONE;
>  		fmt =3D &formats[i];
> @@ -294,7 +310,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ct=
x,
> =20
>  	fmt =3D hantro_find_format(ctx, pix_mp->pixelformat);
>  	if (!fmt) {
> -		fmt =3D hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH);
> +		fmt =3D hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH, f=
alse);
>  		pix_mp->pixelformat =3D fmt->fourcc;
>  	}
> =20
> @@ -387,7 +403,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  	const struct hantro_fmt *vpu_fmt;
>  	struct v4l2_pix_format_mplane fmt;
> =20
> -	vpu_fmt =3D hantro_get_default_fmt(ctx, true, HANTRO_DEFAULT_BIT_DEPTH)=
;
> +	vpu_fmt =3D hantro_get_default_fmt(ctx, true, HANTRO_DEFAULT_BIT_DEPTH,=
 false);
>  	if (!vpu_fmt)
>  		return;
> =20
> @@ -397,17 +413,17 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  	if (ctx->is_encoder)
>  		hantro_set_fmt_cap(ctx, &fmt);
>  	else
> -		hantro_set_fmt_out(ctx, &fmt);
> +		hantro_set_fmt_out(ctx, &fmt, false);
>  }
> =20
>  int
> -hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
> +hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_po=
stproc)
>  {
>  	const struct hantro_fmt *raw_vpu_fmt;
>  	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
>  	int ret;
> =20
> -	raw_vpu_fmt =3D hantro_get_default_fmt(ctx, false, bit_depth);
> +	raw_vpu_fmt =3D hantro_get_default_fmt(ctx, false, bit_depth, need_post=
proc);
>  	if (!raw_vpu_fmt)
>  		return -EINVAL;
> =20
> @@ -420,12 +436,14 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bi=
t_depth)
>  	raw_fmt.width =3D encoded_fmt->width;
>  	raw_fmt.height =3D encoded_fmt->height;
>  	if (ctx->is_encoder)
> -		ret =3D hantro_set_fmt_out(ctx, &raw_fmt);
> +		ret =3D hantro_set_fmt_out(ctx, &raw_fmt, need_postproc);
>  	else
>  		ret =3D hantro_set_fmt_cap(ctx, &raw_fmt);
> =20
> -	if (!ret)
> +	if (!ret) {
>  		ctx->bit_depth =3D bit_depth;
> +		ctx->need_postproc =3D need_postproc;
> +	}
> =20
>  	return ret;
>  }
> @@ -433,7 +451,7 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_=
depth)
>  void hantro_reset_fmts(struct hantro_ctx *ctx)
>  {
>  	hantro_reset_encoded_fmt(ctx);
> -	hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
> +	hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH, false);
>  }
> =20
>  static void
> @@ -480,7 +498,8 @@ hantro_update_requires_hold_capture_buf(struct hantro=
_ctx *ctx, u32 fourcc)
>  }
> =20
>  static int hantro_set_fmt_out(struct hantro_ctx *ctx,
> -			      struct v4l2_pix_format_mplane *pix_mp)
> +			      struct v4l2_pix_format_mplane *pix_mp,
> +			      bool need_postproc)
>  {
>  	struct vb2_queue *vq;
>  	int ret;
> @@ -533,7 +552,9 @@ static int hantro_set_fmt_out(struct hantro_ctx *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (!ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx, hantro_get_format_depth(pix_mp->pixelformat)=
);
> +		hantro_reset_raw_fmt(ctx,
> +				     hantro_get_format_depth(pix_mp->pixelformat),
> +				     need_postproc);
> =20
>  	/* Colorimetry information are always propagated. */
>  	ctx->dst_fmt.colorspace =3D pix_mp->colorspace;
> @@ -596,7 +617,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
> +		hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH, false);
> =20
>  	/* Colorimetry information are always propagated. */
>  	ctx->src_fmt.colorspace =3D pix_mp->colorspace;
> @@ -616,7 +637,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
>  static int
>  vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_forma=
t *f)
>  {
> -	return hantro_set_fmt_out(fh_to_ctx(priv), &f->fmt.pix_mp);
> +	return hantro_set_fmt_out(fh_to_ctx(priv), &f->fmt.pix_mp, false);
>  }
> =20
>  static int
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.h
> index 9ea2fef57dcd..db0ee971e4af 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
> @@ -21,10 +21,11 @@
>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
> =20
> -int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth);
> +int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool nee=
d_postproc);
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int=
 bit_depth);
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream,
> +		       int bit_depth, bool need_postproc);
> =20
>  #endif /* HANTRO_V4L2_H_ */

