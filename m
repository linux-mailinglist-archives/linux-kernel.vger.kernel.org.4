Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F9D67CE36
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjAZOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjAZOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE1222D4;
        Thu, 26 Jan 2023 06:33:36 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 959296602E70;
        Thu, 26 Jan 2023 14:33:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674743615;
        bh=8qFUxdsl7twq591uo+X+TfuQMTvgNu9wejrziThHdEk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ngH9Ek/2a+3iJwWPHctejHS/IkeA/HAsHuLRvGU5a1xIjuL6pRKYKcCaTI1wkXecN
         y9Cdb3EDU3PhQtV+fHL3BH1mfgaQNc/YXDY7vpsHi/qCrb94EVvzR+nsMybyrGOdBI
         9hcNpWwWFJAuyaoNWr+o03VgYWOlbULq5+sXxsWUqtkRQ2XVBVJ6qebje2BqOb7bW5
         j2eXGYymttnohVyr0f4S0w0EkxTwB4k7dNTVGxQB+orkFeihT6a33VqtRM6LhZ1/qv
         WD83I+0ZdF/j63kNHPoc8F+zWkKEyvCAuKBy/UvQ6WFkNZBkImXKrhV9LNT1uIO79M
         GIPlfrRa9MWCA==
Message-ID: <beb018218c6b0763ae15e28752f3292240f664c6.camel@collabora.com>
Subject: Re: [PATCH v4 2/2] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Date:   Thu, 26 Jan 2023 09:33:24 -0500
In-Reply-To: <20230125172755.1498973-3-benjamin.gaignard@collabora.com>
References: <20230125172755.1498973-1-benjamin.gaignard@collabora.com>
         <20230125172755.1498973-3-benjamin.gaignard@collabora.com>
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

Hi Benjamin,

Le mercredi 25 janvier 2023 =C3=A0 18:27 +0100, Benjamin Gaignard a =C3=A9c=
rit=C2=A0:
> When decoding a 10bits bitstreams HEVC driver should only expose
> 10bits pixel formats.
> To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
> when bit depth change and to correctly set match_depth in pixel formats
> enumeration.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 4:
> - Only set ctx->bit_depth when hantro_reset_raw_fmt() returns is ok.
>=20
>  .../media/platform/verisilicon/hantro_drv.c   | 46 +++++++++++++++----
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>  2 files changed, 40 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 8cb4a68c9119..30abab7ac9bf 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, str=
uct vb2_queue *dst_vq)
> =20
>  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct hantro_ctx *ctx;
> -
> -	ctx =3D container_of(ctrl->handler,
> -			   struct hantro_ctx, ctrl_handler);
> -
>  	if (ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS) {
>  		const struct v4l2_ctrl_h264_sps *sps =3D ctrl->p_new.p_h264_sps;
> =20
> @@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 !=3D 0 && sps->bit_depth_luma_minus8 !=
=3D 2)
>  			/* Only 8-bit and 10-bit are supported */
>  			return -EINVAL;
> -
> -		ctx->bit_depth =3D sps->bit_depth_luma_minus8 + 8;
>  	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_VP9_FRAME) {
>  		const struct v4l2_ctrl_vp9_frame *dec_params =3D ctrl->p_new.p_vp9_fra=
me;
> =20
> @@ -286,6 +279,38 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
> =20
> +static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct hantro_ctx *ctx;
> +
> +	ctx =3D container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
> +	vpu_debug(1, "s_ctrl: id =3D %d, val =3D %d\n", ctrl->id, ctrl->val);

This trace feels redundant with the v4l2 core traces, mind dropping it ?

Other then that, the patch looks good to me, but should have included a Fix=
es
tag for backport purposes. Could it be ?

Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")

With that adjusted:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_HEVC_SPS:
> +	{
> +		const struct v4l2_ctrl_hevc_sps *sps =3D ctrl->p_new.p_hevc_sps;
> +		int bit_depth =3D sps->bit_depth_luma_minus8 + 8;
> +		int ret;
> +
> +		if (ctx->bit_depth =3D=3D bit_depth)
> +			return 0;
> +
> +		ret =3D hantro_reset_raw_fmt(ctx, bit_depth);
> +		if (!ret)
> +			ctx->bit_depth =3D bit_depth;
> +
> +		return ret;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct hantro_ctx *ctx;
> @@ -328,6 +353,11 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops =
=3D {
>  	.try_ctrl =3D hantro_try_ctrl,
>  };
> =20
> +static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops =3D {
> +	.s_ctrl =3D hantro_hevc_s_ctrl,
> +	.try_ctrl =3D hantro_try_ctrl,
> +};
> +
>  static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops =3D {
>  	.s_ctrl =3D hantro_jpeg_s_ctrl,
>  };
> @@ -470,7 +500,7 @@ static const struct hantro_ctrl controls[] =3D {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
>  			.id =3D V4L2_CID_STATELESS_HEVC_SPS,
> -			.ops =3D &hantro_ctrl_ops,
> +			.ops =3D &hantro_hevc_ctrl_ops,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/=
media/platform/verisilicon/imx8m_vpu_hw.c
> index b390228fd3b4..f850d8bddef6 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -152,6 +152,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_=
fmts[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
>  		.postprocessed =3D true,
>  		.frmsize =3D {
>  			.min_width =3D FMT_MIN_WIDTH,
> @@ -165,6 +166,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_=
fmts[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_P010,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
>  		.postprocessed =3D true,
>  		.frmsize =3D {
>  			.min_width =3D FMT_MIN_WIDTH,

