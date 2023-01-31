Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B029682441
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAaF6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:58:06 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBC38E;
        Mon, 30 Jan 2023 21:58:00 -0800 (PST)
X-UUID: 3628b976a12c11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KBnNi8SQX4pTbtzS2PM5rlD98IpxdGTkY+6/oG1LIQI=;
        b=A/gKWnc9FJU8QvYonj802wo+Y0jgpxSt3lpaSimPdI+gVGE7a+H+Nx4V0H5qYz2gzML5lMXK3p98dptc4o4Lr3ySO3ySBvVNHk4CYIRKX92B+vihEBJeypdHW4xn93ey4nxHIHexSi547ZtfTqPaddyyY18E/CGOtHuMToBDMrI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:a64f0095-e040-4b29-87eb-f0c710ddf4cf,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:3ca2d6b,CLOUDID:0a96d355-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 3628b976a12c11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 722342448; Tue, 31 Jan 2023 13:57:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 13:57:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 13:57:55 +0800
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
        <maoguang.meng@mediatek.com>, Irui Wang <irui.wang@mediatek.com>
Subject: [V5] media: mtk-jpeg: Fixes jpeghw multi-core judgement
Date:   Tue, 31 Jan 2023 13:57:53 +0800
Message-ID: <20230131055753.20572-1-irui.wang@mediatek.com>
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

some chips have multi-hw, but others have only one,
modify the condition of multi-hw judgement

Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 +++-
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 79a8f1b1965c..857afaa24cab 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1694,7 +1694,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (list_empty(&pdev->dev.devres_head)) {
+	if (!jpeg->variant->multi_core) {
 		INIT_DELAYED_WORK(&jpeg->job_timeout_work,
 				  mtk_jpeg_job_timeout_work);
 
@@ -1888,6 +1888,7 @@ static struct mtk_jpeg_variant mtk8195_jpegenc_drvdata = {
 	.ioctl_ops = &mtk_jpeg_enc_ioctl_ops,
 	.out_q_default_fourcc = V4L2_PIX_FMT_YUYV,
 	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
+	.multi_core = true,
 };
 
 static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
@@ -1899,6 +1900,7 @@ static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
 	.ioctl_ops = &mtk_jpeg_dec_ioctl_ops,
 	.out_q_default_fourcc = V4L2_PIX_FMT_JPEG,
 	.cap_q_default_fourcc = V4L2_PIX_FMT_YUV420M,
+	.multi_core = true,
 };
 
 #if defined(CONFIG_OF)
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index b9126476be8f..20517f7a5405 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -60,6 +60,7 @@ enum mtk_jpeg_ctx_state {
  * @ioctl_ops:			the callback of jpeg v4l2_ioctl_ops
  * @out_q_default_fourcc:	output queue default fourcc
  * @cap_q_default_fourcc:	capture queue default fourcc
+ * @multi_core:			mark jpeg hw is multi_core or not
  */
 struct mtk_jpeg_variant {
 	struct clk_bulk_data *clks;
@@ -74,6 +75,7 @@ struct mtk_jpeg_variant {
 	const struct v4l2_ioctl_ops *ioctl_ops;
 	u32 out_q_default_fourcc;
 	u32 cap_q_default_fourcc;
+	bool multi_core;
 };
 
 struct mtk_jpeg_src_buf {
-- 
2.18.0

