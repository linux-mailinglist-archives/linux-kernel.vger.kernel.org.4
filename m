Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339BA6AF6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCGU1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCGU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0E23661
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:27:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EBBDB81A1D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E4BC433A4;
        Tue,  7 Mar 2023 20:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220852;
        bh=vizWD6a5JSdbywtnVxbUOoJJmX8KvhVFdJlgxGmYpX4=;
        h=From:To:Cc:Subject:Date:From;
        b=UhoOPB1btWUDvIf/P8/unvroVvfLmOxbBItIjVp6BKzNZrh4xNvaYT7/aTyfbg+Sm
         /AR6PmyJM+qkC16itywHChLEEuU9pdPG8dkON2fl/ZUBX3T9NG+ogFHTvre/RINMs7
         txWejxi/6r46rn2Am4N7PlJbGCRcz809+oQ8BhNgLKc/ADnap/X6IO6rLOPE+oRe6x
         6npRvmWzNLjvqN73XzIF7iPZA7qGi7eIArBGoJpKXpkrCVfGvWaKoAun9OF9E5HxCz
         H3VG8ddO6f/9xtXSSccmU63hNk+L78JnORk/XuG9ZwvYl2SkmLYOzc6pucFVI6u1hj
         BT6G42gOkZBsA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] habanalabs: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 14:27:29 -0600
Message-Id: <20230307202729.881391-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
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
---
 drivers/accel/habanalabs/common/habanalabs_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 03dae57dc838..26f65aa21079 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -12,7 +12,6 @@
 #include "../include/hw_ip/pci/pci_general.h"
 
 #include <linux/pci.h>
-#include <linux/aer.h>
 #include <linux/module.h>
 
 #define CREATE_TRACE_POINTS
@@ -550,8 +549,6 @@ static int hl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_drvdata(pdev, hdev);
 
-	pci_enable_pcie_error_reporting(pdev);
-
 	rc = hl_device_init(hdev, hl_class);
 	if (rc) {
 		dev_err(&pdev->dev, "Fatal error during habanalabs device init\n");
@@ -562,7 +559,6 @@ static int hl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 disable_device:
-	pci_disable_pcie_error_reporting(pdev);
 	pci_set_drvdata(pdev, NULL);
 	destroy_hdev(hdev);
 
@@ -585,7 +581,6 @@ static void hl_pci_remove(struct pci_dev *pdev)
 		return;
 
 	hl_device_fini(hdev);
-	pci_disable_pcie_error_reporting(pdev);
 	pci_set_drvdata(pdev, NULL);
 	destroy_hdev(hdev);
 }
-- 
2.25.1

