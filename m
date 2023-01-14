Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09BF66AA44
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjANIyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjANIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:54:15 -0500
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCF59E6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 00:54:13 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GcIkpkMKaFcd8GcIkpbxVz; Sat, 14 Jan 2023 09:54:11 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 09:54:11 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] video: fbdev: omapfb: Use kstrtobool() instead of strtobool()
Date:   Sat, 14 Jan 2023 09:54:04 +0100
Message-Id: <b475ed9827ccef2081b557330a224f5fd8e6c8f3.1673686433.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch was already sent as a part of a serie ([1]) that axed all usages
of strtobool().
Most of the patches have been merged in -next.

I synch'ed with latest -next and re-send the remaining ones as individual
patches.

Changes in v2:
  - No change

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c | 7 ++++---
 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c | 7 ++++---
 drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c | 3 ++-
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c      | 3 ++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index bc5a44c2a144..ae937854403b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -10,6 +10,7 @@
 #define DSS_SUBSYS_NAME "DISPLAY"
 
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
@@ -36,7 +37,7 @@ static ssize_t display_enabled_store(struct omap_dss_device *dssdev,
 	int r;
 	bool enable;
 
-	r = strtobool(buf, &enable);
+	r = kstrtobool(buf, &enable);
 	if (r)
 		return r;
 
@@ -73,7 +74,7 @@ static ssize_t display_tear_store(struct omap_dss_device *dssdev,
 	if (!dssdev->driver->enable_te || !dssdev->driver->get_te)
 		return -ENOENT;
 
-	r = strtobool(buf, &te);
+	r = kstrtobool(buf, &te);
 	if (r)
 		return r;
 
@@ -183,7 +184,7 @@ static ssize_t display_mirror_store(struct omap_dss_device *dssdev,
 	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
 		return -ENOENT;
 
-	r = strtobool(buf, &mirror);
+	r = kstrtobool(buf, &mirror);
 	if (r)
 		return r;
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index ba21c4a2633d..1b644be5fe2e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -10,6 +10,7 @@
 #define DSS_SUBSYS_NAME "MANAGER"
 
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -246,7 +247,7 @@ static ssize_t manager_trans_key_enabled_store(struct omap_overlay_manager *mgr,
 	bool enable;
 	int r;
 
-	r = strtobool(buf, &enable);
+	r = kstrtobool(buf, &enable);
 	if (r)
 		return r;
 
@@ -290,7 +291,7 @@ static ssize_t manager_alpha_blending_enabled_store(
 	if(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER))
 		return -ENODEV;
 
-	r = strtobool(buf, &enable);
+	r = kstrtobool(buf, &enable);
 	if (r)
 		return r;
 
@@ -329,7 +330,7 @@ static ssize_t manager_cpr_enable_store(struct omap_overlay_manager *mgr,
 	if (!dss_has_feature(FEAT_CPR))
 		return -ENODEV;
 
-	r = strtobool(buf, &enable);
+	r = kstrtobool(buf, &enable);
 	if (r)
 		return r;
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 601c0beb6de9..1da4fb1c77b4 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
+#include <linux/kstrtox.h>
 #include <linux/platform_device.h>
 
 #include <video/omapfb_dss.h>
@@ -210,7 +211,7 @@ static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
 	int r;
 	bool enable;
 
-	r = strtobool(buf, &enable);
+	r = kstrtobool(buf, &enable);
 	if (r)
 		return r;
 
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
index 06dc41aa0354..831b2c2fbdf9 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/mm.h>
 #include <linux/omapfb.h>
 
@@ -96,7 +97,7 @@ static ssize_t store_mirror(struct device *dev,
 	int r;
 	struct fb_var_screeninfo new_var;
 
-	r = strtobool(buf, &mirror);
+	r = kstrtobool(buf, &mirror);
 	if (r)
 		return r;
 
-- 
2.34.1

