Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07D47405E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjF0Vqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjF0Vql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:46:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F682953;
        Tue, 27 Jun 2023 14:46:36 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D4B99660716B;
        Tue, 27 Jun 2023 22:46:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687902395;
        bh=7Yv0RLEqwrkwHViyfVu6oNggvzTGRKyaB317MVjZZKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCt6Wnh0qQyBkJ/zP4lYYrsd7dAsxqaPhyFzzqJyrmx4f3SCG0p+aO2Gi+Boqi+G0
         JHlT68vKq1OFsrCtXIBuC3Cc4eoE+qXCr/R4nX1PjopFMYi3cmhveCut23B9hS7ONa
         mNpn162Q2W8XWmDjPvLYBTq6ijOaeqs5o8xCCIOUC+9/aYQuzNsr63I1IDMPyjzzeB
         PWZJyzhx5Soz2uoxEW/Pz+BrYHEW1Iue0+yu7H+4krGsiZ12wS8WHvBRs+nuKmapWW
         LSNdFYyUb3qKWwBajZ7pPwroP0kjmwTEQDmMq2cKk59WgvtSUo+m8/5s3+vDb0+8IZ
         nbZq0gVinZAtg==
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
Subject: [PATCH v4 5/7] media: mediatek: vcodec: Read HW active status from syscon
Date:   Tue, 27 Jun 2023 17:45:55 -0400
Message-ID: <20230627214615.1503901-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627214615.1503901-1-nfraprado@collabora.com>
References: <20230627214615.1503901-1-nfraprado@collabora.com>
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

Remove the requirement of a VDEC_SYS reg iospace for both MT8173 and
MT8183. To achieve that, rely on a vdecsys syscon to be passed through
the DT, and use it to directly read the VDEC_HW_ACTIVE bit during IRQ
handling to check whether the HW is active. Also update the VP8 stateful
decoder to use the syscon, if present, for writes to VDEC_SYS.

The old behavior is still present when reg-names aren't supplied, as
to keep backward compatibility.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v4:
- Added new helper and updated VP8 stateful decoder to use it, so the
  syscon can also be used by mt8173
- Made handling cleaner
- Reworded commit

Changes in v3:
- Switched handling of VDEC_HW_ACTIVE to use a syscon instead of the
  'active' clock
- Reworded commit
- Removed changes to subdev part of driver, since they aren't used by
  MT8183

 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 76 ++++++++++++++++---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
 .../mediatek/vcodec/mtk_vcodec_util.c         | 15 ++++
 .../mediatek/vcodec/mtk_vcodec_util.h         |  2 +
 .../mediatek/vcodec/vdec/vdec_vp8_if.c        | 10 +--
 5 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 83780d29a9cf..d83c2eb6f118 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -8,10 +8,12 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
@@ -38,22 +40,30 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
 	}
 }
 
