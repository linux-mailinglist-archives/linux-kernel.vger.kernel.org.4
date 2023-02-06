Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9111E68B952
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjBFKB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:01:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9C12850;
        Mon,  6 Feb 2023 02:01:17 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9490B6602F90;
        Mon,  6 Feb 2023 10:01:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675677676;
        bh=JSh/wdVnPgjT9XpgJxJRzIiGnPbLZPZnhfU8/MKT0ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwT05yb7Fv6vqjZvaH15YcVpRxZZh8uajUpG9goYDGOs6UNzggUFJhwgzSDtrzmoz
         uXCVv+5ZNwrfHgsMmrbRsEK76h2rERW4CKrDc63DRiG7xu4xzMufAjVzeAZjXzak9C
         hIagdfxiyliaiBK3bZ0PR3flyy2C5zLggJJ3+NcU+D2vwNdYvJeg4RVRxtX3R+AG3I
         9+y2oahjtUdTmDuK5kG3/62SgI9wjUPgwoyVnhKhTRWLcnNTkmXarn1SmlVncMTnKX
         zx7MZE9+7MFEwbrLaGlpjCcEkl9pwUCyc2Nu/Tt6WehiCv1z6sDdWOJXvyEEHPTPB4
         OXN3ZsX5aRbhw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 1/7] clk: mediatek: fhctl: Add support for older fhctl register layout
Date:   Mon,  6 Feb 2023 11:00:59 +0100
Message-Id: <20230206100105.861720-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
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

The Frequency Hopping Controller (FHCTL) seems to have different
versions, as it has a slightly different register layout on some
older SoCs like MT6795, MT8173, MT8183 (and others).

This driver is indeed compatible with at least some of those older
IP revisions, so all we need to do is to add a way to select the
right register layout at registration time.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-fhctl.c             | 26 +++++++++++++++++---
 drivers/clk/mediatek/clk-fhctl.h             |  9 ++++++-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c |  2 ++
 drivers/clk/mediatek/clk-pllfh.c             | 23 +++++++++++++----
 drivers/clk/mediatek/clk-pllfh.h             |  1 +
 5 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-fhctl.c b/drivers/clk/mediatek/clk-fhctl.c
index 4f271acef5fe..45e4842cbf04 100644
--- a/drivers/clk/mediatek/clk-fhctl.c
+++ b/drivers/clk/mediatek/clk-fhctl.c
@@ -14,7 +14,20 @@
 #define PERCENT_TO_DDSLMT(dds, percent_m10) \
 	((((dds) * (percent_m10)) >> 5) / 100)
 
