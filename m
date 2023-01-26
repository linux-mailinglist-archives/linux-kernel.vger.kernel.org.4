Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C918067D8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjAZW7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAZW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:59:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABADB53986
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:59:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so3283876plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74QDMdiScJ37bdDF7SctdH9jkcXdbZkF3Aa2qa6bze0=;
        b=X/ZjNLClNmW/v7/FhMe+/ztXFGNt3U1F0t96/hRnhFdwqIU1HD9SfUlCmzInWpRtJB
         SPF/imwhGztYUrZnNU8GYbknCUrm0W2plSv2VdytqsYNvnFHd1BewE8Ui0MMiDzoji51
         hZwVJO+/VksAkKomER6Wy3Ylbq/V2iTN3VkEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74QDMdiScJ37bdDF7SctdH9jkcXdbZkF3Aa2qa6bze0=;
        b=TWMOFxEONJaTcpHA1wZRg5te9bUzdMe1DQl5qpnm6uIhEj5NBriyJek51PsaiWTikC
         8ip6kwEMKwB/x+NNXY0gEn6ea4MLaucXADENlL6z0c4BzZnq77mSjpp5caiLFxSyIX+B
         qIuSCXtosC+HNYxqZZrxAKz+Zpi8b5p3APUWTavXTfMM/Dnw+xZjfULW+oDzdYPJwP5q
         R3V23wFLJGYbzkUwjLrzdOzKemn2Hqlk93YURlWg68ioRN6ljqm6beFG+r1jqoWWzFk9
         Vjt8pn3YzdNhLGcWHI8BdALRdbYVxr8f7XSxLUKXQI28dVAI63ZadlNFatkdVpt9bJQ1
         ZF+w==
X-Gm-Message-State: AFqh2kp7qsfZg4Dogjk9MIPI9zR6pX+1wgnfX+pyCYS6eCvEhyh+dzWC
        QxJ5nNWqN+oi9nyMIfCEcExX9ASAiBcbkAsCxH173A==
X-Google-Smtp-Source: AMrXdXshOT93MUx8xKFD+4qe0coPmW40yZUggqej/M3zqEz9EaS3CiQbmZb9fiop+JFmTAg/gzTDJA==
X-Received: by 2002:a17:903:31c3:b0:194:b982:d83c with SMTP id v3-20020a17090331c300b00194b982d83cmr29945851ple.21.1674773956246;
        Thu, 26 Jan 2023 14:59:16 -0800 (PST)
Received: from ryanneph-glaptop.corp.google.com ([2620:15c:9d:200:f493:a4d0:9413:178d])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001962858f990sm1475968plg.164.2023.01.26.14.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:59:15 -0800 (PST)
From:   Ryan Neph <ryanneph@chromium.org>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Yiwei Zhang <zzyiwei@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Ryan Neph <ryanneph@chromium.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Robert Foss <robert.foss@collabora.com>
Subject: [PATCH] drm/virtio: exbuf->fence_fd unmodified on interrupted wait
Date:   Thu, 26 Jan 2023 14:58:15 -0800
Message-Id: <20230126225815.1518839-1-ryanneph@chromium.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
making the retry attempt fail at sync_file_get_fence().

The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
passed value for exbuf->fence_fd when returning ERESTARTSYS or EINTR.

Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
Signed-off-by: Ryan Neph <ryanneph@chromium.org>
---

 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 ++++++---
 include/uapi/drm/virtgpu_drm.h         | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 9f4a90493aea..ffce4e2a409a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -132,6 +132,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	uint64_t fence_ctx;
 	uint32_t ring_idx;
 
+	exbuf->fence_fd = -1;
+
 	fence_ctx = vgdev->fence_drv.context;
 	ring_idx = 0;
 
@@ -152,8 +154,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		ring_idx = exbuf->ring_idx;
 	}
 
-	exbuf->fence_fd = -1;
-
 	virtio_gpu_create_context(dev, file);
 	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
 		struct dma_fence *in_fence;
@@ -173,7 +173,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 		dma_fence_put(in_fence);
 		if (ret)
-			return ret;
+			goto out_err;
 	}
 
 	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
@@ -259,6 +259,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	if (out_fence_fd >= 0)
 		put_unused_fd(out_fence_fd);
+out_err:
+	if (ret == -EINTR || ret == -ERESTARTSYS)
+		exbuf->fence_fd = in_fence_fd;
 
 	return ret;
 }
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 0512fde5e697..ac8d1eed12ab 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -64,6 +64,9 @@ struct drm_virtgpu_map {
 	__u32 pad;
 };
 
+/* For ioctl() returning ERESTARTSYS or EINTR, fence_fd is unmodified.
+ * For all other errors it is set to -1.
+ */
 struct drm_virtgpu_execbuffer {
 	__u32 flags;
 	__u32 size;
-- 
2.39.1.456.gfc5497dd1b-goog

