Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E184774E7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGKHVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKHVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:21:00 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BFCE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:20:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f087:2614:ec9d:569f])
        by albert.telenet-ops.be with bizsmtp
        id KjLt2A00K1w4dBK06jLuuy; Tue, 11 Jul 2023 09:20:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJ7fz-0015rg-00;
        Tue, 11 Jul 2023 09:20:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJ7g5-00Bu7W-Pz;
        Tue, 11 Jul 2023 09:20:53 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: mxc: Improve PM configuration
Date:   Tue, 11 Jul 2023 09:20:53 +0200
Message-Id: <20230711072053.2837327-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM=n (e.g. m68k/allmodconfig):

    drivers/gpio/gpio-mxc.c:612:12: error: ‘mxc_gpio_runtime_resume’ defined but not used [-Werror=unused-function]
      612 | static int mxc_gpio_runtime_resume(struct device *dev)
          |            ^~~~~~~~~~~~~~~~~~~~~~~
    drivers/gpio/gpio-mxc.c:602:12: error: ‘mxc_gpio_runtime_suspend’ defined but not used [-Werror=unused-function]
      602 | static int mxc_gpio_runtime_suspend(struct device *dev)
          |            ^~~~~~~~~~~~~~~~~~~~~~~~

Fix this by using the non-SET *_PM_OPS to configure the dev_pm_ops
callbacks, and by wrapping the driver.pm initializer insider pm_ptr().

As NOIRQ_SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr() internally, the
__maybe_unused annotations for the noirq callbacks are no longer needed,
and can be removed.

Fixes: 3283d820dce649ad ("gpio: mxc: add runtime pm support")
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpio-mxc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index a9fb6bd9aa6f9645..a43df5d5006e62d3 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
+static int mxc_gpio_noirq_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
@@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
+static int mxc_gpio_noirq_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
@@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mxc_gpio_dev_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
-	SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
+	RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume, NULL)
 };
 
 static int mxc_gpio_syscore_suspend(void)
@@ -695,7 +695,7 @@ static struct platform_driver mxc_gpio_driver = {
 		.name	= "gpio-mxc",
 		.of_match_table = mxc_gpio_dt_ids,
 		.suppress_bind_attrs = true,
-		.pm = &mxc_gpio_dev_pm_ops,
+		.pm = pm_ptr(&mxc_gpio_dev_pm_ops),
 	},
 	.probe		= mxc_gpio_probe,
 };
-- 
2.34.1

