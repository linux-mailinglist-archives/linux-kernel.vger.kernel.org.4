Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7373EC24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjFZUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFZUvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:51:25 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D912A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:51:22 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 36104240103
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:51:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687812669; bh=tNIMKCKftTirXMggzoPi3H2tlA7Th71YKmucyD7m0pc=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=lyEDE9TkJ/RrF7TULqNbc/e465txk7WVij0EUPzDXrtmV12qhAEbwp6oBDQmOUc4W
         Ix/mC9ruP5KYXKD64s3txiJ7FJsSbZykqRKRA6fgCvlNp2WxjiQQ8mx+WgPXBTMLiH
         ScHibYQzj5OyoAzPEL2jVvoLTQQ54k2Fl8hn/geWqO5LXCN/P4DWbANII+VuZdP771
         50aqd9uJEdYnMftL9NDLcKr2zMzBm0lruK/TSK9yUTTNTWkj8L3Jmoeyzgs98rqdF8
         GY3MHG7ZhbGQ3c39TSbxvOEid4qkOvzP74G4pN0zWheoyY12HRiKtrpniwhvOfaJNU
         VHazwfUa3JkqA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qqg3s3ckFz9rxH;
        Mon, 26 Jun 2023 22:51:05 +0200 (CEST)
From:   Anne Macedo <retpolanne@posteo.net>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anne Macedo <retpolanne@posteo.net>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Rene Treffer <treffer@measite.de>
Subject: [PATCH] usb: host: xhci: remove renesas rom wiping
Date:   Mon, 26 Jun 2023 20:49:12 +0000
Message-ID: <20230626204910.728-3-retpolanne@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cards based on Renesas uPD72020x currently have their ROM wiped on
module start if they have an external ROM. This means that every time
you start up the module, the ROM gets cleaned up and the firmware
redownloaded.

Wiping the ROM all the time is not necessary and can lead to situations
where, for example, people with stable firmwares might have their card fail
due to incomplete flashes (due to timeouts, for example).

Another case is when PCI configs are set up after the ROM is flashed
(e.g. disabling hotplugging). The ROM wipe and reflash process will
overwrite these configs.

Also, the current ROM setup can't work: the flash layout contains more
than the firmware – for uploading, it needs to be prefixed with ~40
bytes that differ by card vendor. This config is documented on the
"uPD720201/uPD720202 User's Manual", section 6.3 (Data Format).

This patch, if applied, removes the cleanup and the setup of the Renesas
ROM as to not make it wipe and reset the ROM.

It also reduces load time, especially during boot, as problems with the
EEPROM chip or CRC checks might take some time during reflashing and
possibly lead to timeouts. Since the ROM is already flashed (either
manually by a tool such as uPD72020x-load or by the kernel module) it
just needs to be loaded during module startup.

