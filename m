Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA56AF161
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjCGSmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCGSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:41:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4EC9E30E;
        Tue,  7 Mar 2023 10:32:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 726B1CE1C85;
        Tue,  7 Mar 2023 18:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C80C433AE;
        Tue,  7 Mar 2023 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213738;
        bh=sxhOUKyK/NsC1MzrNzYBeE7kuwoED0rqhP9R9JiXQ3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8HGFNMk4sJ7JvkVF9YJaqueJncGoydFlLJnNwSGxSxKXyYHv0fBeoPg3MUFQDLBa
         tPTfvdqfiyqOpnhWUEO2+AkaAbb5Chn8COeK6LZJrB++fwGRv+uI2HsOEQ9zquY19J
         KR1BYAzcUGIGArw5s6U7u6UIhUMnOwrq865wfsvERv1wiHGDaIDW5W77rPLxmlU1Nn
         +KlC8gboOR8gPABhqyHOsH/zh5K/duy25zCpG+cwCZCfU4DSZx68sYszBiZtf0VbpB
         RWVr5X2Y6IK7Y03amLzW6gewbFAq78Fe9ZhraC2i9gNkKAkg3wy4w4VnWE7UnDD+1g
         eAkS3AEfSP80A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 04/10] scsi: bfa: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 12:28:36 -0600
Message-Id: <20230307182842.870378-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307182842.870378-1-helgaas@kernel.org>
References: <20230307182842.870378-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
---
 drivers/scsi/bfa/bfad.c     | 6 ------
 drivers/scsi/bfa/bfad_drv.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index e5aa982ffedc..529b73a83d69 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -738,9 +738,6 @@ bfad_pci_init(struct pci_dev *pdev, struct bfad_s *bfad)
 		goto out_release_region;
 	}
 
-	/* Enable PCIE Advanced Error Recovery (AER) if kernel supports */
-	pci_enable_pcie_error_reporting(pdev);
-
 	bfad->pci_bar0_kva = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
 	bfad->pci_bar2_kva = pci_iomap(pdev, 2, pci_resource_len(pdev, 2));
 
@@ -801,8 +798,6 @@ bfad_pci_uninit(struct pci_dev *pdev, struct bfad_s *bfad)
 	pci_iounmap(pdev, bfad->pci_bar0_kva);
 	pci_iounmap(pdev, bfad->pci_bar2_kva);
 	pci_release_regions(pdev);
-	/* Disable PCIE Advanced Error Recovery (AER) */
-	pci_disable_pcie_error_reporting(pdev);
 	pci_disable_device(pdev);
 }
 
@@ -1562,7 +1557,6 @@ bfad_pci_slot_reset(struct pci_dev *pdev)
 	if (restart_bfa(bfad) == -1)
 		goto out_disable_device;
 
-	pci_enable_pcie_error_reporting(pdev);
 	dev_printk(KERN_WARNING, &pdev->dev,
 		   "slot_reset completed  flags: 0x%x!\n", bfad->bfad_flags);
 
diff --git a/drivers/scsi/bfa/bfad_drv.h b/drivers/scsi/bfa/bfad_drv.h
index eaee7c8bc2d2..7682cfa34265 100644
--- a/drivers/scsi/bfa/bfad_drv.h
+++ b/drivers/scsi/bfa/bfad_drv.h
@@ -30,7 +30,6 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/bitops.h>
-#include <linux/aer.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
-- 
2.25.1

