Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1EF6C0ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCTK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCTK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:28:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963EC18A92;
        Mon, 20 Mar 2023 03:28:49 -0700 (PDT)
X-UUID: fe593e9ac70911ed91027fb02e0f1d65-20230320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VzgHvxX4suLNdf1qFV/p7L0tXMGHaTG14SSEJaLhH+8=;
        b=YKa8+AbYqJJlmfnu6lWW0bhYbKGMLn3vzZ5loPq1ZgljmxKKV1p+0l2X5WtNXk1rHyaXlAXdSxIXk0cN1jWkDnzhLUt7lUGOa5Nv8sZrM113o6zxbKG1IdiBWFPuPo02zkv/iPCOLfPiXjvhupIipl6jdX5J7dSF67tMMKD6WkA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:6c011eb0-f6d7-413d-9443-3693d4471c45,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:c42056f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: fe593e9ac70911ed91027fb02e0f1d65-20230320
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1984304081; Mon, 20 Mar 2023 18:28:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 20 Mar 2023 18:28:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 18:28:43 +0800
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
Subject: [PATCH 4/6 RESEND] media: mediatek: vcodec: Get get each instance format type
Date:   Mon, 20 Mar 2023 18:28:36 +0800
Message-ID: <20230320102838.8313-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320102838.8313-1-yunfei.dong@mediatek.com>
References: <20230320102838.8313-1-yunfei.dong@mediatek.com>
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

Adding echo command to get capture and output queue format type:
'echo -format > vdec'

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 9e7d57d21cea..8a03f986a857 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -10,6 +10,34 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_util.h"
 
+static void mtk_vdec_dbgfs_get_format_type(int output, int capture)
+{
+	switch (output) {
+	case V4L2_PIX_FMT_H264_SLICE:
+		pr_info("output format: h264 slice\n");
+		break;
+	case V4L2_PIX_FMT_VP8_FRAME:
+		pr_info("output format: vp8 slice\n");
+		break;
+	case V4L2_PIX_FMT_VP9_FRAME:
+		pr_info("output format: vp9 slice\n");
+		break;
+	default:
+		pr_info("unsupported output format: 0x%x\n", output);
+	}
+
+	switch (capture) {
+	case V4L2_PIX_FMT_MM21:
+		pr_info("capture format MM21\n");
+		break;
+	case V4L2_PIX_FMT_MT21C:
+		pr_info("capture format MT21C\n");
+		break;
+	default:
+		pr_info("unsupported capture format: 0x%x\n", capture);
+	}
+}
+
 static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 				    size_t count, loff_t *ppos)
 {
@@ -33,11 +61,17 @@ static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 				ctx->picinfo.pic_w, ctx->picinfo.pic_h,
 				ctx->picinfo.buf_w, ctx->picinfo.buf_h);
 		}
+
+		if (strstr(buf, "-format")) {
+			str_count++;
+			mtk_vdec_dbgfs_get_format_type(ctx->current_codec, ctx->capture_fourcc);
+		}
 	}
 
 	if (!str_count) {
 		pr_info("\t can not found useful cmd: %s\n", buf);
 		pr_info("\t -picinfo	     ex. echo -picinfo\n");
+		pr_info("\t -format	     ex. echo -format\n");
 	}
 
 	return count;
-- 
2.25.1

