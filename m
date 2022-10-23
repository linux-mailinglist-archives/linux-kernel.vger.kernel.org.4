Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98960922B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJWJxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJWJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:53:29 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29CD75CC2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518554; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjKKqw3Bk3xbTfdsBUYQKJyI4PHiU8JemC2E70n/LOg=;
        b=0usJwLGZjJ+e/1Vb9BwWtfQuGR6MEwx+OK98wvscHh0B4ccXJYqJZ/svmM2+nwVOsZcK14
        3HElOeLjAwv76sNkobr6+Pv2HjvnkDnOFBfra0DiDMsuGDuAnOe7cS8VwXXWGbJ77spbUR
        vJ6LBe/UdZBd6ijdOt0LvoNw+pmSzoo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v3 19/28] mfd: arizona: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:43 +0100
Message-Id: <20221023094852.8035-20-paul@crapouillou.net>
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

Only export the arizona_pm_ops if CONFIG_PM is set, but leave the
suspend/resume functions (and related code) outside #ifdef guards.

If CONFIG_PM is not set, the arizona_pm_ops will be defined as
"static __maybe_unused", and the structure plus all the callbacks will
be automatically dropped by the compiler.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

V2: Use new EXPORT_GPL_DEV_PM_OPS() macro
V3: No change

 drivers/mfd/arizona-core.c | 19 +++++++------------
 drivers/mfd/arizona-i2c.c  |  2 +-
 drivers/mfd/arizona-spi.c  |  2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index cbf1dd90b70d..bd7ee3260d53 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -480,7 +480,6 @@ static int wm5102_clear_write_sequencer(struct arizona *arizona)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int arizona_isolate_dcvdd(struct arizona *arizona)
 {
 	int ret;
@@ -742,9 +741,7 @@ static int arizona_runtime_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
 static int arizona_suspend(struct device *dev)
 {
 	struct arizona *arizona = dev_get_drvdata(dev);
@@ -784,17 +781,15 @@ static int arizona_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-const struct dev_pm_ops arizona_pm_ops = {
-	SET_RUNTIME_PM_OPS(arizona_runtime_suspend,
-			   arizona_runtime_resume,
-			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
-				      arizona_resume_noirq)
+EXPORT_GPL_DEV_PM_OPS(arizona_pm_ops) = {
+	RUNTIME_PM_OPS(arizona_runtime_suspend,
+		       arizona_runtime_resume,
+		       NULL)
+	SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
+				  arizona_resume_noirq)
 };
-EXPORT_SYMBOL_GPL(arizona_pm_ops);
 
 #ifdef CONFIG_OF
 static int arizona_of_get_core_pdata(struct arizona *arizona)
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 6d83e6b9a692..8799d9183bee 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -119,7 +119,7 @@ static const struct of_device_id arizona_i2c_of_match[] = {
 static struct i2c_driver arizona_i2c_driver = {
 	.driver = {
 		.name	= "arizona",
-		.pm	= &arizona_pm_ops,
+		.pm	= pm_ptr(&arizona_pm_ops),
 		.of_match_table	= of_match_ptr(arizona_i2c_of_match),
 	},
 	.probe		= arizona_i2c_probe,
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 941b0267d09d..da05b966d48c 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -282,7 +282,7 @@ static const struct of_device_id arizona_spi_of_match[] = {
 static struct spi_driver arizona_spi_driver = {
 	.driver = {
 		.name	= "arizona",
-		.pm	= &arizona_pm_ops,
+		.pm	= pm_ptr(&arizona_pm_ops),
 		.of_match_table	= of_match_ptr(arizona_spi_of_match),
 		.acpi_match_table = ACPI_PTR(arizona_acpi_match),
 	},
-- 
2.35.1

