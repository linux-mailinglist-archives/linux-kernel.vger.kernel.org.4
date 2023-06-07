Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F129725892
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbjFGIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbjFGItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:49:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50181BC2;
        Wed,  7 Jun 2023 01:49:15 -0700 (PDT)
X-UUID: 2ac0cf40051011ee9cb5633481061a41-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MiLqEL4f5jDWnn56uumlvIhWTiEfFuaWimX9kYe+qjs=;
        b=KF/KE+Ckw4PZzTMlF+7U8ydyxLwWS1KR7EfDus3QepePuMGftUJ1TcBPQEXJbg4qKX3GRVI8ZbMhQ9uaEqBq4H9i3QzGIwIBdYHDvFePAhJMstVztUpuPeLgVZe+2VjbogL9RSLxxkTHdh7xYUxE5WbEXi9UeICMnc1AxSo1Zio=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:9bb25e72-b3da-4a79-884f-f500327e24d6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:90c5a83d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV:0
X-CID-BVR: 2,OSH|NGT
X-CID-BAS: 2,OSH|NGT,0,_
X-UUID: 2ac0cf40051011ee9cb5633481061a41-20230607
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1555715155; Wed, 07 Jun 2023 16:49:08 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 16:49:08 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 16:49:07 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,05/10] mediatek: vcodec: replace pr_* with dev_* for v4l2 debug message
Date:   Wed, 7 Jun 2023 16:48:56 +0800
Message-ID: <20230607084901.28021-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607084901.28021-1-yunfei.dong@mediatek.com>
References: <20230607084901.28021-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pr_err with dev_err for 'mtk_v4l2_err' debug message.
Replace pr_debug with dev_dbg for 'mtk_v4l2_debug' debug message.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 113 +++++-----
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  52 ++---
 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       |   4 +-
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       |  24 ++-
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c |  85 ++++----
 .../vcodec/mtk_vcodec_dec_stateless.c         |  48 +++--
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 193 +++++++++---------
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  41 ++--
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       |  13 +-
 .../platform/mediatek/vcodec/mtk_vcodec_fw.c  |   4 +-
 .../mediatek/vcodec/mtk_vcodec_fw_scp.c       |   2 +-
 .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |   6 +-
 .../mediatek/vcodec/mtk_vcodec_intr.c         |   4 +-
 .../mediatek/vcodec/mtk_vcodec_util.c         |  27 +--
 .../mediatek/vcodec/mtk_vcodec_util.h         |  23 ++-
 .../vcodec/vdec/vdec_av1_req_lat_if.c         |  22 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |   4 +-
 .../vcodec/vdec/vdec_h264_req_multi_if.c      |   7 +-
 .../vcodec/vdec/vdec_hevc_req_multi_if.c      |   4 +-
 .../mediatek/vcodec/vdec/vdec_vp8_if.c        |  21 +-
 .../platform/mediatek/vcodec/vdec_drv_if.c    |   5 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c |  37 ++--
 .../platform/mediatek/vcodec/vdec_vpu_if.c    |   3 +-
 .../mediatek/vcodec/venc/venc_h264_if.c       |   3 +-
 .../mediatek/vcodec/venc/venc_vp8_if.c        |   3 +-
 25 files changed, 391 insertions(+), 357 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 93fcea821001..aae89a82d2a5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -82,7 +82,7 @@ static int vidioc_decoder_cmd(struct file *file, void *priv,
 	if (ret)
 		return ret;
 
-	mtk_v4l2_debug(1, "decoder cmd=%u", cmd->cmd);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1, "decoder cmd=%u", cmd->cmd);
 	dst_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
 				V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 	switch (cmd->cmd) {
@@ -90,11 +90,13 @@ static int vidioc_decoder_cmd(struct file *file, void *priv,
 		src_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
 				V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 		if (!vb2_is_streaming(src_vq)) {
-			mtk_v4l2_debug(1, "Output stream is off. No need to flush.");
+			mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+				       "Output stream is off. No need to flush.");
 			return 0;
 		}
 		if (!vb2_is_streaming(dst_vq)) {
-			mtk_v4l2_debug(1, "Capture stream is off. No need to flush.");
+			mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+				       "Capture stream is off. No need to flush.");
 			return 0;
 		}
 		v4l2_m2m_buf_queue(ctx->m2m_ctx, &ctx->empty_flush_buf.vb);
@@ -172,8 +174,8 @@ static int vidioc_vdec_qbuf(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
-		mtk_v4l2_err("[%d] Call on QBUF after unrecoverable error",
-				ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] Call on QBUF after unrecoverable error",
+			     ctx->id);
 		return -EIO;
 	}
 
@@ -186,8 +188,8 @@ static int vidioc_vdec_dqbuf(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
-		mtk_v4l2_err("[%d] Call on DQBUF after unrecoverable error",
-				ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] Call on DQBUF after unrecoverable error",
+			     ctx->id);
 		return -EIO;
 	}
 
@@ -288,11 +290,10 @@ static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 		    (pix_fmt_mp->height + 64) <= frmsize->max_height)
 			pix_fmt_mp->height += 64;
 
-		mtk_v4l2_debug(0,
-			"before resize width=%d, height=%d, after resize width=%d, height=%d, sizeimage=%d",
-			tmp_w, tmp_h, pix_fmt_mp->width,
-			pix_fmt_mp->height,
-			pix_fmt_mp->width * pix_fmt_mp->height);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 0,
+			       "before resize wxh=%dx%d, after resize wxh=%dx%d, sizeimage=%d",
+			       tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
+			       pix_fmt_mp->width * pix_fmt_mp->height);
 
 		pix_fmt_mp->num_planes = fmt->num_planes;
 		pix_fmt_mp->plane_fmt[0].sizeimage =
@@ -344,7 +345,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 	}
 
 	if (pix_fmt_mp->plane_fmt[0].sizeimage == 0) {
-		mtk_v4l2_err("sizeimage of output format must be given");
+		mtk_v4l2_err(ctx->dev->plat_dev, "sizeimage of output format must be given");
 		return -EINVAL;
 	}
 
@@ -432,7 +433,7 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	const struct mtk_video_fmt *fmt;
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 
-	mtk_v4l2_debug(3, "[%d]", ctx->id);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]", ctx->id);
 
 	q_data = mtk_vdec_get_q_data(ctx, f->type);
 	if (!q_data)
@@ -446,7 +447,7 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	if (!dec_pdata->uses_stateless_api &&
 	    f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
 	    vb2_is_busy(&ctx->m2m_ctx->out_q_ctx.q)) {
-		mtk_v4l2_err("out_q_ctx buffers already requested");
+		mtk_v4l2_err(ctx->dev->plat_dev, "out_q_ctx buffers already requested");
 		ret = -EBUSY;
 	}
 
@@ -456,7 +457,7 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	 */
 	if ((f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) &&
 	    vb2_is_busy(&ctx->m2m_ctx->cap_q_ctx.q)) {
-		mtk_v4l2_err("cap_q_ctx buffers already requested");
+		mtk_v4l2_err(ctx->dev->plat_dev, "cap_q_ctx buffers already requested");
 		ret = -EBUSY;
 	}
 
@@ -491,8 +492,8 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 		if (ctx->state == MTK_STATE_FREE) {
 			ret = vdec_if_init(ctx, q_data->fmt->fourcc);
 			if (ret) {
-				mtk_v4l2_err("[%d]: vdec_if_init() fail ret=%d",
-					ctx->id, ret);
+				mtk_v4l2_err(ctx->dev->plat_dev, "[%d]: vdec_if_init() fail ret=%d",
+					     ctx->id, ret);
 				return -EINVAL;
 			}
 			ctx->state = MTK_STATE_INIT;
@@ -515,8 +516,8 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 		 */
 		ret = vdec_if_get_param(ctx, GET_PARAM_PIC_INFO, &ctx->picinfo);
 		if (ret) {
-			mtk_v4l2_err("[%d]Error!! Get GET_PARAM_PICTURE_INFO Fail",
-				     ctx->id);
+			mtk_v4l2_err(ctx->dev->plat_dev,
+				     "[%d]Error!! Get GET_PARAM_PICTURE_INFO Fail", ctx->id);
 		}
 
 		ctx->last_decoded_picinfo = ctx->picinfo;
@@ -540,7 +541,8 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 
 		ctx->q_data[MTK_Q_DATA_DST].coded_width = ctx->picinfo.buf_w;
 		ctx->q_data[MTK_Q_DATA_DST].coded_height = ctx->picinfo.buf_h;
-		mtk_v4l2_debug(2, "[%d] vdec_if_init() num_plane = %d wxh=%dx%d pic wxh=%dx%d sz[0]=0x%x sz[1]=0x%x",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2,
+			       "[%d] vdec init num_plane:%d wxh=%dx%d pic wxh=%dx%d sz=0x%x_0x%x",
 			       ctx->id, pix_mp->num_planes, ctx->picinfo.buf_w, ctx->picinfo.buf_h,
 			       ctx->picinfo.pic_w, ctx->picinfo.pic_h,
 			       ctx->q_data[MTK_Q_DATA_DST].sizeimage[0],
@@ -570,14 +572,11 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 		fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
 		fsize->stepwise = dec_pdata->vdec_formats[i].frmsize;
 
-		mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
-				ctx->dev->dec_capability,
-				fsize->stepwise.min_width,
-				fsize->stepwise.max_width,
-				fsize->stepwise.step_width,
-				fsize->stepwise.min_height,
-				fsize->stepwise.max_height,
-				fsize->stepwise.step_height);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "%x, %d %d %d %d %d %d",
+			       ctx->dev->dec_capability, fsize->stepwise.min_width,
+			       fsize->stepwise.max_width, fsize->stepwise.step_width,
+			       fsize->stepwise.min_height, fsize->stepwise.max_height,
+			       fsize->stepwise.step_height);
 
 		return 0;
 	}
@@ -641,7 +640,7 @@ static int vidioc_vdec_g_fmt(struct file *file, void *priv,
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
 	if (!vq) {
-		mtk_v4l2_err("no vb2 queue for type=%d", f->type);
+		mtk_v4l2_err(ctx->dev->plat_dev, "no vb2 queue for type=%d", f->type);
 		return -EINVAL;
 	}
 
@@ -712,8 +711,9 @@ static int vidioc_vdec_g_fmt(struct file *file, void *priv,
 		pix_mp->plane_fmt[1].bytesperline = q_data->bytesperline[1];
 		pix_mp->plane_fmt[1].sizeimage = q_data->sizeimage[1];
 
-		mtk_v4l2_debug(1, "[%d] type=%d state=%d Format information could not be read, not ready yet!",
-				ctx->id, f->type, ctx->state);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+			       "[%d] type=%d state=%d Get format information fail, not ready yet!",
+			       ctx->id, f->type, ctx->state);
 	}
 
 	return 0;
@@ -730,7 +730,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 	q_data = mtk_vdec_get_q_data(ctx, vq->type);
 
 	if (q_data == NULL) {
-		mtk_v4l2_err("vq->type=%d err\n", vq->type);
+		mtk_v4l2_err(ctx->dev->plat_dev, "vq->type=%d err\n", vq->type);
 		return -EINVAL;
 	}
 
@@ -756,10 +756,9 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 			sizes[i] = q_data->sizeimage[i];
 	}
 
-	mtk_v4l2_debug(1,
-			"[%d]\t type = %d, get %d plane(s), %d buffer(s) of size 0x%x 0x%x ",
-			ctx->id, vq->type, *nplanes, *nbuffers,
-			sizes[0], sizes[1]);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+		       "[%d]\t type = %d, get %d plane(s), %d buffer(s) of size 0x%x 0x%x ",
+		       ctx->id, vq->type, *nplanes, *nbuffers, sizes[0], sizes[1]);
 
 	return 0;
 }
@@ -770,16 +769,16 @@ int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
 	struct mtk_q_data *q_data;
 	int i;
 
-	mtk_v4l2_debug(3, "[%d] (%d) id=%d",
-			ctx->id, vb->vb2_queue->type, vb->index);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] (%d) id=%d",
+		       ctx->id, vb->vb2_queue->type, vb->index);
 
 	q_data = mtk_vdec_get_q_data(ctx, vb->vb2_queue->type);
 
 	for (i = 0; i < q_data->fmt->num_planes; i++) {
 		if (vb2_plane_size(vb, i) < q_data->sizeimage[i]) {
-			mtk_v4l2_err("data will not fit into plane %d (%lu < %d)",
-				i, vb2_plane_size(vb, i),
-				q_data->sizeimage[i]);
+			mtk_v4l2_err(ctx->dev->plat_dev,
+				     "data will not fit into plane %d (%lu < %d)",
+				     i, vb2_plane_size(vb, i), q_data->sizeimage[i]);
 			return -EINVAL;
 		}
 		if (!V4L2_TYPE_IS_OUTPUT(vb->type))
@@ -807,7 +806,7 @@ void vb2ops_vdec_buf_finish(struct vb2_buffer *vb)
 	mutex_unlock(&ctx->lock);
 
 	if (buf_error) {
-		mtk_v4l2_err("Unrecoverable error on buffer.");
+		mtk_v4l2_err(ctx->dev->plat_dev, "Unrecoverable error on buffer.");
 		ctx->state = MTK_STATE_ABORT;
 	}
 }
@@ -843,8 +842,8 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
 	int ret;
 
-	mtk_v4l2_debug(3, "[%d] (%d) state=(%x) ctx->decoded_frame_cnt=%d",
-			ctx->id, q->type, ctx->state, ctx->decoded_frame_cnt);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] (%d) state=(%x) ctx->decoded_frame_cnt=%d",
+		       ctx->id, q->type, ctx->state, ctx->decoded_frame_cnt);
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		while ((src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx))) {
@@ -870,17 +869,17 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 		 */
 		ctx->picinfo = ctx->last_decoded_picinfo;
 
-		mtk_v4l2_debug(2,
-				"[%d]-> new(%d,%d), old(%d,%d), real(%d,%d)",
-				ctx->id, ctx->last_decoded_picinfo.pic_w,
-				ctx->last_decoded_picinfo.pic_h,
-				ctx->picinfo.pic_w, ctx->picinfo.pic_h,
-				ctx->last_decoded_picinfo.buf_w,
-				ctx->last_decoded_picinfo.buf_h);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2,
+			       "[%d]-> new(%d,%d), old(%d,%d), real(%d,%d)",
+			       ctx->id, ctx->last_decoded_picinfo.pic_w,
+			       ctx->last_decoded_picinfo.pic_h,
+			       ctx->picinfo.pic_w, ctx->picinfo.pic_h,
+			       ctx->last_decoded_picinfo.buf_w,
+			       ctx->last_decoded_picinfo.buf_h);
 
 		ret = ctx->dev->vdec_pdata->flush_decoder(ctx);
 		if (ret)
