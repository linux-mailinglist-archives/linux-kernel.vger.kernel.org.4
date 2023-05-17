Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20917072E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEQUUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5851FEB;
        Wed, 17 May 2023 13:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D1464AFF;
        Wed, 17 May 2023 20:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9F7C433D2;
        Wed, 17 May 2023 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684354817;
        bh=tmrEqMSlltVVWCR826sj25ts9zl6YULEBavsqHAY8to=;
        h=From:To:Cc:Subject:Date:From;
        b=heAqux+yqXgxXkijDEAiFmUchjVlz/v6KJhWZCe6P5zq4SpPdRo95hufWL9UwLfDP
         q8bmR8CLw+ubMxjTT4b2nAAqQg254sbAryZReih0XIyrXXsjOcOY0sARWFEPHQe4Ti
         7aE7pS3721poCYt4gnaEnUFAo4frdbIXerV9OCscoIG/UWwtOPl0G/7V3DKIFy1D5J
         qFtrPPY3KrscAD9nAoF8XdyvFiapgeKjwo3JXT/anN1qbPrCCHCc41eKFr4dqObPR9
         f27UJY6anzLAiejtanf0SvyuRONjQwe9XmczmWR5NkNcgoua6lafEpyFgebvU9kRI2
         i1obqdAcXlLqg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: omap: convert to modern PM ops
Date:   Wed, 17 May 2023 22:20:07 +0200
Message-Id: <20230517202012.634386-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new uart_write() function is only called from suspend/resume code, causing
a build warning when those are left out:

drivers/tty/serial/8250/8250_omap.c:169:13: error: 'uart_write' defined but not used [-Werror=unused-function]

Remove the #ifdefs and use the modern pm_ops/pm_sleep_ops and their wrappers
to let the compiler see where it's used but still drop the dead code.

Fixes: 398cecc24846 ("serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_omap.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5c093dfcee1d..00b2c35042ee 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1571,7 +1571,6 @@ static int omap8250_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int omap8250_prepare(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
@@ -1616,12 +1615,7 @@ static int omap8250_resume(struct device *dev)
 	serial8250_resume_port(priv->line);
 	return 0;
 }
-#else
-#define omap8250_prepare NULL
-#define omap8250_complete NULL
-#endif
 
-#ifdef CONFIG_PM
 static int omap8250_lost_context(struct uart_8250_port *up)
 {
 	u32 val;
@@ -1738,7 +1732,6 @@ static int omap8250_runtime_resume(struct device *dev)
 	schedule_work(&priv->qos_work);
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP
 static int __init omap8250_console_fixup(void)
@@ -1781,17 +1774,17 @@ console_initcall(omap8250_console_fixup);
 #endif
 
 static const struct dev_pm_ops omap8250_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(omap8250_suspend, omap8250_resume)
-	SET_RUNTIME_PM_OPS(omap8250_runtime_suspend,
+	SYSTEM_SLEEP_PM_OPS(omap8250_suspend, omap8250_resume)
+	RUNTIME_PM_OPS(omap8250_runtime_suspend,
 			   omap8250_runtime_resume, NULL)
-	.prepare        = omap8250_prepare,
-	.complete       = omap8250_complete,
+	.prepare        = pm_sleep_ptr(omap8250_prepare),
+	.complete       = pm_sleep_ptr(omap8250_complete),
 };
 
 static struct platform_driver omap8250_platform_driver = {
 	.driver = {
 		.name		= "omap8250",
-		.pm		= &omap8250_dev_pm_ops,
+		.pm		= pm_ptr(&omap8250_dev_pm_ops),
 		.of_match_table = omap8250_dt_ids,
 	},
 	.probe			= omap8250_probe,
-- 
2.39.2

