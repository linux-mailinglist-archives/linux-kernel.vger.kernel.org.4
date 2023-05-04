Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0E16F7558
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjEDT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjEDTzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F081AEF0;
        Thu,  4 May 2023 12:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1A0D637C9;
        Thu,  4 May 2023 19:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40023C433EF;
        Thu,  4 May 2023 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229697;
        bh=0GXFjYVqZ0PZmO9tVgTtfCagheAJigcdVsSQDV6JnJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M97Ii3afl/+sV3kszFMoB2RFv2qzqohbgyryPRCUjDHLImqpYxEtCGo6FCCgFFtDZ
         wET9aU6aAswiVknZjcb3j07zpQypn59BJDyl8HnFua/6JFlSF9+yQ0J2Eg5SHbr8Oz
         SE4smzEozd4lXv1pihVRK3fXGb8oiGMn3cCIsHhSCTBjNPa9h+fO5/yfgDaGAWlBNy
         TaH1eqCGvH0Nd/s5Hmx02jhmLzHejVuVLS+6GYnURGSXbKArnVPuY6YXO+OcgqV7zV
         FJY2JymcTdrkNP2VmBQJzOzg7XRiWoRsAz5NZWYdqnUDFj4v2o7/FS2AX14r+30pFJ
         4LP6TuxS98mug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 46/49] Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set
Date:   Thu,  4 May 2023 15:46:23 -0400
Message-Id: <20230504194626.3807438-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0d218c3642b9ccf71f44987cd03c19320f3bd918 ]

On some devices the BCM Bluetooth adapter does not have a valid bdaddr set.

btbcm.c currently sets HCI_QUIRK_INVALID_BDADDR to indicate when this is
the case. But this requires users to manual setup a btaddr, by doing e.g.:

btmgmt -i hci0 public-addr 'B0:F1:EC:82:1D:B3'

Which means that Bluetooth will not work out of the box on such devices.
To avoid this (where possible) hci_bcm sets: HCI_QUIRK_USE_BDADDR_PROPERTY
which tries to get the bdaddr from devicetree.

But this only works on devicetree platforms. On UEFI based platforms
there is a special Broadcom UEFI variable which when present contains
the devices bdaddr, just like how there is another UEFI variable which
contains wifi nvram contents including the wifi MAC address.

Add support for getting the bdaddr from this Broadcom UEFI variable,
so that Bluetooth will work OOTB for users on devices where this
UEFI variable is present.

This fixes Bluetooth not working on for example Asus T100HA 2-in-1s.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btbcm.c | 47 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 43e98a598bd9a..de2ea589aa49b 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2015  Intel Corporation
  */
 
+#include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/dmi.h>
@@ -34,6 +35,43 @@
 /* For kmalloc-ing the fw-name array instead of putting it on the stack */
 typedef char bcm_fw_name[BCM_FW_NAME_LEN];
 
+#ifdef CONFIG_EFI
+static int btbcm_set_bdaddr_from_efi(struct hci_dev *hdev)
+{
+	efi_guid_t guid = EFI_GUID(0x74b00bd9, 0x805a, 0x4d61, 0xb5, 0x1f,
+				   0x43, 0x26, 0x81, 0x23, 0xd1, 0x13);
+	bdaddr_t efi_bdaddr, bdaddr;
+	efi_status_t status;
+	unsigned long len;
+	int ret;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	len = sizeof(efi_bdaddr);
+	status = efi.get_variable(L"BDADDR", &guid, NULL, &len, &efi_bdaddr);
+	if (status != EFI_SUCCESS)
+		return -ENXIO;
+
+	if (len != sizeof(efi_bdaddr))
+		return -EIO;
+
+	baswap(&bdaddr, &efi_bdaddr);
+
+	ret = btbcm_set_bdaddr(hdev, &bdaddr);
+	if (ret)
+		return ret;
+
+	bt_dev_info(hdev, "BCM: Using EFI device address (%pMR)", &bdaddr);
+	return 0;
+}
+#else
+static int btbcm_set_bdaddr_from_efi(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -87,9 +125,12 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
-		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
-			    &bda->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		/* Try falling back to BDADDR EFI variable */
+		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
+			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
+				    &bda->bdaddr);
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		}
 	}
 
 	kfree_skb(skb);
-- 
2.39.2

