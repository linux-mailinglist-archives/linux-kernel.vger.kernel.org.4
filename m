Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48716C750D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCXBcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCXBce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:32:34 -0400
Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264340C0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:32:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679621550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W2nbe/qe97oAd0bkNVfAnRrtvuCJRlnabZEg2AKy4ms=;
        b=ihN99A1FVxcJ7h4amVIKFbjkcMh/XINOnSx09wZ80dEXEv//9JkdYcwVFzIvU2DTOVL2r1
        GtlBvV5dgMSzkx5XdoEPG+MC8dM6jY5qFi8n+Y+8x7/agsDr5qYYCK86BiYQbxnR9VAsSK
        kMUiRDLq9EE1QY3m3mcCiksOhyW4lf4=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ntb_hw_amd: Remove redundant pci_clear_master
Date:   Fri, 24 Mar 2023 09:32:18 +0800
Message-Id: <20230324013224.5963-1-cai.huoqing@linux.dev>
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
v1->v2: No change
v1 link:
	https://lore.kernel.org/lkml/20230323115336.12986-1-cai.huoqing@linux.dev/

 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 730f2103b91d..855ff65f64a5 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1194,7 +1194,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 	return 0;
 
 err_dma_mask:
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 err_pci_regions:
 	pci_disable_device(pdev);
@@ -1209,7 +1208,6 @@ static void amd_ntb_deinit_pci(struct amd_ntb_dev *ndev)
 
 	pci_iounmap(pdev, ndev->self_mmio);
 
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-- 
2.34.1

