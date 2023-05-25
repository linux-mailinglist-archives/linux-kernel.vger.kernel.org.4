Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614B7710277
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbjEYBkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbjEYBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:40:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C412F;
        Wed, 24 May 2023 18:40:22 -0700 (PDT)
X-UUID: 1916290cfa9d11ed9cb5633481061a41-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EXYJiSXFWszC60VW1Mpl7DVaCUrm9+G5TpFWnV5gHa8=;
        b=CGaZZ/aVdb4tK8GrxvJXNxVH9k17ttqpCJ2ALStkRpaLGbEdHS0waANJyu7zqYfCrqW27j39+7OsNLt6klNGpJs9oANRgNUcXveRsB73mFIB5h5UqFWkg0szYoNHMrJQL+J0HS/Xbp+kJOceDnd9OZIW65ZNlk+i2lHcTNmkoZo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:0225f035-57a6-4da5-a6eb-2e82ca803ff1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.25,REQID:0225f035-57a6-4da5-a6eb-2e82ca803ff1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:d5b0ae3,CLOUDID:65eeea6c-2f20-4998-991c-3b78627e4938,B
        ulkID:230525094016ZQFNXMYE,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 1916290cfa9d11ed9cb5633481061a41-20230525
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 22819965; Thu, 25 May 2023 09:40:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 09:40:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 09:40:13 +0800
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
Subject: [PATCH v4,2/4] media: mediatek: vcodec: using decoder status instead of core work count
Date:   Thu, 25 May 2023 09:40:07 +0800
Message-ID: <20230525014009.23345-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525014009.23345-1-yunfei.dong@mediatek.com>
References: <20230525014009.23345-1-yunfei.dong@mediatek.com>
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

Adding the definition of decoder status to separate different decoder
period for core hardware.

core_work_cnt is the number of core work queued to work queue, the control
is very complex, leading to some unreasonable test result.

Using parameter status to indicate whether queue core work to work queue.

