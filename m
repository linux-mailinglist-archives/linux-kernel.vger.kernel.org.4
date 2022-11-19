Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CADC6310FD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiKSUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKSUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:51:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2998712D1E;
        Sat, 19 Nov 2022 12:51:11 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so7444530pli.0;
        Sat, 19 Nov 2022 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bAqgYnbP6qZL1afAcbM3Tf3M3J5IQhHIXMvEmd2gsw=;
        b=EkSPsKG4ndYR5SLcMSVAU0v6JNyoDCo/QZaNMARfsRA6A7WvsVUvL4IB84ODtba7G5
         IR4pQR0o3PWSj7J5T+iWeLrOTYHVvYFyboRx1UGI6DmZssYw7cJLaMY1VGywcQPRsVFW
         5hHeoW5ldChFawxZPgzjaR7i7xtGxB7mqIc3Ayvoj8OWEbVzRoGBdndcrvG4yUSiQ4yR
         GkIW3mmmFqkgi9clwFL0OoxXUDrKQw8NMT8zipH/wEsLifAaPTg+R1y2PXmR6Gv+geVy
         aMIZhOgJULwqiPtzc6A/nMmpaSIaMRtaJLc9ICfkudostkDr2jBFgPUs4qVjeRz5qRP3
         2q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bAqgYnbP6qZL1afAcbM3Tf3M3J5IQhHIXMvEmd2gsw=;
        b=gis6Nq52bvuG+tyaq+02mal/g4n1eohHN5p4uaqvIrvYk9cSYU30xygG2epXfRIlJ3
         BzZniiZ63WH+X3W/3ZN9d1QM97GveUviywEeaaSwTJazE2bBLigxNRLbubWLGyqNJwqZ
         fdqXkcsoq8QtkWcOxbbPETeMXfOOM0kl9de+2CGb6LQ+E5aCnplMPPS8H1Qyc9NkmMMD
         ciEU5JxuqAPxJRyN7I7Eh1tbjKqmkA0DX1Lwu2yciy1zyrVWI46vawazKHX1CtHtRgq+
         JT6GA2j0kUF6ztG+2mdPXCB7ZXtWe3hBCfGR35EWEerjt5M1iyhhwWVX9W2JR6UhFlYk
         pAuQ==
X-Gm-Message-State: ANoB5pmr2WxxwzcIvTx8YTXPcYXwGYD6QeXCPcrAeL4Djf0ouLlSOfBn
        bV4QRPdJma3SRS4S2IJ4vt4=
X-Google-Smtp-Source: AA0mqf6gVt7oSpxV+jWy9y5qHmJEIvXMx5GK2SUuAKAvlKfk7XLpmgqTnT6/KOHt4Hm/YhifP8PW6w==
X-Received: by 2002:a17:902:9889:b0:182:e9dd:936d with SMTP id s9-20020a170902988900b00182e9dd936dmr5412197plp.6.1668891070537;
        Sat, 19 Nov 2022 12:51:10 -0800 (PST)
Received: from y.home.yangfl.dn42 ([8.45.41.20])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b00176b3d7db49sm6207505plb.0.2022.11.19.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 12:51:10 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] HID: kye: Add support for MousePen M508X
Date:   Sun, 20 Nov 2022 04:50:56 +0800
Message-Id: <20221119205057.11694-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119191743.6466-1-mmyangfl@gmail.com>
References: <20221119191743.6466-1-mmyangfl@gmail.com>
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
v2: add missing hid-quirks.c entry
v3: minor fix of descriptor
 drivers/hid/hid-ids.h    |   1 +
 drivers/hid/hid-kye.c    | 152 ++++++++++++++++++++++++++++++++++++---
 drivers/hid/hid-quirks.c |   1 +
 3 files changed, 145 insertions(+), 9 deletions(-)

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
index da903138e..805d30c39 100644
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
+	0x75, 0x10,                   /*      Report Size (16),           */
+	0xA4,                         /*      Push,                       */
+	0x05, 0x01,                   /*      Usage Page (Desktop),       */
+	0x09, 0x30,                   /*      Usage (X),                  */
+	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x45, 0x16,                   /*      Physical Maximum (22),      */
+	0x65, 0x11,                   /*      Unit (Centimeter),          */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x26, 0x00, 0x64,             /*      Logical Maximum (25600),    */
+	0x46, 0x8F, 0x00,             /*      Physical Maximum (143),     */
+	0x55, 0xFF,                   /*      Unit Exponent (-1),         */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xB4,                         /*      Pop,                        */
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
+	0xA4,                         /*      Push,                       */
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
+	0xB4,                         /*      Pop,                        */
+	0x09, 0x38,                   /*      Usage (Wheel),              */
+	0x15, 0xFF,                   /*      Logical Minimum (-1),       */
+	0x75, 0x08,                   /*      Report Size (8),            */
+	0x81, 0x06,                   /*      Input (Variable, Relative), */
+	0x81, 0x01,                   /*      Input (Constant),           */
+	0xC0,                         /*    End Collection,               */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0C,                   /*  Usage Page (Consumer),          */
+	0x09, 0x01,                   /*  Usage (Consumer Control),       */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x12,                   /*    Report ID (18),               */
+	0x0A, 0x01, 0x02,             /*    Usage (AC New),               */
+	0x09, 0x40,                   /*    Usage (Menu),                 */
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
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 50e1c717f..c70bbdc1a 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -108,6 +108,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_M508X), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406XE), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E), HID_QUIRK_ALWAYS_POLL },
-- 
2.35.1

