Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C5620053
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiKGVGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiKGVFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:05:17 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 227C62CE02;
        Mon,  7 Nov 2022 13:05:00 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8EA2AE0EDE;
        Tue,  8 Nov 2022 00:05:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=fKQS+owvIEj7LQdoOrNgOexhbokWX7U43vRl+NtD+dI=; b=fDIFM8MVe2dm
        QiXGxub0NJDWErmPJhddOpgQTYa9cXN+Oezr/G1hXW71Sb9zY+bXh2NdnSkH5LmQ
        E5uuAkUlsuHqqwTH3Y+AlaZO9onJBCn+/ze3vLeN1ySt0nYNTGJ5qZsyR4AyRnvV
        CoMyjffdZTEzcMdMVgCJR+pHp2TSwHc=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7F39BE0ED3;
        Tue,  8 Nov 2022 00:05:00 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Nov 2022 00:05:00 +0300
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
        caihuoqing <caihuoqing@baidu.com>, <linux-pci@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 20/24] dmaengine: dw-edma: Drop DT-region allocation
Date:   Tue, 8 Nov 2022 00:04:34 +0300
Message-ID: <20221107210438.1515-21-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in allocating an additional memory for the data target
regions passed then to the client drivers. Just use the already available
structures defined in the dw_edma_chip instance.

Note these regions are unused in normal circumstances since they are
specific to the case of eDMA being embedded into the DW PCIe End-point and
having it's CSRs accessible over a End-point' BAR. This case is only known
to be implemented as a part of the Synopsys PCIe EndPoint IP prototype
kit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 58808bec4148..040a88cfe070 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -738,7 +738,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
-	struct dw_edma_region *dt_region;
 	struct device *dev = chip->dev;
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
@@ -754,12 +753,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	for (i = 0; i < ch_cnt; i++) {
 		chan = &dw->chan[i];
 
-		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
-		if (!dt_region)
-			return -ENOMEM;
-
-		chan->vc.chan.private = dt_region;
-
 		chan->dw = dw;
 
 		if (i < dw->wr_ch_cnt) {
@@ -807,17 +800,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 			 chan->msi.data);
 
 		chan->vc.desc_free = vchan_free_desc;
-		vchan_init(&chan->vc, dma);
+		chan->vc.chan.private = chan->dir == EDMA_DIR_WRITE ?
+					&dw->chip->dt_region_wr[chan->id] :
+					&dw->chip->dt_region_rd[chan->id];
 
-		if (chan->dir == EDMA_DIR_WRITE) {
-			dt_region->paddr = chip->dt_region_wr[chan->id].paddr;
-			dt_region->vaddr = chip->dt_region_wr[chan->id].vaddr;
-			dt_region->sz = chip->dt_region_wr[chan->id].sz;
-		} else {
-			dt_region->paddr = chip->dt_region_rd[chan->id].paddr;
-			dt_region->vaddr = chip->dt_region_rd[chan->id].vaddr;
-			dt_region->sz = chip->dt_region_rd[chan->id].sz;
-		}
+		vchan_init(&chan->vc, dma);
 
 		dw_edma_v0_core_device_config(chan);
 	}
-- 
2.38.0


