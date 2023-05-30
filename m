Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565E4715F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjE3MaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjE3M3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:29:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162AE19F;
        Tue, 30 May 2023 05:29:38 -0700 (PDT)
X-UUID: 97ba70dcfee511ed9cb5633481061a41-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dxyJlVhmmzrGcYulhQ457VG6kkrioCdG10OgAjNkjXw=;
        b=ZHUKFFKpyv4NhtFEtroWlylsL4BolvQPDVWPLo0UdSMrgo8aMo+mWwITk9HyjglkWVde4wEEwQ7irIHngmIXXd3iZTju4PNUA4uUoGqq2qRbpcSPrTOAY+SDAIV+vV2fPtbsxGS7Dq0BypRJWKhOgrrzDPLKuQti35UuwXTWnGk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:b96b591f-f08e-45d6-9c09-8fbc9b8b8db8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:55ae023d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 97ba70dcfee511ed9cb5633481061a41-20230530
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1102217493; Tue, 30 May 2023 20:29:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 20:29:15 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 20:29:14 +0800
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
Subject: [PATCH v6,5/8] media: mediatek: vcodec: Get each instance format type
Date:   Tue, 30 May 2023 20:29:05 +0800
Message-ID: <20230530122908.19267-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530122908.19267-1-yunfei.dong@mediatek.com>
References: <20230530122908.19267-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding echo command to get capture and output queue format
type of each instance:"echo '-format' > vdec", not current
hardware supported.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 48 +++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 5b6bd4c4de3b..09ca5dc2c22a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -10,6 +10,48 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_util.h"
 
+static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_ctx *ctx, char *buf,
+					   int *used, int total)
+{
+	int curr_len;
+
+	switch (ctx->current_codec) {
+	case V4L2_PIX_FMT_H264_SLICE:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\toutput format: h264 slice\n");
+		break;
+	case V4L2_PIX_FMT_VP8_FRAME:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\toutput format: vp8 slice\n");
+		break;
+	case V4L2_PIX_FMT_VP9_FRAME:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\toutput format: vp9 slice\n");
+		break;
+	default:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\tunsupported output format: 0x%x\n",
+				    ctx->current_codec);
+	}
+	*used += curr_len;
+
+	switch (ctx->capture_fourcc) {
+	case V4L2_PIX_FMT_MM21:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\tcapture format: MM21\n");
+		break;
+	case V4L2_PIX_FMT_MT21C:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\tcapture format: MT21C\n");
+		break;
+	default:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\tunsupported capture format: 0x%x\n",
+				    ctx->capture_fourcc);
+	}
+	*used += curr_len;
+}
+
 static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 				    size_t count, loff_t *ppos)
 {
@@ -44,6 +86,9 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 	if (strstr(dbgfs->dbgfs_buf, "-picinfo"))
 		dbgfs_index[MTK_VDEC_DBGFS_PICINFO] = true;
 
+	if (strstr(dbgfs->dbgfs_buf, "-format"))
+		dbgfs_index[MTK_VDEC_DBGFS_FORMAT] = true;
+
 	mutex_lock(&dbgfs->dbgfs_lock);
 	list_for_each_entry(dbgfs_inst, &dbgfs->dbgfs_head, node) {
 		ctx = dbgfs_inst->vcodec_ctx;
@@ -59,6 +104,9 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 					    ctx->picinfo.buf_w, ctx->picinfo.buf_h);
 			used_len += curr_len;
 		}
+
+		if (dbgfs_index[MTK_VDEC_DBGFS_FORMAT])
+			mtk_vdec_dbgfs_get_format_type(ctx, buf, &used_len, total_len);
 	}
 	mutex_unlock(&dbgfs->dbgfs_lock);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index 30d956b7227f..6fcb20cfcd91 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -15,6 +15,7 @@ struct mtk_vcodec_ctx;
  */
 enum mtk_vdec_dbgfs_log_index {
 	MTK_VDEC_DBGFS_PICINFO,
+	MTK_VDEC_DBGFS_FORMAT,
 	MTK_VDEC_DBGFS_MAX,
 };
 
-- 
2.18.0

