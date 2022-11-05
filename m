Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F198661DFB3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 00:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKEX3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 19:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiKEX3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 19:29:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306310B6A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 16:29:13 -0700 (PDT)
Received: from dimapc.. (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D46E6602966;
        Sat,  5 Nov 2022 23:29:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667690952;
        bh=vbVBlvxc2Xe9eEsRj4GTle+nnT3PFJq80uOvrVBOKHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxg4owk8Wj8lCKX2iriLQJDmAXo6LCYQcVBH2wKNWh7xXy7u1+RPH8xrq1uT1hia0
         C7Eo8mZfOrJNQawIVCGlxNCW3Bzbc4UKj8FiedWRsjvYUgR2RDzUf9dP/AC03M/pnz
         G6qsTemVYuiUcBwYveJlTr0/Ori5tJJZe7X7TC2xLol7culnPwjvDR4YXhst5oTYyx
         xocbL70C6rcz5FY1KYMjyf49DwNZttv5hCxcXN/whKJThsCv2KB4uuGfWR3VpJfb48
         X1Sc7jM+E14K6ERFsRPdKQ2AAwCLLbQbMmTHbT3YxwdV8ONr0AnWllk2NY0kKEyIM0
         pbejPAnhrtWAA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 5/7] drm/gem: Add drm_gem_pin_unlocked()
Date:   Sun,  6 Nov 2022 02:27:17 +0300
Message-Id: <20221105232719.302619-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221105232719.302619-1-dmitry.osipenko@collabora.com>
References: <20221105232719.302619-1-dmitry.osipenko@collabora.com>
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

Add unlocked variants of drm_gem_un/pin() functions. These new helpers
will take care of GEM dma-reservation locking for DRM drivers.

VirtIO-GPU driver will use these helpers to pin shmem framebuffers,
preventing them from eviction during scanout.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 29 +++++++++++++++++++++++++++++
 include/drm/drm_gem.h     |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 299bca1390aa..5b8c66f113a9 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1154,6 +1154,35 @@ void drm_gem_unpin(struct drm_gem_object *obj)
 		obj->funcs->unpin(obj);
 }
 
+int drm_gem_pin_unlocked(struct drm_gem_object *obj)
+{
+	int ret;
+
+	if (!obj->funcs->pin)
+		return 0;
+
+	ret = dma_resv_lock_interruptible(obj->resv, NULL);
+	if (ret)
+		return ret;
+
+	ret = obj->funcs->pin(obj);
+	dma_resv_unlock(obj->resv);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_gem_pin_unlocked);
+
+void drm_gem_unpin_unlocked(struct drm_gem_object *obj)
+{
+	if (!obj->funcs->unpin)
+		return;
+
+	dma_resv_lock(obj->resv, NULL);
+	obj->funcs->unpin(obj);
+	dma_resv_unlock(obj->resv);
+}
+EXPORT_SYMBOL(drm_gem_unpin_unlocked);
+
 int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	int ret;
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index b46ade812443..b43da1652356 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -480,4 +480,7 @@ unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
 			       unsigned long *remaining,
 			       bool (*shrink)(struct drm_gem_object *obj));
 
+int drm_gem_pin_unlocked(struct drm_gem_object *obj);
+void drm_gem_unpin_unlocked(struct drm_gem_object *obj);
+
 #endif /* __DRM_GEM_H__ */
-- 
2.37.3

