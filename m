Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6164D40C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLNXzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLNXx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:53:26 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED0B7511DA;
        Wed, 14 Dec 2022 15:53:23 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8CB20E0ED6;
        Thu, 15 Dec 2022 02:53:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=i5i9TkCG3hGnq3CWiMkD0V+zfJ+jV4ugBGTrN/78M2c=; b=BuAWY4u1RPVB
        7nSoH8ol1L8Xnej4R4cJlcLIzFkYPyjnRae98gGXy3uVtf9YRstt7VaP5Ay7PdGk
        /wJT4lI+p5LHqbWndGJeFe2dK+SUwoq+hMrSlv+VQX4bpmesLTel3Rol/bATv/4K
        K7pg0oo8G958oxfId7szjX0cONCruK0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8073AE0E6B;
        Thu, 15 Dec 2022 02:53:23 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 15 Dec 2022 02:53:23 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 21/25] dmaengine: dw-edma: Replace chip ID number with device name
Date:   Thu, 15 Dec 2022 02:53:01 +0300
Message-ID: <20221214235305.31744-22-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using some abstract number as the DW eDMA chip identifier isn't really
practical. First of all there can be more than one DW eDMA controller on
the platform some of them can be detected as the PCIe end-points, some of
them can be embedded into the DW PCIe Root Port/End-point controllers.
Seeing some abstract number in for instance IRQ handlers list doesn't give
a notion regarding their reference to the particular DMA controller.
Secondly current DW eDMA chip id implementation doesn't provide the
multi-eDMA platforms support for same reason of possibly having eDMA
detected on different system buses. At the same time re-implementing
something ida-based won't give much benefits especially seeing the DW eDMA
chip ID is only used in the IRQ request procedure. So to speak in order to
preserve the code simplicity and get to have the multi-eDMA platforms
support let's just use the parental device name to create the DW eDMA
controller name.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>

---

Changelog v2:
- Slightly extend the eDMA name array. (@Manivannan)
---
 drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
 drivers/dma/dw-edma/dw-edma-core.h | 2 +-
 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 1 -
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 040a88cfe070..e3671bfbe186 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -973,7 +973,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dw->chan)
 		return -ENOMEM;
 
-	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
+	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
+		 dev_name(chip->dev));
 
 	/* Disable eDMA, only to establish the ideal initial conditions */
 	dw_edma_v0_core_off(dw);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e3ad3e372b55..0ab2b6dba880 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -96,7 +96,7 @@ struct dw_edma_irq {
 };
 
 struct dw_edma {
-	char				name[20];
+	char				name[32];
 
 	struct dma_device		dma;
 
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index f530bacfd716..3f9dadc73854 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -222,7 +222,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	/* Data structure initialization */
 	chip->dev = dev;
-	chip->id = pdev->devfn;
 
 	chip->mf = vsec_data.mf;
 	chip->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 380a0a3e251f..9d44da4aa59d 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -76,7 +76,6 @@ enum dw_edma_chip_flags {
  */
 struct dw_edma_chip {
 	struct device		*dev;
-	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 	u32			flags;
-- 
2.38.1


