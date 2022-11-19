Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177563102C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiKSRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiKSRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:47:17 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137071A3B0;
        Sat, 19 Nov 2022 09:47:15 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 62so7620268pgb.13;
        Sat, 19 Nov 2022 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7H6DJKCfHixnPFAkTLAl8E83OdjF7PB5hMUCcb4RgU=;
        b=J0OnoI0a9KLtfnySwMotBzRojT7zBwvZp1Lrf+GlwgI0OKsXtB3xIr9k0HER3vXyx2
         b7yyvFR+vsOgiXVF7OQFPYvs6M2OaElGJ7FHPrgwkaVpNDvuIlE6RpZTbLLVWwS0knto
         ckzNWiWKcnqWEqLZjyIIu+FBZOrLz2MBsjyN5b339f5wUIDwCUM6o79S5fZ7tjuoB7ec
         3wouCMydnnUUb7ZzMXVFPo1545IqoymFwpiqAPozJMsbTuAdpsf5wsozE4vV2uWOHsVb
         L2EhXfq4sOltoh8j3HOBCtuEhIA7sbnC7Vt+2teUpQeAic1sddM2y1Vbri4czIkLI3qA
         pP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7H6DJKCfHixnPFAkTLAl8E83OdjF7PB5hMUCcb4RgU=;
        b=n6OEnQYfivep9WcSRSe0XbHkUKumwDD+ic6LZRmSVRQkSRgghxrmpqFUH75ESBnYpl
         APhqvL0AaVBu21I8hOXKH3h7UR/fu4lBKyeMUmX8lpn1lCQMuiV87OGVjOYJer3AKTNX
         cc8ZeVcws2L4u7LghtBfEJYEPZD9pPRsZHSoWUjh8EoOFZIExyB6RpeOMcycOOOBZhU1
         RWIZSoKl4cBrRl28wnG2anKyTY2Le+d3DE0o4vJsydNGpMMPuCaiIDD6TDxp32tdckzp
         A3l1HNLEcCatxsVZ+6NGxsEfR8OLzyl4LgrInmZCRZ3PL8v5LMdQCFmqL+HiNg1OyicE
         gnJw==
X-Gm-Message-State: ANoB5plCg5/diDQ4i2YCwRD1IwSUabhxJ2p9Vc2xLXrw4z4gRNUVQjRv
        qn6Tknh9ovPtpdAd+UDjXK8=
X-Google-Smtp-Source: AA0mqf6+F6iusHSvqWPZA/PLKMR5HsR7O1Z62/fMGS1gIpZX/1NivDOKF09TZ0Nja+azJZYoHoyD6Q==
X-Received: by 2002:a63:cc15:0:b0:476:ccde:6694 with SMTP id x21-20020a63cc15000000b00476ccde6694mr11104234pgf.603.1668880034424;
        Sat, 19 Nov 2022 09:47:14 -0800 (PST)
Received: from y.home.yangfl.dn42 ([8.45.41.20])
        by smtp.gmail.com with ESMTPSA id q15-20020aa7842f000000b0056b9df2a15esm5392491pfn.62.2022.11.19.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 09:47:13 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: kye: Add support for MousePen M508X
Date:   Sun, 20 Nov 2022 01:46:55 +0800
Message-Id: <20221119174656.83976-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Genius MousePen M508X digitizer tablet sends incorrect report descriptor by
default. This patch replaces it with a corrected one.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/hid/hid-ids.h |   1 +
 drivers/hid/hid-kye.c | 152 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 144 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index dad953f66..45f49b9be 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -716,6 +716,7 @@
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2	0x501a
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
 #define USB_DEVICE_ID_KYE_PENSKETCH_M912	0x5015
+#define USB_DEVICE_ID_KYE_MOUSEPEN_M508X	0x5017
 #define USB_DEVICE_ID_KYE_EASYPEN_M406XE	0x5019
 
 #define USB_VENDOR_ID_LABTEC		0x1020
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index da903138e..ef36599af 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -480,6 +480,131 @@ static __u8 pensketch_m912_rdesc_fixed[] = {
 	0xC0                          /*  End Collection                  */
 };
 
