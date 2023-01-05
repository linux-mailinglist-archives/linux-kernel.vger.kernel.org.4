Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340B65F48C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjAETeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjAETde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:33:34 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1252600
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6ng+7yFDWt9LxupRFip41Ax8DmuR3ZIMGl3JGKRkSCM=; b=IhWo/ViZZotddgwnge91joIdD4
        0QJtZLN9QO/xB3TuOerTdBCV+0q+Ka/r6dheIvcSdSucO+ZSAkRZ0mKMiTDkXJ/tQkrg+BMR8H6d4
        NCk83lxooSipqYGYT9e/skAoPgW9mn0JriK44nCGuYwjrW04uZtcHUy15JZA9bffX190DdUsnoIGp
        GPLGaVm/0QgJy837Y7FYfdgaGjqVvLDtboQlLk7iVC9xsIu34VbeelE1JpjqFXNmqXWnUYCptin6K
        CSl8wzC62l18t5Fc4fkAUUp5BgkvUrcOdSJPyPFq6ZaO+wVorKUbe8Rf1kXy8tx72/wnHpzmF7rNI
        GAd3OWFQ==;
Received: from [187.36.234.139] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pDVx0-000Kcs-7a; Thu, 05 Jan 2023 20:30:54 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 1/2] drm/debugfs: use octal permissions instead of symbolic permissions
Date:   Thu,  5 Jan 2023 16:30:38 -0300
Message-Id: <20230105193039.287677-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.39.0
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

Currently, debugfs functions are using symbolic macros as permission
bits, but checkpatch reinforces permission bits in the octal form, as
they are more readable and easier to understand [1].

Therefore, use octal permission bits in all debugfs functions.

[1] https://docs.kernel.org/dev-tools/checkpatch.html#permissions

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_debugfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 5ea237839439..4f643a490dc3 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -207,7 +207,7 @@ void drm_debugfs_create_files(const struct drm_info_list *files, int count,
 
 		tmp->minor = minor;
 		tmp->dent = debugfs_create_file(files[i].name,
-						S_IFREG | S_IRUGO, root, tmp,
+						0444, root, tmp,
 						&drm_debugfs_fops);
 		tmp->info_ent = &files[i];
 
@@ -246,7 +246,7 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 		dev->driver->debugfs_init(minor);
 
 	list_for_each_entry_safe(entry, tmp, &dev->debugfs_list, list) {
-		debugfs_create_file(entry->file.name, S_IFREG | S_IRUGO,
+		debugfs_create_file(entry->file.name, 0444,
 				    minor->debugfs_root, entry, &drm_debugfs_entry_fops);
 		list_del(&entry->list);
 	}
@@ -263,7 +263,7 @@ void drm_debugfs_late_register(struct drm_device *dev)
 		return;
 
 	list_for_each_entry_safe(entry, tmp, &dev->debugfs_list, list) {
-		debugfs_create_file(entry->file.name, S_IFREG | S_IRUGO,
+		debugfs_create_file(entry->file.name, 0444,
 				    minor->debugfs_root, entry, &drm_debugfs_entry_fops);
 		list_del(&entry->list);
 	}
@@ -508,15 +508,15 @@ void drm_debugfs_connector_add(struct drm_connector *connector)
 	connector->debugfs_entry = root;
 
 	/* force */
-	debugfs_create_file("force", S_IRUGO | S_IWUSR, root, connector,
+	debugfs_create_file("force", 0644, root, connector,
 			    &drm_connector_fops);
 
 	/* edid */
-	debugfs_create_file("edid_override", S_IRUGO | S_IWUSR, root, connector,
+	debugfs_create_file("edid_override", 0644, root, connector,
 			    &drm_edid_fops);
 
 	/* vrr range */
-	debugfs_create_file("vrr_range", S_IRUGO, root, connector,
+	debugfs_create_file("vrr_range", 0444, root, connector,
 			    &vrr_range_fops);
 
 	/* max bpc */
-- 
2.39.0

