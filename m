Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DD6507D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiLSGpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLSGol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:44:41 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE9DEF2;
        Sun, 18 Dec 2022 22:43:46 -0800 (PST)
X-UUID: 1010e273bddc4456b8581de3a78062af-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=odog/isKgUkhZk4MV4Q1K/niqEMxgodJbAmD9P+gUPE=;
        b=jhL3bA1per8Idx+AZmcVkTHrdl/AGG+O/nD1k65YQUzCtm2BDZo6iK5pEc6dsC4FovkVQ/lBeWJantI3LzkOCpqO29zz1RKmNajCZDTed7VIfxz4TRDdVDx631lGLLB3IEBjx5wryXxSxMghVUS6SzlezQPisVWsbzBwFT/7aYE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:98c6fb85-3bf1-4076-9f77-af8d9667c33e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:98c6fb85-3bf1-4076-9f77-af8d9667c33e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:d6a2bc89-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2212191443429Q43CZUM,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1010e273bddc4456b8581de3a78062af-20221219
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2006930266; Mon, 19 Dec 2022 14:43:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 14:43:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Dec 2022 14:43:39 +0800
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
Subject: [PATCH v2,3/7] media: mediatek: vcodec: move lat_buf to the top of core list
Date:   Mon, 19 Dec 2022 14:43:28 +0800
Message-ID: <20221219064332.2124-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219064332.2124-1-yunfei.dong@mediatek.com>
References: <20221219064332.2124-1-yunfei.dong@mediatek.com>
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
 .../platform/mediatek/vcodec/vdec_msg_queue.c      | 14 ++++++++++++++
 .../platform/mediatek/vcodec/vdec_msg_queue.h      |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index ad5002ca953e..ed526ff0ade6 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -174,9 +174,22 @@ void vdec_msg_queue_update_ube_wptr(struct vdec_msg_queue *msg_queue, uint64_t u
 
 bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 {
+	struct vdec_lat_buf *buf, *tmp;
+	struct vdec_msg_queue_ctx *core_ctx;
 	long timeout_jiff;
 	int ret;
 
+	core_ctx = &msg_queue->ctx->dev->msg_queue_core_ctx;
+	spin_lock(&core_ctx->ready_lock);
+	list_for_each_entry_safe(buf, tmp, &core_ctx->ready_queue, core_list) {
+		if (buf && buf->ctx == msg_queue->ctx) {
+			list_move(&buf->core_list, &core_ctx->ready_queue);
+			queue_work(buf->ctx->dev->core_workqueue,
+				   &buf->ctx->msg_queue.core_work);
+		}
+	}
+	spin_unlock(&core_ctx->ready_lock);
+
 	timeout_jiff = msecs_to_jiffies(1000 * (NUM_BUFFER_COUNT + 2));
 	ret = wait_event_timeout(msg_queue->lat_ctx.ready_to_use,
 				 msg_queue->lat_ctx.ready_num == NUM_BUFFER_COUNT,
@@ -257,6 +270,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
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
2.25.1

