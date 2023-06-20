Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722873605F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFTAEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFTAEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:04:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2850110D4;
        Mon, 19 Jun 2023 17:04:15 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 93BA36606F6C;
        Tue, 20 Jun 2023 01:04:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687219454;
        bh=7Uy90B8rQDsK2NiHlzH+mhXRwuLVWP2mVHok4MwIH/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHdUfoMMqWk9/DC5bGcZvuhel3P/C3YGLKPdSlnIVRi4TAspQfwfQaIXh2QKXPucH
         RkPn1EGwmauio7lAWuk9N16Uww+iw6GUM/2RcGRtAawWGEJXdw5wLUjT2TiZiMmkVZ
         de2mdmlwEJMHDMBi961heyztujhdXtaR0F92I9JRuCM5Y1uyqmvaRmb/RSMuTwTsUi
         3nHk5i4fLLLeEZ4QIy1uUVJ/pbe2O2KnMB0rWbGxtkMOAQg3KkiNWxc8cTiZxwO2T/
         C7BPGRPPpqPkzZiO1RI9WKpsH6XO4tsWjmlgtB1RE5V5Ap+MjCSd9LG/Dv8zuKIGwd
         dML0qerRUtztA==
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
Subject: [PATCH v3 5/6] media: mediatek: vcodec: Read HW active status from syscon on MT8183
Date:   Mon, 19 Jun 2023 20:03:38 -0400
Message-ID: <20230620000349.2122191-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620000349.2122191-1-nfraprado@collabora.com>
References: <20230620000349.2122191-1-nfraprado@collabora.com>
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

Remove the requirement of a VDEC_SYS reg iospace for MT8183. To achieve
that, rely on a vdecsys syscon to be passed through the DT, and use it
to directly read the VDEC_HW_ACTIVE bit during IRQ handling to check
whether the HW is active.

The old behavior is still present when reg-names aren't supplied, as
MT8173 still relies on it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
I dropped the tags from this commit since a syscon is now used instead
of an extra clock.

Changes in v3:
- Switched handling of VDEC_HW_ACTIVE to use a syscon instead of the
  'active' clock
- Reworded commit
- Removed changes to subdev part of driver, since they aren't used by
  MT8183

 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 71 ++++++++++++++++---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 83780d29a9cf..387ed26d6d5d 100644
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
@@ -38,22 +40,37 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
 	}
 }
 
+static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
+{
+	u32 cg_status = 0;
+	int val, ret;
+
+	if (!dev->reg_base[VDEC_SYS]) {
+		ret = regmap_read(dev->vdecsys_regmap, VDEC_HW_ACTIVE_ADDR, &val);
+		if (ret) {
+			mtk_v4l2_err("Failed to read VDEC active status");
+			return false;
+		}
+
+		return (val & VDEC_HW_ACTIVE_MASK) == 0;
+	}
+
+	cg_status = readl(dev->reg_base[VDEC_SYS] + VDEC_HW_ACTIVE_ADDR);
+	return (cg_status & VDEC_HW_ACTIVE_MASK) == 0;
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
 
@@ -82,6 +99,25 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
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
@@ -91,12 +127,22 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
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
 	}
 
 	return 0;
@@ -118,6 +164,9 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
 	if (dev->dec_irq < 0)
 		return dev->dec_irq;
 
+	dev->vdecsys_regmap = syscon_regmap_lookup_by_phandle_optional(pdev->dev.of_node,
+								       "mediatek,vdecsys");
+
 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
 			       mtk_vcodec_dec_irq_handler, 0, pdev->name, dev);
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
 
-- 
2.41.0