Fixes: 2e0ef56d81cb ("media: mediatek: vcodec: making sure queue_work successfully")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 33 ++++++++-----------
 .../platform/mediatek/vcodec/vdec_msg_queue.h | 16 +++++++--
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index f3073d1e7f42..03f8d7cd8edd 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -71,7 +71,6 @@ static void vdec_msg_queue_dec(struct vdec_msg_queue *msg_queue, int hardware_in
 int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf *buf)
 {
 	struct list_head *head;
-	int status;
 
 	head = vdec_get_buf_list(msg_ctx->hardware_index, buf);
 	if (!head) {
@@ -87,12 +86,9 @@ int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf
 	if (msg_ctx->hardware_index != MTK_VDEC_CORE) {
 		wake_up_all(&msg_ctx->ready_to_use);
 	} else {
-		if (buf->ctx->msg_queue.core_work_cnt <
-			atomic_read(&buf->ctx->msg_queue.core_list_cnt)) {
-			status = queue_work(buf->ctx->dev->core_workqueue,
-					    &buf->ctx->msg_queue.core_work);
-			if (status)
-				buf->ctx->msg_queue.core_work_cnt++;
+		if (!(buf->ctx->msg_queue.status & CONTEXT_LIST_QUEUED)) {
+			queue_work(buf->ctx->dev->core_workqueue, &buf->ctx->msg_queue.core_work);
+			buf->ctx->msg_queue.status |= CONTEXT_LIST_QUEUED;
 		}
 	}
 
@@ -261,7 +257,10 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 		container_of(msg_queue, struct mtk_vcodec_ctx, msg_queue);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vdec_lat_buf *lat_buf;
-	int status;
+
+	spin_lock(&ctx->dev->msg_queue_core_ctx.ready_lock);
+	ctx->msg_queue.status &= ~CONTEXT_LIST_QUEUED;
+	spin_unlock(&ctx->dev->msg_queue_core_ctx.ready_lock);
 
 	lat_buf = vdec_msg_queue_dqbuf(&dev->msg_queue_core_ctx);
 	if (!lat_buf)
@@ -278,17 +277,13 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
 
 	wake_up_all(&ctx->msg_queue.core_dec_done);
-	spin_lock(&dev->msg_queue_core_ctx.ready_lock);
-	lat_buf->ctx->msg_queue.core_work_cnt--;
-
-	if (lat_buf->ctx->msg_queue.core_work_cnt <
-		atomic_read(&lat_buf->ctx->msg_queue.core_list_cnt)) {
-		status = queue_work(lat_buf->ctx->dev->core_workqueue,
-				    &lat_buf->ctx->msg_queue.core_work);
-		if (status)
-			lat_buf->ctx->msg_queue.core_work_cnt++;
+	if (!(ctx->msg_queue.status & CONTEXT_LIST_QUEUED) &&
+	    atomic_read(&msg_queue->core_list_cnt)) {
+		spin_lock(&ctx->dev->msg_queue_core_ctx.ready_lock);
+		ctx->msg_queue.status |= CONTEXT_LIST_QUEUED;
+		spin_unlock(&ctx->dev->msg_queue_core_ctx.ready_lock);
+		queue_work(ctx->dev->core_workqueue, &msg_queue->core_work);
 	}
-	spin_unlock(&dev->msg_queue_core_ctx.ready_lock);
 }
 
 int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
@@ -303,13 +298,13 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 		return 0;
 
 	msg_queue->ctx = ctx;
-	msg_queue->core_work_cnt = 0;
 	vdec_msg_queue_init_ctx(&msg_queue->lat_ctx, MTK_VDEC_LAT0);
 	INIT_WORK(&msg_queue->core_work, vdec_msg_queue_core_work);
 
 	atomic_set(&msg_queue->lat_list_cnt, 0);
 	atomic_set(&msg_queue->core_list_cnt, 0);
 	init_waitqueue_head(&msg_queue->core_dec_done);
+	msg_queue->status = CONTEXT_LIST_EMPTY;
 
 	msg_queue->wdma_addr.size =
 		vde_msg_queue_get_trans_size(ctx->picinfo.buf_w,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index a5d44bc97c16..8f82d1484772 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -21,6 +21,18 @@ struct mtk_vcodec_ctx;
 struct mtk_vcodec_dev;
 typedef int (*core_decode_cb_t)(struct vdec_lat_buf *lat_buf);
 
+/**
+ * enum core_ctx_status - Context decode status for core hardwre.
+ * @CONTEXT_LIST_EMPTY: No buffer queued on core hardware(must always be 0)
+ * @CONTEXT_LIST_QUEUED: Buffer queued to core work list
+ * @CONTEXT_LIST_DEC_DONE: context decode done
+ */
+enum core_ctx_status {
+	CONTEXT_LIST_EMPTY = 0,
+	CONTEXT_LIST_QUEUED,
+	CONTEXT_LIST_DEC_DONE,
+};
+
 /**
  * struct vdec_msg_queue_ctx - represents a queue for buffers ready to be processed
  * @ready_to_use: ready used queue used to signalize when get a job queue
@@ -77,7 +89,7 @@ struct vdec_lat_buf {
  * @lat_list_cnt: used to record each instance lat list count
  * @core_list_cnt: used to record each instance core list count
  * @core_dec_done: core work queue decode done event
- * @core_work_cnt: the number of core work in work queue
+ * @status: current context decode status for core hardware
  */
 struct vdec_msg_queue {
 	struct vdec_lat_buf lat_buf[NUM_BUFFER_COUNT];
@@ -93,7 +105,7 @@ struct vdec_msg_queue {
 	atomic_t lat_list_cnt;
 	atomic_t core_list_cnt;
 	wait_queue_head_t core_dec_done;
-	int core_work_cnt;
+	int status;
 };
 
 /**
-- 
2.18.0

