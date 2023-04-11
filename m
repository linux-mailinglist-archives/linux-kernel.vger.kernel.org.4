Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEACE6DD2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDKGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDKGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:37:49 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517821FC4;
        Mon, 10 Apr 2023 23:37:44 -0700 (PDT)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        (user=void0red@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33B6ZWKa016709-33B6ZWKc016709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Apr 2023 14:35:32 +0800
From:   Kang Chen <void0red@hust.edu.cn>
To:     daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn,
        error27@gmail.com, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com, void0red@hust.edu.cn
Subject: [PATCH v3 2/2] thermal: mediatek: change clk_prepare_enable to devm_clk_get_enabled in mtk_thermal_probe
Date:   Tue, 11 Apr 2023 14:35:31 +0800
Message-Id: <20230411063531.3976354-2-void0red@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411063531.3976354-1-void0red@hust.edu.cn>
References: <b2e5ef14-9a12-15d5-8016-d0994c1177c3@linaro.org>
 <20230411063531.3976354-1-void0red@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: void0red@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v3 -> v2: remove some useles func calls.
v2 -> v1: init

Notice the devm_clk_get_enabled do the clk_get and clk_prepare_enable
at the same time.
I'm not sure if this has any side effects in initialization.

 drivers/thermal/mediatek/auxadc_thermal.c | 48 +++++------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 3372f7c29626..995837ce3ea2 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1116,14 +1116,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
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
@@ -1182,16 +1174,16 @@ static int mtk_thermal_probe(struct platform_device *pdev)
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
 
 	if (mt->conf->version != MTK_THERMAL_V1) {
@@ -1215,38 +1207,18 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
 					      &mtk_thermal_ops);
-	if (IS_ERR(tzdev)) {
-		ret = PTR_ERR(tzdev);
-		goto err_disable_clk_peri_therm;
-	}
+	if (IS_ERR(tzdev))
+		return PTR_ERR(tzdev);
 
 	ret = devm_thermal_add_hwmon_sysfs(tzdev);
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

