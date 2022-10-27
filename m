Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0FA60F8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiJ0NLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiJ0NKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:10:52 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF9696FD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:10:35 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:53a:31ee:412:433f])
        by michel.telenet-ops.be with bizsmtp
        id d1AW2800P5LQXpN061AWZg; Thu, 27 Oct 2022 15:10:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oo2eT-001pe8-V4; Thu, 27 Oct 2022 15:10:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oo2eT-00G6Wz-FL; Thu, 27 Oct 2022 15:10:29 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        noreply@ellerman.id.au
Subject: [PATCH 2/2] mtd: rawnand: lpc32xx_slc: Switch to using pm_ptr()
Date:   Thu, 27 Oct 2022 15:10:28 +0200
Message-Id: <20221027131028.3838303-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027131028.3838303-1-geert@linux-m68k.org>
References: <20221027131028.3838303-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch to using the gpiod API removed the last user of
lpc32xx_wp_disable() outside #ifdef CONFIG_PM, causing build failures if
CONFIG_PM=n:

    drivers/mtd/nand/raw/lpc32xx_slc.c:318:13: error: ‘lpc32xx_wp_disable’ defined but not used [-Werror=unused-function]
      318 | static void lpc32xx_wp_disable(struct lpc32xx_nand_host *host)
          |             ^~~~~~~~~~~~~~~~~~

Fix this by switching from #ifdef CONFIG_PM to pm_ptr(), increasing
compile-coverage as a side-effect.

Reported-by: noreply@ellerman.id.au
Fixes: 6b923db2867cb5e1 ("mtd: rawnand: lpc32xx_slc: switch to using gpiod API")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mtd/nand/raw/lpc32xx_slc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 4702577f74e5dae4..6918737346c95c8a 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -969,7 +969,6 @@ static int lpc32xx_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int lpc32xx_nand_resume(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
@@ -1008,11 +1007,6 @@ static int lpc32xx_nand_suspend(struct platform_device *pdev, pm_message_t pm)
 	return 0;
 }
 
-#else
-#define lpc32xx_nand_resume NULL
-#define lpc32xx_nand_suspend NULL
-#endif
-
 static const struct of_device_id lpc32xx_nand_match[] = {
 	{ .compatible = "nxp,lpc3220-slc" },
 	{ /* sentinel */ },
@@ -1022,8 +1016,8 @@ MODULE_DEVICE_TABLE(of, lpc32xx_nand_match);
 static struct platform_driver lpc32xx_nand_driver = {
 	.probe		= lpc32xx_nand_probe,
 	.remove		= lpc32xx_nand_remove,
-	.resume		= lpc32xx_nand_resume,
-	.suspend	= lpc32xx_nand_suspend,
+	.resume		= pm_ptr(lpc32xx_nand_resume),
+	.suspend	= pm_ptr(lpc32xx_nand_suspend),
 	.driver		= {
 		.name	= LPC32XX_MODNAME,
 		.of_match_table = lpc32xx_nand_match,
-- 
2.25.1

