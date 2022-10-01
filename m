Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3CC5F1998
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiJAD1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiJADZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:25:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B7F80AB;
        Fri, 30 Sep 2022 20:17:54 -0700 (PDT)
X-UUID: faca22d3819b4747866305462f157480-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6YODgIkJ5B15rmZrHBBzn4vXZqLJDx2Vv+ld3YAklVw=;
        b=BeKcGngxtsDwUgxfExAHhJ62eqMc67XCvWM9wwq9dHVb4jLKLqcqNdm5rDBu05Pncg+kPhfiowWuqdnRwBMK+Iwn72B7E5PbZkzQ5IA53gNPRXRdowSOr+mqK135ByJUNeR67niW3CueeNs9Ong0IRYF+yyRSOXglYN04Ex0m5Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:42a16988-44c9-4e81-bcd4-e7d27477ff69,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:cb3ed6e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: faca22d3819b4747866305462f157480-20221001
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 124696460; Sat, 01 Oct 2022 11:17:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:17:47 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:17:46 +0800
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
Subject: [PATCH v6, 6/8] media: mediatek: vcodec: Refactor encoder clock on/off function
Date:   Sat, 1 Oct 2022 11:17:35 +0800
Message-ID: <20221001031737.18266-7-irui.wang@mediatek.com>
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

when enable multi-core encoding, encoder cores use their own clock,
refactor clock management functions with used encoder hardware id.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       | 89 ++++++++++++++++---
 .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |  6 +-
 .../platform/mediatek/vcodec/venc_drv_if.c    |  4 +-
 3 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index 213c3f50e9eb..2f83aade779a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -60,7 +60,9 @@ EXPORT_SYMBOL_GPL(mtk_vcodec_init_enc_clk);
 static int mtk_enc_core_power_on(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_venc_hw_dev *sub_core;
+	struct mtk_vcodec_clk *clk;
 	int ret, i;
+	int j = 0;
 
 	/* multi-core encoding need power on all available cores */
 	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
@@ -73,12 +75,27 @@ static int mtk_enc_core_power_on(struct mtk_vcodec_ctx *ctx)
 			mtk_v4l2_err("power on sub_core[%d] fail %d", i, ret);
 			goto pm_on_fail;
 		}
+
+		clk = &sub_core->pm.venc_clk;
+		for (j = 0; j < clk->clk_num; j++) {
+			ret = clk_prepare(clk->clk_info[j].vcodec_clk);
+			if (ret) {
+				mtk_v4l2_err("prepare clk [%s] fail %d",
+					     clk->clk_info[j].clk_name, ret);
+				goto pm_on_fail;
+			}
+		}
 	}
 	return ret;
 
 pm_on_fail:
 	for (i -= 1; i >= 0; i--) {
 		sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[i];
+
+		clk = &sub_core->pm.venc_clk;
+		for (j -= 1; j >= 0; j--)
+			clk_unprepare(clk->clk_info[j].vcodec_clk);
+
 		pm_runtime_put_sync(&sub_core->plat_dev->dev);
 	}
 	return ret;
@@ -87,7 +104,9 @@ static int mtk_enc_core_power_on(struct mtk_vcodec_ctx *ctx)
 int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_vcodec_pm *pm = &ctx->dev->pm;
+	struct mtk_vcodec_clk *clk;
 	int ret;
+	int i = 0;
 
 	ret = pm_runtime_resume_and_get(pm->dev);
 	if (ret) {
@@ -95,6 +114,16 @@ int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx)
 		return ret;
 	}
 
+	clk = &pm->venc_clk;
+	for (i = 0; i < clk->clk_num; i++) {
+		ret = clk_prepare(clk->clk_info[i].vcodec_clk);
+		if (ret) {
+			mtk_v4l2_err("prepare clk [%s] fail %d",
+				     clk->clk_info[i].clk_name, ret);
+			goto clk_error;
+		}
+	}
+
 	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
 		ret = mtk_enc_core_power_on(ctx);
 		if (ret) {
@@ -104,6 +133,9 @@ int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx)
 	}
 	return ret;
 
+clk_error:
+	for (i -= 1; i >= 0; i--)
+		clk_unprepare(clk->clk_info[i].vcodec_clk);
 core_error:
 	pm_runtime_put_sync(pm->dev);
 	return ret;
