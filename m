Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D925666A13
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjALENI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjALEMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:12:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E5B4D486;
        Wed, 11 Jan 2023 20:11:56 -0800 (PST)
X-UUID: 3d24e544922f11eda06fc9ecc4dadd91-20230112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VGOhPn9WiWW6pB8TKxx2qIP4+8wsLCqYE4xeDwAEtJ4=;
        b=tetRkzaNQxo+U+i5QGTogwfhSMcmbbl5ZM2h8ri76IQrX1XAq++U0iaNPbzpybZZ+iy8Dn3PSo9UaMvVwn8MfTZr7Qzyoc1/bYTfWAey+eeWyhF1N9gqYVPZGqI1ltUeSXeFTa+4lbfecxBMTzg4eYT1aMNIKval8W21B6Gve20=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:99390537-8d11-4a9a-ac72-9b9276fd4b2e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:99390537-8d11-4a9a-ac72-9b9276fd4b2e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:1eb66b54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2301121211532JQUJLPW,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 3d24e544922f11eda06fc9ecc4dadd91-20230112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 794779153; Thu, 12 Jan 2023 12:11:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Jan 2023 12:11:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Jan 2023 12:11:48 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3,6/7] media: mediatek: vcodec: making sure queue_work successfully
Date:   Thu, 12 Jan 2023 12:11:39 +0800
Message-ID: <20230112041140.833-7-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112041140.833-1-yunfei.dong@mediatek.com>
References: <20230112041140.833-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting core work to work queue using queue_work maybe fail, call
queue_work again when the count of core work in work queue is less
than core_list_cnt, making sure all the buffer in core list can be
scheduled.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 31 ++++++++++++++-----
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  2 ++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index cdc539a46cb9..f3073d1e7f42 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -71,6 +71,7 @@ static void vdec_msg_queue_dec(struct vdec_msg_queue *msg_queue, int hardware_in
 int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf *buf)
 {
 	struct list_head *head;
+	int status;
 
 	head = vdec_get_buf_list(msg_ctx->hardware_index, buf);
 	if (!head) {
@@ -83,11 +84,17 @@ int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf
 	msg_ctx->ready_num++;
 
 	vdec_msg_queue_inc(&buf->ctx->msg_queue, msg_ctx->hardware_index);
-	if (msg_ctx->hardware_index != MTK_VDEC_CORE)
+	if (msg_ctx->hardware_index != MTK_VDEC_CORE) {
 		wake_up_all(&msg_ctx->ready_to_use);
-	else
-		queue_work(buf->ctx->dev->core_workqueue,
-			   &buf->ctx->msg_queue.core_work);
+	} else {
+		if (buf->ctx->msg_queue.core_work_cnt <
+			atomic_read(&buf->ctx->msg_queue.core_list_cnt)) {
+			status = queue_work(buf->ctx->dev->core_workqueue,
+					    &buf->ctx->msg_queue.core_work);
+			if (status)
+				buf->ctx->msg_queue.core_work_cnt++;
+		}
+	}
 
 	mtk_v4l2_debug(3, "enqueue buf type: %d addr: 0x%p num: %d",
 		       msg_ctx->hardware_index, buf, msg_ctx->ready_num);
@@ -254,6 +261,7 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 		container_of(msg_queue, struct mtk_vcodec_ctx, msg_queue);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vdec_lat_buf *lat_buf;
+	int status;
 
 	lat_buf = vdec_msg_queue_dqbuf(&dev->msg_queue_core_ctx);
 	if (!lat_buf)
@@ -270,11 +278,17 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
 
 	wake_up_all(&ctx->msg_queue.core_dec_done);
-	if (atomic_read(&lat_buf->ctx->msg_queue.core_list_cnt)) {
-		mtk_v4l2_debug(3, "re-schedule to decode for core: %d",
-			       dev->msg_queue_core_ctx.ready_num);
-		queue_work(dev->core_workqueue, &msg_queue->core_work);
+	spin_lock(&dev->msg_queue_core_ctx.ready_lock);
+	lat_buf->ctx->msg_queue.core_work_cnt--;
+
+	if (lat_buf->ctx->msg_queue.core_work_cnt <
+		atomic_read(&lat_buf->ctx->msg_queue.core_list_cnt)) {
+		status = queue_work(lat_buf->ctx->dev->core_workqueue,
+				    &lat_buf->ctx->msg_queue.core_work);
+		if (status)
+			lat_buf->ctx->msg_queue.core_work_cnt++;
 	}
+	spin_unlock(&dev->msg_queue_core_ctx.ready_lock);
 }
 
 int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
@@ -289,6 +303,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 		return 0;
 
 	msg_queue->ctx = ctx;
+	msg_queue->core_work_cnt = 0;
 	vdec_msg_queue_init_ctx(&msg_queue->lat_ctx, MTK_VDEC_LAT0);
 	INIT_WORK(&msg_queue->core_work, vdec_msg_queue_core_work);
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index a75c04418f52..a5d44bc97c16 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -77,6 +77,7 @@ struct vdec_lat_buf {
  * @lat_list_cnt: used to record each instance lat list count
  * @core_list_cnt: used to record each instance core list count
  * @core_dec_done: core work queue decode done event
+ * @core_work_cnt: the number of core work in work queue
  */
 struct vdec_msg_queue {
 	struct vdec_lat_buf lat_buf[NUM_BUFFER_COUNT];
@@ -92,6 +93,7 @@ struct vdec_msg_queue {
 	atomic_t lat_list_cnt;
 	atomic_t core_list_cnt;
 	wait_queue_head_t core_dec_done;
+	int core_work_cnt;
 };
 
 /**
-- 
2.18.0

