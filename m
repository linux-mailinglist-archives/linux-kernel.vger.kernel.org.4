Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551F55F1993
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiJAD0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiJADZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:25:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA5F80A4;
        Fri, 30 Sep 2022 20:17:50 -0700 (PDT)
X-UUID: e97db3c1121c430aab2360299c843be4-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nD2qa9frkMSGj6PytXf0V1URBD+ujDxdpHZfDVsjUxQ=;
        b=BSRsvhL94fovYxf+4eHQMy/Q4pJVHDUeRE//sfQAo0DZhwu4Yt7KWd7n2fG6y9F6LvcJBrwDFWpMd4WpGfbjTDFm/UX0zpPAH6htj2j+6KBOdRxRhNWyQje7pFb4F9TwFpoUjgfZ2w8ejgXs9GvUsqkG8MxskgfOreRkX3HXl3w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d51d1420-53bc-484c-bb64-25d358a0c0da,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:8067afa3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e97db3c1121c430aab2360299c843be4-20221001
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1596094693; Sat, 01 Oct 2022 11:17:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:17:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:17:42 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        "Irui Wang" <irui.wang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6, 2/8] media: mediatek: vcodec: Enable venc dual core usage
Date:   Sat, 1 Oct 2022 11:17:31 +0800
Message-ID: <20221001031737.18266-3-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221001031737.18266-1-irui.wang@mediatek.com>
References: <20221001031737.18266-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new property to indicate whether the encoder has multiple cores.
Use of_platform_populate to probe each venc cores, the core device can
use the init_clk/request_irq helper to initialize their own power/clk/irq.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../media/platform/mediatek/vcodec/Makefile   |   4 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  12 ++
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |   6 +
 .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 136 ++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_enc_hw.h       |  36 +++++
 5 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h

diff --git a/drivers/media/platform/mediatek/vcodec/Makefile b/drivers/media/platform/mediatek/vcodec/Makefile
index 93e7a343b5b0..e150b3dbd15c 100644
--- a/drivers/media/platform/mediatek/vcodec/Makefile
+++ b/drivers/media/platform/mediatek/vcodec/Makefile
@@ -3,7 +3,8 @@
 obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
 				       mtk-vcodec-enc.o \
 				       mtk-vcodec-common.o \
-				       mtk-vcodec-dec-hw.o
+				       mtk-vcodec-dec-hw.o \
+				       mtk-vcodec-enc-hw.o
 
 mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
 		vdec/vdec_vp8_if.o \
@@ -32,6 +33,7 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
 		venc_drv_if.o \
 		venc_vpu_if.o \
 
+mtk-vcodec-enc-hw-y := mtk_vcodec_enc_hw.o
 
 mtk-vcodec-common-y := mtk_vcodec_intr.o \
 		mtk_vcodec_util.o \
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 9acab54fd650..6faf9ccc940f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -95,6 +95,15 @@ enum mtk_fmt_type {
 	MTK_FMT_FRAME = 2,
 };
 
+/*
+ * enum mtk_venc_hw_id -- encoder hardware id
+ */
+enum mtk_venc_hw_id {
+	MTK_VENC_CORE_0 = 0,
+	MTK_VENC_CORE_1,
+	MTK_VENC_HW_MAX,
+};
+
 /*
  * enum mtk_vdec_hw_id - Hardware index used to separate
  *                         different hardware
@@ -470,6 +479,7 @@ struct mtk_vcodec_enc_pdata {
  * @dec_active_cnt: used to mark whether need to record register value
  * @vdec_racing_info: record register value
  * @dec_racing_info_mutex: mutex lock used for inner racing mode
+ * @enc_hw_dev: used to store venc core device
  */
 struct mtk_vcodec_dev {
 	struct v4l2_device v4l2_dev;
@@ -520,6 +530,8 @@ struct mtk_vcodec_dev {
 	u32 vdec_racing_info[132];
 	/* Protects access to vdec_racing_info data */
 	struct mutex dec_racing_info_mutex;
+
+	void *enc_hw_dev[MTK_VENC_HW_MAX];
 };
 
 static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 9095186d5495..48f9f59516bd 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -263,6 +263,12 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_enc_pm;
 	}
 