Suggested-by: Rene Treffer <treffer@measite.de>
Signed-off-by: Anne Macedo <retpolanne@posteo.net>
---
 drivers/usb/host/xhci-pci-renesas.c | 188 ----------------------------
 1 file changed, 188 deletions(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 93f8b355bc70..28656beb808d 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -375,199 +375,11 @@ static int renesas_fw_download(struct pci_dev *pdev,
 	return 0;
 }
 
-static void renesas_rom_erase(struct pci_dev *pdev)
-{
-	int retval, i;
-	u8 status;
-
-	dev_dbg(&pdev->dev, "Performing ROM Erase...\n");
-	retval = pci_write_config_dword(pdev, RENESAS_DATA0,
-					RENESAS_ROM_ERASE_MAGIC);
-	if (retval) {
-		dev_err(&pdev->dev, "ROM erase, magic word write failed: %d\n",
-			pcibios_err_to_errno(retval));
-		return;
-	}
-
-	retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
-	if (retval) {
-		dev_err(&pdev->dev, "ROM status read failed: %d\n",
-			pcibios_err_to_errno(retval));
-		return;
-	}
-	status |= RENESAS_ROM_STATUS_ERASE;
-	retval = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, status);
-	if (retval) {
-		dev_err(&pdev->dev, "ROM erase set word write failed\n");
-		return;
-	}
-
-	/* sleep a bit while ROM is erased */
-	msleep(20);
-
-	for (i = 0; i < RENESAS_RETRY; i++) {
-		retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS,
-					      &status);
-		status &= RENESAS_ROM_STATUS_ERASE;
-		if (!status)
-			break;
-
-		mdelay(RENESAS_DELAY);
-	}
-
-	if (i == RENESAS_RETRY)
-		dev_dbg(&pdev->dev, "Chip erase timedout: %x\n", status);
-
-	dev_dbg(&pdev->dev, "ROM Erase... Done success\n");
-}
-
-static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
-{
-	const u32 *fw_data = (const u32 *)fw->data;
-	int err, i;
-	u8 status;
-
-	/* 2. Write magic word to Data0 */
-	err = pci_write_config_dword(pdev, RENESAS_DATA0,
-				     RENESAS_ROM_WRITE_MAGIC);
-	if (err)
-		return false;
-
-	/* 3. Set External ROM access */
-	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
-				    RENESAS_ROM_STATUS_ACCESS);
-	if (err)
-		goto remove_bypass;
-
-	/* 4. Check the result */
-	err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
-	if (err)
-		goto remove_bypass;
-	status &= GENMASK(6, 4);
-	if (status) {
-		dev_err(&pdev->dev,
-			"setting external rom failed: %x\n", status);
-		goto remove_bypass;
-	}
-
-	/* 5 to 16 Write FW to DATA0/1 while checking SetData0/1 */
-	for (i = 0; i < fw->size / 4; i++) {
-		err = renesas_fw_download_image(pdev, fw_data, i, true);
-		if (err) {
-			dev_err(&pdev->dev,
-				"ROM Download Step %d failed at position %d bytes with (%d)\n",
-				 i, i * 4, err);
-			goto remove_bypass;
-		}
-	}
-
-	/*
-	 * wait till DATA0/1 is cleared
-	 */
-	for (i = 0; i < RENESAS_RETRY; i++) {
-		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS_MSB,
-					   &status);
-		if (err)
-			goto remove_bypass;
-		if (!(status & (BIT(0) | BIT(1))))
-			break;
-
-		udelay(RENESAS_DELAY);
-	}
-	if (i == RENESAS_RETRY) {
-		dev_err(&pdev->dev, "Final Firmware ROM Download step timed out\n");
-		goto remove_bypass;
-	}
-
-	/* 17. Remove bypass */
-	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
-	if (err)
-		return false;
-
-	udelay(10);
-
-	/* 18. check result */
-	for (i = 0; i < RENESAS_RETRY; i++) {
-		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
-		if (err) {
-			dev_err(&pdev->dev, "Read ROM status failed:%d\n",
-				pcibios_err_to_errno(err));
-			return false;
-		}
-		status &= RENESAS_ROM_STATUS_RESULT;
-		if (status ==  RENESAS_ROM_STATUS_SUCCESS) {
-			dev_dbg(&pdev->dev, "Download ROM success\n");
-			break;
-		}
-		udelay(RENESAS_DELAY);
-	}
-	if (i == RENESAS_RETRY) { /* Timed out */
-		dev_err(&pdev->dev,
-			"Download to external ROM TO: %x\n", status);
-		return false;
-	}
-
-	dev_dbg(&pdev->dev, "Download to external ROM succeeded\n");
-
-	/* Last step set Reload */
-	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
-				    RENESAS_ROM_STATUS_RELOAD);
-	if (err) {
-		dev_err(&pdev->dev, "Set ROM execute failed: %d\n",
-			pcibios_err_to_errno(err));
-		return false;
-	}
-
-	/*
-	 * wait till Reload is cleared
-	 */
-	for (i = 0; i < RENESAS_RETRY; i++) {
-		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
-		if (err)
-			return false;
-		if (!(status & RENESAS_ROM_STATUS_RELOAD))
-			break;
-
-		udelay(RENESAS_DELAY);
-	}
-	if (i == RENESAS_RETRY) {
-		dev_err(&pdev->dev, "ROM Exec timed out: %x\n", status);
-		return false;
-	}
-
-	return true;
-
-remove_bypass:
-	pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
-	return false;
-}
-
 static int renesas_load_fw(struct pci_dev *pdev, const struct firmware *fw)
 {
 	int err = 0;
-	bool rom;
-
-	/* Check if the device has external ROM */
-	rom = renesas_check_rom(pdev);
-	if (rom) {
-		/* perform chip erase first */
-		renesas_rom_erase(pdev);
-
-		/* lets try loading fw on ROM first */
-		rom = renesas_setup_rom(pdev, fw);
-		if (!rom) {
-			dev_dbg(&pdev->dev,
-				"ROM load failed, falling back on FW load\n");
-		} else {
-			dev_dbg(&pdev->dev,
-				"ROM load success\n");
-			goto exit;
-		}
-	}
 
 	err = renesas_fw_download(pdev, fw);
-
-exit:
 	if (err)
 		dev_err(&pdev->dev, "firmware failed to download (%d).", err);
 	return err;
-- 
2.41.0