-			mtk_v4l2_err("DecodeFinal failed, ret=%d", ret);
+			mtk_v4l2_err(ctx->dev->plat_dev, "DecodeFinal failed, ret=%d", ret);
 	}
 	ctx->state = MTK_STATE_FLUSH;
 
@@ -905,7 +904,7 @@ static int m2mops_vdec_job_ready(void *m2m_priv)
 {
 	struct mtk_vcodec_ctx *ctx = m2m_priv;
 
-	mtk_v4l2_debug(3, "[%d]", ctx->id);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]", ctx->id);
 
 	if (ctx->state == MTK_STATE_ABORT)
 		return 0;
@@ -973,7 +972,7 @@ int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 	struct mtk_vcodec_ctx *ctx = priv;
 	int ret = 0;
 
-	mtk_v4l2_debug(3, "[%d]", ctx->id);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]", ctx->id);
 
 	src_vq->type		= V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
 	src_vq->io_modes	= VB2_DMABUF | VB2_MMAP;
@@ -988,7 +987,7 @@ int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	ret = vb2_queue_init(src_vq);
 	if (ret) {
-		mtk_v4l2_err("Failed to initialize videobuf2 queue(output)");
+		mtk_v4l2_err(ctx->dev->plat_dev, "Failed to initialize videobuf2 queue(output)");
 		return ret;
 	}
 	dst_vq->type		= V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
@@ -1004,7 +1003,7 @@ int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	ret = vb2_queue_init(dst_vq);
 	if (ret)
-		mtk_v4l2_err("Failed to initialize videobuf2 queue(capture)");
+		mtk_v4l2_err(ctx->dev->plat_dev, "Failed to initialize videobuf2 queue(capture)");
 
 	return ret;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 03721eda2769..b79470da72ba 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -33,7 +33,8 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
 	case MTK_VDEC_LAT_SINGLE_CORE:
 		return MTK_VDEC_ONE_LAT_ONE_CORE;
 	default:
-		mtk_v4l2_err("hw arch %d not supported", dev->vdec_pdata->hw_arch);
+		mtk_v4l2_err(dev->plat_dev, "hw arch %d not supported",
+			     dev->vdec_pdata->hw_arch);
 		return MTK_VDEC_NO_HW;
 	}
 }
@@ -52,7 +53,7 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 	/* check if HW active or not */
 	cg_status = readl(dev->reg_base[0]);
 	if ((cg_status & VDEC_HW_ACTIVE) != 0) {
-		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0 (0x%08x)",
+		mtk_v4l2_err(dev->plat_dev, "DEC ISR, VDEC active is not 0x0 (0x%08x)",
 			     cg_status);
 		return IRQ_HANDLED;
 	}
@@ -71,9 +72,8 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 
 	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
 
-	mtk_v4l2_debug(3,
-			"mtk_vcodec_dec_irq_handler :wake up ctx %d, dec_done_status=%x",
-			ctx->id, dec_done_status);
+	mtk_v4l2_debug(dev->plat_dev, 3, "wake up ctx %d, dec_done_status=%x",
+		       ctx->id, dec_done_status);
 
 	return IRQ_HANDLED;
 }
@@ -96,7 +96,7 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 		if (IS_ERR(dev->reg_base[i]))
 			return PTR_ERR(dev->reg_base[i]);
 
-		mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
+		mtk_v4l2_debug(dev->plat_dev, 2, "reg[%d] base=%p", i, dev->reg_base[i]);
 	}
 
 	return 0;
@@ -176,15 +176,14 @@ static int fops_vcodec_open(struct file *file)
 	ctx->type = MTK_INST_DECODER;
 	ret = dev->vdec_pdata->ctrls_setup(ctx);
 	if (ret) {
-		mtk_v4l2_err("Failed to setup mt vcodec controls");
+		mtk_v4l2_err(dev->plat_dev, "Failed to setup mt vcodec controls");
 		goto err_ctrls_setup;
 	}
 	ctx->m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev_dec, ctx,
 		&mtk_vcodec_dec_queue_init);
 	if (IS_ERR((__force void *)ctx->m2m_ctx)) {
 		ret = PTR_ERR((__force void *)ctx->m2m_ctx);
-		mtk_v4l2_err("Failed to v4l2_m2m_ctx_init() (%d)",
-			ret);
+		mtk_v4l2_err(dev->plat_dev, "Failed to v4l2_m2m_ctx_init() (%d)", ret);
 		goto err_m2m_ctx_init;
 	}
 	src_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
@@ -202,14 +201,14 @@ static int fops_vcodec_open(struct file *file)
 			 * Return 0 if downloading firmware successfully,
 			 * otherwise it is failed
 			 */
-			mtk_v4l2_err("failed to load firmware!");
+			mtk_v4l2_err(dev->plat_dev, "failed to load firmware!");
 			goto err_load_fw;
 		}
 
 		dev->dec_capability =
 			mtk_vcodec_fw_get_vdec_capa(dev->fw_handler);
 
-		mtk_v4l2_debug(0, "decoder capability %x", dev->dec_capability);
+		mtk_v4l2_debug(dev->plat_dev, 0, "decoder capability %x", dev->dec_capability);
 	}
 
 	ctx->dev->vdec_pdata->init_vdec_params(ctx);
@@ -218,8 +217,8 @@ static int fops_vcodec_open(struct file *file)
 	mtk_vcodec_dbgfs_create(ctx);
 
 	mutex_unlock(&dev->dev_mutex);
-	mtk_v4l2_debug(0, "%s decoder [%d]", dev_name(&dev->plat_dev->dev),
-			ctx->id);
+	mtk_v4l2_debug(dev->plat_dev, 0, "%s decoder [%d]", dev_name(&dev->plat_dev->dev),
+		       ctx->id);
 	return ret;
 
 	/* Deinit when failure occurred */
@@ -241,7 +240,7 @@ static int fops_vcodec_release(struct file *file)
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(file->private_data);
 
-	mtk_v4l2_debug(0, "[%d] decoder", ctx->id);
+	mtk_v4l2_debug(dev->plat_dev, 0, "[%d] decoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
 
 	/*
@@ -296,7 +295,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 					 &rproc_phandle)) {
 		fw_type = SCP;
 	} else {
-		mtk_v4l2_err("Could not get vdec IPI device");
+		mtk_v4l2_err(dev->plat_dev, "Could not get vdec IPI device");
 		return -ENODEV;
 	}
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
@@ -316,7 +315,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 			alloc_ordered_workqueue("core-decoder",
 						WQ_MEM_RECLAIM | WQ_FREEZABLE);
 		if (!dev->core_workqueue) {
-			mtk_v4l2_err("Failed to create core workqueue");
+			mtk_v4l2_err(dev->plat_dev, "Failed to create core workqueue");
 			ret = -EINVAL;
 			goto err_res;
 		}
@@ -332,13 +331,13 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
 	if (ret) {
-		mtk_v4l2_err("v4l2_device_register err=%d", ret);
+		mtk_v4l2_err(dev->plat_dev, "v4l2_device_register err=%d", ret);
 		goto err_core_workq;
 	}
 
 	vfd_dec = video_device_alloc();
 	if (!vfd_dec) {
-		mtk_v4l2_err("Failed to allocate video device");
+		mtk_v4l2_err(dev->plat_dev, "Failed to allocate video device");
 		ret = -ENOMEM;
 		goto err_dec_alloc;
 	}
@@ -359,7 +358,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	dev->m2m_dev_dec = v4l2_m2m_init(&mtk_vdec_m2m_ops);
 	if (IS_ERR((__force void *)dev->m2m_dev_dec)) {
-		mtk_v4l2_err("Failed to init mem2mem dec device");
+		mtk_v4l2_err(dev->plat_dev, "Failed to init mem2mem dec device");
 		ret = PTR_ERR((__force void *)dev->m2m_dev_dec);
 		goto err_dec_alloc;
 	}
@@ -368,7 +367,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		alloc_ordered_workqueue(MTK_VCODEC_DEC_NAME,
 			WQ_MEM_RECLAIM | WQ_FREEZABLE);
 	if (!dev->decode_workqueue) {
-		mtk_v4l2_err("Failed to create decode workqueue");
+		mtk_v4l2_err(dev->plat_dev, "Failed to create decode workqueue");
 		ret = -EINVAL;
 		goto err_event_workq;
 	}
@@ -377,7 +376,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		ret = of_platform_populate(pdev->dev.of_node, NULL, NULL,
 					   &pdev->dev);
 		if (ret) {
-			mtk_v4l2_err("Main device of_platform_populate failed.");
+			mtk_v4l2_err(dev->plat_dev, "Main device of_platform_populate failed.");
 			goto err_reg_cont;
 		}
 	} else {
@@ -390,7 +389,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	ret = video_register_device(vfd_dec, VFL_TYPE_VIDEO, -1);
 	if (ret) {
-		mtk_v4l2_err("Failed to register video device");
+		mtk_v4l2_err(dev->plat_dev, "Failed to register video device");
 		goto err_reg_cont;
 	}
 
@@ -409,21 +408,22 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		ret = v4l2_m2m_register_media_controller(dev->m2m_dev_dec, dev->vfd_dec,
 							 MEDIA_ENT_F_PROC_VIDEO_DECODER);
 		if (ret) {
-			mtk_v4l2_err("Failed to register media controller");
+			mtk_v4l2_err(dev->plat_dev, "Failed to register media controller");
 			goto err_dec_mem_init;
 		}
 
 		ret = media_device_register(&dev->mdev_dec);
 		if (ret) {
-			mtk_v4l2_err("Failed to register media device");
+			mtk_v4l2_err(dev->plat_dev, "Failed to register media device");
 			goto err_media_reg;
 		}
 
-		mtk_v4l2_debug(0, "media registered as /dev/media%d", vfd_dec->minor);
+		mtk_v4l2_debug(dev->plat_dev, 0, "media registered as /dev/media%d",
+			       vfd_dec->minor);
 	}
 
 	mtk_vcodec_dbgfs_init(dev, false);
-	mtk_v4l2_debug(0, "decoder registered as /dev/video%d", vfd_dec->minor);
+	mtk_v4l2_debug(dev->plat_dev, 0, "decoder registered as /dev/video%d", vfd_dec->minor);
 
 	return 0;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index b753bf54ebd9..2ed2ac1521fb 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -77,7 +77,7 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 	/* check if HW active or not */
 	cg_status = readl(dev->reg_base[VDEC_HW_SYS]);
 	if (cg_status & VDEC_HW_ACTIVE) {
-		mtk_v4l2_err("vdec active is not 0x0 (0x%08x)",
+		mtk_v4l2_err(dev->plat_dev, "vdec active is not 0x0 (0x%08x)",
 			     cg_status);
 		return IRQ_HANDLED;
 	}
@@ -93,7 +93,7 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 
 	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
 
-	mtk_v4l2_debug(3, "wake up ctx %d, dec_done_status=%x",
+	mtk_v4l2_debug(dev->plat_dev, 3, "wake up ctx %d, dec_done_status=%x",
 		       ctx->id, dec_done_status);
 
 	return IRQ_HANDLED;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 777d445999e9..4b2ccfdc273f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -32,7 +32,7 @@ int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *
 		if (!dec_clk->clk_info)
 			return -ENOMEM;
 	} else {
-		mtk_v4l2_err("Failed to get vdec clock count");
+		mtk_v4l2_err(pdev, "Failed to get vdec clock count");
 		return -EINVAL;
 	}
 
@@ -41,14 +41,13 @@ int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *
 		ret = of_property_read_string_index(pdev->dev.of_node,
 			"clock-names", i, &clk_info->clk_name);
 		if (ret) {
-			mtk_v4l2_err("Failed to get clock name id = %d", i);
+			mtk_v4l2_err(pdev, "Failed to get clock name id = %d", i);
 			return ret;
 		}
 		clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
 			clk_info->clk_name);
 		if (IS_ERR(clk_info->vcodec_clk)) {
-			mtk_v4l2_err("devm_clk_get (%d)%s fail", i,
-				clk_info->clk_name);
+			mtk_v4l2_err(pdev, "devm_clk_get (%d)%s fail", i, clk_info->clk_name);
 			return PTR_ERR(clk_info->vcodec_clk);
 		}
 	}
@@ -59,26 +58,29 @@ EXPORT_SYMBOL_GPL(mtk_vcodec_init_dec_clk);
 
 static int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
 {
+	struct platform_device *pdev = container_of(pm->dev, struct platform_device, dev);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(pm->dev);
 	if (ret)
-		mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
+		mtk_v4l2_err(pdev, "pm_runtime_resume_and_get fail %d", ret);
 
 	return ret;
 }
 
 static void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
 {
+	struct platform_device *pdev = container_of(pm->dev, struct platform_device, dev);
 	int ret;
 
 	ret = pm_runtime_put(pm->dev);
 	if (ret && ret != -EAGAIN)
-		mtk_v4l2_err("pm_runtime_put fail %d", ret);
+		mtk_v4l2_err(pdev, "pm_runtime_put fail %d", ret);
 }
 
 static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 {
+	struct platform_device *pdev = container_of(pm->dev, struct platform_device, dev);
 	struct mtk_vcodec_clk *dec_clk;
 	int ret, i;
 
@@ -86,8 +88,8 @@ static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 	for (i = 0; i < dec_clk->clk_num; i++) {
 		ret = clk_prepare_enable(dec_clk->clk_info[i].vcodec_clk);
 		if (ret) {
-			mtk_v4l2_err("clk_prepare_enable %d %s fail %d", i,
-				dec_clk->clk_info[i].clk_name, ret);
+			mtk_v4l2_err(pdev, "clk_prepare_enable %d %s fail %d", i,
+				     dec_clk->clk_info[i].clk_name, ret);
 			goto error;
 		}
 	}
@@ -120,7 +122,7 @@ static void mtk_vcodec_dec_enable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_id
 		if (subdev_dev)
 			enable_irq(subdev_dev->dec_irq);
 		else
-			mtk_v4l2_err("Failed to get hw dev\n");
+			mtk_v4l2_err(vdec_dev->plat_dev, "Failed to get hw dev\n");
 	} else {
 		enable_irq(vdec_dev->dec_irq);
 	}
@@ -138,7 +140,7 @@ static void mtk_vcodec_dec_disable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_i
 		if (subdev_dev)
 			disable_irq(subdev_dev->dec_irq);
 		else
