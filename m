Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3A7190E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjFADEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjFADDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:03:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C7EE70;
        Wed, 31 May 2023 20:03:13 -0700 (PDT)
X-UUID: d42cea2e002811ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yyUqk3K6NONW59xzShFxlN27d07VVWGgOH/DQmH1vz8=;
        b=krtkg49wx+3WPaF/R8dTKW8uBorrE0KHqA6q4n3Seatk72FEq0ow/fyWkmQvDEDFTI2pNh9u/gqGioVwRcLSrPYI9kAhSOQEKxyIYxBRpdfPtRjW6o9FysvYzabTwBaMPNvrPpegxjtiRDoLEshMfzFhs2bEizrCV6VOMmitVQk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:206bc3c3-78a6-42dd-a2f5-18ccc8be890c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:048fa76d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV:0
X-CID-BVR: 2,OSH|NGT
X-CID-BAS: 2,OSH|NGT,0,_
X-UUID: d42cea2e002811ee9cb5633481061a41-20230601
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1023176984; Thu, 01 Jun 2023 11:03:05 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 11:03:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 11:03:03 +0800
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
Subject: [PATCH 5/8] mediatek: vcodec: separate struct mtk_vcodec_ctx
Date:   Thu, 1 Jun 2023 11:02:53 +0800
Message-ID: <20230601030256.29875-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601030256.29875-1-yunfei.dong@mediatek.com>
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding different context struct for encoder and decoder, remove
'struct mtk_vcodec_ctx'.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_com_drv.h      |  76 +++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        |   6 +-
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |   8 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c |  60 ++--
 .../platform/mediatek/vcodec/mtk_vcodec_dec.h |  10 +-
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   8 +-
 .../mediatek/vcodec/mtk_vcodec_dec_drv.h      | 158 ++++++++++
 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       |   4 +-
 .../mediatek/vcodec/mtk_vcodec_dec_hw.h       |   2 +-
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       |   8 +-
 .../mediatek/vcodec/mtk_vcodec_dec_pm.h       |   4 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c |  28 +-
 .../vcodec/mtk_vcodec_dec_stateless.c         |  22 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 269 +-----------------
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c |  78 ++---
 .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  12 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  10 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.h      | 158 ++++++++++
 .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |  25 +-
 .../mediatek/vcodec/mtk_vcodec_intr.c         |  26 +-
 .../mediatek/vcodec/mtk_vcodec_intr.h         |   3 +-
 .../mediatek/vcodec/mtk_vcodec_util.c         |  54 +++-
 .../mediatek/vcodec/mtk_vcodec_util.h         |   8 +-
 .../vcodec/vdec/vdec_av1_req_lat_if.c         |  22 +-
 .../mediatek/vcodec/vdec/vdec_h264_if.c       |   6 +-
 .../vcodec/vdec/vdec_h264_req_common.c        |   4 +-
 .../vcodec/vdec/vdec_h264_req_common.h        |   4 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |   8 +-
 .../vcodec/vdec/vdec_h264_req_multi_if.c      |  10 +-
 .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  16 +-
 .../mediatek/vcodec/vdec/vdec_vp8_if.c        |   4 +-
 .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  10 +-
 .../mediatek/vcodec/vdec/vdec_vp9_if.c        |   8 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  18 +-
 .../platform/mediatek/vcodec/vdec_drv_base.h  |   2 +-
 .../platform/mediatek/vcodec/vdec_drv_if.c    |   8 +-
 .../platform/mediatek/vcodec/vdec_drv_if.h    |   8 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c |   8 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.h |   8 +-
 .../platform/mediatek/vcodec/vdec_vpu_if.h    |   4 +-
 .../mediatek/vcodec/venc/venc_h264_if.c       |  12 +-
 .../mediatek/vcodec/venc/venc_vp8_if.c        |   8 +-
 .../platform/mediatek/vcodec/venc_drv_base.h  |   2 +-
 .../platform/mediatek/vcodec/venc_drv_if.c    |  14 +-
 .../platform/mediatek/vcodec/venc_drv_if.h    |   8 +-
 .../platform/mediatek/vcodec/venc_vpu_if.h    |   2 +-
 46 files changed, 720 insertions(+), 511 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
new file mode 100644
index 000000000000..3b6e1faf60ce
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Yunfei Dong <yunfei.dong@mediatek.com>
+ */
+
+#ifndef _MTK_VCODEC_COM_DRV_H_
+#define _MTK_VCODEC_COM_DRV_H_
+
+#include <linux/platform_device.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/videobuf2-core.h>
+
+#define MTK_VCODEC_MAX_PLANES	3
+
+/**
+ * enum mtk_instance_state - The state of an MTK Vcodec instance.
+ * @MTK_STATE_FREE: default state when instance is created
+ * @MTK_STATE_INIT: vcodec instance is initialized
+ * @MTK_STATE_HEADER: vdec had sps/pps header parsed or venc
+ *			had sps/pps header encoded
+ * @MTK_STATE_FLUSH: vdec is flushing. Only used by decoder
+ * @MTK_STATE_ABORT: vcodec should be aborted
+ */
+enum mtk_instance_state {
+	MTK_STATE_FREE = 0,
+	MTK_STATE_INIT = 1,
+	MTK_STATE_HEADER = 2,
+	MTK_STATE_FLUSH = 3,
+	MTK_STATE_ABORT = 4,
+};
+
+enum mtk_fmt_type {
+	MTK_FMT_DEC = 0,
+	MTK_FMT_ENC = 1,
+	MTK_FMT_FRAME = 2,
+};
+
+/*
+ * struct mtk_video_fmt - Structure used to store information about pixelformats
+ */
+struct mtk_video_fmt {
+	u32	fourcc;
+	enum mtk_fmt_type	type;
+	u32	num_planes;
+	u32	flags;
+	struct v4l2_frmsize_stepwise frmsize;
+};
+
+/*
+ * struct mtk_q_data - Structure used to store information about queue
+ */
+struct mtk_q_data {
+	unsigned int	visible_width;
+	unsigned int	visible_height;
+	unsigned int	coded_width;
+	unsigned int	coded_height;
+	enum v4l2_field	field;
+	unsigned int	bytesperline[MTK_VCODEC_MAX_PLANES];
+	unsigned int	sizeimage[MTK_VCODEC_MAX_PLANES];
+	const struct mtk_video_fmt	*fmt;
+};
+
+/*
+ * enum mtk_instance_type - The type of an MTK Vcodec instance.
+ */
+enum mtk_instance_type {
+	MTK_INST_DECODER		= 0,
+	MTK_INST_ENCODER		= 1,
+};
+
+#endif /* _MTK_VCODEC_COM_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 2151c3967684..b88fc0a0c102 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -10,7 +10,7 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_util.h"
 
-static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_ctx *ctx, char *buf,
+static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_dec_ctx *ctx, char *buf,
 					   int *used, int total)
 {
 	int curr_len;
@@ -91,7 +91,7 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 	struct mtk_vcodec_dev *vcodec_dev = filp->private_data;
 	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int total_len = 200 * (dbgfs->inst_count == 0 ? 1 : dbgfs->inst_count);
 	int used_len = 0, curr_len, ret;
 	bool dbgfs_index[MTK_VDEC_DBGFS_MAX] = {0};
@@ -143,7 +143,7 @@ static const struct file_operations vdec_fops = {
 	.read = mtk_vdec_dbgfs_read,
 };
 
-void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
 	struct mtk_vcodec_dev *vcodec_dev = ctx->dev;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index 241ff8197e73..d4672d627e43 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -8,7 +8,7 @@
 #define __MTK_VCODEC_DBGFS_H__
 
 struct mtk_vcodec_dev;
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 
 /*
  * enum mtk_vdec_dbgfs_log_index  - used to get different debug information
@@ -27,7 +27,7 @@ enum mtk_vdec_dbgfs_log_index {
  */
 struct mtk_vcodec_dbgfs_inst {
 	struct list_head node;
-	struct mtk_vcodec_ctx *vcodec_ctx;
+	struct mtk_vcodec_dec_ctx *vcodec_ctx;
 	int inst_id;
 };
 
@@ -50,12 +50,12 @@ struct mtk_vcodec_dbgfs {
 };
 
 #if defined(CONFIG_DEBUG_FS)
-void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx);
 void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id);
 void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode);
 void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev);
 #else
-static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
+static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
 {
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 93fcea821001..b1e56564cf2c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -35,7 +35,7 @@ mtk_vdec_find_format(struct v4l2_format *f,
 	return NULL;
 }
 
-static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
+static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_dec_ctx *ctx, int format_index)
 {
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 	const struct mtk_video_fmt *fmt;
@@ -55,7 +55,7 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
 	return false;
 }
 
