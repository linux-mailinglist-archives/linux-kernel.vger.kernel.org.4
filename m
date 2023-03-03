Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379FA6A9777
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCCMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCCMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:47:00 -0500
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [IPv6:2001:41d0:203:375::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE06662319
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:46:58 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677847616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2Gj3Ch7hBh75WMJAHVGAr9mLSJges7Su8Qtlbft6Rc=;
        b=JZ/QDOVn/y7Dp8KWmS+wluD+FTnS5F8Dmyt5PVAwZmwqSdcKUrR0WVwk0aNMgcKGgFLILJ
        rDoeEoULMBh2AqpKS5UAG0R+8fsmRmI1UkmeRbuOc8BuGJDCuu3nL1pyneIcxq48W0Fpzf
        j4jbRUvAsdCA8TlCbcX6MNN3yb8luNE=
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
Subject: [PATCH v5 1/4] dmaengine: dw-edma: Rename dw_edma_core_ops structure to dw_edma_plat_ops
Date:   Fri,  3 Mar 2023 20:46:31 +0800
Message-Id: <20230303124642.5519-2-cai.huoqing@linux.dev>
In-Reply-To: <20230303124642.5519-1-cai.huoqing@linux.dev>
References: <20230303124642.5519-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cai huoqing <cai.huoqing@linux.dev>

Rename dw_edma_core_ops structure to dw_edma_plat_ops, the ops is platform
specific operations: the DMA device environment configs like IRQs,
address translation, etc.

The dw_edma_plat_ops name was supposed to refer to the platform which
the DW eDMA engine is embedded to, like PCIe end-point (accessible via
the PCIe bus) or a PCIe root port (directly accessible by CPU).
Needless to say that for them the IRQ-vector and PCI-addresses are
differently determined. The suggested name has a connection with the
kernel platform device only as a private case of the eDMA/hDMA embedded
into the DW PCI Root ports, though basically it was supposed to refer to
any platform in which the DMA hardware lives.

Anyway the renaming was necessary to distinguish two types of
the implementation callbacks:
1. DW eDMA/hDMA IP-core specific operations: device-specific CSR
setups in one or another aspect of the DMA-engine initialization.
2. DW eDMA/hDMA platform specific operations: the DMA device
environment configs like IRQs, address translation, etc.

dw_edma_core_ops is supposed to be used for the case 1, and
dw_edma_plat_ops - for the case 2.

Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
---
  v4->v5:
    1.Revert the instance dw_edma_pcie_core_ops
    2.Move the change EDMA_MF_HDMA_NATIVE to patch[3/4] 

  v4 link:
  https://lore.kernel.org/lkml/20230221034656.14476-2-cai.huoqing@linux.dev/
 
 drivers/dma/dw-edma/dw-edma-pcie.c           | 2 +-
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 include/linux/dma/edma.h                     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2b40f2b44f5e..190b32d8016d 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 	return region.start;
 }
 
-static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
+static const struct dw_edma_plat_ops dw_edma_pcie_core_ops = {
 	.irq_vector = dw_edma_pcie_irq_vector,
 	.pci_address = dw_edma_pcie_address,
 };
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..44e90b71d429 100644
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

