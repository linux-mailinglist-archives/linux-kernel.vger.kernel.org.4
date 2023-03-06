Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66C6AC2B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCFOMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjCFOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:12:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2321D272B;
        Mon,  6 Mar 2023 06:09:52 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6D8B6602FF1;
        Mon,  6 Mar 2023 14:07:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111628;
        bh=MyJkv2GU2hsM5d8F1LGjAaTK3FS7K3NsQ1olEogWvNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1iB3kmyijUSNC6t5Ga2EqKyYf4O8yvo+XtjO3xHSI4wbujYie6ZCO74FLDbYVHx6
         1x29Gx4yiuZj3J6gOhBk6uaQ3s+6dq2HLnFCtKbHpp0DY4qJW9pxelNFymXdTsNzGy
         hQojitijbOw9ajpY323L5Fiy8Uv4ObTuOLrDXGfIh4F69h7Iyj7lL8SH8gmXfpjt/7
         voGNRz6NhMgcYmpRIZrDN2eNDR+5PKSA7avphwkHP/rpOfRVj7VK83+px2IWlsgdOr
         VD2rfwhgBm8BulccZzOpI1VfO4weYRj1PK3ytFxZJNOJmPmJuX6ioT91ZvFVJS3kDU
         ll1e5cHj2/PJw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v6 50/54] clk: mediatek: mt8135: Move apmixedsys to its own file
Date:   Mon,  6 Mar 2023 15:05:39 +0100
Message-Id: <20230306140543.1813621-51-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for migrating mt8135 clocks to the common simple
probe mechanism, move the apmixedsys clocks to a different file.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile                |  2 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 62 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8135.c            | 46 ---------------
 3 files changed, 63 insertions(+), 47 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8135-apmixedsys.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 048a150a7637..bcd3b8c465aa 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-apmixed.o
 obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-infracfg.o
 obj-$(CONFIG_COMMON_CLK_MT7986_ETHSYS) += clk-mt7986-eth.o
-obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135.o
+obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135-apmixedsys.o clk-mt8135.o
 obj-$(CONFIG_COMMON_CLK_MT8167) += clk-mt8167-apmixedsys.o clk-mt8167.o
 obj-$(CONFIG_COMMON_CLK_MT8167_AUDSYS) += clk-mt8167-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8167_IMGSYS) += clk-mt8167-img.o
diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
new file mode 100644
index 000000000000..2b4d379300fc
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ *               James Liao <jamesjj.liao@mediatek.com>
+ * Copyright (c) 2023 Collabora, Ltd.
+ *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8135-clk.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#define MT8135_PLL_FMAX		(2000 * MHZ)
+#define CON0_MT8135_RST_BAR	BIT(27)
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift) { \
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = CON0_MT8135_RST_BAR,			\
+		.fmax = MT8135_PLL_FMAX,				\
+		.pcwbits = _pcwbits,					\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+	}
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_ARMPLL1, "armpll1", 0x200, 0x218, 0x80000000, 0, 21, 0x204, 24, 0x0, 0x204, 0),
+	PLL(CLK_APMIXED_ARMPLL2, "armpll2", 0x2cc, 0x2e4, 0x80000000, 0, 21, 0x2d0, 24, 0x0, 0x2d0, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x21c, 0x234, 0xf0000000, HAVE_RST_BAR, 21, 0x21c, 6, 0x0, 0x220, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x238, 0x250, 0xf3000000, HAVE_RST_BAR, 7, 0x238, 6, 0x0, 0x238, 9),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x254, 0x26c, 0xf0000000, HAVE_RST_BAR, 21, 0x254, 6, 0x0, 0x258, 0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x278, 0x290, 0x80000000, 0, 21, 0x278, 6, 0x0, 0x27c, 0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x294, 0x2ac, 0x80000000, 0, 31, 0x294, 6, 0x0, 0x298, 0),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2b0, 0x2c8, 0x80000000, 0, 21, 0x2b0, 6, 0x0, 0x2b4, 0),
+	PLL(CLK_APMIXED_AUDPLL, "audpll", 0x2e8, 0x300, 0x80000000, 0, 31, 0x2e8, 6, 0x2f8, 0x2ec, 0),
+	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x304, 0x31c, 0x80000000, 0, 21, 0x2b0, 6, 0x0, 0x308, 0),
+};
+
+static void __init mtk_apmixedsys_init(struct device_node *node)
+{
+	struct clk_hw_onecell_data *clk_data;
+
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return;
+
+	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+}
+CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8135-apmixedsys",
+		mtk_apmixedsys_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 98165b1f7c97..2a9405b552c6 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -592,50 +592,4 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	mtk_register_reset_controller(node, &clk_rst_desc[1]);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
-
-#define MT8135_PLL_FMAX		(2000 * MHZ)
-#define CON0_MT8135_RST_BAR	BIT(27)
-
-#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift) { \
-		.id = _id,						\
-		.name = _name,						\
-		.reg = _reg,						\
-		.pwr_reg = _pwr_reg,					\
-		.en_mask = _en_mask,					\
-		.flags = _flags,					\
-		.rst_bar_mask = CON0_MT8135_RST_BAR,			\
-		.fmax = MT8135_PLL_FMAX,				\
-		.pcwbits = _pcwbits,					\
-		.pd_reg = _pd_reg,					\
-		.pd_shift = _pd_shift,					\
-		.tuner_reg = _tuner_reg,				\
-		.pcw_reg = _pcw_reg,					\
-		.pcw_shift = _pcw_shift,				\
-	}
-
-static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL1, "armpll1", 0x200, 0x218, 0x80000000, 0, 21, 0x204, 24, 0x0, 0x204, 0),
-	PLL(CLK_APMIXED_ARMPLL2, "armpll2", 0x2cc, 0x2e4, 0x80000000, 0, 21, 0x2d0, 24, 0x0, 0x2d0, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x21c, 0x234, 0xf0000000, HAVE_RST_BAR, 21, 0x21c, 6, 0x0, 0x220, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x238, 0x250, 0xf3000000, HAVE_RST_BAR, 7, 0x238, 6, 0x0, 0x238, 9),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x254, 0x26c, 0xf0000000, HAVE_RST_BAR, 21, 0x254, 6, 0x0, 0x258, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x278, 0x290, 0x80000000, 0, 21, 0x278, 6, 0x0, 0x27c, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x294, 0x2ac, 0x80000000, 0, 31, 0x294, 6, 0x0, 0x298, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2b0, 0x2c8, 0x80000000, 0, 21, 0x2b0, 6, 0x0, 0x2b4, 0),
-	PLL(CLK_APMIXED_AUDPLL, "audpll", 0x2e8, 0x300, 0x80000000, 0, 31, 0x2e8, 6, 0x2f8, 0x2ec, 0),
-	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x304, 0x31c, 0x80000000, 0, 21, 0x2b0, 6, 0x0, 0x308, 0),
-};
-
-static void __init mtk_apmixedsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return;
-
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-}
-CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8135-apmixedsys",
-		mtk_apmixedsys_init);
 MODULE_LICENSE("GPL");
-- 
2.39.2

