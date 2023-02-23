Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E66A0398
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjBWINm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjBWIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:13:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4D498B0;
        Thu, 23 Feb 2023 00:13:25 -0800 (PST)
X-UUID: ee7e07d8b35111eda06fc9ecc4dadd91-20230223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9r+WM7v+v+aqqXYNQiSrE5n+ZdQz4RMsB1qmBc64lKc=;
        b=ChraeNE4TzN/puh2uv+/XmMBZN2w/EBZrV5r4s0hZ5qAuSxWbsrhJjkgCeC6NMp4i7igoBRNcZNYI1a0KZuz+DtdJzVQV5/kLhEg0xnffH1AJ9kld4gVb4owEb7KHfqExYnt8fYH5+AmeALYoBfeVD4guwT7mAp6X3Z2uCjHEKo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:4d03de18-5c64-4e89-a81e-003b5a1be404,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:25b5999,CLOUDID:a30159b1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: ee7e07d8b35111eda06fc9ecc4dadd91-20230223
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 393979555; Thu, 23 Feb 2023 16:13:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 23 Feb 2023 16:13:17 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 23 Feb 2023 16:13:17 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Subject: [V1,3/7] media: mtk-jpeg: Fixes jpeg enc&dec worker sw flow
Date:   Thu, 23 Feb 2023 16:13:08 +0800
Message-ID: <20230223081312.29296-4-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223081312.29296-1-irui.wang@mediatek.com>
References: <20230223081312.29296-1-irui.wang@mediatek.com>
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

From: kyrie wu <kyrie.wu@mediatek.com>

1. Move removing buffer after sw setting and before hw setting
in enc&dec worker to prevents the operation of removing
the buffer twice if the sw setting fails.
2. Remove the redundant operation of queue work in the
jpegenc irq handler because the jpegenc worker has called
v4l2_m2m_job_finish to do it.

Fixes: 5fb1c2361e56 ("mtk-jpegenc: add jpeg encode worker interface")
Fixes: dedc21500334 ("media: mtk-jpegdec: add jpeg decode worker interface")

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   | 14 +++++++-------
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |  4 ----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index daa4a6448311..d940dc5ede74 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1025,9 +1025,6 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 	if (!dst_buf)
 		goto getbuf_fail;
 
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 
 	mtk_jpegenc_set_hw_param(ctx, hw_id, src_buf, dst_buf);
@@ -1045,6 +1042,9 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 		goto enc_end;
 	}
 
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
 	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
 			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
 
@@ -1220,9 +1220,6 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	if (!dst_buf)
 		goto getbuf_fail;
 
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
 	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
@@ -1231,7 +1228,7 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 					     &jpeg_src_buf->dec_param)) {
 		mtk_jpeg_queue_src_chg_event(ctx);
 		ctx->state = MTK_JPEG_SOURCE_CHANGE;
-		goto dec_end;
+		goto getbuf_fail;
 	}
 
 	jpeg_src_buf->curr_ctx = ctx;
@@ -1254,6 +1251,9 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 		goto clk_end;
 	}
 
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
 	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
 			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
 
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 1bbb712d78d0..867f4c1a09fa 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -286,10 +286,6 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 	mtk_jpegenc_put_buf(jpeg);
 	pm_runtime_put(ctx->jpeg->dev);
 	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
-	if (!list_empty(&ctx->fh.m2m_ctx->out_q_ctx.rdy_queue) ||
-	    !list_empty(&ctx->fh.m2m_ctx->cap_q_ctx.rdy_queue)) {
-		queue_work(master_jpeg->workqueue, &ctx->jpeg_work);
-	}
 
 	jpeg->hw_state = MTK_JPEG_HW_IDLE;
 	wake_up(&master_jpeg->enc_hw_wq);
-- 
2.18.0

