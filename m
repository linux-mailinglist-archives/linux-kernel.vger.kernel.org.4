Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA1726F65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjFGU6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjFGU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:57:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D22114;
        Wed,  7 Jun 2023 13:57:38 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5631C6606F0B;
        Wed,  7 Jun 2023 21:57:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686171457;
        bh=KyOkgk88JgYi98xRL1GjOR9/RT/y1SQOg2IBFayUZcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntuxpUy4W5smT35modxJscKpuD3WdBdTgX6d8uR+aV1AOWxy/HJU5HRZjhRyfRqMP
         2riEo/kC6qhVw5IRduSgctCAQnHN1URPtQ76BRGHyc2STPc55cF4ZWDsSqQDC2Q4SA
         4q/UGjpmgWtJm1TVrKPtKBQLaFg/ecccU8tBK+Lytg1x25dbXc8L2PzDHY31KE5C56
         yAdzNv1YB/vRC02eMBj6G+bYag2QiPoo6//eTlaCnrBFx7nzh7XPijoKjh2+tHDmuK
         GrO1Wq5/OYIC+c4u6b919Khroz8qvqYjzcxYqrIT8Y137CQ/Lvc1MarSURqoOPJiF4
         FwIB8ZSONIfFg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/5] media: mediatek: vcodec: Read HW active status from clock
Date:   Wed,  7 Jun 2023 16:53:40 -0400
Message-ID: <20230607205714.510012-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607205714.510012-1-nfraprado@collabora.com>
References: <20230607205714.510012-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the requirement of a VDEC_SYS reg iospace. To achieve that, rely
on the "active" clock being passed through the DT, and read its status
during IRQ handling to check whether the HW is active.

The old behavior is still present when reg-names aren't supplied, as to
keep backward compatibility.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 59 +++++++++++++++----
 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 20 +++++--
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 12 +++-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
 4 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 9c652beb3f19..8038472fb67b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -16,6 +16,7 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 #include <media/v4l2-device.h>
+#include <linux/clk-provider.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
@@ -38,22 +39,29 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
 	}
 }
 
+static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
+{
+	u32 cg_status = 0;
+
+	if (!dev->reg_base[VDEC_SYS])
+		return __clk_is_enabled(dev->pm.vdec_active_clk);
+
+	cg_status = readl(dev->reg_base[VDEC_SYS]);
+	return (cg_status & VDEC_HW_ACTIVE) == 0;
+}
+
 static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
 	struct mtk_vcodec_ctx *ctx;
-	u32 cg_status = 0;
 	unsigned int dec_done_status = 0;
 	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_MISC] +
 					VDEC_IRQ_CFG_REG;
 
 	ctx = mtk_vcodec_get_curr_ctx(dev, MTK_VDEC_CORE);
 
-	/* check if HW active or not */
-	cg_status = readl(dev->reg_base[0]);
-	if ((cg_status & VDEC_HW_ACTIVE) != 0) {
-		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0 (0x%08x)",
-			     cg_status);
+	if (!mtk_vcodec_is_hw_active(dev)) {
+		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0");
 		return IRQ_HANDLED;
 	}
 
@@ -82,6 +90,25 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 {
 	struct platform_device *pdev = dev->plat_dev;
 	int reg_num, i;
+	struct resource *res;
+	bool no_vdecsys_reg = false;
+	static const char * const mtk_dec_reg_names[] = {
+		"misc",
+		"ld",
+		"top",
+		"cm",
+		"ad",
+		"av",
+		"pp",
+		"hwd",
+		"hwq",
+		"hwb",
+		"hwg"
+	};
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "misc");
+	if (res)
+		no_vdecsys_reg = true;
 
 	/* Sizeof(u32) * 4 bytes for each register base. */
 	reg_num = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
