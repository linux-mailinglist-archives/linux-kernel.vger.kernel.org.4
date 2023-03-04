Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D936AACDF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 23:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCDWGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 17:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 17:06:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1AA1025D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 14:06:09 -0800 (PST)
Received: from workpc.. (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CF96660225B;
        Sat,  4 Mar 2023 22:06:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677967567;
        bh=2eKMCTATYlFljPW4aNKFeI2xXrg1Vr8JjX3ydL1iphA=;
        h=From:To:Cc:Subject:Date:From;
        b=Mta7oilfDcpP/YPqBk+mVLhxrdHDWyRdFu4rrXqaTPyWyy+PviM+MY//n5dFkgA5l
         D8HBxiur4wjYfc7szaXnlB3DxFzlbNE78J6vj3teDaw0oke9hEKHZsDWroBTwprEFi
         UpZnKckWkdkespKstG/8C+YHt4AD68oU4w/Hg7I2AqZUkvzBJ/V5YKGag6ncWarr+0
         Cw58jG3zW6X37YSBYplutby4WmiMhfERG4/cAccYviyhVyovMd3Ix7VZZUJ65FT/+z
         Lg440TYsDe6sZfNtMiAn8uhLLA6jWAQNuJuKxfI5iLu4Hfp5hguHJtYs/1qSAfH/Zv
         U6rNa2Rd/G8rw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, Rob Clark <robdclark@gmail.com>
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v1] drm/virtio: Fix handling CONFIG_DRM_VIRTIO_GPU_KMS option
Date:   Sun,  5 Mar 2023 01:05:10 +0300
Message-Id: <20230304220510.964715-1-dmitry.osipenko@collabora.com>
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

Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 874ad6c2621a..7522fab2b709 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -45,9 +45,11 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
 		if (vgdev->has_edid)
 			virtio_gpu_cmd_get_edids(vgdev);
-		virtio_gpu_cmd_get_display_info(vgdev);
-		virtio_gpu_notify(vgdev);
-		drm_helper_hpd_irq_event(vgdev->ddev);
+		if (vgdev->num_scanouts) {
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
-- 
2.39.2

