Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF97A74F8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGKUMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGKUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:12:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20EE12F;
        Tue, 11 Jul 2023 13:12:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3453E66015A0;
        Tue, 11 Jul 2023 21:12:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689106337;
        bh=FhG74NE8si1G+ZAOGq0ZNS37Tth3K0fwaXfGnneex0A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n/mTwnhaTtC1ySSdp+4xdsjPhc20JBpAaKDt0DXeT8GXLYXkaD5wrcy1qFLT509pT
         1egRfsfWy5lva+Iu2KarPSZ7H+9/Z4M/is4W3NRFlVwCXz90eQUjfaOU3uWAPXjDe+
         tCInE4eyBVV7gt6s9OBTcfWnOytLS4xuL4UTIXucLWCIL6Nz4jIVt9lXccKwNCe2+s
         r4lVf602/vR1mqdnmOu5xY6uUdgsz8O5EsDwfsQgHGDlwH3MSbXrlGz83REV8ToS9C
         A+jwhailtn204EktVodB+8SVcWoXGFAYQ+n/DLzIhtxl9nzpA1t3YcECcrstlDnwrm
         g1DjZawBinv5g==
Message-ID: <fbf227d6a681e9c028a6348dbc6a57658b9c49e1.camel@collabora.com>
Subject: Re: [PATCH 3/3] media: mediatek: vcodec: Add driver to support 10bit
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Tue, 11 Jul 2023 16:12:08 -0400
In-Reply-To: <20230711125749.15555-4-yunfei.dong@mediatek.com>
References: <20230711125749.15555-1-yunfei.dong@mediatek.com>
         <20230711125749.15555-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 11 juillet 2023 =C3=A0 20:57 +0800, Yunfei Dong a =C3=A9crit=C2=A0=
