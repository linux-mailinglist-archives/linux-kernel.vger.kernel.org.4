Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C260F6AB2E7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCEWMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCEWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:11:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A841B56C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 14:11:44 -0800 (PST)
Received: from workpc.. (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 88FF366021D4;
        Sun,  5 Mar 2023 22:11:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678054303;
        bh=TDFrhbBWF0ucqm92sCbpy3xDfts2RbHE70GCYFDMUb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byw/5vK60u75qY454Bl72GHjzJj560DDhYFhFQJ5C9TD11PhDfK0rtHAUmAFkjZWP
         7+oVbeqeK4tgi5eKXmjQ//WhIs+oDsV96QiXmJaoHE28AXYD+yX9z63+DuMg1lT2DM
         kUv7VMU2lbpQz5rp3SOBewLDOQGfSRc2u/AJwP3LyhDSzgMT7FT6U3M0NNjueAcjNx
         I8Fk/Bgghohi6d21sbTGUQ7ghMN5W1Sn6qW3nYx0QQ+voCaKdZE/eC5UgdhDo4kJrq
         gvZVpqElKgvpxbfzWKoUyejlE3/s7UYlp7rj4Q6WlS0hBzL1NsJ48gKu2BWr8aIVsM
         jkTxVu9Wfrd+A==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v12 09/11] drm/gem: Export drm_gem_pin/unpin()
Date:   Mon,  6 Mar 2023 01:10:09 +0300
Message-Id: <20230305221011.1404672-10-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305221011.1404672-1-dmitry.osipenko@collabora.com>
References: <20230305221011.1404672-1-dmitry.osipenko@collabora.com>
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

Export drm_gem_un/pin() functions. They will be used by VirtIO-GPU driver
for pinning of an active framebuffer, preventing it from swapping out by
memory shrinker.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c      | 2 ++
 drivers/gpu/drm/drm_internal.h | 2 --
 include/drm/drm_gem.h          | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 3da34b121c93..6492c47b7142 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1153,12 +1153,14 @@ int drm_gem_pin(struct drm_gem_object *obj)
 	else
 		return 0;
 }
+EXPORT_SYMBOL(drm_gem_pin);
 
 void drm_gem_unpin(struct drm_gem_object *obj)
 {
 	if (obj->funcs->unpin)
 		obj->funcs->unpin(obj);
 }
+EXPORT_SYMBOL(drm_gem_unpin);
 
 int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index d7e023bbb0d5..55d0ee7475f7 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -173,8 +173,6 @@ void drm_gem_release(struct drm_device *dev, struct drm_file *file_private);
 void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
 			const struct drm_gem_object *obj);
 
-int drm_gem_pin(struct drm_gem_object *obj);
-void drm_gem_unpin(struct drm_gem_object *obj);
 int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 7bd8e2bbbb36..f7703cb66569 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -493,4 +493,7 @@ unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
 
 int drm_gem_evict(struct drm_gem_object *obj);
 
+int drm_gem_pin(struct drm_gem_object *obj);
+void drm_gem_unpin(struct drm_gem_object *obj);
+
 #endif /* __DRM_GEM_H__ */
-- 
2.39.2

