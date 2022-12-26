Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E96563F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiLZPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiLZPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:52:36 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B83063A1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=v7BLxcmv54ZghGIeL/NetHeNVse710hXnO8qNFDiNp0=; b=ZfSpBYkgdJpaWdhpFW7tGqNe+r
        nhhtt+CV18qthe4KwLsiJ89OUo2WvsKbl6Z9+ZXKv+uX93ArrYP53iZ3JZqUyX+QM2aMOEfK9oetm
        hol/OLCXeSCGFABw0gSKaltriuUM92t5OyRF6jD+/PNQvvnmlYXt0kI2NWJyXMMdZ8Uon1XWP3jA3
        k5XjuDX5I332whUg9Lcm2Stly5MArl1ipWjQZie26vFmUGL7oKmQNYk7fGUDgNtNQy9gKQkcN1upW
        82fgxAyD5AE0HgyzuWzLEzz1KqyWNYzQMIzehgbsE57x2mpdYq/yZKuV2p1LS2Z6WJjceSa1n39rC
        bNIusnGQ==;
Received: from [187.36.234.139] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p9pmC-00AXBr-6O; Mon, 26 Dec 2022 16:52:32 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, noralf@tronnes.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Emma Anholt <emma@anholt.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6/9] drm/virtio: use new debugfs device-centered functions
Date:   Mon, 26 Dec 2022 12:50:26 -0300
Message-Id: <20221226155029.244355-7-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226155029.244355-1-mcanal@igalia.com>
References: <20221226155029.244355-1-mcanal@igalia.com>
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
drm_debugfs_add_files() function, which center the debugfs files
management on the drm_device instead of drm_minor. Moreover, remove the
debugfs_init hook and add the debugfs files directly on virtio_gpu_probe(),
before drm_dev_register().

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c | 17 +++++++----------
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  5 ++---
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index 853dd9aa397e..91c81b7429cc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -68,8 +68,8 @@ static int virtio_gpu_features(struct seq_file *m, void *data)
 static int
 virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
+	struct drm_debugfs_entry *entry = m->private;
+	struct virtio_gpu_device *vgdev = entry->dev->dev_private;
 
 	seq_printf(m, "fence %llu %lld\n",
 		   (u64)atomic64_read(&vgdev->fence_drv.last_fence_id),
@@ -80,8 +80,8 @@ virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 static int
 virtio_gpu_debugfs_host_visible_mm(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
+	struct drm_debugfs_entry *entry = m->private;
+	struct virtio_gpu_device *vgdev = entry->dev->dev_private;
 	struct drm_printer p;
 
 	if (!vgdev->has_host_visible) {
@@ -94,7 +94,7 @@ virtio_gpu_debugfs_host_visible_mm(struct seq_file *m, void *data)
 	return 0;
 }
 
-static struct drm_info_list virtio_gpu_debugfs_list[] = {
+static struct drm_debugfs_info virtio_gpu_debugfs_list[] = {
 	{ "virtio-gpu-features", virtio_gpu_features },
 	{ "virtio-gpu-irq-fence", virtio_gpu_debugfs_irq_info, 0, NULL },
 	{ "virtio-gpu-host-visible-mm", virtio_gpu_debugfs_host_visible_mm },
@@ -102,10 +102,7 @@ static struct drm_info_list virtio_gpu_debugfs_list[] = {
 
 #define VIRTIO_GPU_DEBUGFS_ENTRIES ARRAY_SIZE(virtio_gpu_debugfs_list)
 
-void
-virtio_gpu_debugfs_init(struct drm_minor *minor)
+void virtio_gpu_debugfs_init(struct drm_device *drm)
 {
-	drm_debugfs_create_files(virtio_gpu_debugfs_list,
-				 VIRTIO_GPU_DEBUGFS_ENTRIES,
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(drm, virtio_gpu_debugfs_list, VIRTIO_GPU_DEBUGFS_ENTRIES);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index ae97b98750b6..83aa77e5893b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -98,6 +98,8 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free;
 
+	virtio_gpu_debugfs_init(dev);
+
 	ret = drm_dev_register(dev, 0);
 	if (ret)
 		goto err_deinit;
@@ -179,9 +181,6 @@ static const struct drm_driver driver = {
 	.dumb_create = virtio_gpu_mode_dumb_create,
 	.dumb_map_offset = virtio_gpu_mode_dumb_mmap,
 
-#if defined(CONFIG_DEBUG_FS)
-	.debugfs_init = virtio_gpu_debugfs_init,
-#endif
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_mmap = drm_gem_prime_mmap,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index b7a64c7dcc2c..663d405ccacd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -469,7 +469,7 @@ struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 	struct sg_table *sgt);
 
 /* virtgpu_debugfs.c */
-void virtio_gpu_debugfs_init(struct drm_minor *minor);
+void virtio_gpu_debugfs_init(struct drm_device *drm);
 
 /* virtgpu_vram.c */
 bool virtio_gpu_is_vram(struct virtio_gpu_object *bo);
-- 
2.38.1

