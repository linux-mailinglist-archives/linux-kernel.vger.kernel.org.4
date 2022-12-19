Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43D650B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiLSMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiLSMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:08:16 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D83A449
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XLI4Q5BF1S4Y7/1I9tMeZIh/hDmMgqL/1tXLD7cwxp4=; b=IIZ+0am/AGpSBN/8WsZv+nY15m
        D6nCIeDL2TtuT0vFmnyOAG7RhDcFQUjUeX449QizsXNwnPMntNZRfwg/9Y3+gMwGGrj8OvDeBjtOW
        yjMEqoPrpu2J8GuZmee8B5+OY31HWWgFx3O+Q6H9WqnFzZPCD+fbsZcgOV26XaWykaAKXU+xoZ0iw
        DpJdQOBZUxjzllBGi7EkAH9X7pNaEc2/Odztg5PR2oNB8Q37Na4tX4g0/8BfQfM/41SdF1cc2KwZZ
        sBjmi+pX7uQqmALGQODebJ4tAygmx8fjxNokdwRkYBwIlBF3FArEag3da+2hAVs/kSp2zMCEESfpH
        AVK/Ac2A==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p7EvO-006HsS-GX; Mon, 19 Dec 2022 13:07:19 +0100
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
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v4 6/7] drm/vkms: use new debugfs device-centered functions
Date:   Mon, 19 Dec 2022 09:06:20 -0300
Message-Id: <20221219120621.15086-7-mcanal@igalia.com>
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
drm_debugfs_add_files() function, which centers the debugfs files
management on the drm_device instead of drm_minor. Moreover, remove the
debugfs_init hook and add the debugfs files directly on vkms_create(),
before drm_dev_register().

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 69346906ec81..6d3a2d57d992 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -92,8 +92,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 
 static int vkms_config_show(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 
 	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
@@ -103,24 +103,16 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list vkms_config_debugfs_list[] = {
+static const struct drm_debugfs_info vkms_config_debugfs_list[] = {
 	{ "vkms_config", vkms_config_show, 0 },
 };
 
-static void vkms_config_debugfs_init(struct drm_minor *minor)
-{
-	drm_debugfs_create_files(vkms_config_debugfs_list, ARRAY_SIZE(vkms_config_debugfs_list),
-				 minor->debugfs_root, minor);
-}
-
 static const struct drm_driver vkms_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
 	.release		= vkms_release,
 	.fops			= &vkms_driver_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
 
-	.debugfs_init           = vkms_config_debugfs_init,
-
 	.name			= DRIVER_NAME,
 	.desc			= DRIVER_DESC,
 	.date			= DRIVER_DATE,
@@ -202,6 +194,9 @@ static int vkms_create(struct vkms_config *config)
 	if (ret)
 		goto out_devres;
 
+	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
+			      ARRAY_SIZE(vkms_config_debugfs_list));
+
 	ret = drm_dev_register(&vkms_device->drm, 0);
 	if (ret)
 		goto out_devres;
-- 
2.38.1

