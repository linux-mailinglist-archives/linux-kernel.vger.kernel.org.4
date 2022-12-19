Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4A7650B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiLSMHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiLSMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:07:07 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93F3BF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GbGrYf38XrOD+DX/TFi/+gfE99jvCnKo4Sqqs8+RLv4=; b=TLpYPUQUV7Q8mkQAIWWFFrrt3i
        pTmcNeu6eEzt6O4bMY+BvXpF/RKT5dSKc8hwaDXgbE8RN4qzYJR+4+JinJmWfencw/BdzbCul3Es5
        JQgRn15Ae4Gymeiwk3yyxgBN9nu6642cCFHCqi9c7guVQZ6Pr0w3phVA3DhEc4bGVqUf2YmIynnZ/
        inQUVssOxFAPVpfFUuvzjgoiuH/ELMumJz0fq+cmMd08nJlh+MfqoHIGs08ghsgGnvBhBfB+006Rv
        4AXXzDx7yr6fS25XBnTRWYZoyg2iUBxU46ik24lQ2IWsQ14uHjdxQeAqxaDQMzX/x8SBmvbRiB192
        b0UrKgVA==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p7Ev1-006HsS-Vm; Mon, 19 Dec 2022 13:06:56 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Wambui Karuga <wambui@karuga.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 2/7] drm: use new debugfs device-centered functions on DRM core files
Date:   Mon, 19 Dec 2022 09:06:16 -0300
Message-Id: <20221219120621.15086-3-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219120621.15086-1-mcanal@igalia.com>
References: <20221219120621.15086-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of drm_debugfs_create_files() with the new
drm_debugfs_add_files() function in all DRM core files, centering the
debugfs files management on the drm_device instead of drm_minor.

Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_atomic.c          | 11 +++++------
 drivers/gpu/drm/drm_client.c          | 11 +++++------
 drivers/gpu/drm/drm_debugfs.c         | 18 ++++++++----------
 drivers/gpu/drm/drm_framebuffer.c     | 11 +++++------
 drivers/gpu/drm/drm_gem_vram_helper.c | 11 +++++------
 5 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index e666799a46d5..5457c02ca1ab 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1756,8 +1756,8 @@ EXPORT_SYMBOL(drm_state_dump);
 #ifdef CONFIG_DEBUG_FS
 static int drm_state_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_printer p = drm_seq_file_printer(m);
 
 	__drm_state_dump(dev, &p, true);
@@ -1766,14 +1766,13 @@ static int drm_state_info(struct seq_file *m, void *data)
 }
 
 /* any use in debugfs files to dump individual planes/crtc/etc? */
-static const struct drm_info_list drm_atomic_debugfs_list[] = {
+static const struct drm_debugfs_info drm_atomic_debugfs_list[] = {
 	{"state", drm_state_info, 0},
 };
 
 void drm_atomic_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(drm_atomic_debugfs_list,
-				 ARRAY_SIZE(drm_atomic_debugfs_list),
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_atomic_debugfs_list,
+			      ARRAY_SIZE(drm_atomic_debugfs_list));
 }
 #endif
diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index fd67efe37c63..262ec64d4397 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -480,8 +480,8 @@ EXPORT_SYMBOL(drm_client_framebuffer_flush);
 #ifdef CONFIG_DEBUG_FS
 static int drm_client_debugfs_internal_clients(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_printer p = drm_seq_file_printer(m);
 	struct drm_client_dev *client;
 
@@ -493,14 +493,13 @@ static int drm_client_debugfs_internal_clients(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list drm_client_debugfs_list[] = {
+static const struct drm_debugfs_info drm_client_debugfs_list[] = {
 	{ "internal_clients", drm_client_debugfs_internal_clients, 0 },
 };
 
 void drm_client_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(drm_client_debugfs_list,
-				 ARRAY_SIZE(drm_client_debugfs_list),
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_client_debugfs_list,
+			      ARRAY_SIZE(drm_client_debugfs_list));
 }
 #endif
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 988fc07b94b4..d9d3ed7acc80 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -51,9 +51,8 @@
 
 static int drm_name_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_minor *minor = node->minor;
-	struct drm_device *dev = minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_master *master;
 
 	mutex_lock(&dev->master_mutex);
@@ -73,8 +72,8 @@ static int drm_name_info(struct seq_file *m, void *data)
 
 static int drm_clients_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_file *priv;
 	kuid_t uid;
 
@@ -125,8 +124,8 @@ static int drm_gem_one_name_info(int id, void *ptr, void *data)
 
 static int drm_gem_name_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 
 	seq_printf(m, "  name     size handles refcount\n");
 
@@ -137,7 +136,7 @@ static int drm_gem_name_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list drm_debugfs_list[] = {
+static const struct drm_debugfs_info drm_debugfs_list[] = {
 	{"name", drm_name_info, 0},
 	{"clients", drm_clients_info, 0},
 	{"gem_names", drm_gem_name_info, DRIVER_GEM},
@@ -231,8 +230,7 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 	sprintf(name, "%d", minor_id);
 	minor->debugfs_root = debugfs_create_dir(name, root);
 
-	drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_debugfs_list, DRM_DEBUGFS_ENTRIES);
 
 	if (drm_drv_uses_atomic_modeset(dev)) {
 		drm_atomic_debugfs_init(minor);
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 2dd97473ca10..aff3746dedfb 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -1203,8 +1203,8 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
 #ifdef CONFIG_DEBUG_FS
 static int drm_framebuffer_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_printer p = drm_seq_file_printer(m);
 	struct drm_framebuffer *fb;
 
@@ -1218,14 +1218,13 @@ static int drm_framebuffer_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list drm_framebuffer_debugfs_list[] = {
+static const struct drm_debugfs_info drm_framebuffer_debugfs_list[] = {
 	{ "framebuffer", drm_framebuffer_info, 0 },
 };
 
 void drm_framebuffer_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(drm_framebuffer_debugfs_list,
-				 ARRAY_SIZE(drm_framebuffer_debugfs_list),
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_framebuffer_debugfs_list,
+			      ARRAY_SIZE(drm_framebuffer_debugfs_list));
 }
 #endif
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index f59adffd938a..d40b3edb52d0 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -957,8 +957,8 @@ static struct ttm_device_funcs bo_driver = {
 
 static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_vram_mm *vmm = node->minor->dev->vram_mm;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_vram_mm *vmm = entry->dev->vram_mm;
 	struct ttm_resource_manager *man = ttm_manager_type(&vmm->bdev, TTM_PL_VRAM);
 	struct drm_printer p = drm_seq_file_printer(m);
 
@@ -966,7 +966,7 @@ static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
+static const struct drm_debugfs_info drm_vram_mm_debugfs_list[] = {
 	{ "vram-mm", drm_vram_mm_debugfs, 0, NULL },
 };
 
@@ -978,9 +978,8 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
  */
 void drm_vram_mm_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
-				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_vram_mm_debugfs_list,
+			      ARRAY_SIZE(drm_vram_mm_debugfs_list));
 }
 EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
 
-- 
2.38.1

