Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011496E3689
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDPJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDPJQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:16:44 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4965B1FFF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:16:43 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nyUwp2vt5Vj4inyUxptm50; Sun, 16 Apr 2023 11:16:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681636601;
        bh=34R78RzbMExczZJuYkzgabitAT4xEBq8BMfJDrQnJw0=;
        h=From:To:Cc:Subject:Date;
        b=Y02O6fSLZ1OStPi3lYi2MwFNS7+N45Is2KC4Lw/JujtlFX0tH/K1484EKHJ4tPkCK
         4/5MpAxubdix6f5fRmS9RjFQUZm5k7FmUw8ZKWz6S+4cGQcYCy7w5fYKb55an0S9Bd
         EadVzTi5wIWHW2+5CQoUOSVprmD6R7FBSsmi9PEjljj9bSlOpLJ7n895dvPh8uz7ev
         IPMHGFozHUg0nMi/dw0z/uTqQyjQUUMpG1WEBjmQHDqtsxUHRMrCTr59OdrPRDtpzE
         gahhRNTWS4j6Ktfq1RyX+UwsDfJlIH2DB5Sp5jkJgh5+R2ah+k7qEoLlxVqRkx32M4
         6O6vGGtW5UegQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Apr 2023 11:16:41 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: st_spi_fsm: Use the devm_clk_get_enabled() helper function
Date:   Sun, 16 Apr 2023 11:16:36 +0200
Message-Id: <4025ec3980a956b0e776024e88ec960afc457501.1681636580.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_clk_get_enabled() helper function instead of hand-writing it.
It saves some line of codes.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mtd/devices/st_spi_fsm.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 54861d889c30..3dbb1aa80bfa 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2046,34 +2046,26 @@ static int stfsm_probe(struct platform_device *pdev)
 		return PTR_ERR(fsm->base);
 	}
 
-	fsm->clk = devm_clk_get(&pdev->dev, NULL);
+	fsm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(fsm->clk)) {
 		dev_err(fsm->dev, "Couldn't find EMI clock.\n");
 		return PTR_ERR(fsm->clk);
 	}
 
-	ret = clk_prepare_enable(fsm->clk);
-	if (ret) {
-		dev_err(fsm->dev, "Failed to enable EMI clock.\n");
-		return ret;
-	}
-
 	mutex_init(&fsm->lock);
 
 	ret = stfsm_init(fsm);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialise FSM Controller\n");
-		goto err_clk_unprepare;
+		return ret;
 	}
 
 	stfsm_fetch_platform_configs(pdev);
 
 	/* Detect SPI FLASH device */
 	info = stfsm_jedec_probe(fsm);
-	if (!info) {
-		ret = -ENODEV;
-		goto err_clk_unprepare;
-	}
+	if (!info)
+		return -ENODEV;
 	fsm->info = info;
 
 	/* Use device size to determine address width */
@@ -2089,7 +2081,7 @@ static int stfsm_probe(struct platform_device *pdev)
 	else
 		ret = stfsm_prepare_rwe_seqs_default(fsm);
 	if (ret)
-		goto err_clk_unprepare;
+		return ret;
 
 	fsm->mtd.name		= info->name;
 	fsm->mtd.dev.parent	= &pdev->dev;
@@ -2112,13 +2104,7 @@ static int stfsm_probe(struct platform_device *pdev)
 		(long long)fsm->mtd.size, (long long)(fsm->mtd.size >> 20),
 		fsm->mtd.erasesize, (fsm->mtd.erasesize >> 10));
 
-	ret = mtd_device_register(&fsm->mtd, NULL, 0);
-	if (ret) {
-err_clk_unprepare:
-		clk_disable_unprepare(fsm->clk);
-	}
-
-	return ret;
+	return mtd_device_register(&fsm->mtd, NULL, 0);
 }
 
 static int stfsm_remove(struct platform_device *pdev)
@@ -2127,8 +2113,6 @@ static int stfsm_remove(struct platform_device *pdev)
 
 	WARN_ON(mtd_device_unregister(&fsm->mtd));
 
-	clk_disable_unprepare(fsm->clk);
-
 	return 0;
 }
 
-- 
2.34.1

