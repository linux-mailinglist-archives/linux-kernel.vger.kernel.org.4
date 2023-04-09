Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5716DBFDB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjDIMkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 08:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDIMko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 08:40:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD283C3D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 05:40:43 -0700 (PDT)
Received: from workpc.. (109-252-119-170.nat.spd-mgts.ru [109.252.119.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 87BBD66031E9;
        Sun,  9 Apr 2023 13:40:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681044042;
        bh=LXZqn9JZkk7iPwWsuND2XuT7vg+8om2rZKLRJkZQfxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLhPIeeTxCNtjwOlYXNAW+NlrRbdIW2XKGHybgjvUcA1SMM00q6WqNQd3DjAxBmHI
         Z7f1QcNcN2c6oAEbPK2uUElaXi0EexP70szW2eB/G9gIuQB2JPvOVNe8VnlcRN+Lrd
         aCFoUcndSp0ulUnPsPFR/8ABEbRLsUpIJNEhI0kBpf1KhF0ejRNwlLGS7BWOpXWXDx
         dsQamKSXuhy2RwWGB3P//OqgZmKYCQwm+imYSadkzdGqJYpzLMkIVQBlUIvx8p2Q72
         wVh/vRtgzCisKbWJAeaOSmRWWXiUoSI4/Dpc6x5CBOoREL7VWRTNMDp87qa8mFLYBA
         Vp+jeejqm+3Jw==
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
Subject: [PATCH v5 2/3] drm/virtio: Wait for each dma-fence of in-fence array individually
Date:   Sun,  9 Apr 2023 15:39:56 +0300
Message-Id: <20230409123957.29553-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230409123957.29553-1-dmitry.osipenko@collabora.com>
References: <20230409123957.29553-1-dmitry.osipenko@collabora.com>
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

Use dma-fence-unwrap API for waiting each dma-fence of the in-fence array
individually. Sync file's in-fence array always has a non-matching fence
context ID, which doesn't allow to skip waiting of fences with a matching
context ID in a case of a merged sync file fence.

Suggested-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 902734778d1b..b60dea077240 100644
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
 	uint32_t context = submit->fence_ctx + submit->ring_idx;
 
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

