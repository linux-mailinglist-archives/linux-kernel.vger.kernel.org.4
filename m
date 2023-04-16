Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3D6E37D1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDPLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjDPLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:53:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CCE2108
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:53:23 -0700 (PDT)
Received: from workpc.. (unknown [IPv6:2a00:1370:817e:4eb4:c5e6:4b85:1e3f:55e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D3BB6603234;
        Sun, 16 Apr 2023 12:53:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681646002;
        bh=fwT8AKV/EdqplpLFzWlWVv7m8/aj98/oTicpTA0Rbz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMxpQFyz3KOewQkhNGyNtbZlH8KUH+MUBOIxKxD+TX3NCNKuGqTaGGpbY1V1SiVa+
         VFOLzIPfnQSzQWsYplt2PGzWPjkcsdgAYQ7JJCZrsUsvZf1irZ/HaWT1j0Q0GQv5/k
         6YOEO396U+X7FUgs1XOmqanti7Ip5mUNdaIHEx0RDHYu0MNJGfPCxkZx14yv2riJsp
         pDIT2llV8OzMarEibdu5YJ+WfLKkAwJ9vMfQdFpU6GgKprQmdwUt7Lrs4tWr6s65pH
         wZkkdJdoYSIbvb+wZqio4n20Unw6Iu4Rfy69XwJitXR+fhRPGm2hv63lPkHa3M05Rl
         7NLdXak1+ZKZQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v6 2/3] drm/virtio: Wait for each dma-fence of in-fence array individually
Date:   Sun, 16 Apr 2023 14:52:36 +0300
Message-Id: <20230416115237.798604-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
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

Use dma-fence-unwrap API for waiting each dma-fence of the in-fence array
individually. Sync file's in-fence array always has a non-matching fence
context ID, which doesn't allow to skip waiting of fences with a matching
context ID in a case of a merged sync file fence.

Suggested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 84e7c4d9d8c7..cf3c04b16a7a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -32,8 +32,8 @@ struct virtio_gpu_submit {
 	void *buf;
 };
 
-static int virtio_gpu_dma_fence_wait(struct virtio_gpu_submit *submit,
-				     struct dma_fence *in_fence)
+static int virtio_gpu_do_fence_wait(struct virtio_gpu_submit *submit,
+				    struct dma_fence *in_fence)
 {
 	u32 context = submit->fence_ctx + submit->ring_idx;
 
@@ -43,6 +43,22 @@ static int virtio_gpu_dma_fence_wait(struct virtio_gpu_submit *submit,
 	return dma_fence_wait(in_fence, true);
 }
 
+static int virtio_gpu_dma_fence_wait(struct virtio_gpu_submit *submit,
+				     struct dma_fence *fence)
+{
+	struct dma_fence_unwrap itr;
+	struct dma_fence *f;
+	int err;
+
+	dma_fence_unwrap_for_each(f, &itr, fence) {
+		err = virtio_gpu_do_fence_wait(submit, f);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int virtio_gpu_fence_event_create(struct drm_device *dev,
 					 struct drm_file *file,
 					 struct virtio_gpu_fence *fence,
-- 
2.39.2

