Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF77710271
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjEYBka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbjEYBk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:40:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150B12E;
        Wed, 24 May 2023 18:40:21 -0700 (PDT)
X-UUID: 1868c2d0fa9d11ed9cb5633481061a41-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/AfKK7NqAn+9gPaT219tJWBpfwQIuYiB+SbN33piwzw=;
        b=Tw63SgtORquHKh5YZU6yp3r8NJr2xrtWl74gKn6WiEpslYzyuAVs1UR0EFBOeTkjUTOK2EKXHZRNTfG2SKEKXrAg7AksJJMj37YzXjUVjeAj18VQwf/jSSAz9EE3rr/Uqe8cydboJl003iUPD4Ny0KArwLggLvJO+pV+UQjhTjg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:a2c8900c-e185-4cb0-b9c6-52bc2aa5d1b5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.25,REQID:a2c8900c-e185-4cb0-b9c6-52bc2aa5d1b5,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:d5b0ae3,CLOUDID:0ee9453c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230525094016CHIOCULO,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1868c2d0fa9d11ed9cb5633481061a41-20230525
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 914826137; Thu, 25 May 2023 09:40:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 09:40:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 09:40:11 +0800
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
Subject: [PATCH v4,1/4] media: mediatek: vcodec: Avoid unneeded error logging
Date:   Thu, 25 May 2023 09:40:06 +0800
Message-ID: <20230525014009.23345-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525014009.23345-1-yunfei.dong@mediatek.com>
References: <20230525014009.23345-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the LAT decoder works faster than its CORE, getting the trans
buffer may be done only after CORE finishes processing: avoid printing
an error if the decode function returns -EAGAIN, as this means that
the buffer from CORE is not yet available, but will be at a later time.

Also change the log level for calls to vdec_msg_queue_dqbuf() in H264
and VP9 LAT decoder drivers to avoid excessive logging.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c   | 2 +-
 .../platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c      | 2 +-
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index 995997f702a0..7b3eb0ccb522 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -292,7 +292,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 		mtk_v4l2_err("vb2 buffer media request is NULL");
 
 	ret = vdec_if_decode(ctx, bs_src, NULL, &res_chg);
-	if (ret) {
+	if (ret && ret != -EAGAIN) {
 		mtk_v4l2_err(" <===[%d], src_buf[%d] sz=0x%zx pts=%llu vdec_if_decode() ret=%d res_chg=%d===>",
 			     ctx->id, vb2_src->index, bs_src->size,
 			     vb2_src->timestamp, ret, res_chg);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 999ce7ee5fdc..181cc52e0847 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -596,7 +596,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 	lat_buf = vdec_msg_queue_dqbuf(&inst->ctx->msg_queue.lat_ctx);
 	if (!lat_buf) {
-		mtk_vcodec_err(inst, "failed to get lat buffer");
+		mtk_vcodec_debug(inst, "failed to get lat buffer");
 		return -EAGAIN;
 	}
 	share_info = lat_buf->private_data;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index cf16cf2807f0..6d981d7341d2 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -2069,7 +2069,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 	lat_buf = vdec_msg_queue_dqbuf(&instance->ctx->msg_queue.lat_ctx);
 	if (!lat_buf) {
-		mtk_vcodec_err(instance, "Failed to get VP9 lat buf\n");
+		mtk_vcodec_debug(instance, "Failed to get VP9 lat buf\n");
 		return -EAGAIN;
 	}
 	pfc = (struct vdec_vp9_slice_pfc *)lat_buf->private_data;
-- 
2.18.0

