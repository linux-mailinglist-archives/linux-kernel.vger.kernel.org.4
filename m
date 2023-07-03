Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4080374639F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGCUCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCUCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:02:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63953E47;
        Mon,  3 Jul 2023 13:02:27 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7936C6606F85;
        Mon,  3 Jul 2023 21:02:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688414546;
        bh=VwKmfhBYFk6GxvuAIj1O1k3v2yogGpoIN7sYN0amhZ0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l51t7MgcHTkYURjMQTNUXFzBHy7sJGnmzdiushsdwwyBu977n6LTO3ukuW2PbVIbs
         tOr4n+eTuIONGt7mH+KLZCMTVFvftkcCv9DKr2BgtuWP4qT5oaE9JvdNSyFsBkaC8U
         Hj+05EmWK1yqr4RlClOYxgPRFa9c5w/Omvv24H3knLg8vVyhZqUeExYns6KISD7ALn
         YLYBpdVYD471ZDs4jBWgMz6Sq7T0CABYDFnACCJj5s62rrFEF4iDUcKV1/5nwh7hyI
         aRkALK7LYSSflQgBouM6gr6MTNTJsxFsRwglZt1i6cuBWphn+sO7bVLrAe2QBb/YXx
         CDhv37Z8+/rGQ==
Message-ID: <4eade95b6e5c66e0c76b75dd6acd83796fbda230.camel@collabora.com>
Subject: Re: [PATCH v4,07/11] media: mediatek: vcodec: separate struct
 'mtk_vcodec_ctx'
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
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 03 Jul 2023 16:02:15 -0400
In-Reply-To: <20230626035346.30654-8-yunfei.dong@mediatek.com>
References: <20230626035346.30654-1-yunfei.dong@mediatek.com>
         <20230626035346.30654-8-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 26 juin 2023 =C3=A0 11:53 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> Adding different context struct for encoder and decoder and removing
