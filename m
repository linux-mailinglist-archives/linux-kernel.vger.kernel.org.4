Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2C5E5E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIVJTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiIVJTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:19:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC56D0784;
        Thu, 22 Sep 2022 02:19:06 -0700 (PDT)
X-UUID: 042a1040e89b44599c10b697c1b1e6d8-20220922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XnxHQeyRg7mdkgxVQVx57nhanzlW4hqsnYyMHyZViKw=;
        b=LJcxduw/Gb8tyfDQ5ybfzwM6EMkxrTBg3Shz4xZvTKSTR2Sa94B4SclQdKQBQKEkim5Rh9VdM948Un4BpQreVh2R+1EJZoD6O/QrGmVrMo41NQA6Jlz864jDHj8HlkfMXGqZyaiJFXNe5vm4jTWWi/WAyE89Tx4uZs+jDYPYdUk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:44171621-5f6a-481b-b7e3-b372fee6b1cb,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:44171621-5f6a-481b-b7e3-b372fee6b1cb,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:3417e0e3-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220922171902S3939IWH,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 042a1040e89b44599c10b697c1b1e6d8-20220922
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1121008601; Thu, 22 Sep 2022 17:19:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Sep 2022 17:18:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Sep 2022 17:18:58 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/7] clk: mediatek: mt6779: use mtk_clk_simple_probe to simplify driver
Date:   Thu, 22 Sep 2022 17:18:32 +0800
Message-ID: <20220922091841.4099-5-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220922091841.4099-1-miles.chen@mediatek.com>
References: <20220922091841.4099-1-miles.chen@mediatek.com>
MIME-Version: 1.0
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

mtk_clk_simple_probe was added by Chun-Jie to simply common flow
of MediaTek clock drivers and ChenYu enhanced the error path of
mtk_clk_simple_probe and added mtk_clk_simple_remove.

Let's use mtk_clk_simple_probe and mtk_clk_simple_probe in other
MediaTek clock drivers as well.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt6779-aud.c  | 29 ++++++++++++--------------
 drivers/clk/mediatek/clk-mt6779-cam.c  | 29 ++++++++++++--------------
 drivers/clk/mediatek/clk-mt6779-img.c  | 29 ++++++++++++--------------
 drivers/clk/mediatek/clk-mt6779-ipe.c  | 29 ++++++++++++--------------
 drivers/clk/mediatek/clk-mt6779-mfg.c  | 27 +++++++++++-------------
 drivers/clk/mediatek/clk-mt6779-vdec.c | 29 ++++++++++++--------------
 drivers/clk/mediatek/clk-mt6779-venc.c | 29 ++++++++++++--------------
 7 files changed, 90 insertions(+), 111 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
index 97e44abb7e87..6e473ae1fd90 100644
--- a/drivers/clk/mediatek/clk-mt6779-aud.c
+++ b/drivers/clk/mediatek/clk-mt6779-aud.c
@@ -89,26 +89,23 @@ static const struct mtk_gate audio_clks[] = {
 		    "audio_h_sel", 31),
 };
 
-static const struct of_device_id of_match_clk_mt6779_aud[] = {
-	{ .compatible = "mediatek,mt6779-audio", },
-	{}
+static const struct mtk_clk_desc audio_desc = {
+	.clks = audio_clks,
+	.num_clks = ARRAY_SIZE(audio_clks),
 };
 
-static int clk_mt6779_aud_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
-
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct of_device_id of_match_clk_mt6779_aud[] = {
+	{
+		.compatible = "mediatek,mt6779-audio",
+		.data = &audio_desc,
+	}, {
+		/* sentinel */
+	}
+};
 
 static struct platform_driver clk_mt6779_aud_drv = {
-	.probe = clk_mt6779_aud_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-aud",
 		.of_match_table = of_match_clk_mt6779_aud,
diff --git a/drivers/clk/mediatek/clk-mt6779-cam.c b/drivers/clk/mediatek/clk-mt6779-cam.c
index 9c5117aae146..7be3db90fa4a 100644
--- a/drivers/clk/mediatek/clk-mt6779-cam.c
+++ b/drivers/clk/mediatek/clk-mt6779-cam.c
@@ -38,26 +38,23 @@ static const struct mtk_gate cam_clks[] = {
 	GATE_CAM(CLK_CAM_FAKE_ENG, "camsys_fake_eng", "cam_sel", 14),
 };
 
-static const struct of_device_id of_match_clk_mt6779_cam[] = {
-	{ .compatible = "mediatek,mt6779-camsys", },
-	{}
+static const struct mtk_clk_desc cam_desc = {
+	.clks = cam_clks,
+	.num_clks = ARRAY_SIZE(cam_clks),
 };
 
-static int clk_mt6779_cam_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_CAM_NR_CLK);
-
-	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks),
-			       clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct of_device_id of_match_clk_mt6779_cam[] = {
+	{
+		.compatible = "mediatek,mt6779-camsys",
+		.data = &cam_desc,
+	}, {
+		/* sentinel */
+	}
+};
 
 static struct platform_driver clk_mt6779_cam_drv = {
-	.probe = clk_mt6779_cam_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-cam",
 		.of_match_table = of_match_clk_mt6779_cam,
diff --git a/drivers/clk/mediatek/clk-mt6779-img.c b/drivers/clk/mediatek/clk-mt6779-img.c
index 801271477d46..9bc51fc82dbd 100644
--- a/drivers/clk/mediatek/clk-mt6779-img.c
+++ b/drivers/clk/mediatek/clk-mt6779-img.c
@@ -30,26 +30,23 @@ static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_WPE_A, "imgsys_wpe_a", "img_sel", 7),
 };
 
