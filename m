Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67D6B8BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCNH0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCNH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:26:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12DC74A72;
        Tue, 14 Mar 2023 00:26:10 -0700 (PDT)
X-UUID: 7ac013c6c23911eda06fc9ecc4dadd91-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0BSMzhQxV0HjibSsjHG5IXMuBDWYtIn/i372U14mmuQ=;
        b=L5fz/pItbq8eqOTJPwmfa0a4j7Pr7V0rOFdt1ryyWZkCtCk1RCIj5O6SY0ZOEgMf/ak//+jDRjBIEGnL1q1JQBsRmGTNpqfK3zMND0iY6GQqL67JmIXtz46P9slbmyUcGUlOEn0Ul01mA+FHigrGQIi600WxAlrieXeJ7r/X6Rs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:2e37b784-acc2-412e-8397-bdb7ef68ade7,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:25b5999,CLOUDID:20a3bcf5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 7ac013c6c23911eda06fc9ecc4dadd91-20230314
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1904697292; Tue, 14 Mar 2023 15:26:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 15:25:59 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 15:25:59 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
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
Subject: [PATCH v3] media: mediatek: vcodec: Force capture queue format to MM21
Date:   Tue, 14 Mar 2023 15:25:57 +0800
Message-ID: <20230314072557.29669-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Libyuv is one software library used to covert format. Only covert
mediatek uncompressed mode MM21 to standard yuv420 for MT21 is
compressed mode. Need to set capture queue format to MM21 in order
to use Libyuv when scp firmware support MM21 and MT21.

Fixes: 7501edef6b1f ("media: mediatek: vcodec: Different codec using different capture format")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
changed with v2:
- re-write commit message.
- change the driver flow.
changed with v1:
- add Fixes tag.
---
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 24 +++----------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 641f533c417f..c99705681a03 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -39,10 +39,9 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
 {
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 	const struct mtk_video_fmt *fmt;
-	struct mtk_q_data *q_data;
 	int num_frame_count = 0, i;
-	bool ret = true;
 
+	fmt = &dec_pdata->vdec_formats[format_index];
 	for (i = 0; i < *dec_pdata->num_formats; i++) {
 		if (dec_pdata->vdec_formats[i].type != MTK_FMT_FRAME)
 			continue;
@@ -50,27 +49,10 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
 		num_frame_count++;
 	}
 
-	if (num_frame_count == 1)
+	if (num_frame_count == 1 || fmt->fourcc == V4L2_PIX_FMT_MM21)
 		return true;
 
-	fmt = &dec_pdata->vdec_formats[format_index];
-	q_data = &ctx->q_data[MTK_Q_DATA_SRC];
-	switch (q_data->fmt->fourcc) {
-	case V4L2_PIX_FMT_VP8_FRAME:
-		if (fmt->fourcc == V4L2_PIX_FMT_MM21)
-			ret = true;
-		break;
-	case V4L2_PIX_FMT_H264_SLICE:
-	case V4L2_PIX_FMT_VP9_FRAME:
-		if (fmt->fourcc == V4L2_PIX_FMT_MM21)
-			ret = false;
-		break;
-	default:
-		ret = true;
-		break;
-	}
-
-	return ret;
+	return false;
 }
 
 static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_ctx *ctx,
-- 
2.25.1

