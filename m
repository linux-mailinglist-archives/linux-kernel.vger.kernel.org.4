Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5336CF4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjC2UwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2Uvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:51:48 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCCD4469E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 13:51:46 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:36106.2084148567
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 29AA2100304;
        Thu, 30 Mar 2023 04:51:45 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id 1f901d09156e45989b64af738c892223 for l.stach@pengutronix.de;
        Thu, 30 Mar 2023 04:51:46 CST
X-Transaction-ID: 1f901d09156e45989b64af738c892223
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v3 6/6] drm/etnaviv: allow usperspace create cached coherent bo
Date:   Thu, 30 Mar 2023 04:51:29 +0800
Message-Id: <20230329205129.1513734-7-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329205129.1513734-1-15330273260@189.cn>
References: <20230329205129.1513734-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

 As Lucas pointed, there should have some way to let mesa query the kernel
 about the host platform whether support cached coherent mode or not. This
 should touch the ioctl stuff I think, bad design may lead new mesa or
 libdrm crash old kernel. It need more instruction how to implement this,
 maybe another patch to do this. Making this driver works on loongson
 platform is far enough for me.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c       |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 22 +++++++++++++++++++--
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  9 ++++++++-
 include/uapi/drm/etnaviv_drm.h              | 11 ++++++-----
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index dbca3bf7fba2..91aeedb837e9 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -276,7 +276,7 @@ static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
 	struct drm_etnaviv_gem_new *args = data;
 
 	if (args->flags & ~(ETNA_BO_CACHED | ETNA_BO_WC | ETNA_BO_UNCACHED |
-			    ETNA_BO_FORCE_MMU))
+			    ETNA_BO_CACHED_COHERENT | ETNA_BO_FORCE_MMU))
 		return -EINVAL;
 
 	return etnaviv_gem_new_handle(dev, file, args->size,
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index b5f73502e3dd..d8b559bd33d3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -343,6 +343,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
 static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 {
 	struct page **pages;
+	pgprot_t prot;
 
 	lockdep_assert_held(&obj->lock);
 
@@ -350,8 +351,20 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 	if (IS_ERR(pages))
 		return NULL;
 
-	return vmap(pages, obj->base.size >> PAGE_SHIFT,
-			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+	switch (obj->flags) {
+	case ETNA_BO_CACHED_COHERENT:
+	case ETNA_BO_CACHED:
+		prot = PAGE_KERNEL;
+		break;
+	case ETNA_BO_UNCACHED:
+		prot = pgprot_noncached(PAGE_KERNEL);
+		break;
+	case ETNA_BO_WC:
+	default:
+		prot = pgprot_writecombine(PAGE_KERNEL);
+	}
+
+	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);
 }
 
 static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
@@ -545,6 +558,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
 static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
 	const struct etnaviv_gem_ops *ops, struct drm_gem_object **obj)
 {
+	struct etnaviv_drm_private *priv = dev->dev_private;
 	struct etnaviv_gem_object *etnaviv_obj;
 	unsigned sz = sizeof(*etnaviv_obj);
 	bool valid = true;
@@ -555,6 +569,10 @@ static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
 	case ETNA_BO_CACHED:
 	case ETNA_BO_WC:
 		break;
+	case ETNA_BO_CACHED_COHERENT:
+		if (priv->has_cached_coherent)
+			break;
+		fallthrough;
 	default:
 		valid = false;
 	}
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 7031db145a77..9364874918e3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -104,11 +104,18 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
 struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 	struct dma_buf_attachment *attach, struct sg_table *sgt)
 {
+	struct etnaviv_drm_private *priv = dev->dev_private;
 	struct etnaviv_gem_object *etnaviv_obj;
 	size_t size = PAGE_ALIGN(attach->dmabuf->size);
+	u32 cache_flags;
 	int ret, npages;
 
-	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
+	if (priv->has_cached_coherent)
+		cache_flags = ETNA_BO_CACHED_COHERENT;
+	else
+		cache_flags = ETNA_BO_WC;
+
+	ret = etnaviv_gem_new_private(dev, size, cache_flags,
 				      &etnaviv_gem_prime_ops, &etnaviv_obj);
 	if (ret < 0)
 		return ERR_PTR(ret);
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index af024d90453d..474b0db286de 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -90,13 +90,14 @@ struct drm_etnaviv_param {
  * GEM buffers:
  */
 
-#define ETNA_BO_CACHE_MASK   0x000f0000
+#define ETNA_BO_CACHE_MASK              0x000f0000
 /* cache modes */
-#define ETNA_BO_CACHED       0x00010000
-#define ETNA_BO_WC           0x00020000
-#define ETNA_BO_UNCACHED     0x00040000
+#define ETNA_BO_CACHED                  0x00010000
+#define ETNA_BO_WC                      0x00020000
+#define ETNA_BO_UNCACHED                0x00040000
+#define ETNA_BO_CACHED_COHERENT         0x00080000
 /* map flags */
-#define ETNA_BO_FORCE_MMU    0x00100000
+#define ETNA_BO_FORCE_MMU               0x00100000
 
 struct drm_etnaviv_gem_new {
 	__u64 size;           /* in */
-- 
2.25.1

