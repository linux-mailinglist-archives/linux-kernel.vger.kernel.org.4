Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F43734930
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjFRWsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFRWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:48:17 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56071BD
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 15:48:15 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3149F240028
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687128493; bh=wB4xfJwsOqxiO5M4BIDiST16DjuP1Z+4Ob8EgcCvync=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=rqC1/Zt4XQa83aEqZ3J+HJP2rND3fkxHVLi7PeWpsrSY05u2Q1sG/zyWkkjfceqak
         7z0J0s4fEPxFNTWAVgvcExj9QyuuCSeP7UgTP6SilO4iifAmbBBS8IHsGUpgAi2HqM
         6en2E5C/SBp0tK3m4YekILJzY9FiHOk/hoCKPrIOGmGyMoReVx+mMXmQ9YMbcNeyUM
         WvEI1+ScWK/PZ0M9kEPGLPyahoUtgoaVE0EJTopLr5T4Vh+1aoSaPmhBYpXLv+IgVF
         tAvNdbEVKQpFLvPfSrZJVZ3THSuSHzMLDN/Ggp1Od1s+TxRmTEI7DW96p/yRVXulPA
         PFsUGWpUVRGtg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qkp2d4Pg1z9rxK;
        Mon, 19 Jun 2023 00:48:09 +0200 (CEST)
From:   Anne Macedo <retpolanne@posteo.net>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        retpolanne@posteo.net
Subject: [PATCH] usb: host: xhci: parameterize Renesas delay/retry
Date:   Sun, 18 Jun 2023 22:46:57 +0000
Message-ID: <20230618224656.2476-2-retpolanne@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cards based on Renesas uPD720202 have their firmware downloaded during
boot by xhci-pci. At this step, the status of the firmware is read and
it takes a while for this read to happen (up to a few seconds). The
macros RENESAS_RETRY and RENESAS_DELAY are used to retry reading this
status byte from PCI a few times. If it can't read the status byte in
RENESAS_RETRY tries, it times out.

However, since this may vary from card to card, these retry and delay
values need to be tweaked. In order to avoid having to patch the code to
change these values, CONFIG_USB_XHCI_PCI_RENESAS_RETRY and
CONFIG_USB_XHCI_PCI_RENESAS_DELAY are introduced.

If applied, this patch helps to fix errors such as:

ROM Download Step 34 failed at position 136 bytes
Firmware Download Step 2 failed at position 8 bytes with (-110)

while loading xhci-pci when using these cards.

This error in particular has been noticed by this e-mail [1].

[1] https://lore.kernel.org/lkml/20190626070658.GP2962@vkoul-mobl/

Signed-off-by: Anne Macedo <retpolanne@posteo.net>
---
 drivers/usb/host/Kconfig            | 10 +++++++
 drivers/usb/host/xhci-pci-renesas.c | 45 ++++++++++++++---------------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c170672f847e..8a255e3b0f03 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -51,6 +51,16 @@ config USB_XHCI_PCI_RENESAS
 	  installed on your system for this device to work.
 	  If unsure, say 'N'.
 
+config USB_XHCI_PCI_RENESAS_DELAY
+	int "Renesas firmware download delay for setting DATAX"
+	depends on USB_XHCI_PCI_RENESAS
+	default 10
+
+config USB_XHCI_PCI_RENESAS_RETRY
+	int "Renesas firmware download number of retries for setting DATAX"
+	depends on USB_XHCI_PCI_RENESAS
+	default 1000
+
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
 	help
diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 93f8b355bc70..009f5878fe6f 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -47,9 +47,6 @@
 #define RENESAS_ROM_ERASE_MAGIC				0x5A65726F
 #define RENESAS_ROM_WRITE_MAGIC				0x53524F4D
 