-			mtk_v4l2_err("Failed to get hw dev\n");
+			mtk_v4l2_err(vdec_dev->plat_dev, "Failed to get hw dev\n");
 	} else {
 		disable_irq(vdec_dev->dec_irq);
 	}
@@ -185,7 +187,7 @@ static struct mtk_vcodec_pm *mtk_vcodec_dec_get_pm(struct mtk_vcodec_dev *vdec_d
 		if (subdev_dev)
 			return &subdev_dev->pm;
 
-		mtk_v4l2_err("Failed to get hw dev\n");
+		mtk_v4l2_err(vdec_dev->plat_dev, "Failed to get hw dev\n");
 		return NULL;
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 29991551cf61..6e7e4f10bb2f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -61,15 +61,16 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
 	struct mtk_video_dec_buf *dstbuf;
 	struct vb2_v4l2_buffer *vb;
 
-	mtk_v4l2_debug(3, "[%d]", ctx->id);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]", ctx->id);
 	if (vdec_if_get_param(ctx, GET_PARAM_DISP_FRAME_BUFFER,
 			      &disp_frame_buffer)) {
-		mtk_v4l2_err("[%d]Cannot get param : GET_PARAM_DISP_FRAME_BUFFER", ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev,
+			     "[%d]Cannot get param : GET_PARAM_DISP_FRAME_BUFFER", ctx->id);
 		return NULL;
 	}
 
 	if (!disp_frame_buffer) {
-		mtk_v4l2_debug(3, "No display frame buffer");
+		mtk_v4l2_debug(ctx->dev->plat_dev, 3, "No display frame buffer");
 		return NULL;
 	}
 
@@ -78,7 +79,7 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
 	vb = &dstbuf->m2m_buf.vb;
 	mutex_lock(&ctx->lock);
 	if (dstbuf->used) {
-		mtk_v4l2_debug(2, "[%d]status=%x queue id=%d to done_list %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "[%d]status=%x queue id=%d to done_list %d",
 			       ctx->id, disp_frame_buffer->status,
 			       vb->vb2_buf.index, dstbuf->queued_in_vb2);
 
@@ -105,15 +106,15 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 
 	if (vdec_if_get_param(ctx, GET_PARAM_FREE_FRAME_BUFFER,
 			      &free_frame_buffer)) {
-		mtk_v4l2_err("[%d] Error!! Cannot get param", ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] Error!! Cannot get param", ctx->id);
 		return NULL;
 	}
 	if (!free_frame_buffer) {
-		mtk_v4l2_debug(3, " No free frame buffer");
+		mtk_v4l2_debug(ctx->dev->plat_dev, 3, " No free frame buffer");
 		return NULL;
 	}
 
-	mtk_v4l2_debug(3, "[%d] tmp_frame_addr = 0x%p", ctx->id,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] tmp_frame_addr = 0x%p", ctx->id,
 		       free_frame_buffer);
 
 	dstbuf = container_of(free_frame_buffer, struct mtk_video_dec_buf,
@@ -131,7 +132,8 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 			 * This reduce overheads that dq/q unused capture
 			 * buffer. In this case, queued_in_vb2 = true.
 			 */
-			mtk_v4l2_debug(2, "[%d]status=%x queue id=%d to rdy_queue %d",
+			mtk_v4l2_debug(ctx->dev->plat_dev, 2,
+				       "[%d]status=%x queue id=%d to rdy_queue %d",
 				       ctx->id, free_frame_buffer->status,
 				       vb->vb2_buf.index, dstbuf->queued_in_vb2);
 			v4l2_m2m_buf_queue(ctx->m2m_ctx, vb);
@@ -146,7 +148,7 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 			 * means this buffer is not from previous decode
 			 * output.
 			 */
-			mtk_v4l2_debug(2,
+			mtk_v4l2_debug(ctx->dev->plat_dev, 2,
 				       "[%d]status=%x queue id=%d to rdy_queue",
 				       ctx->id, free_frame_buffer->status,
 				       vb->vb2_buf.index);
@@ -161,7 +163,7 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 			 * When this buffer q from user space, it could
 			 * directly q to vb2 buffer
 			 */
-			mtk_v4l2_debug(3, "[%d]status=%x err queue id=%d %d %d",
+			mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]status=%x err queue id=%d %d %d",
 				       ctx->id, free_frame_buffer->status,
 				       vb->vb2_buf.index, dstbuf->queued_in_vb2,
 				       dstbuf->queued_in_v4l2);
@@ -191,7 +193,7 @@ static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_ctx *ctx)
 		.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
 	};
 
-	mtk_v4l2_debug(1, "[%d]", ctx->id);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d]", ctx->id);
 	v4l2_event_queue_fh(&ctx->fh, &ev_src_ch);
 }
 
@@ -202,7 +204,7 @@ static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
 
 	ret = vdec_if_decode(ctx, NULL, NULL, &res_chg);
 	if (ret)
-		mtk_v4l2_err("DecodeFinal failed, ret=%d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "DecodeFinal failed, ret=%d", ret);
 
 	clean_display_buffer(ctx);
 	clean_free_buffer(ctx);
@@ -221,14 +223,14 @@ static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
 	for (k = 0; k < num_supported_formats; k++) {
 		fmt = &mtk_video_formats[k];
 		if (fmt->fourcc == pixelformat) {
-			mtk_v4l2_debug(1, "Update cap fourcc(%d -> %d)",
+			mtk_v4l2_debug(ctx->dev->plat_dev, 1, "Update cap fourcc(%d -> %d)",
 				       dst_q_data->fmt->fourcc, pixelformat);
 			dst_q_data->fmt = fmt;
 			return;
 		}
 	}
 
-	mtk_v4l2_err("Cannot get fourcc(%d), using init value", pixelformat);
+	mtk_v4l2_err(ctx->dev->plat_dev, "Cannot get fourcc(%d), using init value", pixelformat);
 }
 
 static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
@@ -238,7 +240,8 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
 
 	if (vdec_if_get_param(ctx, GET_PARAM_PIC_INFO,
 			      &ctx->last_decoded_picinfo)) {
-		mtk_v4l2_err("[%d]Error!! Cannot get param : GET_PARAM_PICTURE_INFO ERR", ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev,
+			     "[%d]Error!! Cannot get param : GET_PARAM_PICTURE_INFO ERR", ctx->id);
 		return -EINVAL;
 	}
 
@@ -246,7 +249,7 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
 	    ctx->last_decoded_picinfo.pic_h == 0 ||
 	    ctx->last_decoded_picinfo.buf_w == 0 ||
 	    ctx->last_decoded_picinfo.buf_h == 0) {
-		mtk_v4l2_err("Cannot get correct pic info");
+		mtk_v4l2_err(ctx->dev->plat_dev, "Cannot get correct pic info");
 		return -EINVAL;
 	}
 
@@ -258,7 +261,7 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
 	    ctx->last_decoded_picinfo.pic_h == ctx->picinfo.pic_h)
 		return 0;
 
-	mtk_v4l2_debug(1, "[%d]-> new(%d,%d), old(%d,%d), real(%d,%d)", ctx->id,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d]-> new(%d,%d), old(%d,%d), real(%d,%d)", ctx->id,
 		       ctx->last_decoded_picinfo.pic_w,
 		       ctx->last_decoded_picinfo.pic_h, ctx->picinfo.pic_w,
 		       ctx->picinfo.pic_h, ctx->last_decoded_picinfo.buf_w,
@@ -266,7 +269,7 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
 
 	ret = vdec_if_get_param(ctx, GET_PARAM_DPB_SIZE, &dpbsize);
 	if (dpbsize == 0)
-		mtk_v4l2_err("Incorrect dpb size, ret=%d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "Incorrect dpb size, ret=%d", ret);
 
 	ctx->dpb_size = dpbsize;
 
@@ -288,14 +291,14 @@ static void mtk_vdec_worker(struct work_struct *work)
 	src_buf = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
 	if (!src_buf) {
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
-		mtk_v4l2_debug(1, "[%d] src_buf empty!!", ctx->id);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] src_buf empty!!", ctx->id);
 		return;
 	}
 
 	dst_buf = v4l2_m2m_next_dst_buf(ctx->m2m_ctx);
 	if (!dst_buf) {
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
-		mtk_v4l2_debug(1, "[%d] dst_buf empty!!", ctx->id);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] dst_buf empty!!", ctx->id);
 		return;
 	}
 
@@ -313,15 +316,15 @@ static void mtk_vdec_worker(struct work_struct *work)
 		vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 1);
 	pfb->base_c.size = ctx->picinfo.fb_sz[1];
 	pfb->status = 0;
-	mtk_v4l2_debug(3, "===>[%d] vdec_if_decode() ===>", ctx->id);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "===>[%d] vdec_if_decode() ===>", ctx->id);
 
-	mtk_v4l2_debug(3,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3,
 		       "id=%d Framebuf  pfb=%p VA=%p Y_DMA=%pad C_DMA=%pad Size=%zx",
 		       dst_buf->vb2_buf.index, pfb, pfb->base_y.va,
 		       &pfb->base_y.dma_addr, &pfb->base_c.dma_addr, pfb->base_y.size);
 
 	if (src_buf == &ctx->empty_flush_buf.vb) {
-		mtk_v4l2_debug(1, "Got empty flush input buffer.");
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "Got empty flush input buffer.");
 		src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
 
 		/* update dst buf status */
@@ -350,11 +353,11 @@ static void mtk_vdec_worker(struct work_struct *work)
 	buf.size = (size_t)src_buf->vb2_buf.planes[0].bytesused;
 	if (!buf.va) {
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
-		mtk_v4l2_err("[%d] id=%d src_addr is NULL!!", ctx->id,
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] id=%d src_addr is NULL!!", ctx->id,
 			     src_buf->vb2_buf.index);
 		return;
 	}
-	mtk_v4l2_debug(3, "[%d] Bitstream VA=%p DMA=%pad Size=%zx vb=%p",
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] Bitstream VA=%p DMA=%pad Size=%zx vb=%p",
 		       ctx->id, buf.va, &buf.dma_addr, buf.size, src_buf);
 	dst_buf->vb2_buf.timestamp = src_buf->vb2_buf.timestamp;
 	dst_buf->timecode = src_buf->timecode;
@@ -366,7 +369,8 @@ static void mtk_vdec_worker(struct work_struct *work)
 	ret = vdec_if_decode(ctx, &buf, pfb, &res_chg);
 
 	if (ret) {
-		mtk_v4l2_err(" <===[%d], src_buf[%d] sz=0x%zx pts=%llu dst_buf[%d] vdec_if_decode() ret=%d res_chg=%d===>",
+		mtk_v4l2_err(ctx->dev->plat_dev,
+			     "[%d], src[%d] sz=0x%zx pts=%llu dst[%d] decode() ret=%d res_chg=%d",
 			     ctx->id, src_buf->vb2_buf.index, buf.size,
 			     src_buf->vb2_buf.timestamp, dst_buf->vb2_buf.index, ret, res_chg);
 		src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
@@ -421,7 +425,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct mtk_q_data *dst_q_data;
 
-	mtk_v4l2_debug(3, "[%d] (%d) id=%d, vb=%p", ctx->id,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] (%d) id=%d, vb=%p", ctx->id,
 		       vb->vb2_queue->type, vb->index, vb);
 	/*
 	 * check if this buffer is ready to be used after decode
@@ -448,20 +452,20 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 	v4l2_m2m_buf_queue(ctx->m2m_ctx, to_vb2_v4l2_buffer(vb));
 
 	if (ctx->state != MTK_STATE_INIT) {
-		mtk_v4l2_debug(3, "[%d] already init driver %d", ctx->id,
+		mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] already init driver %d", ctx->id,
 			       ctx->state);
 		return;
 	}
 
 	src_buf = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
 	if (!src_buf) {
-		mtk_v4l2_err("No src buffer");
+		mtk_v4l2_err(ctx->dev->plat_dev, "No src buffer");
 		return;
 	}
 
 	if (src_buf == &ctx->empty_flush_buf.vb) {
 		/* This shouldn't happen. Just in case. */
-		mtk_v4l2_err("Invalid flush buffer.");
+		mtk_v4l2_err(ctx->dev->plat_dev, "Invalid flush buffer.");
 		v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
 		return;
 	}
@@ -469,7 +473,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 	src_mem.va = vb2_plane_vaddr(&src_buf->vb2_buf, 0);
 	src_mem.dma_addr = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
 	src_mem.size = (size_t)src_buf->vb2_buf.planes[0].bytesused;
-	mtk_v4l2_debug(2, "[%d] buf id=%d va=%p dma=%pad size=%zx", ctx->id,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 2, "[%d] buf id=%d va=%p dma=%pad size=%zx", ctx->id,
 		       src_buf->vb2_buf.index, src_mem.va, &src_mem.dma_addr,
 		       src_mem.size);
 
@@ -484,20 +488,22 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 
 		src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
 		if (ret == -EIO) {
-			mtk_v4l2_err("[%d] Unrecoverable error in vdec_if_decode.", ctx->id);
+			mtk_v4l2_err(ctx->dev->plat_dev,
+				     "[%d] Unrecoverable error in vdec_if_decode.", ctx->id);
 			ctx->state = MTK_STATE_ABORT;
 			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
 		} else {
 			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
 		}
-		mtk_v4l2_debug(ret ? 0 : 1,
+		mtk_v4l2_debug(ctx->dev->plat_dev, ret ? 0 : 1,
 			       "[%d] vdec_if_decode() src_buf=%d, size=%zu, fail=%d, res_chg=%d",
 			       ctx->id, src_buf->vb2_buf.index, src_mem.size, ret, res_chg);
 		return;
 	}
 
 	if (vdec_if_get_param(ctx, GET_PARAM_PIC_INFO, &ctx->picinfo)) {
-		mtk_v4l2_err("[%d]Error!! Cannot get param : GET_PARAM_PICTURE_INFO ERR", ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev,
+			     "[%d]Error!! Cannot get param : GET_PARAM_PICTURE_INFO ERR", ctx->id);
 		return;
 	}
 
@@ -508,17 +514,18 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 		dst_q_data->bytesperline[i] = ctx->picinfo.buf_w;
 	}
 