> struct 'mtk_vcodec_ctx'.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/mtk_vcodec_com_drv.h      |  76 +++++
>  .../mediatek/vcodec/mtk_vcodec_dbgfs.c        |   6 +-
>  .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  10 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_dec.c |  60 ++--
>  .../platform/mediatek/vcodec/mtk_vcodec_dec.h |  10 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  10 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.h      | 158 ++++++++++
>  .../mediatek/vcodec/mtk_vcodec_dec_hw.c       |   4 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_hw.h       |   2 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_pm.c       |   8 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_pm.h       |   4 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_stateful.c |  28 +-
>  .../vcodec/mtk_vcodec_dec_stateless.c         |  22 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 269 +-----------------
>  .../platform/mediatek/vcodec/mtk_vcodec_enc.c |  78 ++---
>  .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  12 +-
>  .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  10 +-
>  .../mediatek/vcodec/mtk_vcodec_enc_drv.h      | 158 ++++++++++
>  .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |  35 ++-
>  .../mediatek/vcodec/mtk_vcodec_intr.c         |  33 ++-
>  .../mediatek/vcodec/mtk_vcodec_intr.h         |   3 +-
>  .../mediatek/vcodec/mtk_vcodec_util.c         |  12 +-
>  .../mediatek/vcodec/mtk_vcodec_util.h         |   8 +-
>  .../vcodec/vdec/vdec_av1_req_lat_if.c         |  22 +-
>  .../mediatek/vcodec/vdec/vdec_h264_if.c       |   6 +-
>  .../vcodec/vdec/vdec_h264_req_common.c        |   4 +-
>  .../vcodec/vdec/vdec_h264_req_common.h        |   4 +-
>  .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |   8 +-
>  .../vcodec/vdec/vdec_h264_req_multi_if.c      |  10 +-
>  .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  16 +-
>  .../mediatek/vcodec/vdec/vdec_vp8_if.c        |   4 +-
>  .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  10 +-
>  .../mediatek/vcodec/vdec/vdec_vp9_if.c        |   8 +-
>  .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  18 +-
>  .../platform/mediatek/vcodec/vdec_drv_base.h  |   2 +-
>  .../platform/mediatek/vcodec/vdec_drv_if.c    |   8 +-
>  .../platform/mediatek/vcodec/vdec_drv_if.h    |   8 +-
>  .../platform/mediatek/vcodec/vdec_msg_queue.c |   8 +-
>  .../platform/mediatek/vcodec/vdec_msg_queue.h |  10 +-
>  .../platform/mediatek/vcodec/vdec_vpu_if.h    |   4 +-
>  .../mediatek/vcodec/venc/venc_h264_if.c       |  12 +-
>  .../mediatek/vcodec/venc/venc_vp8_if.c        |   8 +-
>  .../platform/mediatek/vcodec/venc_drv_base.h  |   2 +-
>  .../platform/mediatek/vcodec/venc_drv_if.c    |  14 +-
>  .../platform/mediatek/vcodec/venc_drv_if.h    |   8 +-
>  .../platform/mediatek/vcodec/venc_vpu_if.h    |   2 +-
>  46 files changed, 698 insertions(+), 514 deletions(-)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_com=
_drv.h
>  create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec=
_drv.h
>  create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc=
_drv.h
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
> new file mode 100644
> index 000000000000..3b6e1faf60ce
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Yunfei Dong <yunfei.dong@mediatek.com>
> + */
> +
> +#ifndef _MTK_VCODEC_COM_DRV_H_
> +#define _MTK_VCODEC_COM_DRV_H_
> +
> +#include <linux/platform_device.h>
> +#include <linux/videodev2.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-mem2mem.h>
> +#include <media/videobuf2-core.h>
> +
> +#define MTK_VCODEC_MAX_PLANES	3
> +
> +/**
> + * enum mtk_instance_state - The state of an MTK Vcodec instance.
> + * @MTK_STATE_FREE: default state when instance is created
> + * @MTK_STATE_INIT: vcodec instance is initialized
> + * @MTK_STATE_HEADER: vdec had sps/pps header parsed or venc
> + *			had sps/pps header encoded
> + * @MTK_STATE_FLUSH: vdec is flushing. Only used by decoder
> + * @MTK_STATE_ABORT: vcodec should be aborted
> + */
> +enum mtk_instance_state {
> +	MTK_STATE_FREE =3D 0,
> +	MTK_STATE_INIT =3D 1,
> +	MTK_STATE_HEADER =3D 2,
> +	MTK_STATE_FLUSH =3D 3,
> +	MTK_STATE_ABORT =3D 4,
> +};
> +
> +enum mtk_fmt_type {
> +	MTK_FMT_DEC =3D 0,
> +	MTK_FMT_ENC =3D 1,
> +	MTK_FMT_FRAME =3D 2,
> +};
> +
> +/*
> + * struct mtk_video_fmt - Structure used to store information about pixe=
lformats
> + */
> +struct mtk_video_fmt {
> +	u32	fourcc;
> +	enum mtk_fmt_type	type;
> +	u32	num_planes;
> +	u32	flags;
> +	struct v4l2_frmsize_stepwise frmsize;
> +};
> +
> +/*
> + * struct mtk_q_data - Structure used to store information about queue
> + */
> +struct mtk_q_data {
> +	unsigned int	visible_width;
> +	unsigned int	visible_height;
> +	unsigned int	coded_width;
> +	unsigned int	coded_height;
> +	enum v4l2_field	field;
> +	unsigned int	bytesperline[MTK_VCODEC_MAX_PLANES];
> +	unsigned int	sizeimage[MTK_VCODEC_MAX_PLANES];
> +	const struct mtk_video_fmt	*fmt;
> +};
> +
> +/*
> + * enum mtk_instance_type - The type of an MTK Vcodec instance.
> + */
> +enum mtk_instance_type {
> +	MTK_INST_DECODER		=3D 0,
> +	MTK_INST_ENCODER		=3D 1,
> +};
> +
> +#endif /* _MTK_VCODEC_COM_DRV_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/=
drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> index b5cdbbfcc388..0f4bbfb3bba5 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> @@ -10,7 +10,7 @@
>  #include "mtk_vcodec_drv.h"
>  #include "mtk_vcodec_util.h"
> =20
> -static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_ctx *ctx, c=
har *buf,
> +static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_dec_ctx *ct=
x, char *buf,
>  					   int *used, int total)
>  {
>  	int curr_len;
> @@ -91,7 +91,7 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, c=
har __user *ubuf,
>  	struct mtk_vcodec_dev *vcodec_dev =3D filp->private_data;
>  	struct mtk_vcodec_dbgfs *dbgfs =3D &vcodec_dev->dbgfs;
>  	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	int total_len =3D 200 * (dbgfs->inst_count =3D=3D 0 ? 1 : dbgfs->inst_c=
ount);
>  	int used_len =3D 0, curr_len, ret;
>  	bool dbgfs_index[MTK_VDEC_DBGFS_MAX] =3D {0};
> @@ -143,7 +143,7 @@ static const struct file_operations vdec_fops =3D {
>  	.read =3D mtk_vdec_dbgfs_read,
>  };
> =20
> -void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
> +void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
>  	struct mtk_vcodec_dev *vcodec_dev =3D ctx->dev;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/=
drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
> index 241ff8197e73..372413d590c5 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
> @@ -8,7 +8,7 @@
>  #define __MTK_VCODEC_DBGFS_H__
> =20
>  struct mtk_vcodec_dev;
> -struct mtk_vcodec_ctx;
> +struct mtk_vcodec_dec_ctx;
> =20
>  /*
>   * enum mtk_vdec_dbgfs_log_index  - used to get different debug informat=
ion
> @@ -22,12 +22,12 @@ enum mtk_vdec_dbgfs_log_index {
>  /**
>   * struct mtk_vcodec_dbgfs_inst  - debugfs information for each inst
>   * @node:       list node for each inst
> - * @vcodec_ctx: struct mtk_vcodec_ctx
> + * @vcodec_ctx: struct mtk_vcodec_dec_ctx
>   * @inst_id:    index of the context that the same with ctx->id
>   */
>  struct mtk_vcodec_dbgfs_inst {
>  	struct list_head node;
> -	struct mtk_vcodec_ctx *vcodec_ctx;
> +	struct mtk_vcodec_dec_ctx *vcodec_ctx;
>  	int inst_id;
>  };
> =20
> @@ -50,12 +50,12 @@ struct mtk_vcodec_dbgfs {
>  };
> =20
>  #if defined(CONFIG_DEBUG_FS)
> -void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx);
> +void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx);
>  void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_=
id);
>  void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_en=
code);
>  void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev);
>  #else
> -static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
> +static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ct=
x)
>  {
>  }
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 269f90fe0a1a..619ff3dd8d50 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -35,7 +35,7 @@ mtk_vdec_find_format(struct v4l2_format *f,
>  	return NULL;
>  }
> =20
> -static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_=
index)
> +static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_dec_ctx *ctx, int for=
mat_index)
>  {
>  	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec_pdata;
>  	const struct mtk_video_fmt *fmt;
> @@ -55,7 +55,7 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx =
*ctx, int format_index)
>  	return false;
>  }
> =20
> -static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_ctx *ctx=
,
> +static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_dec_ctx =
*ctx,
>  					      enum v4l2_buf_type type)
>  {
>  	if (V4L2_TYPE_IS_OUTPUT(type))
> @@ -74,7 +74,7 @@ static int vidioc_try_decoder_cmd(struct file *file, vo=
id *priv,
>  static int vidioc_decoder_cmd(struct file *file, void *priv,
>  				struct v4l2_decoder_cmd *cmd)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	struct vb2_queue *src_vq, *dst_vq;
>  	int ret;
> =20
> @@ -112,23 +112,23 @@ static int vidioc_decoder_cmd(struct file *file, vo=
id *priv,
>  	return 0;
>  }
> =20
> -void mtk_vdec_unlock(struct mtk_vcodec_ctx *ctx)
> +void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	mutex_unlock(&ctx->dev->dec_mutex[ctx->hw_id]);
>  }
> =20
> -void mtk_vdec_lock(struct mtk_vcodec_ctx *ctx)
> +void mtk_vdec_lock(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	mutex_lock(&ctx->dev->dec_mutex[ctx->hw_id]);
>  }
> =20
> -void mtk_vcodec_dec_release(struct mtk_vcodec_ctx *ctx)
> +void mtk_vcodec_dec_release(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	vdec_if_deinit(ctx);
>  	ctx->state =3D MTK_STATE_FREE;
>  }
> =20
> -void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
> +void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct mtk_q_data *q_data;
> =20
> @@ -169,7 +169,7 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vco=
dec_ctx *ctx)
>  static int vidioc_vdec_qbuf(struct file *file, void *priv,
>  			    struct v4l2_buffer *buf)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
> =20
>  	if (ctx->state =3D=3D MTK_STATE_ABORT) {
>  		mtk_v4l2_vdec_err(ctx, "[%d] Call on QBUF after unrecoverable error", =
ctx->id);
> @@ -182,7 +182,7 @@ static int vidioc_vdec_qbuf(struct file *file, void *=
priv,
>  static int vidioc_vdec_dqbuf(struct file *file, void *priv,
>  			     struct v4l2_buffer *buf)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
> =20
>  	if (ctx->state =3D=3D MTK_STATE_ABORT) {
>  		mtk_v4l2_vdec_err(ctx, "[%d] Call on DQBUF after unrecoverable error",=
 ctx->id);
> @@ -194,7 +194,7 @@ static int vidioc_vdec_dqbuf(struct file *file, void =
*priv,
> =20
>  static int mtk_vcodec_dec_get_chip_name(void *priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
> =20
>  	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec")=
)
> @@ -216,7 +216,7 @@ static int mtk_vcodec_dec_get_chip_name(void *priv)
>  static int vidioc_vdec_querycap(struct file *file, void *priv,
>  				struct v4l2_capability *cap)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
>  	int platform_name =3D mtk_vcodec_dec_get_chip_name(priv);
> =20
> @@ -229,7 +229,7 @@ static int vidioc_vdec_querycap(struct file *file, vo=
id *priv,
>  static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
>  				     const struct v4l2_event_subscription *sub)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(fh);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(fh);
> =20
>  	if (ctx->dev->vdec_pdata->uses_stateless_api)
>  		return v4l2_ctrl_subscribe_event(fh, sub);
> @@ -244,7 +244,7 @@ static int vidioc_vdec_subscribe_evt(struct v4l2_fh *=
fh,
>  	}
>  }
> =20
> -static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format=
 *f,
> +static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_fo=
rmat *f,
>  			  const struct mtk_video_fmt *fmt)
>  {
>  	struct v4l2_pix_format_mplane *pix_fmt_mp =3D &f->fmt.pix_mp;
> @@ -312,7 +312,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file =
*file, void *priv,
>  				struct v4l2_format *f)
>  {
>  	const struct mtk_video_fmt *fmt;
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec_pdata;
> =20
>  	fmt =3D mtk_vdec_find_format(f, dec_pdata);
> @@ -330,7 +330,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file =
*file, void *priv,
>  {
>  	struct v4l2_pix_format_mplane *pix_fmt_mp =3D &f->fmt.pix_mp;
>  	const struct mtk_video_fmt *fmt;
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec_pdata;
> =20
>  	fmt =3D mtk_vdec_find_format(f, dec_pdata);
> @@ -351,7 +351,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file =
*file, void *priv,
>  static int vidioc_vdec_g_selection(struct file *file, void *priv,
>  			struct v4l2_selection *s)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	struct mtk_q_data *q_data;
> =20
>  	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
> @@ -400,7 +400,7 @@ static int vidioc_vdec_g_selection(struct file *file,=
 void *priv,
>  static int vidioc_vdec_s_selection(struct file *file, void *priv,
>  				struct v4l2_selection *s)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
> =20
>  	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
>  		return -EINVAL;
> @@ -422,7 +422,7 @@ static int vidioc_vdec_s_selection(struct file *file,=
 void *priv,
>  static int vidioc_vdec_s_fmt(struct file *file, void *priv,
>  			     struct v4l2_format *f)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	struct v4l2_pix_format_mplane *pix_mp;
>  	struct mtk_q_data *q_data;
>  	int ret =3D 0;
> @@ -552,7 +552,7 @@ static int vidioc_enum_framesizes(struct file *file, =
void *priv,
>  				struct v4l2_frmsizeenum *fsize)
>  {
>  	int i =3D 0;
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec_pdata;
> =20
>  	if (fsize->index !=3D 0)
> @@ -584,7 +584,7 @@ static int vidioc_enum_framesizes(struct file *file, =
void *priv,
>  static int vidioc_enum_fmt(struct v4l2_fmtdesc *f, void *priv,
>  			   bool output_queue)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec_pdata;
>  	const struct mtk_video_fmt *fmt;
>  	int i, j =3D 0;
> @@ -630,7 +630,7 @@ static int vidioc_vdec_enum_fmt_vid_out(struct file *=
file, void *priv,
>  static int vidioc_vdec_g_fmt(struct file *file, void *priv,
>  			     struct v4l2_format *f)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(priv);
>  	struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
>  	struct vb2_queue *vq;
>  	struct mtk_q_data *q_data;
> @@ -719,7 +719,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, uns=
igned int *nbuffers,
>  			    unsigned int *nplanes, unsigned int sizes[],
>  			    struct device *alloc_devs[])
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vq);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(vq);
>  	struct mtk_q_data *q_data;
>  	unsigned int i;
> =20
> @@ -761,7 +761,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, uns=
igned int *nbuffers,
> =20
>  int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct mtk_q_data *q_data;
>  	int i;
> =20
> @@ -785,7 +785,7 @@ int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
> =20
>  void vb2ops_vdec_buf_finish(struct vb2_buffer *vb)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vb2_v4l2;
>  	struct mtk_video_dec_buf *buf;
>  	bool buf_error;
> @@ -823,7 +823,7 @@ int vb2ops_vdec_buf_init(struct vb2_buffer *vb)
> =20
>  int vb2ops_vdec_start_streaming(struct vb2_queue *q, unsigned int count)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(q);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(q);
> =20
>  	if (ctx->state =3D=3D MTK_STATE_FLUSH)
>  		ctx->state =3D MTK_STATE_HEADER;
> @@ -834,7 +834,7 @@ int vb2ops_vdec_start_streaming(struct vb2_queue *q, =
unsigned int count)
>  void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
>  {
>  	struct vb2_v4l2_buffer *src_buf =3D NULL, *dst_buf =3D NULL;
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(q);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(q);
>  	int ret;
> =20
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] (%d) state=3D(%x) ctx->decoded_frame_cn=
t=3D%d",
> @@ -889,7 +889,7 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
> =20
>  static void m2mops_vdec_device_run(void *priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_dec_ctx *ctx =3D priv;
>  	struct mtk_vcodec_dev *dev =3D ctx->dev;
> =20
>  	queue_work(dev->decode_workqueue, &ctx->decode_work);
> @@ -897,7 +897,7 @@ static void m2mops_vdec_device_run(void *priv)
> =20
>  static int m2mops_vdec_job_ready(void *m2m_priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D m2m_priv;
> +	struct mtk_vcodec_dec_ctx *ctx =3D m2m_priv;
> =20
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d]", ctx->id);
> =20
> @@ -916,7 +916,7 @@ static int m2mops_vdec_job_ready(void *m2m_priv)
> =20
>  static void m2mops_vdec_job_abort(void *priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_dec_ctx *ctx =3D priv;
> =20
>  	ctx->state =3D MTK_STATE_ABORT;
>  }
> @@ -964,7 +964,7 @@ const struct v4l2_ioctl_ops mtk_vdec_ioctl_ops =3D {
>  int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
>  			   struct vb2_queue *dst_vq)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_dec_ctx *ctx =3D priv;
>  	int ret =3D 0;
> =20
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d]", ctx->id);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
> index 4572f92826f2..ece27c880e50 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
> @@ -11,6 +11,8 @@
>  #include <media/videobuf2-core.h>
>  #include <media/v4l2-mem2mem.h>
> =20
> +#include "mtk_vcodec_dec_drv.h"
> +
>  #define VCODEC_DEC_ALIGNED_64 64
>  #define VCODEC_CAPABILITY_4K_DISABLED	0x10
>  #define VCODEC_DEC_4K_CODED_WIDTH	4096U
> @@ -78,12 +80,12 @@ extern const struct mtk_vcodec_dec_pdata mtk_vdec_sin=
gle_core_pdata;
>   * mtk_vdec_lock get decoder hw lock and set curr_ctx
>   * to ctx instance that get lock
>   */
> -void mtk_vdec_unlock(struct mtk_vcodec_ctx *ctx);
> -void mtk_vdec_lock(struct mtk_vcodec_ctx *ctx);
> +void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx);
> +void mtk_vdec_lock(struct mtk_vcodec_dec_ctx *ctx);
>  int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
>  			   struct vb2_queue *dst_vq);
> -void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx);
> -void mtk_vcodec_dec_release(struct mtk_vcodec_ctx *ctx);
> +void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_dec_ctx *ctx);
> +void mtk_vcodec_dec_release(struct mtk_vcodec_dec_ctx *ctx);
> =20
>  /*
>   * VB2 ops
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 4469c2411f40..5609fd3268f2 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -25,7 +25,7 @@
>  #include "mtk_vcodec_util.h"
>  #include "mtk_vcodec_fw.h"
> =20
> -static int mtk_vcodec_get_hw_count(struct mtk_vcodec_ctx *ctx, struct mt=
k_vcodec_dev *dev)
> +static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struc=
t mtk_vcodec_dev *dev)
>  {
>  	switch (dev->vdec_pdata->hw_arch) {
>  	case MTK_VDEC_PURE_SINGLE_CORE:
> @@ -41,7 +41,7 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_ct=
x *ctx, struct mtk_vcodec
>  static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
>  {
>  	struct mtk_vcodec_dev *dev =3D priv;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	u32 cg_status =3D 0;
>  	unsigned int dec_done_status =3D 0;
>  	void __iomem *vdec_misc_addr =3D dev->reg_base[VDEC_MISC] +
> @@ -68,7 +68,7 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, =
void *priv)
>  	writel((readl(vdec_misc_addr) & ~VDEC_IRQ_CLR),
>  		dev->reg_base[VDEC_MISC] + VDEC_IRQ_CFG_REG);
> =20
> -	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
> +	wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
> =20
>  	mtk_v4l2_vdec_dbg(3, ctx, "wake up ctx %d, dec_done_status=3D%x", ctx->=
id, dec_done_status);
> =20
> @@ -137,7 +137,7 @@ static int mtk_vcodec_init_dec_resources(struct mtk_v=
codec_dev *dev)
>  static int fops_vcodec_open(struct file *file)
>  {
>  	struct mtk_vcodec_dev *dev =3D video_drvdata(file);
> -	struct mtk_vcodec_ctx *ctx =3D NULL;
> +	struct mtk_vcodec_dec_ctx *ctx =3D NULL;
>  	int ret =3D 0, i, hw_count;
>  	struct vb2_queue *src_vq;
> =20
> @@ -234,7 +234,7 @@ static int fops_vcodec_open(struct file *file)
>  static int fops_vcodec_release(struct file *file)
>  {
>  	struct mtk_vcodec_dev *dev =3D video_drvdata(file);
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(file->private_data);
> +	struct mtk_vcodec_dec_ctx *ctx =3D fh_to_dec_ctx(file->private_data);
> =20
>  	mtk_v4l2_vdec_dbg(0, ctx, "[%d] decoder", ctx->id);
>  	mutex_lock(&dev->dev_mutex);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> new file mode 100644
> index 000000000000..94870b651919
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Yunfei Dong <yunfei.dong@mediatek.com>
> + */
> +
> +#ifndef _MTK_VCODEC_DEC_DRV_H_
> +#define _MTK_VCODEC_DEC_DRV_H_
> +
> +#include "mtk_vcodec_com_drv.h"
> +#include "mtk_vcodec_fw_priv.h"
> +#include "vdec_msg_queue.h"
> +
> +/**
> + * struct vdec_pic_info  - picture size information
> + * @pic_w: picture width
> + * @pic_h: picture height
> + * @buf_w: picture buffer width (64 aligned up from pic_w)
> + * @buf_h: picture buffer heiht (64 aligned up from pic_h)
> + * @fb_sz: bitstream size of each plane
> + * E.g. suppose picture size is 176x144,
> + *      buffer size will be aligned to 176x160.
> + * @cap_fourcc: fourcc number(may changed when resolution change)
> + * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bi=
t os.
> + */
> +struct vdec_pic_info {
> +	unsigned int pic_w;
> +	unsigned int pic_h;
> +	unsigned int buf_w;
> +	unsigned int buf_h;
> +	unsigned int fb_sz[VIDEO_MAX_PLANES];
> +	unsigned int cap_fourcc;
> +	unsigned int reserved;
> +};
> +
> +/*
> + * enum mtk_vdec_hw_id - Hardware index used to separate
> + *                         different hardware
> + */
> +enum mtk_vdec_hw_id {
> +	MTK_VDEC_CORE,
> +	MTK_VDEC_LAT0,
> +	MTK_VDEC_LAT1,
> +	MTK_VDEC_LAT_SOC,
> +	MTK_VDEC_HW_MAX,
> +};
> +
> +/**
> + * struct mtk_vcodec_dec_ctx - Context (instance) private data.
> + *
> + * @type: type of the instance - decoder or encoder

For that specific tructure, it must be set to decoder only. I think its
important to document that this must stay first and is used for type checki=
ng.

> + * @dev: pointer to the mtk_vcodec_dev of the device
> + * @list: link to ctx_list of mtk_vcodec_dev
> + *
> + * @fh: struct v4l2_fh
> + * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
> + * @q_data: store information of input and output queue
> + *	    of the context
> + * @id: index of the context that this structure describes
> + * @state: state of the context
> + *
> + * @dec_if: hooked decoder driver interface
> + * @drv_handle: driver handle for specific decode/encode instance
> + *
> + * @picinfo: store picture info after header parsing
> + * @dpb_size: store dpb count after header parsing
> + *
> + * @int_cond: variable used by the waitqueue
> + * @int_type: type of the last interrupt
> + * @queue: waitqueue that can be used to wait for this context to
> + *	   finish
> + * @irq_status: irq status
> + *
> + * @ctrl_hdl: handler for v4l2 framework
> + * @decode_work: worker for the decoding
> + * @last_decoded_picinfo: pic information get from latest decode
> + * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. =
Only
> + *		     to be used with encoder and stateful decoder.
> + * @is_flushing: set to true if flushing is in progress.
> + *
> + * @current_codec: current set input codec, in V4L2 pixel format
> + * @capture_fourcc: capture queue type in V4L2 pixel format
> + *
> + * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
> + * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
> + * @quantization: enum v4l2_quantization, colorspace quantization
> + * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
> + *
> + * @decoded_frame_cnt: number of decoded frames
> + * @lock: protect variables accessed by V4L2 threads and worker thread s=
uch as
> + *	  mtk_video_dec_buf.
> + * @hw_id: hardware index used to identify different hardware.
> + *
> + * @msg_queue: msg queue used to store lat buffer information.
> + */
> +struct mtk_vcodec_dec_ctx {
> +	enum mtk_instance_type type;
> +	struct mtk_vcodec_dev *dev;
> +	struct list_head list;
> +
> +	struct v4l2_fh fh;
> +	struct v4l2_m2m_ctx *m2m_ctx;
> +	struct mtk_q_data q_data[2];
> +	int id;
> +	enum mtk_instance_state state;
> +
> +	const struct vdec_common_if *dec_if;
> +	void *drv_handle;
> +
> +	struct vdec_pic_info picinfo;
> +	int dpb_size;
> +
> +	int int_cond[MTK_VDEC_HW_MAX];
> +	int int_type[MTK_VDEC_HW_MAX];
> +	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
> +	unsigned int irq_status;
> +
> +	struct v4l2_ctrl_handler ctrl_hdl;
> +	struct work_struct decode_work;
> +	struct vdec_pic_info last_decoded_picinfo;
> +	struct v4l2_m2m_buffer empty_flush_buf;
> +	bool is_flushing;
> +
> +	u32 current_codec;
> +	u32 capture_fourcc;
> +
> +	enum v4l2_colorspace colorspace;
> +	enum v4l2_ycbcr_encoding ycbcr_enc;
> +	enum v4l2_quantization quantization;
> +	enum v4l2_xfer_func xfer_func;
> +
> +	int decoded_frame_cnt;
> +	struct mutex lock;
> +	int hw_id;
> +
> +	struct vdec_msg_queue msg_queue;
> +};
> +
> +static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *f=
h)
> +{
> +	return container_of(fh, struct mtk_vcodec_dec_ctx, fh);
> +}
> +
> +static inline struct mtk_vcodec_dec_ctx *ctrl_to_dec_ctx(struct v4l2_ctr=
l *ctrl)
> +{
> +	return container_of(ctrl->handler, struct mtk_vcodec_dec_ctx, ctrl_hdl)=
;
> +}
> +
> +/* Wake up context wait_queue */
> +static inline void
> +wake_up_dec_ctx(struct mtk_vcodec_dec_ctx *ctx, unsigned int reason, uns=
igned int hw_id)
> +{
> +	ctx->int_cond[hw_id] =3D 1;
> +	ctx->int_type[hw_id] =3D reason;
> +	wake_up_interruptible(&ctx->queue[hw_id]);
> +}
> +
> +#endif /* _MTK_VCODEC_DEC_DRV_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> index 7c4d8ec201e3..dde0894f2ab0 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> @@ -66,7 +66,7 @@ static int mtk_vdec_hw_prob_done(struct mtk_vcodec_dev =
*vdec_dev)
>  static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
>  {
>  	struct mtk_vdec_hw_dev *dev =3D priv;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	u32 cg_status;
>  	unsigned int dec_done_status;
>  	void __iomem *vdec_misc_addr =3D dev->reg_base[VDEC_HW_MISC] +
> @@ -90,7 +90,7 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, voi=
d *priv)
>  	writel(dec_done_status | VDEC_IRQ_CFG, vdec_misc_addr);
>  	writel(dec_done_status & ~VDEC_IRQ_CLR, vdec_misc_addr);
> =20
> -	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
> +	wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
> =20
>  	mtk_v4l2_vdec_dbg(3, ctx, "wake up ctx %d, dec_done_status=3D%x",
>  			  ctx->id, dec_done_status);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
> index 36faa8d9d681..d62c7f961cfa 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
> @@ -48,7 +48,7 @@ struct mtk_vdec_hw_dev {
>  	struct mtk_vcodec_dev *main_dev;
>  	void __iomem *reg_base[VDEC_HW_MAX];
> =20
> -	struct mtk_vcodec_ctx *curr_ctx;
> +	struct mtk_vcodec_dec_ctx *curr_ctx;
> =20
>  	int dec_irq;
>  	struct mtk_vcodec_pm pm;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> index 3ab996705b97..29ef00c4a326 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> @@ -143,7 +143,7 @@ static void mtk_vcodec_dec_disable_irq(struct mtk_vco=
dec_dev *vdec_dev, int hw_i
>  	}
>  }
> =20
> -static void mtk_vcodec_load_racing_info(struct mtk_vcodec_ctx *ctx)
> +static void mtk_vcodec_load_racing_info(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	void __iomem *vdec_racing_addr;
>  	int j;
> @@ -157,7 +157,7 @@ static void mtk_vcodec_load_racing_info(struct mtk_vc=
odec_ctx *ctx)
>  	mutex_unlock(&ctx->dev->dec_racing_info_mutex);
>  }
> =20
> -static void mtk_vcodec_record_racing_info(struct mtk_vcodec_ctx *ctx)
> +static void mtk_vcodec_record_racing_info(struct mtk_vcodec_dec_ctx *ctx=
)
>  {
>  	void __iomem *vdec_racing_addr;
>  	int j;
> @@ -231,7 +231,7 @@ static void mtk_vcodec_dec_child_dev_off(struct mtk_v=
codec_dev *vdec_dev,
>  	}
>  }
> =20
> -void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_i=
dx)
> +void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_dec_ctx *ctx, int =
hw_idx)
>  {
>  	mutex_lock(&ctx->dev->dec_mutex[hw_idx]);
> =20
> @@ -247,7 +247,7 @@ void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec=
_ctx *ctx, int hw_idx)
>  }
>  EXPORT_SYMBOL_GPL(mtk_vcodec_dec_enable_hardware);
> =20
> -void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_=
idx)
> +void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_dec_ctx *ctx, int=
 hw_idx)
