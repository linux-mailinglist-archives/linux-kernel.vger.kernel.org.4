Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE876C9B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjC0FyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjC0Fxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:53:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2B40FF;
        Sun, 26 Mar 2023 22:53:38 -0700 (PDT)
X-UUID: b5eb0d78cc6311eda9a90f0bb45854f4-20230327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=q8ATRrZDWQhSXGH4D6vY9Ng33CB7nwHAIklZzu5PsGk=;
        b=EvwzMXf8ncJCHQ2B0ubWFF1+3yJh6NozLQZuO8VeDD7KDj2Xo1NnVS+jfts4yMqs+OiqU179F6VOBgsmVSxj6NPBV3xWjqvnseUh4u0YWQ0G06mixpRwca+N3YC1e6y+f1RbZgujBfF2SmIQa6BWu+SFtxRJcodVUpHm0462HTM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:be24c65d-6127-4a16-927d-f18c87bb5934,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.22,REQID:be24c65d-6127-4a16-927d-f18c87bb5934,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:120426c,CLOUDID:2ea075b4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230327135334ZANJ9IMP,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b5eb0d78cc6311eda9a90f0bb45854f4-20230327
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1757893028; Mon, 27 Mar 2023 13:53:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 27 Mar 2023 13:53:33 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Mar 2023 13:53:32 +0800
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
Subject: [PATCH v3,5/7] media: mediatek: vcodec: Get each instance format type
Date:   Mon, 27 Mar 2023 13:53:13 +0800
Message-ID: <20230327055315.13936-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327055315.13936-1-yunfei.dong@mediatek.com>
References: <20230327055315.13936-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding echo command to get capture and output queue format
type of each instance:"echo '-format' > vdec", not current
hardware supported.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
- this patch used to get each instance output and capture queue format type, not supported format type
---
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 48 +++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 19a1dc068efd..1b1b4301a83d 100644
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
+				    "\tcapture format MM21\n");
+		break;
+	case V4L2_PIX_FMT_MT21C:
+		curr_len = snprintf(buf + *used, total - *used,
+				    "\tcapture format MT21C\n");
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
@@ -45,6 +87,9 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 	if (strstr(dbgfs->dbgfs_buf, "-picinfo"))
 		dbgfs_index[MTK_VDEC_DBGFS_PICINFO] = true;
 
+	if (strstr(dbgfs->dbgfs_buf, "-format"))
+		dbgfs_index[MTK_VDEC_DBGFS_FORMAT] = true;
+
 	mutex_lock(&dbgfs->dbgfs_lock);
 	list_for_each_entry(dbgfs_inst, &dbgfs->dbgfs_head, node) {
 		ctx = dbgfs_inst->vcodec_ctx;
@@ -60,6 +105,9 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 					    ctx->picinfo.buf_w, ctx->picinfo.buf_h);
 			used_len += curr_len;
 		}
+
+		if (dbgfs_index[MTK_VDEC_DBGFS_FORMAT])
+			mtk_vdec_dbgfs_get_format_type(ctx, buf, &used_len, total_len);
 	}
 	mutex_unlock(&dbgfs->dbgfs_lock);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index da61b2dffe29..b0bdb84a46df 100644
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