-	mtk_v4l2_debug(2, "[%d] vdec_if_init() OK wxh=%dx%d pic wxh=%dx%d sz[0]=0x%x sz[1]=0x%x",
+	mtk_v4l2_debug(ctx->dev->plat_dev, 2,
+		       "[%d] vdec_if_init() OK wxh=%dx%d pic wxh=%dx%d sz[0]=0x%x sz[1]=0x%x",
 		       ctx->id, ctx->picinfo.buf_w, ctx->picinfo.buf_h, ctx->picinfo.pic_w,
 		       ctx->picinfo.pic_h, dst_q_data->sizeimage[0], dst_q_data->sizeimage[1]);
 
 	ret = vdec_if_get_param(ctx, GET_PARAM_DPB_SIZE, &dpbsize);
 	if (dpbsize == 0)
-		mtk_v4l2_err("[%d] GET_PARAM_DPB_SIZE fail=%d", ctx->id, ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] GET_PARAM_DPB_SIZE fail=%d", ctx->id, ret);
 
 	ctx->dpb_size = dpbsize;
 	ctx->state = MTK_STATE_HEADER;
-	mtk_v4l2_debug(1, "[%d] dpbsize=%d", ctx->id, ctx->dpb_size);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] dpbsize=%d", ctx->id, ctx->dpb_size);
 
 	mtk_vdec_queue_res_chg_event(ctx);
 }
@@ -533,7 +540,7 @@ static int mtk_vdec_g_v_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctx->state >= MTK_STATE_HEADER) {
 			ctrl->val = ctx->dpb_size;
 		} else {
-			mtk_v4l2_debug(0, "Seqinfo not ready");
+			mtk_v4l2_debug(ctx->dev->plat_dev, 0, "Seqinfo not ready");
 			ctrl->val = 0;
 		}
 		break;
@@ -570,7 +577,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 			       V4L2_MPEG_VIDEO_H264_PROFILE_MAIN);
 
 	if (ctx->ctrl_hdl.error) {
-		mtk_v4l2_err("Adding control failed %d", ctx->ctrl_hdl.error);
+		mtk_v4l2_err(ctx->dev->plat_dev, "Adding control failed %d", ctx->ctrl_hdl.error);
 		return ctx->ctrl_hdl.error;
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index db1e14a1bd6c..4c97cd9afd16 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -232,10 +232,10 @@ static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_ctx *ctx, int error
 	vb2_dst = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
 	if (vb2_dst) {
 		v4l2_m2m_buf_done(vb2_dst, state);
-		mtk_v4l2_debug(2, "free frame buffer id:%d to done list",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "free frame buffer id:%d to done list",
 			       vb2_dst->vb2_buf.index);
 	} else {
-		mtk_v4l2_err("dst buffer is NULL");
+		mtk_v4l2_err(ctx->dev->plat_dev, "dst buffer is NULL");
 	}
 
 	if (src_buf_req)
@@ -251,7 +251,7 @@ static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx)
 
 	vb2_v4l2 = v4l2_m2m_next_dst_buf(ctx->m2m_ctx);
 	if (!vb2_v4l2) {
-		mtk_v4l2_debug(1, "[%d] dst_buf empty!!", ctx->id);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] dst_buf empty!!", ctx->id);
 		return NULL;
 	}
 
@@ -269,7 +269,8 @@ static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx)
 			vb2_dma_contig_plane_dma_addr(dst_buf, 1);
 		pfb->base_c.size = ctx->q_data[MTK_Q_DATA_DST].sizeimage[1];
 	}
-	mtk_v4l2_debug(1, "id=%d Framebuf  pfb=%p VA=%p Y_DMA=%pad C_DMA=%pad Size=%zx frame_count = %d",
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+		       "id=%d Framebuf pfb=%p VA=%p Y/C_DMA=%pad_%pad Size=%zx frame_count = %d",
 		       dst_buf->index, pfb, pfb->base_y.va, &pfb->base_y.dma_addr,
 		       &pfb->base_c.dma_addr, pfb->base_y.size, ctx->decoded_frame_cnt);
 
@@ -300,7 +301,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 	vb2_v4l2_src = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
 	if (!vb2_v4l2_src) {
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
-		mtk_v4l2_debug(1, "[%d] no available source buffer", ctx->id);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] no available source buffer", ctx->id);
 		return;
 	}
 
@@ -309,7 +310,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 				   m2m_buf.vb);
 	bs_src = &dec_buf_src->bs_buffer;
 
-	mtk_v4l2_debug(3, "[%d] (%d) id=%d, vb=%p", ctx->id,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] (%d) id=%d, vb=%p", ctx->id,
 		       vb2_src->vb2_queue->type, vb2_src->index, vb2_src);
 
 	bs_src->va = vb2_plane_vaddr(vb2_src, 0);
@@ -317,25 +318,25 @@ static void mtk_vdec_worker(struct work_struct *work)
 	bs_src->size = (size_t)vb2_src->planes[0].bytesused;
 	if (!bs_src->va) {
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
-		mtk_v4l2_err("[%d] id=%d source buffer is NULL", ctx->id,
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] id=%d source buffer is NULL", ctx->id,
 			     vb2_src->index);
 		return;
 	}
 
-	mtk_v4l2_debug(3, "[%d] Bitstream VA=%p DMA=%pad Size=%zx vb=%p",
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] Bitstream VA=%p DMA=%pad Size=%zx vb=%p",
 		       ctx->id, bs_src->va, &bs_src->dma_addr, bs_src->size, vb2_src);
 	/* Apply request controls. */
 	src_buf_req = vb2_src->req_obj.req;
 	if (src_buf_req)
 		v4l2_ctrl_request_setup(src_buf_req, &ctx->ctrl_hdl);
 	else
-		mtk_v4l2_err("vb2 buffer media request is NULL");
+		mtk_v4l2_err(ctx->dev->plat_dev, "vb2 buffer media request is NULL");
 
 	ret = vdec_if_decode(ctx, bs_src, NULL, &res_chg);
 	if (ret && ret != -EAGAIN) {
-		mtk_v4l2_err(" <===[%d], src_buf[%d] sz=0x%zx pts=%llu vdec_if_decode() ret=%d res_chg=%d===>",
-			     ctx->id, vb2_src->index, bs_src->size,
-			     vb2_src->timestamp, ret, res_chg);
+		mtk_v4l2_err(ctx->dev->plat_dev,
+			     "[%d], src[%d] sz=0x%zx pts=%llu decode() ret=%d res_chg=%d", ctx->id,
+			     vb2_src->index, bs_src->size, vb2_src->timestamp, ret, res_chg);
 		if (ret == -EIO) {
 			mutex_lock(&ctx->lock);
 			dec_buf_src->error = true;
@@ -363,7 +364,8 @@ static void vb2ops_vdec_stateless_buf_queue(struct vb2_buffer *vb)
 	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2 = to_vb2_v4l2_buffer(vb);
 
-	mtk_v4l2_debug(3, "[%d] (%d) id=%d, vb=%p", ctx->id, vb->vb2_queue->type, vb->index, vb);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] (%d) id=%d, vb=%p", ctx->id,
+		       vb->vb2_queue->type, vb->index, vb);
 
 	mutex_lock(&ctx->lock);
 	v4l2_m2m_buf_queue(ctx->m2m_ctx, vb2_v4l2);
@@ -374,9 +376,10 @@ static void vb2ops_vdec_stateless_buf_queue(struct vb2_buffer *vb)
 	/* If an OUTPUT buffer, we may need to update the state */
 	if (ctx->state == MTK_STATE_INIT) {
 		ctx->state = MTK_STATE_HEADER;
-		mtk_v4l2_debug(1, "Init driver from init to header.");
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "Init driver from init to header.");
 	} else {
-		mtk_v4l2_debug(3, "[%d] already init driver %d", ctx->id, ctx->state);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d] already init driver %d",
+			       ctx->id, ctx->state);
 	}
 }
 
@@ -393,7 +396,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 
 	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS);
 	if (ctx->ctrl_hdl.error) {
-		mtk_v4l2_err("v4l2_ctrl_handler_init failed\n");
+		mtk_v4l2_err(ctx->dev->plat_dev, "v4l2_ctrl_handler_init failed\n");
 		return ctx->ctrl_hdl.error;
 	}
 
@@ -402,7 +405,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 
 		v4l2_ctrl_new_custom(&ctx->ctrl_hdl, &cfg, NULL);
 		if (ctx->ctrl_hdl.error) {
-			mtk_v4l2_err("Adding control %d failed %d", i, ctx->ctrl_hdl.error);
+			mtk_v4l2_err(ctx->dev->plat_dev, "Adding control %d failed %d",
+				     i, ctx->ctrl_hdl.error);
 			return ctx->ctrl_hdl.error;
 		}
 	}
@@ -415,16 +419,18 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 static int fops_media_request_validate(struct media_request *mreq)
 {
 	const unsigned int buffer_cnt = vb2_request_buffer_cnt(mreq);
+	struct platform_device *plat_dev = container_of(mreq->mdev->dev,
+		struct platform_device, dev);
 
 	switch (buffer_cnt) {
 	case 1:
 		/* We expect exactly one buffer with the request */
 		break;
 	case 0:
-		mtk_v4l2_debug(1, "No buffer provided with the request");
+		mtk_v4l2_debug(plat_dev, 1, "No buffer provided with the request");
 		return -ENOENT;
 	default:
-		mtk_v4l2_debug(1, "Too many buffers (%d) provided with the request",
+		mtk_v4l2_debug(plat_dev, 1, "Too many buffers (%d) provided with the request",
 			       buffer_cnt);
 		return -EINVAL;
 	}
@@ -470,12 +476,12 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 		mtk_video_formats[count_formats].num_planes = 2;
 		break;
 	default:
-		mtk_v4l2_err("Can not add unsupported format type");
+		mtk_v4l2_err(ctx->dev->plat_dev, "Can not add unsupported format type");
 		return;
 	}
 
 	num_formats++;
-	mtk_v4l2_debug(3, "num_formats: %d dec_capability: 0x%x",
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "num_formats: %d dec_capability: 0x%x",
 		       count_formats, ctx->dev->dec_capability);
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index db65e77bd373..630ecc9f2240 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -51,62 +51,63 @@ static int vidioc_venc_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_BITRATE_MODE val= %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_BITRATE_MODE val= %d",
 			       ctrl->val);
 		if (ctrl->val != V4L2_MPEG_VIDEO_BITRATE_MODE_CBR) {
-			mtk_v4l2_err("Unsupported bitrate mode =%d", ctrl->val);
+			mtk_v4l2_err(ctx->dev->plat_dev, "Unsupported bitrate mode =%d", ctrl->val);
 			ret = -EINVAL;
 		}
 		break;
 	case V4L2_CID_MPEG_VIDEO_BITRATE:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_BITRATE val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_BITRATE val = %d",
 			       ctrl->val);
 		p->bitrate = ctrl->val;
 		ctx->param_change |= MTK_ENCODE_PARAM_BITRATE;
 		break;
 	case V4L2_CID_MPEG_VIDEO_B_FRAMES:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_B_FRAMES val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_B_FRAMES val = %d",
 			       ctrl->val);
 		p->num_b_frame = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2,
+			       "V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE val = %d",
 			       ctrl->val);
 		p->rc_frame = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_MAX_QP:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_H264_MAX_QP val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_H264_MAX_QP val = %d",
 			       ctrl->val);
 		p->h264_max_qp = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_HEADER_MODE val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_HEADER_MODE val = %d",
 			       ctrl->val);
 		p->seq_hdr_mode = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE val = %d",
 			       ctrl->val);
 		p->rc_mb = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_H264_PROFILE val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_H264_PROFILE val = %d",
 			       ctrl->val);
 		p->h264_profile = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_H264_LEVEL val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_H264_LEVEL val = %d",
 			       ctrl->val);
 		p->h264_level = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_I_PERIOD:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_H264_I_PERIOD val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_H264_I_PERIOD val = %d",
 			       ctrl->val);
 		p->intra_period = ctrl->val;
 		ctx->param_change |= MTK_ENCODE_PARAM_INTRA_PERIOD;
 		break;
 	case V4L2_CID_MPEG_VIDEO_GOP_SIZE:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_GOP_SIZE val = %d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_GOP_SIZE val = %d",
 			       ctrl->val);
 		p->gop_size = ctrl->val;
 		ctx->param_change |= MTK_ENCODE_PARAM_GOP_SIZE;
@@ -116,10 +117,11 @@ static int vidioc_venc_s_ctrl(struct v4l2_ctrl *ctrl)
 		 * FIXME - what vp8 profiles are actually supported?
 		 * The ctrl is added (with only profile 0 supported) for now.
 		 */
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_VP8_PROFILE val = %d", ctrl->val);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_VP8_PROFILE val = %d",
+			       ctrl->val);
 		break;
 	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
-		mtk_v4l2_debug(2, "V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME");
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME");
 		p->force_intra = 1;
 		ctx->param_change |= MTK_ENCODE_PARAM_FORCE_INTRA;
 		break;
@@ -341,7 +343,8 @@ static int vidioc_try_fmt_out(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 	if (pix_fmt_mp->height < tmp_h && (pix_fmt_mp->height + 32) <= max_height)
 		pix_fmt_mp->height += 32;
 
-	mtk_v4l2_debug(0, "before resize w=%d, h=%d, after resize w=%d, h=%d, sizeimage=%d %d",
+	mtk_v4l2_debug(ctx->dev->plat_dev, 0,
+		       "before resize w=%d, h=%d, after resize w=%d, h=%d, sizeimage=%d %d",
 		       tmp_w, tmp_h, pix_fmt_mp->width,
 		       pix_fmt_mp->height,
 		       pix_fmt_mp->plane_fmt[0].sizeimage,
@@ -396,7 +399,7 @@ static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
 		param->input_yuv_fmt = VENC_YUV_FORMAT_NV21;
 		break;
 	default:
-		mtk_v4l2_err("Unsupported fourcc =%d", q_data_src->fmt->fourcc);
+		mtk_v4l2_err(ctx->dev->plat_dev, "Unsupported fourcc =%d", q_data_src->fmt->fourcc);
 		break;
 	}
 	param->h264_profile = enc_params->h264_profile;
@@ -414,13 +417,13 @@ static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
 	param->gop_size = enc_params->gop_size;
 	param->bitrate = enc_params->bitrate;
 
-	mtk_v4l2_debug(0,
-		"fmt 0x%x, P/L %d/%d, w/h %d/%d, buf %d/%d, fps/bps %d/%d, gop %d, i_period %d",
-		param->input_yuv_fmt, param->h264_profile,
-		param->h264_level, param->width, param->height,
-		param->buf_width, param->buf_height,
-		param->frm_rate, param->bitrate,
-		param->gop_size, param->intra_period);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 0,
+		       "fmt 0x%x P/L %d/%d w/h %d/%d buf %d/%d fps/bps %d/%d gop %d i_period %d",
+		       param->input_yuv_fmt, param->h264_profile,
+		       param->h264_level, param->width, param->height,
+		       param->buf_width, param->buf_height,
+		       param->frm_rate, param->bitrate,
+		       param->gop_size, param->intra_period);
 }
 
 static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
