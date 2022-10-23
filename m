Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679C4609233
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJWJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJWJy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:54:58 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D022516
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518558; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSXFtUMP2239U1R0Zna0E84HFug4CfOI1c/yuHZa1WY=;
        b=QOwuLGThnniJS2rm7pVt7LxJYscZhBKEE7Tv34kOWnFNg4Qiz4BxDRIvnRFQJWm4Vjeave
        jRY7bIDtV1wqowQozXM0Zt9yfBDxihcCiPy9yhGzUSrj76q0r6YVLc1XMtj/Hs3oaYI4+C
        Oqz7GOeo7RU3/xKrtYb7ogh96xfqmGA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 25/28] mfd: stmpe: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:49 +0100
Message-Id: <20221023094852.8035-26-paul@crapouillou.net>
In-Reply-To: <20221023094852.8035-1-paul@crapouillou.net>
References: <20221023094852.8035-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new EXPORT_GPL_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

V2: remove duplicated "const".

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org

 drivers/mfd/stmpe-i2c.c | 4 +---
 drivers/mfd/stmpe-spi.c | 4 +---
 drivers/mfd/stmpe.c     | 8 ++------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index d3eedf3d607e..bf094cc9f9de 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -116,9 +116,7 @@ MODULE_DEVICE_TABLE(i2c, stmpe_i2c_id);
 static struct i2c_driver stmpe_i2c_driver = {
 	.driver = {
 		.name = "stmpe-i2c",
-#ifdef CONFIG_PM
-		.pm = &stmpe_dev_pm_ops,
-#endif
+		.pm = pm_sleep_ptr(&stmpe_dev_pm_ops),
 		.of_match_table = stmpe_of_match,
 	},
 	.probe		= stmpe_i2c_probe,
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index ad8055a0e286..e9cbf33502b3 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -135,9 +135,7 @@ static struct spi_driver stmpe_spi_driver = {
 	.driver = {
 		.name	= "stmpe-spi",
 		.of_match_table = of_match_ptr(stmpe_spi_of_match),
-#ifdef CONFIG_PM
-		.pm	= &stmpe_dev_pm_ops,
-#endif
+		.pm	= pm_sleep_ptr(&stmpe_dev_pm_ops),
 	},
 	.probe		= stmpe_spi_probe,
 	.remove		= stmpe_spi_remove,
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 0c4f74197d3e..c304d20bb988 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1495,7 +1495,6 @@ void stmpe_remove(struct stmpe *stmpe)
 	mfd_remove_devices(stmpe->dev);
 }
 
-#ifdef CONFIG_PM
 static int stmpe_suspend(struct device *dev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(dev);
@@ -1516,8 +1515,5 @@ static int stmpe_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops stmpe_dev_pm_ops = {
-	.suspend	= stmpe_suspend,
-	.resume		= stmpe_resume,
-};
-#endif
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmpe_dev_pm_ops,
+			     stmpe_suspend, stmpe_resume);
-- 
2.35.1

