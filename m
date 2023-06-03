Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6E9720F6A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjFCKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjFCKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 06:39:29 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3BBAE44
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 03:39:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Bxq+pcGHtkaOoDAA--.4145S3;
        Sat, 03 Jun 2023 18:39:24 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLb9bGHtkMTGHAA--.24004S7;
        Sat, 03 Jun 2023 18:39:23 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v7 5/7] drm/etnaviv: allow bypass component framework
Date:   Sat,  3 Jun 2023 18:39:21 +0800
Message-Id: <20230603103923.3041723-6-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230603103923.3041723-1-suijingfeng@loongson.cn>
References: <20230603103923.3041723-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxLb9bGHtkMTGHAA--.24004S7
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gr4UCr4UWryUKw1kCF1fCrg_yoW3tr13pF
        4xJayYkrW8uayqg34UArn5ZF13Cw1Sq34Iy34kK3sakw45JryktF1YyFyjyFnxJrZ5WFW3
        tr1DtrWUAF40y3DanT9S1TB71UUUU1DqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b6AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
        JwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4
        CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj
        6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
        CY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUe6OJ5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds another code path to allow bypass component frameworks, A platform
with a single GPU core could probably try the non-component code path.
This patch is for code sharing, no functional change.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 47 ++++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 84 +++++++++++++++++----------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  3 +
 3 files changed, 91 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6a048be02857..93ca240cd4c0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -536,10 +536,9 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.minor              = 3,
 };
 
-/*
- * Platform driver:
- */
-static int etnaviv_bind(struct device *dev)
+static struct etnaviv_drm_private *etna_private_ptr;
+
+static int etnaviv_drm_bind(struct device *dev, bool component)
 {
 	struct etnaviv_drm_private *priv;
 	struct drm_device *drm;
@@ -556,12 +555,15 @@ static int etnaviv_bind(struct device *dev)
 	}
 
 	drm->dev_private = priv;
+	etna_private_ptr = priv;
 
 	dma_set_max_seg_size(dev, SZ_2G);
 
-	dev_set_drvdata(dev, drm);
+	if (component)
+		ret = component_bind_all(dev, drm);
+	else
+		ret = etnaviv_gpu_bind(dev, NULL, drm);
 
-	ret = component_bind_all(dev, drm);
 	if (ret < 0)
 		goto out_free_priv;
 
@@ -574,7 +576,10 @@ static int etnaviv_bind(struct device *dev)
 	return 0;
 
 out_unbind:
-	component_unbind_all(dev, drm);
+	if (component)
+		component_unbind_all(dev, drm);
+	else
+		etnaviv_gpu_unbind(dev, NULL, drm);
 out_free_priv:
 	etnaviv_free_private(priv);
 out_put:
@@ -583,14 +588,17 @@ static int etnaviv_bind(struct device *dev)
 	return ret;
 }
 
-static void etnaviv_unbind(struct device *dev)
+static void etnaviv_drm_unbind(struct device *dev, bool component)
 {
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct etnaviv_drm_private *priv = drm->dev_private;
+	struct etnaviv_drm_private *priv = etna_private_ptr;
+	struct drm_device *drm = priv->drm;
 
 	drm_dev_unregister(drm);
 
-	component_unbind_all(dev, drm);
+	if (component)
+		component_unbind_all(dev, drm);
+	else
+		etnaviv_gpu_unbind(dev, NULL, drm);
 
 	etnaviv_free_private(priv);
 
@@ -599,9 +607,22 @@ static void etnaviv_unbind(struct device *dev)
 	drm_dev_put(drm);
 }
 
+/*
+ * Platform driver:
+ */
+static int etnaviv_master_bind(struct device *dev)
+{
+	return etnaviv_drm_bind(dev, true);
+}
+
+static void etnaviv_master_unbind(struct device *dev)
+{
+	return etnaviv_drm_unbind(dev, true);
+}
+
 static const struct component_master_ops etnaviv_master_ops = {
-	.bind = etnaviv_bind,
-	.unbind = etnaviv_unbind,
+	.bind = etnaviv_master_bind,
+	.unbind = etnaviv_master_unbind,
 };
 
 static int etnaviv_pdev_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 6c7aa9322468..126f0409aaed 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1737,8 +1737,7 @@ static const struct thermal_cooling_device_ops cooling_ops = {
 	.set_cur_state = etnaviv_gpu_cooling_set_cur_state,
 };
 
-static int etnaviv_gpu_bind(struct device *dev, struct device *master,
-	void *data)
+int etnaviv_gpu_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
 	struct etnaviv_drm_private *priv = drm->dev_private;
