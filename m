Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1D714ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjE2RO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjE2ROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:14:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4156CCF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:14:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxfOtq3XRkqEkCAA--.2122S3;
        Tue, 30 May 2023 01:14:18 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD79p3XRkLUJ_AA--.10654S6;
        Tue, 30 May 2023 01:14:18 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Li Yi <liyi@loongson.cn>
Subject: [PATCH v4 4/6] drm/etnaviv: add helpers for private data construction and destruction
Date:   Tue, 30 May 2023 01:14:15 +0800
Message-Id: <20230529171417.2146323-5-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529171417.2146323-1-suijingfeng@loongson.cn>
References: <20230529171417.2146323-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxD79p3XRkLUJ_AA--.10654S6
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCw4rWr47Gr17WF1kGF1rJFb_yoWrCFy8pF
        srJa40yrWvvF48K3sxJrs8Za43C3WxWa409asFqwn0qw4ayr1kWFn5tFyUAF9xJFyrCFy3
        tw1Dtr1UXF40krJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
        AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_
        Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
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