+/* Original MousePen M508X report descriptor size */
+#define MOUSEPEN_M508X_RDESC_ORIG_SIZE	482
+
+/* Fixed MousePen M508X report descriptor */
+static __u8 mousepen_m508x_rdesc_fixed[] = {
+	0x06, 0x00, 0xFF,             /*  Usage Page (FF00h),             */
+	0x09, 0x01,                   /*  Usage (01h),                    */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x05,                   /*    Report ID (5),                */
+	0x09, 0x01,                   /*    Usage (01h),                  */
+	0x15, 0x81,                   /*    Logical Minimum (-127),       */
+	0x25, 0x7F,                   /*    Logical Maximum (127),        */
+	0x75, 0x08,                   /*    Report Size (8),              */
+	0x95, 0x07,                   /*    Report Count (7),             */
+	0xB1, 0x02,                   /*    Feature (Variable),           */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
+	0x09, 0x01,                   /*  Usage (Digitizer),              */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x10,                   /*    Report ID (16),               */
+	0x09, 0x20,                   /*    Usage (Stylus),               */
+	0xA1, 0x00,                   /*    Collection (Physical),        */
+	0x09, 0x42,                   /*      Usage (Tip Switch),         */
+	0x09, 0x44,                   /*      Usage (Barrel Switch),      */
+	0x09, 0x46,                   /*      Usage (Tablet Pick),        */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x75, 0x01,                   /*      Report Size (1),            */
+	0x95, 0x03,                   /*      Report Count (3),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x95, 0x04,                   /*      Report Count (4),           */
+	0x81, 0x01,                   /*      Input (Constant),           */
+	0x09, 0x32,                   /*      Usage (In Range),           */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x05, 0x01,                   /*      Usage Page (Desktop),       */
+	0x09, 0x30,                   /*      Usage (X),                  */
+	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x45, 0x16,                   /*      Physical Maximum (22),      */
+	0x65, 0x11,                   /*      Unit (Centimeter),          */
+	0x75, 0x10,                   /*      Report Size (16),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x26, 0x00, 0x64,             /*      Logical Maximum (25600),    */
+	0x46, 0x8F, 0x00,             /*      Physical Maximum (143),     */
+	0x55, 0xFF,                   /*      Unit Exponent (-1),         */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x05, 0x0D,                   /*      Usage Page (Digitizer),     */
+	0x09, 0x30,                   /*      Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x07,             /*      Logical Maximum (2047),     */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xC0,                         /*    End Collection,               */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
+	0x09, 0x21,                   /*  Usage (Puck),                   */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x11,                   /*    Report ID (17),               */
+	0x09, 0x21,                   /*    Usage (Puck),                 */
+	0xA0,                         /*    Collection (Physical),        */
+	0x05, 0x09,                   /*      Usage Page (Button),        */
+	0x19, 0x01,                   /*      Usage Minimum (01h),        */
+	0x29, 0x03,                   /*      Usage Maximum (03h),        */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x75, 0x01,                   /*      Report Size (1),            */
+	0x95, 0x03,                   /*      Report Count (3),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x95, 0x04,                   /*      Report Count (4),           */
+	0x81, 0x01,                   /*      Input (Constant),           */
+	0x05, 0x0D,                   /*      Usage Page (Digitizer),     */
+	0x09, 0x32,                   /*      Usage (In Range),           */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x05, 0x01,                   /*      Usage Page (Desktop),       */
+	0x09, 0x30,                   /*      Usage (X),                  */
+	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x45, 0x16,                   /*      Physical Maximum (22),      */
+	0x65, 0x11,                   /*      Unit (Centimeter),          */
+	0x75, 0x10,                   /*      Report Size (16),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x26, 0x00, 0x64,             /*      Logical Maximum (25600),    */
+	0x46, 0x8F, 0x00,             /*      Physical Maximum (143),     */
+	0x55, 0xFF,                   /*      Unit Exponent (-1),         */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x38,                   /*      Usage (Wheel),              */
+	0x15, 0xFF,                   /*      Logical Minimum (-1),       */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x44,                         /*      Physical Maximum (0),       */
+	0x75, 0x08,                   /*      Report Size (8),            */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0x81, 0x06,                   /*      Input (Variable, Relative), */
+	0x81, 0x01,                   /*      Input (Constant),           */
+	0xC0,                         /*    End Collection,               */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0C,                   /*  Usage Page (Consumer),          */
+	0x09, 0x01,                   /*  Usage (Consumer Control),       */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x12,                   /*    Report ID (18),               */
+	0x0A, 0x01, 0x02,             /*    Usage (AC New),               */
+	0x0B, 0x76, 0x00, 0x0D, 0x00, /*    Usage (Digitizer Brush),      */
+	0x0A, 0x6A, 0x02,             /*    Usage (AC Delete),            */
+	0x0A, 0x1A, 0x02,             /*    Usage (AC Undo),              */
+	0x14,                         /*    Logical Minimum (0),          */
+	0x25, 0x01,                   /*    Logical Maximum (1),          */
+	0x75, 0x01,                   /*    Report Size (1),              */
+	0x95, 0x04,                   /*    Report Count (4),             */
+	0x81, 0x02,                   /*    Input (Variable),             */
+	0x81, 0x01,                   /*    Input (Constant),             */
+	0x15, 0xFF,                   /*    Logical Minimum (-1),         */
+	0x75, 0x08,                   /*    Report Size (8),              */
+	0x95, 0x02,                   /*    Report Count (2),             */
+	0x81, 0x01,                   /*    Input (Constant),             */
+	0x0A, 0x35, 0x02,             /*    Usage (AC Scroll),            */
+	0x0A, 0x2F, 0x02,             /*    Usage (AC Zoom),              */
+	0x0A, 0x38, 0x02,             /*    Usage (AC Pan),               */
+	0x95, 0x03,                   /*    Report Count (3),             */
+	0x81, 0x06,                   /*    Input (Variable, Relative),   */
+	0x95, 0x01,                   /*    Report Count (1),             */
+	0x81, 0x01,                   /*    Input (Constant),             */
+	0xC0                          /*  End Collection                  */
+};
+
 /* Original EasyPen M406XE report descriptor size */
 #define EASYPEN_M406XE_RDESC_ORIG_SIZE	476
 
