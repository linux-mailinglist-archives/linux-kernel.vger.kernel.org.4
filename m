Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68AD63C805
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiK2TT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiK2TTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:08 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A63B6C705
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749479; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEjxKDNm3i4FDiWmBekbtVQ5t/EpC9nOnul1c9i1i1M=;
        b=Taryu9xn7LuS8c0dGYEZkB9nNj0a7nz0bW0TjxOfTRSglh8anKk2e3H8RCb0mxFe8jiqET
        h9AlKR8lJOljzO1Dly2Ye7OAmnAkZoamwKHHwPKR0XQ3eHAw2F6kGRNsVQc/7fqXBe7P+b
        BOJYFPUGDN8RVcomPQ2KFZyZPc9daao=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 06/26] drm: sun4i: Define and use generic PM ops
Date:   Tue, 29 Nov 2022 19:17:13 +0000
Message-Id: <20221129191733.137897-7-paul@crapouillou.net>
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

Use the new DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS() macro to create a
"struct dev_pm_ops" that can be used by this driver, instead of using
custom PM callbacks with the same behaviour.

v2: Use the DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS() macro instead of an
    exported dev_pm_ops.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Samuel: since the code changed I had to remove your reviewed-by, sorry
        about that.

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index cc94efbbf2d4..178ada09b467 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -13,6 +13,7 @@
 #include <linux/of_graph.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -339,27 +340,6 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	return count;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sun4i_drv_drm_sys_suspend(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_suspend(drm);
-}
-
-static int sun4i_drv_drm_sys_resume(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_resume(drm);
-}
-#endif
-
-static const struct dev_pm_ops sun4i_drv_drm_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sun4i_drv_drm_sys_suspend,
-				sun4i_drv_drm_sys_resume)
-};
-
 static int sun4i_drv_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
@@ -434,13 +414,15 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
 
+DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS(sun4i_pm_ops);
+
 static struct platform_driver sun4i_drv_platform_driver = {
 	.probe		= sun4i_drv_probe,
 	.remove		= sun4i_drv_remove,
 	.driver		= {
 		.name		= "sun4i-drm",
 		.of_match_table	= sun4i_drv_of_table,
-		.pm = &sun4i_drv_drm_pm_ops,
+		.pm = pm_sleep_ptr(&sun4i_pm_ops),
 	},
 };
 drm_module_platform_driver(sun4i_drv_platform_driver);
-- 
2.35.1

