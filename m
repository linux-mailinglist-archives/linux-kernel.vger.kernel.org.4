Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8CC62689E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiKLJmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiKLJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:42:03 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E551D309;
        Sat, 12 Nov 2022 01:41:58 -0800 (PST)
X-UUID: 328651832b854ac39f2746aa4b2e0d08-20221112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fqUwc0KfzE+JLt+0m8FqWIvXx2dWICjp0wZ8oKRmkCA=;
        b=ioDcLLHk3+YFVlti36YL8oNMhG2mVyaX26b3kxI7ffZfYiLVrw8HYKRoFF0TZ9GLVq2qrWHH5V7jjPHU1MpWII6JwzZntHL7dQQWaSG402QulDgFSfzxE2LU1yL505+TMiMSsC6txUw3JtT3AuV9NfkBryEmasWckCGNWJKNavY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:822c2c42-52db-4a12-a4aa-4fc74b8c5d7c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.12,REQID:822c2c42-52db-4a12-a4aa-4fc74b8c5d7c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:62cd327,CLOUDID:05ff5a5d-100c-4555-952b-a62c895efded,B
        ulkID:221112174153PU5PVGYW,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 328651832b854ac39f2746aa4b2e0d08-20221112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 472636858; Sat, 12 Nov 2022 17:41:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 12 Nov 2022 17:41:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 12 Nov 2022 17:41:48 +0800
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
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 3/5] media: mediatek: vcodec: Fix h264 set lat buffer error
Date:   Sat, 12 Nov 2022 17:41:42 +0800
Message-ID: <20221112094144.4256-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221112094144.4256-1-yunfei.dong@mediatek.com>
References: <20221112094144.4256-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will set lat buffer to lat_list two times when lat decode timeout for
inner racing mode.

If core thread can't get frame buffer, need to return error value.

Fixes: 59fba9eed5a7 ("media: mediatek: vcodec: support stateless H.264 decoding for mt8192")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/vdec/vdec_h264_req_multi_if.c      | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 4cc92700692b..2b7576265f48 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -471,6 +471,12 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
 	       sizeof(share_info->h264_slice_params));
 
 	fb = ctx->dev->vdec_pdata->get_cap_buffer(ctx);
+	if (!fb) {
+		err = -EBUSY;
+		mtk_vcodec_err(inst, "fb buffer is NULL");
+		goto vdec_dec_end;
+	}
+
 	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
 	vdec_fb_va = (unsigned long)fb;
 
@@ -630,7 +636,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	err = vpu_dec_start(vpu, data, 2);
 	if (err) {
 		mtk_vcodec_debug(inst, "lat decode err: %d", err);
-		goto err_scp_decode;
+		goto err_free_fb_out;
 	}
 
 	share_info->trans_end = inst->ctx->msg_queue.wdma_addr.dma_addr +
@@ -647,12 +653,17 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	/* wait decoder done interrupt */
 	timeout = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
 					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
+	if (timeout)
+		mtk_vcodec_err(inst, "lat decode timeout: pic_%d", inst->slice_dec_num);
 	inst->vsi->dec.timeout = !!timeout;
 
 	err = vpu_dec_end(vpu);
-	if (err == SLICE_HEADER_FULL || timeout || err == TRANS_BUFFER_FULL) {
-		err = -EINVAL;
-		goto err_scp_decode;
+	if (err == SLICE_HEADER_FULL || err == TRANS_BUFFER_FULL) {
+		if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability))
+			vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
+		inst->slice_dec_num++;
+		mtk_vcodec_err(inst, "lat dec fail: pic_%d err:%d", inst->slice_dec_num, err);
+		return -EINVAL;
 	}
 
 	share_info->trans_end = inst->ctx->msg_queue.wdma_addr.dma_addr +
@@ -669,10 +680,6 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 	inst->slice_dec_num++;
 	return 0;
-
-err_scp_decode:
-	if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability))
-		vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
 err_free_fb_out:
 	vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
 	mtk_vcodec_err(inst, "slice dec number: %d err: %d", inst->slice_dec_num, err);
-- 
2.18.0