+	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+	if (ret) {
+		mtk_v4l2_err("Failed to populate children devices");
+		goto err_enc_pm;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	dev->reg_base[dev->venc_pdata->core_id] =
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
new file mode 100644
index 000000000000..cc4938f027e0
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc.h"
+#include "mtk_vcodec_enc_hw.h"
+#include "mtk_vcodec_intr.h"
+
+static const struct of_device_id mtk_venc_hw_ids[] = {
+	{.compatible = "mediatek,mtk-venc-hw",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_venc_hw_ids);
+
+static void clean_hw_irq_status(unsigned int irq_status, void __iomem *addr)
+{
+	if (irq_status & MTK_VENC_IRQ_STATUS_PAUSE)
+		writel(MTK_VENC_IRQ_STATUS_PAUSE, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_SWITCH)
+		writel(MTK_VENC_IRQ_STATUS_SWITCH, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_DRAM)
+		writel(MTK_VENC_IRQ_STATUS_DRAM, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_SPS)
+		writel(MTK_VENC_IRQ_STATUS_SPS, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_PPS)
+		writel(MTK_VENC_IRQ_STATUS_PPS, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_FRM)
+		writel(MTK_VENC_IRQ_STATUS_FRM, addr);
+}
+
+static irqreturn_t mtk_enc_hw_irq_handler(int irq, void *priv)
+{
+	struct mtk_venc_hw_dev *dev = priv;
+	struct mtk_vcodec_ctx *ctx;
+	unsigned long flags;
+	void __iomem *addr;
+
+	spin_lock_irqsave(&dev->main_dev->irqlock, flags);
+	ctx = dev->curr_ctx;
+	spin_unlock_irqrestore(&dev->main_dev->irqlock, flags);
+	if (!ctx)
+		return IRQ_HANDLED;
+
+	mtk_v4l2_debug(1, "id=%d core :%d", ctx->id, dev->hw_id);
+
+	addr = dev->reg_base + MTK_VENC_IRQ_ACK_OFFSET;
+	ctx->irq_status = readl(dev->reg_base + MTK_VENC_IRQ_STATUS_OFFSET);
+	clean_hw_irq_status(ctx->irq_status, addr);
+
+	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	return IRQ_HANDLED;
+}
+
+static int mtk_venc_hw_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_venc_hw_dev *sub_core;
+	struct mtk_vcodec_dev *main_dev;
+	int ret;
+
+	if (!dev->parent)
+		return dev_err_probe(dev, -ENODEV,
+				     "No parent for venc core device\n");
+
+	main_dev = dev_get_drvdata(dev->parent);
+	if (!main_dev)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to get parent driver data\n");
+
+	sub_core = devm_kzalloc(&pdev->dev, sizeof(*sub_core), GFP_KERNEL);
+	if (!sub_core)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to get alloc core data\n");
+
+	sub_core->plat_dev = pdev;
+
+	platform_set_drvdata(pdev, sub_core);
+
+	sub_core->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sub_core->reg_base))
+		return dev_err_probe(dev, PTR_ERR(sub_core->reg_base),
+				     "Failed to get reg base\n");
+
+	sub_core->enc_irq = platform_get_irq(pdev, 0);
+	if (sub_core->enc_irq < 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to get irq resource\n");
+
+	ret = devm_request_irq(dev, sub_core->enc_irq,
+			       mtk_enc_hw_irq_handler, 0,
+			       pdev->name, sub_core);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to install sub_core->enc_irq %d\n",
+				     sub_core->enc_irq);
+
+	ret = of_property_read_u32(dev->of_node, "mediatek,hw-id",
+				   &sub_core->hw_id);
+
+	if (ret || sub_core->hw_id >= MTK_VENC_HW_MAX)
+		return dev_err_probe(dev, (ret ? ret : -EINVAL),
+				     "Cannot parse hardware id");
+
+	main_dev->enc_hw_dev[sub_core->hw_id] = sub_core;
+	sub_core->main_dev = main_dev;
+
+	dev_dbg(dev, "Venc core :%d probe done\n", sub_core->hw_id);
+
+	return 0;
+}
+
+static struct platform_driver mtk_venc_core_driver = {
+	.probe  = mtk_venc_hw_probe,
+	.driver = {
+		.name	 = "mtk-venc-core",
+		.of_match_table = mtk_venc_hw_ids,
+	},
+};
+module_platform_driver(mtk_venc_core_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek video encoder core driver");
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
new file mode 100644
index 000000000000..9daea9665659
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef _MTK_VCODEC_ENC_HW_H_
+#define _MTK_VCODEC_ENC_HW_H_
+
+#include <linux/platform_device.h>
+#include "mtk_vcodec_drv.h"
+
+/**
+ * struct mtk_venc_hw_dev - driver data
+ * @plat_dev: platform_device
+ * @main_dev: main device
+ * @pm: power management data
+ * @curr_ctx: the context that is waiting for venc hardware
+ * @reg_base: mapped address of venc registers
+ * @irq_status: venc hardware irq status
+ * @enc_irq: venc device irq
+ * @hw_id: for venc hardware id: core#0, core#1...
+ */
+struct mtk_venc_hw_dev {
+	struct platform_device *plat_dev;
+	struct mtk_vcodec_dev *main_dev;
+
+	struct mtk_vcodec_pm pm;
+	struct mtk_vcodec_ctx *curr_ctx;
+
+	void __iomem *reg_base;
+	unsigned int irq_status;
+	int enc_irq;
+	enum mtk_venc_hw_id hw_id;
+};
+
+#endif /* _MTK_VCODEC_ENC_HW_H_ */
-- 
2.18.0

