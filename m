Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38256AF689
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjCGUQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCGUQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:16:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C054E5C1;
        Tue,  7 Mar 2023 12:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90129B81A13;
        Tue,  7 Mar 2023 20:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B3DC433EF;
        Tue,  7 Mar 2023 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220193;
        bh=FupbKwelwLHLV++gMmX5dmMnAyDReIjpfS4XTY/hr5U=;
        h=From:To:Cc:Subject:Date:From;
        b=U5ni1xNATlVfMAIzrN1+nBzrPIn62wUdqocGJ1nsTr7ZeDSxyO2wmoxAqgdgWOp6V
         e9WvLpw8HM1S003EyuAd8FNa4VEl9Ma+TXQgj+CZ3PkLVSgutM3hR6suMqqwpU+UgT
         RSgxob6o1RiF3LI0rRh9ElDFu6LREuN0hSuh3OKedhaZHEXFsQu/y4gsQRiFdW5TqX
         Grdl+1bW6ekgWha+9JKkcjV0vwo1BNEy5yjyY+DZrsBBJ0HenTW027ymdd58wbAapb
         AKndnJGh9hZyEyeoBzq3nSQsCeduwT0PVTiYfJV0zUVMgmXx9joctHTAwFN20TAgND
         0GqmMwk0jk5Ew==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] bus: mhi: host: pci_generic: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 14:16:25 -0600
Message-Id: <20230307201625.879567-1-helgaas@kernel.org>
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
 drivers/bus/mhi/host/pci_generic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index f39657f71483..6e13c43a84d1 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
  */
 
-#include <linux/aer.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mhi.h>
@@ -903,11 +902,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_pdev->pci_state = pci_store_saved_state(pdev);
 	pci_load_saved_state(pdev, NULL);
 
-	pci_enable_pcie_error_reporting(pdev);
-
 	err = mhi_register_controller(mhi_cntrl, mhi_cntrl_config);
 	if (err)
-		goto err_disable_reporting;
+		return err;
 
 	/* MHI bus does not power up the controller by default */
 	err = mhi_prepare_for_power_up(mhi_cntrl);
@@ -941,8 +938,6 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_unprepare_after_power_down(mhi_cntrl);
 err_unregister:
 	mhi_unregister_controller(mhi_cntrl);
-err_disable_reporting:
-	pci_disable_pcie_error_reporting(pdev);
 
 	return err;
 }
@@ -965,7 +960,6 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 		pm_runtime_get_noresume(&pdev->dev);
 
 	mhi_unregister_controller(mhi_cntrl);
-	pci_disable_pcie_error_reporting(pdev);
 }
 
 static void mhi_pci_shutdown(struct pci_dev *pdev)
-- 
2.25.1