-static const struct of_device_id of_match_clk_mt6779_img[] = {
-	{ .compatible = "mediatek,mt6779-imgsys", },
-	{}
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
 };
 
-static int clk_mt6779_img_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
-
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-			       clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct of_device_id of_match_clk_mt6779_img[] = {
+	{
+		.compatible = "mediatek,mt6779-imgsys",
+		.data = &img_desc,
+	}, {
+		/* sentinel */
+	}
+};
 
 static struct platform_driver clk_mt6779_img_drv = {
-	.probe = clk_mt6779_img_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-img",
 		.of_match_table = of_match_clk_mt6779_img,
diff --git a/drivers/clk/mediatek/clk-mt6779-ipe.c b/drivers/clk/mediatek/clk-mt6779-ipe.c
index f67814ca7dfb..92e9d1ade422 100644
--- a/drivers/clk/mediatek/clk-mt6779-ipe.c
+++ b/drivers/clk/mediatek/clk-mt6779-ipe.c
@@ -32,26 +32,23 @@ static const struct mtk_gate ipe_clks[] = {
 	GATE_IPE(CLK_IPE_DPE, "ipe_dpe", "ipe_sel", 6),
 };
 
-static const struct of_device_id of_match_clk_mt6779_ipe[] = {
-	{ .compatible = "mediatek,mt6779-ipesys", },
-	{}
+static const struct mtk_clk_desc ipe_desc = {
+	.clks = ipe_clks,
+	.num_clks = ARRAY_SIZE(ipe_clks),
 };
 
-static int clk_mt6779_ipe_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IPE_NR_CLK);
-
-	mtk_clk_register_gates(node, ipe_clks, ARRAY_SIZE(ipe_clks),
-			       clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct of_device_id of_match_clk_mt6779_ipe[] = {
+	{
+		.compatible = "mediatek,mt6779-ipesys",
+		.data = &ipe_desc,
+	}, {
+		/* sentinel */
+	}
+};
 
 static struct platform_driver clk_mt6779_ipe_drv = {
-	.probe = clk_mt6779_ipe_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-ipe",
 		.of_match_table = of_match_clk_mt6779_ipe,
diff --git a/drivers/clk/mediatek/clk-mt6779-mfg.c b/drivers/clk/mediatek/clk-mt6779-mfg.c
index fc7387b59758..efc793a1969a 100644
--- a/drivers/clk/mediatek/clk-mt6779-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6779-mfg.c
@@ -27,26 +27,23 @@ static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFGCFG_BG3D, "mfg_bg3d", "mfg_sel", 0),
 };
 
-static int clk_mt6779_mfg_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_MFGCFG_NR_CLK);
-
-	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
-			       clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc mfg_desc = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
 
 static const struct of_device_id of_match_clk_mt6779_mfg[] = {
-	{ .compatible = "mediatek,mt6779-mfgcfg", },
-	{}
+	{
+		.compatible = "mediatek,mt6779-mfgcfg",
+		.data = &mfg_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt6779_mfg_drv = {
-	.probe = clk_mt6779_mfg_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-mfg",
 		.of_match_table = of_match_clk_mt6779_mfg,
diff --git a/drivers/clk/mediatek/clk-mt6779-vdec.c b/drivers/clk/mediatek/clk-mt6779-vdec.c
index 7e195b082e86..3209a6518d5b 100644
--- a/drivers/clk/mediatek/clk-mt6779-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6779-vdec.c
@@ -39,26 +39,23 @@ static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC1_I(CLK_VDEC_LARB1, "vdec_larb1_cken", "vdec_sel", 0),
 };
 
-static const struct of_device_id of_match_clk_mt6779_vdec[] = {
-	{ .compatible = "mediatek,mt6779-vdecsys", },
-	{}
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
 };
 
-static int clk_mt6779_vdec_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_GCON_NR_CLK);
-
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-			       clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct of_device_id of_match_clk_mt6779_vdec[] = {
+	{
+		.compatible = "mediatek,mt6779-vdecsys",
+		.data = &vdec_desc,
+	}, {
+		/* sentinel */
+	}
+};
 
 static struct platform_driver clk_mt6779_vdec_drv = {
-	.probe = clk_mt6779_vdec_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-vdec",
 		.of_match_table = of_match_clk_mt6779_vdec,
diff --git a/drivers/clk/mediatek/clk-mt6779-venc.c b/drivers/clk/mediatek/clk-mt6779-venc.c
index 573efa87c9bd..c25035c0f334 100644
--- a/drivers/clk/mediatek/clk-mt6779-venc.c
+++ b/drivers/clk/mediatek/clk-mt6779-venc.c
@@ -30,26 +30,23 @@ static const struct mtk_gate venc_clks[] = {
 	GATE_VENC_I(CLK_VENC_GCON_GALS, "venc_gals", "venc_sel", 28),
 };
 
-static const struct of_device_id of_match_clk_mt6779_venc[] = {
-	{ .compatible = "mediatek,mt6779-vencsys", },
-	{}
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
 };
 
-static int clk_mt6779_venc_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_VENC_GCON_NR_CLK);
-
-	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-			       clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct of_device_id of_match_clk_mt6779_venc[] = {
+	{
+		.compatible = "mediatek,mt6779-vencsys",
+		.data = &venc_desc,
+	}, {
+		/* sentinel */
+	}
+};
 
 static struct platform_driver clk_mt6779_venc_drv = {
-	.probe = clk_mt6779_venc_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-venc",
 		.of_match_table = of_match_clk_mt6779_venc,
-- 
2.18.0

