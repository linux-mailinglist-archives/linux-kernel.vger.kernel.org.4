Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06EA73B50A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFWKRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFWKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:17:17 -0400
Received: from out-46.mta0.migadu.com (out-46.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC99172C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:17:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687514927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mYSHA82Ggr/qk8LcxRbWw+jtvr8ZShkQNBHi2vnZ+s=;
        b=Lzg3YyZjlP7eRGip2Pkq+Mlkn9hRfaUhzylAQ7XKNRcqwCBYLb1w4P73Ire/0LVeXvDLIz
        MfyjpGmYhjQcQC4Hb+QFcuzk44dUFpduWHPWYF3n1tUjfYU02Rg7J0nHbNxqVTl/9EN6km
        1KkGyTaVOUxJgeE5C2JJqu6xcW0bLVg=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v1 8/8] drm/etnaviv: Add a helper to get a pointer to the first available node
Date:   Fri, 23 Jun 2023 18:08:22 +0800
Message-Id: <20230623100822.274706-9-sui.jingfeng@linux.dev>
In-Reply-To: <20230623100822.274706-1-sui.jingfeng@linux.dev>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

This make the code in etnaviv_pdev_probe() less twisted, drop the reference
to device node after finished. Also kill a double blank line.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 32 ++++++++++++++++++---------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 7d0eeab3e8b7..3446f8eabf59 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -27,6 +27,19 @@
  * DRM operations:
  */
 
+/* If the DT contains at least one available GPU, return a pointer to it */
+
+static struct device_node *etnaviv_of_first_node(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "vivante,gc") {
+		if (of_device_is_available(np))
+			return np;
+	}
+
+	return NULL;
+}
 
 static void load_gpu(struct drm_device *dev)
 {
@@ -587,7 +600,7 @@ static const struct component_master_ops etnaviv_master_ops = {
 static int etnaviv_pdev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *first_node = NULL;
+	struct device_node *first_node;
 	struct component_match *match = NULL;
 
 	if (!dev->platform_data) {
@@ -597,11 +610,10 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			if (!of_device_is_available(core_node))
 				continue;
 
-			if (!first_node)
-				first_node = core_node;
-
 			drm_of_component_match_add(&pdev->dev, &match,
 						   component_compare_of, core_node);
+
+			of_node_put(core_node);
 		}
 	} else {
 		char **names = dev->platform_data;
@@ -634,8 +646,11 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 * device as the GPU we found. This assumes that all Vivante
 	 * GPUs in the system share the same DMA constraints.
 	 */
-	if (first_node)
+	first_node = etnaviv_of_first_node();
+	if (first_node) {
 		of_dma_configure(&pdev->dev, first_node, true);
+		of_node_put(first_node);
+	}
 
 	return component_master_add_with_match(dev, &etnaviv_master_ops, match);
 }
@@ -709,17 +724,14 @@ static int __init etnaviv_init(void)
 	 * If the DT contains at least one available GPU device, instantiate
 	 * the DRM platform device.
 	 */
-	for_each_compatible_node(np, NULL, "vivante,gc") {
-		if (!of_device_is_available(np))
-			continue;
+	np = etnaviv_of_first_node();
+	if (np) {
 		of_node_put(np);
 
 		ret = etnaviv_create_platform_device("etnaviv",
 						     &etnaviv_platform_device);
 		if (ret)
 			goto unregister_platform_driver;
-
-		break;
 	}
 
 	return 0;
-- 
2.25.1

