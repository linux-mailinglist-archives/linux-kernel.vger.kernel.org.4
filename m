Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC52C6EC5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjDXGDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 02:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjDXGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:02:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC5846B1;
        Sun, 23 Apr 2023 23:01:42 -0700 (PDT)
X-UUID: 794975a4e26511eda9a90f0bb45854f4-20230424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WoL64s5ABGC3JLRHKg1Y7d5gunkiamjG91kHfOR9t2s=;
        b=uYFe9Yl3jTbnK9K9Mpz572rqLwRtyxHxG3BVnXDbqvMx7Qg1v5f7C8rStAwchF8+YsQUZNG+9F2twjKh4VNGaLuICZZEDtmeGeB13YGxXQPvpbBKb+nIcJ1RgwCK7xbP8cWASce/GGP8BQ/1//Z0xbY2wa3rLnEpSeBeYoDBFTc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:7d2f8565-424f-410d-8660-dde958f46a2e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:7d2f8565-424f-410d-8660-dde958f46a2e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:bb9d49a2-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230424140139O6K56AXB,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 794975a4e26511eda9a90f0bb45854f4-20230424
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1640590661; Mon, 24 Apr 2023 14:01:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Apr 2023 14:01:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Apr 2023 14:01:35 +0800
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
Subject: [PATCH v3,4/4] media: mediatek: vcodec: using empty lat buffer as the last one
Date:   Mon, 24 Apr 2023 14:01:30 +0800
Message-ID: <20230424060130.18395-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424060130.18395-1-yunfei.dong@mediatek.com>
References: <20230424060130.18395-1-yunfei.dong@mediatek.com>
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
index 08c720c9760e..66b4175601e3 100644
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
+	mtk_v4l2_debug(3, "flush done => ready_num:%d status:%d list(%d %d)",
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

