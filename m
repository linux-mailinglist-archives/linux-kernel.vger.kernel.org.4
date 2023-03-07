Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D76AF2CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjCGS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjCGS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:56:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EA69749E;
        Tue,  7 Mar 2023 10:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6799CE1C79;
        Tue,  7 Mar 2023 18:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F30C433D2;
        Tue,  7 Mar 2023 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213736;
        bh=3JdjywG6DsWfWzdvnLIaNQak/6ZVrelHGxK1Jb+bRtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvRTfYfCSLh/IziCDBzjHgXEvc0lyIja1XSjGQKUO6wnvdwH8JANNu7u651awRvem
         hX5/li75IpG+veKKl+988VGOcqNgjqGj2szYqfWShD4a60S0cOc5bMXjQXXB2AmBGA
         l83ZS7yFYNEUhHdcG3ElFzNtSZ6Brkz2aypJJlzaEliKmpXpNL3468i81xyqPf/YzM
         Frtn4G9z1RuT4gS95ggjuZd7qysoazZFtCzU0onGYJDUASzG0LV9OjaJ0e6wp7Bwgb
         +C/VVR/nFuAKNdQt1u/4ycjYeu2cL2OZTqGBKuAHNqluODtPXf6hVfQXMdjXt6+oMv
         7CUHbBrFoQL7Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>
Subject: [PATCH 03/10] scsi: be2iscsi: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 12:28:35 -0600
Message-Id: <20230307182842.870378-4-helgaas@kernel.org>
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
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
---
 drivers/scsi/be2iscsi/be_main.c | 9 ---------
 drivers/scsi/be2iscsi/be_main.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 50a577ac3bb4..0aaf6fc47683 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -5545,13 +5545,6 @@ static int beiscsi_dev_probe(struct pci_dev *pcidev,
 		goto disable_pci;
 	}
 
-	/* Enable EEH reporting */
-	ret = pci_enable_pcie_error_reporting(pcidev);
-	if (ret)
-		beiscsi_log(phba, KERN_WARNING, BEISCSI_LOG_INIT,
-			    "BM_%d : PCIe Error Reporting "
-			    "Enabling Failed\n");
-
 	pci_save_state(pcidev);
 
 	/* Initialize Driver configuration Paramters */
@@ -5736,7 +5729,6 @@ static int beiscsi_dev_probe(struct pci_dev *pcidev,
 	pci_disable_msix(phba->pcidev);
 	pci_dev_put(phba->pcidev);
 	iscsi_host_free(phba->shost);
-	pci_disable_pcie_error_reporting(pcidev);
 	pci_set_drvdata(pcidev, NULL);
 disable_pci:
 	pci_release_regions(pcidev);
@@ -5779,7 +5771,6 @@ static void beiscsi_remove(struct pci_dev *pcidev)
 
 	pci_dev_put(phba->pcidev);
 	iscsi_host_free(phba->shost);
-	pci_disable_pcie_error_reporting(pcidev);
 	pci_set_drvdata(pcidev, NULL);
 	pci_release_regions(pcidev);
 	pci_disable_device(pcidev);
diff --git a/drivers/scsi/be2iscsi/be_main.h b/drivers/scsi/be2iscsi/be_main.h
index 98977c0700f1..71c95d144560 100644
--- a/drivers/scsi/be2iscsi/be_main.h
+++ b/drivers/scsi/be2iscsi/be_main.h
@@ -16,7 +16,6 @@
 #include <linux/in.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
-#include <linux/aer.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
-- 
2.25.1

