Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37495EC07F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiI0LGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiI0LFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:05:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20042F0D;
        Tue, 27 Sep 2022 04:04:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B673E1042;
        Tue, 27 Sep 2022 04:04:18 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3848D3F66F;
        Tue, 27 Sep 2022 04:04:11 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH] of: Fix "dma-ranges" handling for bus controllers
Date:   Tue, 27 Sep 2022 12:04:06 +0100
Message-Id: <6319e6d0b39b58552dcfb1c111b6ec45a5ca6bf8.1664276646.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 951d48855d86 ("of: Make of_dma_get_range() work on bus nodes")
relaxed the handling of "dma-ranges" for any leaf node on the assumption
that it would still represent a usage error for the property to be
present on a non-bus leaf node. However there turns out to be a fiddly
case where a bus also represents a DMA-capable device in its own right,
such as a PCIe root complex with an integrated DMA engine on its
platform side. In such cases, "dma-ranges" translation is entirely valid
for devices discovered behind the bus, but should not be erroneously
applied to the bus controller device itself which operates in its
parent's address space. Fix this by restoring the previous behaviour for
the specific case where a device is configured via its own OF node,
since it is logical to assume that a device should never represent its
own parent bus.

Reported-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/address.c    | 2 +-
 drivers/of/device.c     | 9 ++++++++-
 drivers/of/of_private.h | 5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 96f0a12e507c..497bb64e338b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -579,7 +579,7 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 }
 EXPORT_SYMBOL(of_translate_address);
 
-static struct device_node *__of_get_dma_parent(const struct device_node *np)
+struct device_node *__of_get_dma_parent(const struct device_node *np)
 {
 	struct of_phandle_args args;
 	int ret, index;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 75b6cbffa755..8cefe5a7d04e 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -116,12 +116,19 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 {
 	const struct iommu_ops *iommu;
 	const struct bus_dma_region *map = NULL;
+	struct device_node *bus_np;
 	u64 dma_start = 0;
 	u64 mask, end, size = 0;
 	bool coherent;
 	int ret;
 
-	ret = of_dma_get_range(np, &map);
+	if (np == dev->of_node)
+		bus_np = __of_get_dma_parent(np);
+	else
+		bus_np = of_node_get(np);
+
+	ret = of_dma_get_range(bus_np, &map);
+	of_node_put(bus_np);
 	if (ret < 0) {
 		/*
 		 * For legacy reasons, we have to assume some devices need
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 9324483397f6..fb6792d381a6 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -155,12 +155,17 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
+struct device_node *__of_get_dma_parent(const struct device_node *np);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
+static inline struct device_node *__of_get_dma_parent(const struct device_node *np)
+{
+	return of_get_parent(np);
+}
 #endif
 
 void fdt_init_reserved_mem(void);
-- 
2.36.1.dirty

