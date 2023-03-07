Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ECF6AF111
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjCGSi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjCGSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:38:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355EDA226B;
        Tue,  7 Mar 2023 10:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4138B819C2;
        Tue,  7 Mar 2023 18:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE31C4339C;
        Tue,  7 Mar 2023 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213749;
        bh=5BE9wZCtaDseXu0/Lv+W7WCLDoimdI41Hg2fMs8HhDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+QWpy5vzZ9/X3juu/fwf9cVoeaZqgxgUo3SAVMRWvYy2BXQA8ukuCt/CITD93mzl
         rGRACDKas4jH63jQpx2P3iqRMboehcUDh3Dp1QeWzku9yTa1e4b76VexBRJbSdAbpY
         z4cNtBYASorZ35SwDq3RcXProMs8qZ7s+7IaspemytoPzgI7nns8XNTadaAqLKIfpI
         vPYYUsTOL+GU5aafA3VhoMLb2HZu5lFUYUIjJtyF3Wy3WlBkLrCgjHnhvRQIEMicyy
         A1SFf2YukrqvJKeyoGfCOY35fhyAZtTe28Ww2t0Mf44DTtQXOy5J769iniV3zK8CPP
         qc0J5lpcBPI5g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH 10/10] scsi: qla4xxx: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 12:28:42 -0600
Message-Id: <20230307182842.870378-11-helgaas@kernel.org>
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
Cc: Manish Rangankar <mrangankar@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
---
 drivers/scsi/qla4xxx/ql4_def.h | 1 -
 drivers/scsi/qla4xxx/ql4_os.c  | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_def.h b/drivers/scsi/qla4xxx/ql4_def.h
index 5f82c8afd5e0..5e683ba49fa5 100644
--- a/drivers/scsi/qla4xxx/ql4_def.h
+++ b/drivers/scsi/qla4xxx/ql4_def.h
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
-#include <linux/aer.h>
 #include <linux/bsg-lib.h>
 #include <linux/vmalloc.h>
 
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 005502125b27..ee6d784c095c 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -8639,8 +8639,6 @@ static int qla4xxx_probe_adapter(struct pci_dev *pdev,
 	ha->host_no = host->host_no;
 	ha->func_num = PCI_FUNC(ha->pdev->devfn);
 
-	pci_enable_pcie_error_reporting(pdev);
-
 	/* Setup Runtime configurable options */
 	if (is_qla8022(ha)) {
 		ha->isp_ops = &qla4_82xx_isp_ops;
@@ -8867,7 +8865,6 @@ static int qla4xxx_probe_adapter(struct pci_dev *pdev,
 	qla4xxx_free_adapter(ha);
 
 probe_failed_ioconfig:
-	pci_disable_pcie_error_reporting(pdev);
 	scsi_host_put(ha->host);
 
 probe_disable_device:
@@ -9022,7 +9019,6 @@ static void qla4xxx_remove_adapter(struct pci_dev *pdev)
 
 	scsi_host_put(ha->host);
 
-	pci_disable_pcie_error_reporting(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.25.1

