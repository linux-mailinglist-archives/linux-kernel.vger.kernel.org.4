Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A861FC41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiKGRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiKGRy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:29 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE8248C8;
        Mon,  7 Nov 2022 09:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667843591; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpKBRvbfGxTJfnKV4fn4HQn1v0QW6PL5yfSkhMzLybQ=;
        b=t6u5Sv21PJgRfXF++fVJX+VAdRGp22WwCvx3HAFeoJqKhPNeoyYRMFB/djd+Ebh/lf3kZC
        rTKnn3KtzAURpA6fRa2lcs47DlsesOMS7QWiaBDdWzUwWUWvImJPGeQHLrv76gHL5K2OX9
        M6bDNVdE7juf+odLNfe79u2KQmnHw54=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 17/26] drm: rcar-du: Remove #ifdef guards for PM related functions
Date:   Mon,  7 Nov 2022 17:52:47 +0000
Message-Id: <20221107175256.360839-7-paul@crapouillou.net>
In-Reply-To: <20221107175256.360839-1-paul@crapouillou.net>
References: <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175256.360839-1-paul@crapouillou.net>
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
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index a2776f1d6f2c..0a89094461cc 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -599,7 +599,6 @@ static const struct drm_driver rcar_du_driver = {
  * Power management
  */
 
-#ifdef CONFIG_PM_SLEEP
 static int rcar_du_pm_suspend(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
@@ -613,11 +612,9 @@ static int rcar_du_pm_resume(struct device *dev)
 
 	return drm_mode_config_helper_resume(&rcdu->ddev);
 }
-#endif
 
-static const struct dev_pm_ops rcar_du_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(rcar_du_pm_suspend, rcar_du_pm_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_du_pm_ops,
+				rcar_du_pm_suspend, rcar_du_pm_resume);
 
 /* -----------------------------------------------------------------------------
  * Platform driver
@@ -712,7 +709,7 @@ static struct platform_driver rcar_du_platform_driver = {
 	.shutdown	= rcar_du_shutdown,
 	.driver		= {
 		.name	= "rcar-du",
-		.pm	= &rcar_du_pm_ops,
+		.pm	= pm_sleep_ptr(&rcar_du_pm_ops),
 		.of_match_table = rcar_du_of_table,
 	},
 };
-- 
2.35.1

