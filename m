Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311CF6AC85E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCFQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCFQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:41:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC4139BA1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:40:52 -0800 (PST)
Received: from workpc.. (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C67DD6602EE4;
        Mon,  6 Mar 2023 16:39:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678120777;
        bh=2qF0hUp8glqDQ1ktUcSd1pu0qhpff4ScS2Sp+BIuEaU=;
        h=From:To:Cc:Subject:Date:From;
        b=W+n6JtB8n30LcsAnOQBmt8DYkHssmRq4ybXRTK7ze63cYN5xZJVUlMFV3qx9bXVTD
         j/CIjJklOkgonUVbISB8pOqdQEyWUu916qZ7CzRH2fhoF61YjwPEgGXK2OXIjhFTRY
         MWIWty2OOEVJhkVzLYE0AAlqTGLuMApawktqS9i+kgx30nBKcAwwPXvvWTslHqSIPe
         jeeB88G3cA2qFqS9DNK7JjeF0WesAtmsy0Q5hJFEBoimyQ1y9wsfEGpR7kxmj9mK2D
         Hs1sK++8a8NiSh0iTCT8DTOhKx14TKSHD7ldpt7Bvk+DdnbmGngXx3FKYedRZ/PpV6
         RY8KK9bD0cOiQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3] drm/virtio: Fix handling CONFIG_DRM_VIRTIO_GPU_KMS option
Date:   Mon,  6 Mar 2023 19:39:16 +0300
Message-Id: <20230306163916.1595961-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VirtIO-GPU got a new config option for disabling KMS. There were two
problems left unnoticed during review when the new option was added:

1. The IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) check in the code was
inverted, hence KMS was disabled when it should be enabled and vice versa.

2. The disabled KMS crashed kernel with a NULL dereference in
drm_kms_helper_hotplug_event(), which shall not be invoked with a
disabled KMS.

Fix the inverted config option check in the code and skip handling the
VIRTIO_GPU_EVENT_DISPLAY sent by host when KMS is disabled in guest to fix
the crash.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---

Changelog:

v3: - Moved another similar "has_edid" occurence under the "num_scanouts"
      condition in virtio_gpu_init(), like was suggested by Emil Velikov.

    - Added ack from Gerd Hoffmann.

v2: - Moved the "has_edid" under the "num_scanouts" condition, like was
      suggested by Gerd Hoffmann.

 drivers/gpu/drm/virtio/virtgpu_kms.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 874ad6c2621a..43e237082cec 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -43,11 +43,13 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			events_read, &events_read);
 	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
-		if (vgdev->has_edid)
-			virtio_gpu_cmd_get_edids(vgdev);
-		virtio_gpu_cmd_get_display_info(vgdev);
-		virtio_gpu_notify(vgdev);
-		drm_helper_hpd_irq_event(vgdev->ddev);
+		if (vgdev->num_scanouts) {
+			if (vgdev->has_edid)
+				virtio_gpu_cmd_get_edids(vgdev);
+			virtio_gpu_cmd_get_display_info(vgdev);
+			virtio_gpu_notify(vgdev);
+			drm_helper_hpd_irq_event(vgdev->ddev);
+		}
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
 	}
 	virtio_cwrite_le(vgdev->vdev, struct virtio_gpu_config,
@@ -224,7 +226,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
 				    VIRTIO_GPU_MAX_SCANOUTS);
 
-	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) || !vgdev->num_scanouts) {
+	if (!IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) || !vgdev->num_scanouts) {
 		DRM_INFO("KMS disabled\n");
 		vgdev->num_scanouts = 0;
 		vgdev->has_edid = false;
@@ -253,9 +255,9 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 
 	if (num_capsets)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
-	if (vgdev->has_edid)
-		virtio_gpu_cmd_get_edids(vgdev);
 	if (vgdev->num_scanouts) {
+		if (vgdev->has_edid)
+			virtio_gpu_cmd_get_edids(vgdev);
 		virtio_gpu_cmd_get_display_info(vgdev);
 		virtio_gpu_notify(vgdev);
 		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
-- 
2.39.2

