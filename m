Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8DA679D85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjAXPbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjAXPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:31:09 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FDC1B55F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:31:08 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16323754f81so950690fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1TAHlxRWlXfSC7RrW8QeHVULz1fB6gmmyRVgz9FwIe8=;
        b=DzPYiYBgIgRXXOIJ+LOTsPaQGvAiWAMYe7hWqSqnnqHyadwcZ60u+JAv/gk4ViEEfM
         BE9aXmb4G79sz042f5UsF7O3XDhRykZ3Yqis4Z3eoR6Y272F1eA4B9tYJ38SvXiiYErT
         cYxJfAkttgrGXxdi3m3DykTp/tHnN+e2yW7VdqcrjbzEGBoSLTnSt2pXUL5dxz27K1ca
         n0AoPVAzZMO27PfKeUkHiwcZ68kXsWkbt1E2W36Lm820yn1IF6n4notPeriYRgcncNPf
         MGm4wnN7kVGMZZWZK2xHRWTohpXy5pfcokmHguXQK2bCjS3Btq3uS6I2+nyB6jpZRhBo
         rWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TAHlxRWlXfSC7RrW8QeHVULz1fB6gmmyRVgz9FwIe8=;
        b=fDikW6RxgP2Ce+zB/AstqbIe/qqe4WT7qMYN/wVIKqB41ek06zl7dDBp7zhxGKnR4F
         X+Jso2UBAD1ACFg3ozfO6wp5x6KnYhKQthQyxiE66z6r1Lf6zq8Zz5mZ2+8b/e++Akgx
         XoS/voqaUYLhgBJXXJRqPsps1W7peYHohg4MH0lQc8rm7sRNDz0BwI06dUvHkOOm3ATx
         RIxHr/BJxHRVfIvZGmdaF1nTMcsvRXH/XJbkY19umEmRJsqSYendlSmPRymMgkHesgAf
         A81pHcDOY4pmF79C9WnsPSYR3d+c76DYnqusLX6DipUiEKJ3GM2VpXY0o8FMS/tA2LWC
         vvwA==
X-Gm-Message-State: AFqh2kqU0VXXh5bfW9GcVll5a1vVUz3dyV2R3aa8QNmv3wsIHcEVYxgZ
        GM+7SBWCiK2xUtMg3VwAVu2Ilg==
X-Google-Smtp-Source: AK7set9QgHtsyYeR0CMSh+bhyPFIsdp2RejJr6q7h0apUzfkTTnHEMaVHEQkkjFuy/fOXUiCfGCPKA==
X-Received: by 2002:a05:6870:a916:b0:160:3390:38b3 with SMTP id eq22-20020a056870a91600b00160339038b3mr2207612oab.5.1674574267600;
        Tue, 24 Jan 2023 07:31:07 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id b5-20020a378005000000b00704a2a40cf2sm1589618qkd.38.2023.01.24.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:31:07 -0800 (PST)
Message-ID: <4b8053c17452de7477dea179be0bf2e02be7462d.camel@ndufresne.ca>
Subject: Re: [PATCH v3] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Date:   Tue, 24 Jan 2023 10:31:05 -0500
In-Reply-To: <20230119084723.133576-1-benjamin.gaignard@collabora.com>
References: <20230119084723.133576-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 19 janvier 2023 =C3=A0 09:47 +0100, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> When decoding a 10bits bitstreams HEVC driver should only expose
> 10bits pixel formats.
> To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
> when bit depth change and to correctly set match_depth in pixel formats
> enumeration.
>=20
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 3:
> - Propagate hantro_reset_raw_fmt() error.
>   I hope I have correctly understood Ezekiel's thoughts=20
>   in the way I have implemented them.
>=20
> version 2:
> - Remove struct hantro_ctx *ctx variable in hantro_try_ctrl()
>   because it isn't used anymore.
>=20
>  .../media/platform/verisilicon/hantro_drv.c   | 40 +++++++++++++++----
>  .../media/platform/verisilicon/hantro_v4l2.c  |  6 +--
>  .../media/platform/verisilicon/hantro_v4l2.h  |  1 +
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>  4 files changed, 38 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 8cb4a68c9119..a713a45c0108 100644
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
> @@ -286,6 +279,32 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
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
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_HEVC_SPS:
> +		const struct v4l2_ctrl_hevc_sps *sps =3D ctrl->p_new.p_hevc_sps;
> +		int bit_depth =3D sps->bit_depth_luma_minus8 + 8;
> +
> +		if (ctx->bit_depth !=3D bit_depth) {
> +			ctx->bit_depth =3D bit_depth;
> +			return hantro_reset_raw_fmt(ctx);

While this match 1:1 with the review comment (chain EBUSY), it does not
conceptually solved the problem since we always modify ctx here, and then m=
odify
it futher into hantro_reset_raw_fmt() before we actually check if the queue=
 is
busy. The code needs to be reorganize to check first, and modify after. Its
quite likely that bit_depth should be a parameter to hantro_reset_raw_fmt()=
 so
we don't spread out the logic.

regards,
Nicolas

> +		}
> +		break;
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
> @@ -328,6 +347,11 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops =
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
> @@ -470,7 +494,7 @@ static const struct hantro_ctrl controls[] =3D {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
>  			.id =3D V4L2_CID_STATELESS_HEVC_SPS,
> -			.ops =3D &hantro_ctrl_ops,
> +			.ops =3D &hantro_hevc_ctrl_ops,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..cd85877bbbe2 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -398,7 +398,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  		hantro_set_fmt_out(ctx, fmt);
>  }
> =20
> -static void
> +int
>  hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  {
>  	const struct hantro_fmt *raw_vpu_fmt;
> @@ -420,9 +420,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
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
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.h
> index 64f6f57e9d7a..cb8e1fe3422d 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
> @@ -21,6 +21,7 @@
>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
> =20
> +int hantro_reset_raw_fmt(struct hantro_ctx *ctx);
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
>  const struct hantro_fmt *
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

