Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8257168B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjE3QHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjE3QGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:06:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EC66113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:06:45 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dxd_EUH3ZkOaYCAA--.6090S3;
        Wed, 31 May 2023 00:06:44 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqrYTH3Zket+AAA--.13773S8;
        Wed, 31 May 2023 00:06:44 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v6 6/6] drm/etnaviv: allow usperspace create cached coherent bo
Date:   Wed, 31 May 2023 00:06:43 +0800
Message-Id: <20230530160643.2344551-7-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530160643.2344551-1-suijingfeng@loongson.cn>
References: <20230530160643.2344551-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqrYTH3Zket+AAA--.13773S8
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF4fGryfAF4UZFyUZFykAFb_yoWrKFWUpF
        Z3AFyYkrW0v3yDK34xAFn8Za43Gw12gFZ2k3sxtwn09w45tF42qr95KFZ8Crn8Jr1fGry3
        tw1Dtry5K3WjyrJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b68YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0E
        x4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7
        CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2
        IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU01E_tUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cached system RAM is coherent on loongson CPUs, and the GPU and DC allways
snoop the CPU's cache. write-combine caching property is not suitiable for
us.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c       |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 22 +++++++++++++++++++--
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  9 ++++++++-
 include/uapi/drm/etnaviv_drm.h              | 11 ++++++-----
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 052f745cecc0..2816c654c023 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -274,7 +274,7 @@ static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
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
index 3524b5811682..671d91d8f1c6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -112,11 +112,18 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
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

