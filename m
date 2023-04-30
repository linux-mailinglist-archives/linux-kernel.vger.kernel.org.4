Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06B6F2A66
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjD3TC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 15:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjD3TCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 15:02:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AED2D67
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 12:02:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJk-000109-Fz; Sun, 30 Apr 2023 21:02:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJj-000BkZ-Rq; Sun, 30 Apr 2023 21:02:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJj-000CVi-82; Sun, 30 Apr 2023 21:02:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH v2 3/3] clk: mediatek: Convert all remaining drivers to platform_driver's .remove_new()
Date:   Sun, 30 Apr 2023 21:02:33 +0200
Message-Id: <20230430190233.878921-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de>
References: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=21500; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LyvVxmvq7gd+HIJRafeDG+gpC/fJRPS6c3jKW5ziPl4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkTrtFGdhP+icM6iZX+CyKisGK/UiWQLqJt3ni+ iDEvkYVf5+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZE67RQAKCRCPgPtYfRL+ Tk3SCACgBOTjhie7tVrNMJ7Da4GO/na3aajyAM6gmB2TgnYcNirb6M9dq8qpglZ4AApq7VvZis9 L7KHdLf1uixITYocPVqWeEnVl7ezsQYKNad6EIsk3Lnf2sutaoRPnPn9HwCqXS7jbv36d81QN6r FlcSpuPG3meC6cmXDUgHIZGRjyTDzSNjUpatxwzyyXGsVeaoaxmCmrvmtXMtjzIYunUh6z2tGHZ hwqmP7GJF8UYo6QrEkXAyCtw2Yf7zhIEEfre56ZzubucJ0jSo2EcwyxlRrQD0pnUIdlnZ5V1pPi ONHzwldFFJOnDTRiZhNFGBiAiHLxoEa2qaFx7osNMliCe+wP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert all mediatek clk drivers from always returning zero in
the remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt6795-infracfg.c   | 6 ++----
 drivers/clk/mediatek/clk-mt6795-pericfg.c    | 6 ++----
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt7622-infracfg.c   | 6 ++----
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8173-infracfg.c   | 6 ++----
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8188-topckgen.c   | 6 ++----
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 6 ++----
 drivers/clk/mediatek/clk-mt8195-topckgen.c   | 6 ++----
 16 files changed, 32 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index 9d2fcda285fb..43272dc744c7 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -138,7 +138,7 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt2712_apmixed_remove(struct platform_device *pdev)