>  {
>  	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
>  		mtk_vcodec_record_racing_info(ctx);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
> index dbcf3cabe6f3..f6c68e57bcc1 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
> @@ -11,7 +11,7 @@
> =20
>  int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vco=
dec_pm *pm);
> =20
> -void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_i=
dx);
> -void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_=
idx);
> +void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_dec_ctx *ctx, int =
hw_idx);
> +void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_dec_ctx *ctx, int=
 hw_idx);
> =20
>  #endif /* _MTK_VCODEC_DEC_PM_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statef=
ul.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> index 3c289b08bc87..93230fe7ab97 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
> @@ -55,7 +55,7 @@ static const unsigned int num_supported_formats =3D
>   * Note the buffers returned from codec driver may still be in driver's
>   * reference list.
>   */
> -static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
> +static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_dec_ctx *=
ctx)
>  {
>  	struct vdec_fb *disp_frame_buffer =3D NULL;
>  	struct mtk_video_dec_buf *dstbuf;
> @@ -98,7 +98,7 @@ static struct vb2_buffer *get_display_buffer(struct mtk=
_vcodec_ctx *ctx)
>   * previous sps/pps/resolution change decode, or do nothing if user
>   * space still owns this buffer
>   */
> -static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
> +static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_dec_ctx *ctx=
)
>  {
>  	struct mtk_video_dec_buf *dstbuf;
>  	struct vdec_fb *free_frame_buffer =3D NULL;
> @@ -173,19 +173,19 @@ static struct vb2_buffer *get_free_buffer(struct mt=
k_vcodec_ctx *ctx)
>  	return &vb->vb2_buf;
>  }
> =20
> -static void clean_display_buffer(struct mtk_vcodec_ctx *ctx)
> +static void clean_display_buffer(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	while (get_display_buffer(ctx))
>  		;
>  }
> =20
> -static void clean_free_buffer(struct mtk_vcodec_ctx *ctx)
> +static void clean_free_buffer(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	while (get_free_buffer(ctx))
>  		;
>  }
> =20
> -static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_ctx *ctx)
> +static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	static const struct v4l2_event ev_src_ch =3D {
>  		.type =3D V4L2_EVENT_SOURCE_CHANGE,
> @@ -196,7 +196,7 @@ static void mtk_vdec_queue_res_chg_event(struct mtk_v=
codec_ctx *ctx)
>  	v4l2_event_queue_fh(&ctx->fh, &ev_src_ch);
>  }
> =20
> -static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
> +static int mtk_vdec_flush_decoder(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	bool res_chg;
>  	int ret;
> @@ -211,7 +211,7 @@ static int mtk_vdec_flush_decoder(struct mtk_vcodec_c=
tx *ctx)
>  	return 0;
>  }
> =20
> -static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
> +static void mtk_vdec_update_fmt(struct mtk_vcodec_dec_ctx *ctx,
>  				unsigned int pixelformat)
>  {
>  	const struct mtk_video_fmt *fmt;
> @@ -232,7 +232,7 @@ static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx=
 *ctx,
>  	mtk_v4l2_vdec_err(ctx, "Cannot get fourcc(%d), using init value", pixel=
format);
>  }
> =20
> -static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
> +static int mtk_vdec_pic_info_update(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	unsigned int dpbsize =3D 0;
>  	int ret;
> @@ -277,8 +277,8 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec=
_ctx *ctx)
> =20
>  static void mtk_vdec_worker(struct work_struct *work)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D
> -		container_of(work, struct mtk_vcodec_ctx, decode_work);
> +	struct mtk_vcodec_dec_ctx *ctx =3D
> +		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
>  	struct mtk_vcodec_dev *dev =3D ctx->dev;
>  	struct vb2_v4l2_buffer *src_buf, *dst_buf;
>  	struct mtk_vcodec_mem buf;
> @@ -420,7 +420,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2=
_buffer *vb)
>  	bool res_chg =3D false;
>  	int ret;
>  	unsigned int dpbsize =3D 1, i;
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vb2_v4l2;
>  	struct mtk_q_data *dst_q_data;
> =20
> @@ -528,7 +528,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2=
_buffer *vb)
> =20
>  static int mtk_vdec_g_v_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D ctrl_to_ctx(ctrl);
> +	struct mtk_vcodec_dec_ctx *ctx =3D ctrl_to_dec_ctx(ctrl);
>  	int ret =3D 0;
> =20
>  	switch (ctrl->id) {
> @@ -550,7 +550,7 @@ static const struct v4l2_ctrl_ops mtk_vcodec_dec_ctrl=
_ops =3D {
>  	.g_volatile_ctrl =3D mtk_vdec_g_v_ctrl,
>  };
> =20
> -static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
> +static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct v4l2_ctrl *ctrl;
> =20
> @@ -581,7 +581,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcod=
ec_ctx *ctx)
>  	return 0;
>  }
> =20
> -static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
> +static void mtk_init_vdec_params(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	unsigned int i;
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statel=
ess.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> index ffe05ff31dd1..64e9dfd0fcb5 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> @@ -218,7 +218,7 @@ static const struct v4l2_frmsize_stepwise stepwise_fh=
d =3D {
>  	.step_height =3D 16
>  };
> =20
> -static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_ctx *ctx, i=
nt error,
> +static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_dec_ctx *ct=
x, int error,
>  					   struct media_request *src_buf_req)
>  {
>  	struct vb2_v4l2_buffer *vb2_dst;
> @@ -242,7 +242,7 @@ static void mtk_vdec_stateless_cap_to_disp(struct mtk=
_vcodec_ctx *ctx, int error
>  		v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);
>  }
> =20
> -static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx)
> +static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_dec_ctx *ct=
x)
>  {
>  	struct mtk_video_dec_buf *framebuf;
>  	struct vb2_v4l2_buffer *vb2_v4l2;
> @@ -279,15 +279,15 @@ static struct vdec_fb *vdec_get_cap_buffer(struct m=
tk_vcodec_ctx *ctx)
> =20
>  static void vb2ops_vdec_buf_request_complete(struct vb2_buffer *vb)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> =20
>  	v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->ctrl_hdl);
>  }
> =20
>  static void mtk_vdec_worker(struct work_struct *work)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D
> -		container_of(work, struct mtk_vcodec_ctx, decode_work);
> +	struct mtk_vcodec_dec_ctx *ctx =3D
> +		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
>  	struct mtk_vcodec_dev *dev =3D ctx->dev;
>  	struct vb2_v4l2_buffer *vb2_v4l2_src;
>  	struct vb2_buffer *vb2_src;
> @@ -362,7 +362,7 @@ static void mtk_vdec_worker(struct work_struct *work)
> =20
>  static void vb2ops_vdec_stateless_buf_queue(struct vb2_buffer *vb)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_vcodec_dec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vb2_v4l2 =3D to_vb2_v4l2_buffer(vb);
> =20
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] (%d) id=3D%d, vb=3D%p", ctx->id, vb->vb=
2_queue->type,
> @@ -383,14 +383,14 @@ static void vb2ops_vdec_stateless_buf_queue(struct =
vb2_buffer *vb)
>  	}
>  }
> =20
> -static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
> +static int mtk_vdec_flush_decoder(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	bool res_chg;
> =20
>  	return vdec_if_decode(ctx, NULL, NULL, &res_chg);
>  }
> =20
> -static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
> +static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	unsigned int i;
> =20
> @@ -442,7 +442,7 @@ const struct media_device_ops mtk_vcodec_media_ops =
=3D {
>  };
> =20
>  static void mtk_vcodec_add_formats(unsigned int fourcc,
> -				   struct mtk_vcodec_ctx *ctx)
> +				   struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct mtk_vcodec_dev *dev =3D ctx->dev;
>  	const struct mtk_vcodec_dec_pdata *pdata =3D dev->vdec_pdata;
> @@ -483,7 +483,7 @@ static void mtk_vcodec_add_formats(unsigned int fourc=
c,
>  			  count_formats, ctx->dev->dec_capability);
>  }
> =20
> -static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_ctx *ctx)
> +static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_dec_ctx *=
ctx)
>  {
>  	int cap_format_count =3D 0, out_format_count =3D 0;
> =20
> @@ -526,7 +526,7 @@ static void mtk_vcodec_get_supported_formats(struct m=
tk_vcodec_ctx *ctx)
>  			mtk_video_formats[cap_format_count + out_format_count - 1];
>  }
> =20
> -static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
> +static void mtk_init_vdec_params(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vb2_queue *src_vq;
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index e3230a4d7b8e..76db7770d981 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -17,13 +17,14 @@
>  #include <media/videobuf2-core.h>
> =20
>  #include "mtk_vcodec_dbgfs.h"
> +#include "mtk_vcodec_dec_drv.h"
> +#include "mtk_vcodec_enc_drv.h"
>  #include "mtk_vcodec_util.h"
>  #include "vdec_msg_queue.h"
> =20
>  #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
>  #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
> =20
> -#define MTK_VCODEC_MAX_PLANES	3
>  #define MTK_V4L2_BENCHMARK	0
>  #define WAIT_INTR_TIMEOUT_MS	1000
>  #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >=3D MTK_VDEC_LAT_SINGLE_CO=
RE)
> @@ -53,60 +54,7 @@ enum mtk_hw_reg_idx {
>  	NUM_MAX_VCODEC_REG_BASE
>  };
> =20
> -/*
> - * enum mtk_instance_type - The type of an MTK Vcodec instance.
> - */
> -enum mtk_instance_type {
> -	MTK_INST_DECODER		=3D 0,
> -	MTK_INST_ENCODER		=3D 1,
> -};
> =20
> -/**
> - * enum mtk_instance_state - The state of an MTK Vcodec instance.
> - * @MTK_STATE_FREE: default state when instance is created
> - * @MTK_STATE_INIT: vcodec instance is initialized
> - * @MTK_STATE_HEADER: vdec had sps/pps header parsed or venc
> - *			had sps/pps header encoded
> - * @MTK_STATE_FLUSH: vdec is flushing. Only used by decoder
> - * @MTK_STATE_ABORT: vcodec should be aborted
> - */
> -enum mtk_instance_state {
> -	MTK_STATE_FREE =3D 0,
> -	MTK_STATE_INIT =3D 1,
> -	MTK_STATE_HEADER =3D 2,
> -	MTK_STATE_FLUSH =3D 3,
> -	MTK_STATE_ABORT =3D 4,
> -};
> -
> -/*
> - * enum mtk_encode_param - General encoding parameters type
> - */
> -enum mtk_encode_param {
> -	MTK_ENCODE_PARAM_NONE =3D 0,
> -	MTK_ENCODE_PARAM_BITRATE =3D (1 << 0),
> -	MTK_ENCODE_PARAM_FRAMERATE =3D (1 << 1),
> -	MTK_ENCODE_PARAM_INTRA_PERIOD =3D (1 << 2),
> -	MTK_ENCODE_PARAM_FORCE_INTRA =3D (1 << 3),
> -	MTK_ENCODE_PARAM_GOP_SIZE =3D (1 << 4),
> -};
> -
> -enum mtk_fmt_type {
> -	MTK_FMT_DEC =3D 0,
> -	MTK_FMT_ENC =3D 1,
> -	MTK_FMT_FRAME =3D 2,
> -};
> -
> -/*
> - * enum mtk_vdec_hw_id - Hardware index used to separate
> - *                         different hardware
> - */
> -enum mtk_vdec_hw_id {
> -	MTK_VDEC_CORE,
> -	MTK_VDEC_LAT0,
> -	MTK_VDEC_LAT1,
> -	MTK_VDEC_LAT_SOC,
> -	MTK_VDEC_HW_MAX,
> -};
> =20
>  /*
>   * enum mtk_vdec_hw_count - Supported hardware count
> @@ -118,17 +66,6 @@ enum mtk_vdec_hw_count {
>  	MTK_VDEC_MAX_HW_COUNT,
>  };
> =20
> -/*
> - * struct mtk_video_fmt - Structure used to store information about pixe=
lformats
> - */
> -struct mtk_video_fmt {
> -	u32	fourcc;
> -	enum mtk_fmt_type	type;
> -	u32	num_planes;
> -	u32	flags;
> -	struct v4l2_frmsize_stepwise frmsize;
> -};
> -
>  /*
>   * enum mtk_q_type - Type of queue
>   */
> @@ -137,54 +74,6 @@ enum mtk_q_type {
>  	MTK_Q_DATA_DST =3D 1,
>  };
> =20
> -/*
> - * struct mtk_q_data - Structure used to store information about queue
> - */
> -struct mtk_q_data {
> -	unsigned int	visible_width;
> -	unsigned int	visible_height;
> -	unsigned int	coded_width;
> -	unsigned int	coded_height;
> -	enum v4l2_field	field;
> -	unsigned int	bytesperline[MTK_VCODEC_MAX_PLANES];
> -	unsigned int	sizeimage[MTK_VCODEC_MAX_PLANES];
> -	const struct mtk_video_fmt	*fmt;
> -};
> -
> -/**
> - * struct mtk_enc_params - General encoding parameters
> - * @bitrate: target bitrate in bits per second
> - * @num_b_frame: number of b frames between p-frame
> - * @rc_frame: frame based rate control
> - * @rc_mb: macroblock based rate control
> - * @seq_hdr_mode: H.264 sequence header is encoded separately or joined
> - *		  with the first frame
> - * @intra_period: I frame period
> - * @gop_size: group of picture size, it's used as the intra frame period
> - * @framerate_num: frame rate numerator. ex: framerate_num=3D30 and
> - *		   framerate_denom=3D1 means FPS is 30
> - * @framerate_denom: frame rate denominator. ex: framerate_num=3D30 and
> - *		     framerate_denom=3D1 means FPS is 30
> - * @h264_max_qp: Max value for H.264 quantization parameter
> - * @h264_profile: V4L2 defined H.264 profile
> - * @h264_level: V4L2 defined H.264 level
> - * @force_intra: force/insert intra frame
> - */
> -struct mtk_enc_params {
> -	unsigned int	bitrate;
> -	unsigned int	num_b_frame;
> -	unsigned int	rc_frame;
> -	unsigned int	rc_mb;
> -	unsigned int	seq_hdr_mode;
> -	unsigned int	intra_period;
> -	unsigned int	gop_size;
> -	unsigned int	framerate_num;
> -	unsigned int	framerate_denom;
> -	unsigned int	h264_max_qp;
> -	unsigned int	h264_profile;
> -	unsigned int	h264_level;
> -	unsigned int	force_intra;
> -};
> =20
>  /*
>   * struct mtk_vcodec_clk_info - Structure used to store clock name
> @@ -211,125 +100,6 @@ struct mtk_vcodec_pm {
>  	struct device	*dev;
>  };
> =20
> -/**
> - * struct vdec_pic_info  - picture size information
> - * @pic_w: picture width
> - * @pic_h: picture height
> - * @buf_w: picture buffer width (64 aligned up from pic_w)
> - * @buf_h: picture buffer heiht (64 aligned up from pic_h)
> - * @fb_sz: bitstream size of each plane
> - * E.g. suppose picture size is 176x144,
> - *      buffer size will be aligned to 176x160.
> - * @cap_fourcc: fourcc number(may changed when resolution change)
> - * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bi=
t os.
> - */
> -struct vdec_pic_info {
> -	unsigned int pic_w;
> -	unsigned int pic_h;
> -	unsigned int buf_w;
> -	unsigned int buf_h;
> -	unsigned int fb_sz[VIDEO_MAX_PLANES];
> -	unsigned int cap_fourcc;
> -	unsigned int reserved;
> -};
> -
> -/**
> - * struct mtk_vcodec_ctx - Context (instance) private data.
> - *
> - * @type: type of the instance - decoder or encoder
> - * @dev: pointer to the mtk_vcodec_dev of the device
> - * @list: link to ctx_list of mtk_vcodec_dev
> - * @fh: struct v4l2_fh
> - * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
> - * @q_data: store information of input and output queue
> - *	    of the context
> - * @id: index of the context that this structure describes
> - * @state: state of the context
> - * @param_change: indicate encode parameter type
> - * @enc_params: encoding parameters
> - * @dec_if: hooked decoder driver interface
> - * @enc_if: hooked encoder driver interface
> - * @drv_handle: driver handle for specific decode/encode instance
> - *
> - * @picinfo: store picture info after header parsing
> - * @dpb_size: store dpb count after header parsing
> - * @int_cond: variable used by the waitqueue
> - * @int_type: type of the last interrupt
> - * @queue: waitqueue that can be used to wait for this context to
> - *	   finish
> - * @irq_status: irq status
> - *
> - * @ctrl_hdl: handler for v4l2 framework
> - * @decode_work: worker for the decoding
> - * @encode_work: worker for the encoding
> - * @last_decoded_picinfo: pic information get from latest decode
> - * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. =
Only
> - *		     to be used with encoder and stateful decoder.
> - * @is_flushing: set to true if flushing is in progress.
> - * @current_codec: current set input codec, in V4L2 pixel format
> - * @capture_fourcc: capture queue type in V4L2 pixel format
> - *
> - * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
> - * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
> - * @quantization: enum v4l2_quantization, colorspace quantization
> - * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
> - * @decoded_frame_cnt: number of decoded frames
> - * @lock: protect variables accessed by V4L2 threads and worker thread s=
uch as
> - *	  mtk_video_dec_buf.
> - * @hw_id: hardware index used to identify different hardware.
> - *
> - * @msg_queue: msg queue used to store lat buffer information.
> - * @q_mutex: vb2_queue mutex.
> - */
> -struct mtk_vcodec_ctx {
> -	enum mtk_instance_type type;
> -	struct mtk_vcodec_dev *dev;
> -	struct list_head list;
> -
> -	struct v4l2_fh fh;
> -	struct v4l2_m2m_ctx *m2m_ctx;
> -	struct mtk_q_data q_data[2];
> -	int id;
> -	enum mtk_instance_state state;
> -	enum mtk_encode_param param_change;
> -	struct mtk_enc_params enc_params;
> -
> -	const struct vdec_common_if *dec_if;
> -	const struct venc_common_if *enc_if;
> -	void *drv_handle;
> -
> -	struct vdec_pic_info picinfo;
> -	int dpb_size;
> -
> -	int int_cond[MTK_VDEC_HW_MAX];
> -	int int_type[MTK_VDEC_HW_MAX];
> -	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
> -	unsigned int irq_status;
> -
> -	struct v4l2_ctrl_handler ctrl_hdl;
> -	struct work_struct decode_work;
> -	struct work_struct encode_work;
> -	struct vdec_pic_info last_decoded_picinfo;
> -	struct v4l2_m2m_buffer empty_flush_buf;
> -	bool is_flushing;
> -
> -	u32 current_codec;
> -	u32 capture_fourcc;
> -
> -	enum v4l2_colorspace colorspace;
> -	enum v4l2_ycbcr_encoding ycbcr_enc;
> -	enum v4l2_quantization quantization;
> -	enum v4l2_xfer_func xfer_func;
> -
> -	int decoded_frame_cnt;
> -	struct mutex lock;
> -	int hw_id;
> -
> -	struct vdec_msg_queue msg_queue;
> -
> -	struct mutex q_mutex;
> -};
> -
>  /*
>   * enum mtk_vdec_hw_arch - Used to separate different hardware architect=
ure
>   */
> @@ -375,12 +145,12 @@ enum mtk_vdec_format_types {
>   */
> =20
>  struct mtk_vcodec_dec_pdata {
> -	void (*init_vdec_params)(struct mtk_vcodec_ctx *ctx);
> -	int (*ctrls_setup)(struct mtk_vcodec_ctx *ctx);
> +	void (*init_vdec_params)(struct mtk_vcodec_dec_ctx *ctx);
> +	int (*ctrls_setup)(struct mtk_vcodec_dec_ctx *ctx);
>  	void (*worker)(struct work_struct *work);
> -	int (*flush_decoder)(struct mtk_vcodec_ctx *ctx);
> -	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_ctx *ctx);
> -	void (*cap_to_disp)(struct mtk_vcodec_ctx *ctx, int error,
> +	int (*flush_decoder)(struct mtk_vcodec_dec_ctx *ctx);
> +	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_dec_ctx *ctx);
> +	void (*cap_to_disp)(struct mtk_vcodec_dec_ctx *ctx, int error,
>  			    struct media_request *src_buf_req);
> =20
>  	struct vb2_ops *vdec_vb2_ops;
> @@ -434,9 +204,10 @@ struct mtk_vcodec_enc_pdata {
>   * @m2m_dev_dec: m2m device for decoder
>   * @m2m_dev_enc: m2m device for encoder.
>   * @plat_dev: platform device
> - * @ctx_list: list of struct mtk_vcodec_ctx
> + * @ctx_list: list of struct mtk_vcodec_dec_ctx
>   * @irqlock: protect data access by irq handler and work thread
>   * @curr_ctx: The context that is waiting for codec hardware
> + * @curr_enc_ctx: The encoder context that is waiting for codec hardware
>   *
>   * @reg_base: Mapped address of MTK Vcodec registers.
>   * @vdec_pdata: decoder IC-specific data
> @@ -482,7 +253,8 @@ struct mtk_vcodec_dev {
>  	struct platform_device *plat_dev;
>  	struct list_head ctx_list;
>  	spinlock_t irqlock;
> -	struct mtk_vcodec_ctx *curr_ctx;
> +	struct mtk_vcodec_dec_ctx *curr_ctx;
> +	struct mtk_vcodec_enc_ctx *curr_enc_ctx;
>  	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
>  	const struct mtk_vcodec_dec_pdata *vdec_pdata;
>  	const struct mtk_vcodec_enc_pdata *venc_pdata;
> @@ -520,23 +292,4 @@ struct mtk_vcodec_dev {
>  	struct mtk_vcodec_dbgfs dbgfs;
>  };
> =20
> -static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
> -{
> -	return container_of(fh, struct mtk_vcodec_ctx, fh);
> -}
> -
> -static inline struct mtk_vcodec_ctx *ctrl_to_ctx(struct v4l2_ctrl *ctrl)
> -{
> -	return container_of(ctrl->handler, struct mtk_vcodec_ctx, ctrl_hdl);
> -}
> -
> -/* Wake up context wait_queue */
> -static inline void
> -wake_up_ctx(struct mtk_vcodec_ctx *ctx, unsigned int reason, unsigned in=
t hw_id)
> -{
> -	ctx->int_cond[hw_id] =3D 1;
> -	ctx->int_type[hw_id] =3D reason;
> -	wake_up_interruptible(&ctx->queue[hw_id]);
> -}
> -
>  #endif /* _MTK_VCODEC_DRV_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index 276da79d98e7..deabf012848e 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -45,7 +45,7 @@ static const struct v4l2_frmsize_stepwise mtk_venc_4k_f=
ramesizes =3D {
> =20
>  static int vidioc_venc_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D ctrl_to_ctx(ctrl);
> +	struct mtk_vcodec_enc_ctx *ctx =3D ctrl_to_enc_ctx(ctrl);
>  	struct mtk_enc_params *p =3D &ctx->enc_params;
>  	int ret =3D 0;
> =20
> @@ -162,7 +162,7 @@ static int vidioc_enum_framesizes(struct file *file, =
void *fh,
>  				  struct v4l2_frmsizeenum *fsize)
>  {
>  	const struct mtk_video_fmt *fmt;
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(fh);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(fh);
> =20
>  	if (fsize->index !=3D 0)
>  		return -EINVAL;
> @@ -186,7 +186,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file,=
 void *priv,
>  				   struct v4l2_fmtdesc *f)
>  {
>  	const struct mtk_vcodec_enc_pdata *pdata =3D
> -		fh_to_ctx(priv)->dev->venc_pdata;
> +		fh_to_enc_ctx(priv)->dev->venc_pdata;
> =20
>  	return vidioc_enum_fmt(f, pdata->capture_formats,
>  			       pdata->num_capture_formats);
> @@ -196,7 +196,7 @@ static int vidioc_enum_fmt_vid_out(struct file *file,=
 void *priv,
>  				   struct v4l2_fmtdesc *f)
>  {
>  	const struct mtk_vcodec_enc_pdata *pdata =3D
> -		fh_to_ctx(priv)->dev->venc_pdata;
> +		fh_to_enc_ctx(priv)->dev->venc_pdata;
> =20
>  	return vidioc_enum_fmt(f, pdata->output_formats,
>  			       pdata->num_output_formats);
> @@ -204,7 +204,7 @@ static int vidioc_enum_fmt_vid_out(struct file *file,=
 void *priv,
> =20
>  static int mtk_vcodec_enc_get_chip_name(void *priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
> =20
>  	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-enc")=
)
> @@ -224,7 +224,7 @@ static int mtk_vcodec_enc_get_chip_name(void *priv)
>  static int vidioc_venc_querycap(struct file *file, void *priv,
>  				struct v4l2_capability *cap)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
>  	int platform_name =3D mtk_vcodec_enc_get_chip_name(priv);
> =20
> @@ -237,7 +237,7 @@ static int vidioc_venc_querycap(struct file *file, vo=
id *priv,
>  static int vidioc_venc_s_parm(struct file *file, void *priv,
>  			      struct v4l2_streamparm *a)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	struct v4l2_fract *timeperframe =3D &a->parm.output.timeperframe;
> =20
>  	if (a->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> @@ -260,7 +260,7 @@ static int vidioc_venc_s_parm(struct file *file, void=
 *priv,
>  static int vidioc_venc_g_parm(struct file *file, void *priv,
>  			      struct v4l2_streamparm *a)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
> =20
>  	if (a->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>  		return -EINVAL;
> @@ -274,7 +274,7 @@ static int vidioc_venc_g_parm(struct file *file, void=
 *priv,
>  	return 0;
>  }
> =20
> -static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_ctx *ctx=
,
> +static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_enc_ctx =
*ctx,
>  					      enum v4l2_buf_type type)
>  {
>  	if (V4L2_TYPE_IS_OUTPUT(type))
> @@ -294,7 +294,7 @@ static void vidioc_try_fmt_cap(struct v4l2_format *f)
>  /* V4L2 specification suggests the driver corrects the format struct if =
any of
>   * the dimensions is unsupported
>   */
> -static int vidioc_try_fmt_out(struct mtk_vcodec_ctx *ctx, struct v4l2_fo=
rmat *f,
> +static int vidioc_try_fmt_out(struct mtk_vcodec_enc_ctx *ctx, struct v4l=
2_format *f,
>  			      const struct mtk_video_fmt *fmt)
>  {
>  	struct v4l2_pix_format_mplane *pix_fmt_mp =3D &f->fmt.pix_mp;
> @@ -367,8 +367,8 @@ static int vidioc_try_fmt_out(struct mtk_vcodec_ctx *=
ctx, struct v4l2_format *f,
>  	return 0;
>  }
> =20
> -static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
> -				struct venc_enc_param *param)
> +static void mtk_venc_set_param(struct mtk_vcodec_enc_ctx *ctx,
> +			       struct venc_enc_param *param)
>  {
>  	struct mtk_q_data *q_data_src =3D &ctx->q_data[MTK_Q_DATA_SRC];
>  	struct mtk_enc_params *enc_params =3D &ctx->enc_params;
> @@ -417,7 +417,7 @@ static void mtk_venc_set_param(struct mtk_vcodec_ctx =
*ctx,
>  static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
>  			     struct v4l2_format *f)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	const struct mtk_vcodec_enc_pdata *pdata =3D ctx->dev->venc_pdata;
>  	struct vb2_queue *vq;
>  	struct mtk_q_data *q_data =3D mtk_venc_get_q_data(ctx, f->type);
> @@ -472,7 +472,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, v=
oid *priv,
>  static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
>  			     struct v4l2_format *f)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	const struct mtk_vcodec_enc_pdata *pdata =3D ctx->dev->venc_pdata;
>  	struct vb2_queue *vq;
>  	struct mtk_q_data *q_data =3D mtk_venc_get_q_data(ctx, f->type);
> @@ -527,7 +527,7 @@ static int vidioc_venc_g_fmt(struct file *file, void =
*priv,
>  			     struct v4l2_format *f)
>  {
>  	struct v4l2_pix_format_mplane *pix =3D &f->fmt.pix_mp;
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	struct vb2_queue *vq;
>  	struct mtk_q_data *q_data =3D mtk_venc_get_q_data(ctx, f->type);
>  	int i;
> @@ -560,7 +560,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file =
*file, void *priv,
>  					 struct v4l2_format *f)
>  {
>  	const struct mtk_video_fmt *fmt;
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	const struct mtk_vcodec_enc_pdata *pdata =3D ctx->dev->venc_pdata;
> =20
>  	fmt =3D mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
> @@ -582,7 +582,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file =
*file, void *priv,
>  					 struct v4l2_format *f)
>  {
>  	const struct mtk_video_fmt *fmt;
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	const struct mtk_vcodec_enc_pdata *pdata =3D ctx->dev->venc_pdata;
> =20
>  	fmt =3D mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
> @@ -603,7 +603,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file =
*file, void *priv,
>  static int vidioc_venc_g_selection(struct file *file, void *priv,
>  				     struct v4l2_selection *s)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	struct mtk_q_data *q_data =3D mtk_venc_get_q_data(ctx, s->type);
> =20
>  	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT)
> @@ -633,7 +633,7 @@ static int vidioc_venc_g_selection(struct file *file,=
 void *priv,
>  static int vidioc_venc_s_selection(struct file *file, void *priv,
>  				     struct v4l2_selection *s)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	struct mtk_q_data *q_data =3D mtk_venc_get_q_data(ctx, s->type);
> =20
>  	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT)
> @@ -658,7 +658,7 @@ static int vidioc_venc_s_selection(struct file *file,=
 void *priv,
>  static int vidioc_venc_qbuf(struct file *file, void *priv,
>  			    struct v4l2_buffer *buf)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
> =20
>  	if (ctx->state =3D=3D MTK_STATE_ABORT) {
>  		mtk_v4l2_venc_err(ctx, "[%d] Call on QBUF after unrecoverable error",
> @@ -672,7 +672,7 @@ static int vidioc_venc_qbuf(struct file *file, void *=
priv,
>  static int vidioc_venc_dqbuf(struct file *file, void *priv,
>  			     struct v4l2_buffer *buf)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	int ret;
> =20
>  	if (ctx->state =3D=3D MTK_STATE_ABORT) {
> @@ -710,7 +710,7 @@ static int vidioc_venc_dqbuf(struct file *file, void =
*priv,
>  static int vidioc_encoder_cmd(struct file *file, void *priv,
>  			      struct v4l2_encoder_cmd *cmd)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(priv);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(priv);
>  	struct vb2_queue *src_vq, *dst_vq;
>  	int ret;
> =20
> @@ -804,7 +804,7 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *=
vq,
>  				   unsigned int sizes[],
>  				   struct device *alloc_devs[])
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vq);
> +	struct mtk_vcodec_enc_ctx *ctx =3D vb2_get_drv_priv(vq);
>  	struct mtk_q_data *q_data =3D mtk_venc_get_q_data(ctx, vq->type);
>  	unsigned int i;
> =20
> @@ -826,7 +826,7 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *=
vq,
> =20
>  static int vb2ops_venc_buf_prepare(struct vb2_buffer *vb)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_vcodec_enc_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct mtk_q_data *q_data =3D mtk_venc_get_q_data(ctx, vb->vb2_queue->t=
ype);
>  	int i;
> =20
> @@ -843,7 +843,7 @@ static int vb2ops_venc_buf_prepare(struct vb2_buffer =
*vb)
> =20
>  static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_vcodec_enc_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vb2_v4l2 =3D
>  			container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
> =20
> @@ -865,7 +865,7 @@ static void vb2ops_venc_buf_queue(struct vb2_buffer *=
vb)
> =20
>  static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int=
 count)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(q);
> +	struct mtk_vcodec_enc_ctx *ctx =3D vb2_get_drv_priv(q);
>  	struct venc_enc_param param;
>  	int ret, pm_ret;
>  	int i;
> @@ -944,7 +944,7 @@ static int vb2ops_venc_start_streaming(struct vb2_que=
ue *q, unsigned int count)
> =20
>  static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D vb2_get_drv_priv(q);
> +	struct mtk_vcodec_enc_ctx *ctx =3D vb2_get_drv_priv(q);
>  	struct vb2_v4l2_buffer *src_buf, *dst_buf;
>  	int ret;
> =20
> @@ -1033,7 +1033,7 @@ static const struct vb2_ops mtk_venc_vb2_ops =3D {
> =20
>  static int mtk_venc_encode_header(void *priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_enc_ctx *ctx =3D priv;
>  	int ret;
>  	struct vb2_v4l2_buffer *src_buf, *dst_buf;
>  	struct mtk_vcodec_mem bs_buf;
> @@ -1080,7 +1080,7 @@ static int mtk_venc_encode_header(void *priv)
>  	return 0;
>  }
> =20
> -static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
> +static int mtk_venc_param_change(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	struct venc_enc_param enc_prm;
>  	struct vb2_v4l2_buffer *vb2_v4l2 =3D v4l2_m2m_next_src_buf(ctx->m2m_ctx=
);
> @@ -1153,7 +1153,7 @@ static int mtk_venc_param_change(struct mtk_vcodec_=
ctx *ctx)
>   */
>  static void mtk_venc_worker(struct work_struct *work)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D container_of(work, struct mtk_vcodec_ctx=
,
> +	struct mtk_vcodec_enc_ctx *ctx =3D container_of(work, struct mtk_vcodec=
_enc_ctx,
>  				    encode_work);
>  	struct vb2_v4l2_buffer *src_buf, *dst_buf;
>  	struct venc_frm_buf frm_buf;
> @@ -1233,7 +1233,7 @@ static void mtk_venc_worker(struct work_struct *wor=
k)
> =20
>  static void m2mops_venc_device_run(void *priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_enc_ctx *ctx =3D priv;
> =20
>  	if ((ctx->q_data[MTK_Q_DATA_DST].fmt->fourcc =3D=3D V4L2_PIX_FMT_H264) =
&&
>  	    (ctx->state !=3D MTK_STATE_HEADER)) {
> @@ -1249,7 +1249,7 @@ static void m2mops_venc_device_run(void *priv)
> =20
>  static int m2mops_venc_job_ready(void *m2m_priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D m2m_priv;
> +	struct mtk_vcodec_enc_ctx *ctx =3D m2m_priv;
> =20
>  	if (ctx->state =3D=3D MTK_STATE_ABORT || ctx->state =3D=3D MTK_STATE_FR=
EE) {
>  		mtk_v4l2_venc_dbg(3, ctx, "[%d]Not ready: state=3D0x%x.", ctx->id, ctx=
->state);
> @@ -1261,7 +1261,7 @@ static int m2mops_venc_job_ready(void *m2m_priv)
> =20
>  static void m2mops_venc_job_abort(void *priv)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_enc_ctx *ctx =3D priv;
> =20
>  	ctx->state =3D MTK_STATE_ABORT;
>  }
> @@ -1272,7 +1272,7 @@ const struct v4l2_m2m_ops mtk_venc_m2m_ops =3D {
>  	.job_abort	=3D m2mops_venc_job_abort,
>  };
> =20
> -void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
> +void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	struct mtk_q_data *q_data;
> =20
> @@ -1333,7 +1333,7 @@ void mtk_vcodec_enc_set_default_params(struct mtk_v=
codec_ctx *ctx)
>  	ctx->enc_params.framerate_denom =3D MTK_DEFAULT_FRAMERATE_DENOM;
>  }
> =20
> -int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
> +int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	const struct v4l2_ctrl_ops *ops =3D &mtk_vcodec_enc_ctrl_ops;
>  	struct v4l2_ctrl_handler *handler =3D &ctx->ctrl_hdl;
> @@ -1399,7 +1399,7 @@ int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ct=
x *ctx)
>  int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
>  			      struct vb2_queue *dst_vq)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_enc_ctx *ctx =3D priv;
>  	int ret;
> =20
>  	/* Note: VB2_USERPTR works with dma-contig because mt8173
> @@ -1434,7 +1434,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb=
2_queue *src_vq,
>  	return vb2_queue_init(dst_vq);
>  }
> =20
> -int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
> +int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	struct mtk_vcodec_dev *dev =3D ctx->dev;
> =20
> @@ -1442,7 +1442,7 @@ int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
>  	return 0;
>  }
> =20
> -int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
> +int mtk_venc_lock(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	struct mtk_vcodec_dev *dev =3D ctx->dev;
> =20
> @@ -1450,7 +1450,7 @@ int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
>  	return 0;
>  }
> =20
> -void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
> +void mtk_vcodec_enc_release(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	int ret =3D venc_if_deinit(ctx);
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
> index 513ee7993e34..82246401ed4a 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
> @@ -11,6 +11,8 @@
>  #include <media/videobuf2-core.h>
>  #include <media/v4l2-mem2mem.h>
> =20
> +#include "mtk_vcodec_enc_drv.h"
> +
>  #define MTK_VENC_IRQ_STATUS_SPS	0x1
>  #define MTK_VENC_IRQ_STATUS_PPS	0x2
>  #define MTK_VENC_IRQ_STATUS_FRM	0x4
> @@ -39,12 +41,12 @@ struct mtk_video_enc_buf {
>  extern const struct v4l2_ioctl_ops mtk_venc_ioctl_ops;
>  extern const struct v4l2_m2m_ops mtk_venc_m2m_ops;
> =20
> -int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx);
> -int mtk_venc_lock(struct mtk_vcodec_ctx *ctx);
> +int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx);
> +int mtk_venc_lock(struct mtk_vcodec_enc_ctx *ctx);
>  int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
>  			      struct vb2_queue *dst_vq);
> -void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
> -int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx);
> -void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx);
> +void mtk_vcodec_enc_release(struct mtk_vcodec_enc_ctx *ctx);
> +int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_enc_ctx *ctx);
> +void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_enc_ctx *ctx);
> =20
>  #endif /* _MTK_VCODEC_ENC_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> index cb1dcbcb16bb..c9b6ce9dfa2d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> @@ -86,13 +86,13 @@ static void clean_irq_status(unsigned int irq_status,=
 void __iomem *addr)
>  static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
>  {
>  	struct mtk_vcodec_dev *dev =3D priv;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_enc_ctx *ctx;
>  	unsigned long flags;
>  	void __iomem *addr;
>  	int core_id;
> =20
>  	spin_lock_irqsave(&dev->irqlock, flags);
> -	ctx =3D dev->curr_ctx;
> +	ctx =3D dev->curr_enc_ctx;
>  	spin_unlock_irqrestore(&dev->irqlock, flags);
> =20
>  	core_id =3D dev->venc_pdata->core_id;
> @@ -110,14 +110,14 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int i=
rq, void *priv)
> =20
>  	clean_irq_status(ctx->irq_status, addr);
> =20
> -	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
> +	wake_up_enc_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
>  	return IRQ_HANDLED;
>  }
> =20
>  static int fops_vcodec_open(struct file *file)
>  {
>  	struct mtk_vcodec_dev *dev =3D video_drvdata(file);
> -	struct mtk_vcodec_ctx *ctx =3D NULL;
> +	struct mtk_vcodec_enc_ctx *ctx =3D NULL;
>  	int ret =3D 0;
>  	struct vb2_queue *src_vq;
> =20
> @@ -204,7 +204,7 @@ static int fops_vcodec_open(struct file *file)
>  static int fops_vcodec_release(struct file *file)
>  {
>  	struct mtk_vcodec_dev *dev =3D video_drvdata(file);
> -	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(file->private_data);
> +	struct mtk_vcodec_enc_ctx *ctx =3D fh_to_enc_ctx(file->private_data);
> =20
>  	mtk_v4l2_venc_dbg(1, ctx, "[%d] encoder", ctx->id);
>  	mutex_lock(&dev->dev_mutex);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> new file mode 100644
> index 000000000000..6aa4afe5b796
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Yunfei Dong <yunfei.dong@mediatek.com>
> + */
> +
> +#ifndef _MTK_VCODEC_ENC_DRV_H_
> +#define _MTK_VCODEC_ENC_DRV_H_
> +
> +#include "mtk_vcodec_com_drv.h"
> +#include "mtk_vcodec_fw_priv.h"
> +
> +/*
> + * enum mtk_encode_param - General encoding parameters type
> + */
> +enum mtk_encode_param {
> +	MTK_ENCODE_PARAM_NONE =3D 0,
> +	MTK_ENCODE_PARAM_BITRATE =3D (1 << 0),
> +	MTK_ENCODE_PARAM_FRAMERATE =3D (1 << 1),
> +	MTK_ENCODE_PARAM_INTRA_PERIOD =3D (1 << 2),
> +	MTK_ENCODE_PARAM_FORCE_INTRA =3D (1 << 3),
> +	MTK_ENCODE_PARAM_GOP_SIZE =3D (1 << 4),
> +};
> +
> +/**
> + * struct mtk_enc_params - General encoding parameters
> + * @bitrate: target bitrate in bits per second
> + * @num_b_frame: number of b frames between p-frame
> + * @rc_frame: frame based rate control
> + * @rc_mb: macroblock based rate control
> + * @seq_hdr_mode: H.264 sequence header is encoded separately or joined
> + *		  with the first frame
> + * @intra_period: I frame period
> + * @gop_size: group of picture size, it's used as the intra frame period
> + * @framerate_num: frame rate numerator. ex: framerate_num=3D30 and
> + *		   framerate_denom=3D1 means FPS is 30
> + * @framerate_denom: frame rate denominator. ex: framerate_num=3D30 and
> + *		     framerate_denom=3D1 means FPS is 30
> + * @h264_max_qp: Max value for H.264 quantization parameter
> + * @h264_profile: V4L2 defined H.264 profile
> + * @h264_level: V4L2 defined H.264 level
> + * @force_intra: force/insert intra frame
> + */
> +struct mtk_enc_params {
> +	unsigned int	bitrate;
> +	unsigned int	num_b_frame;
> +	unsigned int	rc_frame;
> +	unsigned int	rc_mb;
> +	unsigned int	seq_hdr_mode;
> +	unsigned int	intra_period;
> +	unsigned int	gop_size;
> +	unsigned int	framerate_num;
> +	unsigned int	framerate_denom;
> +	unsigned int	h264_max_qp;
> +	unsigned int	h264_profile;
> +	unsigned int	h264_level;
> +	unsigned int	force_intra;
> +};
> +
> +/**
> + * struct mtk_vcodec_enc_ctx - Context (instance) private data.
> + *
> + * @type: type of the instance - decoder or encoder

Similar to the decoder context, but this one can only be set to ENCODER and=
 must
stay first.

> + * @dev: pointer to the mtk_vcodec_dev of the device
> + * @list: link to ctx_list of mtk_vcodec_dev
> + *
> + * @fh: struct v4l2_fh
> + * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
> + * @q_data: store information of input and output queue
> + *	    of the context
> + * @id: index of the context that this structure describes
> + * @state: state of the context
> + * @param_change: indicate encode parameter type
> + * @enc_params: encoding parameters
> + *
> + * @enc_if: hooked encoder driver interface
> + * @drv_handle: driver handle for specific decode/encode instance
> + *
> + * @int_cond: variable used by the waitqueue
> + * @int_type: type of the last interrupt
> + * @queue: waitqueue that can be used to wait for this context to
> + *	   finish
> + * @irq_status: irq status
> + *
> + * @ctrl_hdl: handler for v4l2 framework
> + * @encode_work: worker for the encoding
> + * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. =
Only
> + *		     to be used with encoder and stateful decoder.
> + * @is_flushing: set to true if flushing is in progress.
> + *
> + * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
> + * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
> + * @quantization: enum v4l2_quantization, colorspace quantization
> + * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
> + *
> + * @lock: protect variables accessed by V4L2 threads and worker thread s=
uch as
> + *	  mtk_video_dec_buf.
> + * @hw_id: hardware index used to identify different hardware.
> + *
> + * @q_mutex: vb2_queue mutex.
> + */
> +struct mtk_vcodec_enc_ctx {
> +	enum mtk_instance_type type;
> +	struct mtk_vcodec_dev *dev;
> +	struct list_head list;
> +
> +	struct v4l2_fh fh;
> +	struct v4l2_m2m_ctx *m2m_ctx;
> +	struct mtk_q_data q_data[2];
> +	int id;
> +	enum mtk_instance_state state;
> +	enum mtk_encode_param param_change;
> +	struct mtk_enc_params enc_params;
> +
> +	const struct venc_common_if *enc_if;
> +	void *drv_handle;
> +
> +	int int_cond[MTK_VDEC_HW_MAX];
> +	int int_type[MTK_VDEC_HW_MAX];
> +	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
> +	unsigned int irq_status;
> +
> +	struct v4l2_ctrl_handler ctrl_hdl;
> +	struct work_struct encode_work;
> +	struct v4l2_m2m_buffer empty_flush_buf;
> +	bool is_flushing;
> +
> +	enum v4l2_colorspace colorspace;
> +	enum v4l2_ycbcr_encoding ycbcr_enc;
> +	enum v4l2_quantization quantization;
> +	enum v4l2_xfer_func xfer_func;
> +
> +	struct mutex lock;
> +	int hw_id;
> +
> +	struct mutex q_mutex;
> +};
> +
> +static inline struct mtk_vcodec_enc_ctx *fh_to_enc_ctx(struct v4l2_fh *f=
h)
> +{
> +	return container_of(fh, struct mtk_vcodec_enc_ctx, fh);
> +}
> +
> +static inline struct mtk_vcodec_enc_ctx *ctrl_to_enc_ctx(struct v4l2_ctr=
l *ctrl)
> +{
> +	return container_of(ctrl->handler, struct mtk_vcodec_enc_ctx, ctrl_hdl)=
;
> +}
> +
> +/* Wake up context wait_queue */
> +static inline void
> +wake_up_enc_ctx(struct mtk_vcodec_enc_ctx *ctx, unsigned int reason, uns=
igned int hw_id)
> +{
> +	ctx->int_cond[hw_id] =3D 1;
> +	ctx->int_type[hw_id] =3D reason;
> +	wake_up_interruptible(&ctx->queue[hw_id]);
> +}
> +
> +#endif /* _MTK_VCODEC_ENC_DRV_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> index ee6846886dd6..571072dffbfa 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> @@ -51,10 +51,25 @@ static void mtk_vcodec_vpu_release(struct mtk_vcodec_=
fw *fw)
>  	put_device(&fw->pdev->dev);
>  }
> =20
> -static void mtk_vcodec_vpu_reset_handler(void *priv)
> +static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
>  {
>  	struct mtk_vcodec_dev *dev =3D priv;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
> +
> +	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
> +
> +	mutex_lock(&dev->dev_mutex);
> +	list_for_each_entry(ctx, &dev->ctx_list, list) {
> +		ctx->state =3D MTK_STATE_ABORT;
> +		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx-=
>id);
> +	}
> +	mutex_unlock(&dev->dev_mutex);
> +}
> +
> +static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
> +{
> +	struct mtk_vcodec_dev *dev =3D priv;
> +	struct mtk_vcodec_enc_ctx *ctx;
> =20
>  	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
> =20
> @@ -84,14 +99,13 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *pr=
iv, enum mtk_vcodec_fw_use
>  	struct mtk_vcodec_fw *fw;
>  	enum rst_id rst_id;
> =20
> -	switch (fw_use) {
> -	case ENCODER:
> +	if (fw_use =3D=3D ENCODER) {
>  		rst_id =3D VPU_RST_ENC;
> -		break;
> -	case DECODER:
> -	default:
> +	} else if (fw_use =3D=3D DECODER) {
>  		rst_id =3D VPU_RST_DEC;
> -		break;
> +	} else {
> +		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
> +		return ERR_PTR(-EINVAL);
>  	}
> =20
>  	plat_dev =3D dev->plat_dev;
> @@ -101,7 +115,10 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *p=
riv, enum mtk_vcodec_fw_use
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> -	vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_handler, dev, rst_id)=
;
> +	if (fw_use =3D=3D DECODER)
> +		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_dec_handler, priv, r=
st_id);
> +	else
> +		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_enc_handler, priv, r=
st_id);
> =20
>  	fw =3D devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
>  	if (!fw)
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> index 5a06be55915b..66d1f50d8968 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> @@ -14,17 +14,34 @@
>  int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int t=
imeout_ms,
>  				 unsigned int hw_id)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	int instance_type =3D *((int *)priv);
>  	long timeout_jiff, ret;
>  	int status =3D 0, ctx_id, ctx_type;
>  	int *ctx_int_cond, *ctx_int_type;
>  	wait_queue_head_t *ctx_queue;
> +	struct platform_device *pdev;
> =20
> -	ctx_id =3D ctx->id;
> -	ctx_type =3D ctx->type;
> -	ctx_int_cond =3D ctx->int_cond;
> -	ctx_int_type =3D ctx->int_type;
> -	ctx_queue =3D ctx->queue;
> +	if (instance_type =3D=3D DECODER) {
> +		struct mtk_vcodec_dec_ctx *ctx;
> +		ctx =3D priv;
> +
> +		ctx_id =3D ctx->id;
> +		ctx_type =3D ctx->type;
> +		ctx_int_cond =3D ctx->int_cond;
> +		ctx_int_type =3D ctx->int_type;
> +		ctx_queue =3D ctx->queue;
> +		pdev =3D ctx->dev->plat_dev;
> +	} else {
> +		struct mtk_vcodec_enc_ctx *ctx;
> +		ctx =3D priv;
> +
> +		ctx_id =3D ctx->id;
> +		ctx_type =3D ctx->type;
> +		ctx_int_cond =3D ctx->int_cond;
> +		ctx_int_type =3D ctx->int_type;
> +		ctx_queue =3D ctx->queue;
> +		pdev =3D ctx->dev->plat_dev;
> +	}
> =20
>  	timeout_jiff =3D msecs_to_jiffies(timeout_ms);
>  	ret =3D wait_event_interruptible_timeout(ctx_queue[hw_id],
> @@ -33,12 +50,12 @@ int mtk_vcodec_wait_for_done_ctx(void *priv, int comm=
and, unsigned int timeout_m
> =20
>  	if (!ret) {
>  		status =3D -1;	/* timeout */
> -		dev_err(&ctx->dev->plat_dev->dev, "[%d] cmd=3D%d, type=3D%d, dec timeo=
ut=3D%ums (%d %d)",
> +		dev_err(&pdev->dev, "[%d] cmd=3D%d, type=3D%d, dec timeout=3D%ums (%d =
%d)",
>  			ctx_id, command, ctx_type, timeout_ms,
>  			ctx_int_cond[hw_id], ctx_int_type[hw_id]);
>  	} else if (-ERESTARTSYS =3D=3D ret) {
>  		status =3D -1;
> -		dev_err(&ctx->dev->plat_dev->dev, "[%d] cmd=3D%d, type=3D%d, dec inter=
 fail (%d %d)",
> +		dev_err(&pdev->dev, "[%d] cmd=3D%d, type=3D%d, dec inter fail (%d %d)"=
,
>  			ctx_id, command, ctx_type,
>  			ctx_int_cond[hw_id], ctx_int_type[hw_id]);
>  	}
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
> index 11bf0ef94d5d..3e3cc71ee572 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
> @@ -9,7 +9,8 @@
> =20
>  #define MTK_INST_IRQ_RECEIVED		0x1
> =20
> -struct mtk_vcodec_ctx;
> +struct mtk_vcodec_dec_ctx;
> +struct mtk_vcodec_enc_ctx;
> =20
>  /* timeout is ms */
>  int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int t=
imeout_ms,
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> index 4e524594df4a..adaeae79558a 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> @@ -34,7 +34,7 @@ EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
>  int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
>  {
>  	unsigned long size =3D mem->size;
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_dec_ctx *ctx =3D priv;
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
> =20
>  	mem->va =3D dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
> @@ -55,7 +55,7 @@ EXPORT_SYMBOL(mtk_vcodec_mem_alloc);
>  void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
>  {
>  	unsigned long size =3D mem->size;
> -	struct mtk_vcodec_ctx *ctx =3D priv;
> +	struct mtk_vcodec_dec_ctx *ctx =3D priv;
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
> =20
>  	if (!mem->va) {
> @@ -87,7 +87,7 @@ void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev,=
 int hw_idx)
>  EXPORT_SYMBOL(mtk_vcodec_get_hw_dev);
> =20
>  void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
> -			     struct mtk_vcodec_ctx *ctx, int hw_idx)
> +			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
>  {
>  	unsigned long flags;
>  	struct mtk_vdec_hw_dev *subdev_dev;
> @@ -108,11 +108,11 @@ void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev =
*vdec_dev,
>  }
>  EXPORT_SYMBOL(mtk_vcodec_set_curr_ctx);
> =20
> -struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vd=
ec_dev,
> -					       unsigned int hw_idx)
> +struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev=
 *vdec_dev,
> +						   unsigned int hw_idx)
>  {
>  	unsigned long flags;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct mtk_vdec_hw_dev *subdev_dev;
> =20
>  	spin_lock_irqsave(&vdec_dev->irqlock, flags);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index e68323ce8eeb..4d48b516f62d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -22,7 +22,7 @@ struct mtk_vcodec_fb {
>  	dma_addr_t dma_addr;
>  };
> =20
> -struct mtk_vcodec_ctx;
> +struct mtk_vcodec_dec_ctx;
>  struct mtk_vcodec_dev;
> =20
>  #undef pr_fmt
> @@ -84,9 +84,9 @@ void __iomem *mtk_vcodec_get_reg_addr(void __iomem **re=
g_base, unsigned int reg_
>  int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
>  void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
>  void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
> -			     struct mtk_vcodec_ctx *ctx, int hw_idx);
> -struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vd=
ec_dev,
> -					       unsigned int hw_idx);
> +			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
> +struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev=
 *vdec_dev,
> +						   unsigned int hw_idx);
>  void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx);
> =20
>  #endif /* _MTK_VCODEC_UTIL_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> index fcfc673ca58b..96ed4bec169e 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> @@ -706,7 +706,7 @@ struct vdec_av1_slice_pfc {
>   * @seq:                global picture sequence
>   */
>  struct vdec_av1_slice_instance {
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_vpu_inst vpu;
> =20
>  	struct mtk_vcodec_mem iq_table;
> @@ -756,7 +756,7 @@ static inline bool vdec_av1_slice_need_scale(u32 ref_=
width, u32 ref_height,
>  		(this_height <=3D (ref_height << 4));
>  }
> =20
> -static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
> +static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int i=
d)
>  {
>  	struct v4l2_ctrl *ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl, id);
> =20
> @@ -769,7 +769,7 @@ static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_=
ctx *ctx, int id)
>  static int vdec_av1_slice_init_cdf_table(struct vdec_av1_slice_instance =
*instance)
>  {
>  	u8 *remote_cdf_table;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_av1_slice_init_vsi *vsi;
>  	int ret;
> =20
> @@ -800,7 +800,7 @@ static int vdec_av1_slice_init_cdf_table(struct vdec_=
av1_slice_instance *instanc
>  static int vdec_av1_slice_init_iq_table(struct vdec_av1_slice_instance *=
instance)
>  {
>  	u8 *remote_iq_table;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_av1_slice_init_vsi *vsi;
>  	int ret;
> =20
> @@ -937,7 +937,7 @@ static void vdec_av1_slice_setup_slot(struct vdec_av1=
_slice_instance *instance,
>  static int vdec_av1_slice_alloc_working_buffer(struct vdec_av1_slice_ins=
tance *instance,
>  					       struct vdec_av1_slice_vsi *vsi)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D instance->ctx;
>  	enum vdec_av1_slice_resolution_level level;
>  	u32 max_sb_w, max_sb_h, max_w, max_h, w, h;
>  	int i, ret;
> @@ -1020,7 +1020,7 @@ static int vdec_av1_slice_alloc_working_buffer(stru=
ct vdec_av1_slice_instance *i
> =20
>  static void vdec_av1_slice_free_working_buffer(struct vdec_av1_slice_ins=
tance *instance)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D instance->ctx;
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(instance->mv); i++)
> @@ -1864,7 +1864,7 @@ static int vdec_av1_slice_update_core(struct vdec_a=
v1_slice_instance *instance,
>  	return 0;
>  }
> =20
> -static int vdec_av1_slice_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_av1_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_av1_slice_instance *instance;
>  	struct vdec_av1_slice_init_vsi *vsi;
> @@ -1962,7 +1962,7 @@ static int vdec_av1_slice_flush(void *h_vdec, struc=
t mtk_vcodec_mem *bs,
> =20
>  static void vdec_av1_slice_get_pic_info(struct vdec_av1_slice_instance *=
instance)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D instance->ctx;
>  	u32 data[3];
> =20
>  	mtk_vdec_debug(ctx, "w %u h %u\n", ctx->picinfo.pic_w, ctx->picinfo.pic=
_h);
> @@ -1988,7 +1988,7 @@ static inline void vdec_av1_slice_get_dpb_size(stru=
ct vdec_av1_slice_instance *i
>  static void vdec_av1_slice_get_crop_info(struct vdec_av1_slice_instance =
*instance,
>  					 struct v4l2_rect *cr)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D instance->ctx;
> =20
>  	cr->left =3D 0;
>  	cr->top =3D 0;
> @@ -2028,7 +2028,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
>  	struct vdec_lat_buf *lat_buf;
>  	struct vdec_av1_slice_pfc *pfc;
>  	struct vdec_av1_slice_vsi *vsi;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	int ret;
> =20
>  	if (!instance || !instance->ctx)
> @@ -2128,7 +2128,7 @@ static int vdec_av1_slice_core_decode(struct vdec_l=
at_buf *lat_buf)
>  {
>  	struct vdec_av1_slice_instance *instance;
>  	struct vdec_av1_slice_pfc *pfc;
> -	struct mtk_vcodec_ctx *ctx =3D NULL;
> +	struct mtk_vcodec_dec_ctx *ctx =3D NULL;
>  	struct vdec_fb *fb =3D NULL;
>  	int ret =3D -EINVAL;
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> index ca5437ae37f6..69914e26cd20 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> @@ -117,7 +117,7 @@ struct vdec_h264_vsi {
>  /**
>   * struct vdec_h264_inst - h264 decoder instance
>   * @num_nalu : how many nalus be decoded
> - * @ctx      : point to mtk_vcodec_ctx
> + * @ctx      : point to mtk_vcodec_dec_ctx
>   * @pred_buf : HW working predication buffer
>   * @mv_buf   : HW working motion vector buffer
>   * @vpu      : VPU instance
> @@ -125,7 +125,7 @@ struct vdec_h264_vsi {
>   */
>  struct vdec_h264_inst {
>  	unsigned int num_nalu;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct mtk_vcodec_mem pred_buf;
>  	struct mtk_vcodec_mem mv_buf[H264_MAX_FB_NUM];
>  	struct vdec_vpu_inst vpu;
> @@ -266,7 +266,7 @@ static void get_dpb_size(struct vdec_h264_inst *inst,=
 unsigned int *dpb_sz)
>  	mtk_vdec_debug(inst->ctx, "sz=3D%d", *dpb_sz);
>  }
> =20
> -static int vdec_h264_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_h264_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_h264_inst *inst =3D NULL;
>  	int err;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_co=
mmon.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
> index 580ce979e2a3..5ca20d75dc8e 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
> @@ -33,7 +33,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
>  	memset(&ref_list[num_valid], 0x20, 32 - num_valid);
>  }
> =20
> -void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
> +void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
>  {
>  	struct v4l2_ctrl *ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl, id);
> =20
> @@ -43,7 +43,7 @@ void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx =
*ctx, int id)
>  	return ctrl->p_cur.p;
>  }
> =20
> -void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
> +void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
>  				 struct slice_api_h264_decode_param *decode_params,
>  				 struct mtk_h264_dpb_info *h264_dpb_info)
>  {
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_co=
mmon.h b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
> index 53d0a7c962a9..0dda9e2315c0 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
> @@ -182,7 +182,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
>   *
>   * Return: returns CID ctrl address.
>   */
> -void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id);
> +void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)=
;
> =20
>  /**
>   * mtk_vdec_h264_fill_dpb_info - get each CID contrl address.
> @@ -191,7 +191,7 @@ void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ct=
x *ctx, int id);
>   * @decode_params:	slice decode params
>   * @h264_dpb_info:	dpb buffer information
>   */
> -void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
> +void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
>  				 struct slice_api_h264_decode_param *decode_params,
>  				 struct mtk_h264_dpb_info *h264_dpb_info);
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if=
.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> index bdff1d2feb1c..4eb98a705be4 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> @@ -74,7 +74,7 @@ struct vdec_h264_vsi {
>  /**
>   * struct vdec_h264_slice_inst - h264 decoder instance
>   * @num_nalu : how many nalus be decoded
> - * @ctx      : point to mtk_vcodec_ctx
> + * @ctx      : point to mtk_vcodec_dec_ctx
>   * @pred_buf : HW working predication buffer
>   * @mv_buf   : HW working motion vector buffer
>   * @vpu      : VPU instance
> @@ -84,7 +84,7 @@ struct vdec_h264_vsi {
>   */
>  struct vdec_h264_slice_inst {
>  	unsigned int num_nalu;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct mtk_vcodec_mem pred_buf;
>  	struct mtk_vcodec_mem mv_buf[H264_MAX_MV_NUM];
>  	struct vdec_vpu_inst vpu;
> @@ -220,7 +220,7 @@ static void free_mv_buf(struct vdec_h264_slice_inst *=
inst)
>  static void get_pic_info(struct vdec_h264_slice_inst *inst,
>  			 struct vdec_pic_info *pic)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D inst->ctx;
> =20
>  	ctx->picinfo.buf_w =3D ALIGN(ctx->picinfo.pic_w, VCODEC_DEC_ALIGNED_64)=
;
>  	ctx->picinfo.buf_h =3D ALIGN(ctx->picinfo.pic_h, VCODEC_DEC_ALIGNED_64)=
;
> @@ -269,7 +269,7 @@ static void get_dpb_size(struct vdec_h264_slice_inst =
*inst, unsigned int *dpb_sz
>  	mtk_vdec_debug(inst->ctx, "sz=3D%d", *dpb_sz);
>  }
> =20
> -static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_h264_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_h264_slice_inst *inst;
>  	int err;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_=
if.c
> index 1c2389e63e4c..846cc39c0168 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> @@ -133,7 +133,7 @@ struct vdec_h264_slice_share_info {
>   * struct vdec_h264_slice_inst - h264 decoder instance
>   *
>   * @slice_dec_num:	how many picture be decoded
> - * @ctx:		point to mtk_vcodec_ctx
> + * @ctx:		point to mtk_vcodec_dec_ctx
>   * @pred_buf:		HW working predication buffer
>   * @mv_buf:		HW working motion vector buffer
>   * @vpu:		VPU instance
> @@ -153,7 +153,7 @@ struct vdec_h264_slice_share_info {
>   */
>  struct vdec_h264_slice_inst {
>  	unsigned int slice_dec_num;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct mtk_vcodec_mem pred_buf;
>  	struct mtk_vcodec_mem mv_buf[H264_MAX_MV_NUM];
>  	struct vdec_vpu_inst vpu;
> @@ -344,7 +344,7 @@ static void vdec_h264_slice_free_mv_buf(struct vdec_h=
264_slice_inst *inst)
> =20
>  static void vdec_h264_slice_get_pic_info(struct vdec_h264_slice_inst *in=
st)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D inst->ctx;
>  	u32 data[3];
> =20
>  	data[0] =3D ctx->picinfo.pic_w;
> @@ -393,7 +393,7 @@ static void vdec_h264_slice_get_crop_info(struct vdec=
_h264_slice_inst *inst,
>  		       cr->left, cr->top, cr->width, cr->height);
>  }
> =20
> -static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_h264_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_h264_slice_inst *inst;
>  	int err, vsi_size;
> @@ -457,7 +457,7 @@ static int vdec_h264_slice_core_decode(struct vdec_la=
t_buf *lat_buf)
>  	u64 vdec_fb_va;
>  	u64 y_fb_dma, c_fb_dma;
>  	int err, timeout, i;
> -	struct mtk_vcodec_ctx *ctx =3D lat_buf->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D lat_buf->ctx;
>  	struct vdec_h264_slice_inst *inst =3D ctx->drv_handle;
>  	struct vb2_v4l2_buffer *vb2_v4l2;
>  	struct vdec_h264_slice_share_info *share_info =3D lat_buf->private_data=
;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_=
if.c
> index aa32b7cbf6f1..67a5f8b82eb8 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> @@ -344,7 +344,7 @@ struct vdec_hevc_slice_share_info {
>   * struct vdec_hevc_slice_inst - hevc decoder instance
>   *
>   * @slice_dec_num:      how many picture be decoded
> - * @ctx:                point to mtk_vcodec_ctx
> + * @ctx:                point to mtk_vcodec_dec_ctx
>   * @mv_buf:             HW working motion vector buffer
>   * @vpu:                VPU instance
>   * @vsi:                vsi used for lat
> @@ -359,7 +359,7 @@ struct vdec_hevc_slice_share_info {
>   */
>  struct vdec_hevc_slice_inst {
>  	unsigned int slice_dec_num;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct mtk_vcodec_mem mv_buf[HEVC_MAX_MV_NUM];
>  	struct vdec_vpu_inst vpu;
>  	struct vdec_hevc_slice_vsi *vsi;
> @@ -380,7 +380,7 @@ static unsigned int vdec_hevc_get_mv_buf_size(unsigne=
d int width, unsigned int h
>  	return 64 * unit_size;
>  }
> =20
> -static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
> +static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int =
id)
>  {
>  	struct v4l2_ctrl *ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl, id);
> =20
> @@ -390,7 +390,7 @@ static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec=
_ctx *ctx, int id)
>  	return ctrl->p_cur.p;
>  }
> =20
> -static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
> +static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
>  				    struct slice_api_hevc_decode_param *decode_params,
>  				    struct mtk_hevc_dpb_info *hevc_dpb_info)
>  {
> @@ -679,7 +679,7 @@ static void vdec_hevc_slice_free_mv_buf(struct vdec_h=
evc_slice_inst *inst)
> =20
>  static void vdec_hevc_slice_get_pic_info(struct vdec_hevc_slice_inst *in=
st)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D inst->ctx;
>  	u32 data[3];
> =20
>  	data[0] =3D ctx->picinfo.pic_w;
> @@ -798,7 +798,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct v=
dec_hevc_slice_inst *inst,
>  					     struct vdec_lat_buf *lat_buf)
>  {
>  	struct mtk_vcodec_mem *mem;
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D inst->ctx;
>  	struct vb2_v4l2_buffer *vb2_v4l2;
>  	struct vdec_fb *fb;
>  	u64 y_fb_dma, c_fb_dma;
> @@ -853,7 +853,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct v=
dec_hevc_slice_inst *inst,
>  	return 0;
>  }
> =20
> -static int vdec_hevc_slice_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_hevc_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_hevc_slice_inst *inst;
>  	int err, vsi_size;
> @@ -924,7 +924,7 @@ static void vdec_hevc_slice_deinit(void *h_vdec)
>  static int vdec_hevc_slice_core_decode(struct vdec_lat_buf *lat_buf)
>  {
>  	int err, timeout;
> -	struct mtk_vcodec_ctx *ctx =3D lat_buf->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D lat_buf->ctx;
>  	struct vdec_hevc_slice_inst *inst =3D ctx->drv_handle;
>  	struct vdec_hevc_slice_share_info *share_info =3D lat_buf->private_data=
;
>  	struct vdec_vpu_inst *vpu =3D &inst->vpu;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> index 295cb2ee5c4a..a8606f74ddc1 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> @@ -160,7 +160,7 @@ struct vdec_vp8_inst {
>  	struct mtk_vcodec_mem working_buf;
>  	struct vdec_vp8_hw_reg_base reg_base;
>  	unsigned int frm_cnt;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_vpu_inst vpu;
>  	struct vdec_vp8_vsi *vsi;
>  };
> @@ -388,7 +388,7 @@ static void free_working_buf(struct vdec_vp8_inst *in=
st)
>  	inst->vsi->dec.working_buf_dma =3D 0;
>  }
> =20
> -static int vdec_vp8_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_vp8_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_vp8_inst *inst;
>  	int err;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.=
c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> index 4193fe20bb92..d3103b877b61 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> @@ -101,12 +101,12 @@ struct vdec_vp8_slice_inst {
>  	struct mtk_vcodec_mem wrap_y_buf;
>  	struct mtk_vcodec_mem wrap_c_buf;
>  	struct mtk_vcodec_mem vld_wrapper_buf;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_vpu_inst vpu;
>  	struct vdec_vp8_slice_vsi *vsi;
>  };
> =20
> -static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int=
 id)
> +static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx,=
 int id)
>  {
>  	struct v4l2_ctrl *ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl, id);
> =20
> @@ -118,7 +118,7 @@ static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_v=
codec_ctx *ctx, int id)
> =20
>  static void vdec_vp8_slice_get_pic_info(struct vdec_vp8_slice_inst *inst=
)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D inst->ctx;
>  	unsigned int data[3];
> =20
>  	data[0] =3D ctx->picinfo.pic_w;
> @@ -233,7 +233,7 @@ static u64 vdec_vp8_slice_get_ref_by_ts(const struct =
v4l2_ctrl_vp8_frame *frame_
>  static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_in=
st *inst)
>  {
>  	const struct v4l2_ctrl_vp8_frame *frame_header;
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D inst->ctx;
>  	struct vb2_queue *vq;
>  	struct vb2_buffer *vb;
>  	u64 referenct_ts;
> @@ -272,7 +272,7 @@ static int vdec_vp8_slice_get_decode_parameters(struc=
t vdec_vp8_slice_inst *inst
>  	return 0;
>  }
> =20
> -static int vdec_vp8_slice_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_vp8_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_vp8_slice_inst *inst;
>  	int err;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> index 62c2b3b021e6..d3493d36329d 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> @@ -196,7 +196,7 @@ struct vdec_vp9_inst {
>  	struct list_head fb_free_list;
>  	struct list_head fb_disp_list;
>  	struct vdec_fb *cur_fb;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_vpu_inst vpu;
>  	struct vdec_vp9_vsi *vsi;
>  	unsigned int total_frm_cnt;
> @@ -531,7 +531,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *i=
nst)
> =20
>  static bool vp9_wait_dec_end(struct vdec_vp9_inst *inst)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D inst->ctx;
> =20
>  	mtk_vcodec_wait_for_done_ctx(inst->ctx,
>  			MTK_INST_IRQ_RECEIVED,
> @@ -543,7 +543,7 @@ static bool vp9_wait_dec_end(struct vdec_vp9_inst *in=
st)
>  		return false;
>  }
> =20
> -static struct vdec_vp9_inst *vp9_alloc_inst(struct mtk_vcodec_ctx *ctx)
> +static struct vdec_vp9_inst *vp9_alloc_inst(struct mtk_vcodec_dec_ctx *c=
tx)
>  {
>  	int result;
>  	struct mtk_vcodec_mem mem;
> @@ -771,7 +771,7 @@ static void vdec_vp9_deinit(void *h_vdec)
>  	vp9_free_inst(inst);
>  }
> =20
> -static int vdec_vp9_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_vp9_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_vp9_inst *inst;
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index 913077d6e701..106ee4daf00b 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -445,7 +445,7 @@ struct vdec_vp9_slice_ref {
>   * @counts_helper:	counts table according to newest kernel spec
>   */
>  struct vdec_vp9_slice_instance {
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_vpu_inst vpu;
> =20
>  	int seq;
> @@ -506,7 +506,7 @@ static int vdec_vp9_slice_init_default_frame_ctx(stru=
ct vdec_vp9_slice_instance
>  {
>  	struct vdec_vp9_slice_frame_ctx *remote_frame_ctx;
>  	struct vdec_vp9_slice_frame_ctx *frame_ctx;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	struct vdec_vp9_slice_init_vsi *vsi;
>  	int ret =3D 0;
> =20
> @@ -543,7 +543,7 @@ static int vdec_vp9_slice_init_default_frame_ctx(stru=
ct vdec_vp9_slice_instance
>  static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slice_ins=
tance *instance,
>  					       struct vdec_vp9_slice_vsi *vsi)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D instance->ctx;
>  	enum vdec_vp9_slice_resolution_level level;
>  	/* super blocks */
>  	unsigned int max_sb_w;
> @@ -635,7 +635,7 @@ static int vdec_vp9_slice_alloc_working_buffer(struct=
 vdec_vp9_slice_instance *i
> =20
>  static void vdec_vp9_slice_free_working_buffer(struct vdec_vp9_slice_ins=
tance *instance)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D instance->ctx;
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(instance->mv); i++) {
> @@ -1850,7 +1850,7 @@ static int vdec_vp9_slice_update_core(struct vdec_v=
p9_slice_instance *instance,
>  	return 0;
>  }
> =20
> -static int vdec_vp9_slice_init(struct mtk_vcodec_ctx *ctx)
> +static int vdec_vp9_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_vp9_slice_instance *instance;
>  	struct vdec_vp9_slice_init_vsi *vsi;
> @@ -1933,7 +1933,7 @@ static int vdec_vp9_slice_flush(void *h_vdec, struc=
t mtk_vcodec_mem *bs,
> =20
>  static void vdec_vp9_slice_get_pic_info(struct vdec_vp9_slice_instance *=
instance)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
> +	struct mtk_vcodec_dec_ctx *ctx =3D instance->ctx;
>  	unsigned int data[3];
> =20
>  	mtk_vdec_debug(instance->ctx, "w %u h %u\n", ctx->picinfo.pic_w, ctx->p=
icinfo.pic_h);
> @@ -1984,7 +1984,7 @@ static int vdec_vp9_slice_single_decode(void *h_vde=
c, struct mtk_vcodec_mem *bs,
>  	struct vdec_vp9_slice_instance *instance =3D h_vdec;
>  	struct vdec_vp9_slice_pfc *pfc =3D &instance->sc_pfc;
>  	struct vdec_vp9_slice_vsi *vsi;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	int ret;
> =20
>  	if (!instance || !instance->ctx)
> @@ -2042,7 +2042,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
>  	struct vdec_lat_buf *lat_buf;
>  	struct vdec_vp9_slice_pfc *pfc;
>  	struct vdec_vp9_slice_vsi *vsi;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	int ret;
> =20
>  	if (!instance || !instance->ctx)
> @@ -2137,7 +2137,7 @@ static int vdec_vp9_slice_core_decode(struct vdec_l=
at_buf *lat_buf)
>  {
>  	struct vdec_vp9_slice_instance *instance;
>  	struct vdec_vp9_slice_pfc *pfc;
> -	struct mtk_vcodec_ctx *ctx =3D NULL;
> +	struct mtk_vcodec_dec_ctx *ctx =3D NULL;
>  	struct vdec_fb *fb =3D NULL;
>  	int ret =3D -EINVAL;
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h b/dri=
vers/media/platform/mediatek/vcodec/vdec_drv_base.h
> index e913f963b7db..f6abb9365234 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
> @@ -15,7 +15,7 @@ struct vdec_common_if {
>  	 * @ctx     : [in] mtk v4l2 context
>  	 * @h_vdec  : [out] driver handle
>  	 */
> -	int (*init)(struct mtk_vcodec_ctx *ctx);
> +	int (*init)(struct mtk_vcodec_dec_ctx *ctx);
> =20
>  	/**
>  	 * (*decode)() - trigger decode
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drive=
rs/media/platform/mediatek/vcodec/vdec_drv_if.c
> index e66faf50892b..d0b459b1603f 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
> @@ -14,7 +14,7 @@
>  #include "vdec_drv_base.h"
>  #include "mtk_vcodec_dec_pm.h"
> =20
> -int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
> +int vdec_if_init(struct mtk_vcodec_dec_ctx *ctx, unsigned int fourcc)
>  {
>  	enum mtk_vdec_hw_arch hw_arch =3D ctx->dev->vdec_pdata->hw_arch;
>  	int ret =3D 0;
> @@ -68,7 +68,7 @@ int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned i=
nt fourcc)
>  	return ret;
>  }
> =20
> -int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs=
,
> +int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_mem=
 *bs,
>  		   struct vdec_fb *fb, bool *res_chg)
>  {
>  	int ret =3D 0;
> @@ -100,7 +100,7 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct=
 mtk_vcodec_mem *bs,
>  	return ret;
>  }
> =20
> -int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_ty=
pe type,
> +int vdec_if_get_param(struct mtk_vcodec_dec_ctx *ctx, enum vdec_get_para=
m_type type,
>  		      void *out)
>  {
>  	int ret =3D 0;
> @@ -115,7 +115,7 @@ int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enu=
m vdec_get_param_type type,
>  	return ret;
>  }
> =20
> -void vdec_if_deinit(struct mtk_vcodec_ctx *ctx)
> +void vdec_if_deinit(struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	if (!ctx->drv_handle)
>  		return;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drive=
rs/media/platform/mediatek/vcodec/vdec_drv_if.h
> index a8da6a59a6a5..816ed6ab1ed0 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
> @@ -69,14 +69,14 @@ extern const struct vdec_common_if vdec_av1_slice_lat=
_if;
>   * @ctx	: [in] v4l2 context
>   * @fourcc	: [in] video format fourcc, V4L2_PIX_FMT_H264/VP8/VP9..
>   */
> -int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc);
> +int vdec_if_init(struct mtk_vcodec_dec_ctx *ctx, unsigned int fourcc);
> =20
>  /**
>   * vdec_if_deinit() - deinitialize decode driver
>   * @ctx	: [in] v4l2 context
>   *
>   */
> -void vdec_if_deinit(struct mtk_vcodec_ctx *ctx);
> +void vdec_if_deinit(struct mtk_vcodec_dec_ctx *ctx);
> =20
>  /**
>   * vdec_if_decode() - trigger decode
> @@ -90,7 +90,7 @@ void vdec_if_deinit(struct mtk_vcodec_ctx *ctx);
>   *
>   * Return: 0 on success. -EIO on unrecoverable error.
>   */
> -int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs=
,
> +int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_mem=
 *bs,
>  		   struct vdec_fb *fb, bool *res_chg);
> =20
>  /**
> @@ -99,7 +99,7 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct m=
tk_vcodec_mem *bs,
>   * @type	: [in] input parameter type
>   * @out	: [out] buffer to store query result
>   */
> -int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_ty=
pe type,
> +int vdec_if_get_param(struct mtk_vcodec_dec_ctx *ctx, enum vdec_get_para=
m_type type,
>  		      void *out);
> =20
>  #endif
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/dr=
ivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> index 1b2d01b15032..0dd1374ccc38 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> @@ -199,7 +199,7 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg=
_queue *msg_queue)
>  }
> =20
>  void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
> -			   struct mtk_vcodec_ctx *ctx)
> +			   struct mtk_vcodec_dec_ctx *ctx)
>  {
>  	struct vdec_lat_buf *lat_buf;
>  	struct mtk_vcodec_mem *mem;
> @@ -237,8 +237,8 @@ static void vdec_msg_queue_core_work(struct work_stru=
ct *work)
>  {
>  	struct vdec_msg_queue *msg_queue =3D
>  		container_of(work, struct vdec_msg_queue, core_work);
> -	struct mtk_vcodec_ctx *ctx =3D
> -		container_of(msg_queue, struct mtk_vcodec_ctx, msg_queue);
> +	struct mtk_vcodec_dec_ctx *ctx =3D
> +		container_of(msg_queue, struct mtk_vcodec_dec_ctx, msg_queue);
>  	struct mtk_vcodec_dev *dev =3D ctx->dev;
>  	struct vdec_lat_buf *lat_buf;
> =20
> @@ -278,7 +278,7 @@ static void vdec_msg_queue_core_work(struct work_stru=
ct *work)
>  }
> =20
>  int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
> -			struct mtk_vcodec_ctx *ctx, core_decode_cb_t core_decode,
> +			struct mtk_vcodec_dec_ctx *ctx, core_decode_cb_t core_decode,
>  			int private_size)
>  {
>  	struct vdec_lat_buf *lat_buf;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/dr=
ivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> index 2f82cc08caa3..1fb3f57c2384 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> @@ -17,7 +17,7 @@
>  #define NUM_BUFFER_COUNT 3
> =20
>  struct vdec_lat_buf;
> -struct mtk_vcodec_ctx;
> +struct mtk_vcodec_dec_ctx;
>  struct mtk_vcodec_dev;
>  typedef int (*core_decode_cb_t)(struct vdec_lat_buf *lat_buf);
> =20
> @@ -76,7 +76,7 @@ struct vdec_lat_buf {
>  	struct media_request *src_buf_req;
> =20
>  	void *private_data;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	core_decode_cb_t core_decode;
>  	struct list_head lat_list;
>  	struct list_head core_list;
> @@ -119,7 +119,7 @@ struct vdec_msg_queue {
>  	struct vdec_lat_buf empty_lat_buf;
>  	wait_queue_head_t core_dec_done;
>  	int status;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  };
> =20
>  /**
> @@ -132,7 +132,7 @@ struct vdec_msg_queue {
>   * Return: returns 0 if init successfully, or fail.
>   */
>  int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
> -			struct mtk_vcodec_ctx *ctx, core_decode_cb_t core_decode,
> +			struct mtk_vcodec_dec_ctx *ctx, core_decode_cb_t core_decode,
>  			int private_size);
> =20
>  /**
> @@ -188,6 +188,6 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg=
_queue *msg_queue);
>   * @ctx: v4l2 ctx
>   */
>  void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
> -			   struct mtk_vcodec_ctx *ctx);
> +			   struct mtk_vcodec_dec_ctx *ctx);
> =20
>  #endif
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drive=
rs/media/platform/mediatek/vcodec/vdec_vpu_if.h
> index 0436bba91457..c9766c108209 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
> @@ -9,7 +9,7 @@
> =20
>  #include "mtk_vcodec_fw.h"
> =20
> -struct mtk_vcodec_ctx;
> +struct mtk_vcodec_dec_ctx;
> =20
>  /**
>   * struct vdec_vpu_inst - VPU instance for video codec
> @@ -40,7 +40,7 @@ struct vdec_vpu_inst {
>  	uint32_t fw_abi_version;
>  	uint32_t inst_id;
>  	unsigned int signaled;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_dec_ctx *ctx;
>  	wait_queue_head_t wq;
>  	mtk_vcodec_ipi_handler handler;
>  	unsigned int codec_type;
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> index 5abc9c4e6d4f..c5f9fc24a692 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> @@ -221,7 +221,7 @@ struct venc_h264_inst {
>  	struct venc_vpu_inst vpu_inst;
>  	struct venc_h264_vsi *vsi;
>  	struct venc_h264_vsi_34 *vsi_34;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_enc_ctx *ctx;
>  };
> =20
>  static inline u32 h264_read_reg(struct venc_h264_inst *inst, u32 addr)
> @@ -409,7 +409,7 @@ static int h264_enc_alloc_work_buf(struct venc_h264_i=
nst *inst, bool is_34bit)
>  static unsigned int h264_enc_wait_venc_done(struct venc_h264_inst *inst)
>  {
>  	unsigned int irq_status =3D 0;
> -	struct mtk_vcodec_ctx *ctx =3D (struct mtk_vcodec_ctx *)inst->ctx;
> +	struct mtk_vcodec_enc_ctx *ctx =3D (struct mtk_vcodec_enc_ctx *)inst->c=
tx;
> =20
>  	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
>  					  WAIT_INTR_TIMEOUT_MS, 0)) {
> @@ -513,7 +513,7 @@ static int h264_encode_frame(struct venc_h264_inst *i=
nst,
>  	unsigned int intra_period;
>  	unsigned int irq_status;
>  	struct venc_frame_info frame_info;
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_enc_ctx *ctx =3D inst->ctx;
> =20
>  	mtk_venc_debug(ctx, "frm_cnt =3D %d\n ", inst->frm_cnt);
> =20
> @@ -582,7 +582,7 @@ static void h264_encode_filler(struct venc_h264_inst =
*inst, void *buf,
>  	memset(p, 0xff, size);
>  }
> =20
> -static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
> +static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	const bool is_ext =3D MTK_ENC_CTX_IS_EXT(ctx);
>  	int ret =3D 0;
> @@ -620,7 +620,7 @@ static int h264_enc_encode(void *handle,
>  {
>  	int ret =3D 0;
>  	struct venc_h264_inst *inst =3D (struct venc_h264_inst *)handle;
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_enc_ctx *ctx =3D inst->ctx;
> =20
>  	mtk_venc_debug(ctx, "opt %d ->", opt);
> =20
> @@ -750,7 +750,7 @@ static int h264_enc_set_param(void *handle,
>  {
>  	int ret =3D 0;
>  	struct venc_h264_inst *inst =3D (struct venc_h264_inst *)handle;
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_enc_ctx *ctx =3D inst->ctx;
>  	const bool is_34bit =3D MTK_ENC_IOVA_IS_34BIT(ctx);
> =20
>  	mtk_venc_debug(ctx, "->type=3D%d", type);
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> index ff54064497f1..e8e4474eacc7 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> @@ -129,7 +129,7 @@ struct venc_vp8_inst {
>  	unsigned int ts_mode;
>  	struct venc_vpu_inst vpu_inst;
>  	struct venc_vp8_vsi *vsi;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_enc_ctx *ctx;
>  };
> =20
>  static inline u32 vp8_enc_read_reg(struct venc_vp8_inst *inst, u32 addr)
> @@ -209,7 +209,7 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_ins=
t *inst)
>  static unsigned int vp8_enc_wait_venc_done(struct venc_vp8_inst *inst)
>  {
>  	unsigned int irq_status =3D 0;
> -	struct mtk_vcodec_ctx *ctx =3D (struct mtk_vcodec_ctx *)inst->ctx;
> +	struct mtk_vcodec_enc_ctx *ctx =3D (struct mtk_vcodec_enc_ctx *)inst->c=
tx;
> =20
>  	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
>  					  WAIT_INTR_TIMEOUT_MS, 0)) {
> @@ -312,7 +312,7 @@ static int vp8_enc_encode_frame(struct venc_vp8_inst =
*inst,
>  	return ret;
>  }
> =20
> -static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
> +static int vp8_enc_init(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	int ret =3D 0;
>  	struct venc_vp8_inst *inst;
> @@ -346,7 +346,7 @@ static int vp8_enc_encode(void *handle,
>  {
>  	int ret =3D 0;
>  	struct venc_vp8_inst *inst =3D (struct venc_vp8_inst *)handle;
> -	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct mtk_vcodec_enc_ctx *ctx =3D inst->ctx;
> =20
>  	enable_irq(ctx->dev->enc_irq);
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h b/dri=
vers/media/platform/mediatek/vcodec/venc_drv_base.h
> index 3d718411dc73..17f8183461b5 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
> +++ b/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
> @@ -19,7 +19,7 @@ struct venc_common_if {
>  	 * @ctx:	[in] mtk v4l2 context
>  	 * @handle: [out] driver handle
>  	 */
> -	int (*init)(struct mtk_vcodec_ctx *ctx);
> +	int (*init)(struct mtk_vcodec_enc_ctx *ctx);
> =20
>  	/**
>  	 * (*encode)() - trigger encode
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drive=
rs/media/platform/mediatek/vcodec/venc_drv_if.c
> index ce0bce811615..08083030516e 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
> @@ -16,7 +16,7 @@
>  #include "mtk_vcodec_enc.h"
>  #include "mtk_vcodec_enc_pm.h"
> =20
> -int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
> +int venc_if_init(struct mtk_vcodec_enc_ctx *ctx, unsigned int fourcc)
>  {
>  	int ret =3D 0;
> =20
> @@ -40,8 +40,8 @@ int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned i=
nt fourcc)
>  	return ret;
>  }
> =20
> -int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
> -		enum venc_set_param_type type, struct venc_enc_param *in)
> +int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
> +		      enum venc_set_param_type type, struct venc_enc_param *in)
>  {
>  	int ret =3D 0;
> =20
> @@ -54,7 +54,7 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
>  	return ret;
>  }
> =20
> -int venc_if_encode(struct mtk_vcodec_ctx *ctx,
> +int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
>  		   enum venc_start_opt opt, struct venc_frm_buf *frm_buf,
>  		   struct mtk_vcodec_mem *bs_buf,
>  		   struct venc_done_result *result)
> @@ -65,7 +65,7 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
>  	mtk_venc_lock(ctx);
> =20
>  	spin_lock_irqsave(&ctx->dev->irqlock, flags);
> -	ctx->dev->curr_ctx =3D ctx;
> +	ctx->dev->curr_enc_ctx =3D ctx;
>  	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
> =20
>  	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
> @@ -74,14 +74,14 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
>  	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
> =20
>  	spin_lock_irqsave(&ctx->dev->irqlock, flags);
> -	ctx->dev->curr_ctx =3D NULL;
> +	ctx->dev->curr_enc_ctx =3D NULL;
>  	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
> =20
>  	mtk_venc_unlock(ctx);
>  	return ret;
>  }
> =20
> -int venc_if_deinit(struct mtk_vcodec_ctx *ctx)
> +int venc_if_deinit(struct mtk_vcodec_enc_ctx *ctx)
>  {
>  	int ret =3D 0;
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drive=
rs/media/platform/mediatek/vcodec/venc_drv_if.h
> index 0b04a1020873..90d714e86ede 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
> @@ -132,14 +132,14 @@ extern const struct venc_common_if venc_vp8_if;
>   * @fourcc: encoder input format
>   * Return: 0 if creating handle successfully, otherwise it is failed.
>   */
> -int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc);
> +int venc_if_init(struct mtk_vcodec_enc_ctx *ctx, unsigned int fourcc);
> =20
>  /*
>   * venc_if_deinit - Release the driver handle
>   * @ctx: device context
>   * Return: 0 if releasing handle successfully, otherwise it is failed.
>   */
> -int venc_if_deinit(struct mtk_vcodec_ctx *ctx);
> +int venc_if_deinit(struct mtk_vcodec_enc_ctx *ctx);
> =20
>  /*
>   * venc_if_set_param - Set parameter to driver
> @@ -148,7 +148,7 @@ int venc_if_deinit(struct mtk_vcodec_ctx *ctx);
>   * @in: input parameter
>   * Return: 0 if setting param successfully, otherwise it is failed.
>   */
> -int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
> +int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
>  		      enum venc_set_param_type type,
>  		      struct venc_enc_param *in);
> =20
> @@ -161,7 +161,7 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
>   * @result: encode result
>   * Return: 0 if encoding frame successfully, otherwise it is failed.
>   */
> -int venc_if_encode(struct mtk_vcodec_ctx *ctx,
> +int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
>  		   enum venc_start_opt opt,
>  		   struct venc_frm_buf *frm_buf,
>  		   struct mtk_vcodec_mem *bs_buf,
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drive=
rs/media/platform/mediatek/vcodec/venc_vpu_if.h
> index f83bc1b3f2bf..71370ab98809 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
> @@ -35,7 +35,7 @@ struct venc_vpu_inst {
>  	unsigned int inst_addr;
>  	void *vsi;
>  	int id;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_enc_ctx *ctx;
>  };
> =20
>  int vpu_enc_init(struct venc_vpu_inst *vpu);

With the slight doc improved:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

