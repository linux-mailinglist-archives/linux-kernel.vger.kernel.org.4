Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3B6D4264
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjDCKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjDCKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:42:40 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F254610264;
        Mon,  3 Apr 2023 03:42:29 -0700 (PDT)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        (user=void0red@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 333Ad1oW026913-333Ad1oX026913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Apr 2023 18:39:01 +0800
From:   Kang Chen <void0red@hust.edu.cn>
To:     dzm91@hust.edu.cn
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
        rdunlap@infradead.org, bchihi@baylibre.com, henry.yen@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        hust-os-kernel-patches@googlegroups.com, void0red@gmail.com,
        error27@gmail.com, Kang Chen <void0red@hust.edu.cn>
Subject: [PATCH] drivers: thermal: mediatek: fix of_iomap leak in mtk_thermal_probe
Date:   Mon,  3 Apr 2023 18:38:55 +0800
Message-Id: <20230403103855.3601901-1-void0red@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
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

Smatch reports:
1. mtk_thermal_probe() warn: 'apmixed_base' from of_iomap() not released.
2. mtk_thermal_probe() warn: 'auxadc_base' from of_iomap() not released.

The original code forgets to release iomap resource when handling errors,
fix it through unified error handling code at the end of mtk_thermal_probe.

Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
Signed-off-by: Kang Chen <void0red@hust.edu.cn>
---
I think the this should be released on the success path but I was too
scared of breaking things. Let me know and I will resend if people want
me to do that.

 drivers/thermal/mediatek/auxadc_thermal.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index ab730f9552d0..741c7d8151bd 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1149,13 +1149,15 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	if (auxadc_phys_base == OF_BAD_ADDR) {
 		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_iounmap_auxadc;
 	}
 
 	apmixedsys = of_parse_phandle(np, "mediatek,apmixedsys", 0);
 	if (!apmixedsys) {
 		dev_err(&pdev->dev, "missing apmixedsys node\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_iounmap_auxadc;
 	}
 
 	apmixed_base = of_iomap(apmixedsys, 0);
@@ -1165,17 +1167,18 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	if (apmixed_phys_base == OF_BAD_ADDR) {
 		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_iounmap_apmixed;
 	}
 
 	ret = device_reset_optional(&pdev->dev);
 	if (ret)
-		return ret;
+		goto err_iounmap_apmixed;
 
 	ret = clk_prepare_enable(mt->clk_auxadc);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
-		return ret;
+		goto err_iounmap_apmixed;
 	}
 
 	ret = clk_prepare_enable(mt->clk_peri_therm);
@@ -1220,7 +1223,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mt->clk_peri_therm);
 err_disable_clk_auxadc:
 	clk_disable_unprepare(mt->clk_auxadc);
-
+err_iounmap_apmixed:
+	iounmap(apmixed_base);
+err_iounmap_auxadc:
+	iounmap(auxadc_base);
 	return ret;
 }
 
-- 
2.34.1