@@ -112,7 +144,8 @@ int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx)
 static void mtk_enc_core_power_off(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_venc_hw_dev *sub_core;
-	int ret, i;
+	struct mtk_vcodec_clk *clk;
+	int ret, i, j;
 
 	/* multi-core encoding need power off all available cores */
 	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
@@ -120,6 +153,10 @@ static void mtk_enc_core_power_off(struct mtk_vcodec_ctx *ctx)
 		if (!sub_core)
 			continue;
 
+		clk = &sub_core->pm.venc_clk;
+		for (j = clk->clk_num - 1; j >= 0; j--)
+			clk_unprepare(clk->clk_info[j].vcodec_clk);
+
 		ret = pm_runtime_put_sync(&sub_core->plat_dev->dev);
 		if (ret)
 			mtk_v4l2_err("power off sub_core[%d] fail %d", i, ret);
@@ -129,26 +166,44 @@ static void mtk_enc_core_power_off(struct mtk_vcodec_ctx *ctx)
 void mtk_vcodec_enc_power_off(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_vcodec_pm *pm = &ctx->dev->pm;
-	int ret;
+	struct mtk_vcodec_clk *clk;
+	int ret, i;
 
 	if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
 		mtk_enc_core_power_off(ctx);
 
+	clk = &pm->venc_clk;
+	for (i = clk->clk_num - 1; i >= 0; i--)
+		clk_unprepare(clk->clk_info[i].vcodec_clk);
+
 	ret = pm_runtime_put_sync(pm->dev);
 	if (ret)
 		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
 }
 
-void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
+void mtk_vcodec_enc_clock_on(struct mtk_vcodec_dev *dev,
+			     enum mtk_venc_hw_id hw_id)
 {
-	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
+	struct mtk_venc_hw_dev *sub_core;
+	struct mtk_vcodec_clk *enc_clk;
+
 	int ret, i = 0;
 
+	if (hw_id == MTK_VENC_CORE_0) {
+		enc_clk = &dev->pm.venc_clk;
+	} else if (hw_id == MTK_VENC_CORE_1) {
+		sub_core = (struct mtk_venc_hw_dev *)dev->enc_hw_dev[hw_id];
+		enc_clk = &sub_core->pm.venc_clk;
+	} else {
+		mtk_v4l2_err("invalid hw id : %d", hw_id);
+		return;
+	}
+
 	for (i = 0; i < enc_clk->clk_num; i++) {
-		ret = clk_prepare_enable(enc_clk->clk_info[i].vcodec_clk);
+		ret = clk_enable(enc_clk->clk_info[i].vcodec_clk);
 		if (ret) {
-			mtk_v4l2_err("venc clk_prepare_enable %d %s fail %d", i,
-				enc_clk->clk_info[i].clk_name, ret);
+			mtk_v4l2_err("venc clk_enable %d %s fail %d", i,
+				     enc_clk->clk_info[i].clk_name, ret);
 			goto clkerr;
 		}
 	}
@@ -157,14 +212,26 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 
 clkerr:
 	for (i -= 1; i >= 0; i--)
-		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
+		clk_disable(enc_clk->clk_info[i].vcodec_clk);
 }
 
-void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
+void mtk_vcodec_enc_clock_off(struct mtk_vcodec_dev *dev,
+			      enum mtk_venc_hw_id hw_id)
 {
-	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
+	struct mtk_venc_hw_dev *sub_core;
+	struct mtk_vcodec_clk *enc_clk;
 	int i = 0;
 
+	if (hw_id == MTK_VENC_CORE_0) {
+		enc_clk = &dev->pm.venc_clk;
+	} else if (hw_id == MTK_VENC_CORE_1) {
+		sub_core = (struct mtk_venc_hw_dev *)dev->enc_hw_dev[hw_id];
+		enc_clk = &sub_core->pm.venc_clk;
+	} else {
+		mtk_v4l2_err("invalid hw id : %d", hw_id);
+		return;
+	}
+
 	for (i = enc_clk->clk_num - 1; i >= 0; i--)
-		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
+		clk_disable(enc_clk->clk_info[i].vcodec_clk);
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
index 9065dec4ed4f..a2906d2971ee 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
@@ -14,7 +14,9 @@ int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
 
 int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx);
 void mtk_vcodec_enc_power_off(struct mtk_vcodec_ctx *ctx);
-void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
-void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
+void mtk_vcodec_enc_clock_on(struct mtk_vcodec_dev *dev,
+			     enum mtk_venc_hw_id hw_id);
+void mtk_vcodec_enc_clock_off(struct mtk_vcodec_dev *dev,
+			      enum mtk_venc_hw_id hw_id);
 
 #endif /* _MTK_VCODEC_ENC_PM_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
index 65a27e39ef5b..6cbdb7e30bb3 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
@@ -64,10 +64,10 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 	ctx->dev->curr_ctx = ctx;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
-	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
+	mtk_vcodec_enc_clock_on(ctx->dev, 0);
 	ret = ctx->enc_if->encode(ctx->drv_handle, opt, frm_buf,
 				  bs_buf, result);
-	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
+	mtk_vcodec_enc_clock_off(ctx->dev, 0);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
 	ctx->dev->curr_ctx = NULL;
-- 
2.18.0

