Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8540263C7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiK2TSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiK2TSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:18:09 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493D5B5A9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749470; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIthVPfRqMzRLHonB9Z3+9yNKc8FhZTyJnewRLDcrPs=;
        b=v6cI95cKHZF7JRsW6yCZyviPrYgL1hUQg6mGKb3+uSwSQT68AJ3ZblHdt2FXdYjVdF2lxU
        YhUSzbi1grVPHthQtkb3JWgqIRU8fEVCYtMlY3+3ITbHhcGY6uZfFk5LsBbEBlxgN4TgmX
        0FTfc9J1QbkFBazrASWsvhNoZ8uol00=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 02/26] drm: bochs: Define and use generic PM ops
Date:   Tue, 29 Nov 2022 19:17:09 +0000
Message-Id: <20221129191733.137897-3-paul@crapouillou.net>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/tiny/bochs.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 024346054c70..598488905607 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -610,30 +611,6 @@ static const struct drm_driver bochs_driver = {
 	DRM_GEM_VRAM_DRIVER,
 };
 
-/* ---------------------------------------------------------------------- */
-/* pm interface                                                           */
-
-#ifdef CONFIG_PM_SLEEP
-static int bochs_pm_suspend(struct device *dev)
-{
-	struct drm_device *drm_dev = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_suspend(drm_dev);
-}
-
-static int bochs_pm_resume(struct device *dev)
-{
-	struct drm_device *drm_dev = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_resume(drm_dev);
-}
-#endif
-
-static const struct dev_pm_ops bochs_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(bochs_pm_suspend,
-				bochs_pm_resume)
-};
-
 /* ---------------------------------------------------------------------- */
 /* pci interface                                                          */
 
@@ -716,12 +693,14 @@ static const struct pci_device_id bochs_pci_tbl[] = {
 	{ /* end of list */ }
 };
 
+DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS(bochs_pm_ops);
+
 static struct pci_driver bochs_pci_driver = {
 	.name =		"bochs-drm",
 	.id_table =	bochs_pci_tbl,
 	.probe =	bochs_pci_probe,
 	.remove =	bochs_pci_remove,
-	.driver.pm =    &bochs_pm_ops,
+	.driver.pm =    pm_sleep_ptr(&bochs_pm_ops),
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.35.1

