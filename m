Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764636C672A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjCWLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCWLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:53:59 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D9134C10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:53:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679572431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4FY3EEAjGMGaZUzTwyD8wRiA7SbipJR+ORYUAZzQpA=;
        b=jm990LnVNAP4u+eLYixqUc+RFWiz/m/delvGMV7SYM09mn+kQAKNx9ZKhmPrfr4eHOq/kM
        9TJyan3qKtRl5UP7+ESwgKwbnYRdGrlCTB+i07snUggXzSAh6qnV2dKC/tDhRuBJv/vcMG
        4dVZRDnB3FHV3edpYV2OJnKIaCHXHpQ=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ntb: intel: Remove redundant pci_clear_master
Date:   Thu, 23 Mar 2023 19:53:35 +0800
Message-Id: <20230323115336.12986-3-cai.huoqing@linux.dev>
In-Reply-To: <20230323115336.12986-1-cai.huoqing@linux.dev>
References: <20230323115336.12986-1-cai.huoqing@linux.dev>
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
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 60a4ebc7bf35..9ab836d0d4f1 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -1791,7 +1791,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 
 err_mmio:
 err_dma_mask:
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 err_pci_regions:
 	pci_disable_device(pdev);
@@ -1808,7 +1807,6 @@ static void intel_ntb_deinit_pci(struct intel_ntb_dev *ndev)
 		pci_iounmap(pdev, ndev->peer_mmio);
 	pci_iounmap(pdev, ndev->self_mmio);
 
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-- 
2.34.1

