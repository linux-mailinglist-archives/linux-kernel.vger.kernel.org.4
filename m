Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846CE72C7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbjFLOQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbjFLOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:14:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B1173F;
        Mon, 12 Jun 2023 07:14:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 822872273A;
        Mon, 12 Jun 2023 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fsDwK3/MzhO/+4V6RVPaJy4VYKnZ6Si9bcp6FJanXE=;
        b=sDvYrg4iyDbhOjotPD+QhWNlzon1voO8gd7EwAYGjZxIeKu9rJ3wFjnXUzkRM4+W39OX9S
        kYLr7T/rr/8WwABgiUpCCkuyfD1gCqFPVyqehITqo54K7MMNCzIgQjQLh+Ftn/ynUb25fL
        XqTbj66tcWrXrhpVnf8iIN7ZIPv2/hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fsDwK3/MzhO/+4V6RVPaJy4VYKnZ6Si9bcp6FJanXE=;
        b=OW4OfnIAJSd2oORHF0mhf5Gj44hTAaC9fiQJKCsfe1nN99etnHCkyBYWnHZT/BDpPOnL5/
        gizTf2JQDsFesvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EABD1357F;
        Mon, 12 Jun 2023 14:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WBPvCS4oh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:14:06 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 33/38] fbdev/core: Move framebuffer and backlight helpers into separate files
Date:   Mon, 12 Jun 2023 16:08:11 +0200
Message-ID: <20230612141352.29939-34-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612141352.29939-1-tzimmermann@suse.de>
References: <20230612141352.29939-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move framebuffer and backlight helpers into separate files. Leave
fbsysfs.c to sysfs-related code. No functional changes.

The framebuffer helpers are not in fbmem.c because they are under
GPL-2.0-or-later copyright, while fbmem.c is GPL-2.0.

v2:
	* include <linux/mutex.h> (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/core/Makefile       |   4 +-
 drivers/video/fbdev/core/fb_backlight.c |  33 +++++++
 drivers/video/fbdev/core/fb_info.c      |  78 +++++++++++++++++
 drivers/video/fbdev/core/fbsysfs.c      | 110 +-----------------------
 4 files changed, 115 insertions(+), 110 deletions(-)
 create mode 100644 drivers/video/fbdev/core/fb_backlight.c
 create mode 100644 drivers/video/fbdev/core/fb_info.c

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 8f0060160ffb7..eee3295bc2252 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
 obj-$(CONFIG_FB)                  += fb.o
-fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
+fb-y                              := fb_backlight.o \
+                                     fb_info.o \
+                                     fbmem.o fbmon.o fbcmap.o fbsysfs.o \
                                      modedb.o fbcvt.o fb_cmdline.o fb_io_fops.o
 fb-$(CONFIG_FB_DEFERRED_IO)       += fb_defio.o
 
diff --git a/drivers/video/fbdev/core/fb_backlight.c b/drivers/video/fbdev/core/fb_backlight.c
new file mode 100644
index 0000000000000..e2d3b3adc870f
--- /dev/null
+++ b/drivers/video/fbdev/core/fb_backlight.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/export.h>
+#include <linux/fb.h>
+#include <linux/mutex.h>
+
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+/*
+ * This function generates a linear backlight curve
+ *
+ *     0: off
+ *   1-7: min
+ * 8-127: linear from min to max
+ */
+void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max)
+{
+	unsigned int i, flat, count, range = (max - min);
+
+	mutex_lock(&fb_info->bl_curve_mutex);
+
+	fb_info->bl_curve[0] = off;
+
+	for (flat = 1; flat < (FB_BACKLIGHT_LEVELS / 16); ++flat)
+		fb_info->bl_curve[flat] = min;
+
+	count = FB_BACKLIGHT_LEVELS * 15 / 16;
+	for (i = 0; i < count; ++i)
+		fb_info->bl_curve[flat + i] = min + (range * (i + 1) / count);
+
+	mutex_unlock(&fb_info->bl_curve_mutex);
+}
+EXPORT_SYMBOL_GPL(fb_bl_default_curve);
+#endif
diff --git a/drivers/video/fbdev/core/fb_info.c b/drivers/video/fbdev/core/fb_info.c
new file mode 100644
index 0000000000000..8bdbefdd4b701
--- /dev/null
+++ b/drivers/video/fbdev/core/fb_info.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/export.h>
+#include <linux/fb.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+/**
+ * framebuffer_alloc - creates a new frame buffer info structure
+ *
+ * @size: size of driver private data, can be zero
+ * @dev: pointer to the device for this fb, this can be NULL
+ *
+ * Creates a new frame buffer info structure. Also reserves @size bytes
+ * for driver private data (info->par). info->par (if any) will be
+ * aligned to sizeof(long).
+ *
+ * Returns the new structure, or NULL if an error occurred.
+ *
+ */
+struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
+{
+#define BYTES_PER_LONG (BITS_PER_LONG/8)
+#define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
+	int fb_info_size = sizeof(struct fb_info);
+	struct fb_info *info;
+	char *p;
+
+	if (size)
+		fb_info_size += PADDING;
+
+	p = kzalloc(fb_info_size + size, GFP_KERNEL);
+
+	if (!p)
+		return NULL;
+
+	info = (struct fb_info *) p;
+
+	if (size)
+		info->par = p + fb_info_size;
+
+	info->device = dev;
+	info->fbcon_rotate_hint = -1;
+
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	mutex_init(&info->bl_curve_mutex);
+#endif
+
+	return info;
+#undef PADDING
+#undef BYTES_PER_LONG
+}
+EXPORT_SYMBOL(framebuffer_alloc);
+
+/**
+ * framebuffer_release - marks the structure available for freeing
+ *
+ * @info: frame buffer info structure
+ *
+ * Drop the reference count of the device embedded in the
+ * framebuffer info structure.
+ *
+ */
+void framebuffer_release(struct fb_info *info)
+{
+	if (!info)
+		return;
+
+	if (WARN_ON(refcount_read(&info->count)))
+		return;
+
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	mutex_destroy(&info->bl_curve_mutex);
+#endif
+
+	kfree(info);
+}
+EXPORT_SYMBOL(framebuffer_release);
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 0c33c4adcd798..849073f1ca067 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -5,93 +5,12 @@
  * Copyright (c) 2004 James Simmons <jsimmons@infradead.org>
  */
 
