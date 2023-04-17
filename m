Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BB6E3F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDQFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDQFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:48:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18B2713;
        Sun, 16 Apr 2023 22:48:30 -0700 (PDT)
X-UUID: 76e8d69cdce311edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=d75mVnZFtVkrnXNi/ZwIiIkVcz/OyU/RTUHoiEDIknM=;
        b=B2CAvljtpT8uZZs1ijIeG2FVI0PdJyTRWhAFVFKsOzLitoOrr4CLptaZRzWx+REILBIov5alTexONWoLJKlGstqt2Aosgs0ePUY1jrv5jQqwIpotKv8Iz+Ysw8Y/LDUjeZzWh9Q5+oZZe9u/E4TWQuObrooHHP59jLGEshwZmCM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:506fe390-9f19-4143-a438-cd0741898fb5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:24bb2eeb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 76e8d69cdce311edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 193392430; Mon, 17 Apr 2023 13:48:22 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 13:48:22 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 13:48:21 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Yunfei Dong <yunfei.dong@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 4/6] media: mediatek: vcodec: add one empty lat buffer as the last one to decode
Date:   Mon, 17 Apr 2023 13:48:14 +0800
Message-ID: <20230417054816.17097-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417054816.17097-1-yunfei.dong@mediatek.com>
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
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

Adding one empty lat buffer with the parameter 'is_empty_flag = true' used
to flush core work queue decode.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 5 +++++
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 03f8d7cd8edd..ef141f9d7bb1 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -317,6 +317,10 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 	msg_queue->wdma_rptr_addr = msg_queue->wdma_addr.dma_addr;
 	msg_queue->wdma_wptr_addr = msg_queue->wdma_addr.dma_addr;
 
+	msg_queue->empty_lat_buf.ctx = ctx;
+	msg_queue->empty_lat_buf.core_decode = NULL;
+	msg_queue->empty_lat_buf.is_last_frame = true;
+
 	for (i = 0; i < NUM_BUFFER_COUNT; i++) {
 		lat_buf = &msg_queue->lat_buf[i];
 
@@ -342,6 +346,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 
 		lat_buf->ctx = ctx;
 		lat_buf->core_decode = core_decode;
+		lat_buf->is_last_frame = false;
 		err = vdec_msg_queue_qbuf(&msg_queue->lat_ctx, lat_buf);
 		if (err) {
 			mtk_v4l2_err("failed to qbuf buf[%d]", i);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index a21ee3aece5c..a80b9853cec9 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -57,6 +57,8 @@ struct vdec_msg_queue_ctx {
  * @core_decode: different codec use different decode callback function
  * @lat_list: add lat buffer to lat head list
  * @core_list: add lat buffer to core head list
+ *
+ * @is_last_frame: meaning this buffer is the last frame
  */
 struct vdec_lat_buf {
 	struct mtk_vcodec_mem wdma_err_addr;
@@ -69,6 +71,8 @@ struct vdec_lat_buf {
 	core_decode_cb_t core_decode;
 	struct list_head lat_list;
 	struct list_head core_list;
+
+	bool is_last_frame;
 };
 
 /**
@@ -83,6 +87,7 @@ struct vdec_lat_buf {
  *
  * @lat_list_cnt: used to record each instance lat list count
  * @core_list_cnt: used to record each instance core list count
+ * @empty_lat_buf: the last lat buf used to flush decode
  * @core_dec_done: core work queue decode done event
  * @status: current context decode status for core hardware
  */
@@ -99,6 +104,7 @@ struct vdec_msg_queue {
 
 	atomic_t lat_list_cnt;
 	atomic_t core_list_cnt;
+	struct vdec_lat_buf empty_lat_buf;
 	wait_queue_head_t core_dec_done;
 	int status;
 };
-- 
2.18.0