-static const struct fhctl_offset fhctl_offset = {
+const struct fhctl_offset fhctl_offset_v1 = {
+	.offset_hp_en = 0x0,
+	.offset_clk_con = 0x4,
+	.offset_rst_con = 0x8,
+	.offset_slope0 = 0xc,
+	.offset_slope1 = 0x10,
+	.offset_cfg = 0x0,
+	.offset_updnlmt = 0x4,
+	.offset_dds = 0x8,
+	.offset_dvfs = 0xc,
+	.offset_mon = 0x10,
+};
+
+const struct fhctl_offset fhctl_offset_v2 = {
 	.offset_hp_en = 0x0,
 	.offset_clk_con = 0x8,
 	.offset_rst_con = 0xc,
@@ -27,9 +40,16 @@ static const struct fhctl_offset fhctl_offset = {
 	.offset_mon = 0x10,
 };
 
-const struct fhctl_offset *fhctl_get_offset_table(void)
+const struct fhctl_offset *fhctl_get_offset_table(enum fhctl_variant v)
 {
-	return &fhctl_offset;
+	switch (v) {
+	case FHCTL_PLLFH_V1:
+		return &fhctl_offset_v1;
+	case FHCTL_PLLFH_V2:
+		return &fhctl_offset_v2;
+	default:
+		return ERR_PTR(-EINVAL);
+	};
 }
 
 static void dump_hw(struct mtk_clk_pll *pll, struct fh_pll_regs *regs,
diff --git a/drivers/clk/mediatek/clk-fhctl.h b/drivers/clk/mediatek/clk-fhctl.h
index 51275febf086..bfa6d281a3ee 100644
--- a/drivers/clk/mediatek/clk-fhctl.h
+++ b/drivers/clk/mediatek/clk-fhctl.h
@@ -7,6 +7,13 @@
 #ifndef __CLK_FHCTL_H
 #define __CLK_FHCTL_H
 
+#include "clk-pllfh.h"
+
+enum fhctl_variant {
+	FHCTL_PLLFH_V1,
+	FHCTL_PLLFH_V2,
+};
+
 struct fhctl_offset {
 	u32 offset_hp_en;
 	u32 offset_clk_con;
@@ -19,7 +26,7 @@ struct fhctl_offset {
 	u32 offset_dvfs;
 	u32 offset_mon;
 };
-const struct fhctl_offset *fhctl_get_offset_table(void);
+const struct fhctl_offset *fhctl_get_offset_table(enum fhctl_variant v);
 const struct fh_operation *fhctl_get_ops(void);
 void fhctl_hw_init(struct mtk_fh *fh);
 
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index 1d673c6278a9..9fded5020ca4 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/mt8186-clk.h>
 
+#include "clk-fhctl.h"
 #include "clk-mtk.h"
 #include "clk-pll.h"
 #include "clk-pllfh.h"
@@ -98,6 +99,7 @@ enum fh_pll_id {
 		.data = {						\
 			.pll_id = _pllid,				\
 			.fh_id = _fhid,					\
+			.fh_ver = FHCTL_PLLFH_V2,			\
 			.fhx_offset = _offset,				\
 			.dds_mask = GENMASK(21, 0),			\
 			.slope0_value = 0x6003c97,			\
diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index f48780bec507..b9297726f5a0 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -104,14 +104,16 @@ void fhctl_parse_dt(const u8 *compatible_node, struct mtk_pllfh_data *pllfhs,
 	}
 }
 
-static void pllfh_init(struct mtk_fh *fh, struct mtk_pllfh_data *pllfh_data)
+static int pllfh_init(struct mtk_fh *fh, struct mtk_pllfh_data *pllfh_data)
 {
 	struct fh_pll_regs *regs = &fh->regs;
 	const struct fhctl_offset *offset;
 	void __iomem *base = pllfh_data->state.base;
 	void __iomem *fhx_base = base + pllfh_data->data.fhx_offset;
 
-	offset = fhctl_get_offset_table();
+	offset = fhctl_get_offset_table(pllfh_data->data.fh_ver);
+	if (IS_ERR(offset))
+		return PTR_ERR(offset);
 
 	regs->reg_hp_en = base + offset->offset_hp_en;
 	regs->reg_clk_con = base + offset->offset_clk_con;
@@ -129,6 +131,8 @@ static void pllfh_init(struct mtk_fh *fh, struct mtk_pllfh_data *pllfh_data)
 	fh->lock = &pllfh_lock;
 
 	fh->ops = fhctl_get_ops();
+
+	return 0;
 }
 
 static bool fhctl_is_supported_and_enabled(const struct mtk_pllfh_data *pllfh)
@@ -142,20 +146,29 @@ mtk_clk_register_pllfh(const struct mtk_pll_data *pll_data,
 {
 	struct clk_hw *hw;
 	struct mtk_fh *fh;
+	int ret;
 
 	fh = kzalloc(sizeof(*fh), GFP_KERNEL);
 	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
-	pllfh_init(fh, pllfh_data);
+	ret = pllfh_init(fh, pllfh_data);
+	if (ret) {
+		hw = ERR_PTR(ret);
+		goto out;
+	}
 
 	hw = mtk_clk_register_pll_ops(&fh->clk_pll, pll_data, base,
 				      &mtk_pllfh_ops);
 
+	if (IS_ERR(hw))
+		goto out;
+
+	fhctl_hw_init(fh);
+
+out:
 	if (IS_ERR(hw))
 		kfree(fh);
-	else
-		fhctl_hw_init(fh);
 
 	return hw;
 }
diff --git a/drivers/clk/mediatek/clk-pllfh.h b/drivers/clk/mediatek/clk-pllfh.h
index c0a6e1537034..5f419c2ec01f 100644
--- a/drivers/clk/mediatek/clk-pllfh.h
+++ b/drivers/clk/mediatek/clk-pllfh.h
@@ -18,6 +18,7 @@ struct fh_pll_state {
 struct fh_pll_data {
 	int pll_id;
 	int fh_id;
+	int fh_ver;
 	u32 fhx_offset;
 	u32 dds_mask;
 	u32 slope0_value;
-- 
2.39.1