-static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_ctx *ctx,
+static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_dec_ctx *ctx,
 					      enum v4l2_buf_type type)
 {
 	if (V4L2_TYPE_IS_OUTPUT(type))
@@ -74,7 +74,7 @@ static int vidioc_try_decoder_cmd(struct file *file, void *priv,
 static int vidioc_decoder_cmd(struct file *file, void *priv,
 				struct v4l2_decoder_cmd *cmd)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct vb2_queue *src_vq, *dst_vq;
 	int ret;
 
@@ -112,23 +112,23 @@ static int vidioc_decoder_cmd(struct file *file, void *priv,
 	return 0;
 }
 
-void mtk_vdec_unlock(struct mtk_vcodec_ctx *ctx)
+void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx)
 {
 	mutex_unlock(&ctx->dev->dec_mutex[ctx->hw_id]);
 }
 
-void mtk_vdec_lock(struct mtk_vcodec_ctx *ctx)
+void mtk_vdec_lock(struct mtk_vcodec_dec_ctx *ctx)
 {
 	mutex_lock(&ctx->dev->dec_mutex[ctx->hw_id]);
 }
 
-void mtk_vcodec_dec_release(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_dec_release(struct mtk_vcodec_dec_ctx *ctx)
 {
 	vdec_if_deinit(ctx);
 	ctx->state = MTK_STATE_FREE;
 }
 
-void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_q_data *q_data;
 
@@ -169,7 +169,7 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
 static int vidioc_vdec_qbuf(struct file *file, void *priv,
 			    struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
 		mtk_v4l2_err("[%d] Call on QBUF after unrecoverable error",
@@ -183,7 +183,7 @@ static int vidioc_vdec_qbuf(struct file *file, void *priv,
 static int vidioc_vdec_dqbuf(struct file *file, void *priv,
 			     struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
 		mtk_v4l2_err("[%d] Call on DQBUF after unrecoverable error",
@@ -196,7 +196,7 @@ static int vidioc_vdec_dqbuf(struct file *file, void *priv,
 
 static int mtk_vcodec_dec_get_chip_name(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec"))
@@ -218,7 +218,7 @@ static int mtk_vcodec_dec_get_chip_name(void *priv)
 static int vidioc_vdec_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
 
@@ -231,7 +231,7 @@ static int vidioc_vdec_querycap(struct file *file, void *priv,
 static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 				     const struct v4l2_event_subscription *sub)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(fh);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(fh);
 
 	if (ctx->dev->vdec_pdata->uses_stateless_api)
 		return v4l2_ctrl_subscribe_event(fh, sub);
@@ -246,7 +246,7 @@ static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 	}
 }
 
-static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
+static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
 			  const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
@@ -315,7 +315,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 
 	fmt = mtk_vdec_find_format(f, dec_pdata);
@@ -333,7 +333,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 
 	fmt = mtk_vdec_find_format(f, dec_pdata);
@@ -354,7 +354,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 static int vidioc_vdec_g_selection(struct file *file, void *priv,
 			struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct mtk_q_data *q_data;
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
@@ -403,7 +403,7 @@ static int vidioc_vdec_g_selection(struct file *file, void *priv,
 static int vidioc_vdec_s_selection(struct file *file, void *priv,
 				struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
@@ -425,7 +425,7 @@ static int vidioc_vdec_s_selection(struct file *file, void *priv,
 static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct v4l2_pix_format_mplane *pix_mp;
 	struct mtk_q_data *q_data;
 	int ret = 0;
@@ -553,7 +553,7 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 				struct v4l2_frmsizeenum *fsize)
 {
 	int i = 0;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 
 	if (fsize->index != 0)
@@ -588,7 +588,7 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 static int vidioc_enum_fmt(struct v4l2_fmtdesc *f, void *priv,
 			   bool output_queue)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 	const struct mtk_video_fmt *fmt;
 	int i, j = 0;
@@ -634,7 +634,7 @@ static int vidioc_vdec_enum_fmt_vid_out(struct file *file, void *priv,
 static int vidioc_vdec_g_fmt(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data;
@@ -723,7 +723,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 			    unsigned int *nplanes, unsigned int sizes[],
 			    struct device *alloc_devs[])
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vq);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vq);
 	struct mtk_q_data *q_data;
 	unsigned int i;
 
@@ -766,7 +766,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 
 int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct mtk_q_data *q_data;
 	int i;
 
@@ -791,7 +791,7 @@ int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
 
 void vb2ops_vdec_buf_finish(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct mtk_video_dec_buf *buf;
 	bool buf_error;
@@ -829,7 +829,7 @@ int vb2ops_vdec_buf_init(struct vb2_buffer *vb)
 
 int vb2ops_vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(q);
 
 	if (ctx->state == MTK_STATE_FLUSH)
 		ctx->state = MTK_STATE_HEADER;
@@ -840,7 +840,7 @@ int vb2ops_vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 {
 	struct vb2_v4l2_buffer *src_buf = NULL, *dst_buf = NULL;
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(q);
 	int ret;
 
 	mtk_v4l2_debug(3, "[%d] (%d) state=(%x) ctx->decoded_frame_cnt=%d",
@@ -895,7 +895,7 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 
 static void m2mops_vdec_device_run(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
 	queue_work(dev->decode_workqueue, &ctx->decode_work);
@@ -903,7 +903,7 @@ static void m2mops_vdec_device_run(void *priv)
 
 static int m2mops_vdec_job_ready(void *m2m_priv)
 {
-	struct mtk_vcodec_ctx *ctx = m2m_priv;
+	struct mtk_vcodec_dec_ctx *ctx = m2m_priv;
 
 	mtk_v4l2_debug(3, "[%d]", ctx->id);
 
@@ -922,7 +922,7 @@ static int m2mops_vdec_job_ready(void *m2m_priv)
 
 static void m2mops_vdec_job_abort(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 
 	ctx->state = MTK_STATE_ABORT;
 }
@@ -970,7 +970,7 @@ const struct v4l2_ioctl_ops mtk_vdec_ioctl_ops = {
 int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 			   struct vb2_queue *dst_vq)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 	int ret = 0;
 
 	mtk_v4l2_debug(3, "[%d]", ctx->id);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
index 4572f92826f2..ece27c880e50 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
@@ -11,6 +11,8 @@
 #include <media/videobuf2-core.h>
 #include <media/v4l2-mem2mem.h>
 
+#include "mtk_vcodec_dec_drv.h"
+
 #define VCODEC_DEC_ALIGNED_64 64
 #define VCODEC_CAPABILITY_4K_DISABLED	0x10
 #define VCODEC_DEC_4K_CODED_WIDTH	4096U
@@ -78,12 +80,12 @@ extern const struct mtk_vcodec_dec_pdata mtk_vdec_single_core_pdata;
  * mtk_vdec_lock get decoder hw lock and set curr_ctx
  * to ctx instance that get lock
  */
-void mtk_vdec_unlock(struct mtk_vcodec_ctx *ctx);
-void mtk_vdec_lock(struct mtk_vcodec_ctx *ctx);
+void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx);
+void mtk_vdec_lock(struct mtk_vcodec_dec_ctx *ctx);
 int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 			   struct vb2_queue *dst_vq);
-void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx);
-void mtk_vcodec_dec_release(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_dec_ctx *ctx);
+void mtk_vcodec_dec_release(struct mtk_vcodec_dec_ctx *ctx);
 
 /*
  * VB2 ops
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 03721eda2769..0451e75b921f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -41,7 +41,7 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
 static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	u32 cg_status = 0;
 	unsigned int dec_done_status = 0;
 	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_MISC] +
@@ -69,7 +69,7 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 	writel((readl(vdec_misc_addr) & ~VDEC_IRQ_CLR),
 		dev->reg_base[VDEC_MISC] + VDEC_IRQ_CFG_REG);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
 
 	mtk_v4l2_debug(3,
 			"mtk_vcodec_dec_irq_handler :wake up ctx %d, dec_done_status=%x",
@@ -140,7 +140,7 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
 static int fops_vcodec_open(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	int ret = 0, i, hw_count;
 	struct vb2_queue *src_vq;
 
@@ -239,7 +239,7 @@ static int fops_vcodec_open(struct file *file)
 static int fops_vcodec_release(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(file->private_data);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(file->private_data);
 
 	mtk_v4l2_debug(0, "[%d] decoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
new file mode 100644
index 000000000000..94870b651919
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Yunfei Dong <yunfei.dong@mediatek.com>
+ */
+
+#ifndef _MTK_VCODEC_DEC_DRV_H_
+#define _MTK_VCODEC_DEC_DRV_H_
+
+#include "mtk_vcodec_com_drv.h"
+#include "mtk_vcodec_fw_priv.h"
+#include "vdec_msg_queue.h"
+
+/**
+ * struct vdec_pic_info  - picture size information
+ * @pic_w: picture width
+ * @pic_h: picture height
+ * @buf_w: picture buffer width (64 aligned up from pic_w)
+ * @buf_h: picture buffer heiht (64 aligned up from pic_h)
+ * @fb_sz: bitstream size of each plane
+ * E.g. suppose picture size is 176x144,
+ *      buffer size will be aligned to 176x160.
+ * @cap_fourcc: fourcc number(may changed when resolution change)
+ * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bit os.
+ */
+struct vdec_pic_info {
+	unsigned int pic_w;
+	unsigned int pic_h;
+	unsigned int buf_w;
+	unsigned int buf_h;
+	unsigned int fb_sz[VIDEO_MAX_PLANES];
+	unsigned int cap_fourcc;
+	unsigned int reserved;
+};
+
+/*
+ * enum mtk_vdec_hw_id - Hardware index used to separate
+ *                         different hardware
+ */
+enum mtk_vdec_hw_id {
+	MTK_VDEC_CORE,
+	MTK_VDEC_LAT0,
+	MTK_VDEC_LAT1,
+	MTK_VDEC_LAT_SOC,
+	MTK_VDEC_HW_MAX,
+};
+
+/**
+ * struct mtk_vcodec_dec_ctx - Context (instance) private data.
+ *
+ * @type: type of the instance - decoder or encoder
+ * @dev: pointer to the mtk_vcodec_dev of the device
+ * @list: link to ctx_list of mtk_vcodec_dev
+ *
+ * @fh: struct v4l2_fh
+ * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
+ * @q_data: store information of input and output queue
+ *	    of the context
+ * @id: index of the context that this structure describes
+ * @state: state of the context
+ *
+ * @dec_if: hooked decoder driver interface
+ * @drv_handle: driver handle for specific decode/encode instance
+ *
+ * @picinfo: store picture info after header parsing
+ * @dpb_size: store dpb count after header parsing
+ *
+ * @int_cond: variable used by the waitqueue
+ * @int_type: type of the last interrupt
+ * @queue: waitqueue that can be used to wait for this context to
+ *	   finish
+ * @irq_status: irq status
+ *
+ * @ctrl_hdl: handler for v4l2 framework
+ * @decode_work: worker for the decoding
+ * @last_decoded_picinfo: pic information get from latest decode
+ * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. Only
+ *		     to be used with encoder and stateful decoder.
+ * @is_flushing: set to true if flushing is in progress.
+ *
+ * @current_codec: current set input codec, in V4L2 pixel format
+ * @capture_fourcc: capture queue type in V4L2 pixel format
+ *
+ * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
+ * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
+ * @quantization: enum v4l2_quantization, colorspace quantization
+ * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
+ *
+ * @decoded_frame_cnt: number of decoded frames
+ * @lock: protect variables accessed by V4L2 threads and worker thread such as
+ *	  mtk_video_dec_buf.
+ * @hw_id: hardware index used to identify different hardware.
+ *
+ * @msg_queue: msg queue used to store lat buffer information.
+ */
+struct mtk_vcodec_dec_ctx {
+	enum mtk_instance_type type;
+	struct mtk_vcodec_dev *dev;
+	struct list_head list;
+
+	struct v4l2_fh fh;
+	struct v4l2_m2m_ctx *m2m_ctx;
+	struct mtk_q_data q_data[2];
+	int id;
+	enum mtk_instance_state state;
+
+	const struct vdec_common_if *dec_if;
+	void *drv_handle;
+
+	struct vdec_pic_info picinfo;
+	int dpb_size;
+
+	int int_cond[MTK_VDEC_HW_MAX];
+	int int_type[MTK_VDEC_HW_MAX];
+	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
+	unsigned int irq_status;
+
+	struct v4l2_ctrl_handler ctrl_hdl;
+	struct work_struct decode_work;
+	struct vdec_pic_info last_decoded_picinfo;
+	struct v4l2_m2m_buffer empty_flush_buf;
+	bool is_flushing;
+
+	u32 current_codec;
+	u32 capture_fourcc;
+
+	enum v4l2_colorspace colorspace;
+	enum v4l2_ycbcr_encoding ycbcr_enc;
+	enum v4l2_quantization quantization;
+	enum v4l2_xfer_func xfer_func;
+
+	int decoded_frame_cnt;
+	struct mutex lock;
+	int hw_id;
+
+	struct vdec_msg_queue msg_queue;
+};
+
+static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *fh)
+{
+	return container_of(fh, struct mtk_vcodec_dec_ctx, fh);
+}
+
+static inline struct mtk_vcodec_dec_ctx *ctrl_to_dec_ctx(struct v4l2_ctrl *ctrl)
+{
+	return container_of(ctrl->handler, struct mtk_vcodec_dec_ctx, ctrl_hdl);
+}
+
+/* Wake up context wait_queue */
+static inline void
+wake_up_dec_ctx(struct mtk_vcodec_dec_ctx *ctx, unsigned int reason, unsigned int hw_id)
+{
+	ctx->int_cond[hw_id] = 1;
+	ctx->int_type[hw_id] = reason;
+	wake_up_interruptible(&ctx->queue[hw_id]);
+}
+
+#endif /* _MTK_VCODEC_DEC_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index b753bf54ebd9..9b59aaee19ec 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -66,7 +66,7 @@ static int mtk_vdec_hw_prob_done(struct mtk_vcodec_dev *vdec_dev)
 static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 {
 	struct mtk_vdec_hw_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	u32 cg_status;
 	unsigned int dec_done_status;
 	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_HW_MISC] +
@@ -91,7 +91,7 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 	writel(dec_done_status | VDEC_IRQ_CFG, vdec_misc_addr);
 	writel(dec_done_status & ~VDEC_IRQ_CLR, vdec_misc_addr);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
+	wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
 
 	mtk_v4l2_debug(3, "wake up ctx %d, dec_done_status=%x",
 		       ctx->id, dec_done_status);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
index 36faa8d9d681..d62c7f961cfa 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
@@ -48,7 +48,7 @@ struct mtk_vdec_hw_dev {
 	struct mtk_vcodec_dev *main_dev;
 	void __iomem *reg_base[VDEC_HW_MAX];
 
-	struct mtk_vcodec_ctx *curr_ctx;
+	struct mtk_vcodec_dec_ctx *curr_ctx;
 
 	int dec_irq;
 	struct mtk_vcodec_pm pm;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 777d445999e9..113ca5f60f2b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -144,7 +144,7 @@ static void mtk_vcodec_dec_disable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_i
 	}
 }
 
-static void mtk_vcodec_load_racing_info(struct mtk_vcodec_ctx *ctx)
+static void mtk_vcodec_load_racing_info(struct mtk_vcodec_dec_ctx *ctx)
 {
 	void __iomem *vdec_racing_addr;
 	int j;
@@ -158,7 +158,7 @@ static void mtk_vcodec_load_racing_info(struct mtk_vcodec_ctx *ctx)
 	mutex_unlock(&ctx->dev->dec_racing_info_mutex);
 }
 
-static void mtk_vcodec_record_racing_info(struct mtk_vcodec_ctx *ctx)
+static void mtk_vcodec_record_racing_info(struct mtk_vcodec_dec_ctx *ctx)
 {
 	void __iomem *vdec_racing_addr;
 	int j;
@@ -232,7 +232,7 @@ static void mtk_vcodec_dec_child_dev_off(struct mtk_vcodec_dev *vdec_dev,
 	}
 }
 
-void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
+void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 {
 	mutex_lock(&ctx->dev->dec_mutex[hw_idx]);
 
@@ -248,7 +248,7 @@ void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dec_enable_hardware);
 
-void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
+void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 {
 	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
 		mtk_vcodec_record_racing_info(ctx);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
index dbcf3cabe6f3..f6c68e57bcc1 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
@@ -11,7 +11,7 @@
 
 int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *pm);
 
-void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx);
-void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx);
+void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
+void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
 
 #endif /* _MTK_VCODEC_DEC_PM_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 29991551cf61..9811118192ac 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -55,7 +55,7 @@ static const unsigned int num_supported_formats =
  * Note the buffers returned from codec driver may still be in driver's
  * reference list.
  */
-static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
+static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_fb *disp_frame_buffer = NULL;
 	struct mtk_video_dec_buf *dstbuf;
@@ -97,7 +97,7 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
  * previous sps/pps/resolution change decode, or do nothing if user
  * space still owns this buffer
  */
-static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
+static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_video_dec_buf *dstbuf;
 	struct vdec_fb *free_frame_buffer = NULL;
@@ -172,19 +172,19 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 	return &vb->vb2_buf;
 }
 
-static void clean_display_buffer(struct mtk_vcodec_ctx *ctx)
+static void clean_display_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	while (get_display_buffer(ctx))
 		;
 }
 
-static void clean_free_buffer(struct mtk_vcodec_ctx *ctx)
+static void clean_free_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	while (get_free_buffer(ctx))
 		;
 }
 
-static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_ctx *ctx)
+static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_dec_ctx *ctx)
 {
 	static const struct v4l2_event ev_src_ch = {
 		.type = V4L2_EVENT_SOURCE_CHANGE,
@@ -195,7 +195,7 @@ static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_ctx *ctx)
 	v4l2_event_queue_fh(&ctx->fh, &ev_src_ch);
 }
 
-static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
+static int mtk_vdec_flush_decoder(struct mtk_vcodec_dec_ctx *ctx)
 {
 	bool res_chg;
 	int ret;
@@ -210,7 +210,7 @@ static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
+static void mtk_vdec_update_fmt(struct mtk_vcodec_dec_ctx *ctx,
 				unsigned int pixelformat)
 {
 	const struct mtk_video_fmt *fmt;
@@ -231,7 +231,7 @@ static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
 	mtk_v4l2_err("Cannot get fourcc(%d), using init value", pixelformat);
 }
 
-static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
+static int mtk_vdec_pic_info_update(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int dpbsize = 0;
 	int ret;
@@ -275,8 +275,8 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
 
 static void mtk_vdec_worker(struct work_struct *work)
 {
-	struct mtk_vcodec_ctx *ctx =
-		container_of(work, struct mtk_vcodec_ctx, decode_work);
+	struct mtk_vcodec_dec_ctx *ctx =
+		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct mtk_vcodec_mem buf;
@@ -417,7 +417,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 	bool res_chg = false;
 	int ret;
 	unsigned int dpbsize = 1, i;
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct mtk_q_data *dst_q_data;
 
@@ -525,7 +525,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 
 static int mtk_vdec_g_v_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct mtk_vcodec_ctx *ctx = ctrl_to_ctx(ctrl);
+	struct mtk_vcodec_dec_ctx *ctx = ctrl_to_dec_ctx(ctrl);
 	int ret = 0;
 
 	switch (ctrl->id) {
@@ -547,7 +547,7 @@ static const struct v4l2_ctrl_ops mtk_vcodec_dec_ctrl_ops = {
 	.g_volatile_ctrl = mtk_vdec_g_v_ctrl,
 };
 
-static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
+static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct v4l2_ctrl *ctrl;
 
@@ -578,7 +578,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
+static void mtk_init_vdec_params(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int i;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index db1e14a1bd6c..998e962e5e85 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -218,7 +218,7 @@ static const struct v4l2_frmsize_stepwise stepwise_fhd = {
 	.step_height = 16
 };
 
-static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_ctx *ctx, int error,
+static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_dec_ctx *ctx, int error,
 					   struct media_request *src_buf_req)
 {
 	struct vb2_v4l2_buffer *vb2_dst;
@@ -242,7 +242,7 @@ static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_ctx *ctx, int error
 		v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);
 }
 
-static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx)
+static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_video_dec_buf *framebuf;
 	struct vb2_v4l2_buffer *vb2_v4l2;
@@ -278,15 +278,15 @@ static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx)
 
 static void vb2ops_vdec_buf_request_complete(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 
 	v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->ctrl_hdl);
 }
 
 static void mtk_vdec_worker(struct work_struct *work)
 {
-	struct mtk_vcodec_ctx *ctx =
-		container_of(work, struct mtk_vcodec_ctx, decode_work);
+	struct mtk_vcodec_dec_ctx *ctx =
+		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *vb2_v4l2_src;
 	struct vb2_buffer *vb2_src;
@@ -360,7 +360,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 
 static void vb2ops_vdec_stateless_buf_queue(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2 = to_vb2_v4l2_buffer(vb);
 
 	mtk_v4l2_debug(3, "[%d] (%d) id=%d, vb=%p", ctx->id, vb->vb2_queue->type, vb->index, vb);
@@ -380,14 +380,14 @@ static void vb2ops_vdec_stateless_buf_queue(struct vb2_buffer *vb)
 	}
 }
 
-static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
+static int mtk_vdec_flush_decoder(struct mtk_vcodec_dec_ctx *ctx)
 {
 	bool res_chg;
 
 	return vdec_if_decode(ctx, NULL, NULL, &res_chg);
 }
 
-static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
+static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int i;
 
@@ -438,7 +438,7 @@ const struct media_device_ops mtk_vcodec_media_ops = {
 };
 
 static void mtk_vcodec_add_formats(unsigned int fourcc,
-				   struct mtk_vcodec_ctx *ctx)
+				   struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	const struct mtk_vcodec_dec_pdata *pdata = dev->vdec_pdata;
@@ -479,7 +479,7 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 		       count_formats, ctx->dev->dec_capability);
 }
 
-static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_ctx *ctx)
+static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_dec_ctx *ctx)
 {
 	int cap_format_count = 0, out_format_count = 0;
 
@@ -522,7 +522,7 @@ static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_ctx *ctx)
 			mtk_video_formats[cap_format_count + out_format_count - 1];
 }
 
