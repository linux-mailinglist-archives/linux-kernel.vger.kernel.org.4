Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147086C7510
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCXBcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCXBck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:32:40 -0400
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6796C2B60B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:32:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679621557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrieUzsMuRHYXa8v1AQdzJWDE6SJhykPzWCWACiwQL8=;
        b=gSX0c39MYWvxeObx2gcyVm4rNyqxjY2FDJcQzPbUsmjLAH0+FwWuhfYLCESL1v6J99OA1G
        wdtLiwdQeyOHlvmfX75a9RkPwzrBm2vnvPBTHtEzDxiL/QfqwZ0ky2AF9aFFKeftLkMMYL
        eMNJ9p3Vf0kLvPeiaCXwb0M9+ujlyEs=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ntb: epf: Remove redundant pci_clear_master
Date:   Fri, 24 Mar 2023 09:32:19 +0800
Message-Id: <20230324013224.5963-2-cai.huoqing@linux.dev>
In-Reply-To: <20230324013224.5963-1-cai.huoqing@linux.dev>
References: <20230324013224.5963-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pci_clear_master to simplify the code,
the bus-mastering is also cleared in do_pci_disable_device,
like this:
./drivers/pci/pci.c:2197
static void do_pci_disable_device(struct pci_dev *dev)
{
	u16 pci_command;

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &= ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

	pcibios_disable_device(dev);
}.
And dev->is_busmaster is set to 0 in pci_disable_device.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v1->v2: Fix the removed label-err_dma_mask

v1 link:
	https://lore.kernel.org/lkml/20230323115336.12986-2-cai.huoqing@linux.dev/

 drivers/ntb/hw/epf/ntb_hw_epf.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 3ece49cb18ff..b640aa0bf45e 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -591,7 +591,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dev_err(dev, "Cannot set DMA mask\n");
-			goto err_dma_mask;
+			goto err_pci_regions;
 		}
 		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
@@ -599,14 +599,14 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
 	if (!ndev->ctrl_reg) {
 		ret = -EIO;
-		goto err_dma_mask;
+		goto err_pci_regions;
 	}
 
 	if (ndev->peer_spad_reg_bar) {
 		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
 		if (!ndev->peer_spad_reg) {
 			ret = -EIO;
-			goto err_dma_mask;
+			goto err_pci_regions;
 		}
 	} else {
 		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
@@ -617,14 +617,11 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
 	if (!ndev->db_reg) {
 		ret = -EIO;
-		goto err_dma_mask;
+		goto err_pci_regions;
 	}
 
 	return 0;
 
-err_dma_mask:
-	pci_clear_master(pdev);
-
 err_pci_regions:
 	pci_disable_device(pdev);
 
@@ -642,7 +639,6 @@ static void ntb_epf_deinit_pci(struct ntb_epf_dev *ndev)
 	pci_iounmap(pdev, ndev->peer_spad_reg);
 	pci_iounmap(pdev, ndev->db_reg);
 
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-- 
2.34.1

