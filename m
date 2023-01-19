Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5E6740FF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjASSay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjASSav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:30:51 -0500
X-Greylist: delayed 80077 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 10:30:15 PST
Received: from m25.coreserver.jp (m25.coreserver.jp [202.172.26.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9394C98
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:30:14 -0800 (PST)
Received: (qmail 816929 invoked by uid 89); 20 Jan 2023 03:30:13 +0900
Received: from 25.6.30.125.dy.iij4u.or.jp (HELO fg-ryz..) (fujii@xaxxi.net@125.30.6.25)
  by m25.coreserver.jp with TLS_AES_256_GCM_SHA384 encrypted SMTP; 20 Jan 2023 03:30:13 +0900
From:   Takahiro Fujii <fujii@xaxxi.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takahiro Fujii <fujii@xaxxi.net>
Subject: [PATCH] HID: elecom: add support for TrackBall 056E:011C
Date:   Fri, 20 Jan 2023 03:30:02 +0900
Message-Id: <20230119183002.352852-1-fujii@xaxxi.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function buttons on ELECOM M-HT1DRBK trackball mouse work. This model
has two devices with different device IDs (010D and 011C). Both of
them misreports the number of buttons as 5 in the report descriptor, even
though they have 8 buttons. hid-elecom overwrites the report to fix them,
but supports only on 010D and does not work on 011C. This patch fixes
011C in the similar way but with specialized position parameters.
In fact, it is sufficient to rewrite only 17th byte (05 -> 08). However I
followed the existing way.

Signed-off-by: Takahiro Fujii <fujii@xaxxi.net>
---
 drivers/hid/hid-elecom.c | 16 ++++++++++++++--
 drivers/hid/hid-ids.h    |  3 ++-
 drivers/hid/hid-quirks.c |  3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index e59e9911fc37..4fa45ee77503 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -12,6 +12,7 @@
  *  Copyright (c) 2017 Alex Manoussakis <amanou@gnu.org>
  *  Copyright (c) 2017 Tomasz Kramkowski <tk@the-tk.com>
  *  Copyright (c) 2020 YOSHIOKA Takuma <lo48576@hard-wi.red>
+ *  Copyright (c) 2022 Takahiro Fujii <fujii@xaxxi.net>
  */
 
 /*
@@ -89,7 +90,7 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	case USB_DEVICE_ID_ELECOM_M_DT1URBK:
 	case USB_DEVICE_ID_ELECOM_M_DT1DRBK:
 	case USB_DEVICE_ID_ELECOM_M_HT1URBK:
-	case USB_DEVICE_ID_ELECOM_M_HT1DRBK:
+	case USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D:
 		/*
 		 * Report descriptor format:
 		 * 12: button bit count
@@ -99,6 +100,16 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		 */
 		mouse_button_fixup(hdev, rdesc, *rsize, 12, 30, 14, 20, 8);
 		break;
+	case USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C:
+		/*
+		 * Report descriptor format:
+		 * 22: button bit count
+		 * 30: padding bit count
+		 * 24: button report size
+		 * 16: button usage maximum
+		 */
+		mouse_button_fixup(hdev, rdesc, *rsize, 22, 30, 24, 16, 8);
+		break;
 	}
 	return rdesc;
 }
@@ -112,7 +123,8 @@ static const struct hid_device_id elecom_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, elecom_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 82713ef3aaa6..86692aecf36d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -429,7 +429,8 @@
 #define USB_DEVICE_ID_ELECOM_M_DT1URBK	0x00fe
 #define USB_DEVICE_ID_ELECOM_M_DT1DRBK	0x00ff
 #define USB_DEVICE_ID_ELECOM_M_HT1URBK	0x010c
-#define USB_DEVICE_ID_ELECOM_M_HT1DRBK	0x010d
+#define USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D	0x010d
+#define USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C	0x011c
 
 #define USB_VENDOR_ID_DREAM_CHEEKY	0x1d34
 #define USB_DEVICE_ID_DREAM_CHEEKY_WN	0x0004
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 0e9702c7f7d6..0e7b4e6a5b2d 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -394,7 +394,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C) },
 #endif
 #if IS_ENABLED(CONFIG_HID_ELO)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0009) },

base-commit: 7c698440524117dca7534592db0e7f465ae4d0bb
-- 
2.39.0

