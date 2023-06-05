Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7299722C67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjFEQVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjFEQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:21:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FDE6;
        Mon,  5 Jun 2023 09:21:34 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1C676605840;
        Mon,  5 Jun 2023 17:21:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685982093;
        bh=LS7cN4RBxcl8sllo4Y3gVv2KC3BFqrCKLyuDQi01anc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFrp470exFqNjDXip/2dVacgLH8+NGfi6s9aOb5c3Xd/NNA2cniQpYP6pqD4WvWKz
         0UeBz67010w+WI7BcBKabhyDmxWIJrmk8wTInHuRzsk8rjLIkquECK3izIa+Y7ole+
         V4JzirlMIqyy8T0fhbdZ31B0lQ+SnJPwtQAGfH7cAYDbS1A1dqn1Vljp7bZm0IwZ2U
         HEzTbNfYVLq5t59SelN2UnuxqtNwX4bDa05a8t0U1Hl2UzPOTioEBY4SQuvcSDB6J7
         h1SeQ8BLKUhIixTN8IBiSGzadB3OxHB+tnl1c0JGx2zBWPBgUrsm0H1j6d6gkofwU9
         Gi6owjuw6kdOg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 4/6] media: mediatek: vcodec: Read HW active status from clock
Date:   Mon,  5 Jun 2023 12:20:28 -0400
Message-Id: <20230605162030.274395-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605162030.274395-1-nfraprado@collabora.com>
References: <20230605162030.274395-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

