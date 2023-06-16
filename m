Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB280732580
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbjFPC7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFPC7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:59:44 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 648252953;
        Thu, 15 Jun 2023 19:59:41 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(18395:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 16 Jun 2023 10:59:25 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 16 Jun
 2023 10:59:25 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 16 Jun 2023 10:59:25 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>
CC:     <tony@atomide.com>, <lgirdwood@gmail.com>, <jneanne@baylibre.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH] regulator: tps65219: Fix pointer assignment in tps65219_get_rdev_by_name()
Date:   Fri, 16 Jun 2023 10:59:24 +0800
Message-ID: <1686884364-31447-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

For the pointer assignment in function body, double pointer must be used as
the input parameter.

Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

I try to fix W=1 build warning for tps65219-regulator.

W=1
    warning: parameter ‘dev’ set but not used [-Wunused-but-set-parameter]
    struct regulator_dev *dev)
                         ^~~~~
But the issue is not what the warning message described.

In tps65219_get_rdev_by_name(), it must return the found rdev and assign it
in 'dev' pointer. Due to pointer assignment issue, it doesn't.

The original code may not cause any problem. But it always takes the last
registered regulator rdev for all tps65219 regulator interrupts.
---
 drivers/regulator/tps65219-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index b1719ee990ab..8971b507a79a 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -289,13 +289,13 @@ static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
 
 static int tps65219_get_rdev_by_name(const char *regulator_name,
 				     struct regulator_dev *rdevtbl[7],
-				     struct regulator_dev *dev)
+				     struct regulator_dev **dev)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
 		if (strcmp(regulator_name, regulators[i].name) == 0) {
-			dev = rdevtbl[i];
+			*dev = rdevtbl[i];
 			return 0;
 		}
 	}
@@ -348,7 +348,7 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 		irq_data[i].dev = tps->dev;
 		irq_data[i].type = irq_type;
 
-		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
+		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, &rdev);
 		if (IS_ERR(rdev)) {
 			dev_err(tps->dev, "Failed to get rdev for %s\n",
 				irq_type->regulator_name);
-- 
2.40.1

