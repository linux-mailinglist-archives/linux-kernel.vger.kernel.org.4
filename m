Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EDD634E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiKWDAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiKWDAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:00:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98208DA4C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:00:19 -0800 (PST)
Received: from dimapc.. (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C28496602AEE;
        Wed, 23 Nov 2022 03:00:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669172418;
        bh=RT5S0yzlaNnCWPARh+1Inmti1GJA1337tFu57txKjKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hhc+CVgz3ztZzhqdqHOTNzN4wdgJzLzwr4A9Wu6OVixxsAi12YBGiHpRZxyozeHnb
         16NoycUMWhhtlKjvjjVZ+Ba4sqjm4j94MjW++DYcWthha17ktWLmGHbsBQSMwetrfC
         oarSIj2efludtgTL1dme9UDMGJaNjCrB3xE8OrELTLaQMThKz0KtlnXDAkXo5fp0pv
         kWfQaDrKOuedrLkH2RS/mp97DGfVRPbJT69X00Dpa97H1AWIKRXqDY6JJYJmNUlH+6
         F4wQuW4EHv8OCIFQKywWdxsa9IkaAD9X6wj+pcwwW2FBMR0tExzUa+4U0/XRV63tp9
         RGzyWE9qLUGWg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
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
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 03/11] drm/gem: Add evict() callback to drm_gem_object_funcs
Date:   Wed, 23 Nov 2022 05:57:15 +0300
Message-Id: <20221123025723.695075-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123025723.695075-1-dmitry.osipenko@collabora.com>
References: <20221123025723.695075-1-dmitry.osipenko@collabora.com>
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

Add new common evict() callback to drm_gem_object_funcs and corresponding
drm_gem_object_evict() helper. This is a first step on a way to providing
common GEM-shrinker API for DRM drivers.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 15 +++++++++++++++
 include/drm/drm_gem.h     | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 299bca1390aa..c0510b8080d2 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1458,3 +1458,18 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
 	return freed;
 }
 EXPORT_SYMBOL(drm_gem_lru_scan);
+
+/**
+ * drm_gem_object_evict - helper to evict backing pages for a GEM object
+ * @obj: obj in question
+ */
+bool
+drm_gem_object_evict(struct drm_gem_object *obj)
+{
+	dma_resv_assert_held(obj->resv);
+
+	if (obj->funcs->evict)
+		return obj->funcs->evict(obj);
+
+	return false;
+}
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index b46ade812443..add1371453f0 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -172,6 +172,16 @@ struct drm_gem_object_funcs {
 	 * This is optional but necessary for mmap support.
 	 */
 	const struct vm_operations_struct *vm_ops;
+
+	/**
+	 * @evict:
+	 *
+	 * Evicts gem object out from memory. Used by the drm_gem_object_evict()
+	 * helper. Returns true on success, false otherwise.
+	 *
+	 * This callback is optional.
+	 */
+	bool (*evict)(struct drm_gem_object *obj);
 };
 
 /**
@@ -480,4 +490,6 @@ unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
 			       unsigned long *remaining,
 			       bool (*shrink)(struct drm_gem_object *obj));
 
+bool drm_gem_object_evict(struct drm_gem_object *obj);
+
 #endif /* __DRM_GEM_H__ */
-- 
2.38.1

