Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D46AF6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCGUcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCGUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:32:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B6AA7AA8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:32:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2091061544
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE08C433EF;
        Tue,  7 Mar 2023 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678221167;
        bh=dOTQs3qUPCCs/2oObN0aBuTrcl21WTjanP9C3iDpiNw=;
        h=From:To:Cc:Subject:Date:From;
        b=b8gZp7QE+PyHxvTNOOtZ1stvmH6lZipLHmGOjZrPqwF/uXGgLFFgFgQ8wpGlpVh11
         bBkDFG6dLwUebSLXJusVcnneeife93sgDFzR1Z1Mt+r7odTsJgh2y85e+/MqYML8ip
         yfRPLWc5BZI3bK6PSPcBdX1FhWRlTa4YTTxrGe4fwANjwaW6l4E48tCm3GldloB4qz
         2Z9IVQBh8KDfRN5f/0ezwX3rz6GI4qsai8czdb7FXQ62JDuJdI+UuAloxSqrqweiWA
         RUrMhAktDlwo2Nb/WJk0afDLRbUfOOtLCDRUHTg0KYat/ylfYDFjJoXoZOhb/jyy8W
         tndSFbtYtw/4g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] nvme-pci: drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 14:32:43 -0600
Message-Id: <20230307203243.882202-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
from the driver .remove() path.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b95c94ee40f..593f86323e25 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/aer.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -2535,7 +2534,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	nvme_map_cmb(dev);
 
-	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
 
 	result = nvme_pci_configure_admin_queue(dev);
@@ -2600,10 +2598,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(dev, 0);
 	pci_free_irq_vectors(pdev);
-	if (pci_is_enabled(pdev)) {
-		pci_disable_pcie_error_reporting(pdev);
+	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
-	}
 	nvme_reap_pending_cqes(dev);
 
 	nvme_cancel_tagset(&dev->ctrl);
-- 
2.25.1

