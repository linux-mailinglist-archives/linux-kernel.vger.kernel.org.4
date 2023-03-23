Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C26C5D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCWDuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCWDuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:50:01 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D32E812
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:49:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679543398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hxk1tPXXlo5ZIXnQqwMJGDLGtwqoxWRQpN6/IOTKuqk=;
        b=TP6UOdGxZJkKQLrZZ3xOz3dNMNJ+DbV9bPtAzgnUMMprYHOgqvwVo1qyUQB6BoU2PKWc+F
        TuseYRNhIHRc5L2L6Ic6n5iC9Ms/9o2vH796OS/ko53c9TTmqKD/NHYzO4k8diIhOqZ/JO
        3FtEtZ904YnMgY/KF5TZaM890dGEumc=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com
Cc:     Cai huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v8 1/4] dmaengine: dw-edma: Rename dw_edma_core_ops structure to dw_edma_plat_ops
Date:   Thu, 23 Mar 2023 11:49:38 +0800
Message-Id: <20230323034944.78357-2-cai.huoqing@linux.dev>
In-Reply-To: <20230323034944.78357-1-cai.huoqing@linux.dev>
References: <20230323034944.78357-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cai huoqing <cai.huoqing@linux.dev>

The dw_edma_core_ops structure contains a set of the operations:
device IRQ numbers getter, CPU/PCI address translation. Based on the
functions semantics the structure name "dw_edma_plat_ops" looks more
descriptive since indeed the operations are platform-specific. The
"dw_edma_core_ops" name shall be used for a structure with the IP-core
specific set of callbacks in order to abstract out DW eDMA and DW HDMA
setups. Such structure will be added in one of the next commit in the
framework of the set of changes adding the DW HDMA device support.

Anyway the renaming was necessary to distinguish two types of
the implementation callbacks:
1. DW eDMA/hDMA IP-core specific operations: device-specific CSR
setups in one or another aspect of the DMA-engine initialization.
2. DW eDMA/hDMA platform specific operations: the DMA device
environment configs like IRQs, address translation, etc.

Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c           | 4 ++--
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 include/linux/dma/edma.h                     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2b40f2b44f5e..1c6043751dc9 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 	return region.start;
 }
 
-static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
+static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.irq_vector = dw_edma_pcie_irq_vector,
 	.pci_address = dw_edma_pcie_address,
 };
@@ -225,7 +225,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	chip->mf = vsec_data.mf;
 	chip->nr_irqs = nr_irqs;
-	chip->ops = &dw_edma_pcie_core_ops;
+	chip->ops = &dw_edma_pcie_plat_ops;
 
 	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 8e33e6e59e68..1f2ee71da4da 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -828,7 +828,7 @@ static int dw_pcie_edma_irq_vector(struct device *dev, unsigned int nr)
 	return platform_get_irq_byname_optional(pdev, name);
 }
 
-static struct dw_edma_core_ops dw_pcie_edma_ops = {
+static struct dw_edma_plat_ops dw_pcie_edma_ops = {
 	.irq_vector = dw_pcie_edma_irq_vector,
 };
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index d2638d9259dc..ed401c965a87 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -40,7 +40,7 @@ struct dw_edma_region {
  *			iATU windows. That will be done by the controller
  *			automatically.
  */
-struct dw_edma_core_ops {
+struct dw_edma_plat_ops {
 	int (*irq_vector)(struct device *dev, unsigned int nr);
 	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
 };
@@ -80,7 +80,7 @@ enum dw_edma_chip_flags {
 struct dw_edma_chip {
 	struct device		*dev;
 	int			nr_irqs;
-	const struct dw_edma_core_ops   *ops;
+	const struct dw_edma_plat_ops	*ops;
 	u32			flags;
 
 	void __iomem		*reg_base;
-- 
2.34.1

