Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627DC6AF115
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjCGSjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjCGSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:38:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732B301A6;
        Tue,  7 Mar 2023 10:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B37E6150E;
        Tue,  7 Mar 2023 18:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A696CC433EF;
        Tue,  7 Mar 2023 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213747;
        bh=zEI877upDLwimMSOZL/AiD7txmrPJ/Mr1O8OUkLbrS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOCIwPdVFuAn51LZbQFX+j+ni6gswOsPKQjmceJyKeogZo1kAP+xjM3o9TQCmbiUS
         9fFhxJcelhr0gwqsMl7LAE/DGgxXRa1HS7mD/SKQ6blu8BwNQat6hwux/YxwMMflDv
         xFl4EQ0TD7ODRGIHo0W7UfCIXyIKhzIaWe2O51m06Jst5ZdKe45dgsgSn7nSVdFRY7
         7gJCytW5wXD3mODPuZFjA/7IZdCZq4BMwoYcexhvVdjceBODy7OaOiNdgcQTix8wGJ
         4SD0IqF74jAApjkM8fNK9FOm7f2ESh9IA/jtfg6TiFontpnELTK9KKJR4ZQbEvLJul
         B5uErx3JPanqQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH 09/10] scsi: qla2xxx: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 12:28:41 -0600
Message-Id: <20230307182842.870378-10-helgaas@kernel.org>
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
Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
---
 drivers/scsi/qla2xxx/qla_def.h | 1 -
 drivers/scsi/qla2xxx/qla_os.c  | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index ec0e987b71fa..df5e5b7fdcfe 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/firmware.h>
-#include <linux/aer.h>
 #include <linux/mutex.h>
 #include <linux/btree.h>
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 545167627e48..a6c5e0d8641d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2940,9 +2940,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ql2xallocfwdump = 0;
 	}
 
-	/* This may fail but that's ok */
-	pci_enable_pcie_error_reporting(pdev);
-
 	ha = kzalloc(sizeof(struct qla_hw_data), GFP_KERNEL);
 	if (!ha) {
 		ql_log_pci(ql_log_fatal, pdev, 0x0009,
@@ -3949,8 +3946,6 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	pci_release_selected_regions(ha->pdev, ha->bars);
 	kfree(ha);
 
-	pci_disable_pcie_error_reporting(pdev);
-
 	pci_disable_device(pdev);
 }
 
@@ -6825,7 +6820,6 @@ qla2x00_disable_board_on_pci_error(struct work_struct *work)
 	qla2x00_unmap_iobases(ha);
 
 	pci_release_selected_regions(ha->pdev, ha->bars);
-	pci_disable_pcie_error_reporting(pdev);
 	pci_disable_device(pdev);
 
 	/*
-- 
2.25.1

