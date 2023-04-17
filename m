Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7F6E47B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDQM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDQM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:29:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDF6C3;
        Mon, 17 Apr 2023 05:29:06 -0700 (PDT)
X-UUID: 5434bdd8dd1911eda9a90f0bb45854f4-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CK0fmkAEedInrPD7lyX6XNapubONfO3nkobCT36RNXs=;
        b=Jo+nRemdZD9UM0VvxGQW0Edv+GscqSw81h21DmblxsAN7CQuN3QlbQfLEAwjsRc5HE/qSco5dLsW36IikAYJvaWH7tDKuC5uytL1qhguurXQidE+QTpjDRjiFFHNOUyfybC45m3MQIW4K5SRFX+ekbxxB51vaL3q51tKzClkIkc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:442e33b8-4a7a-4408-9a4d-8c344d587213,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:fc609aa1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 5434bdd8dd1911eda9a90f0bb45854f4-20230417
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1535629906; Mon, 17 Apr 2023 20:13:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 20:13:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 20:13:55 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,4/4] media: mediatek: vcodec: using empty lat buffer as the last one
Date:   Mon, 17 Apr 2023 20:13:50 +0800
Message-ID: <20230417121350.32186-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417121350.32186-1-yunfei.dong@mediatek.com>
References: <20230417121350.32186-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding one empty lat buffer with parameter 'is_empty_flag = true'
used to flush core work queue decode.

Queue the empty lat buffer to core list when driver need to flush decode.
It's mean core already decode all existed lat buffer when get empty lat
buffer, then wake up core decode done event, the driver will exit when getting
core dec done event.

Fixes: d227af847ac2 ("media: mediatek: vcodec: add core decode done event")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 35 +++++++++++--------
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  8 +++++
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 08c720c9760e..d2e48eefc958 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -177,9 +177,6 @@ void vdec_msg_queue_update_ube_wptr(struct vdec_msg_queue *msg_queue, uint64_t u
 
 bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 {
-	int ret;
-	long timeout_jiff;
-
 	if (atomic_read(&msg_queue->lat_list_cnt) == NUM_BUFFER_COUNT) {
 		mtk_v4l2_debug(3, "wait buf full: list(%d %d) ready_num:%d status:%d",
 			       atomic_read(&msg_queue->lat_list_cnt),
@@ -189,19 +186,14 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 		return true;
 	}
 
-	timeout_jiff = msecs_to_jiffies(1000 * (NUM_BUFFER_COUNT + 2));
-	ret = wait_event_timeout(msg_queue->ctx->msg_queue.core_dec_done,
-				 msg_queue->lat_ctx.ready_num == NUM_BUFFER_COUNT,
-				 timeout_jiff);
-	if (ret) {
-		mtk_v4l2_debug(3, "success to get lat buf: %d",
-			       msg_queue->lat_ctx.ready_num);
-		return true;
-	}
+	msg_queue->flush_done = false;
+	vdec_msg_queue_qbuf(&msg_queue->core_ctx, &msg_queue->empty_lat_buf);
+	wait_event(msg_queue->core_dec_done, msg_queue->flush_done);
 
-	mtk_v4l2_err("failed with lat buf isn't full: list(%d %d)",
-		     atomic_read(&msg_queue->lat_list_cnt),
-		     atomic_read(&msg_queue->core_list_cnt));
+	mtk_v4l2_debug("flush done => ready_num:%d status:%d list(%d %d)",
+		       msg_queue->lat_ctx.ready_num, msg_queue->status,
+		       atomic_read(&msg_queue->lat_list_cnt),
+		       atomic_read(&msg_queue->core_list_cnt));
 
 	return false;
 }
@@ -250,6 +242,14 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 	if (!lat_buf)
 		return;
 
+	if (lat_buf->is_last_frame) {
+		ctx->msg_queue.status = CONTEXT_LIST_DEC_DONE;
+		msg_queue->flush_done = true;
+		wake_up(&ctx->msg_queue.core_dec_done);
+
+		return;
+	}
+
 	ctx = lat_buf->ctx;
 	mtk_vcodec_dec_enable_hardware(ctx, MTK_VDEC_CORE);
 	mtk_vcodec_set_curr_ctx(dev, ctx, MTK_VDEC_CORE);
@@ -300,6 +300,10 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 	msg_queue->wdma_rptr_addr = msg_queue->wdma_addr.dma_addr;
 	msg_queue->wdma_wptr_addr = msg_queue->wdma_addr.dma_addr;
 
+	msg_queue->empty_lat_buf.ctx = ctx;
+	msg_queue->empty_lat_buf.core_decode = NULL;
+	msg_queue->empty_lat_buf.is_last_frame = true;
+
 	for (i = 0; i < NUM_BUFFER_COUNT; i++) {
 		lat_buf = &msg_queue->lat_buf[i];
 
@@ -325,6 +329,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 
 		lat_buf->ctx = ctx;
 		lat_buf->core_decode = core_decode;
+		lat_buf->is_last_frame = false;
 		err = vdec_msg_queue_qbuf(&msg_queue->lat_ctx, lat_buf);
 		if (err) {
 			mtk_v4l2_err("failed to qbuf buf[%d]", i);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index efc94165e016..8f771874f8e6 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -62,6 +62,8 @@ struct vdec_msg_queue_ctx {
  * @core_decode: different codec use different decode callback function
  * @lat_list: add lat buffer to lat head list
  * @core_list: add lat buffer to core head list
+ *
+ * @is_last_frame: meaning this buffer is the last frame
  */
 struct vdec_lat_buf {
 	struct mtk_vcodec_mem wdma_err_addr;
@@ -74,6 +76,8 @@ struct vdec_lat_buf {
 	core_decode_cb_t core_decode;
 	struct list_head lat_list;
 	struct list_head core_list;
+
+	bool is_last_frame;
 };
 
 /**
@@ -88,6 +92,8 @@ struct vdec_lat_buf {
  *
  * @lat_list_cnt: used to record each instance lat list count
  * @core_list_cnt: used to record each instance core list count
+ * @flush_done: core flush done status
+ * @empty_lat_buf: the last lat buf used to flush decode
  * @core_dec_done: core work queue decode done event
  * @status: current context decode status for core hardware
  */
@@ -104,6 +110,8 @@ struct vdec_msg_queue {
 
 	atomic_t lat_list_cnt;
 	atomic_t core_list_cnt;
+	bool flush_done;
+	struct vdec_lat_buf empty_lat_buf;
 	wait_queue_head_t core_dec_done;
 	int status;
 };
-- 
2.18.0

