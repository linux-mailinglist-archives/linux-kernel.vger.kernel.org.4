Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2995737876
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjFUA6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFUA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:58:38 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB80183
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AHRpiiiLC5kKDXx9I68+5zUOknZnGRCucbKH1IwIdOA=; b=ZcBC5oLi2E/CWy/em1B12OApC7
        20r32P8uA7Qb94hiFHgcfV9W3wrZXUErThEqCZNt17E90yEP19EmMhaXiQTM1wTzIpP16E2JWJxhX
        F7wpFdXLcBUmEmdVMkXjOQKUSJ10msQ5YFyu44DpJftADcB7dPF/n/qB4BGU5sEVCZqjMNDUlFu6W
        fP+bpoWCx6inN4SRmVjTmK4dinhO/EwDb6oGB58aHsnublzySd86iXLCWk7Bpyb6BWObbE0Zc/c2N
        FmpkOCwKYCHQ/hUr3obgd/q/0cCAOAD0tHeSwjcu5d2yhpAkwOA8OiwFrcDwGR4H3qTCpJnd+ReBH
        ZKz5J65A==;
Received: from [179.113.218.86] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qBmB8-0011pg-K6; Wed, 21 Jun 2023 02:58:35 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH v3 2/4] drm: Create DRM_IOCTL_GET_RESET
Date:   Tue, 20 Jun 2023 21:57:17 -0300
Message-ID: <20230621005719.836857-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621005719.836857-1-andrealmeid@igalia.com>
References: <20230621005719.836857-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new DRM ioctl operation to get the numbers of resets for a
given context. The numbers reflect just the resets that happened after
the context was created, and not since the machine was booted.

Create a debugfs interface to make easier to test the API without real
resets.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/drm_debugfs.c |  2 ++
 drivers/gpu/drm/drm_ioctl.c   | 58 +++++++++++++++++++++++++++++++++++
 include/drm/drm_device.h      |  3 ++
 include/drm/drm_drv.h         |  3 ++
 include/uapi/drm/drm.h        | 21 +++++++++++++
 include/uapi/drm/drm_mode.h   | 15 +++++++++
 6 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4855230ba2c6..316dce60434d 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -251,6 +251,8 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 		list_del(&entry->list);
 	}
 
+	debugfs_create_bool("drm_reset_spoof", 0644, minor->debugfs_root, &dev->reset_spoof);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 7c9d66ee917d..23c282681ec7 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -528,6 +528,63 @@ int drm_version(struct drm_device *dev, void *data,
 	return err;
 }
 
+/**
+ * drm_spoof_reset - Spoof a fake reset
+ *
+ * @reset: reset struct to be spoofed
+ *
+ * Create a fake reset report for testing
+ */
+static void drm_spoof_reset(struct drm_get_reset *reset)
+{
+	reset->dev_reset_count = 1;
+	reset->ctx_reset_count = 0;
+	reset->flags = 0;
+	reset->ctx_id = 0;
+
+	DRM_INFO("[Spoofed] Reporting reset.ctx = %llu .dev = %llu\n",
+	       reset->ctx_reset_count, reset->dev_reset_count);
+}
+
+/**
+ * drm_getreset - Get reset information from a DRM device
+ *
+ * @dev DRM device
+ * @data user argument, pointing to a drm_get_reset structure
+ * @filp file pointer
+ *
+ * Return zero on success or negative number on failure.
+ *
+ * Fills in the reset information in data arg.
+ */
+int drm_getreset(struct drm_device *dev, void *data,
+			struct drm_file *file_priv)
+{
+	struct drm_get_reset *reset = data;
+	int ret = 0;
+
+	if (dev->reset_spoof) {
+		drm_spoof_reset(reset);
+		return 0;
+	}
+
+	if (!dev->driver->get_reset)
+		return -ENOSYS;
+
+	if (reset->flags)
+		return -EINVAL;
+
+	ret = dev->driver->get_reset(file_priv, dev, reset);
+
+	if (!ret)
+		DRM_INFO("Reporting reset.ctx = %llu .dev = %llu\n",
+		       reset->ctx_reset_count, reset->dev_reset_count);
+	else
+		DRM_WARN("%s failed with %d return\n", __func__, ret);
+
+	return ret;
+}
+
 static int drm_ioctl_permit(u32 flags, struct drm_file *file_priv)
 {
 	/* ROOT_ONLY is only for CAP_SYS_ADMIN */
@@ -716,6 +773,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_LIST_LESSEES, drm_mode_list_lessees_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GET_LEASE, drm_mode_get_lease_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_REVOKE_LEASE, drm_mode_revoke_lease_ioctl, DRM_MASTER),
+	DRM_IOCTL_DEF(DRM_IOCTL_GET_RESET, drm_getreset, DRM_RENDER_ALLOW),
 };
 
 #define DRM_CORE_IOCTL_COUNT	ARRAY_SIZE(drm_ioctls)
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 7cf4afae2e79..fcd7b5d45cde 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -326,6 +326,9 @@ struct drm_device {
 	 */
 	struct list_head debugfs_list;
 
+	/* Spoof device reset for testing */
+	bool reset_spoof;
+
 	/* Everything below here is for legacy driver, never use! */
 	/* private: */
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 89e2706cac56..518a9db157fb 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -401,6 +401,9 @@ struct drm_driver {
 			       struct drm_device *dev, uint32_t handle,
 			       uint64_t *offset);
 
+	int (*get_reset)(struct drm_file *file_priv,
+			 struct drm_device *dev, struct drm_get_reset *reset);
+
 	/**
 	 * @show_fdinfo:
 	 *
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index a87bbbbca2d4..a84559aa0d77 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1169,6 +1169,27 @@ extern "C" {
  */
 #define DRM_IOCTL_MODE_GETFB2		DRM_IOWR(0xCE, struct drm_mode_fb_cmd2)
 
+/**
+ * DRM_IOCTL_GET_RESET - Get information about device resets
+ *
+ * This operation requests from the device information about resets. It should
+ * consider only resets that happens after the context is created, therefore,
+ * the counter should be zero during context creation.
+ *
+ * dev_reset_count tells how many resets have happened on this device, and
+ * ctx_reset_count tells how many of such resets were caused by this context.
+ *
+ * Flags can be used to tell if a reset is in progress, and userspace should
+ * wait until it's not in progress anymore to be able to create a new context;
+ * and to tell if the VRAM is considered lost. There's no safe way to clean this
+ * flag so if a context see this flag set, it should be like that until the end
+ * of the context.
+ */
+#define DRM_IOCTL_GET_RESET		DRM_IOWR(0xCF, struct drm_get_reset)
+
+#define DRM_RESET_IN_PROGRESS	0x1
+#define DRM_RESET_VRAM_LOST	0x2
+
 /*
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 43691058d28f..c3257bd1af9c 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1308,6 +1308,21 @@ struct drm_mode_rect {
 	__s32 y2;
 };
 
+/**
+ * struct drm_get_reset - Get information about a DRM device resets
+ * @ctx_id: the context id to be queried about resets
+ * @flags: flags
+ * @dev_reset_count: global counter of resets for a given DRM device
+ * @ctx_reset_count: of all the resets counted by this device, how many were
+ * caused by this context.
+ */
+struct drm_get_reset {
+	__u32 ctx_id;
+	__u32 flags;
+	__u64 dev_reset_count;
+	__u64 ctx_reset_count;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.41.0