@@ -435,12 +438,12 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
 	if (!vq) {
-		mtk_v4l2_err("fail to get vq");
+		mtk_v4l2_err(ctx->dev->plat_dev, "fail to get vq");
 		return -EINVAL;
 	}
 
 	if (vb2_is_busy(vq)) {
-		mtk_v4l2_err("queue busy");
+		mtk_v4l2_err(ctx->dev->plat_dev, "queue busy");
 		return -EBUSY;
 	}
 
@@ -468,8 +471,8 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 	if (ctx->state == MTK_STATE_FREE) {
 		ret = venc_if_init(ctx, q_data->fmt->fourcc);
 		if (ret) {
-			mtk_v4l2_err("venc_if_init failed=%d, codec type=%x",
-					ret, q_data->fmt->fourcc);
+			mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_init failed=%d, codec type=%x",
+				     ret, q_data->fmt->fourcc);
 			return -EBUSY;
 		}
 		ctx->state = MTK_STATE_INIT;
@@ -490,12 +493,12 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
 	if (!vq) {
-		mtk_v4l2_err("fail to get vq");
+		mtk_v4l2_err(ctx->dev->plat_dev, "fail to get vq");
 		return -EINVAL;
 	}
 
 	if (vb2_is_busy(vq)) {
-		mtk_v4l2_err("queue busy");
+		mtk_v4l2_err(ctx->dev->plat_dev, "queue busy");
 		return -EBUSY;
 	}
 
@@ -670,8 +673,8 @@ static int vidioc_venc_qbuf(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
-		mtk_v4l2_err("[%d] Call on QBUF after unrecoverable error",
-				ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] Call on QBUF after unrecoverable error",
+			     ctx->id);
 		return -EIO;
 	}
 
@@ -685,8 +688,8 @@ static int vidioc_venc_dqbuf(struct file *file, void *priv,
 	int ret;
 
 	if (ctx->state == MTK_STATE_ABORT) {
-		mtk_v4l2_err("[%d] Call on QBUF after unrecoverable error",
-				ctx->id);
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] Call on QBUF after unrecoverable error",
+			     ctx->id);
 		return -EIO;
 	}
 
@@ -724,7 +727,7 @@ static int vidioc_encoder_cmd(struct file *file, void *priv,
 	int ret;
 
 	if (ctx->state == MTK_STATE_ABORT) {
-		mtk_v4l2_err("[%d] Call to CMD after unrecoverable error",
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] Call to CMD after unrecoverable error",
 			     ctx->id);
 		return -EIO;
 	}
@@ -737,7 +740,7 @@ static int vidioc_encoder_cmd(struct file *file, void *priv,
 	if (ctx->is_flushing)
 		return -EBUSY;
 
-	mtk_v4l2_debug(1, "encoder cmd=%u", cmd->cmd);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1, "encoder cmd=%u", cmd->cmd);
 
 	dst_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
 				 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
@@ -746,11 +749,13 @@ static int vidioc_encoder_cmd(struct file *file, void *priv,
 		src_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
 					 V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 		if (!vb2_is_streaming(src_vq)) {
-			mtk_v4l2_debug(1, "Output stream is off. No need to flush.");
+			mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+				       "Output stream is off. No need to flush.");
 			return 0;
 		}
 		if (!vb2_is_streaming(dst_vq)) {
-			mtk_v4l2_debug(1, "Capture stream is off. No need to flush.");
+			mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+				       "Capture stream is off. No need to flush.");
 			return 0;
 		}
 		ctx->is_flushing = true;
@@ -841,9 +846,10 @@ static int vb2ops_venc_buf_prepare(struct vb2_buffer *vb)
 
 	for (i = 0; i < q_data->fmt->num_planes; i++) {
 		if (vb2_plane_size(vb, i) < q_data->sizeimage[i]) {
-			mtk_v4l2_err("data will not fit into plane %d (%lu < %d)",
-				i, vb2_plane_size(vb, i),
-				q_data->sizeimage[i]);
+			mtk_v4l2_err(ctx->dev->plat_dev,
+				     "data will not fit into plane %d (%lu < %d)",
+				     i, vb2_plane_size(vb, i),
+				     q_data->sizeimage[i]);
 			return -EINVAL;
 		}
 	}
@@ -863,10 +869,9 @@ static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
 
 	if ((vb->vb2_queue->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) &&
 	    (ctx->param_change != MTK_ENCODE_PARAM_NONE)) {
-		mtk_v4l2_debug(1, "[%d] Before id=%d encode parameter change %x",
-			       ctx->id,
-			       vb2_v4l2->vb2_buf.index,
-			       ctx->param_change);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+			       "[%d] Before id=%d encode parameter change %x", ctx->id,
+			       vb2_v4l2->vb2_buf.index, ctx->param_change);
 		mtk_buf->param_change = ctx->param_change;
 		mtk_buf->enc_params = ctx->enc_params;
 		ctx->param_change = MTK_ENCODE_PARAM_NONE;
@@ -901,14 +906,14 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	ret = pm_runtime_resume_and_get(&ctx->dev->plat_dev->dev);
 	if (ret < 0) {
-		mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "pm_runtime_resume_and_get fail %d", ret);
 		goto err_start_stream;
 	}
 
 	mtk_venc_set_param(ctx, &param);
 	ret = venc_if_set_param(ctx, VENC_SET_PARAM_ENC, &param);
 	if (ret) {
-		mtk_v4l2_err("venc_if_set_param failed=%d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_set_param failed=%d", ret);
 		ctx->state = MTK_STATE_ABORT;
 		goto err_set_param;
 	}
@@ -921,7 +926,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 					VENC_SET_PARAM_PREPEND_HEADER,
 					NULL);
 		if (ret) {
-			mtk_v4l2_err("venc_if_set_param failed=%d", ret);
+			mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_set_param failed=%d", ret);
 			ctx->state = MTK_STATE_ABORT;
 			goto err_set_param;
 		}
@@ -933,7 +938,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 err_set_param:
 	pm_ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
 	if (pm_ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", pm_ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "pm_runtime_put fail %d", pm_ret);
 
 err_start_stream:
 	for (i = 0; i < q->num_buffers; ++i) {
@@ -944,9 +949,9 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 		 * can be marked as done.
 		 */
 		if (buf && buf->state == VB2_BUF_STATE_ACTIVE) {
-			mtk_v4l2_debug(0, "[%d] id=%d, type=%d, %d -> VB2_BUF_STATE_QUEUED",
-					ctx->id, i, q->type,
-					(int)buf->state);
+			mtk_v4l2_debug(ctx->dev->plat_dev, 0,
+				       "[%d] id=%d, type=%d, %d -> VB2_BUF_STATE_QUEUED",
+				       ctx->id, i, q->type, (int)buf->state);
 			v4l2_m2m_buf_done(to_vb2_v4l2_buffer(buf),
 					  VB2_BUF_STATE_QUEUED);
 		}
@@ -961,7 +966,7 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	int ret;
 
-	mtk_v4l2_debug(2, "[%d]-> type=%d", ctx->id, q->type);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 2, "[%d]-> type=%d", ctx->id, q->type);
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		while ((dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx))) {
@@ -972,7 +977,7 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 		if (ctx->is_flushing) {
 			struct v4l2_m2m_buffer *b, *n;
 
-			mtk_v4l2_debug(1, "STREAMOFF called while flushing");
+			mtk_v4l2_debug(ctx->dev->plat_dev, 1, "STREAMOFF called while flushing");
 			/*
 			 * STREAMOFF could be called before the flush buffer is
 			 * dequeued. Check whether empty flush buf is still in
@@ -1006,7 +1011,7 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	     vb2_is_streaming(&ctx->m2m_ctx->out_q_ctx.q)) ||
 	    (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
 	     vb2_is_streaming(&ctx->m2m_ctx->cap_q_ctx.q))) {
-		mtk_v4l2_debug(1, "[%d]-> q type %d out=%d cap=%d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d]-> q type %d out=%d cap=%d",
 			       ctx->id, q->type,
 			       vb2_is_streaming(&ctx->m2m_ctx->out_q_ctx.q),
 			       vb2_is_streaming(&ctx->m2m_ctx->cap_q_ctx.q));
@@ -1016,11 +1021,11 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	/* Release the encoder if both streams are stopped. */
 	ret = venc_if_deinit(ctx);
 	if (ret)
-		mtk_v4l2_err("venc_if_deinit failed=%d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_deinit failed=%d", ret);
 
 	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
 	if (ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "pm_runtime_put fail %d", ret);
 
 	ctx->state = MTK_STATE_FREE;
 }
@@ -1054,7 +1059,7 @@ static int mtk_venc_encode_header(void *priv)
 
 	dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
 	if (!dst_buf) {
-		mtk_v4l2_debug(1, "No dst buffer");
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "No dst buffer");
 		return -EINVAL;
 	}
 
@@ -1062,12 +1067,10 @@ static int mtk_venc_encode_header(void *priv)
 	bs_buf.dma_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 	bs_buf.size = (size_t)dst_buf->vb2_buf.planes[0].length;
 
-	mtk_v4l2_debug(1,
-			"[%d] buf id=%d va=0x%p dma_addr=0x%llx size=%zu",
-			ctx->id,
-			dst_buf->vb2_buf.index, bs_buf.va,
-			(u64)bs_buf.dma_addr,
-			bs_buf.size);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+		       "[%d] buf id=%d va=0x%p dma_addr=0x%llx size=%zu",
+		       ctx->id, dst_buf->vb2_buf.index, bs_buf.va,
+		       (u64)bs_buf.dma_addr, bs_buf.size);
 
 	ret = venc_if_encode(ctx,
 			VENC_START_OPT_ENCODE_SEQUENCE_HEADER,
@@ -1077,7 +1080,7 @@ static int mtk_venc_encode_header(void *priv)
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
 		ctx->state = MTK_STATE_ABORT;
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
-		mtk_v4l2_err("venc_if_encode failed=%d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_encode failed=%d", ret);
 		return -EINVAL;
 	}
 	src_buf = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
@@ -1085,7 +1088,7 @@ static int mtk_venc_encode_header(void *priv)
 		dst_buf->vb2_buf.timestamp = src_buf->vb2_buf.timestamp;
 		dst_buf->timecode = src_buf->timecode;
 	} else {
-		mtk_v4l2_err("No timestamp for the header buffer.");
+		mtk_v4l2_err(ctx->dev->plat_dev, "No timestamp for the header buffer.");
 	}
 
 	ctx->state = MTK_STATE_HEADER;
@@ -1114,10 +1117,8 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 
 	if (mtk_buf->param_change & MTK_ENCODE_PARAM_BITRATE) {
 		enc_prm.bitrate = mtk_buf->enc_params.bitrate;
-		mtk_v4l2_debug(1, "[%d] id=%d, change param br=%d",
-				ctx->id,
-				vb2_v4l2->vb2_buf.index,
-				enc_prm.bitrate);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] id=%d, change param br=%d",
+			       ctx->id, vb2_v4l2->vb2_buf.index, enc_prm.bitrate);
 		ret |= venc_if_set_param(ctx,
 					 VENC_SET_PARAM_ADJUST_BITRATE,
 					 &enc_prm);
@@ -1125,27 +1126,23 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 	if (!ret && mtk_buf->param_change & MTK_ENCODE_PARAM_FRAMERATE) {
 		enc_prm.frm_rate = mtk_buf->enc_params.framerate_num /
 				   mtk_buf->enc_params.framerate_denom;
-		mtk_v4l2_debug(1, "[%d] id=%d, change param fr=%d",
-			       ctx->id,
-			       vb2_v4l2->vb2_buf.index,
-			       enc_prm.frm_rate);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] id=%d, change param fr=%d",
+			       ctx->id, vb2_v4l2->vb2_buf.index, enc_prm.frm_rate);
 		ret |= venc_if_set_param(ctx,
 					 VENC_SET_PARAM_ADJUST_FRAMERATE,
 					 &enc_prm);
 	}
 	if (!ret && mtk_buf->param_change & MTK_ENCODE_PARAM_GOP_SIZE) {
 		enc_prm.gop_size = mtk_buf->enc_params.gop_size;
-		mtk_v4l2_debug(1, "change param intra period=%d",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "change param intra period=%d",
 			       enc_prm.gop_size);
 		ret |= venc_if_set_param(ctx,
 					 VENC_SET_PARAM_GOP_SIZE,
 					 &enc_prm);
 	}
 	if (!ret && mtk_buf->param_change & MTK_ENCODE_PARAM_FORCE_INTRA) {
-		mtk_v4l2_debug(1, "[%d] id=%d, change param force I=%d",
-				ctx->id,
-				vb2_v4l2->vb2_buf.index,
-				mtk_buf->enc_params.force_intra);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 1, "[%d] id=%d, change param force I=%d",
+			       ctx->id, vb2_v4l2->vb2_buf.index, mtk_buf->enc_params.force_intra);
 		if (mtk_buf->enc_params.force_intra)
 			ret |= venc_if_set_param(ctx,
 						 VENC_SET_PARAM_FORCE_INTRA,
@@ -1156,8 +1153,8 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 
 	if (ret) {
 		ctx->state = MTK_STATE_ABORT;
-		mtk_v4l2_err("venc_if_set_param %d failed=%d",
-				mtk_buf->param_change, ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_set_param %d failed=%d",
+			     mtk_buf->param_change, ret);
 		return -1;
 	}
 
@@ -1218,14 +1215,14 @@ static void mtk_venc_worker(struct work_struct *work)
 	bs_buf.dma_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 	bs_buf.size = (size_t)dst_buf->vb2_buf.planes[0].length;
 
-	mtk_v4l2_debug(2,
-			"Framebuf PA=%llx Size=0x%zx;PA=0x%llx Size=0x%zx;PA=0x%llx Size=%zu",
-			(u64)frm_buf.fb_addr[0].dma_addr,
-			frm_buf.fb_addr[0].size,
-			(u64)frm_buf.fb_addr[1].dma_addr,
-			frm_buf.fb_addr[1].size,
-			(u64)frm_buf.fb_addr[2].dma_addr,
-			frm_buf.fb_addr[2].size);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 2,
+		       "Framebuf PA=%llx Size=0x%zx;PA=0x%llx Size=0x%zx;PA=0x%llx Size=%zu",
+		       (u64)frm_buf.fb_addr[0].dma_addr,
+		       frm_buf.fb_addr[0].size,
+		       (u64)frm_buf.fb_addr[1].dma_addr,
+		       frm_buf.fb_addr[1].size,
+		       (u64)frm_buf.fb_addr[2].dma_addr,
+		       frm_buf.fb_addr[2].size);
 
 	ret = venc_if_encode(ctx, VENC_START_OPT_ENCODE_FRAME,
 			     &frm_buf, &bs_buf, &enc_result);
