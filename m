Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51464DED5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiLOQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiLOQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:41:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BA20357;
        Thu, 15 Dec 2022 08:41:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1DB2B81C10;
        Thu, 15 Dec 2022 16:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D382C433D2;
        Thu, 15 Dec 2022 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122505;
        bh=qr+A41JYwJVtW3GKLurUHfsNl6BDsehK6/H/piVrKGU=;
        h=From:To:Cc:Subject:Date:From;
        b=Tfj+INVJjKCGmcs5qcMnIAFcmlg+jpYqEItRG67UtzFGQof2s0NFPLFZ0YE6yGYJ9
         BB9kWsCWlCpaDUzsaO7cXOm06CpmKU0Vk2p3sYwRhjt7QIvglk8+iCXRap+1zi3THE
         7PiOzBZ22xJXljAtIJ52Idr7/IGnm9aj3pUFKvDJ2Oyj8xaFPal++UaeTU9nRobAzk
         /J7HHorm7D8wQJ7/iAjxEc7ZMDC3ZIEJvdPGoXR9rvyiRaUSy05zEstsI60TXKo+Tc
         IZ5nlfoGeuLlD4oqeBr+H5JGFJeOJWBb++e2NoN4QDrUyCRJVs7ZBAED0mekmOP/9k
         adVQKoBf6+0uA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Axel Lin <axel.lin@ingics.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps65219: fix Wextra warning
Date:   Thu, 15 Dec 2022 17:41:28 +0100
Message-Id: <20221215164140.821796-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an invalid pointer comparison when building with
-Wextra enabled:

drivers/regulator/tps65219-regulator.c: In function 'tps65219_regulator_probe':
drivers/regulator/tps65219-regulator.c:370:26: error: ordered comparison of pointer with integer zero [-Werror=extra]
  370 |                 if (rdev < 0) {
      |                          ^

It appears that the intention here was to check for an error code, rather
than the pointer, so adapt the code to propagate the error from the
called function instead.

Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/regulator/tps65219-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index c484c943e467..fea3998334b1 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -366,11 +366,11 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 		irq_data[i].dev = tps->dev;
 		irq_data[i].type = irq_type;
 
-		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
-		if (rdev < 0) {
+		error = tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
+		if (error) {
 			dev_err(tps->dev, "Failed to get rdev for %s\n",
 				irq_type->regulator_name);
-			return -EINVAL;
+			return error;
 		}
 		irq_data[i].rdev = rdev;
 
-- 
2.35.1