@@ -626,18 +751,24 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(easypen_m610x_rdesc_fixed);
 		}
 		break;
-	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
-		if (*rsize == EASYPEN_M406XE_RDESC_ORIG_SIZE) {
-			rdesc = easypen_m406xe_rdesc_fixed;
-			*rsize = sizeof(easypen_m406xe_rdesc_fixed);
-		}
-		break;
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
 		if (*rsize == PENSKETCH_M912_RDESC_ORIG_SIZE) {
 			rdesc = pensketch_m912_rdesc_fixed;
 			*rsize = sizeof(pensketch_m912_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
+		if (*rsize == MOUSEPEN_M508X_RDESC_ORIG_SIZE) {
+			rdesc = mousepen_m508x_rdesc_fixed;
+			*rsize = sizeof(mousepen_m508x_rdesc_fixed);
+		}
+		break;
+	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
+		if (*rsize == EASYPEN_M406XE_RDESC_ORIG_SIZE) {
+			rdesc = easypen_m406xe_rdesc_fixed;
+			*rsize = sizeof(easypen_m406xe_rdesc_fixed);
+		}
+		break;
 	case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
 		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
 					"Genius Gila Gaming Mouse");
@@ -721,8 +852,9 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
-	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
+	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
 		ret = kye_tablet_enable(hdev);
 		if (ret) {
 			hid_err(hdev, "tablet enabling failed\n");
@@ -756,6 +888,10 @@ static const struct hid_device_id kye_devices[] = {
 				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_MOUSEPEN_M508X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
@@ -764,8 +900,6 @@ static const struct hid_device_id kye_devices[] = {
 				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_GENIUS_MANTICORE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, kye_devices);
-- 
2.35.1