@@ -1240,20 +1237,21 @@ static void mtk_venc_worker(struct work_struct *work)
 		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
-		mtk_v4l2_err("venc_if_encode failed=%d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_encode failed=%d", ret);
 	} else {
 		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_result.bs_size);
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
-		mtk_v4l2_debug(2, "venc_if_encode bs size=%d",
-				 enc_result.bs_size);
+		mtk_v4l2_debug(ctx->dev->plat_dev, 2, "venc_if_encode bs size=%d",
+			       enc_result.bs_size);
 	}
 
 	v4l2_m2m_job_finish(ctx->dev->m2m_dev_enc, ctx->m2m_ctx);
 
-	mtk_v4l2_debug(1, "<=== src_buf[%d] dst_buf[%d] venc_if_encode ret=%d Size=%u===>",
-			src_buf->vb2_buf.index, dst_buf->vb2_buf.index, ret,
-			enc_result.bs_size);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 1,
+		       "<=== src_buf[%d] dst_buf[%d] venc_if_encode ret=%d Size=%u===>",
+		       src_buf->vb2_buf.index, dst_buf->vb2_buf.index, ret,
+		       enc_result.bs_size);
 }
 
 static void m2mops_venc_device_run(void *priv)
@@ -1277,7 +1275,7 @@ static int m2mops_venc_job_ready(void *m2m_priv)
 	struct mtk_vcodec_ctx *ctx = m2m_priv;
 
 	if (ctx->state == MTK_STATE_ABORT || ctx->state == MTK_STATE_FREE) {
-		mtk_v4l2_debug(3, "[%d]Not ready: state=0x%x.",
+		mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]Not ready: state=0x%x.",
 			       ctx->id, ctx->state);
 		return 0;
 	}
@@ -1413,8 +1411,7 @@ int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 
 
 	if (handler->error) {
-		mtk_v4l2_err("Init control handler fail %d",
-				handler->error);
+		mtk_v4l2_err(ctx->dev->plat_dev, "Init control handler fail %d", handler->error);
 		return handler->error;
 	}
 
@@ -1482,7 +1479,7 @@ void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
 	int ret = venc_if_deinit(ctx);
 
 	if (ret)
-		mtk_v4l2_err("venc_if_deinit failed=%d", ret);
+		mtk_v4l2_err(ctx->dev->plat_dev, "venc_if_deinit failed=%d", ret);
 
 	ctx->state = MTK_STATE_FREE;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index a56652e476c2..83685db506ef 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -97,12 +97,11 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 
 	core_id = dev->venc_pdata->core_id;
 	if (core_id < 0 || core_id >= NUM_MAX_VCODEC_REG_BASE) {
-		mtk_v4l2_err("Invalid core id: %d, ctx id: %d",
-			     core_id, ctx->id);
+		mtk_v4l2_err(dev->plat_dev, "Invalid core id: %d, ctx id: %d", core_id, ctx->id);
 		return IRQ_HANDLED;
 	}
 
-	mtk_v4l2_debug(1, "id: %d, core id: %d", ctx->id, core_id);
+	mtk_v4l2_debug(dev->plat_dev, 1, "id: %d, core id: %d", ctx->id, core_id);
 
 	addr = dev->reg_base[core_id] + MTK_VENC_IRQ_ACK_OFFSET;
 
@@ -143,16 +142,14 @@ static int fops_vcodec_open(struct file *file)
 	ctx->type = MTK_INST_ENCODER;
 	ret = mtk_vcodec_enc_ctrls_setup(ctx);
 	if (ret) {
-		mtk_v4l2_err("Failed to setup controls() (%d)",
-				ret);
+		mtk_v4l2_err(dev->plat_dev, "Failed to setup controls() (%d)", ret);
 		goto err_ctrls_setup;
 	}
 	ctx->m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev_enc, ctx,
 					 &mtk_vcodec_enc_queue_init);
 	if (IS_ERR((__force void *)ctx->m2m_ctx)) {
 		ret = PTR_ERR((__force void *)ctx->m2m_ctx);
-		mtk_v4l2_err("Failed to v4l2_m2m_ctx_init() (%d)",
-				ret);
+		mtk_v4l2_err(dev->plat_dev, "Failed to v4l2_m2m_ctx_init() (%d)", ret);
 		goto err_m2m_ctx_init;
 	}
 	src_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
@@ -171,23 +168,23 @@ static int fops_vcodec_open(struct file *file)
 			 * Return 0 if downloading firmware successfully,
 			 * otherwise it is failed
 			 */
-			mtk_v4l2_err("vpu_load_firmware failed!");
+			mtk_v4l2_err(dev->plat_dev, "vpu_load_firmware failed!");
 			goto err_load_fw;
 		}
 
 		dev->enc_capability =
 			mtk_vcodec_fw_get_venc_capa(dev->fw_handler);
-		mtk_v4l2_debug(0, "encoder capability %x", dev->enc_capability);
+		mtk_v4l2_debug(dev->plat_dev, 0, "encoder capability %x", dev->enc_capability);
 	}
 
-	mtk_v4l2_debug(2, "Create instance [%d]@%p m2m_ctx=%p ",
-			ctx->id, ctx, ctx->m2m_ctx);
+	mtk_v4l2_debug(dev->plat_dev, 2, "Create instance [%d]@%p m2m_ctx=%p ",
+		       ctx->id, ctx, ctx->m2m_ctx);
 
 	list_add(&ctx->list, &dev->ctx_list);
 
 	mutex_unlock(&dev->dev_mutex);
-	mtk_v4l2_debug(0, "%s encoder [%d]", dev_name(&dev->plat_dev->dev),
-			ctx->id);
+	mtk_v4l2_debug(dev->plat_dev, 0, "%s encoder [%d]", dev_name(&dev->plat_dev->dev),
+		       ctx->id);
 	return ret;
 
 	/* Deinit when failure occurred */
@@ -209,7 +206,7 @@ static int fops_vcodec_release(struct file *file)
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(file->private_data);
 
-	mtk_v4l2_debug(1, "[%d] encoder", ctx->id);
+	mtk_v4l2_debug(dev->plat_dev, 1, "[%d] encoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
 
 	v4l2_m2m_ctx_release(ctx->m2m_ctx);
@@ -255,7 +252,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 					 &rproc_phandle)) {
 		fw_type = SCP;
 	} else {
-		mtk_v4l2_err("Could not get venc IPI device");
+		mtk_v4l2_err(dev->plat_dev, "Could not get venc IPI device");
 		return -ENODEV;
 	}
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
@@ -307,14 +304,14 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
 	if (ret) {
-		mtk_v4l2_err("v4l2_device_register err=%d", ret);
+		mtk_v4l2_err(dev->plat_dev, "v4l2_device_register err=%d", ret);
 		goto err_res;
 	}
 
 	/* allocate video device for encoder and register it */
 	vfd_enc = video_device_alloc();
 	if (!vfd_enc) {
-		mtk_v4l2_err("Failed to allocate video device");
+		mtk_v4l2_err(dev->plat_dev, "Failed to allocate video device");
 		ret = -ENOMEM;
 		goto err_enc_alloc;
 	}
@@ -335,7 +332,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	dev->m2m_dev_enc = v4l2_m2m_init(&mtk_venc_m2m_ops);
 	if (IS_ERR((__force void *)dev->m2m_dev_enc)) {
-		mtk_v4l2_err("Failed to init mem2mem enc device");
+		mtk_v4l2_err(dev->plat_dev, "Failed to init mem2mem enc device");
 		ret = PTR_ERR((__force void *)dev->m2m_dev_enc);
 		goto err_enc_mem_init;
 	}
@@ -345,19 +342,19 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 						WQ_MEM_RECLAIM |
 						WQ_FREEZABLE);
 	if (!dev->encode_workqueue) {
-		mtk_v4l2_err("Failed to create encode workqueue");
+		mtk_v4l2_err(dev->plat_dev, "Failed to create encode workqueue");
 		ret = -EINVAL;
 		goto err_event_workq;
 	}
 
 	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, -1);
 	if (ret) {
-		mtk_v4l2_err("Failed to register video device");
+		mtk_v4l2_err(dev->plat_dev, "Failed to register video device");
 		goto err_enc_reg;
 	}
 
 	mtk_vcodec_dbgfs_init(dev, true);
-	mtk_v4l2_debug(0, "encoder %d registered as /dev/video%d",
+	mtk_v4l2_debug(dev->plat_dev, 0, "encoder %d registered as /dev/video%d",
 		       dev->venc_pdata->core_id, vfd_enc->num);
 
 	return 0;
@@ -459,7 +456,7 @@ static void mtk_vcodec_enc_remove(struct platform_device *pdev)
 {
 	struct mtk_vcodec_dev *dev = platform_get_drvdata(pdev);
 
-	mtk_v4l2_debug_enter();
+	mtk_v4l2_debug_enter(pdev);
 	destroy_workqueue(dev->encode_workqueue);
 	if (dev->m2m_dev_enc)
 		v4l2_m2m_release(dev->m2m_dev_enc);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index 7055954eb2af..c63e60c5aaf7 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -35,7 +35,7 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
 		if (!enc_clk->clk_info)
 			return -ENOMEM;
 	} else {
-		mtk_v4l2_err("Failed to get venc clock count");
+		mtk_v4l2_err(mtkdev->plat_dev, "Failed to get venc clock count");
 		return -EINVAL;
 	}
 
@@ -44,14 +44,14 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
 		ret = of_property_read_string_index(pdev->dev.of_node,
 			"clock-names", i, &clk_info->clk_name);
 		if (ret) {
-			mtk_v4l2_err("venc failed to get clk name %d", i);
+			mtk_v4l2_err(mtkdev->plat_dev, "venc failed to get clk name %d", i);
 			return ret;
 		}
 		clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
 			clk_info->clk_name);
 		if (IS_ERR(clk_info->vcodec_clk)) {
-			mtk_v4l2_err("venc devm_clk_get (%d)%s fail", i,
-				clk_info->clk_name);
+			mtk_v4l2_err(mtkdev->plat_dev, "venc devm_clk_get (%d)%s fail", i,
+				     clk_info->clk_name);
 			return PTR_ERR(clk_info->vcodec_clk);
 		}
 	}
