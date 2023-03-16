Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD846BC93E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCPIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCPIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:34:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108110A;
        Thu, 16 Mar 2023 01:34:47 -0700 (PDT)
X-UUID: 468ee8e8c3d311ed91027fb02e0f1d65-20230316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Y/l9E1Q7qL2RV7CeynDNIrYPiyMMqFFu5pxGWD9dx9c=;
        b=WXWUlLJEKvl04q9mGCng01wCutlR4B7i+MkK2sIYhyIOvFKFlhqT+jZAojxSl+oXw0NzOc+e2S+qnv8j0l9B+7t+oqlZZevWL0i9n1zwWQnZUGSG5gB/7TGeU4WqNk/dJ+5jy3fiyLt2S3Xr9TyRkKxjP4wuvD95P0o9pGL4hVE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:4b7b3e52-a946-4219-a66e-18a230635a02,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:83295aa,CLOUDID:352efdf5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 468ee8e8c3d311ed91027fb02e0f1d65-20230316
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1421684787; Thu, 16 Mar 2023 16:19:30 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 16 Mar 2023 16:19:29 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 16 Mar 2023 16:19:28 +0800
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
Subject: [V1] media: mtk-jpeg: fixes use standard huffman table issue
Date:   Thu, 16 Mar 2023 16:19:25 +0800
Message-ID: <20230316081925.10247-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

if no found huffman table in file, hw use standard table

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
This patch dependents on:
https://patchwork.linuxtv.org/project/linux-media/cover/20230310062355.9963-1-irui.wang@mediatek.com/
---
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |  9 ++
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |  1 +
 .../mediatek/jpeg/mtk_jpeg_dec_parse.c        | 97 +++++++++++--------
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |  2 +
 4 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 869068fac5e2..62119ef959dc 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -378,6 +378,14 @@ static void mtk_jpeg_dec_set_q_table(void __iomem *base, u32 id0, u32 id1,
 	writel(val, base + JPGDEC_REG_QT_ID);
 }
 
+static void mtk_jpeg_dec_set_huffman_mode(void __iomem *base, u8 huffman_tb_exist)
+{
+	if (!huffman_tb_exist) {
+		writel(0x1, base + JPGDEC_REG_ST_HUFFMAN_EN);
+		writel(0x0, base + JPGDEC_REG_BUILD_HUFF_INDEX);
+	}
+}
+
 static void mtk_jpeg_dec_set_dma_group(void __iomem *base, u32 mcu_group,
 				       u32 group_num, u32 last_mcu)
 {
@@ -423,6 +431,7 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
 				 cfg->comp_id[2]);
 	mtk_jpeg_dec_set_q_table(base, cfg->qtbl_num[0],
 				 cfg->qtbl_num[1], cfg->qtbl_num[2]);
