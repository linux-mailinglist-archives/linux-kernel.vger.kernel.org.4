Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B46C60E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCWHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCWHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:35:43 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50281816F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:35:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VeTb.bu_1679556935;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VeTb.bu_1679556935)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 15:35:36 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     neil.armstrong@linaro.org
Cc:     khilman@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] phy: dphy: Use devm_platform_ioremap_resource()
Date:   Thu, 23 Mar 2023 15:35:34 +0800
Message-Id: <20230323073534.75037-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit 7945f929f1a7 ("drivers: provide
devm_platform_ioremap_resource()"), convert platform_get_resource(),
devm_ioremap_resource() to a single call to use
devm_platform_ioremap_resource(), as this is exactly what this function
does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
index 32d1ff09befb..6e9af79e152c 100644
--- a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
+++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
@@ -335,7 +335,6 @@ static int phy_meson_axg_mipi_dphy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 	struct phy_meson_axg_mipi_dphy_priv *priv;
 	struct phy *phy;
 	void __iomem *base;
@@ -348,8 +347,7 @@ static int phy_meson_axg_mipi_dphy_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	platform_set_drvdata(pdev, priv);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.20.1.7.g153144c

