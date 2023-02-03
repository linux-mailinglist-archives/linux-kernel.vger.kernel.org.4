Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF05468A6EE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 00:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjBCXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 18:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjBCXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:34:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4531633F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 15:34:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k13so6879229plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6oU+/BUJEqSH1rwyi+AFr1P0CnGEURs/L67LaOUlsvI=;
        b=MWi1HGbriGJlFR7rmopelt7eIZpVNld6It8CyxxIDjlZVJBvAIJsiQfdo0sxwXjFHK
         NRBzgZpd9fyRXRg9WozmvwZ//jCcAp+z2BfHA0oMliaqBGjUw7rE2dCKNhrbMZpIPvTc
         RzOQgSSAn1wa199dehrjf8zmZy/nmSut7c58g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oU+/BUJEqSH1rwyi+AFr1P0CnGEURs/L67LaOUlsvI=;
        b=NYa/K8MEgbS8trV7EtAoDUvQa29J25F5zcU+NBA0dC2qciMFD6PdWABC1P715hPgPA
         0c7ygNXN8I4FISA/x9bfxG2eMrjvklwIqcznRKOOge2fmtlirbNajKoHh3CPct+ulyc0
         9p3XXnYPT8Il0ZMFzm4EFMjETSDInvC0O44Pj2rZ8ThLXOOQGGDnudw+txHSrs95zc3E
         YaQy+gMgmGgFYvn6IaduAwsLfYYOjQf2oP2CBiTrFTjBPi49tyNRqB8bN1/+/ipWJkFw
         cRd42OJ4V/MLzE+0DOrnqYzZoPdzMDTWevBF7ubWXGMbqhurOTAn+f44RnMIHUJoLt1X
         yoeQ==
X-Gm-Message-State: AO0yUKUJhKT9xr8N34hOnZih5Nk36ryXPQE0TCqOiCqVd1tITWwumU01
        /yQVktbxMojwoH9jUzCi88vRTg==
X-Google-Smtp-Source: AK7set9LBswFtzsZwcR9gI92dra3cplBvHIJtb4P0+iR/Itdg7R5FNXZd6oCRgXiBpg57MuEu89ZQA==
X-Received: by 2002:a17:902:c20c:b0:194:9b4e:1c90 with SMTP id 12-20020a170902c20c00b001949b4e1c90mr11508975pll.57.1675467252881;
        Fri, 03 Feb 2023 15:34:12 -0800 (PST)
Received: from ryanneph-glaptop.corp.google.com ([2620:15c:9d:200:7617:a96c:96d2:ed12])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001947c617c45sm2144320plb.221.2023.02.03.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 15:34:12 -0800 (PST)
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
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: [PATCH v2] drm/virtio: exbuf->fence_fd unmodified on interrupted wait
Date:   Fri,  3 Feb 2023 15:33:44 -0800
Message-Id: <20230203233345.2477767-1-ryanneph@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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
passed value for exbuf->fence_fd when returning anything besides a
successful result from the ioctl.

Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
Signed-off-by: Ryan Neph <ryanneph@chromium.org>
Reviewed-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

---

Changes in v2:
- No longer modifies exbuf->fence_fd unless DRM_IOCTL_VIRTGPU_EXECBUFFER
  succeeds.
- Added r-b tags (Rob/Dmitry) from v1.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +----
 include/uapi/drm/virtgpu_drm.h         | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 9f4a90493aea..da45215a933d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -126,7 +126,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	void __user *user_bo_handles = NULL;
 	struct virtio_gpu_object_array *buflist = NULL;
 	struct sync_file *sync_file;
-	int in_fence_fd = exbuf->fence_fd;
 	int out_fence_fd = -1;
 	void *buf;
 	uint64_t fence_ctx;
@@ -152,13 +151,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		ring_idx = exbuf->ring_idx;
 	}
 
-	exbuf->fence_fd = -1;
-
 	virtio_gpu_create_context(dev, file);
 	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
 		struct dma_fence *in_fence;
 
-		in_fence = sync_file_get_fence(in_fence_fd);
+		in_fence = sync_file_get_fence(exbuf->fence_fd);
 
 		if (!in_fence)
 			return -EINVAL;
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 0512fde5e697..7b158fcb02b4 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -64,6 +64,7 @@ struct drm_virtgpu_map {
 	__u32 pad;
 };
 
+/* fence_fd is modified on success if VIRTGPU_EXECBUF_FENCE_FD_OUT flag is set. */
 struct drm_virtgpu_execbuffer {
 	__u32 flags;
 	__u32 size;
-- 
2.39.1.519.gcb327c4b5f-goog

