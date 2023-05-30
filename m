Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9268B7168B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjE3QHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjE3QGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:06:55 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89E54116
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:06:45 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxFvEUH3ZkLKYCAA--.6024S3;
        Wed, 31 May 2023 00:06:44 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqrYTH3Zket+AAA--.13773S6;
        Wed, 31 May 2023 00:06:44 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v6 4/6] drm/etnaviv: add helpers for private data construction and destruction
Date:   Wed, 31 May 2023 00:06:41 +0800
Message-Id: <20230530160643.2344551-5-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530160643.2344551-1-suijingfeng@loongson.cn>
References: <20230530160643.2344551-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqrYTH3Zket+AAA--.13773S6
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCw4rWr47Gr17WF1kGF1rJFb_yoWrCFy8pF
        srJa40yrWvvF48K3sxJrs8Za43C3WxWa409asFqwn0qw4ayr1kWFn5tFyUAF9xJFyrCFy3
        tw1Dtr1UXF40krJanT9S1TB71UUUU1UqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bh8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAa
        w2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj6I8E
        87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
        xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3U73UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct etnaviv_drm_private contains a lot of common resources that are
shared by all GPUs. This patch introduces two dedicated functions, which
is for the construction and destruction of instances of this structure.
    
The idea is to avoid leaking its members outside. The error handling code
can also be simplified.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 71 +++++++++++++++++----------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h |  4 ++
 2 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 0a9d90c18f2c..56c98711f8e1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -498,28 +498,17 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.minor              = 3,
 };
 
-/*
- * Platform driver:
- */
-static int etnaviv_bind(struct device *dev)
+static int etnaviv_alloc_private(struct device *dev,
+				 struct etnaviv_drm_private **ppriv)
 {
 	struct etnaviv_drm_private *priv;
-	struct drm_device *drm;
 	int ret;
 
-	drm = drm_dev_alloc(&etnaviv_drm_driver, dev);
-	if (IS_ERR(drm))
-		return PTR_ERR(drm);
-
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(dev, "failed to allocate private data\n");
-		ret = -ENOMEM;
-		goto out_put;
+		return -ENOMEM;
 	}
-	drm->dev_private = priv;
-
-	dma_set_max_seg_size(dev, SZ_2G);
 
 	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
 
@@ -528,18 +517,55 @@ static int etnaviv_bind(struct device *dev)
 	priv->num_gpus = 0;
 	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
-	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(drm->dev);
+	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(dev);
 	if (IS_ERR(priv->cmdbuf_suballoc)) {
-		dev_err(drm->dev, "Failed to create cmdbuf suballocator\n");
+		dev_err(dev, "Failed to create cmdbuf suballocator\n");
 		ret = PTR_ERR(priv->cmdbuf_suballoc);
-		goto out_free_priv;
+		kfree(priv);
+		return ret;
 	}
 
+	*ppriv = priv;
+
+	return 0;
+}
+
+static void etnaviv_free_private(struct etnaviv_drm_private *priv)
+{
+	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
+
+	xa_destroy(&priv->active_contexts);
+
+	kfree(priv);
+}
+
+/*
+ * Platform driver:
+ */
+static int etnaviv_bind(struct device *dev)
+{
+	struct etnaviv_drm_private *priv;
+	struct drm_device *drm;
+	int ret;
+
+	drm = drm_dev_alloc(&etnaviv_drm_driver, dev);
+	if (IS_ERR(drm))
+		return PTR_ERR(drm);
+
+	ret = etnaviv_alloc_private(dev, &priv);
+	if (ret)
+		goto out_put;
+
+	priv->drm = drm;
+	drm->dev_private = priv;
+
+	dma_set_max_seg_size(dev, SZ_2G);
+
 	dev_set_drvdata(dev, drm);
 
 	ret = component_bind_all(dev, drm);
 	if (ret < 0)
-		goto out_destroy_suballoc;
+		goto out_free_priv;
 
 	load_gpu(drm);
 
@@ -551,10 +577,8 @@ static int etnaviv_bind(struct device *dev)
 
 out_unbind:
 	component_unbind_all(dev, drm);
-out_destroy_suballoc:
-	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
 out_free_priv:
-	kfree(priv);
+	etnaviv_free_private(priv);
 out_put:
 	drm_dev_put(drm);
 
@@ -570,12 +594,9 @@ static void etnaviv_unbind(struct device *dev)
 
 	component_unbind_all(dev, drm);
 
-	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
-
-	xa_destroy(&priv->active_contexts);
+	etnaviv_free_private(priv);
 
 	drm->dev_private = NULL;
-	kfree(priv);
 
 	drm_dev_put(drm);
 }
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index b3eb1662e90c..87fb52c03c5e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -35,6 +35,7 @@ struct etnaviv_file_private {
 };
 
 struct etnaviv_drm_private {
+	struct drm_device *drm;
 	int num_gpus;
 	struct etnaviv_gpu *gpu[ETNA_MAX_PIPES];
 	gfp_t shm_gfp_mask;
@@ -45,6 +46,9 @@ struct etnaviv_drm_private {
 	struct xarray active_contexts;
 	u32 next_context_id;
 
+	/* hint for platform support cached coherent caching mode */
+	bool has_cached_coherent;
+
 	/* list of GEM objects: */
 	struct mutex gem_lock;
 	struct list_head gem_list;
-- 
2.25.1

