Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E925E5C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiIVH3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIVH3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:29:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095701B787
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:29:38 -0700 (PDT)
X-UUID: 4233d9138b25406aad4ef9e885444596-20220922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TkJRIDcEgfyqlqBAXy4O2qBob2FyY4hJGpkDrUrwH3g=;
        b=ShJPFIoNCOGVq/2kVEtFx8F2TD7/02fIFrUTIq2NIZ8PAwePeDZLYH00BjkIEoAf2tAnNAsfWf1QhuYrR7kyfA2nMEarMDSrf8zKoQNXmTGkw/X4AJjQIvQhWwN/vNO9+G5OiH7o2QOIpO7lE8Eb+3YZ6rggbIU69Qhe+tVYVXM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8ce09c72-4353-4d4e-bccf-9a3aaeb21187,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:daa4a706-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4233d9138b25406aad4ef9e885444596-20220922
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1981461656; Thu, 22 Sep 2022 15:29:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 22 Sep 2022 15:29:31 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 22 Sep 2022 15:29:31 +0800
From:   <xinlei.lee@mediatek.com>
To:     <matthias.bgg@gmail.com>, <jason-jh.lin@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <rex-bc.chen@mediatek.com>, <ck.hu@mediatek.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v7,1/3] soc: mediatek: Add mmsys func to adapt to dpi output for MT8186
Date:   Thu, 22 Sep 2022 15:29:22 +0800
Message-ID: <1663831764-18169-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1663831764-18169-1-git-send-email-xinlei.lee@mediatek.com>
References: <1663831764-18169-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

The difference between MT8186 and other ICs is that when modifying the
output format, we need to modify the mmsys_base+0x400 register to take
effect.
So when setting the dpi output format, we need to call mmsys_func to set
it to MT8186 synchronously.

Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 drivers/soc/mediatek/mt8186-mmsys.h    |  8 +++++++
 drivers/soc/mediatek/mtk-mmsys.c       | 32 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  9 ++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
index eb1ad9c37a9c..536005d1cc55 100644
--- a/drivers/soc/mediatek/mt8186-mmsys.h
+++ b/drivers/soc/mediatek/mt8186-mmsys.h
@@ -3,6 +3,14 @@
 #ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
 #define __SOC_MEDIATEK_MT8186_MMSYS_H
 
+/* Values for DPI configuration in MMSYS address space */
+#define MT8186_MMSYS_DPI_OUTPUT_FORMAT		0x400
+#define DPI_FORMAT_MASK					0x3
+#define DPI_RGB888_SDR_CON				0
+#define DPI_RGB888_DDR_CON				1
+#define DPI_RGB565_SDR_CON				2
+#define DPI_RGB565_DDR_CON				3
+
 #define MT8186_MMSYS_OVL_CON			0xF04
 #define MT8186_MMSYS_OVL0_CON_MASK			0x3
 #define MT8186_MMSYS_OVL0_2L_CON_MASK			0xC
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 06d8e83a2cb5..0857806206dc 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -227,6 +227,38 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
+static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
+{
+	u32 tmp;
+
+	tmp = readl_relaxed(mmsys->regs + offset);
+	tmp = (tmp & ~mask) | val;
+	writel_relaxed(tmp, mmsys->regs + offset);
+}
+
+void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val)
+{
+	switch (val) {
+	case MTK_DPI_RGB888_DDR_CON:
+		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB888_DDR_CON);
+		break;
+	case MTK_DPI_RGB565_SDR_CON:
+		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB565_SDR_CON);
+		break;
+	case MTK_DPI_RGB565_DDR_CON:
+		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB565_DDR_CON);
+		break;
+	default:
+		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
+				      DPI_FORMAT_MASK, DPI_RGB888_DDR_CON);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_fmt_config);
+
 static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
 				  bool assert)
 {
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 59117d970daf..b85f66db33e1 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -9,6 +9,13 @@
 enum mtk_ddp_comp_id;
 struct device;
 
+enum mtk_dpi_out_format_con {
+	MTK_DPI_RGB888_SDR_CON,
+	MTK_DPI_RGB888_DDR_CON,
+	MTK_DPI_RGB565_SDR_CON,
+	MTK_DPI_RGB565_DDR_CON
+};
+
 enum mtk_ddp_comp_id {
 	DDP_COMPONENT_AAL0,
 	DDP_COMPONENT_AAL1,
@@ -65,4 +72,6 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
 
+void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val);
+
 #endif /* __MTK_MMSYS_H */
-- 
2.18.0