@@ -1769,7 +1768,6 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	if (ret < 0)
 		goto out_sched;
 
-
 	gpu->drm = drm;
 	gpu->fence_context = dma_fence_context_alloc(1);
 	xa_init_flags(&gpu->user_fences, XA_FLAGS_ALLOC);
@@ -1798,8 +1796,7 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	return ret;
 }
 
-static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
-	void *data)
+void etnaviv_gpu_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
 
@@ -1869,9 +1866,11 @@ static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
 	return 0;
 }
 
-static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
+/* platform independent */
+
+static int etnaviv_gpu_driver_create(struct device *dev, void __iomem *mmio,
+				     int irq, bool component, bool has_clk)
 {
-	struct device *dev = &pdev->dev;
 	struct etnaviv_gpu *gpu;
 	int err;
 
@@ -1879,24 +1878,21 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->dev = &pdev->dev;
+	gpu->dev = dev;
+	gpu->mmio = mmio;
 	mutex_init(&gpu->lock);
 	mutex_init(&gpu->sched_lock);
 
-	/* Map registers: */
-	gpu->mmio = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(gpu->mmio))
-		return PTR_ERR(gpu->mmio);
-
 	/* Get Interrupt: */
-	err = etnaviv_gpu_register_irq(gpu,  platform_get_irq(pdev, 0));
+	err = etnaviv_gpu_register_irq(gpu, irq);
 	if (err)
 		return err;
 
-	/* Get Clocks: */
-	err = etnaviv_gpu_clk_get(gpu);
-	if (err)
-		return err;
+	if (has_clk) {
+		err = etnaviv_gpu_clk_get(gpu);
+		if (err)
+			return err;
+	}
 
 	/* TODO: figure out max mapped size */
 	dev_set_drvdata(dev, gpu);
@@ -1906,24 +1902,27 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	 * autosuspend delay is rather arbitary: no measurements have
 	 * yet been performed to determine an appropriate value.
 	 */
-	pm_runtime_use_autosuspend(gpu->dev);
-	pm_runtime_set_autosuspend_delay(gpu->dev, 200);
-	pm_runtime_enable(gpu->dev);
-
-	err = component_add(&pdev->dev, &gpu_ops);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to register component: %d\n", err);
-		return err;
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 200);
+	pm_runtime_enable(dev);
+
+	if (component) {
+		err = component_add(dev, &gpu_ops);
+		if (err < 0) {
+			dev_err(dev, "failed to register component: %d\n", err);
+			return err;
+		}
 	}
 
 	return 0;
 }
 
-static int etnaviv_gpu_platform_remove(struct platform_device *pdev)
+static void etnaviv_gpu_driver_destroy(struct device *dev, bool component)
 {
-	component_del(&pdev->dev, &gpu_ops);
-	pm_runtime_disable(&pdev->dev);
-	return 0;
+	if (component)
+		component_del(dev, &gpu_ops);
+
+	pm_runtime_disable(dev);
 }
 
 static int etnaviv_gpu_rpm_suspend(struct device *dev)
@@ -1973,6 +1972,31 @@ static const struct dev_pm_ops etnaviv_gpu_pm_ops = {
 	RUNTIME_PM_OPS(etnaviv_gpu_rpm_suspend, etnaviv_gpu_rpm_resume, NULL)
 };
 
+static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *mmio;
+	int irq;
+
+	/* Map registers: */
+	mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	irq = platform_get_irq(pdev, 0);
+
+	return etnaviv_gpu_driver_create(dev, mmio, irq, true, true);
+}
+
+static int etnaviv_gpu_platform_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	etnaviv_gpu_driver_destroy(dev, true);
+
+	return 0;
+}
+
 struct platform_driver etnaviv_gpu_driver = {
 	.driver = {
 		.name = "etnaviv-gpu",
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 98c6f9c320fc..1ec829a649b5 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -206,6 +206,9 @@ void etnaviv_gpu_pm_put(struct etnaviv_gpu *gpu);
 int etnaviv_gpu_wait_idle(struct etnaviv_gpu *gpu, unsigned int timeout_ms);
 void etnaviv_gpu_start_fe(struct etnaviv_gpu *gpu, u32 address, u16 prefetch);
 
+int etnaviv_gpu_bind(struct device *dev, struct device *master, void *data);
+void etnaviv_gpu_unbind(struct device *dev, struct device *master, void *data);
+
 extern struct platform_driver etnaviv_gpu_driver;
 
 #endif /* __ETNAVIV_GPU_H__ */
-- 
2.25.1

