Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8399E63106D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 20:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiKSTSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 14:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiKSTSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 14:18:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1413DD0;
        Sat, 19 Nov 2022 11:18:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t17so6545370pjo.3;
        Sat, 19 Nov 2022 11:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jd34oDE5tgW7Xr0uL0ebPFGuoLTNlNOFzZ6YlWV6+E=;
        b=i6Phvx4jIgrzuShLY17ZTwNYjckbrdwx4NAFiBxKZjhI3TJauv422CIATV7U1Al4ma
         MYcy5VdhfLxUqbV3QeNIcfECZ5mlPWyJQBSB8QpTsPvI/Ci52Le4hxVDfch514s69uiI
         u6ikIRZmn2/BpzkLz1aYd7yEZLT7VBI5DUdyu6dbNC1NtTdEcZnm/mPs2Po5bR4tf3vz
         BrTSnI/iT2i1yTfCns+QTnkJBtpsEczO+Hw42/5n6g7EGDhyr8FQQpe3d2gvcWZEGoUy
         yibrajT76AzCkL1AexBRCAZo8kT3+/zi0F2cSxVEJU2Asgl6dYxTIwqkm2kALwgqm8j2
         khCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jd34oDE5tgW7Xr0uL0ebPFGuoLTNlNOFzZ6YlWV6+E=;
        b=z8vRxM3WahU7P2eO5FYbwGlnyCk3vSP0vaYMZJEfyStRiLkG1Mu0CASH7MlCpXYl7s
         IQ9O/G1tnVPPiTyNl0a0IMwcs+wN26WDYLh8TVkAMbxG2FCx9y2Kzy4hA0+W9LCWD78Z
         x+dwJ9XHhDgJi0o9sYaaoFCqBrCOewUcy2DyWdm34Fq4WRfZxDgeA6gObfEuHVsvH3Ku
         VXyOERdKJloorv625vHiYYp7cSj+kRKSEzsF2PTyJmlFD6GFB215Ma+JZeB6RGTeMYEK
         I1ssnRuAFT8kBbeC37TrBcbF6+GwxgfCXQpWfhIRbzXaxTHaHn7hFWl/xkCAvz4YyH/1
         +9Kw==
X-Gm-Message-State: ANoB5pnHfX925T4mkWG5nBKDljZpQzDmHEsFlC73dhC3s0AieohFECr9
        qXwoAqOV7u4eeNuDfaP587GfBCmxzsECvdiUPoY=
X-Google-Smtp-Source: AA0mqf5IPdueyz05VOpxsWYoOkmrea1QBDPsZP/c5Dd5YprJsQ5DFRfuIT5edjShAj6XbCSMUks2mw==
X-Received: by 2002:a17:903:2305:b0:188:f3b9:7146 with SMTP id d5-20020a170903230500b00188f3b97146mr5030581plh.91.1668885486921;
        Sat, 19 Nov 2022 11:18:06 -0800 (PST)
Received: from y.home.yangfl.dn42 ([8.45.41.20])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00188f7ad561asm4965355pli.249.2022.11.19.11.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 11:18:06 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: kye: Add support for MousePen M508X
Date:   Sun, 20 Nov 2022 03:17:42 +0800
Message-Id: <20221119191743.6466-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119174656.83976-1-mmyangfl@gmail.com>
References: <20221119174656.83976-1-mmyangfl@gmail.com>
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
index da903138e..97e209c1f 100644
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

