Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD406D4E54
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjDCQsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjDCQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:48:36 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084719B7;
        Mon,  3 Apr 2023 09:48:32 -0700 (PDT)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        (user=void0red@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 333GkBiv000418-333GkBiw000418
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Apr 2023 00:46:11 +0800
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
Subject: [PATCH v2 1/2] thermal: mediatek: use devm_of_iomap to avoid resource leak in mtk_thermal_probe
Date:   Tue,  4 Apr 2023 00:46:09 +0800
Message-Id: <20230403164610.3608082-1-void0red@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6e3c59c3-8ad0-9c53-62a4-7be6f55a7c02@linaro.org>
References: <6e3c59c3-8ad0-9c53-62a4-7be6f55a7c02@linaro.org>
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
fix it by switch to devm_of_iomap.

Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
Signed-off-by: Kang Chen <void0red@hust.edu.cn>
---
v2 -> v1: use devm_of_iomap instead.

 drivers/thermal/mediatek/auxadc_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index ab730f9552d0..df5e2e354408 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1142,7 +1142,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	auxadc_base = of_iomap(auxadc, 0);
+	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
+	if (IS_ERR(auxadc_base))
+		return PTR_ERR(auxadc_base);
+
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1158,7 +1161,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	apmixed_base = of_iomap(apmixedsys, 0);
+	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
+	if (IS_ERR(apmixed_base)
+		return PTR_ERR(apmixed_base);
+
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);
-- 
2.34.1

