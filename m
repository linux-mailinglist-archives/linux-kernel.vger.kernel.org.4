Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E0D6AE640
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCGQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCGQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:20:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060C114E9E;
        Tue,  7 Mar 2023 08:20:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A69EFB818F9;
        Tue,  7 Mar 2023 16:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE2CC433EF;
        Tue,  7 Mar 2023 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678206033;
        bh=8OmisYPM396GTnn0qHx1504HwFcjgvFJo3Io7iVLMOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fM36JUgn5Etdhyi5d9yhB1i+nKo1nYhZ+rBHwBRa0Mfo8v396Z46Z0QsNy74YS4fT
         Soz5dIgU9vjO/2iO8wS8LhJHaREiGPUoWvoL8gpjbhXQWTSU8EB4r/uUMzplX1k1YW
         1nb34j76XLaMfx4USK4qL7EFpDls8/dD6FuXkr676yrD7XNRudFxuPMC/9l3Qs1cjT
         dcUxuwlsUY6ke9IkfK8XbiyeSK+9cfIjhPSfdc/Ht4OnctzpsCRYL9W3svZlg7f66N
         9pKp+lf+NBkth4w5h2IfZQtDFA/lFfI1m6yTnCTMWBJyDptvc9o5x3dp5689tuzjC+
         CbMHv0NeJupFA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        qat-linux@intel.com
Subject: [PATCH 1/6] crypto: qat - drop redundant adf_enable_aer()
Date:   Tue,  7 Mar 2023 10:19:42 -0600
Message-Id: <20230307161947.857491-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307161947.857491-1-helgaas@kernel.org>
References: <20230307161947.857491-1-helgaas@kernel.org>
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
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: qat-linux@intel.com
---
 drivers/crypto/qat/qat_4xxx/adf_drv.c         | 11 ++----
 drivers/crypto/qat/qat_c3xxx/adf_drv.c        |  9 ++---
 drivers/crypto/qat/qat_c62x/adf_drv.c         |  9 ++---
 drivers/crypto/qat/qat_common/adf_aer.c       | 35 -------------------
 .../crypto/qat/qat_common/adf_common_drv.h    |  2 --
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c     |  9 ++---
 6 files changed, 9 insertions(+), 66 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index b3a4c7b23864..025de43a572b 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -403,21 +403,19 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	adf_enable_aer(accel_dev);
-
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state.\n");
 		ret = -ENOMEM;
-		goto out_err_disable_aer;
+		goto out_err;
 	}
 
 	ret = adf_sysfs_init(accel_dev);
 	if (ret)
-		goto out_err_disable_aer;
+		goto out_err;
 
 	ret = hw_data->dev_config(accel_dev);
 	if (ret)
-		goto out_err_disable_aer;
+		goto out_err;
 
 	ret = adf_dev_init(accel_dev);
 	if (ret)
@@ -433,8 +431,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_dev_stop(accel_dev);
 out_err_dev_shutdown:
 	adf_dev_shutdown(accel_dev);
-out_err_disable_aer:
-	adf_disable_aer(accel_dev);
 out_err:
 	adf_cleanup_accel(accel_dev);
 	return ret;
@@ -450,7 +446,6 @@ static void adf_remove(struct pci_dev *pdev)
 	}
 	adf_dev_stop(accel_dev);
 	adf_dev_shutdown(accel_dev);
-	adf_disable_aer(accel_dev);
 	adf_cleanup_accel(accel_dev);
 }
 
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
index 1f4fbf4562b2..17a390718b10 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -193,17 +193,15 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 
-	adf_enable_aer(accel_dev);
-
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
 		ret = -ENOMEM;
-		goto out_err_disable_aer;
+		goto out_err_free_reg;
 	}
 
 	ret = hw_data->dev_config(accel_dev);
 	if (ret)
-		goto out_err_disable_aer;
+		goto out_err_free_reg;
 
 	ret = adf_dev_init(accel_dev);
 	if (ret)
@@ -219,8 +217,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_dev_stop(accel_dev);
 out_err_dev_shutdown:
 	adf_dev_shutdown(accel_dev);
-out_err_disable_aer:
-	adf_disable_aer(accel_dev);
 out_err_free_reg:
 	pci_release_regions(accel_pci_dev->pci_dev);
 out_err_disable:
@@ -241,7 +237,6 @@ static void adf_remove(struct pci_dev *pdev)
 	}
 	adf_dev_stop(accel_dev);
 	adf_dev_shutdown(accel_dev);
-	adf_disable_aer(accel_dev);
 	adf_cleanup_accel(accel_dev);
 	adf_cleanup_pci_dev(accel_dev);
 	kfree(accel_dev);
