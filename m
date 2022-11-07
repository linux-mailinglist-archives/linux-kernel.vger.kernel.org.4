Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116961FBED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiKGRvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKGRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:51:29 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F723E9C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667843473; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDRHgJeXjD/Lfgp6cHobjOELEmX34fviCtkXalmd8+c=;
        b=f0JM/l8sjONQLMbeKaV/13rSiNUmMjvk1GSAMsTvoHb8ClwnThUWo7yB/bPzQpKMojrQtX
        Gh+xqUDRaNWRqQcrKl8qKs/IwLSiuWGYy+8WGZDAG8aG6KtfazclijdWmWPoJ0kmCQY5n5
        I6QP0f4xD6v2Df9PkdLUssmfIjwqs2U=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 02/26] drm: bochs: Use the dev_pm_ops provided by modeset helper
Date:   Mon,  7 Nov 2022 17:50:42 +0000
Message-Id: <20221107175106.360578-3-paul@crapouillou.net>
In-Reply-To: <20221107175106.360578-1-paul@crapouillou.net>
References: <20221107175106.360578-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the drm_mode_config_pm_ops structure exported by
drm_modeset_helper.c, which provides the exact same PM callbacks.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/tiny/bochs.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 04682f831544..26e9cba89f68 100644
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
 
@@ -721,7 +698,7 @@ static struct pci_driver bochs_pci_driver = {
 	.id_table =	bochs_pci_tbl,
 	.probe =	bochs_pci_probe,
 	.remove =	bochs_pci_remove,
-	.driver.pm =    &bochs_pm_ops,
+	.driver.pm =    pm_sleep_ptr(&drm_mode_config_pm_ops),
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.35.1

