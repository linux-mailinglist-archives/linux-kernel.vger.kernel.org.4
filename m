Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281E66860AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjBAHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:33:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543D11140;
        Tue, 31 Jan 2023 23:33:28 -0800 (PST)
X-UUID: b5b3dc08a20211ed945fc101203acc17-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=88pRMCVl/UXV909ZRbmU0TQkYikt3A2ZWXIraNYULyw=;
        b=N4Qb8eaUdEXT7rXoAPalF8ezWO4inOdxSbemKlt8oI4tp6ki+fNMf8Zv7VAtHFzatpu4XqmMHy1dq6azy3f6ATFvuJt6wlufJRII06GQTJBjz8fFsAyfXBtklQVbgHULPCUbm6ysdXDAUz/numbI0SQB0VFdwulofAYPte/HOyw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:7de75d24-44f1-46c9-bcc7-e74fd3776c5f,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:3ca2d6b,CLOUDID:7ca51ef7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: b5b3dc08a20211ed945fc101203acc17-20230201
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 612455149; Wed, 01 Feb 2023 15:33:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 15:33:22 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 15:33:21 +0800
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
Subject: [PATCH v4,3/7] media: mediatek: vcodec: move lat_buf to the top of core list
Date:   Wed, 1 Feb 2023 15:33:12 +0800
Message-ID: <20230201073316.27923-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201073316.27923-1-yunfei.dong@mediatek.com>
References: <20230201073316.27923-1-yunfei.dong@mediatek.com>
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

Current instance will decode done when begin to wait lat buf full,
move the lat_buf of current instance to the top of core list to make
sure current instance's lat_buf will be used firstly.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 21 ++++++++++++++++++-
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index ad5002ca953e..0da6e3e2ef0b 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -174,8 +174,26 @@ void vdec_msg_queue_update_ube_wptr(struct vdec_msg_queue *msg_queue, uint64_t u
 
 bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 {
+	struct vdec_lat_buf *buf, *tmp;
+	struct list_head *list_core[3];
+	struct vdec_msg_queue_ctx *core_ctx;
+	int ret, i, in_core_count = 0;
 	long timeout_jiff;
-	int ret;
+
+	core_ctx = &msg_queue->ctx->dev->msg_queue_core_ctx;
+	spin_lock(&core_ctx->ready_lock);
+	list_for_each_entry_safe(buf, tmp, &core_ctx->ready_queue, core_list) {
+		if (buf && buf->ctx == msg_queue->ctx) {
+			list_core[in_core_count++] = &buf->core_list;
+			list_del(&buf->core_list);
+		}
+	}
+
+	for (i = 0; i < in_core_count; i++) {
+		list_add(list_core[in_core_count - (1 + i)], &core_ctx->ready_queue);
+		queue_work(msg_queue->ctx->dev->core_workqueue, &msg_queue->core_work);
+	}
+	spin_unlock(&core_ctx->ready_lock);
 
 	timeout_jiff = msecs_to_jiffies(1000 * (NUM_BUFFER_COUNT + 2));
 	ret = wait_event_timeout(msg_queue->lat_ctx.ready_to_use,
@@ -257,6 +275,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 	if (msg_queue->wdma_addr.size)
 		return 0;
 
+	msg_queue->ctx = ctx;
 	vdec_msg_queue_init_ctx(&msg_queue->lat_ctx, MTK_VDEC_LAT0);
 	INIT_WORK(&msg_queue->core_work, vdec_msg_queue_core_work);
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index b1aa5572ba49..56280d6682c5 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -72,6 +72,7 @@ struct vdec_lat_buf {
  * @wdma_wptr_addr: ube write point
  * @core_work: core hardware work
  * @lat_ctx: used to store lat buffer list
+ * @ctx: point to mtk_vcodec_ctx
  *
  * @lat_list_cnt: used to record each instance lat list count
  * @core_list_cnt: used to record each instance core list count
@@ -85,6 +86,7 @@ struct vdec_msg_queue {
 
 	struct work_struct core_work;
 	struct vdec_msg_queue_ctx lat_ctx;
+	struct mtk_vcodec_ctx *ctx;
 
 	atomic_t lat_list_cnt;
 	atomic_t core_list_cnt;
-- 
2.18.0