-static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
+static void mtk_init_vdec_params(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vb2_queue *src_vq;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index e3230a4d7b8e..76db7770d981 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -17,13 +17,14 @@
 #include <media/videobuf2-core.h>
 
 #include "mtk_vcodec_dbgfs.h"
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_util.h"
 #include "vdec_msg_queue.h"
 
 #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
 #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
 
-#define MTK_VCODEC_MAX_PLANES	3
 #define MTK_V4L2_BENCHMARK	0
 #define WAIT_INTR_TIMEOUT_MS	1000
 #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
@@ -53,60 +54,7 @@ enum mtk_hw_reg_idx {
 	NUM_MAX_VCODEC_REG_BASE
 };
 
-/*
- * enum mtk_instance_type - The type of an MTK Vcodec instance.
- */
-enum mtk_instance_type {
-	MTK_INST_DECODER		= 0,
-	MTK_INST_ENCODER		= 1,
-};
 
-/**
- * enum mtk_instance_state - The state of an MTK Vcodec instance.
- * @MTK_STATE_FREE: default state when instance is created
- * @MTK_STATE_INIT: vcodec instance is initialized
- * @MTK_STATE_HEADER: vdec had sps/pps header parsed or venc
- *			had sps/pps header encoded
- * @MTK_STATE_FLUSH: vdec is flushing. Only used by decoder
- * @MTK_STATE_ABORT: vcodec should be aborted
- */
-enum mtk_instance_state {
-	MTK_STATE_FREE = 0,
-	MTK_STATE_INIT = 1,
-	MTK_STATE_HEADER = 2,
-	MTK_STATE_FLUSH = 3,
-	MTK_STATE_ABORT = 4,
-};
-
-/*
- * enum mtk_encode_param - General encoding parameters type
- */
-enum mtk_encode_param {
-	MTK_ENCODE_PARAM_NONE = 0,
-	MTK_ENCODE_PARAM_BITRATE = (1 << 0),
-	MTK_ENCODE_PARAM_FRAMERATE = (1 << 1),
-	MTK_ENCODE_PARAM_INTRA_PERIOD = (1 << 2),
-	MTK_ENCODE_PARAM_FORCE_INTRA = (1 << 3),
-	MTK_ENCODE_PARAM_GOP_SIZE = (1 << 4),
-};
-
-enum mtk_fmt_type {
-	MTK_FMT_DEC = 0,
-	MTK_FMT_ENC = 1,
-	MTK_FMT_FRAME = 2,
-};
-
-/*
- * enum mtk_vdec_hw_id - Hardware index used to separate
- *                         different hardware
- */
-enum mtk_vdec_hw_id {
-	MTK_VDEC_CORE,
-	MTK_VDEC_LAT0,
-	MTK_VDEC_LAT1,
-	MTK_VDEC_LAT_SOC,
-	MTK_VDEC_HW_MAX,
-};
 
 /*
  * enum mtk_vdec_hw_count - Supported hardware count
@@ -118,17 +66,6 @@ enum mtk_vdec_hw_count {
 	MTK_VDEC_MAX_HW_COUNT,
 };
 
-/*
- * struct mtk_video_fmt - Structure used to store information about pixelformats
- */
-struct mtk_video_fmt {
-	u32	fourcc;
-	enum mtk_fmt_type	type;
-	u32	num_planes;
-	u32	flags;
-	struct v4l2_frmsize_stepwise frmsize;
-};
-
 /*
  * enum mtk_q_type - Type of queue
  */
@@ -137,54 +74,6 @@ enum mtk_q_type {
 	MTK_Q_DATA_DST = 1,
 };
 
-/*
- * struct mtk_q_data - Structure used to store information about queue
- */
-struct mtk_q_data {
-	unsigned int	visible_width;
-	unsigned int	visible_height;
-	unsigned int	coded_width;
-	unsigned int	coded_height;
-	enum v4l2_field	field;
-	unsigned int	bytesperline[MTK_VCODEC_MAX_PLANES];
-	unsigned int	sizeimage[MTK_VCODEC_MAX_PLANES];
-	const struct mtk_video_fmt	*fmt;
-};
-
-/**
- * struct mtk_enc_params - General encoding parameters
- * @bitrate: target bitrate in bits per second
- * @num_b_frame: number of b frames between p-frame
- * @rc_frame: frame based rate control
- * @rc_mb: macroblock based rate control
- * @seq_hdr_mode: H.264 sequence header is encoded separately or joined
- *		  with the first frame
- * @intra_period: I frame period
- * @gop_size: group of picture size, it's used as the intra frame period
- * @framerate_num: frame rate numerator. ex: framerate_num=30 and
- *		   framerate_denom=1 means FPS is 30
- * @framerate_denom: frame rate denominator. ex: framerate_num=30 and
- *		     framerate_denom=1 means FPS is 30
- * @h264_max_qp: Max value for H.264 quantization parameter
- * @h264_profile: V4L2 defined H.264 profile
- * @h264_level: V4L2 defined H.264 level
- * @force_intra: force/insert intra frame
- */
-struct mtk_enc_params {
-	unsigned int	bitrate;
-	unsigned int	num_b_frame;
-	unsigned int	rc_frame;
-	unsigned int	rc_mb;
-	unsigned int	seq_hdr_mode;
-	unsigned int	intra_period;
-	unsigned int	gop_size;
-	unsigned int	framerate_num;
-	unsigned int	framerate_denom;
-	unsigned int	h264_max_qp;
-	unsigned int	h264_profile;
-	unsigned int	h264_level;
-	unsigned int	force_intra;
-};
 
 /*
  * struct mtk_vcodec_clk_info - Structure used to store clock name
@@ -211,125 +100,6 @@ struct mtk_vcodec_pm {
 	struct device	*dev;
 };
 
-/**
- * struct vdec_pic_info  - picture size information
- * @pic_w: picture width
- * @pic_h: picture height
- * @buf_w: picture buffer width (64 aligned up from pic_w)
- * @buf_h: picture buffer heiht (64 aligned up from pic_h)
- * @fb_sz: bitstream size of each plane
- * E.g. suppose picture size is 176x144,
- *      buffer size will be aligned to 176x160.
- * @cap_fourcc: fourcc number(may changed when resolution change)
- * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bit os.
- */
-struct vdec_pic_info {
-	unsigned int pic_w;
-	unsigned int pic_h;
-	unsigned int buf_w;
-	unsigned int buf_h;
-	unsigned int fb_sz[VIDEO_MAX_PLANES];
-	unsigned int cap_fourcc;
-	unsigned int reserved;
-};
-
-/**
- * struct mtk_vcodec_ctx - Context (instance) private data.
- *
- * @type: type of the instance - decoder or encoder
- * @dev: pointer to the mtk_vcodec_dev of the device
- * @list: link to ctx_list of mtk_vcodec_dev
- * @fh: struct v4l2_fh
- * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
- * @q_data: store information of input and output queue
- *	    of the context
- * @id: index of the context that this structure describes
- * @state: state of the context
- * @param_change: indicate encode parameter type
- * @enc_params: encoding parameters
- * @dec_if: hooked decoder driver interface
- * @enc_if: hooked encoder driver interface
- * @drv_handle: driver handle for specific decode/encode instance
- *
- * @picinfo: store picture info after header parsing
- * @dpb_size: store dpb count after header parsing
- * @int_cond: variable used by the waitqueue
- * @int_type: type of the last interrupt
- * @queue: waitqueue that can be used to wait for this context to
- *	   finish
- * @irq_status: irq status
- *
- * @ctrl_hdl: handler for v4l2 framework
- * @decode_work: worker for the decoding
- * @encode_work: worker for the encoding
- * @last_decoded_picinfo: pic information get from latest decode
- * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. Only
- *		     to be used with encoder and stateful decoder.
- * @is_flushing: set to true if flushing is in progress.
- * @current_codec: current set input codec, in V4L2 pixel format
- * @capture_fourcc: capture queue type in V4L2 pixel format
- *
- * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
- * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
- * @quantization: enum v4l2_quantization, colorspace quantization
- * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
- * @decoded_frame_cnt: number of decoded frames
- * @lock: protect variables accessed by V4L2 threads and worker thread such as
- *	  mtk_video_dec_buf.
- * @hw_id: hardware index used to identify different hardware.
- *
- * @msg_queue: msg queue used to store lat buffer information.
- * @q_mutex: vb2_queue mutex.
- */
-struct mtk_vcodec_ctx {
-	enum mtk_instance_type type;
-	struct mtk_vcodec_dev *dev;
-	struct list_head list;
-
-	struct v4l2_fh fh;
-	struct v4l2_m2m_ctx *m2m_ctx;
-	struct mtk_q_data q_data[2];
-	int id;
-	enum mtk_instance_state state;
-	enum mtk_encode_param param_change;
-	struct mtk_enc_params enc_params;
-
-	const struct vdec_common_if *dec_if;
-	const struct venc_common_if *enc_if;
-	void *drv_handle;
-
-	struct vdec_pic_info picinfo;
-	int dpb_size;
-
-	int int_cond[MTK_VDEC_HW_MAX];
-	int int_type[MTK_VDEC_HW_MAX];
-	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
-	unsigned int irq_status;
-
-	struct v4l2_ctrl_handler ctrl_hdl;
-	struct work_struct decode_work;
-	struct work_struct encode_work;
-	struct vdec_pic_info last_decoded_picinfo;
-	struct v4l2_m2m_buffer empty_flush_buf;
-	bool is_flushing;
-
-	u32 current_codec;
-	u32 capture_fourcc;
-
-	enum v4l2_colorspace colorspace;
-	enum v4l2_ycbcr_encoding ycbcr_enc;
-	enum v4l2_quantization quantization;
-	enum v4l2_xfer_func xfer_func;
-
-	int decoded_frame_cnt;
-	struct mutex lock;
-	int hw_id;
-
-	struct vdec_msg_queue msg_queue;
-
-	struct mutex q_mutex;
-};
-
 /*
  * enum mtk_vdec_hw_arch - Used to separate different hardware architecture
  */
@@ -375,12 +145,12 @@ enum mtk_vdec_format_types {
  */
 
 struct mtk_vcodec_dec_pdata {
-	void (*init_vdec_params)(struct mtk_vcodec_ctx *ctx);
-	int (*ctrls_setup)(struct mtk_vcodec_ctx *ctx);
+	void (*init_vdec_params)(struct mtk_vcodec_dec_ctx *ctx);
+	int (*ctrls_setup)(struct mtk_vcodec_dec_ctx *ctx);
 	void (*worker)(struct work_struct *work);
-	int (*flush_decoder)(struct mtk_vcodec_ctx *ctx);
-	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_ctx *ctx);
-	void (*cap_to_disp)(struct mtk_vcodec_ctx *ctx, int error,
+	int (*flush_decoder)(struct mtk_vcodec_dec_ctx *ctx);
+	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_dec_ctx *ctx);
+	void (*cap_to_disp)(struct mtk_vcodec_dec_ctx *ctx, int error,
 			    struct media_request *src_buf_req);
 
 	struct vb2_ops *vdec_vb2_ops;
@@ -434,9 +204,10 @@ struct mtk_vcodec_enc_pdata {
  * @m2m_dev_dec: m2m device for decoder
  * @m2m_dev_enc: m2m device for encoder.
  * @plat_dev: platform device
- * @ctx_list: list of struct mtk_vcodec_ctx
+ * @ctx_list: list of struct mtk_vcodec_dec_ctx
  * @irqlock: protect data access by irq handler and work thread
  * @curr_ctx: The context that is waiting for codec hardware
+ * @curr_enc_ctx: The encoder context that is waiting for codec hardware
  *
  * @reg_base: Mapped address of MTK Vcodec registers.
  * @vdec_pdata: decoder IC-specific data
@@ -482,7 +253,8 @@ struct mtk_vcodec_dev {
 	struct platform_device *plat_dev;
 	struct list_head ctx_list;
 	spinlock_t irqlock;
-	struct mtk_vcodec_ctx *curr_ctx;
+	struct mtk_vcodec_dec_ctx *curr_ctx;
+	struct mtk_vcodec_enc_ctx *curr_enc_ctx;
 	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
 	const struct mtk_vcodec_dec_pdata *vdec_pdata;
 	const struct mtk_vcodec_enc_pdata *venc_pdata;
@@ -520,23 +292,4 @@ struct mtk_vcodec_dev {
 	struct mtk_vcodec_dbgfs dbgfs;
 };
 
-static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
-{
-	return container_of(fh, struct mtk_vcodec_ctx, fh);
-}
-
-static inline struct mtk_vcodec_ctx *ctrl_to_ctx(struct v4l2_ctrl *ctrl)
-{
-	return container_of(ctrl->handler, struct mtk_vcodec_ctx, ctrl_hdl);
-}
-
-/* Wake up context wait_queue */
-static inline void
-wake_up_ctx(struct mtk_vcodec_ctx *ctx, unsigned int reason, unsigned int hw_id)
-{
-	ctx->int_cond[hw_id] = 1;
-	ctx->int_type[hw_id] = reason;
-	wake_up_interruptible(&ctx->queue[hw_id]);
-}
-
 #endif /* _MTK_VCODEC_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index db65e77bd373..0da61adfd5ee 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -45,7 +45,7 @@ static const struct v4l2_frmsize_stepwise mtk_venc_4k_framesizes = {
 
 static int vidioc_venc_s_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct mtk_vcodec_ctx *ctx = ctrl_to_ctx(ctrl);
+	struct mtk_vcodec_enc_ctx *ctx = ctrl_to_enc_ctx(ctrl);
 	struct mtk_enc_params *p = &ctx->enc_params;
 	int ret = 0;
 
@@ -172,7 +172,7 @@ static int vidioc_enum_framesizes(struct file *file, void *fh,
 				  struct v4l2_frmsizeenum *fsize)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(fh);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(fh);
 
 	if (fsize->index != 0)
 		return -EINVAL;
@@ -196,7 +196,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 				   struct v4l2_fmtdesc *f)
 {
 	const struct mtk_vcodec_enc_pdata *pdata =
-		fh_to_ctx(priv)->dev->venc_pdata;
+		fh_to_enc_ctx(priv)->dev->venc_pdata;
 
 	return vidioc_enum_fmt(f, pdata->capture_formats,
 			       pdata->num_capture_formats);
@@ -206,7 +206,7 @@ static int vidioc_enum_fmt_vid_out(struct file *file, void *priv,
 				   struct v4l2_fmtdesc *f)
 {
 	const struct mtk_vcodec_enc_pdata *pdata =
-		fh_to_ctx(priv)->dev->venc_pdata;
+		fh_to_enc_ctx(priv)->dev->venc_pdata;
 
 	return vidioc_enum_fmt(f, pdata->output_formats,
 			       pdata->num_output_formats);
@@ -214,7 +214,7 @@ static int vidioc_enum_fmt_vid_out(struct file *file, void *priv,
 
 static int mtk_vcodec_enc_get_chip_name(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-enc"))
@@ -234,7 +234,7 @@ static int mtk_vcodec_enc_get_chip_name(void *priv)
 static int vidioc_venc_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_enc_get_chip_name(priv);
 
@@ -247,7 +247,7 @@ static int vidioc_venc_querycap(struct file *file, void *priv,
 static int vidioc_venc_s_parm(struct file *file, void *priv,
 			      struct v4l2_streamparm *a)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct v4l2_fract *timeperframe = &a->parm.output.timeperframe;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
@@ -270,7 +270,7 @@ static int vidioc_venc_s_parm(struct file *file, void *priv,
 static int vidioc_venc_g_parm(struct file *file, void *priv,
 			      struct v4l2_streamparm *a)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -EINVAL;
@@ -284,7 +284,7 @@ static int vidioc_venc_g_parm(struct file *file, void *priv,
 	return 0;
 }
 
-static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_ctx *ctx,
+static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_enc_ctx *ctx,
 					      enum v4l2_buf_type type)
 {
 	if (V4L2_TYPE_IS_OUTPUT(type))
@@ -304,7 +304,7 @@ static void vidioc_try_fmt_cap(struct v4l2_format *f)
 /* V4L2 specification suggests the driver corrects the format struct if any of
  * the dimensions is unsupported
  */
-static int vidioc_try_fmt_out(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
+static int vidioc_try_fmt_out(struct mtk_vcodec_enc_ctx *ctx, struct v4l2_format *f,
 			      const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
@@ -376,8 +376,8 @@ static int vidioc_try_fmt_out(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 	return 0;
 }
 
-static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
-				struct venc_enc_param *param)
+static void mtk_venc_set_param(struct mtk_vcodec_enc_ctx *ctx,
+			       struct venc_enc_param *param)
 {
 	struct mtk_q_data *q_data_src = &ctx->q_data[MTK_Q_DATA_SRC];
 	struct mtk_enc_params *enc_params = &ctx->enc_params;
@@ -426,7 +426,7 @@ static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
 static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
@@ -481,7 +481,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
@@ -536,7 +536,7 @@ static int vidioc_venc_g_fmt(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
 	int i;
@@ -569,7 +569,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 					 struct v4l2_format *f)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
 	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
@@ -591,7 +591,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 					 struct v4l2_format *f)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
 	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
@@ -612,7 +612,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 static int vidioc_venc_g_selection(struct file *file, void *priv,
 				     struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, s->type);
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
@@ -642,7 +642,7 @@ static int vidioc_venc_g_selection(struct file *file, void *priv,
 static int vidioc_venc_s_selection(struct file *file, void *priv,
 				     struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, s->type);
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
@@ -667,7 +667,7 @@ static int vidioc_venc_s_selection(struct file *file, void *priv,
 static int vidioc_venc_qbuf(struct file *file, void *priv,
 			    struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
 		mtk_v4l2_err("[%d] Call on QBUF after unrecoverable error",
@@ -681,7 +681,7 @@ static int vidioc_venc_qbuf(struct file *file, void *priv,
 static int vidioc_venc_dqbuf(struct file *file, void *priv,
 			     struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	int ret;
 
 	if (ctx->state == MTK_STATE_ABORT) {
@@ -719,7 +719,7 @@ static int vidioc_venc_dqbuf(struct file *file, void *priv,
 static int vidioc_encoder_cmd(struct file *file, void *priv,
 			      struct v4l2_encoder_cmd *cmd)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct vb2_queue *src_vq, *dst_vq;
 	int ret;
 
@@ -813,7 +813,7 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 				   unsigned int sizes[],
 				   struct device *alloc_devs[])
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vq);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(vq);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, vq->type);
 	unsigned int i;
 
@@ -835,7 +835,7 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 
 static int vb2ops_venc_buf_prepare(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, vb->vb2_queue->type);
 	int i;
 
@@ -853,7 +853,7 @@ static int vb2ops_venc_buf_prepare(struct vb2_buffer *vb)
 
 static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2 =
 			container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
 
@@ -877,7 +877,7 @@ static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
 
 static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
 	int ret, pm_ret;
 	int i;
@@ -957,7 +957,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(q);
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	int ret;
 
@@ -1046,7 +1046,7 @@ static const struct vb2_ops mtk_venc_vb2_ops = {
 
 static int mtk_venc_encode_header(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 	int ret;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct mtk_vcodec_mem bs_buf;
@@ -1095,7 +1095,7 @@ static int mtk_venc_encode_header(void *priv)
 	return 0;
 }
 
-static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
+static int mtk_venc_param_change(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct venc_enc_param enc_prm;
 	struct vb2_v4l2_buffer *vb2_v4l2 = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
@@ -1174,7 +1174,7 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
  */
 static void mtk_venc_worker(struct work_struct *work)
 {
-	struct mtk_vcodec_ctx *ctx = container_of(work, struct mtk_vcodec_ctx,
+	struct mtk_vcodec_enc_ctx *ctx = container_of(work, struct mtk_vcodec_enc_ctx,
 				    encode_work);
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct venc_frm_buf frm_buf;
@@ -1258,7 +1258,7 @@ static void mtk_venc_worker(struct work_struct *work)
 
 static void m2mops_venc_device_run(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 
 	if ((ctx->q_data[MTK_Q_DATA_DST].fmt->fourcc == V4L2_PIX_FMT_H264) &&
 	    (ctx->state != MTK_STATE_HEADER)) {
@@ -1274,7 +1274,7 @@ static void m2mops_venc_device_run(void *priv)
 
 static int m2mops_venc_job_ready(void *m2m_priv)
 {
-	struct mtk_vcodec_ctx *ctx = m2m_priv;
+	struct mtk_vcodec_enc_ctx *ctx = m2m_priv;
 
 	if (ctx->state == MTK_STATE_ABORT || ctx->state == MTK_STATE_FREE) {
 		mtk_v4l2_debug(3, "[%d]Not ready: state=0x%x.",
@@ -1287,7 +1287,7 @@ static int m2mops_venc_job_ready(void *m2m_priv)
 
 static void m2mops_venc_job_abort(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 
 	ctx->state = MTK_STATE_ABORT;
 }
@@ -1298,7 +1298,7 @@ const struct v4l2_m2m_ops mtk_venc_m2m_ops = {
 	.job_abort	= m2mops_venc_job_abort,
 };
 
-void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct mtk_q_data *q_data;
 
@@ -1359,7 +1359,7 @@ void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
 	ctx->enc_params.framerate_denom = MTK_DEFAULT_FRAMERATE_DENOM;
 }
 
-int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
+int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_enc_ctx *ctx)
 {
 	const struct v4l2_ctrl_ops *ops = &mtk_vcodec_enc_ctrl_ops;
 	struct v4l2_ctrl_handler *handler = &ctx->ctrl_hdl;
@@ -1426,7 +1426,7 @@ int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 			      struct vb2_queue *dst_vq)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 	int ret;
 
 	/* Note: VB2_USERPTR works with dma-contig because mt8173
@@ -1461,7 +1461,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	return vb2_queue_init(dst_vq);
 }
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
@@ -1469,7 +1469,7 @@ int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_lock(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
@@ -1477,7 +1477,7 @@ int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_enc_release(struct mtk_vcodec_enc_ctx *ctx)
 {
 	int ret = venc_if_deinit(ctx);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
index 513ee7993e34..82246401ed4a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
@@ -11,6 +11,8 @@
 #include <media/videobuf2-core.h>
 #include <media/v4l2-mem2mem.h>
 
+#include "mtk_vcodec_enc_drv.h"
+
 #define MTK_VENC_IRQ_STATUS_SPS	0x1
 #define MTK_VENC_IRQ_STATUS_PPS	0x2
 #define MTK_VENC_IRQ_STATUS_FRM	0x4
@@ -39,12 +41,12 @@ struct mtk_video_enc_buf {
 extern const struct v4l2_ioctl_ops mtk_venc_ioctl_ops;
 extern const struct v4l2_m2m_ops mtk_venc_m2m_ops;
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx);
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx);
+int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx);
+int mtk_venc_lock(struct mtk_vcodec_enc_ctx *ctx);
 int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 			      struct vb2_queue *dst_vq);
-void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
-int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx);
-void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_enc_release(struct mtk_vcodec_enc_ctx *ctx);
+int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_enc_ctx *ctx);
+void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_enc_ctx *ctx);
 
 #endif /* _MTK_VCODEC_ENC_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index a56652e476c2..a5b4b654cc5b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -86,13 +86,13 @@ static void clean_irq_status(unsigned int irq_status, void __iomem *addr)
 static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
 	int core_id;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
-	ctx = dev->curr_ctx;
+	ctx = dev->curr_enc_ctx;
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
 	core_id = dev->venc_pdata->core_id;
@@ -111,14 +111,14 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 
 	clean_irq_status(ctx->irq_status, addr);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	wake_up_enc_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
 	return IRQ_HANDLED;
 }
 
 static int fops_vcodec_open(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_enc_ctx *ctx = NULL;
 	int ret = 0;
 	struct vb2_queue *src_vq;
 
@@ -207,7 +207,7 @@ static int fops_vcodec_open(struct file *file)
 static int fops_vcodec_release(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(file->private_data);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(file->private_data);
 
 	mtk_v4l2_debug(1, "[%d] encoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
new file mode 100644
index 000000000000..6aa4afe5b796
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Yunfei Dong <yunfei.dong@mediatek.com>
+ */
+
+#ifndef _MTK_VCODEC_ENC_DRV_H_
+#define _MTK_VCODEC_ENC_DRV_H_
+
+#include "mtk_vcodec_com_drv.h"
+#include "mtk_vcodec_fw_priv.h"
+
+/*
+ * enum mtk_encode_param - General encoding parameters type
+ */
+enum mtk_encode_param {
+	MTK_ENCODE_PARAM_NONE = 0,
+	MTK_ENCODE_PARAM_BITRATE = (1 << 0),
+	MTK_ENCODE_PARAM_FRAMERATE = (1 << 1),
+	MTK_ENCODE_PARAM_INTRA_PERIOD = (1 << 2),
+	MTK_ENCODE_PARAM_FORCE_INTRA = (1 << 3),
+	MTK_ENCODE_PARAM_GOP_SIZE = (1 << 4),
+};
+
+/**
+ * struct mtk_enc_params - General encoding parameters
+ * @bitrate: target bitrate in bits per second
+ * @num_b_frame: number of b frames between p-frame
+ * @rc_frame: frame based rate control
+ * @rc_mb: macroblock based rate control
+ * @seq_hdr_mode: H.264 sequence header is encoded separately or joined
+ *		  with the first frame
+ * @intra_period: I frame period
+ * @gop_size: group of picture size, it's used as the intra frame period
+ * @framerate_num: frame rate numerator. ex: framerate_num=30 and
+ *		   framerate_denom=1 means FPS is 30
+ * @framerate_denom: frame rate denominator. ex: framerate_num=30 and
+ *		     framerate_denom=1 means FPS is 30
+ * @h264_max_qp: Max value for H.264 quantization parameter
+ * @h264_profile: V4L2 defined H.264 profile
+ * @h264_level: V4L2 defined H.264 level
+ * @force_intra: force/insert intra frame
+ */
+struct mtk_enc_params {
+	unsigned int	bitrate;
+	unsigned int	num_b_frame;
+	unsigned int	rc_frame;
+	unsigned int	rc_mb;
+	unsigned int	seq_hdr_mode;
+	unsigned int	intra_period;
+	unsigned int	gop_size;
+	unsigned int	framerate_num;
+	unsigned int	framerate_denom;
+	unsigned int	h264_max_qp;
+	unsigned int	h264_profile;
+	unsigned int	h264_level;
+	unsigned int	force_intra;
+};
+
+/**
+ * struct mtk_vcodec_enc_ctx - Context (instance) private data.
+ *
+ * @type: type of the instance - decoder or encoder
+ * @dev: pointer to the mtk_vcodec_dev of the device
+ * @list: link to ctx_list of mtk_vcodec_dev
+ *
+ * @fh: struct v4l2_fh
+ * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
+ * @q_data: store information of input and output queue
+ *	    of the context
+ * @id: index of the context that this structure describes
+ * @state: state of the context
+ * @param_change: indicate encode parameter type
+ * @enc_params: encoding parameters
+ *
+ * @enc_if: hooked encoder driver interface
+ * @drv_handle: driver handle for specific decode/encode instance
+ *
+ * @int_cond: variable used by the waitqueue
+ * @int_type: type of the last interrupt
+ * @queue: waitqueue that can be used to wait for this context to
+ *	   finish
+ * @irq_status: irq status
+ *
+ * @ctrl_hdl: handler for v4l2 framework
+ * @encode_work: worker for the encoding
+ * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. Only
+ *		     to be used with encoder and stateful decoder.
+ * @is_flushing: set to true if flushing is in progress.
+ *
+ * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
+ * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
+ * @quantization: enum v4l2_quantization, colorspace quantization
+ * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
+ *
+ * @lock: protect variables accessed by V4L2 threads and worker thread such as
+ *	  mtk_video_dec_buf.
+ * @hw_id: hardware index used to identify different hardware.
+ *
+ * @q_mutex: vb2_queue mutex.
+ */
+struct mtk_vcodec_enc_ctx {
+	enum mtk_instance_type type;
+	struct mtk_vcodec_dev *dev;
+	struct list_head list;
+
+	struct v4l2_fh fh;
+	struct v4l2_m2m_ctx *m2m_ctx;
+	struct mtk_q_data q_data[2];
+	int id;
+	enum mtk_instance_state state;
+	enum mtk_encode_param param_change;
+	struct mtk_enc_params enc_params;
+
+	const struct venc_common_if *enc_if;
+	void *drv_handle;
+
+	int int_cond[MTK_VDEC_HW_MAX];
+	int int_type[MTK_VDEC_HW_MAX];
+	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
+	unsigned int irq_status;
+
+	struct v4l2_ctrl_handler ctrl_hdl;
+	struct work_struct encode_work;
+	struct v4l2_m2m_buffer empty_flush_buf;
+	bool is_flushing;
+
+	enum v4l2_colorspace colorspace;
+	enum v4l2_ycbcr_encoding ycbcr_enc;
+	enum v4l2_quantization quantization;
+	enum v4l2_xfer_func xfer_func;
+
+	struct mutex lock;
+	int hw_id;
+
+	struct mutex q_mutex;
+};
+
+static inline struct mtk_vcodec_enc_ctx *fh_to_enc_ctx(struct v4l2_fh *fh)
+{
+	return container_of(fh, struct mtk_vcodec_enc_ctx, fh);
+}
+
+static inline struct mtk_vcodec_enc_ctx *ctrl_to_enc_ctx(struct v4l2_ctrl *ctrl)
+{
+	return container_of(ctrl->handler, struct mtk_vcodec_enc_ctx, ctrl_hdl);
+}
+
+/* Wake up context wait_queue */
+static inline void
+wake_up_enc_ctx(struct mtk_vcodec_enc_ctx *ctx, unsigned int reason, unsigned int hw_id)
+{
+	ctx->int_cond[hw_id] = 1;
+	ctx->int_type[hw_id] = reason;
+	wake_up_interruptible(&ctx->queue[hw_id]);
+}
+
+#endif /* _MTK_VCODEC_ENC_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
index 46a028031133..65562a36788f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
@@ -51,10 +51,26 @@ static void mtk_vcodec_vpu_release(struct mtk_vcodec_fw *fw)
 	put_device(&fw->pdev->dev);
 }
 
-static void mtk_vcodec_vpu_reset_handler(void *priv)
+static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
+
+	mtk_v4l2_err("Watchdog timeout!!");
+
+	mutex_lock(&dev->dev_mutex);
+	list_for_each_entry(ctx, &dev->ctx_list, list) {
+		ctx->state = MTK_STATE_ABORT;
+		mtk_v4l2_debug(0, "[%d] Change to state MTK_STATE_ABORT",
+			       ctx->id);
+	}
+	mutex_unlock(&dev->dev_mutex);
+}
+
+static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
+{
+	struct mtk_vcodec_dev *dev = priv;
+	struct mtk_vcodec_enc_ctx *ctx;
 
 	mtk_v4l2_err("Watchdog timeout!!");
 
@@ -102,7 +118,10 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use
 		return ERR_PTR(-EINVAL);
 	}
 
-	vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_handler, dev, rst_id);
+	if (fw_use == DECODER)
+		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_dec_handler, dev, rst_id);
+	else
+		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_enc_handler, dev, rst_id);
 
 	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
 	if (!fw)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
index daa44f635727..e28df989fd82 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
@@ -14,17 +14,31 @@
 int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
 				 unsigned int hw_id)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	int instance_type = *((int *)priv);
+	struct mtk_vcodec_dec_ctx *vdec_ctx;
+	struct mtk_vcodec_enc_ctx *venc_ctx;
 	long timeout_jiff, ret;
 	int status = 0, ctx_id, ctx_type;
 	int *ctx_int_cond, *ctx_int_type;
 	wait_queue_head_t *ctx_queue;
 
-	ctx_id = ctx->id;
-	ctx_type = ctx->type;
-	ctx_int_cond = ctx->int_cond;
-	ctx_int_type = ctx->int_type;
-	ctx_queue = ctx->queue;
+	if (instance_type == DECODER) {
+		vdec_ctx = priv;
+
+		ctx_id = vdec_ctx->id;
+		ctx_type = vdec_ctx->type;
+		ctx_int_cond = vdec_ctx->int_cond;
+		ctx_int_type = vdec_ctx->int_type;
+		ctx_queue = vdec_ctx->queue;
+	} else {
+		venc_ctx = priv;
+
+		ctx_id = venc_ctx->id;
+		ctx_type = venc_ctx->type;
+		ctx_int_cond = venc_ctx->int_cond;
+		ctx_int_type = venc_ctx->int_type;
+		ctx_queue = venc_ctx->queue;
+	}
 
 	timeout_jiff = msecs_to_jiffies(timeout_ms);
 	ret = wait_event_interruptible_timeout(ctx_queue[hw_id],
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
index 11bf0ef94d5d..3e3cc71ee572 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
@@ -9,7 +9,8 @@
 
 #define MTK_INST_IRQ_RECEIVED		0x1
 
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
+struct mtk_vcodec_enc_ctx;
 
 /* timeout is ms */
 int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index 847e321f4fcc..3a3cf5034028 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -34,8 +34,21 @@ EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
-	struct mtk_vcodec_ctx *ctx = priv;
-	struct device *dev = &ctx->dev->plat_dev->dev;
+	int instance_type = *((int *)priv);
+	struct mtk_vcodec_dec_ctx *vdec_ctx;
+	struct mtk_vcodec_enc_ctx *venc_ctx;
+	struct device *dev;
+	int ctx_id;
+
+	if (instance_type == DECODER) {
+		vdec_ctx = priv;
+		dev = &vdec_ctx->dev->plat_dev->dev;
+		ctx_id = vdec_ctx->id;
+	} else {
+		venc_ctx = priv;
+		dev = &venc_ctx->dev->plat_dev->dev;
+		ctx_id = venc_ctx->id;
+	}
 
 	mem->va = dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
@@ -44,10 +57,10 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 		return -ENOMEM;
 	}
 
-	mtk_v4l2_debug(3, "[%d]  - va      = %p", ctx->id, mem->va);
-	mtk_v4l2_debug(3, "[%d]  - dma     = 0x%lx", ctx->id,
+	mtk_v4l2_debug(3, "[%d]  - va      = %p", ctx_id, mem->va);
+	mtk_v4l2_debug(3, "[%d]  - dma     = 0x%lx", ctx_id,
 		       (unsigned long)mem->dma_addr);
-	mtk_v4l2_debug(3, "[%d]    size = 0x%lx", ctx->id, size);
+	mtk_v4l2_debug(3, "[%d]    size = 0x%lx", ctx_id, size);
 
 	return 0;
 }
@@ -56,8 +69,21 @@ EXPORT_SYMBOL(mtk_vcodec_mem_alloc);
 void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
-	struct mtk_vcodec_ctx *ctx = priv;
-	struct device *dev = &ctx->dev->plat_dev->dev;
+	int instance_type = *((int *)priv);
+	struct mtk_vcodec_dec_ctx *vdec_ctx;
+	struct mtk_vcodec_enc_ctx *venc_ctx;
+	struct device *dev;
+	int ctx_id;
+
+	if (instance_type == DECODER) {
+		vdec_ctx = priv;
+		dev = &vdec_ctx->dev->plat_dev->dev;
+		ctx_id = vdec_ctx->id;
+	} else {
+		venc_ctx = priv;
+		dev = &venc_ctx->dev->plat_dev->dev;
+		ctx_id = venc_ctx->id;
+	}
 
 	if (!mem->va) {
 		mtk_v4l2_err("%s dma_free size=%ld failed!", dev_name(dev),
@@ -65,10 +91,10 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 		return;
 	}
 
-	mtk_v4l2_debug(3, "[%d]  - va      = %p", ctx->id, mem->va);
-	mtk_v4l2_debug(3, "[%d]  - dma     = 0x%lx", ctx->id,
+	mtk_v4l2_debug(3, "[%d]  - va      = %p", ctx_id, mem->va);
+	mtk_v4l2_debug(3, "[%d]  - dma     = 0x%lx", ctx_id,
 		       (unsigned long)mem->dma_addr);
-	mtk_v4l2_debug(3, "[%d]    size = 0x%lx", ctx->id, size);
+	mtk_v4l2_debug(3, "[%d]    size = 0x%lx", ctx_id, size);
 
 	dma_free_coherent(dev, size, mem->va, mem->dma_addr);
 	mem->va = NULL;
@@ -89,7 +115,7 @@ void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx)
 EXPORT_SYMBOL(mtk_vcodec_get_hw_dev);
 
 void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-			     struct mtk_vcodec_ctx *ctx, int hw_idx)
+			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 {
 	unsigned long flags;
 	struct mtk_vdec_hw_dev *subdev_dev;
@@ -110,11 +136,11 @@ void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
 }
 EXPORT_SYMBOL(mtk_vcodec_set_curr_ctx);
 
-struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-					       unsigned int hw_idx)
+struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+						   unsigned int hw_idx)
 {
 	unsigned long flags;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vdec_hw_dev *subdev_dev;
 
 	spin_lock_irqsave(&vdec_dev->irqlock, flags);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index f018af38b39d..9c31e70272bd 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -22,7 +22,7 @@ struct mtk_vcodec_fb {
 	dma_addr_t dma_addr;
 };
 
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 struct mtk_vcodec_dev;
 
 #undef pr_fmt
@@ -68,9 +68,9 @@ void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_
 int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-			     struct mtk_vcodec_ctx *ctx, int hw_idx);
-struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-					       unsigned int hw_idx);
+			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
+struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+						   unsigned int hw_idx);
 void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx);
 
 #endif /* _MTK_VCODEC_UTIL_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
index b8629554159e..64cd9ef99766 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
@@ -706,7 +706,7 @@ struct vdec_av1_slice_pfc {
  * @seq:                global picture sequence
  */
 struct vdec_av1_slice_instance {
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 
 	struct mtk_vcodec_mem iq_table;
@@ -756,7 +756,7 @@ static inline bool vdec_av1_slice_need_scale(u32 ref_width, u32 ref_height,
 		(this_height <= (ref_height << 4));
 }
 
-static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -769,7 +769,7 @@ static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 static int vdec_av1_slice_init_cdf_table(struct vdec_av1_slice_instance *instance)
 {
 	u8 *remote_cdf_table;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_av1_slice_init_vsi *vsi;
 	int ret;
 
@@ -801,7 +801,7 @@ static int vdec_av1_slice_init_cdf_table(struct vdec_av1_slice_instance *instanc
 static int vdec_av1_slice_init_iq_table(struct vdec_av1_slice_instance *instance)
 {
 	u8 *remote_iq_table;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_av1_slice_init_vsi *vsi;
 	int ret;
 
@@ -938,7 +938,7 @@ static void vdec_av1_slice_setup_slot(struct vdec_av1_slice_instance *instance,
 static int vdec_av1_slice_alloc_working_buffer(struct vdec_av1_slice_instance *instance,
 					       struct vdec_av1_slice_vsi *vsi)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	enum vdec_av1_slice_resolution_level level;
 	u32 max_sb_w, max_sb_h, max_w, max_h, w, h;
 	int i, ret;
@@ -1021,7 +1021,7 @@ static int vdec_av1_slice_alloc_working_buffer(struct vdec_av1_slice_instance *i
 
 static void vdec_av1_slice_free_working_buffer(struct vdec_av1_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(instance->mv); i++)
@@ -1865,7 +1865,7 @@ static int vdec_av1_slice_update_core(struct vdec_av1_slice_instance *instance,
 	return 0;
 }
 
-static int vdec_av1_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_av1_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_av1_slice_instance *instance;
 	struct vdec_av1_slice_init_vsi *vsi;
@@ -1963,7 +1963,7 @@ static int vdec_av1_slice_flush(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 static void vdec_av1_slice_get_pic_info(struct vdec_av1_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	u32 data[3];
 
 	mtk_vcodec_debug(ctx->id, "w %u h %u\n", ctx->picinfo.pic_w, ctx->picinfo.pic_h);
@@ -1989,7 +1989,7 @@ static inline void vdec_av1_slice_get_dpb_size(struct vdec_av1_slice_instance *i
 static void vdec_av1_slice_get_crop_info(struct vdec_av1_slice_instance *instance,
 					 struct v4l2_rect *cr)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 
 	cr->left = 0;
 	cr->top = 0;
@@ -2029,7 +2029,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	struct vdec_lat_buf *lat_buf;
 	struct vdec_av1_slice_pfc *pfc;
 	struct vdec_av1_slice_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int ret;
 
 	if (!instance || !instance->ctx)
@@ -2131,7 +2131,7 @@ static int vdec_av1_slice_core_decode(struct vdec_lat_buf *lat_buf)
 {
 	struct vdec_av1_slice_instance *instance;
 	struct vdec_av1_slice_pfc *pfc;
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	struct vdec_fb *fb = NULL;
 	int ret = -EINVAL;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
index 5032a776c90f..326cb27faca2 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
@@ -117,7 +117,7 @@ struct vdec_h264_vsi {
 /**
  * struct vdec_h264_inst - h264 decoder instance
  * @num_nalu : how many nalus be decoded
- * @ctx      : point to mtk_vcodec_ctx
+ * @ctx      : point to mtk_vcodec_dec_ctx
  * @pred_buf : HW working predication buffer
  * @mv_buf   : HW working motion vector buffer
  * @vpu      : VPU instance
@@ -125,7 +125,7 @@ struct vdec_h264_vsi {
  */
 struct vdec_h264_inst {
 	unsigned int num_nalu;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem pred_buf;
 	struct mtk_vcodec_mem mv_buf[H264_MAX_FB_NUM];
 	struct vdec_vpu_inst vpu;
@@ -269,7 +269,7 @@ static void get_dpb_size(struct vdec_h264_inst *inst, unsigned int *dpb_sz)
 	mtk_vcodec_debug(inst->ctx->id, "sz=%d", *dpb_sz);
 }
 
-static int vdec_h264_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_h264_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_h264_inst *inst = NULL;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
index 580ce979e2a3..5ca20d75dc8e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
@@ -33,7 +33,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
 	memset(&ref_list[num_valid], 0x20, 32 - num_valid);
 }
 
-void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -43,7 +43,7 @@ void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 	return ctrl->p_cur.p;
 }
 
-void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
+void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
 				 struct slice_api_h264_decode_param *decode_params,
 				 struct mtk_h264_dpb_info *h264_dpb_info)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
index 53d0a7c962a9..0dda9e2315c0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
@@ -182,7 +182,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
  *
  * Return: returns CID ctrl address.
  */
-void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id);
+void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id);
 
 /**
  * mtk_vdec_h264_fill_dpb_info - get each CID contrl address.
@@ -191,7 +191,7 @@ void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id);
  * @decode_params:	slice decode params
  * @h264_dpb_info:	dpb buffer information
  */
-void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
+void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
 				 struct slice_api_h264_decode_param *decode_params,
 				 struct mtk_h264_dpb_info *h264_dpb_info);
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index 6a5533ef0a7f..be9f678ae6f9 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -74,7 +74,7 @@ struct vdec_h264_vsi {
 /**
  * struct vdec_h264_slice_inst - h264 decoder instance
  * @num_nalu : how many nalus be decoded
- * @ctx      : point to mtk_vcodec_ctx
+ * @ctx      : point to mtk_vcodec_dec_ctx
  * @pred_buf : HW working predication buffer
  * @mv_buf   : HW working motion vector buffer
  * @vpu      : VPU instance
@@ -84,7 +84,7 @@ struct vdec_h264_vsi {
  */
 struct vdec_h264_slice_inst {
 	unsigned int num_nalu;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem pred_buf;
 	struct mtk_vcodec_mem mv_buf[H264_MAX_MV_NUM];
 	struct vdec_vpu_inst vpu;
@@ -222,7 +222,7 @@ static void free_mv_buf(struct vdec_h264_slice_inst *inst)
 static void get_pic_info(struct vdec_h264_slice_inst *inst,
 			 struct vdec_pic_info *pic)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 
 	ctx->picinfo.buf_w = ALIGN(ctx->picinfo.pic_w, VCODEC_DEC_ALIGNED_64);
 	ctx->picinfo.buf_h = ALIGN(ctx->picinfo.pic_h, VCODEC_DEC_ALIGNED_64);
@@ -271,7 +271,7 @@ static void get_dpb_size(struct vdec_h264_slice_inst *inst, unsigned int *dpb_sz
 	mtk_vcodec_debug(inst->ctx->id, "sz=%d", *dpb_sz);
 }
 
-static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_h264_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_h264_slice_inst *inst;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index f6614a5e7e66..42355008d580 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -133,7 +133,7 @@ struct vdec_h264_slice_share_info {
  * struct vdec_h264_slice_inst - h264 decoder instance
  *
  * @slice_dec_num:	how many picture be decoded
- * @ctx:		point to mtk_vcodec_ctx
+ * @ctx:		point to mtk_vcodec_dec_ctx
  * @pred_buf:		HW working predication buffer
  * @mv_buf:		HW working motion vector buffer
  * @vpu:		VPU instance
@@ -153,7 +153,7 @@ struct vdec_h264_slice_share_info {
  */
 struct vdec_h264_slice_inst {
 	unsigned int slice_dec_num;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem pred_buf;
 	struct mtk_vcodec_mem mv_buf[H264_MAX_MV_NUM];
 	struct vdec_vpu_inst vpu;
@@ -344,7 +344,7 @@ static void vdec_h264_slice_free_mv_buf(struct vdec_h264_slice_inst *inst)
 
 static void vdec_h264_slice_get_pic_info(struct vdec_h264_slice_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	u32 data[3];
 
 	data[0] = ctx->picinfo.pic_w;
@@ -393,7 +393,7 @@ static void vdec_h264_slice_get_crop_info(struct vdec_h264_slice_inst *inst,
 			 cr->left, cr->top, cr->width, cr->height);
 }
 
-static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_h264_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_h264_slice_inst *inst;
 	int err, vsi_size;
@@ -459,7 +459,7 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
 	u64 vdec_fb_va;
 	u64 y_fb_dma, c_fb_dma;
 	int err, timeout, i;
-	struct mtk_vcodec_ctx *ctx = lat_buf->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = lat_buf->ctx;
 	struct vdec_h264_slice_inst *inst = ctx->drv_handle;
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct vdec_h264_slice_share_info *share_info = lat_buf->private_data;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
index acea0ff311ac..46b564b3f247 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
@@ -344,7 +344,7 @@ struct vdec_hevc_slice_share_info {
  * struct vdec_hevc_slice_inst - hevc decoder instance
  *
  * @slice_dec_num:      how many picture be decoded
- * @ctx:                point to mtk_vcodec_ctx
+ * @ctx:                point to mtk_vcodec_dec_ctx
  * @mv_buf:             HW working motion vector buffer
  * @vpu:                VPU instance
  * @vsi:                vsi used for lat
@@ -359,7 +359,7 @@ struct vdec_hevc_slice_share_info {
  */
 struct vdec_hevc_slice_inst {
 	unsigned int slice_dec_num;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem mv_buf[HEVC_MAX_MV_NUM];
 	struct vdec_vpu_inst vpu;
 	struct vdec_hevc_slice_vsi *vsi;
@@ -380,7 +380,7 @@ static unsigned int vdec_hevc_get_mv_buf_size(unsigned int width, unsigned int h
 	return 64 * unit_size;
 }
 
-static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -390,7 +390,7 @@ static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 	return ctrl->p_cur.p;
 }
 
-static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
+static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
 				    struct slice_api_hevc_decode_param *decode_params,
 				    struct mtk_hevc_dpb_info *hevc_dpb_info)
 {
@@ -679,7 +679,7 @@ static void vdec_hevc_slice_free_mv_buf(struct vdec_hevc_slice_inst *inst)
 
 static void vdec_hevc_slice_get_pic_info(struct vdec_hevc_slice_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	u32 data[3];
 
 	data[0] = ctx->picinfo.pic_w;
@@ -798,7 +798,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct vdec_hevc_slice_inst *inst,
 					     struct vdec_lat_buf *lat_buf)
 {
 	struct mtk_vcodec_mem *mem;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct vdec_fb *fb;
 	u64 y_fb_dma, c_fb_dma;
@@ -854,7 +854,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct vdec_hevc_slice_inst *inst,
 	return 0;
 }
 
-static int vdec_hevc_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_hevc_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_hevc_slice_inst *inst;
 	int err, vsi_size;
@@ -927,7 +927,7 @@ static void vdec_hevc_slice_deinit(void *h_vdec)
 static int vdec_hevc_slice_core_decode(struct vdec_lat_buf *lat_buf)
 {
 	int err, timeout;
-	struct mtk_vcodec_ctx *ctx = lat_buf->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = lat_buf->ctx;
 	struct vdec_hevc_slice_inst *inst = ctx->drv_handle;
 	struct vdec_hevc_slice_share_info *share_info = lat_buf->private_data;
 	struct vdec_vpu_inst *vpu = &inst->vpu;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index 607c0ce67322..a89c477fc4cf 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -160,7 +160,7 @@ struct vdec_vp8_inst {
 	struct mtk_vcodec_mem working_buf;
 	struct vdec_vp8_hw_reg_base reg_base;
 	unsigned int frm_cnt;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 	struct vdec_vp8_vsi *vsi;
 };
@@ -388,7 +388,7 @@ static void free_working_buf(struct vdec_vp8_inst *inst)
 	inst->vsi->dec.working_buf_dma = 0;
 }
 
-static int vdec_vp8_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp8_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp8_inst *inst;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index 468edab5fd60..f530ad00e5ea 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -101,12 +101,12 @@ struct vdec_vp8_slice_inst {
 	struct mtk_vcodec_mem wrap_y_buf;
 	struct mtk_vcodec_mem wrap_c_buf;
 	struct mtk_vcodec_mem vld_wrapper_buf;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 	struct vdec_vp8_slice_vsi *vsi;
 };
 
-static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -118,7 +118,7 @@ static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 
 static void vdec_vp8_slice_get_pic_info(struct vdec_vp8_slice_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	unsigned int data[3];
 
 	data[0] = ctx->picinfo.pic_w;
@@ -233,7 +233,7 @@ static u64 vdec_vp8_slice_get_ref_by_ts(const struct v4l2_ctrl_vp8_frame *frame_
 static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_inst *inst)
 {
 	const struct v4l2_ctrl_vp8_frame *frame_header;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	struct vb2_queue *vq;
 	struct vb2_buffer *vb;
 	u64 referenct_ts;
@@ -272,7 +272,7 @@ static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_inst *inst
 	return 0;
 }
 
-static int vdec_vp8_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp8_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp8_slice_inst *inst;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
index 226d980bc785..f4b4a0e9fedd 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
@@ -196,7 +196,7 @@ struct vdec_vp9_inst {
 	struct list_head fb_free_list;
 	struct list_head fb_disp_list;
 	struct vdec_fb *cur_fb;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 	struct vdec_vp9_vsi *vsi;
 	unsigned int total_frm_cnt;
@@ -535,7 +535,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
 
 static bool vp9_wait_dec_end(struct vdec_vp9_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 
 	mtk_vcodec_wait_for_done_ctx(inst->ctx,
 			MTK_INST_IRQ_RECEIVED,
@@ -547,7 +547,7 @@ static bool vp9_wait_dec_end(struct vdec_vp9_inst *inst)
 		return false;
 }
 
-static struct vdec_vp9_inst *vp9_alloc_inst(struct mtk_vcodec_ctx *ctx)
+static struct vdec_vp9_inst *vp9_alloc_inst(struct mtk_vcodec_dec_ctx *ctx)
 {
 	int result;
 	struct mtk_vcodec_mem mem;
@@ -783,7 +783,7 @@ static void vdec_vp9_deinit(void *h_vdec)
 	vp9_free_inst(inst);
 }
 
-static int vdec_vp9_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp9_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp9_inst *inst;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index b5507dac25b3..e61b0dc13e08 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -445,7 +445,7 @@ struct vdec_vp9_slice_ref {
  * @counts_helper:	counts table according to newest kernel spec
  */
 struct vdec_vp9_slice_instance {
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 
 	int seq;
@@ -506,7 +506,7 @@ static int vdec_vp9_slice_init_default_frame_ctx(struct vdec_vp9_slice_instance
 {
 	struct vdec_vp9_slice_frame_ctx *remote_frame_ctx;
 	struct vdec_vp9_slice_frame_ctx *frame_ctx;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vp9_slice_init_vsi *vsi;
 	int ret = 0;
 
@@ -543,7 +543,7 @@ static int vdec_vp9_slice_init_default_frame_ctx(struct vdec_vp9_slice_instance
 static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slice_instance *instance,
 					       struct vdec_vp9_slice_vsi *vsi)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	enum vdec_vp9_slice_resolution_level level;
 	/* super blocks */
 	unsigned int max_sb_w;
@@ -635,7 +635,7 @@ static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slice_instance *i
 
 static void vdec_vp9_slice_free_working_buffer(struct vdec_vp9_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(instance->mv); i++) {
@@ -1856,7 +1856,7 @@ static int vdec_vp9_slice_update_core(struct vdec_vp9_slice_instance *instance,
 	return 0;
 }
 
-static int vdec_vp9_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp9_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp9_slice_instance *instance;
 	struct vdec_vp9_slice_init_vsi *vsi;
@@ -1939,7 +1939,7 @@ static int vdec_vp9_slice_flush(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 static void vdec_vp9_slice_get_pic_info(struct vdec_vp9_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	unsigned int data[3];
 
 	mtk_vcodec_debug(instance->ctx->id, "w %u h %u\n",
@@ -1992,7 +1992,7 @@ static int vdec_vp9_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	struct vdec_vp9_slice_instance *instance = h_vdec;
 	struct vdec_vp9_slice_pfc *pfc = &instance->sc_pfc;
 	struct vdec_vp9_slice_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int ret;
 
 	if (!instance || !instance->ctx)
@@ -2050,7 +2050,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	struct vdec_lat_buf *lat_buf;
 	struct vdec_vp9_slice_pfc *pfc;
 	struct vdec_vp9_slice_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int ret;
 
 	if (!instance || !instance->ctx)
@@ -2146,7 +2146,7 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
 {
 	struct vdec_vp9_slice_instance *instance;
 	struct vdec_vp9_slice_pfc *pfc;
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	struct vdec_fb *fb = NULL;
 	int ret = -EINVAL;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h b/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
index e913f963b7db..f6abb9365234 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
@@ -15,7 +15,7 @@ struct vdec_common_if {
 	 * @ctx     : [in] mtk v4l2 context
 	 * @h_vdec  : [out] driver handle
 	 */
-	int (*init)(struct mtk_vcodec_ctx *ctx);
+	int (*init)(struct mtk_vcodec_dec_ctx *ctx);
 
 	/**
 	 * (*decode)() - trigger decode
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
index 06d393174cc2..cee9af5d5119 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
@@ -14,7 +14,7 @@
 #include "vdec_drv_base.h"
 #include "mtk_vcodec_dec_pm.h"
 
-int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
+int vdec_if_init(struct mtk_vcodec_dec_ctx *ctx, unsigned int fourcc)
 {
 	enum mtk_vdec_hw_arch hw_arch = ctx->dev->vdec_pdata->hw_arch;
 	int ret = 0;
@@ -68,7 +68,7 @@ int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 	return ret;
 }
 
-int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
+int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_mem *bs,
 		   struct vdec_fb *fb, bool *res_chg)
 {
 	int ret = 0;
@@ -100,7 +100,7 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
 	return ret;
 }
 
-int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_type type,
+int vdec_if_get_param(struct mtk_vcodec_dec_ctx *ctx, enum vdec_get_param_type type,
 		      void *out)
 {
 	int ret = 0;
@@ -115,7 +115,7 @@ int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_type type,
 	return ret;
 }
 
-void vdec_if_deinit(struct mtk_vcodec_ctx *ctx)
+void vdec_if_deinit(struct mtk_vcodec_dec_ctx *ctx)
 {
 	if (!ctx->drv_handle)
 		return;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
index a8da6a59a6a5..816ed6ab1ed0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
@@ -69,14 +69,14 @@ extern const struct vdec_common_if vdec_av1_slice_lat_if;
  * @ctx	: [in] v4l2 context
  * @fourcc	: [in] video format fourcc, V4L2_PIX_FMT_H264/VP8/VP9..
  */
-int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc);
+int vdec_if_init(struct mtk_vcodec_dec_ctx *ctx, unsigned int fourcc);
 
 /**
  * vdec_if_deinit() - deinitialize decode driver
  * @ctx	: [in] v4l2 context
  *
  */
-void vdec_if_deinit(struct mtk_vcodec_ctx *ctx);
+void vdec_if_deinit(struct mtk_vcodec_dec_ctx *ctx);
 
 /**
  * vdec_if_decode() - trigger decode
@@ -90,7 +90,7 @@ void vdec_if_deinit(struct mtk_vcodec_ctx *ctx);
  *
  * Return: 0 on success. -EIO on unrecoverable error.
  */
-int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
+int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_mem *bs,
 		   struct vdec_fb *fb, bool *res_chg);
 
 /**
@@ -99,7 +99,7 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
  * @type	: [in] input parameter type
  * @out	: [out] buffer to store query result
  */
-int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_type type,
+int vdec_if_get_param(struct mtk_vcodec_dec_ctx *ctx, enum vdec_get_param_type type,
 		      void *out);
 
 #endif
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index f555341ae708..a2b5f3dce466 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -202,7 +202,7 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 }
 
 void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
-			   struct mtk_vcodec_ctx *ctx)
+			   struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_lat_buf *lat_buf;
 	struct mtk_vcodec_mem *mem;
@@ -240,8 +240,8 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 {
 	struct vdec_msg_queue *msg_queue =
 		container_of(work, struct vdec_msg_queue, core_work);
-	struct mtk_vcodec_ctx *ctx =
-		container_of(msg_queue, struct mtk_vcodec_ctx, msg_queue);
+	struct mtk_vcodec_dec_ctx *ctx =
+		container_of(msg_queue, struct mtk_vcodec_dec_ctx, msg_queue);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vdec_lat_buf *lat_buf;
 
@@ -281,7 +281,7 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 }
 
 int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
-			struct mtk_vcodec_ctx *ctx, core_decode_cb_t core_decode,
+			struct mtk_vcodec_dec_ctx *ctx, core_decode_cb_t core_decode,
 			int private_size)
 {
 	struct vdec_lat_buf *lat_buf;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index 2a745e902ad1..eea56f24b60e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -17,7 +17,7 @@
 #define NUM_BUFFER_COUNT 3
 
 struct vdec_lat_buf;
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 struct mtk_vcodec_dev;
 typedef int (*core_decode_cb_t)(struct vdec_lat_buf *lat_buf);
 
@@ -76,7 +76,7 @@ struct vdec_lat_buf {
 	struct media_request *src_buf_req;
 
 	void *private_data;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	core_decode_cb_t core_decode;
 	struct list_head lat_list;
 	struct list_head core_list;
@@ -130,7 +130,7 @@ struct vdec_msg_queue {
  * Return: returns 0 if init successfully, or fail.
  */
 int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
-			struct mtk_vcodec_ctx *ctx, core_decode_cb_t core_decode,
+			struct mtk_vcodec_dec_ctx *ctx, core_decode_cb_t core_decode,
 			int private_size);
 
 /**
@@ -186,6 +186,6 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue);
  * @ctx: v4l2 ctx
  */
 void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
-			   struct mtk_vcodec_ctx *ctx);
+			   struct mtk_vcodec_dec_ctx *ctx);
 
 #endif
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
index 0436bba91457..c9766c108209 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
@@ -9,7 +9,7 @@
 
 #include "mtk_vcodec_fw.h"
 
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 
 /**
  * struct vdec_vpu_inst - VPU instance for video codec
@@ -40,7 +40,7 @@ struct vdec_vpu_inst {
 	uint32_t fw_abi_version;
 	uint32_t inst_id;
 	unsigned int signaled;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	wait_queue_head_t wq;
 	mtk_vcodec_ipi_handler handler;
 	unsigned int codec_type;
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index c1b7330de910..8916a7c047a1 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -221,7 +221,7 @@ struct venc_h264_inst {
 	struct venc_vpu_inst vpu_inst;
 	struct venc_h264_vsi *vsi;
 	struct venc_h264_vsi_34 *vsi_34;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 };
 
 static inline u32 h264_read_reg(struct venc_h264_inst *inst, u32 addr)
@@ -419,7 +419,7 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
 static unsigned int h264_enc_wait_venc_done(struct venc_h264_inst *inst)
 {
 	unsigned int irq_status = 0;
-	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = (struct mtk_vcodec_enc_ctx *)inst->ctx;
 
 	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
 					  WAIT_INTR_TIMEOUT_MS, 0)) {
@@ -529,7 +529,7 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 	unsigned int intra_period;
 	unsigned int irq_status;
 	struct venc_frame_info frame_info;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 
 	mtk_vcodec_debug_enter(inst->ctx->id);
 	mtk_vcodec_debug(inst->ctx->id, "frm_cnt = %d\n ", inst->frm_cnt);
@@ -599,7 +599,7 @@ static void h264_encode_filler(struct venc_h264_inst *inst, void *buf,
 	memset(p, 0xff, size);
 }
 
-static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
+static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(ctx);
 	int ret = 0;
@@ -641,7 +641,7 @@ static int h264_enc_encode(void *handle,
 {
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 
 	mtk_vcodec_debug(inst->ctx->id, "opt %d ->", opt);
 
@@ -772,7 +772,7 @@ static int h264_enc_set_param(void *handle,
 {
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 	const bool is_34bit = MTK_ENC_IOVA_IS_34BIT(ctx);
 
 	mtk_vcodec_debug(inst->ctx->id, "->type=%d", type);
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index 5ca6649901ff..d35b8027e574 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -129,7 +129,7 @@ struct venc_vp8_inst {
 	unsigned int ts_mode;
 	struct venc_vpu_inst vpu_inst;
 	struct venc_vp8_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 };
 
 static inline u32 vp8_enc_read_reg(struct venc_vp8_inst *inst, u32 addr)
@@ -219,7 +219,7 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_inst *inst)
 static unsigned int vp8_enc_wait_venc_done(struct venc_vp8_inst *inst)
 {
 	unsigned int irq_status = 0;
-	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = (struct mtk_vcodec_enc_ctx *)inst->ctx;
 
 	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
 					  WAIT_INTR_TIMEOUT_MS, 0)) {
@@ -324,7 +324,7 @@ static int vp8_enc_encode_frame(struct venc_vp8_inst *inst,
 	return ret;
 }
 
-static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
+static int vp8_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 {
 	int ret = 0;
 	struct venc_vp8_inst *inst;
@@ -362,7 +362,7 @@ static int vp8_enc_encode(void *handle,
 {
 	int ret = 0;
 	struct venc_vp8_inst *inst = (struct venc_vp8_inst *)handle;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 
 	mtk_vcodec_debug_enter(inst->ctx->id);
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h b/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
index 3d718411dc73..17f8183461b5 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
@@ -19,7 +19,7 @@ struct venc_common_if {
 	 * @ctx:	[in] mtk v4l2 context
 	 * @handle: [out] driver handle
 	 */
-	int (*init)(struct mtk_vcodec_ctx *ctx);
+	int (*init)(struct mtk_vcodec_enc_ctx *ctx);
 
 	/**
 	 * (*encode)() - trigger encode
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
index ce0bce811615..08083030516e 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
@@ -16,7 +16,7 @@
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_pm.h"
 
-int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
+int venc_if_init(struct mtk_vcodec_enc_ctx *ctx, unsigned int fourcc)
 {
 	int ret = 0;
 
@@ -40,8 +40,8 @@ int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 	return ret;
 }
 
-int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
-		enum venc_set_param_type type, struct venc_enc_param *in)
+int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
+		      enum venc_set_param_type type, struct venc_enc_param *in)
 {
 	int ret = 0;
 
@@ -54,7 +54,7 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
 	return ret;
 }
 
-int venc_if_encode(struct mtk_vcodec_ctx *ctx,
+int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 		   enum venc_start_opt opt, struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
 		   struct venc_done_result *result)
@@ -65,7 +65,7 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 	mtk_venc_lock(ctx);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = ctx;
+	ctx->dev->curr_enc_ctx = ctx;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
 	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
@@ -74,14 +74,14 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = NULL;
+	ctx->dev->curr_enc_ctx = NULL;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
 	mtk_venc_unlock(ctx);
 	return ret;
 }
 
-int venc_if_deinit(struct mtk_vcodec_ctx *ctx)
+int venc_if_deinit(struct mtk_vcodec_enc_ctx *ctx)
 {
 	int ret = 0;
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
index 0b04a1020873..90d714e86ede 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
@@ -132,14 +132,14 @@ extern const struct venc_common_if venc_vp8_if;
  * @fourcc: encoder input format
  * Return: 0 if creating handle successfully, otherwise it is failed.
  */
-int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc);
+int venc_if_init(struct mtk_vcodec_enc_ctx *ctx, unsigned int fourcc);
 
 /*
  * venc_if_deinit - Release the driver handle
  * @ctx: device context
  * Return: 0 if releasing handle successfully, otherwise it is failed.
  */
-int venc_if_deinit(struct mtk_vcodec_ctx *ctx);
+int venc_if_deinit(struct mtk_vcodec_enc_ctx *ctx);
 
 /*
  * venc_if_set_param - Set parameter to driver
@@ -148,7 +148,7 @@ int venc_if_deinit(struct mtk_vcodec_ctx *ctx);
  * @in: input parameter
  * Return: 0 if setting param successfully, otherwise it is failed.
  */
-int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
+int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
 		      enum venc_set_param_type type,
 		      struct venc_enc_param *in);
 
@@ -161,7 +161,7 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
  * @result: encode result
  * Return: 0 if encoding frame successfully, otherwise it is failed.
  */
-int venc_if_encode(struct mtk_vcodec_ctx *ctx,
+int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 		   enum venc_start_opt opt,
 		   struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
index f83bc1b3f2bf..71370ab98809 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
@@ -35,7 +35,7 @@ struct venc_vpu_inst {
 	unsigned int inst_addr;
 	void *vsi;
 	int id;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 };
 
 int vpu_enc_init(struct venc_vpu_inst *vpu);
-- 
2.25.1