+static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
+{
+	u32 cg_status;
+
+	if (dev->vdecsys_regmap)
+		return !regmap_test_bits(dev->vdecsys_regmap, VDEC_HW_ACTIVE_ADDR,
+					 VDEC_HW_ACTIVE_MASK);
+
+	cg_status = readl(dev->reg_base[VDEC_SYS] + VDEC_HW_ACTIVE_ADDR);
+	return !FIELD_GET(VDEC_HW_ACTIVE_MASK, cg_status);
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
-	cg_status = readl(dev->reg_base[0] + VDEC_HW_ACTIVE_ADDR);
-	if ((cg_status & VDEC_HW_ACTIVE_MASK) != 0) {
-		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0 (0x%08x)",
-			     cg_status);
+	if (!mtk_vcodec_is_hw_active(dev)) {
+		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0");
 		return IRQ_HANDLED;
 	}
 
@@ -82,6 +92,33 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 {
 	struct platform_device *pdev = dev->plat_dev;
 	int reg_num, i;
+	struct resource *res;
+	bool has_vdecsys_reg;
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
+	/*
+	 * If we have reg-names in devicetree, this means that we're on a new
+	 * register organization, which implies that the VDEC_SYS iospace gets
+	 * R/W through a syscon (regmap).
+	 * Here we try to get the "misc" iostart only to check if we have reg-names
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "misc");
+	if (res)
+		has_vdecsys_reg = false;
+	else
+		has_vdecsys_reg = true;
 
 	/* Sizeof(u32) * 4 bytes for each register base. */
 	reg_num = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
@@ -91,12 +128,29 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < reg_num; i++) {
-		dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
-		if (IS_ERR(dev->reg_base[i]))
-			return PTR_ERR(dev->reg_base[i]);
+	if (has_vdecsys_reg) {
+		for (i = 0; i < reg_num; i++) {
+			dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
+			if (IS_ERR(dev->reg_base[i]))
+				return PTR_ERR(dev->reg_base[i]);
+
+			mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
+		}
+	} else {
+		for (i = 0; i < reg_num; i++) {
+			dev->reg_base[i+1] = devm_platform_ioremap_resource_byname(pdev, mtk_dec_reg_names[i]);
+			if (IS_ERR(dev->reg_base[i+1]))
+				return PTR_ERR(dev->reg_base[i+1]);
 
-		mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
+			mtk_v4l2_debug(2, "reg[%d] base=%p", i+1, dev->reg_base[i+1]);
+		}
+
+		dev->vdecsys_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+								      "mediatek,vdecsys");
+		if (IS_ERR(dev->vdecsys_regmap)) {
+			dev_err(&pdev->dev, "Missing mediatek,vdecsys property");
+			return PTR_ERR(dev->vdecsys_regmap);
+		}
 	}
 
 	return 0;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index f17d67e781c9..0b430936f67d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -489,6 +489,7 @@ struct mtk_vcodec_dev {
 	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
 	const struct mtk_vcodec_dec_pdata *vdec_pdata;
 	const struct mtk_vcodec_enc_pdata *venc_pdata;
+	struct regmap *vdecsys_regmap;
 
 	struct mtk_vcodec_fw *fw_handler;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index f214e6f67005..8aaa5eb45444 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_drv.h"
@@ -34,6 +35,20 @@ void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 }
 EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 
+int mtk_vcodec_write_vdecsys(struct mtk_vcodec_ctx *ctx, unsigned int reg,
+			     unsigned int val)
+{
+	struct mtk_vcodec_dev *dev = ctx->dev;
+
+	if (dev->vdecsys_regmap)
+		return regmap_write(dev->vdecsys_regmap, reg, val);
+
+	writel(val, dev->reg_base[VDEC_SYS] + reg);
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_vcodec_write_vdecsys);
+
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 			struct mtk_vcodec_mem *mem)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 88d389b65f13..c8bb4fc5153f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -70,6 +70,8 @@ extern int mtk_vcodec_dbg;
 
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 				unsigned int reg_idx);
+int mtk_vcodec_write_vdecsys(struct mtk_vcodec_ctx *ctx, unsigned int reg,
+			     unsigned int val);
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 				struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index 88c046731754..2592fa37b4c8 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -91,7 +91,6 @@ struct vdec_vp8_vsi {
 
 /**
  * struct vdec_vp8_hw_reg_base - HW register base
- * @sys		: base address for sys
  * @misc	: base address for misc
  * @ld		: base address for ld
  * @top		: base address for top
@@ -100,7 +99,6 @@ struct vdec_vp8_vsi {
  * @hwb		: base address for hwb
  */
 struct vdec_vp8_hw_reg_base {
-	void __iomem *sys;
 	void __iomem *misc;
 	void __iomem *ld;
 	void __iomem *top;
@@ -170,7 +168,6 @@ static void get_hw_reg_base(struct vdec_vp8_inst *inst)
 	inst->reg_base.top = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_TOP);
 	inst->reg_base.cm = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_CM);
 	inst->reg_base.hwd = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_HWD);
-	inst->reg_base.sys = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_SYS);
 	inst->reg_base.misc = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_MISC);
 	inst->reg_base.ld = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_LD);
 	inst->reg_base.hwb = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_HWB);
@@ -222,17 +219,16 @@ static void read_hw_segmentation_data(struct vdec_vp8_inst *inst)
 static void enable_hw_rw_function(struct vdec_vp8_inst *inst)
 {
 	u32 val = 0;
-	void __iomem *sys = inst->reg_base.sys;
 	void __iomem *misc = inst->reg_base.misc;
 	void __iomem *ld = inst->reg_base.ld;
 	void __iomem *hwb = inst->reg_base.hwb;
 	void __iomem *hwd = inst->reg_base.hwd;
 
-	writel(0x1, sys + VP8_RW_CKEN_SET);
+	mtk_vcodec_write_vdecsys(inst->ctx, VP8_RW_CKEN_SET, 0x1);
 	writel(0x101, ld + VP8_WO_VLD_SRST);
 	writel(0x101, hwb + VP8_WO_VLD_SRST);
 
-	writel(1, sys);
+	mtk_vcodec_write_vdecsys(inst->ctx, 0, 0x1);
 	val = readl(misc + VP8_RW_MISC_SRST);
 	writel((val & 0xFFFFFFFE), misc + VP8_RW_MISC_SRST);
 
@@ -241,7 +237,7 @@ static void enable_hw_rw_function(struct vdec_vp8_inst *inst)
 	writel(0x71201100, misc + VP8_RW_MISC_FUNC_CON);
 	writel(0x0, ld + VP8_WO_VLD_SRST);
 	writel(0x0, hwb + VP8_WO_VLD_SRST);
-	writel(0x1, sys + VP8_RW_DCM_CON);
+	mtk_vcodec_write_vdecsys(inst->ctx, VP8_RW_DCM_CON, 0x1);
 	writel(0x1, misc + VP8_RW_MISC_DCM_CON);
 	writel(0x1, hwd + VP8_RW_VP8_CTRL);
 }
-- 
2.41.0

