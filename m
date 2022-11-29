Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA2963C814
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiK2TUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiK2TTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:24 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38D4B74B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749481; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3h4oSdyi2DbsUWXKmZBEiADc1xXo8dUgCVeZJAcvkys=;
        b=VNXKY6qe3tntRfAt+sR5Q0jbeSupt1Y3NW7iQLe04Xwlsz03KUFJWn8P60YT6puBDyVvKn
        zaKoNBgxF/j6K+ZIlDVyCvz2S0F7dSIllvVoXg2Z6O1qSM0hc4HPVnxBszMSvc0sQxFti5
        q+7kNakiF4k3ZXbDN3yEIVpxOJHxwfg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/26] drm: atmel-hlcdc: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:17:15 +0000
Message-Id: <20221129191733.137897-9-paul@crapouillou.net>
In-Reply-To: <20221129191733.137897-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
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

Use the DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to handle
the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index a2bb5b916235..4e806b06d35d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -784,7 +784,6 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
@@ -815,10 +814,10 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev)
 
 	return drm_atomic_helper_resume(drm_dev, dc->suspend.state);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(atmel_hlcdc_dc_drm_pm_ops,
-		atmel_hlcdc_dc_drm_suspend, atmel_hlcdc_dc_drm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_dc_drm_pm_ops,
+				atmel_hlcdc_dc_drm_suspend,
+				atmel_hlcdc_dc_drm_resume);
 
 static const struct of_device_id atmel_hlcdc_dc_of_match[] = {
 	{ .compatible = "atmel,hlcdc-display-controller" },
@@ -830,7 +829,7 @@ static struct platform_driver atmel_hlcdc_dc_platform_driver = {
 	.remove	= atmel_hlcdc_dc_drm_remove,
 	.driver	= {
 		.name	= "atmel-hlcdc-display-controller",
-		.pm	= &atmel_hlcdc_dc_drm_pm_ops,
+		.pm	= pm_sleep_ptr(&atmel_hlcdc_dc_drm_pm_ops),
 		.of_match_table = atmel_hlcdc_dc_of_match,
 	},
 };
-- 
2.35.1

