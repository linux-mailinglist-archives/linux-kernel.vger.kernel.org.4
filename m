Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE956AF2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjCGSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjCGSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:54:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D01A5F6;
        Tue,  7 Mar 2023 10:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9371561538;
        Tue,  7 Mar 2023 18:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC636C4339E;
        Tue,  7 Mar 2023 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213746;
        bh=3BwaxeqR5K9UM6t70G9A7Zg8LXyh/lE1LnqW0l4i6Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBDFXwGmb4NbFsnOLQNVjKfCxYBZQe6gNNlsx3x0rX+hVweeeTXZ9n6hO3ziosB6x
         WU0LRWK1gsud8ozmdXQVhaBQkzv5y6PwpV6rYIqxIU67i7XF2MAtI1v8CxbYHhOmh5
         C2umXRpwPBPBw1hSxq2Q/Z/SB64Hkq4HpHnVsEmHpPPxn0pBRlCEI9GQ+qke617Epq
         Y+IpQ4mEHCEcdVsUjeLIGyYTAmmQalsQyGpejG5L22UcUdGDUJokGMhTC/s48i8ckt
         nRccsUU1YJ8NJn+8Y51wKPN23u+xDU4mdtFb6FEUoepcrTHyx0BWAkKd+Bk5wbROKT
         3p+pYSz9Q3OLA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH 08/10] scsi: mpt3sas: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 12:28:40 -0600
Message-Id: <20230307182842.870378-9-helgaas@kernel.org>
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
Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  | 5 -----
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2ee9ea57554d..a8b260f46796 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -60,7 +60,6 @@
 #include <linux/ktime.h>
 #include <linux/kthread.h>
 #include <asm/page.h>        /* To get host page size per arch */
-#include <linux/aer.h>
 
 
 #include "mpt3sas_base.h"
@@ -3535,7 +3534,6 @@ mpt3sas_base_unmap_resources(struct MPT3SAS_ADAPTER *ioc)
 
 	if (pci_is_enabled(pdev)) {
 		pci_release_selected_regions(ioc->pdev, ioc->bars);
-		pci_disable_pcie_error_reporting(pdev);
 		pci_disable_device(pdev);
 	}
 }
@@ -3615,9 +3613,6 @@ mpt3sas_base_map_resources(struct MPT3SAS_ADAPTER *ioc)
 		goto out_fail;
 	}
 
-/* AER (Advanced Error Reporting) hooks */
-	pci_enable_pcie_error_reporting(pdev);
-
 	pci_set_master(pdev);
 
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 8e24ebcebfe5..e2f09833659f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -52,7 +52,6 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <linux/aer.h>
 #include <linux/raid_class.h>
 #include <linux/blk-mq-pci.h>
 #include <asm/unaligned.h>
-- 
2.25.1

