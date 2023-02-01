Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4A6860B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjBAHdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjBAHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:33:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5468A41;
        Tue, 31 Jan 2023 23:33:31 -0800 (PST)
X-UUID: b82fd7a2a20211eda06fc9ecc4dadd91-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GdM+CxNswjU0Sm0RCB0Us5l9zdkJ+nj/JYBJ+VUqKrY=;
        b=Yd8XgR4VMExwZyTPWSlxDeUiYxP1TPfv4YHoEKHPpJvZPGsqfu8pW08nN5DQevgwgvfyv86LGPdJYCn2AHcZmx0HL86bs9AjLeSTUekkPfGc5aIpZFGenTLDKGlCp9XN/CKRPMaReiowMrC3ce9Wcf70JwaMrymiTCynoHjblXc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:84f7041a-0b6d-4bea-8c14-d11c498fa6ed,IP:0,U
        RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-55
X-CID-META: VersionHash:3ca2d6b,CLOUDID:cfa51ef7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: b82fd7a2a20211eda06fc9ecc4dadd91-20230201
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1216760531; Wed, 01 Feb 2023 15:33:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 15:33:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 15:33:25 +0800
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
Subject: [PATCH v4,7/7] media: mediatek: vcodec: change lat thread decode error condition
Date:   Wed, 1 Feb 2023 15:33:16 +0800
Message-ID: <20230201073316.27923-8-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201073316.27923-1-yunfei.dong@mediatek.com>
References: <20230201073316.27923-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If lat thread can't get lat buffer, it should be that current instance
don't be schedulded, the driver can't free the src buffer directly.

Fixes: 7b182b8d9c85 ("media: mediatek: vcodec: Refactor get and put capture buffer flow")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c     | 6 ++++--
 .../platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c  | 2 +-
 .../platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c     | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index ffbcee04dc26..04beb3f08eea 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -258,8 +258,10 @@ static void mtk_vdec_worker(struct work_struct *work)
 		if (src_buf_req)
 			v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);
 	} else {
-		v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
-		v4l2_m2m_buf_done(vb2_v4l2_src, state);
+		if (ret != -EAGAIN) {
+			v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
+			v4l2_m2m_buf_done(vb2_v4l2_src, state);
+		}
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
 	}
 }
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 8f262e86bb05..07774b6a3dbd 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -574,7 +574,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	lat_buf = vdec_msg_queue_dqbuf(&inst->ctx->msg_queue.lat_ctx);
 	if (!lat_buf) {
 		mtk_vcodec_err(inst, "failed to get lat buffer");
-		return -EINVAL;
+		return -EAGAIN;
 	}
 	share_info = lat_buf->private_data;
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index cbb6728b8a40..cf16cf2807f0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -2070,7 +2070,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	lat_buf = vdec_msg_queue_dqbuf(&instance->ctx->msg_queue.lat_ctx);
 	if (!lat_buf) {
 		mtk_vcodec_err(instance, "Failed to get VP9 lat buf\n");
-		return -EBUSY;
+		return -EAGAIN;
 	}
 	pfc = (struct vdec_vp9_slice_pfc *)lat_buf->private_data;
 	if (!pfc) {
-- 
2.18.0