:
> From: Mingjia Zhang <mingjia.zhang@mediatek.com>
>=20
> Adding to support capture formats V4L2_PIX_FMT_MT2110T and
> V4L2_PIX_FMT_MT2110R for 10bit playback. Need to get the size
> of each plane again when user space setting syntax to get 10bit
> information.
>=20
> V4L2_PIX_FMT_MT2110T for AV1/VP9/HEVC.
> V4L2_PIX_FMT_MT2110R for H264.
>=20
> Signed-off-by: Mingjia Zhang <mingjia.zhang@mediatek.com>
> Co-developed-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  22 ++-
>  .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   5 +
>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 140 +++++++++++++++++-
>  3 files changed, 163 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> index 5acb7dff18f2..91ed576d6821 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> @@ -37,7 +37,9 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_dec_=
ctx *ctx, int format_inde
>  {
>  	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec_pdata;
>  	const struct mtk_video_fmt *fmt;
> +	struct mtk_q_data *q_data;
>  	int num_frame_count =3D 0, i;
> +	bool ret =3D false;
> =20
>  	fmt =3D &dec_pdata->vdec_formats[format_index];
>  	for (i =3D 0; i < *dec_pdata->num_formats; i++) {
> @@ -47,10 +49,26 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_de=
c_ctx *ctx, int format_inde
>  		num_frame_count++;
>  	}
> =20
> -	if (num_frame_count =3D=3D 1 || fmt->fourcc =3D=3D V4L2_PIX_FMT_MM21)
> +	if (num_frame_count =3D=3D 1 || (!ctx->is_10bit_bitstream && fmt->fourc=
c =3D=3D V4L2_PIX_FMT_MM21))
>  		return true;
> =20
> -	return false;
> +	q_data =3D &ctx->q_data[MTK_Q_DATA_SRC];
> +	switch (q_data->fmt->fourcc) {
> +	case V4L2_PIX_FMT_H264_SLICE:
> +		if (ctx->is_10bit_bitstream && fmt->fourcc =3D=3D V4L2_PIX_FMT_MT2110R=
)
> +			ret =3D true;
> +		break;
> +	case V4L2_PIX_FMT_VP9_FRAME:
> +	case V4L2_PIX_FMT_AV1_FRAME:
> +	case V4L2_PIX_FMT_HEVC_SLICE:
> +		if (ctx->is_10bit_bitstream && fmt->fourcc =3D=3D V4L2_PIX_FMT_MT2110T=
)
> +			ret =3D true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
>  }
> =20
>  static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_dec_ctx =
*ctx,
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.h
> index c8b4374c5e6c..cd607e90fe9c 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> @@ -31,6 +31,7 @@ enum mtk_vdec_format_types {
>  	MTK_VDEC_FORMAT_AV1_FRAME =3D 0x800,
>  	MTK_VDEC_FORMAT_HEVC_FRAME =3D 0x1000,
>  	MTK_VCODEC_INNER_RACING =3D 0x20000,
> +	MTK_VDEC_IS_SUPPORT_10BIT =3D 0x40000,
>  };
> =20
>  /*
> @@ -160,6 +161,8 @@ struct mtk_vcodec_dec_pdata {
>   * @hw_id: hardware index used to identify different hardware.
>   *
>   * @msg_queue: msg queue used to store lat buffer information.
> + *
> + * @is_10bit_bitstream: set to true if it's 10bit bitstream
>   */
>  struct mtk_vcodec_dec_ctx {
>  	enum mtk_instance_type type;
> @@ -202,6 +205,8 @@ struct mtk_vcodec_dec_ctx {
>  	int hw_id;
> =20
>  	struct vdec_msg_queue msg_queue;
> +
> +	bool is_10bit_bitstream;
>  };
> =20
>  /**
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_d=
ec_stateless.c
> index 99a84c7e1901..cef937fdf462 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> @@ -200,7 +200,7 @@ static const struct mtk_stateless_control mtk_statele=
ss_controls[] =3D {
> =20
>  #define NUM_CTRLS ARRAY_SIZE(mtk_stateless_controls)
> =20
> -static struct mtk_video_fmt mtk_video_formats[7];
> +static struct mtk_video_fmt mtk_video_formats[9];
> =20
>  static struct mtk_video_fmt default_out_format;
>  static struct mtk_video_fmt default_cap_format;
> @@ -387,6 +387,134 @@ static int mtk_vdec_flush_decoder(struct mtk_vcodec=
_dec_ctx *ctx)
>  	return vdec_if_decode(ctx, NULL, NULL, &res_chg);
>  }
> =20
> +static int mtk_vcodec_get_pic_info(struct mtk_vcodec_dec_ctx *ctx)
> +{
> +	struct mtk_q_data *q_data;
> +	int ret =3D 0;
> +
> +	q_data =3D &ctx->q_data[MTK_Q_DATA_DST];
> +	if (q_data->fmt->num_planes =3D=3D 1) {
> +		mtk_v4l2_vdec_err(ctx, "[%d]Error!! 10bit mode not support one plane",=
 ctx->id);
> +		return -EINVAL;
> +	}
> +
> +	ctx->capture_fourcc =3D q_data->fmt->fourcc;
> +	ret =3D vdec_if_get_param(ctx, GET_PARAM_PIC_INFO, &ctx->picinfo);
> +	if (ret) {
> +		mtk_v4l2_vdec_err(ctx, "[%d]Error!! Get GET_PARAM_PICTURE_INFO Fail", =
ctx->id);
> +		return ret;
> +	}
> +
> +	ctx->last_decoded_picinfo =3D ctx->picinfo;
> +
> +	q_data->sizeimage[0] =3D ctx->picinfo.fb_sz[0];
> +	q_data->bytesperline[0] =3D ctx->picinfo.buf_w * 5 / 4;
> +
> +	q_data->sizeimage[1] =3D ctx->picinfo.fb_sz[1];
> +	q_data->bytesperline[1] =3D ctx->picinfo.buf_w * 5 / 4;
> +
> +	q_data->coded_width =3D ctx->picinfo.buf_w;
> +	q_data->coded_height =3D ctx->picinfo.buf_h;
> +	mtk_v4l2_vdec_dbg(1, ctx, "[%d] wxh=3D%dx%d pic wxh=3D%dx%d sz[0]=3D0x%=
x sz[1]=3D0x%x",
> +			  ctx->id, ctx->picinfo.buf_w, ctx->picinfo.buf_h,
> +			  ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> +			  q_data->sizeimage[0], q_data->sizeimage[1]);
> +
> +	return ret;
> +}
> +
> +static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct mtk_vcodec_dec_ctx *ctx =3D ctrl_to_dec_ctx(ctrl);
> +	struct v4l2_ctrl_h264_sps *h264;
> +	struct v4l2_ctrl_hevc_sps *h265;
> +	struct v4l2_ctrl_vp9_frame *frame;
> +	struct v4l2_ctrl_av1_sequence *seq;
> +	struct v4l2_ctrl *hdr_ctrl;
> +	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec_pdata;
> +	const struct mtk_video_fmt *fmt;
> +	int i =3D 0, ret =3D 0;
> +
> +	hdr_ctrl =3D ctrl;
> +	if (!hdr_ctrl || !hdr_ctrl->p_cur.p)
> +		return -EINVAL;
> +
> +	switch (hdr_ctrl->id) {
> +	case V4L2_CID_STATELESS_H264_SPS:
> +		h264 =3D (struct v4l2_ctrl_h264_sps *)hdr_ctrl->p_new.p;
> +		if (h264->bit_depth_chroma_minus8 =3D=3D 2 && h264->bit_depth_luma_min=
us8 =3D=3D 2) {
> +			ctx->is_10bit_bitstream =3D true;
> +		} else if (h264->bit_depth_chroma_minus8 !=3D 0 &&
> +			   h264->bit_depth_luma_minus8 !=3D 0) {
> +			mtk_v4l2_vdec_err(ctx, "H264: chroma_minus8:%d, luma_minus8:%d",
> +					  h264->bit_depth_chroma_minus8,
> +					  h264->bit_depth_luma_minus8);
> +			return -EINVAL;
> +		}
> +		break;
> +	case V4L2_CID_STATELESS_HEVC_SPS:
> +		h265 =3D (struct v4l2_ctrl_hevc_sps *)hdr_ctrl->p_new.p;
> +		if (h265->bit_depth_chroma_minus8 =3D=3D 2 && h265->bit_depth_luma_min=
us8 =3D=3D 2) {
> +			ctx->is_10bit_bitstream =3D true;
> +		} else if (h265->bit_depth_chroma_minus8 !=3D 0 &&
> +			   h265->bit_depth_luma_minus8 !=3D 0) {
> +			mtk_v4l2_vdec_err(ctx, "HEVC: chroma_minus8:%d, luma_minus8:%d",
> +					  h265->bit_depth_chroma_minus8,
> +					  h265->bit_depth_luma_minus8);
> +			return -EINVAL;
> +		}
> +		break;
> +	case V4L2_CID_STATELESS_VP9_FRAME:
> +		frame =3D (struct v4l2_ctrl_vp9_frame *)hdr_ctrl->p_new.p;
> +		if (frame->bit_depth =3D=3D 10) {
> +			ctx->is_10bit_bitstream =3D true;
> +		} else if (frame->bit_depth !=3D 8) {
> +			mtk_v4l2_vdec_err(ctx, "VP9: bit_depth:%d", frame->bit_depth);
> +			return -EINVAL;
> +		}
> +		break;
> +	case V4L2_CID_STATELESS_AV1_SEQUENCE:
> +		seq =3D (struct v4l2_ctrl_av1_sequence *)hdr_ctrl->p_new.p;
> +		if (seq->bit_depth =3D=3D 10) {
> +			ctx->is_10bit_bitstream =3D true;
> +		} else if (seq->bit_depth !=3D 8) {
> +			mtk_v4l2_vdec_err(ctx, "AV1: bit_depth:%d", seq->bit_depth);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		mtk_v4l2_vdec_err(ctx, "Not supported ctrl id: 0x%x\n", hdr_ctrl->id);
> +		return -EINVAL;

I can confirm we hit this for every single codec and decoding fails. Writte=
n
this way, this code should never have worked, even for 10bit decoding.

> +	}
> +
> +	if (!ctx->is_10bit_bitstream)
> +		return ret;
> +
> +	for (i =3D 0; i < *dec_pdata->num_formats; i++) {
> +		fmt =3D &dec_pdata->vdec_formats[i];
> +		if (fmt->fourcc =3D=3D V4L2_PIX_FMT_MT2110R &&
> +		    hdr_ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS) {
> +			ctx->q_data[MTK_Q_DATA_DST].fmt =3D fmt;
> +			break;
> +		}
> +
> +		if (fmt->fourcc =3D=3D V4L2_PIX_FMT_MT2110T &&
> +		    (hdr_ctrl->id =3D=3D V4L2_CID_STATELESS_HEVC_SPS ||
> +		    hdr_ctrl->id =3D=3D V4L2_CID_STATELESS_VP9_FRAME ||
> +		    hdr_ctrl->id =3D=3D V4L2_CID_STATELESS_AV1_SEQUENCE)) {
> +			ctx->q_data[MTK_Q_DATA_DST].fmt =3D fmt;
> +			break;
> +		}
> +	}
> +	ret =3D mtk_vcodec_get_pic_info(ctx);
> +
> +	return ret;
> +}
> +
> +static const struct v4l2_ctrl_ops mtk_vcodec_dec_ctrl_ops =3D {
> +	.s_ctrl =3D mtk_vdec_s_ctrl,
> +};
> +
>  static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	unsigned int i;
> @@ -399,7 +527,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcod=
ec_dec_ctx *ctx)
> =20
>  	for (i =3D 0; i < NUM_CTRLS; i++) {
>  		struct v4l2_ctrl_config cfg =3D mtk_stateless_controls[i].cfg;
> -
> +		cfg.ops =3D &mtk_vcodec_dec_ctrl_ops;
>  		v4l2_ctrl_new_custom(&ctx->ctrl_hdl, &cfg, NULL);
>  		if (ctx->ctrl_hdl.error) {
>  			mtk_v4l2_vdec_err(ctx, "Adding control %d failed %d", i,
> @@ -466,6 +594,8 @@ static void mtk_vcodec_add_formats(unsigned int fourc=
c,
>  		break;
>  	case V4L2_PIX_FMT_MM21:
>  	case V4L2_PIX_FMT_MT21C:
> +	case V4L2_PIX_FMT_MT2110T:
> +	case V4L2_PIX_FMT_MT2110R:
>  		mtk_video_formats[count_formats].fourcc =3D fourcc;
>  		mtk_video_formats[count_formats].type =3D MTK_FMT_FRAME;
>  		mtk_video_formats[count_formats].num_planes =3D 2;
> @@ -491,6 +621,12 @@ static void mtk_vcodec_get_supported_formats(struct =
mtk_vcodec_dec_ctx *ctx)
>  		mtk_vcodec_add_formats(V4L2_PIX_FMT_MT21C, ctx);
>  		cap_format_count++;
>  	}
> +	if (ctx->dev->dec_capability & MTK_VDEC_IS_SUPPORT_10BIT) {
> +		mtk_vcodec_add_formats(V4L2_PIX_FMT_MT2110T, ctx);
> +		cap_format_count++;
> +		mtk_vcodec_add_formats(V4L2_PIX_FMT_MT2110R, ctx);
> +		cap_format_count++;
> +	}
>  	if (ctx->dev->dec_capability & MTK_VDEC_FORMAT_MM21) {
>  		mtk_vcodec_add_formats(V4L2_PIX_FMT_MM21, ctx);
>  		cap_format_count++;