+static void clk_mt2712_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -146,8 +146,6 @@ static int clk_mt2712_apmixed_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt2712_apmixed[] = {
@@ -158,7 +156,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_apmixed);
 
 static struct platform_driver clk_mt2712_apmixed_drv = {
 	.probe = clk_mt2712_apmixed_probe,
-	.remove = clk_mt2712_apmixed_remove,
+	.remove_new = clk_mt2712_apmixed_remove,
 	.driver = {
 		.name = "clk-mt2712-apmixed",
 		.of_match_table = of_match_clk_mt2712_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
index 8b30109f253c..8c65974ed9b8 100644
--- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
@@ -187,7 +187,7 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt6795_apmixed_remove(struct platform_device *pdev)
+static void clk_mt6795_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -197,13 +197,11 @@ static int clk_mt6795_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
 				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt6795_apmixed_drv = {
 	.probe = clk_mt6795_apmixed_probe,
-	.remove = clk_mt6795_apmixed_remove,
+	.remove_new = clk_mt6795_apmixed_remove,
 	.driver = {
 		.name = "clk-mt6795-apmixed",
 		.of_match_table = of_match_clk_mt6795_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index 086ea1438564..06d7fdf3098b 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -127,7 +127,7 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt6795_infracfg_remove(struct platform_device *pdev)
+static void clk_mt6795_infracfg_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -136,8 +136,6 @@ static int clk_mt6795_infracfg_remove(struct platform_device *pdev)
 	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
 	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt6795_infracfg_drv = {
@@ -146,7 +144,7 @@ static struct platform_driver clk_mt6795_infracfg_drv = {
 		.of_match_table = of_match_clk_mt6795_infracfg,
 	},
 	.probe = clk_mt6795_infracfg_probe,
-	.remove = clk_mt6795_infracfg_remove,
+	.remove_new = clk_mt6795_infracfg_remove,
 };
 module_platform_driver(clk_mt6795_infracfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index 62cc19eee2c7..3f6bea418a5a 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -136,7 +136,7 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt6795_pericfg_remove(struct platform_device *pdev)
+static void clk_mt6795_pericfg_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -145,8 +145,6 @@ static int clk_mt6795_pericfg_remove(struct platform_device *pdev)
 	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
 	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt6795_pericfg_drv = {
@@ -155,7 +153,7 @@ static struct platform_driver clk_mt6795_pericfg_drv = {
 		.of_match_table = of_match_clk_mt6795_pericfg,
 	},
 	.probe = clk_mt6795_pericfg_probe,
-	.remove = clk_mt6795_pericfg_remove,
+	.remove_new = clk_mt6795_pericfg_remove,
 };
 module_platform_driver(clk_mt6795_pericfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index a36808d074d6..9cffd278e9a4 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -119,7 +119,7 @@ static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt7622_apmixed_remove(struct platform_device *pdev)
+static void clk_mt7622_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -128,8 +128,6 @@ static int clk_mt7622_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
@@ -140,7 +138,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7622_apmixed);
 
 static struct platform_driver clk_mt7622_apmixed_drv = {
 	.probe = clk_mt7622_apmixed_probe,
-	.remove = clk_mt7622_apmixed_remove,
+	.remove_new = clk_mt7622_apmixed_remove,
 	.driver = {
 		.name = "clk-mt7622-apmixed",
 		.of_match_table = of_match_clk_mt7622_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt7622-infracfg.c b/drivers/clk/mediatek/clk-mt7622-infracfg.c
index 9dc05526f287..6bc911cb29a6 100644
--- a/drivers/clk/mediatek/clk-mt7622-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7622-infracfg.c
@@ -101,7 +101,7 @@ static int clk_mt7622_infracfg_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt7622_infracfg_remove(struct platform_device *pdev)
+static void clk_mt7622_infracfg_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -110,8 +110,6 @@ static int clk_mt7622_infracfg_remove(struct platform_device *pdev)
 	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
 	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt7622_infracfg_drv = {
@@ -120,7 +118,7 @@ static struct platform_driver clk_mt7622_infracfg_drv = {
 		.of_match_table = of_match_clk_mt7622_infracfg,
 	},
 	.probe = clk_mt7622_infracfg_probe,
-	.remove = clk_mt7622_infracfg_remove,
+	.remove_new = clk_mt7622_infracfg_remove,
 };
 module_platform_driver(clk_mt7622_infracfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index 744aae092281..d1239b4b3db7 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -73,7 +73,7 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt8135_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8135_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -81,8 +81,6 @@ static int clk_mt8135_apmixed_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt8135_apmixed[] = {
@@ -93,7 +91,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8135_apmixed);
 
 static struct platform_driver clk_mt8135_apmixed_drv = {
 	.probe = clk_mt8135_apmixed_probe,
-	.remove = clk_mt8135_apmixed_remove,
+	.remove_new = clk_mt8135_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8135-apmixed",
 		.of_match_table = of_match_clk_mt8135_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index 8c2aa8b0f39e..daa2856d1ab7 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -189,7 +189,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8173_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8173_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -199,13 +199,11 @@ static int clk_mt8173_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
 				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8173_apmixed_drv = {
 	.probe = clk_mt8173_apmixed_probe,
-	.remove = clk_mt8173_apmixed_remove,
+	.remove_new = clk_mt8173_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8173-apmixed",
 		.of_match_table = of_match_clk_mt8173_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index 4ed5043076ec..2f2f074e231a 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -129,7 +129,7 @@ static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8173_infracfg_remove(struct platform_device *pdev)
+static void clk_mt8173_infracfg_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -138,8 +138,6 @@ static int clk_mt8173_infracfg_remove(struct platform_device *pdev)
 	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
 	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8173_infracfg_drv = {
@@ -148,7 +146,7 @@ static struct platform_driver clk_mt8173_infracfg_drv = {
 		.of_match_table = of_match_clk_mt8173_infracfg,
 	},
 	.probe = clk_mt8173_infracfg_probe,
-	.remove = clk_mt8173_infracfg_remove,
+	.remove_new = clk_mt8173_infracfg_remove,
 };
 module_platform_driver(clk_mt8173_infracfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index da7950d51c64..fff64a8fd557 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -172,7 +172,7 @@ static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8186_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8186_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -181,13 +181,11 @@ static int clk_mt8186_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
 				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8186_apmixed_drv = {
 	.probe = clk_mt8186_apmixed_probe,
-	.remove = clk_mt8186_apmixed_remove,
+	.remove_new = clk_mt8186_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8186-apmixed",
 		.of_match_table = of_match_clk_mt8186_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
index 9d21da2d9aa7..3c1ace87796b 100644
--- a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
@@ -132,7 +132,7 @@ static int clk_mt8188_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8188_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8188_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -141,13 +141,11 @@ static int clk_mt8188_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8188_apmixed_drv = {
 	.probe = clk_mt8188_apmixed_probe,
-	.remove = clk_mt8188_apmixed_remove,
+	.remove_new = clk_mt8188_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8188-apmixed",
 		.of_match_table = of_match_clk_mt8188_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
index c56ec42cb15f..1ab30834a8ff 100644
--- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
@@ -1322,7 +1322,7 @@ static int clk_mt8188_topck_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8188_topck_remove(struct platform_device *pdev)
+static void clk_mt8188_topck_remove(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *top_clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
@@ -1334,13 +1334,11 @@ static int clk_mt8188_topck_remove(struct platform_device *pdev)
 	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
 	mtk_free_clk_data(top_clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8188_topck_drv = {
 	.probe = clk_mt8188_topck_probe,
-	.remove = clk_mt8188_topck_remove,
+	.remove_new = clk_mt8188_topck_remove,
 	.driver = {
 		.name = "clk-mt8188-topck",
 		.of_match_table = of_match_clk_mt8188_topck,
diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
index eafd34297b9a..3590932acc63 100644
--- a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
@@ -188,7 +188,7 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8192_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8192_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -198,8 +198,6 @@ static int clk_mt8192_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
 				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8192_apmixed_drv = {
@@ -208,7 +206,7 @@ static struct platform_driver clk_mt8192_apmixed_drv = {
 		.of_match_table = of_match_clk_mt8192_apmixed,
 	},
 	.probe = clk_mt8192_apmixed_probe,
-	.remove = clk_mt8192_apmixed_remove,
+	.remove_new = clk_mt8192_apmixed_remove,
 };
 module_platform_driver(clk_mt8192_apmixed_drv);
 MODULE_DESCRIPTION("MediaTek MT8192 apmixed clocks driver");
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 8b9b5d820286..502a9dc1fdb8 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -209,7 +209,7 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8195_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -219,13 +219,11 @@ static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
 				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_apmixed_drv = {
 	.probe = clk_mt8195_apmixed_probe,
-	.remove = clk_mt8195_apmixed_remove,
+	.remove_new = clk_mt8195_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8195-apmixed",
 		.of_match_table = of_match_clk_mt8195_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index de04c087c8c3..79762bc85cd7 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -85,7 +85,7 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
+static void clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
@@ -93,8 +93,6 @@ static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_plls(apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
@@ -105,7 +103,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_apusys_pll);
 
 static struct platform_driver clk_mt8195_apusys_pll_drv = {
 	.probe = clk_mt8195_apusys_pll_probe,
-	.remove = clk_mt8195_apusys_pll_remove,
+	.remove_new = clk_mt8195_apusys_pll_remove,
 	.driver = {
 		.name = "clk-mt8195-apusys_pll",
 		.of_match_table = of_match_clk_mt8195_apusys_pll,
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 3c2174c3e742..ffa4dc559867 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1317,7 +1317,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_topck_remove(struct platform_device *pdev)
+static void clk_mt8195_topck_remove(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *top_clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
@@ -1329,13 +1329,11 @@ static int clk_mt8195_topck_remove(struct platform_device *pdev)
 	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
 	mtk_free_clk_data(top_clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_topck_drv = {
 	.probe = clk_mt8195_topck_probe,
-	.remove = clk_mt8195_topck_remove,
+	.remove_new = clk_mt8195_topck_remove,
 	.driver = {
 		.name = "clk-mt8195-topck",
 		.of_match_table = of_match_clk_mt8195_topck,
-- 
2.39.2

