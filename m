Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B160D01E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiJYPQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiJYPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:16:51 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53BCE99B;
        Tue, 25 Oct 2022 08:16:47 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DAB51C0002;
        Tue, 25 Oct 2022 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666711006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uly7ckkhJ2QaaComUjr1tUEanSEoMRUyfouydzaxF4Q=;
        b=af37qNXCOQfJN2YCS+hKn6lR8J5vIO2LiaMYB7Xu6AxkWBe5+JOGQIFTiq9aZQB6HfeM8Y
        0pMFpTGKmlScEzWJUtTvBADhoIMZFRzhESRdc5j5L1I2bIaL7vAqsAoTJldg5Wmdy5yYQU
        Uymz6VfKcZ3jkK3Hadl5UPXyrxcE2sswBsVUzefbGTQPL47JnxZ+FMqEjevB474KiQCya6
        +XyVSZ33YG0U2YXXsmo8eSC1LOvce1ZTaeY38n+xDnb7d3nCHvq1CfcJjq6e3o+eO/iIbl
        qxf85t8+KRx45IfwVOxfs51y+mT+JUqwCZcRN1UnjxdiULiS3Tu4ly4u12V1dg==
Date:   Tue, 25 Oct 2022 17:16:44 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, gregkh@linuxfoundation.org,
        wens@csie.org, samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] media: cedrus: Filter controls based on capability
Message-ID: <Y1f93E4HvTVr2DuC@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <20221024201515.34129-6-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xdfw+kjfC1LhWNk0"
Content-Disposition: inline
In-Reply-To: <20221024201515.34129-6-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdfw+kjfC1LhWNk0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon 24 Oct 22, 22:15, Jernej Skrabec wrote:
> Because not all Cedrus variants supports all codecs, controls should be
> registered only if codec related to individual control is supported by
> Cedrus.
>=20
> Replace codec enum, which is not used at all, with capabilities flags
> and register control only if capabilities are met.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 45 +++++++++++----------
>  drivers/staging/media/sunxi/cedrus/cedrus.h |  2 +-
>  2 files changed, 25 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
> index 2f284a58d787..023566b02dc5 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -77,56 +77,56 @@ static const struct cedrus_control cedrus_controls[] =
=3D {
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_MPEG2_SEQUENCE,
>  		},
> -		.codec		=3D CEDRUS_CODEC_MPEG2,
> +		.capabilities	=3D CEDRUS_CAPABILITY_MPEG2_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_MPEG2_PICTURE,
>  		},
> -		.codec		=3D CEDRUS_CODEC_MPEG2,
> +		.capabilities	=3D CEDRUS_CAPABILITY_MPEG2_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_MPEG2_QUANTISATION,
>  		},
> -		.codec		=3D CEDRUS_CODEC_MPEG2,
> +		.capabilities	=3D CEDRUS_CAPABILITY_MPEG2_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_H264_DECODE_PARAMS,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_H264_SLICE_PARAMS,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_H264_SPS,
>  			.ops	=3D &cedrus_ctrl_ops,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_H264_PPS,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_H264_SCALING_MATRIX,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_H264_PRED_WEIGHTS,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
> @@ -134,7 +134,7 @@ static const struct cedrus_control cedrus_controls[] =
=3D {
>  			.max	=3D V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
>  			.def	=3D V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
> @@ -142,7 +142,7 @@ static const struct cedrus_control cedrus_controls[] =
=3D {
>  			.max	=3D V4L2_STATELESS_H264_START_CODE_NONE,
>  			.def	=3D V4L2_STATELESS_H264_START_CODE_NONE,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	/*
>  	 * We only expose supported profiles information,
> @@ -160,20 +160,20 @@ static const struct cedrus_control cedrus_controls[=
] =3D {
>  			.menu_skip_mask =3D
>  				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
>  		},
> -		.codec		=3D CEDRUS_CODEC_H264,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_HEVC_SPS,
>  			.ops	=3D &cedrus_ctrl_ops,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_HEVC_PPS,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg =3D {
> @@ -181,13 +181,13 @@ static const struct cedrus_control cedrus_controls[=
] =3D {
>  			/* The driver can only handle 1 entry per slice for now */
>  			.dims   =3D { 1 },
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg =3D {
> @@ -197,7 +197,7 @@ static const struct cedrus_control cedrus_controls[] =
=3D {
>  			.max =3D 0xffffffff,
>  			.step =3D 1,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg =3D {
> @@ -205,7 +205,7 @@ static const struct cedrus_control cedrus_controls[] =
=3D {
>  			.max	=3D V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
>  			.def	=3D V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg =3D {
> @@ -213,19 +213,19 @@ static const struct cedrus_control cedrus_controls[=
] =3D {
>  			.max	=3D V4L2_STATELESS_HEVC_START_CODE_NONE,
>  			.def	=3D V4L2_STATELESS_HEVC_START_CODE_NONE,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id	=3D V4L2_CID_STATELESS_VP8_FRAME,
>  		},
> -		.codec		=3D CEDRUS_CODEC_VP8,
> +		.capabilities	=3D CEDRUS_CAPABILITY_VP8_DEC,
>  	},
>  	{
>  		.cfg =3D {
>  			.id =3D V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
>  		},
> -		.codec		=3D CEDRUS_CODEC_H265,
> +		.capabilities	=3D CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  };
> =20
> @@ -275,6 +275,9 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, =
struct cedrus_ctx *ctx)
>  		return -ENOMEM;
> =20
>  	for (i =3D 0; i < CEDRUS_CONTROLS_COUNT; i++) {
> +		if (!cedrus_is_capable(ctx, cedrus_controls[i].capabilities))
> +			continue;
> +
>  		ctrl =3D v4l2_ctrl_new_custom(hdl, &cedrus_controls[i].cfg,
>  					    NULL);
>  		if (hdl->error) {
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.h
> index 1a98790a99af..7a1619967513 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -57,7 +57,7 @@ enum cedrus_h264_pic_type {
> =20
>  struct cedrus_control {
>  	struct v4l2_ctrl_config cfg;
> -	enum cedrus_codec	codec;
> +	unsigned int		capabilities;
>  };
> =20
>  struct cedrus_h264_run {
> --=20
> 2.38.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--xdfw+kjfC1LhWNk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNX/dwACgkQ3cLmz3+f
v9Gb+Af/dywkX70PM27smnwIoZUvkk+GkgAiROlYkJtOX3TFHHV60AL1U7hXh481
hv4ql8tekS+p4kwbYpAEcHYj4dYvRbGyNtqiBHYTvXrZ4XzWfK6fTvZLjhQqtJg+
iqRwuARVppbTy2yCEFH77daCfcWA17IpgFt0JwAohLKFK1uiWblcM7NvLx4AB6Oy
BacxFsSAtdC7r0GrSKPLlxg/cq4CNjgwKKdqQQPjiyN4Kjvf4JyGDl7CAsmHM8Xy
rgDQf97GQ5xFFQlBqaOWx/b6J1h/3mVTCfjI435CJiy45EIFLm8h/+9ak+rvtKB4
roCIOHld+cX2Fh2pXRFt5zoCobeuDg==
=6s+C
-----END PGP SIGNATURE-----

--xdfw+kjfC1LhWNk0--
