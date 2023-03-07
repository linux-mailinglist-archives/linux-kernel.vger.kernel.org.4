Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B776AF217
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjCGSuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjCGStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:49:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B069AA31;
        Tue,  7 Mar 2023 10:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA1B561535;
        Tue,  7 Mar 2023 18:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3604C4339C;
        Tue,  7 Mar 2023 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213733;
        bh=XS+PFEsEIiwF3n0OJvyDRAlYdXATlWQBybPUUa+WKYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+aAKQ8ciAPb9rvkw6XjR6NZIhXrGgsAd/Bs24BFlKdtLuQr3RB8e3V3c+wAKK3Oq
         5ffQKPaJUcIhsDJHW6ltC6X9g1ziyQk4R6qs5xn2Pog4UdMS+ffKYuUY3W8Vt9uC2H
         NrVjtkjyjPVtiSblulTvcNS1I5VwEH3yB2jAED0ifXjLE3R3n5J/Rkg8BuFQwb2aAg
         /wE4bj5113RXlH2Zqt3tOikBVnKj4T27Npp08zqcaLUPY1UJ+wwMZ/9cdNOnzD0dpP
         z5yhPQHtdmxDZcXKbTrN9/EKJbADK8ZjrjO20YIuDVswFVFAJWk/WyBtrGmawOG/a0
         GlygUW033hB9w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Raghava Aditya Renukunta <raghavaaditya.renukunta@pmcs.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 01/10] scsi: aacraid: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 12:28:33 -0600
Message-Id: <20230307182842.870378-2-helgaas@kernel.org>
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
driver.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Also remove pci_disable_pcie_error_reporting() from the .error_detected()
path, which was added by 5c63f7f710bd ("aacraid: Added EEH support") but
looks unnecessary.  Error reporting will be disabled by the device reset
and will be re-enabled by the pci_restore_state() in aac_pci_slot_reset().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: Raghava Aditya Renukunta <raghavaaditya.renukunta@pmcs.com>
Cc: Tomas Henzl <thenzl@redhat.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/aacraid/linit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 5ba5c18b77b4..43160bf4d6a8 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -26,7 +26,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
-#include <linux/aer.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -1783,7 +1782,6 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	aac_scan_host(aac);
 
-	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
 
 	return 0;
@@ -1949,7 +1947,6 @@ static pci_ers_result_t aac_pci_error_detected(struct pci_dev *pdev,
 		scsi_host_complete_all_commands(shost, DID_NO_CONNECT);
 		aac_release_resources(aac);
 
-		pci_disable_pcie_error_reporting(pdev);
 		aac_adapter_ioremap(aac, 0);
 
 		return PCI_ERS_RESULT_NEED_RESET;
-- 
2.25.1

