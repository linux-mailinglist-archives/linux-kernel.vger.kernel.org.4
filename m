Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB461FC02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiKGRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiKGRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:52:47 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517D25E91
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667843480; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6lrUUQrnG1hoBLHHonfLfMerCAB94qKyHJkeyV1GEE=;
        b=mOQsq/YgbgLowrcMuJ9PYfkUUJGVmSR0UC2N+mrw4pWcTL7x7t3PurcnDE9N741lXgI7xO
        Npdvj5CpH+prx/VHOjCE6UJ5J1y/Udi7n1P3AJ5AkbNLowSYbB+zInJeirWWJGxzKo1/xE
        c/X7buNkJ9fOXZGRBxb8e/gUfvI0qgM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/26] drm: atmel-hlcdc: Remove #ifdef guards for PM related functions
Date:   Mon,  7 Nov 2022 17:50:48 +0000
Message-Id: <20221107175106.360578-9-paul@crapouillou.net>
In-Reply-To: <20221107175106.360578-1-paul@crapouillou.net>
References: <20221107175106.360578-1-paul@crapouillou.net>
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
index f7e7f4e919c7..05146936cc70 100644
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