@@ -91,12 +118,22 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < reg_num; i++) {
-		dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
-		if (IS_ERR(dev->reg_base[i]))
-			return PTR_ERR(dev->reg_base[i]);
+	if (!no_vdecsys_reg) {
+		for (i = 0; i < reg_num; i++) {
+			dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
+			if (IS_ERR(dev->reg_base[i]))
+				return PTR_ERR(dev->reg_base[i]);
 
-		mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
+			mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
+		}
+	} else {
+		for (i = 0; i < reg_num; i++) {
+			dev->reg_base[i+1] = devm_platform_ioremap_resource_byname(pdev, mtk_dec_reg_names[i]);
+			if (IS_ERR(dev->reg_base[i+1]))
+				return PTR_ERR(dev->reg_base[i+1]);
+
+			mtk_v4l2_debug(2, "reg[%d] base=%p", i+1, dev->reg_base[i+1]);
+		}
 	}
 
 	return 0;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index b753bf54ebd9..4e786821015d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/clk-provider.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
@@ -63,22 +64,29 @@ static int mtk_vdec_hw_prob_done(struct mtk_vcodec_dev *vdec_dev)
 	return 0;
 }
 
+static bool mtk_vcodec_is_hw_active(struct mtk_vdec_hw_dev *dev)
+{
+	u32 cg_status;
+
+	if (!dev->reg_base[VDEC_HW_SYS])
+		return __clk_is_enabled(dev->pm.vdec_active_clk);
+
+	cg_status = readl(dev->reg_base[VDEC_HW_SYS]);
+	return (cg_status & VDEC_HW_ACTIVE) == 0;
+}
+
 static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 {
 	struct mtk_vdec_hw_dev *dev = priv;
 	struct mtk_vcodec_ctx *ctx;
-	u32 cg_status;
 	unsigned int dec_done_status;
 	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_HW_MISC] +
 					VDEC_IRQ_CFG_REG;
 
 	ctx = mtk_vcodec_get_curr_ctx(dev->main_dev, dev->hw_idx);
 
-	/* check if HW active or not */
-	cg_status = readl(dev->reg_base[VDEC_HW_SYS]);
-	if (cg_status & VDEC_HW_ACTIVE) {
-		mtk_v4l2_err("vdec active is not 0x0 (0x%08x)",
-			     cg_status);
+	if (!mtk_vcodec_is_hw_active(dev)) {
+		mtk_v4l2_err("vdec active is not 0x0");
 		return IRQ_HANDLED;
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 777d445999e9..53e621965950 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -51,6 +51,9 @@ int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *
 				clk_info->clk_name);
 			return PTR_ERR(clk_info->vcodec_clk);
 		}
+
+		if (strcmp(clk_info->clk_name, "active") == 0)
+			pm->vdec_active_clk = clk_info->vcodec_clk;
 	}
 
 	return 0;
@@ -84,6 +87,9 @@ static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 
 	dec_clk = &pm->vdec_clk;
 	for (i = 0; i < dec_clk->clk_num; i++) {
+		if (strcmp(dec_clk->clk_info[i].clk_name, "active") == 0)
+			continue;
+
 		ret = clk_prepare_enable(dec_clk->clk_info[i].vcodec_clk);
 		if (ret) {
 			mtk_v4l2_err("clk_prepare_enable %d %s fail %d", i,
@@ -104,8 +110,12 @@ static void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 	int i;
 
 	dec_clk = &pm->vdec_clk;
-	for (i = dec_clk->clk_num - 1; i >= 0; i--)
+	for (i = dec_clk->clk_num - 1; i >= 0; i--) {
+		if (strcmp(dec_clk->clk_info[i].clk_name, "active") == 0)
+			continue;
+
 		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
+	}
 }
 
 static void mtk_vcodec_dec_enable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 9acab54fd650..180e74c69042 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -208,6 +208,7 @@ struct mtk_vcodec_pm {
 	struct mtk_vcodec_clk	vdec_clk;
 	struct mtk_vcodec_clk	venc_clk;
 	struct device	*dev;
+	struct clk *vdec_active_clk;
 };
 
 /**
-- 
2.41.0