-/*
- * Note:  currently there's only stubs for framebuffer_alloc and
- * framebuffer_release here.  The reson for that is that until all drivers
- * are converted to use it a sysfsification will open OOPSable races.
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
+#include <linux/console.h>
 #include <linux/fb.h>
 #include <linux/fbcon.h>
-#include <linux/console.h>
-#include <linux/module.h>
 
 #define FB_SYSFS_FLAG_ATTR 1
 
-/**
- * framebuffer_alloc - creates a new frame buffer info structure
- *
- * @size: size of driver private data, can be zero
- * @dev: pointer to the device for this fb, this can be NULL
- *
- * Creates a new frame buffer info structure. Also reserves @size bytes
- * for driver private data (info->par). info->par (if any) will be
- * aligned to sizeof(long).
- *
- * Returns the new structure, or NULL if an error occurred.
- *
- */
-struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
-{
-#define BYTES_PER_LONG (BITS_PER_LONG/8)
-#define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
-	int fb_info_size = sizeof(struct fb_info);
-	struct fb_info *info;
-	char *p;
-
-	if (size)
-		fb_info_size += PADDING;
-
-	p = kzalloc(fb_info_size + size, GFP_KERNEL);
-
-	if (!p)
-		return NULL;
-
-	info = (struct fb_info *) p;
-
-	if (size)
-		info->par = p + fb_info_size;
-
-	info->device = dev;
-	info->fbcon_rotate_hint = -1;
-
-#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
-	mutex_init(&info->bl_curve_mutex);
-#endif
-
-	return info;
-#undef PADDING
-#undef BYTES_PER_LONG
-}
-EXPORT_SYMBOL(framebuffer_alloc);
-
-/**
- * framebuffer_release - marks the structure available for freeing
- *
- * @info: frame buffer info structure
- *
- * Drop the reference count of the device embedded in the
- * framebuffer info structure.
- *
- */
-void framebuffer_release(struct fb_info *info)
-{
-	if (!info)
-		return;
-
-	if (WARN_ON(refcount_read(&info->count)))
-		return;
-
-#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
-	mutex_destroy(&info->bl_curve_mutex);
-#endif
-
-	kfree(info);
-}
-EXPORT_SYMBOL(framebuffer_release);
-
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
 	int err;
@@ -551,30 +470,3 @@ void fb_cleanup_device(struct fb_info *fb_info)
 		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
 	}
 }
-
-#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
-/* This function generates a linear backlight curve
- *
- *     0: off
- *   1-7: min
- * 8-127: linear from min to max
- */
-void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max)
-{
-	unsigned int i, flat, count, range = (max - min);
-
-	mutex_lock(&fb_info->bl_curve_mutex);
-
-	fb_info->bl_curve[0] = off;
-
-	for (flat = 1; flat < (FB_BACKLIGHT_LEVELS / 16); ++flat)
-		fb_info->bl_curve[flat] = min;
-
-	count = FB_BACKLIGHT_LEVELS * 15 / 16;
-	for (i = 0; i < count; ++i)
-		fb_info->bl_curve[flat + i] = min + (range * (i + 1) / count);
-
-	mutex_unlock(&fb_info->bl_curve_mutex);
-}
-EXPORT_SYMBOL_GPL(fb_bl_default_curve);
-#endif
-- 
2.41.0