-#define RENESAS_RETRY	10000
-#define RENESAS_DELAY	10
-
 static int renesas_fw_download_image(struct pci_dev *dev,
 				     const u32 *fw, size_t step, bool rom)
 {
@@ -73,7 +70,7 @@ static int renesas_fw_download_image(struct pci_dev *dev,
 	data0_or_data1 = (step & 1) == 1;
 
 	/* step+1. Read "Set DATAX" and confirm it is cleared. */
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < CONFIG_USB_XHCI_PCI_RENESAS_RETRY; i++) {
 		err = pci_read_config_byte(dev, status_reg, &fw_status);
 		if (err) {
 			dev_err(&dev->dev, "Read Status failed: %d\n",
@@ -83,9 +80,9 @@ static int renesas_fw_download_image(struct pci_dev *dev,
 		if (!(fw_status & BIT(data0_or_data1)))
 			break;
 
-		udelay(RENESAS_DELAY);
+		udelay(CONFIG_USB_XHCI_PCI_RENESAS_DELAY);
 	}
-	if (i == RENESAS_RETRY) {
+	if (i == CONFIG_USB_XHCI_PCI_RENESAS_RETRY) {
 		dev_err(&dev->dev, "Timeout for Set DATAX step: %zd\n", step);
 		return -ETIMEDOUT;
 	}
@@ -321,7 +318,7 @@ static int renesas_fw_download(struct pci_dev *pdev,
 	 * "DATA0" or "DATA1". Naturally, we wait until "SET DATA0/1"
 	 * is cleared by the hardware beforehand.
 	 */
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < CONFIG_USB_XHCI_PCI_RENESAS_RETRY; i++) {
 		err = pci_read_config_byte(pdev, RENESAS_FW_STATUS_MSB,
 					   &fw_status);
 		if (err)
@@ -329,9 +326,9 @@ static int renesas_fw_download(struct pci_dev *pdev,
 		if (!(fw_status & (BIT(0) | BIT(1))))
 			break;
 
-		udelay(RENESAS_DELAY);
+		udelay(CONFIG_USB_XHCI_PCI_RENESAS_DELAY);
 	}
-	if (i == RENESAS_RETRY)
+	if (i == CONFIG_USB_XHCI_PCI_RENESAS_RETRY)
 		dev_warn(&pdev->dev, "Final Firmware Download step timed out.");
 
 	/*
@@ -343,16 +340,16 @@ static int renesas_fw_download(struct pci_dev *pdev,
 		return pcibios_err_to_errno(err);
 
 	/* 12. Read "Result Code" and confirm it is good. */
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < CONFIG_USB_XHCI_PCI_RENESAS_RETRY; i++) {
 		err = pci_read_config_byte(pdev, RENESAS_FW_STATUS, &fw_status);
 		if (err)
 			return pcibios_err_to_errno(err);
 		if (fw_status & RENESAS_FW_STATUS_SUCCESS)
 			break;
 
-		udelay(RENESAS_DELAY);
+		udelay(CONFIG_USB_XHCI_PCI_RENESAS_DELAY);
 	}
-	if (i == RENESAS_RETRY) {
+	if (i == CONFIG_USB_XHCI_PCI_RENESAS_RETRY) {
 		/* Timed out / Error - let's see if we can fix this */
 		err = renesas_fw_check_running(pdev);
 		switch (err) {
@@ -405,17 +402,17 @@ static void renesas_rom_erase(struct pci_dev *pdev)
 	/* sleep a bit while ROM is erased */
 	msleep(20);
 
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < CONFIG_USB_XHCI_PCI_RENESAS_RETRY; i++) {
 		retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS,
 					      &status);
 		status &= RENESAS_ROM_STATUS_ERASE;
 		if (!status)
 			break;
 
-		mdelay(RENESAS_DELAY);
+		mdelay(CONFIG_USB_XHCI_PCI_RENESAS_DELAY);
 	}
 
-	if (i == RENESAS_RETRY)
+	if (i == CONFIG_USB_XHCI_PCI_RENESAS_RETRY)
 		dev_dbg(&pdev->dev, "Chip erase timedout: %x\n", status);
 
 	dev_dbg(&pdev->dev, "ROM Erase... Done success\n");
@@ -464,7 +461,7 @@ static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
 	/*
 	 * wait till DATA0/1 is cleared
 	 */
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < CONFIG_USB_XHCI_PCI_RENESAS_RETRY; i++) {
 		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS_MSB,
 					   &status);
 		if (err)
@@ -472,9 +469,9 @@ static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
 		if (!(status & (BIT(0) | BIT(1))))
 			break;
 
-		udelay(RENESAS_DELAY);
+		udelay(CONFIG_USB_XHCI_PCI_RENESAS_DELAY);
 	}
-	if (i == RENESAS_RETRY) {
+	if (i == CONFIG_USB_XHCI_PCI_RENESAS_RETRY) {
 		dev_err(&pdev->dev, "Final Firmware ROM Download step timed out\n");
 		goto remove_bypass;
 	}
@@ -487,7 +484,7 @@ static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
 	udelay(10);
 
 	/* 18. check result */
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < CONFIG_USB_XHCI_PCI_RENESAS_RETRY; i++) {
 		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
 		if (err) {
 			dev_err(&pdev->dev, "Read ROM status failed:%d\n",
@@ -499,9 +496,9 @@ static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
 			dev_dbg(&pdev->dev, "Download ROM success\n");
 			break;
 		}
-		udelay(RENESAS_DELAY);
+		udelay(CONFIG_USB_XHCI_PCI_RENESAS_DELAY);
 	}
-	if (i == RENESAS_RETRY) { /* Timed out */
+	if (i == CONFIG_USB_XHCI_PCI_RENESAS_RETRY) { /* Timed out */
 		dev_err(&pdev->dev,
 			"Download to external ROM TO: %x\n", status);
 		return false;
@@ -521,16 +518,16 @@ static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
 	/*
 	 * wait till Reload is cleared
 	 */
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < CONFIG_USB_XHCI_PCI_RENESAS_RETRY; i++) {
 		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
 		if (err)
 			return false;
 		if (!(status & RENESAS_ROM_STATUS_RELOAD))
 			break;
 
-		udelay(RENESAS_DELAY);
+		udelay(CONFIG_USB_XHCI_PCI_RENESAS_DELAY);
 	}
-	if (i == RENESAS_RETRY) {
+	if (i == CONFIG_USB_XHCI_PCI_RENESAS_RETRY) {
 		dev_err(&pdev->dev, "ROM Exec timed out: %x\n", status);
 		return false;
 	}
-- 
2.41.0