+	mtk_jpeg_dec_set_huffman_mode(base, cfg->huffman_tb_exist);
 	mtk_jpeg_dec_set_sampling_factor(base, cfg->comp_num,
 					 cfg->sampling_w[0],
 					 cfg->sampling_h[0],
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
index 8c31c6b12417..660df1bee463 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
@@ -54,6 +54,7 @@ struct mtk_jpeg_dec_param {
 	u32 uv_size;
 	u32 dec_size;
 	u8 uv_brz_w;
+	u8 huffman_tb_exist;
 };
 
 struct mtk_jpeg_bs {
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c
index b95c45791c29..d0f7a87b3e4b 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c
@@ -12,6 +12,7 @@
 
 #define TEM	0x01
 #define SOF0	0xc0
+#define DHT	0xc4
 #define RST	0xd0
 #define SOI	0xd8
 #define EOI	0xd9
@@ -54,17 +55,65 @@ static void read_skip(struct mtk_jpeg_stream *stream, long len)
 		read_byte(stream);
 }
 
+static bool parse_header(struct mtk_jpeg_stream *stream,
+			 struct mtk_jpeg_dec_param *param)
+{
+	int i, byte;
+	u32 word;
+
+	/* length */
+	if (read_word_be(stream, &word))
+		goto parse_end;
+
+	/* precision */
+	if (read_byte(stream) == -1)
+		goto parse_end;
+
+	if (read_word_be(stream, &word))
+		goto parse_end;
+	param->pic_h = word;
+
+	if (read_word_be(stream, &word))
+		goto parse_end;
+	param->pic_w = word;
+
+	param->comp_num = read_byte(stream);
+	if (param->comp_num != 1 && param->comp_num != 3)
+		goto parse_end;
+
+	for (i = 0; i < param->comp_num; i++) {
+		param->comp_id[i] = read_byte(stream);
+		if (param->comp_id[i] == -1)
+			break;
+
+		/* sampling */
+		byte = read_byte(stream);
+		if (byte == -1)
+			break;
+		param->sampling_w[i] = (byte >> 4) & 0x0F;
+		param->sampling_h[i] = byte & 0x0F;
+
+		param->qtbl_num[i] = read_byte(stream);
+		if (param->qtbl_num[i] == -1)
+			break;
+	}
+
+parse_end:
+	return !(i == param->comp_num);
+}
+
 static bool mtk_jpeg_do_parse(struct mtk_jpeg_dec_param *param, u8 *src_addr_va,
 			      u32 src_size)
 {
 	bool notfound = true;
+	bool file_end = false;
 	struct mtk_jpeg_stream stream;
 
 	stream.addr = src_addr_va;
 	stream.size = src_size;
 	stream.curr = 0;
 
-	while (notfound) {
+	while (!file_end && (!param->huffman_tb_exist || notfound)) {
 		int i, length, byte;
 		u32 word;
 
@@ -84,50 +133,18 @@ static bool mtk_jpeg_do_parse(struct mtk_jpeg_dec_param *param, u8 *src_addr_va,
 		length = 0;
 		switch (byte) {
 		case SOF0:
-			/* length */
-			if (read_word_be(&stream, &word))
-				break;
-
-			/* precision */
-			if (read_byte(&stream) == -1)
-				break;
-
-			if (read_word_be(&stream, &word))
-				break;
-			param->pic_h = word;
-
-			if (read_word_be(&stream, &word))
-				break;
-			param->pic_w = word;
-
-			param->comp_num = read_byte(&stream);
-			if (param->comp_num != 1 && param->comp_num != 3)
-				break;
-
-			for (i = 0; i < param->comp_num; i++) {
-				param->comp_id[i] = read_byte(&stream);
-				if (param->comp_id[i] == -1)
-					break;
-
-				/* sampling */
-				byte = read_byte(&stream);
-				if (byte == -1)
-					break;
-				param->sampling_w[i] = (byte >> 4) & 0x0F;
-				param->sampling_h[i] = byte & 0x0F;
-
-				param->qtbl_num[i] = read_byte(&stream);
-				if (param->qtbl_num[i] == -1)
-					break;
-			}
-
-			notfound = !(i == param->comp_num);
+			notfound = parse_header(&stream, param);
 			break;
 		case RST ... RST + 7:
 		case SOI:
-		case EOI:
 		case TEM:
 			break;
+		case EOI:
+			file_end = true;
+			break;
+		case DHT:
+			param->huffman_tb_exist = 1;
+			break;
 		default:
 			if (read_word_be(&stream, &word))
 				break;
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
index 27b7711ca341..b5ae4d9fe0a8 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
@@ -45,6 +45,8 @@
 #define JPGDEC_REG_QT_ID		0x0270
 #define JPGDEC_REG_INTERRUPT_STATUS	0x0274
 #define JPGDEC_REG_STATUS		0x0278
+#define JPGDEC_REG_ST_HUFFMAN_EN	0x320
+#define JPGDEC_REG_BUILD_HUFF_INDEX	0x330
 #define JPGDEC_REG_BIT_STREAM_SIZE	0x0344
 
 #endif /* _MTK_JPEG_REG_H */
-- 
2.18.0

