Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144556ACD98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCFTIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCFTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:08:44 -0500
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 11:08:43 PST
Received: from granite.fifsource.com (granite.fifsource.com [173.255.216.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50C367CD;
        Mon,  6 Mar 2023 11:08:43 -0800 (PST)
Received: by granite.fifsource.com (Postfix, from userid 498)
        id E41984067; Mon,  6 Mar 2023 10:50:26 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from ceramic.home.fifi.org (107-142-44-66.lightspeed.sntcca.sbcglobal.net [107.142.44.66])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "ceramic.home.fifi.org", Issuer "FifSource Email CA (2015-04)" (verified OK))
        by granite.fifsource.com (Postfix) with ESMTPS id A5E434062;
        Mon,  6 Mar 2023 10:50:26 -0800 (PST)
Received: by ceramic.home.fifi.org (Postfix, from userid 1000)
        id 8B85A1A0008D; Mon,  6 Mar 2023 10:50:26 -0800 (PST)
From:   Philippe Troin <phil@fifi.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 6 Mar 2023 10:18:36 -0800
Subject: [PATCH] HID: add HP 13t-aw100 & 14t-ea100 digitizer battery quirks
Message-Id: <20230306185026.8B85A1A0008D@ceramic.home.fifi.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to many other devices using the Synopsys Designware Elantech
hardware, HP Spectre x360 13t-aw100 and 14t-ea100 report an empty
battery devices, supposedly for the active stylus.

Apply the HID_BATTERY_QUIRK_IGNORE quirk to ignore the battery reports
from these devices. Note that there are multiple versions of the panel
installed in the 14t-ea100.

Signed-off-by: Philippe Troin <phil@fifi.org>
---
 drivers/hid/hid-ids.h   | 3 +++
 drivers/hid/hid-input.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 63545cd307e5..22e716b66fb8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -420,6 +420,9 @@
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
 #define I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCREEN	0x2A1C
 #define I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN	0x279F
+#define I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100	0x29F5
+#define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
+#define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7fc967964dd8..5c65a584b3fa 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -398,6 +398,12 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100),
+	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1),
+	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.39.2

