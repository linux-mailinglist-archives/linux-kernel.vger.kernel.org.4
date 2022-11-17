Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6F62D6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbiKQJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiKQJZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:25:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD73B1C3;
        Thu, 17 Nov 2022 01:25:08 -0800 (PST)
X-UUID: 2d86bf5b79cd451790e0a8fcc531def9-20221117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ztddfO3HpzzX7jMv99ap2IqMNrkjflAF85r48IEZWKU=;
        b=sPaIxISqZE9f7omtmM/9wDwL5S8algZJxoK8GKbEG2AOmDzlviQX+r+yu9t2BlQeTK9ABYO6X8dfjV0RY4aUY4OknLUnGZ/XDG/NJZTjKPEBvxFEs4NxjWNuwELlMyI6x9/j9ZP6TEKy0eDMXVuS5B74OY7whvnHqj072Jtp5Pw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0653e927-1962-4356-a135-6084b0a425ff,IP:0,U
        RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-META: VersionHash:62cd327,CLOUDID:9ef976db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2d86bf5b79cd451790e0a8fcc531def9-20221117
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2029179431; Thu, 17 Nov 2022 17:25:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 17 Nov 2022 17:25:00 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 17 Nov 2022 17:24:59 +0800
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
Subject: [PATCH v2,4/5] media: mediatek: vcodec: Setting lat buf to lat_list when lat decode error
Date:   Thu, 17 Nov 2022 17:24:52 +0800
Message-ID: <20221117092453.31366-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117092453.31366-1-yunfei.dong@mediatek.com>
References: <20221117092453.31366-1-yunfei.dong@mediatek.com>
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

Need to set lat buf to lat_list when lat decode error, or lat buffer will lost.

Fixes: 5d418351ca8f ("media: mediatek: vcodec: support stateless VP9 decoding")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c    | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index fb1c36a3592d..cbb6728b8a40 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -2073,21 +2073,23 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		return -EBUSY;
 	}
 	pfc = (struct vdec_vp9_slice_pfc *)lat_buf->private_data;
-	if (!pfc)
-		return -EINVAL;
+	if (!pfc) {
+		ret = -EINVAL;
+		goto err_free_fb_out;
+	}
 	vsi = &pfc->vsi;
 
 	ret = vdec_vp9_slice_setup_lat(instance, bs, lat_buf, pfc);
 	if (ret) {
 		mtk_vcodec_err(instance, "Failed to setup VP9 lat ret %d\n", ret);
-		return ret;
+		goto err_free_fb_out;
 	}
 	vdec_vp9_slice_vsi_to_remote(vsi, instance->vsi);
 
 	ret = vpu_dec_start(&instance->vpu, NULL, 0);
 	if (ret) {
 		mtk_vcodec_err(instance, "Failed to dec VP9 ret %d\n", ret);
-		return ret;
+		goto err_free_fb_out;
 	}
 
 	if (instance->irq) {
@@ -2107,7 +2109,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	/* LAT trans full, no more UBE or decode timeout */
 	if (ret) {
 		mtk_vcodec_err(instance, "VP9 decode error: %d\n", ret);
-		return ret;
+		goto err_free_fb_out;
 	}
 
 	mtk_vcodec_debug(instance, "lat dma addr: 0x%lx 0x%lx\n",
@@ -2120,6 +2122,9 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
 
 	return 0;
+err_free_fb_out:
+	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
+	return ret;
 }
 
 static int vdec_vp9_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
-- 
2.18.0

