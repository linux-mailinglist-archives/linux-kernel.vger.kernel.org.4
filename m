Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A739267B486
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjAYOeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjAYOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:34:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0B92F791;
        Wed, 25 Jan 2023 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674657242; x=1706193242;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3kpOMqrQuctFKDrDiGjBznoIROiBQ5QhwWS1ed7ePGE=;
  b=eeZzmZZYBYFhSOLUPBMGTrUn290Gw7tjfzbXj7edVCgtPzflaliA9F7Z
   JsPm9p6FG4ke+5D6UsqBZ9vhLYvkNKc/Dr7+yg7mY7qvH+0/eCjkzV7qg
   znWlIyERyCYGz0MZWx8u0Y8vOfP/HpQC+k704ye+zYVAE6zfYCVhY7JUC
   peHwuaanJas+O6f1vxpnbFZPXyEYM9DAXTyfTkfCw8gE453wn0FExv4H+
   yuBAnHDskgyqaBetW4I5hpA+VoBoPDnMGdDTD3vICjIakqV/YoN30MxNm
   88hsV9Qimm2UlmyBqoXMlgfVVtY82qRSsaEcb/DkbgIe3tjo73QFVjrlg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="324268176"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="324268176"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 06:33:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="805017342"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="805017342"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2023 06:33:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37B9A165; Wed, 25 Jan 2023 16:34:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] usb: gadget: Use correct APIs and data types for UUID handling
Date:   Wed, 25 Jan 2023 16:34:25 +0200
Message-Id: <20230125143425.85268-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two types for UUIDs depending on the byte ordering.
Instead of explaining how bytes should go over the wire,
use dedicated APIs and data types. This removes a confusion
over the byte ordering.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/composite.c | 4 ++--
 include/linux/usb/webusb.h     | 9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 8e2603688016..fa7dd6cf014d 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -829,7 +829,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 	if (cdev->use_webusb) {
 		struct usb_plat_dev_cap_descriptor *webusb_cap;
 		struct usb_webusb_cap_data *webusb_cap_data;
-		uuid_t webusb_uuid = WEBUSB_UUID;
+		guid_t webusb_uuid = WEBUSB_UUID;
 
 		webusb_cap = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
 		webusb_cap_data = (struct usb_webusb_cap_data *) webusb_cap->CapabilityData;
@@ -841,7 +841,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 		webusb_cap->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
 		webusb_cap->bDevCapabilityType = USB_PLAT_DEV_CAP_TYPE;
 		webusb_cap->bReserved = 0;
-		export_uuid(webusb_cap->UUID, &webusb_uuid);
+		export_guid(webusb_cap->UUID, &webusb_uuid);
 
 		if (cdev->bcd_webusb_version != 0)
 			webusb_cap_data->bcdVersion = cpu_to_le16(cdev->bcd_webusb_version);
diff --git a/include/linux/usb/webusb.h b/include/linux/usb/webusb.h
index b430d84357f3..fe43020b4a48 100644
--- a/include/linux/usb/webusb.h
+++ b/include/linux/usb/webusb.h
@@ -11,15 +11,12 @@
 #include "uapi/linux/usb/ch9.h"
 
 /*
- * little endian PlatformCapablityUUID for WebUSB
+ * Little Endian PlatformCapablityUUID for WebUSB
  * 3408b638-09a9-47a0-8bfd-a0768815b665
- * to identify Platform Device Capability descriptors as referring to WebUSB
- *
- * the UUID above MUST be sent over the wire as the byte sequence:
- * {0x38, 0xB6, 0x08, 0x34, 0xA9, 0x09, 0xA0, 0x47, 0x8B, 0xFD, 0xA0, 0x76, 0x88, 0x15, 0xB6, 0x65}.
+ * to identify Platform Device Capability descriptors as referring to WebUSB.
  */
 #define WEBUSB_UUID \
-	UUID_INIT(0x38b60834, 0xa909, 0xa047, 0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0x65)
+	GUID_INIT(0x3408b638, 0x09a9, 0x47a0, 0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0x65)
 
 /*
  * WebUSB Platform Capability data
-- 
2.39.0