diff --git a/drivers/crypto/qat/qat_c62x/adf_drv.c b/drivers/crypto/qat/qat_c62x/adf_drv.c
index 4ccaf298250c..fd799044cdd7 100644
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -193,17 +193,15 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 
-	adf_enable_aer(accel_dev);
-
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
 		ret = -ENOMEM;
-		goto out_err_disable_aer;
+		goto out_err_free_reg;
 	}
 
 	ret = hw_data->dev_config(accel_dev);
 	if (ret)
-		goto out_err_disable_aer;
+		goto out_err_free_reg;
 
 	ret = adf_dev_init(accel_dev);
 	if (ret)
@@ -219,8 +217,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_dev_stop(accel_dev);
 out_err_dev_shutdown:
 	adf_dev_shutdown(accel_dev);
-out_err_disable_aer:
-	adf_disable_aer(accel_dev);
 out_err_free_reg:
 	pci_release_regions(accel_pci_dev->pci_dev);
 out_err_disable:
@@ -241,7 +237,6 @@ static void adf_remove(struct pci_dev *pdev)
 	}
 	adf_dev_stop(accel_dev);
 	adf_dev_shutdown(accel_dev);
-	adf_disable_aer(accel_dev);
 	adf_cleanup_accel(accel_dev);
 	adf_cleanup_pci_dev(accel_dev);
 	kfree(accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index fe9bb2f3536a..bb7289032088 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/aer.h>
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
@@ -173,40 +172,6 @@ const struct pci_error_handlers adf_err_handler = {
 };
 EXPORT_SYMBOL_GPL(adf_err_handler);
 
-/**
- * adf_enable_aer() - Enable Advance Error Reporting for acceleration device
- * @accel_dev:  Pointer to acceleration device.
- *
- * Function enables PCI Advance Error Reporting for the
- * QAT acceleration device accel_dev.
- * To be used by QAT device specific drivers.
- */
-void adf_enable_aer(struct adf_accel_dev *accel_dev)
-{
-	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
-
-	pci_enable_pcie_error_reporting(pdev);
-}
-EXPORT_SYMBOL_GPL(adf_enable_aer);
-
-/**
- * adf_disable_aer() - Disable Advance Error Reporting for acceleration device
- * @accel_dev:  Pointer to acceleration device.
- *
- * Function disables PCI Advance Error Reporting for the
- * QAT acceleration device accel_dev.
- * To be used by QAT device specific drivers.
- *
- * Return: void
- */
-void adf_disable_aer(struct adf_accel_dev *accel_dev)
-{
-	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
-
-	pci_disable_pcie_error_reporting(pdev);
-}
-EXPORT_SYMBOL_GPL(adf_disable_aer);
-
 int adf_init_aer(void)
 {
 	device_reset_wq = alloc_workqueue("qat_device_reset_wq",
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 7189265573c0..13f32c7b13fa 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -88,8 +88,6 @@ int adf_ae_start(struct adf_accel_dev *accel_dev);
 int adf_ae_stop(struct adf_accel_dev *accel_dev);
 
 extern const struct pci_error_handlers adf_err_handler;
-void adf_enable_aer(struct adf_accel_dev *accel_dev);
-void adf_disable_aer(struct adf_accel_dev *accel_dev);
 void adf_reset_sbr(struct adf_accel_dev *accel_dev);
 void adf_reset_flr(struct adf_accel_dev *accel_dev);
 void adf_dev_restore(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
index ebeb17b67fcd..feb6e000cc6d 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -193,17 +193,15 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 
-	adf_enable_aer(accel_dev);
-
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
 		ret = -ENOMEM;
-		goto out_err_disable_aer;
+		goto out_err_free_reg;
 	}
 
 	ret = hw_data->dev_config(accel_dev);
 	if (ret)
-		goto out_err_disable_aer;
+		goto out_err_free_reg;
 
 	ret = adf_dev_init(accel_dev);
 	if (ret)
@@ -219,8 +217,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_dev_stop(accel_dev);
 out_err_dev_shutdown:
 	adf_dev_shutdown(accel_dev);
-out_err_disable_aer:
-	adf_disable_aer(accel_dev);
 out_err_free_reg:
 	pci_release_regions(accel_pci_dev->pci_dev);
 out_err_disable:
@@ -241,7 +237,6 @@ static void adf_remove(struct pci_dev *pdev)
 	}
 	adf_dev_stop(accel_dev);
 	adf_dev_shutdown(accel_dev);
-	adf_disable_aer(accel_dev);
 	adf_cleanup_accel(accel_dev);
 	adf_cleanup_pci_dev(accel_dev);
 	kfree(accel_dev);
-- 
2.25.1

