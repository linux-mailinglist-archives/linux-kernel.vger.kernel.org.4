Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6466E49DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDQNZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDQNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:24:35 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A815FEB;
        Mon, 17 Apr 2023 06:24:28 -0700 (PDT)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        (user=void0red@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33HCtsCs000971-33HCtsCu000971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Apr 2023 20:55:55 +0800
From:   Kang Chen <void0red@hust.edu.cn>
To:     error27@gmail.com
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel.lezcano@linaro.org,
        daniel@makrotopia.org, dzm91@hust.edu.cn, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com, void0red@hust.edu.cn
Subject: [PATCH v4 2/2] thermal: mediatek: change clk_prepare_enable to devm_clk_get_enabled in mtk_thermal_probe
Date:   Mon, 17 Apr 2023 20:55:33 +0800
Message-Id: <20230417125533.3142236-2-void0red@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417125533.3142236-1-void0red@hust.edu.cn>
References: <48ae0e2e-257d-4ad2-afbc-2eb4b48e516b@kili.mountain>
 <20230417125533.3142236-1-void0red@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: void0red@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use devm_clk_get_enabled to do automatic resource management.
Meanwhile, remove error handling labels in the probe function and
the whole remove function.

Signed-off-by: Kang Chen <void0red@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v4 -> v3: port to linux-next tree
v3 -> v2: remove some useles func calls.
v2 -> v1: init

 drivers/thermal/mediatek/auxadc_thermal.c | 48 +++++------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index dcc64237ea60..18c8cce960c3 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1186,14 +1186,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	mt->conf = of_device_get_match_data(&pdev->dev);
 
-	mt->clk_peri_therm = devm_clk_get(&pdev->dev, "therm");
-	if (IS_ERR(mt->clk_peri_therm))
-		return PTR_ERR(mt->clk_peri_therm);
-
-	mt->clk_auxadc = devm_clk_get(&pdev->dev, "auxadc");
-	if (IS_ERR(mt->clk_auxadc))
-		return PTR_ERR(mt->clk_auxadc);
-
 	mt->thermal_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(mt->thermal_base))
 		return PTR_ERR(mt->thermal_base);
@@ -1252,16 +1244,16 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(mt->clk_auxadc);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
-		return ret;
+	mt->clk_auxadc = devm_clk_get_enabled(&pdev->dev, "auxadc");
+	if (IS_ERR(mt->clk_auxadc)) {
+		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", mt->clk_auxadc);
+		return PTR_ERR(mt->clk_auxadc);
 	}
 
-	ret = clk_prepare_enable(mt->clk_peri_therm);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
-		goto err_disable_clk_auxadc;
+	mt->clk_peri_therm = devm_clk_get_enabled(&pdev->dev, "therm");
+	if (IS_ERR(mt->clk_peri_therm)) {
+		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", mt->clk_peri_therm);
+		return PTR_ERR(mt->clk_peri_therm);
 	}
 
 	mtk_thermal_turn_on_buffer(mt, apmixed_base);
@@ -1288,38 +1280,18 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
 					      &mtk_thermal_ops);
-	if (IS_ERR(tzdev)) {
-		ret = PTR_ERR(tzdev);
-		goto err_disable_clk_peri_therm;
-	}
+	if (IS_ERR(tzdev))
+		return PTR_ERR(tzdev);
 
 	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
 	if (ret)
 		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
 
 	return 0;
-
-err_disable_clk_peri_therm:
-	clk_disable_unprepare(mt->clk_peri_therm);
-err_disable_clk_auxadc:
-	clk_disable_unprepare(mt->clk_auxadc);
-
-	return ret;
-}
-
-static int mtk_thermal_remove(struct platform_device *pdev)
-{
-	struct mtk_thermal *mt = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(mt->clk_peri_therm);
-	clk_disable_unprepare(mt->clk_auxadc);
-
-	return 0;
 }
 
 static struct platform_driver mtk_thermal_driver = {
 	.probe = mtk_thermal_probe,
-	.remove = mtk_thermal_remove,
 	.driver = {
 		.name = "mtk-thermal",
 		.of_match_table = mtk_thermal_of_match,
-- 
2.34.1

