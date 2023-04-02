Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8456D3947
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjDBQtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDBQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:49:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C691A964;
        Sun,  2 Apr 2023 09:49:25 -0700 (PDT)
Received: from workpc.. (109-252-124-32.nat.spd-mgts.ru [109.252.124.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E447660315A;
        Sun,  2 Apr 2023 17:49:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680454164;
        bh=3dPqETNlCEj0+ulf61itP4Ot/SUrhYkmYMIoCx2fPKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz7XqWFSUwQ7whH4qg7LP3vJN22sMJ6tJVAFYYP25xA4z3DRG1KGfDlsG4yTOf/rH
         IWsf+B6VQFZzh8DeUfPFxHfipE47Qt6ALmmlCulDpkngz+lPv6X67zl5Q3GlLXfv+j
         PtTq0lEcn/lh2Y2t0Wpn9CC6qL291yw6g8PV+CaSt4ag6tpnVtePSKBDulZTkLy4MF
         Z8HESzdkem7v8XNkYcMXUD5fGB+xT/HY52euX6dUxjws/Tk+9J2cfHuNVsOgpATftx
         Nlab9pjuG6Q7tYSdFgPQaRsgQVcF6h258bWkcC795nf53cXT3gbl0zG+OA7Z9keJNy
         dA6uKGsKHfsOA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1 5/7] Revert "drm: Assert held reservation lock for dma-buf mmapping"
Date:   Sun,  2 Apr 2023 19:48:24 +0300
Message-Id: <20230402164826.752842-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230402164826.752842-1-dmitry.osipenko@collabora.com>
References: <20230402164826.752842-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't assert held dma-buf reservation lock on memory mapping of exported
buffer.

We're going to change dma-buf mmap() locking policy such that exporters
will have to handle the lock. The previous locking policy caused deadlock
problem for DRM drivers in a case of self-imported dma-bufs, it's solved
by moving the lock down to exporters.

Fixes: 39ce25291871 ("drm: Assert held reservation lock for dma-buf mmapping")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_prime.c                | 2 --
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 2 --
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c  | 2 --
 drivers/gpu/drm/tegra/gem.c                | 2 --
 4 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 149cd4ff6a3b..cea85e84666f 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -781,8 +781,6 @@ int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct drm_device *dev = obj->dev;
 
-	dma_resv_assert_held(dma_buf->resv);
-
 	if (!dev->driver->gem_prime_mmap)
 		return -ENOSYS;
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index fd556a076d05..1df74f7aa3dc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -97,8 +97,6 @@ static int i915_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	int ret;
 
-	dma_resv_assert_held(dma_buf->resv);
-
 	if (obj->base.size < vma->vm_end - vma->vm_start)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
index 3abc47521b2c..8e194dbc9506 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
@@ -66,8 +66,6 @@ static int omap_gem_dmabuf_mmap(struct dma_buf *buffer,
 	struct drm_gem_object *obj = buffer->priv;
 	int ret = 0;
 
-	dma_resv_assert_held(buffer->resv);
-
 	ret = drm_gem_mmap_obj(obj, omap_gem_mmap_size(obj), vma);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index bce991a2ccc0..871ef5d26523 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -693,8 +693,6 @@ static int tegra_gem_prime_mmap(struct dma_buf *buf, struct vm_area_struct *vma)
 	struct drm_gem_object *gem = buf->priv;
 	int err;
 
-	dma_resv_assert_held(buf->resv);
-
 	err = drm_gem_mmap_obj(gem, gem->size, vma);
 	if (err < 0)
 		return err;
-- 
2.39.2

