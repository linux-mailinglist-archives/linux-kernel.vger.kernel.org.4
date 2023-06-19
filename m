Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF4735718
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjFSMnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFSMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:42:26 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5BBE10D3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:42:21 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:49634.708654646
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id E85ED102995;
        Mon, 19 Jun 2023 20:42:18 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xwndj with ESMTP id a4cbec9d97a5455a8cc00a4dbdebc0e3 for l.stach@pengutronix.de;
        Mon, 19 Jun 2023 20:42:18 CST
X-Transaction-ID: a4cbec9d97a5455a8cc00a4dbdebc0e3
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v10 09/11] drm/etnaviv: Clean up etnaviv_pdev_probe() function
Date:   Mon, 19 Jun 2023 20:41:59 +0800
Message-Id: <20230619124201.2215558-10-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619124201.2215558-1-15330273260@189.cn>
References: <20230619124201.2215558-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
index 47b2cdbb53e2..8907cdb8a1f8 100644
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
@@ -664,7 +698,6 @@ static const struct component_master_ops etnaviv_master_ops = {
 static int etnaviv_pdev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *first_node = NULL;
 	struct component_match *match = NULL;
 
 	if (!dev->platform_data) {
@@ -674,10 +707,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
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
@@ -688,31 +718,8 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
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

