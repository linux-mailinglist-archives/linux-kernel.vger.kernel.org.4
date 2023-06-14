Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBF72F2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbjFNCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbjFNCsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:48:06 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12D661BE9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:47:59 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:39796.1729481184
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 56F9A102A0A;
        Wed, 14 Jun 2023 10:47:57 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id 9bcf566c75864b53860340869d884dc2 for l.stach@pengutronix.de;
        Wed, 14 Jun 2023 10:47:59 CST
X-Transaction-ID: 9bcf566c75864b53860340869d884dc2
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v9 9/9] drm/etnaviv: Clean up etnaviv_pdev_probe() function
Date:   Wed, 14 Jun 2023 10:47:45 +0800
Message-Id: <20230614024745.865129-10-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614024745.865129-1-15330273260@189.cn>
References: <20230614024745.865129-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Add a dedicate function to do the DMA configuration to the virtual master.
Also replace the &pdev->dev with dev.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 65 +++++++++++++++------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 0ee7f641cee3..df4c21a17d9d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -54,6 +54,40 @@ static bool etnaviv_is_dma_coherent(struct device *dev)
 	return coherent;
 }
 
+static int etnaviv_of_dma_configure(struct device *dev)
+{
+	struct device_node *first_node;
+
+	/*
+	 * PTA and MTLB can have 40 bit base addresses, but
+	 * unfortunately, an entry in the MTLB can only point to a
+	 * 32 bit base address of a STLB. Moreover, to initialize the
+	 * MMU we need a command buffer with a 32 bit address because
+	 * without an MMU there is only an indentity mapping between
+	 * the internal 32 bit addresses and the bus addresses.
+	 *
+	 * To make things easy, we set the dma_coherent_mask to 32
+	 * bit to make sure we are allocating the command buffers and
+	 * TLBs in the lower 4 GiB address space.
+	 */
+	if (dma_set_mask(dev, DMA_BIT_MASK(40)) ||
+	    dma_set_coherent_mask(dev, DMA_BIT_MASK(32))) {
+		dev_err(dev, "No suitable DMA available\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Apply the same DMA configuration to the virtual etnaviv
+	 * device as the GPU we found. This assumes that all Vivante
+	 * GPUs in the system share the same DMA constraints.
+	 */
+	first_node = etnaviv_of_first_available_node();
+	if (first_node)
+		of_dma_configure(dev, first_node, true);
+
+	return 0;
+}
+
 /*
  * etnaviv private data construction and destructions:
  */
@@ -663,7 +697,6 @@ static const struct component_master_ops etnaviv_master_ops = {
 static int etnaviv_pdev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *first_node = NULL;
 	struct component_match *match = NULL;
 
 	if (!dev->platform_data) {
@@ -673,10 +706,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			if (!of_device_is_available(core_node))
 				continue;
 
-			if (!first_node)
-				first_node = core_node;
-
-			drm_of_component_match_add(&pdev->dev, &match,
+			drm_of_component_match_add(dev, &match,
 						   component_compare_of, core_node);
 		}
 	} else {
@@ -687,31 +717,8 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			component_match_add(dev, &match, component_compare_dev_name, names[i]);
 	}
 
-	/*
-	 * PTA and MTLB can have 40 bit base addresses, but
-	 * unfortunately, an entry in the MTLB can only point to a
-	 * 32 bit base address of a STLB. Moreover, to initialize the
-	 * MMU we need a command buffer with a 32 bit address because
-	 * without an MMU there is only an indentity mapping between
-	 * the internal 32 bit addresses and the bus addresses.
-	 *
-	 * To make things easy, we set the dma_coherent_mask to 32
-	 * bit to make sure we are allocating the command buffers and
-	 * TLBs in the lower 4 GiB address space.
-	 */
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(40)) ||
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
-		dev_dbg(&pdev->dev, "No suitable DMA available\n");
+	if (etnaviv_of_dma_configure(dev))
 		return -ENODEV;
-	}
-
-	/*
-	 * Apply the same DMA configuration to the virtual etnaviv
-	 * device as the GPU we found. This assumes that all Vivante
-	 * GPUs in the system share the same DMA constraints.
-	 */
-	if (first_node)
-		of_dma_configure(&pdev->dev, first_node, true);
 
 	return component_master_add_with_match(dev, &etnaviv_master_ops, match);
 }
-- 
2.25.1