@@ -61,14 +61,15 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
+	struct platform_device *pdev = container_of(pm->dev, struct platform_device, dev);
 	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
 	int ret, i = 0;
 
 	for (i = 0; i < enc_clk->clk_num; i++) {
 		ret = clk_prepare_enable(enc_clk->clk_info[i].vcodec_clk);
 		if (ret) {
-			mtk_v4l2_err("venc clk_prepare_enable %d %s fail %d", i,
-				enc_clk->clk_info[i].clk_name, ret);
+			mtk_v4l2_err(pdev, "venc clk_prepare_enable %d %s fail %d", i,
+				     enc_clk->clk_info[i].clk_name, ret);
 			goto clkerr;
 		}
 	}
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
index be9159acacf8..540e3dd27384 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
@@ -8,13 +8,15 @@
 struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
 					   enum mtk_vcodec_fw_use fw_use)
 {
+	struct mtk_vcodec_dev *dev = priv;
+
 	switch (type) {
 	case VPU:
 		return mtk_vcodec_fw_vpu_init(priv, fw_use);
 	case SCP:
 		return mtk_vcodec_fw_scp_init(priv, fw_use);
 	default:
-		mtk_v4l2_err("invalid vcodec fw type");
+		mtk_v4l2_err(dev->plat_dev, "invalid vcodec fw type");
 		return ERR_PTR(-EINVAL);
 	}
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
index 9a2472442c6f..39f361da5412 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
@@ -63,7 +63,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use
 	plat_dev = dev->plat_dev;
 	scp = scp_get(plat_dev);
 	if (!scp) {
-		mtk_v4l2_err("could not get vdec scp handle");
+		mtk_v4l2_err(plat_dev, "could not get vdec scp handle");
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
index 46a028031133..a3656041c4ec 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
@@ -56,12 +56,12 @@ static void mtk_vcodec_vpu_reset_handler(void *priv)
 	struct mtk_vcodec_dev *dev = priv;
 	struct mtk_vcodec_ctx *ctx;
 
-	mtk_v4l2_err("Watchdog timeout!!");
+	mtk_v4l2_err(dev->plat_dev, "Watchdog timeout!!");
 
 	mutex_lock(&dev->dev_mutex);
 	list_for_each_entry(ctx, &dev->ctx_list, list) {
 		ctx->state = MTK_STATE_ABORT;
-		mtk_v4l2_debug(0, "[%d] Change to state MTK_STATE_ABORT",
+		mtk_v4l2_debug(dev->plat_dev, 0, "[%d] Change to state MTK_STATE_ABORT",
 			       ctx->id);
 	}
 	mutex_unlock(&dev->dev_mutex);
@@ -98,7 +98,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use
 	plat_dev = dev->plat_dev;
 	fw_pdev = vpu_get_plat_device(plat_dev);
 	if (!fw_pdev) {
-		mtk_v4l2_err("firmware device is not ready");
+		mtk_v4l2_err(plat_dev, "firmware device is not ready");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
index daa44f635727..9a44dfff51bf 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
@@ -33,12 +33,12 @@ int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_m
 
 	if (!ret) {
 		status = -1;	/* timeout */
-		mtk_v4l2_err("[%d] cmd=%d, type=%d, dec timeout=%ums (%d %d)",
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] cmd=%d, type=%d, dec timeout=%ums (%d %d)",
 			     ctx_id, command, ctx_type, timeout_ms,
 			     ctx_int_cond[hw_id], ctx_int_type[hw_id]);
 	} else if (-ERESTARTSYS == ret) {
 		status = -1;
-		mtk_v4l2_err("[%d] cmd=%d, type=%d, dec inter fail (%d %d)",
+		mtk_v4l2_err(ctx->dev->plat_dev, "[%d] cmd=%d, type=%d, dec inter fail (%d %d)",
 			     ctx_id, command, ctx_type,
 			     ctx_int_cond[hw_id], ctx_int_type[hw_id]);
 	}
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index 847e321f4fcc..a4345c25cc29 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -21,10 +21,11 @@ int mtk_v4l2_dbg_level;
 EXPORT_SYMBOL(mtk_v4l2_dbg_level);
 #endif
 
-void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_idx)
+void __iomem *mtk_vcodec_get_reg_addr(struct platform_device *pdev, void __iomem **reg_base,
+				      unsigned int reg_idx)
 {
 	if (reg_idx >= NUM_MAX_VCODEC_REG_BASE) {
-		mtk_v4l2_err("Invalid arguments, reg_idx=%d", reg_idx);
+		mtk_v4l2_err(pdev, "Invalid arguments, reg_idx=%d", reg_idx);
 		return NULL;
 	}
 	return reg_base[reg_idx];
@@ -39,15 +40,15 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 
 	mem->va = dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
-		mtk_v4l2_err("%s dma_alloc size=%ld failed!", dev_name(dev),
+		mtk_v4l2_err(ctx->dev->plat_dev, "%s dma_alloc size=%ld failed!", dev_name(dev),
 			     size);
 		return -ENOMEM;
 	}
 
-	mtk_v4l2_debug(3, "[%d]  - va      = %p", ctx->id, mem->va);
-	mtk_v4l2_debug(3, "[%d]  - dma     = 0x%lx", ctx->id,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]  - va      = %p", ctx->id, mem->va);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]  - dma     = 0x%lx", ctx->id,
 		       (unsigned long)mem->dma_addr);
-	mtk_v4l2_debug(3, "[%d]    size = 0x%lx", ctx->id, size);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]    size = 0x%lx", ctx->id, size);
 
 	return 0;
 }
@@ -60,15 +61,15 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	if (!mem->va) {
-		mtk_v4l2_err("%s dma_free size=%ld failed!", dev_name(dev),
+		mtk_v4l2_err(ctx->dev->plat_dev, "%s dma_free size=%ld failed!", dev_name(dev),
 			     size);
 		return;
 	}
 
-	mtk_v4l2_debug(3, "[%d]  - va      = %p", ctx->id, mem->va);
-	mtk_v4l2_debug(3, "[%d]  - dma     = 0x%lx", ctx->id,
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]  - va      = %p", ctx->id, mem->va);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]  - dma     = 0x%lx", ctx->id,
 		       (unsigned long)mem->dma_addr);
-	mtk_v4l2_debug(3, "[%d]    size = 0x%lx", ctx->id, size);
+	mtk_v4l2_debug(ctx->dev->plat_dev, 3, "[%d]    size = 0x%lx", ctx->id, size);
 
 	dma_free_coherent(dev, size, mem->va, mem->dma_addr);
 	mem->va = NULL;
@@ -80,7 +81,7 @@ EXPORT_SYMBOL(mtk_vcodec_mem_free);
 void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx)
 {
 	if (hw_idx >= MTK_VDEC_HW_MAX || hw_idx < 0 || !dev->subdev_dev[hw_idx]) {
-		mtk_v4l2_err("hw idx is out of range:%d", hw_idx);
+		mtk_v4l2_err(dev->plat_dev, "hw idx is out of range:%d", hw_idx);
 		return NULL;
 	}
 
@@ -98,7 +99,7 @@ void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
 	if (vdec_dev->vdec_pdata->is_subdev_supported) {
 		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
 		if (!subdev_dev) {
-			mtk_v4l2_err("Failed to get hw dev");
+			mtk_v4l2_err(ctx->dev->plat_dev, "Failed to get hw dev");
 			spin_unlock_irqrestore(&vdec_dev->irqlock, flags);
 			return;
 		}
@@ -121,7 +122,7 @@ struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
 	if (vdec_dev->vdec_pdata->is_subdev_supported) {
 		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
 		if (!subdev_dev) {
-			mtk_v4l2_err("Failed to get hw dev");
+			mtk_v4l2_err(vdec_dev->plat_dev, "Failed to get hw dev");
 			spin_unlock_irqrestore(&vdec_dev->irqlock, flags);
 			return NULL;
 		}
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index ddc12c3e2983..9809f7af6402 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -28,8 +28,8 @@ struct mtk_vcodec_dev;
 #undef pr_fmt
 #define pr_fmt(fmt) "%s(),%d: " fmt, __func__, __LINE__
 
-#define mtk_v4l2_err(fmt, args...)                \
-	pr_err("[MTK_V4L2][ERROR] " fmt "\n", ##args)
+#define mtk_v4l2_err(plat_dev, fmt, args...)                             \
+	dev_err(&(plat_dev)->dev, "[MTK_V4L2][ERROR] " fmt "\n", ##args)
 
 #define mtk_vcodec_err(plat_dev, inst_id, fmt, args...)                                 \
 	dev_err(&(plat_dev)->dev, "[MTK_VCODEC][ERROR][%d]: " fmt "\n", inst_id, ##args)
@@ -38,11 +38,11 @@ struct mtk_vcodec_dev;
 extern int mtk_v4l2_dbg_level;
 extern int mtk_vcodec_dbg;
 
-#define mtk_v4l2_debug(level, fmt, args...)				\
-	do {								\
-		if (mtk_v4l2_dbg_level >= level)			\
-			pr_debug("[MTK_V4L2] %s, %d: " fmt "\n",        \
-				 __func__, __LINE__, ##args);	        \
+#define mtk_v4l2_debug(plat_dev, level, fmt, args...)                             \
+	do {                                                                      \
+		if (mtk_v4l2_dbg_level >= (level))                                  \
+			dev_dbg(&(plat_dev)->dev, "[MTK_V4L2] %s, %d: " fmt "\n", \
+				 __func__, __LINE__, ##args);                     \
 	} while (0)
 
 #define mtk_vcodec_debug(plat_dev, inst_id, fmt, args...)                               \
@@ -52,19 +52,20 @@ extern int mtk_vcodec_dbg;
 				inst_id, __func__, __LINE__, ##args);                   \
 	} while (0)
 #else
-#define mtk_v4l2_debug(level, fmt, args...) pr_debug(fmt, ##args)
+#define mtk_v4l2_debug(plat_dev, level, fmt, args...) dev_dbg(&(plat_dev)->dev, fmt, ##args)
 
 #define mtk_vcodec_debug(plat_dev, inst_id, fmt, args...)			\
 	dev_dbg(&(plat_dev)->dev, "[MTK_VCODEC][%d]: " fmt "\n", inst_id, ##args)
 #endif
 
-#define mtk_v4l2_debug_enter()  mtk_v4l2_debug(3, "+")
-#define mtk_v4l2_debug_leave()  mtk_v4l2_debug(3, "-")
+#define mtk_v4l2_debug_enter(plat_dev)  mtk_v4l2_debug(plat_dev, 3, "+")
+#define mtk_v4l2_debug_leave(plat_dev)  mtk_v4l2_debug(plat_dev, 3, "-")
 
 #define mtk_vcodec_debug_enter(plat_dev, inst_id)  mtk_vcodec_debug(plat_dev, inst_id, "+")
 #define mtk_vcodec_debug_leave(plat_dev, inst_id)  mtk_vcodec_debug(plat_dev, inst_id, "-")
 
-void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_idx);
+void __iomem *mtk_vcodec_get_reg_addr(struct platform_device *pdev, void __iomem **reg_base,
+				      unsigned int reg_idx);
 int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
index 26885b935ed2..39606d685d2e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
@@ -855,21 +855,23 @@ static inline void vdec_av1_slice_clear_fb(struct vdec_av1_slice_frame_info *fra
 	memset((void *)frame_info, 0, sizeof(struct vdec_av1_slice_frame_info));
 }
 
-static void vdec_av1_slice_decrease_ref_count(struct vdec_av1_slice_slot *slots, int fb_idx)
+static void vdec_av1_slice_decrease_ref_count(struct platform_device *pdev,
+					      struct vdec_av1_slice_slot *slots, int fb_idx)
 {
 	struct vdec_av1_slice_frame_info *frame_info = slots->frame_info;
 
 	frame_info[fb_idx].ref_count--;
 	if (frame_info[fb_idx].ref_count < 0) {
 		frame_info[fb_idx].ref_count = 0;
-		mtk_v4l2_err("av1_error: %s() fb_idx %d decrease ref_count error\n",
+		mtk_v4l2_err(pdev, "av1_error: %s() fb_idx %d decrease ref_count error\n",
 			     __func__, fb_idx);
 	}
 
 	vdec_av1_slice_clear_fb(&frame_info[fb_idx]);
 }
 
-static void vdec_av1_slice_cleanup_slots(struct vdec_av1_slice_slot *slots,
+static void vdec_av1_slice_cleanup_slots(struct platform_device *pdev,
+					 struct vdec_av1_slice_slot *slots,
 					 struct vdec_av1_slice_frame *frame,
 					 struct v4l2_ctrl_av1_frame *ctrl_fh)
 {
@@ -894,7 +896,7 @@ static void vdec_av1_slice_cleanup_slots(struct vdec_av1_slice_slot *slots,
 		}
 
 		if (!ref_used)
-			vdec_av1_slice_decrease_ref_count(slots, slot_id);
+			vdec_av1_slice_decrease_ref_count(pdev, slots, slot_id);
 	}
 }
 
@@ -907,11 +909,12 @@ static void vdec_av1_slice_setup_slot(struct vdec_av1_slice_instance *instance,
 	int ref_id;
 
 	memcpy(&vsi->slots, &instance->slots, sizeof(instance->slots));
-	vdec_av1_slice_cleanup_slots(&vsi->slots, &vsi->frame, ctrl_fh);
+	vdec_av1_slice_cleanup_slots(instance->ctx->dev->plat_dev, &vsi->slots,
+				     &vsi->frame, ctrl_fh);
 	vsi->slot_id = vdec_av1_slice_get_new_slot(vsi);
 
 	if (vsi->slot_id == AV1_INVALID_IDX) {
-		mtk_v4l2_err("warning:av1 get invalid index slot\n");
+		mtk_v4l2_err(instance->ctx->dev->plat_dev, "warning:av1 get invalid index slot\n");
 		vsi->slot_id = 0;
 	}
 	cur_frame_info = &vsi->slots.frame_info[vsi->slot_id];
@@ -1484,7 +1487,8 @@ static unsigned char vdec_av1_slice_get_sign_bias(int a,
 	return result;
 }
 
-static void vdec_av1_slice_setup_ref(struct vdec_av1_slice_pfc *pfc,
+static void vdec_av1_slice_setup_ref(struct platform_device *pdev,
+				     struct vdec_av1_slice_pfc *pfc,
 				     struct v4l2_ctrl_av1_frame *ctrl_fh)
 {
 	struct vdec_av1_slice_vsi *vsi = &pfc->vsi;
@@ -1507,7 +1511,7 @@ static void vdec_av1_slice_setup_ref(struct vdec_av1_slice_pfc *pfc,
 		slot_id = frame->ref_frame_map[ref_idx];
 		frame_info = &slots->frame_info[slot_id];
 		if (slot_id == AV1_INVALID_IDX) {
-			mtk_v4l2_err("cannot match reference[%d] 0x%llx\n", i,
+			mtk_v4l2_err(pdev, "cannot match reference[%d] 0x%llx\n", i,
 				     ctrl_fh->reference_frame_ts[ref_idx]);
 			frame->order_hints[i] = 0;
 			frame->ref_frame_valid[i] = 0;
@@ -1576,7 +1580,7 @@ static int vdec_av1_slice_setup_pfc(struct vdec_av1_slice_instance *instance,
 
 	vdec_av1_slice_setup_state(vsi);
 	vdec_av1_slice_setup_slot(instance, vsi, ctrl_fh);
-	vdec_av1_slice_setup_ref(pfc, ctrl_fh);
+	vdec_av1_slice_setup_ref(instance->ctx->dev->plat_dev, pfc, ctrl_fh);
 	vdec_av1_slice_get_previous(vsi);
 
 	pfc->seq = instance->seq;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index e5dec0230659..3c91395a8d5c 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -190,7 +190,7 @@ static int alloc_mv_buf(struct vdec_h264_slice_inst *inst,
 	struct mtk_vcodec_mem *mem = NULL;
 	unsigned int buf_sz = mtk_vdec_h264_get_mv_buf_size(pic->buf_w, pic->buf_h);
 
-	mtk_v4l2_debug(3, "size = 0x%x", buf_sz);
+	mtk_v4l2_debug(inst->ctx->dev->plat_dev, 3, "size = 0x%x", buf_sz);
 	for (i = 0; i < H264_MAX_MV_NUM; i++) {
 		mem = &inst->mv_buf[i];
 		if (mem->va)
@@ -247,7 +247,7 @@ static void get_pic_info(struct vdec_h264_slice_inst *inst,
 		    ctx->last_decoded_picinfo.buf_h != ctx->picinfo.buf_h)
 			inst->vsi_ctx.dec.realloc_mv_buf = true;
 
-		mtk_v4l2_debug(1, "ResChg: (%d %d) : old(%d, %d) -> new(%d, %d)",
+		mtk_v4l2_debug(inst->ctx->dev->plat_dev, 1, "ResChg:(%d %d):old(%d,%d)->new(%d,%d)",
 			       inst->vsi_ctx.dec.resolution_changed,
 			       inst->vsi_ctx.dec.realloc_mv_buf,
 			       ctx->last_decoded_picinfo.pic_w,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index a7494d12e28d..ee6a69b0f148 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -295,7 +295,8 @@ static void vdec_h264_slice_fill_decode_reflist(struct vdec_h264_slice_inst *ins
 	mtk_vdec_h264_fill_dpb_info(inst->ctx, &slice_param->decode_params,
 				    slice_param->h264_dpb_info);
 
-	mtk_v4l2_debug(3, "cur poc = %d\n", dec_params->bottom_field_order_cnt);
+	mtk_v4l2_debug(inst->ctx->dev->plat_dev, 3, "cur poc = %d\n",
+		       dec_params->bottom_field_order_cnt);
 	/* Build the reference lists */
 	v4l2_h264_init_reflist_builder(&reflist_builder, dec_params, sps,
 				       inst->dpb);
@@ -315,7 +316,7 @@ static int vdec_h264_slice_alloc_mv_buf(struct vdec_h264_slice_inst *inst,
 	struct mtk_vcodec_mem *mem;
 	int i, err;
 
-	mtk_v4l2_debug(3, "size = 0x%x", buf_sz);
+	mtk_v4l2_debug(inst->ctx->dev->plat_dev, 3, "size = 0x%x", buf_sz);
 	for (i = 0; i < H264_MAX_MV_NUM; i++) {
 		mem = &inst->mv_buf[i];
 		if (mem->va)
@@ -374,7 +375,7 @@ static void vdec_h264_slice_get_pic_info(struct vdec_h264_slice_inst *inst)
 		    ctx->last_decoded_picinfo.buf_h != ctx->picinfo.buf_h)
 			inst->realloc_mv_buf = true;
 
-		mtk_v4l2_debug(1, "resChg: (%d %d) : old(%d, %d) -> new(%d, %d)",
+		mtk_v4l2_debug(inst->ctx->dev->plat_dev, 1, "resChg:(%d %d):old(%d,%d)->new(%d,%d)",
 			       inst->resolution_changed,
 			       inst->realloc_mv_buf,
 			       ctx->last_decoded_picinfo.pic_w,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
index 9d507db4645a..1a8f2a189ab3 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
@@ -649,7 +649,7 @@ static int vdec_hevc_slice_alloc_mv_buf(struct vdec_hevc_slice_inst *inst,
 	struct mtk_vcodec_mem *mem;
 	int i, err;
 
-	mtk_v4l2_debug(3, "allocate mv buffer size = 0x%x", buf_sz);
+	mtk_v4l2_debug(inst->ctx->dev->plat_dev, 3, "allocate mv buffer size = 0x%x", buf_sz);
 	for (i = 0; i < HEVC_MAX_MV_NUM; i++) {
 		mem = &inst->mv_buf[i];
 		if (mem->va)
@@ -708,7 +708,7 @@ static void vdec_hevc_slice_get_pic_info(struct vdec_hevc_slice_inst *inst)
 		    ctx->last_decoded_picinfo.buf_h != ctx->picinfo.buf_h)
 			inst->realloc_mv_buf = true;
 
-		mtk_v4l2_debug(1, "resChg: (%d %d) : old(%d, %d) -> new(%d, %d)",
+		mtk_v4l2_debug(inst->ctx->dev->plat_dev, 1, "resChg:(%d %d):old(%d,%d)->new(%d,%d)",
 			       inst->resolution_changed,
 			       inst->realloc_mv_buf,
 			       ctx->last_decoded_picinfo.pic_w,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index f43c64cb1e36..fba6b1289434 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -167,13 +167,20 @@ struct vdec_vp8_inst {
 
 static void get_hw_reg_base(struct vdec_vp8_inst *inst)
 {
-	inst->reg_base.top = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_TOP);
-	inst->reg_base.cm = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_CM);
-	inst->reg_base.hwd = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_HWD);
-	inst->reg_base.sys = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_SYS);
-	inst->reg_base.misc = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_MISC);
-	inst->reg_base.ld = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_LD);
-	inst->reg_base.hwb = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_HWB);
+	inst->reg_base.top = mtk_vcodec_get_reg_addr(inst->ctx->dev->plat_dev,
+						     inst->ctx->dev->reg_base, VDEC_TOP);
+	inst->reg_base.cm = mtk_vcodec_get_reg_addr(inst->ctx->dev->plat_dev,
+						    inst->ctx->dev->reg_base, VDEC_CM);
+	inst->reg_base.hwd = mtk_vcodec_get_reg_addr(inst->ctx->dev->plat_dev,
+						     inst->ctx->dev->reg_base, VDEC_HWD);
+	inst->reg_base.sys = mtk_vcodec_get_reg_addr(inst->ctx->dev->plat_dev,
+						     inst->ctx->dev->reg_base, VDEC_SYS);
+	inst->reg_base.misc = mtk_vcodec_get_reg_addr(inst->ctx->dev->plat_dev,
+						      inst->ctx->dev->reg_base, VDEC_MISC);
+	inst->reg_base.ld = mtk_vcodec_get_reg_addr(inst->ctx->dev->plat_dev,
+						    inst->ctx->dev->reg_base, VDEC_LD);
+	inst->reg_base.hwb = mtk_vcodec_get_reg_addr(inst->ctx->dev->plat_dev,
+						     inst->ctx->dev->reg_base, VDEC_HWB);
 }
 
 static void write_hw_segmentation_data(struct vdec_vp8_inst *inst)
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
index 06d393174cc2..ae93f68b8473 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
@@ -75,7 +75,7 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
 
 	if (bs) {
 		if ((bs->dma_addr & 63) != 0) {
-			mtk_v4l2_err("bs dma_addr should 64 byte align");
+			mtk_v4l2_err(ctx->dev->plat_dev, "bs dma_addr should 64 byte align");
 			return -EINVAL;
 		}
 	}
@@ -83,7 +83,8 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
 	if (fb) {
 		if (((fb->base_y.dma_addr & 511) != 0) ||
 		    ((fb->base_c.dma_addr & 511) != 0)) {
-			mtk_v4l2_err("frame buffer dma_addr should 512 byte align");
+			mtk_v4l2_err(ctx->dev->plat_dev,
+				     "frame buffer dma_addr should 512 byte align");
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index f555341ae708..36c17f1fb43a 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -77,7 +77,7 @@ int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf
 
 	head = vdec_get_buf_list(msg_ctx->hardware_index, buf);
 	if (!head) {
-		mtk_v4l2_err("fail to qbuf: %d", msg_ctx->hardware_index);
+		mtk_v4l2_err(buf->ctx->dev->plat_dev, "fail to qbuf: %d", msg_ctx->hardware_index);
 		return -EINVAL;
 	}
 
@@ -95,7 +95,7 @@ int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf
 		}
 	}
 
-	mtk_v4l2_debug(3, "enqueue buf type: %d addr: 0x%p num: %d",
+	mtk_v4l2_debug(buf->ctx->dev->plat_dev, 3, "enqueue buf type: %d addr: 0x%p num: %d",
 		       msg_ctx->hardware_index, buf, msg_ctx->ready_num);
 	spin_unlock(&msg_ctx->ready_lock);
 
@@ -123,8 +123,6 @@ struct vdec_lat_buf *vdec_msg_queue_dqbuf(struct vdec_msg_queue_ctx *msg_ctx)
 
 	spin_lock(&msg_ctx->ready_lock);
 	if (list_empty(&msg_ctx->ready_queue)) {
-		mtk_v4l2_debug(3, "queue is NULL, type:%d num: %d",
-			       msg_ctx->hardware_index, msg_ctx->ready_num);
 		spin_unlock(&msg_ctx->ready_lock);
 
 		if (msg_ctx->hardware_index == MTK_VDEC_CORE)
@@ -146,14 +144,14 @@ struct vdec_lat_buf *vdec_msg_queue_dqbuf(struct vdec_msg_queue_ctx *msg_ctx)
 	head = vdec_get_buf_list(msg_ctx->hardware_index, buf);
 	if (!head) {
 		spin_unlock(&msg_ctx->ready_lock);
-		mtk_v4l2_err("fail to dqbuf: %d", msg_ctx->hardware_index);
+		mtk_v4l2_err(buf->ctx->dev->plat_dev, "fail to dqbuf: %d", msg_ctx->hardware_index);
 		return NULL;
 	}
 	list_del(head);
 	vdec_msg_queue_dec(&buf->ctx->msg_queue, msg_ctx->hardware_index);
 
 	msg_ctx->ready_num--;
-	mtk_v4l2_debug(3, "dqueue buf type:%d addr: 0x%p num: %d",
+	mtk_v4l2_debug(buf->ctx->dev->plat_dev, 3, "dqueue buf type:%d addr: 0x%p num: %d",
 		       msg_ctx->hardware_index, buf, msg_ctx->ready_num);
 	spin_unlock(&msg_ctx->ready_lock);
 
@@ -164,7 +162,8 @@ void vdec_msg_queue_update_ube_rptr(struct vdec_msg_queue *msg_queue, uint64_t u
 {
 	spin_lock(&msg_queue->lat_ctx.ready_lock);
 	msg_queue->wdma_rptr_addr = ube_rptr;
-	mtk_v4l2_debug(3, "update ube rprt (0x%llx)", ube_rptr);
+	mtk_v4l2_debug(msg_queue->empty_lat_buf.ctx->dev->plat_dev, 3,
+		       "update ube rprt (0x%llx)", ube_rptr);
 	spin_unlock(&msg_queue->lat_ctx.ready_lock);
 }
 
@@ -172,7 +171,8 @@ void vdec_msg_queue_update_ube_wptr(struct vdec_msg_queue *msg_queue, uint64_t u
 {
 	spin_lock(&msg_queue->lat_ctx.ready_lock);
 	msg_queue->wdma_wptr_addr = ube_wptr;
-	mtk_v4l2_debug(3, "update ube wprt: (0x%llx 0x%llx) offset: 0x%llx",
+	mtk_v4l2_debug(msg_queue->empty_lat_buf.ctx->dev->plat_dev, 3,
+		       "update ube wprt: (0x%llx 0x%llx) offset: 0x%llx",
 		       msg_queue->wdma_rptr_addr, msg_queue->wdma_wptr_addr,
 		       ube_wptr);
 	spin_unlock(&msg_queue->lat_ctx.ready_lock);
@@ -181,7 +181,8 @@ void vdec_msg_queue_update_ube_wptr(struct vdec_msg_queue *msg_queue, uint64_t u
 bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 {
 	if (atomic_read(&msg_queue->lat_list_cnt) == NUM_BUFFER_COUNT) {
-		mtk_v4l2_debug(3, "wait buf full: list(%d %d) ready_num:%d status:%d",
+		mtk_v4l2_debug(msg_queue->empty_lat_buf.ctx->dev->plat_dev, 3,
+			       "wait buf full: list(%d %d) ready_num:%d status:%d",
 			       atomic_read(&msg_queue->lat_list_cnt),
 			       atomic_read(&msg_queue->core_list_cnt),
 			       msg_queue->lat_ctx.ready_num,
@@ -193,7 +194,8 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 	vdec_msg_queue_qbuf(&msg_queue->core_ctx, &msg_queue->empty_lat_buf);
 	wait_event(msg_queue->core_dec_done, msg_queue->flush_done);
 
-	mtk_v4l2_debug(3, "flush done => ready_num:%d status:%d list(%d %d)",
+	mtk_v4l2_debug(msg_queue->empty_lat_buf.ctx->dev->plat_dev, 3,
+		       "flush done => ready_num:%d status:%d list(%d %d)",
 		       msg_queue->lat_ctx.ready_num, msg_queue->status,
 		       atomic_read(&msg_queue->lat_list_cnt),
 		       atomic_read(&msg_queue->core_list_cnt));
@@ -305,7 +307,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 					     ctx->picinfo.buf_h);
 	err = mtk_vcodec_mem_alloc(ctx, &msg_queue->wdma_addr);
 	if (err) {
-		mtk_v4l2_err("failed to allocate wdma_addr buf");
+		mtk_v4l2_err(ctx->dev->plat_dev, "failed to allocate wdma_addr buf");
 		return -ENOMEM;
 	}
 	msg_queue->wdma_rptr_addr = msg_queue->wdma_addr.dma_addr;
@@ -321,14 +323,15 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 		lat_buf->wdma_err_addr.size = VDEC_ERR_MAP_SZ_AVC;
 		err = mtk_vcodec_mem_alloc(ctx, &lat_buf->wdma_err_addr);
 		if (err) {
-			mtk_v4l2_err("failed to allocate wdma_err_addr buf[%d]", i);
+			mtk_v4l2_err(ctx->dev->plat_dev,
+				     "failed to allocate wdma_err_addr buf[%d]", i);
 			goto mem_alloc_err;
 		}
 
 		lat_buf->slice_bc_addr.size = VDEC_LAT_SLICE_HEADER_SZ;
 		err = mtk_vcodec_mem_alloc(ctx, &lat_buf->slice_bc_addr);
 		if (err) {
-			mtk_v4l2_err("failed to allocate wdma_addr buf[%d]", i);
+			mtk_v4l2_err(ctx->dev->plat_dev, "failed to allocate wdma_addr buf[%d]", i);
 			goto mem_alloc_err;
 		}
 
@@ -336,14 +339,16 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 			lat_buf->rd_mv_addr.size = VDEC_RD_MV_BUFFER_SZ;
 			err = mtk_vcodec_mem_alloc(ctx, &lat_buf->rd_mv_addr);
 			if (err) {
-				mtk_v4l2_err("failed to allocate rd_mv_addr buf[%d]", i);
+				mtk_v4l2_err(ctx->dev->plat_dev,
+					     "failed to allocate rd_mv_addr buf[%d]", i);
 				return -ENOMEM;
 			}
 
 			lat_buf->tile_addr.size = VDEC_LAT_TILE_SZ;
 			err = mtk_vcodec_mem_alloc(ctx, &lat_buf->tile_addr);
 			if (err) {
-				mtk_v4l2_err("failed to allocate tile_addr buf[%d]", i);
+				mtk_v4l2_err(ctx->dev->plat_dev,
+					     "failed to allocate tile_addr buf[%d]", i);
 				return -ENOMEM;
 			}
 		}
@@ -359,7 +364,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 		lat_buf->is_last_frame = false;
 		err = vdec_msg_queue_qbuf(&msg_queue->lat_ctx, lat_buf);
 		if (err) {
-			mtk_v4l2_err("failed to qbuf buf[%d]", i);
+			mtk_v4l2_err(ctx->dev->plat_dev, "failed to qbuf buf[%d]", i);
 			goto mem_alloc_err;
 		}
 	}
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index 92a75bc34dde..e971f385723c 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -97,7 +97,8 @@ static void vpu_dec_ipi_handler(void *data, unsigned int len, void *priv)
 					(unsigned long)msg->ap_inst_addr;
 
 	if (!vpu) {
-		mtk_v4l2_err("ap_inst_addr is NULL, did the SCP hang or crash?");
+		mtk_v4l2_err(vpu->ctx->dev->plat_dev,
+			     "ap_inst_addr is NULL, did the SCP hang or crash?");
 		return;
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index a895ee7db069..fc3e021d24e8 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -620,7 +620,8 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
 	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
-	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
+	inst->hw_base = mtk_vcodec_get_reg_addr(ctx->dev->plat_dev, inst->ctx->dev->reg_base,
+						VENC_SYS);
 
 	mtk_vcodec_debug_enter(inst->ctx->dev->plat_dev, inst->ctx->id);
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index 37f06292d174..4e1c49093385 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -340,7 +340,8 @@ static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
 	inst->vpu_inst.id = IPI_VENC_VP8;
-	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_LT_SYS);
+	inst->hw_base = mtk_vcodec_get_reg_addr(ctx->dev->plat_dev, inst->ctx->dev->reg_base,
+						VENC_LT_SYS);
 
 	mtk_vcodec_debug_enter(inst->ctx->dev->plat_dev, inst->ctx->id);
 
-- 
2.18.0

