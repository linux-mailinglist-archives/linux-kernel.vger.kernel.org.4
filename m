Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952E368BC55
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjBFMHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBFMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:07:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3D16320;
        Mon,  6 Feb 2023 04:07:21 -0800 (PST)
X-UUID: cb95d5c2a61611ed945fc101203acc17-20230206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2pQGKOjFD0EPNmzhVI3is/MPjDoOLrtnUT5IvptZW2g=;
        b=KwCB2xvoPlyEO8zcGeJa1fGnz1hosiJgDC1ZdUwVjU86lMdbW/G5RLCeRVgpejDmdKXc49O7bCUWH8BAIeXTB5ZLDt//k2i0aiC7MygsLDxim1JLIh3hoEgUv0yHGC/mk+aKm6MgV0ujb5xEy8C2Rv/iN9skiCj0BmFZ4LyBUGM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:ea7d3391-6695-4b14-bab0-d8cac65ab097,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:92647356-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: cb95d5c2a61611ed945fc101203acc17-20230206
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1315678384; Mon, 06 Feb 2023 20:07:15 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 6 Feb 2023 20:07:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 6 Feb 2023 20:07:13 +0800
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
Subject: [PATCH 4/6] media: mediatek: vcodec: Get get each instance format type
Date:   Mon, 6 Feb 2023 20:07:06 +0800
Message-ID: <20230206120708.19631-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206120708.19631-1-yunfei.dong@mediatek.com>
References: <20230206120708.19631-1-yunfei.dong@mediatek.com>
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
2.18.0

