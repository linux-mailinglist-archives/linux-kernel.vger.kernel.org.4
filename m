Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D168CE43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBGEg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBGEgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:36:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21781366A7;
        Mon,  6 Feb 2023 20:36:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m2so14464161plg.4;
        Mon, 06 Feb 2023 20:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZGqSJHo5DU+dlQ/SjOtVka2Lo+aAcY8E9XeHqxv9Vg=;
        b=KzruR9WJFKVvTidjydBxg3ezu9ZIbc9mX/yM8aMQ4xmbZg9NRvAUfzNJ4p4DDc647J
         oifzBRixw/N6X3f8cW5KhcLvndsrKdOcXbPKkC+iGcErcqddChY/ODGqEZL2JuZ18Ffd
         xCXHKsg4XN8k4oinJICJgpcTurg0ML6setX58bDnSGCMbp4Ck+efVPByY7MZoKXG8e5i
         BMSpBuZpcWOl/B1h+pGiq2tdjLFU/Bkbl6MFCIU3tX7gSJ83BeL+KIIJBHqqzHs9Ogit
         e56AwGsm9o+rxd/3+XpyWbCgWGdUzkLoE+uvs7lItGDG40iL0bH1CGTuZu5aJS7uE1BO
         qcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZGqSJHo5DU+dlQ/SjOtVka2Lo+aAcY8E9XeHqxv9Vg=;
        b=T6z8GUQoFXmcEGrdknIIwffzoezhevITOPkNeeJNBKdynujTeFDpVqSwC6jD8EZ5/a
         GWE35XT2bQq9woDqwLVlaM2miK7mBz7CjZq+Z5qsUm/kTfx4pPcYmpj2dKL0XjkjPHQe
         BFRv3ar/9xoWYJzdz1M1PqXVXknO3LSLhfxZSaTDo0atOdvwgkHyp+Vo0GjDMnFiO/Jq
         veqs8Ea3gnWDx8LPucpdFEfUp64EMuIKvG2uh5tUCP8eevL0PQS7CEA06ZLuGomqYHkc
         ZIoo5ZKCyAKBPO4J+9OcOdW8f/xRIUGywvXj9CcEHUoz194gxNc7FYc9fFQRdFVpZzAk
         QS/g==
X-Gm-Message-State: AO0yUKUFOQPeDolq7KQ42MKYEdBF9V4QMRzr1WZJaBsz+vrPhpiiuoSq
        7QuaMk+cEq5PWrwITlx25iM=
X-Google-Smtp-Source: AK7set8UUyNmAjzshXozRFDsIxHpHZ1RbwOGJjq2my5RFc0PuG4iVbVaaurvPDNUV3EdX7UoDiIqDA==
X-Received: by 2002:a05:6a20:690c:b0:bc:cff9:f092 with SMTP id q12-20020a056a20690c00b000bccff9f092mr2278794pzj.10.1675744573644;
        Mon, 06 Feb 2023 20:36:13 -0800 (PST)
Received: from d.home.yangfl.dn42 ([222.69.200.222])
        by smtp.gmail.com with ESMTPSA id p4-20020a63ab04000000b00499a90cce5bsm6695310pgf.50.2023.02.06.20.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:36:12 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] HID: kye: Add support for all kye tablets
Date:   Tue,  7 Feb 2023 12:33:17 +0800
Message-Id: <20230207043318.23842-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207043318.23842-1-mmyangfl@gmail.com>
References: <20230207043318.23842-1-mmyangfl@gmail.com>
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

Physical data for all kye tablets are collected from Windows driver, to
generate correct HID reports.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/hid/hid-ids.h    |   7 ++
 drivers/hid/hid-kye.c    | 173 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-quirks.c |   8 ++
 3 files changed, 188 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index dce7e1424672..11153d897db7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -712,12 +712,19 @@
 #define USB_DEVICE_ID_GENIUS_MANTICORE	0x0153
 #define USB_DEVICE_ID_GENIUS_GX_IMPERATOR	0x4018
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
+#define USB_DEVICE_ID_KYE_EASYPEN_M406	0x5005
+#define USB_DEVICE_ID_KYE_EASYPEN_M506	0x500F
 #define USB_DEVICE_ID_KYE_EASYPEN_I405X	0x5010
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
+#define USB_DEVICE_ID_KYE_EASYPEN_M406W	0x5012
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
+#define USB_DEVICE_ID_KYE_EASYPEN_340	0x5014
 #define USB_DEVICE_ID_KYE_PENSKETCH_M912	0x5015
+#define USB_DEVICE_ID_KYE_MOUSEPEN_M508WX	0x5016
+#define USB_DEVICE_ID_KYE_MOUSEPEN_M508X	0x5017
 #define USB_DEVICE_ID_KYE_EASYPEN_M406XE	0x5019
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2	0x501A
+#define USB_DEVICE_ID_KYE_PENSKETCH_T609A	0x501B
 
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index 47f5aa5e9d88..b3bde4bb979d 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -15,6 +15,74 @@
 
 #include "hid-ids.h"
 
+/* Data gathered from Database/VID0458_PID????/Vista/TBoard/default.xml in ioTablet driver
+ *
+ * TODO:
+ *   - Add battery and sleep support for EasyPen M406W and MousePen M508WX
+ *   - Investigate ScrollZ.MiceFMT buttons of EasyPen M406
+ */
+
+static const __u8 easypen_m406_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),    */
+	0x09, 0x01,        /*  Usage (Consumer Control), */
+	0xA1, 0x01,        /*  Collection (Application), */
+	0x85, 0x12,        /*    Report ID (18),         */
+	0x0A, 0x45, 0x02,  /*    Usage (AC Rotate),      */
+	0x09, 0x40,        /*    Usage (Menu),           */
+	0x0A, 0x2F, 0x02,  /*    Usage (AC Zoom),        */
+	0x0A, 0x46, 0x02,  /*    Usage (AC Resize),      */
+	0x0A, 0x1A, 0x02,  /*    Usage (AC Undo),        */
+	0x0A, 0x6A, 0x02,  /*    Usage (AC Delete),      */
+	0x0A, 0x24, 0x02,  /*    Usage (AC Back),        */
+	0x0A, 0x25, 0x02,  /*    Usage (AC Forward),     */
+	0x14,              /*    Logical Minimum (0),    */
+	0x25, 0x01,        /*    Logical Maximum (1),    */
+	0x75, 0x01,        /*    Report Size (1),        */
+	0x95, 0x08,        /*    Report Count (8),       */
+	0x81, 0x02,        /*    Input (Variable),       */
+	0x95, 0x30,        /*    Report Count (48),      */
+	0x81, 0x01,        /*    Input (Constant),       */
+	0xC0               /*  End Collection            */
+};
+
+static const __u8 easypen_m506_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),    */
+	0x09, 0x01,        /*  Usage (Consumer Control), */
+	0xA1, 0x01,        /*  Collection (Application), */
+	0x85, 0x12,        /*    Report ID (18),         */
+	0x0A, 0x6A, 0x02,  /*    Usage (AC Delete),      */
+	0x0A, 0x1A, 0x02,  /*    Usage (AC Undo),        */
+	0x0A, 0x2D, 0x02,  /*    Usage (AC Zoom In),     */
+	0x0A, 0x2E, 0x02,  /*    Usage (AC Zoom Out),    */
+	0x14,              /*    Logical Minimum (0),    */
+	0x25, 0x01,        /*    Logical Maximum (1),    */
+	0x75, 0x01,        /*    Report Size (1),        */
+	0x95, 0x04,        /*    Report Count (4),       */
+	0x81, 0x02,        /*    Input (Variable),       */
+	0x95, 0x34,        /*    Report Count (52),      */
+	0x81, 0x01,        /*    Input (Constant),       */
+	0xC0               /*  End Collection            */
+};
+
+static const __u8 easypen_m406w_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),    */
+	0x09, 0x01,        /*  Usage (Consumer Control), */
+	0xA1, 0x01,        /*  Collection (Application), */
+	0x85, 0x12,        /*    Report ID (18),         */
+	0x0A, 0x6A, 0x02,  /*    Usage (AC Delete),      */
+	0x0A, 0x1A, 0x02,  /*    Usage (AC Undo),        */
+	0x0A, 0x01, 0x02,  /*    Usage (AC New),         */
+	0x09, 0x40,        /*    Usage (Menu),           */
+	0x14,              /*    Logical Minimum (0),    */
+	0x25, 0x01,        /*    Logical Maximum (1),    */
+	0x75, 0x01,        /*    Report Size (1),        */
+	0x95, 0x04,        /*    Report Count (4),       */
+	0x81, 0x02,        /*    Input (Variable),       */
+	0x95, 0x34,        /*    Report Count (52),      */
+	0x81, 0x01,        /*    Input (Constant),       */
+	0xC0               /*  End Collection            */
+};
+
 static const __u8 easypen_m610x_control_rdesc[] = {
 	0x05, 0x0C,        /*  Usage Page (Consumer),       */
 	0x09, 0x01,        /*  Usage (Consumer Control),    */
@@ -58,6 +126,54 @@ static const __u8 pensketch_m912_control_rdesc[] = {
 	0xC0               /*  End Collection                */
 };
 
+static const __u8 mousepen_m508wx_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),    */
+	0x09, 0x01,        /*  Usage (Consumer Control), */
+	0xA1, 0x01,        /*  Collection (Application), */
+	0x85, 0x12,        /*    Report ID (18),         */
+	0x0A, 0x1A, 0x02,  /*    Usage (AC Undo),        */
+	0x0A, 0x6A, 0x02,  /*    Usage (AC Delete),      */
+	0x0A, 0x2D, 0x02,  /*    Usage (AC Zoom In),     */
+	0x0A, 0x2E, 0x02,  /*    Usage (AC Zoom Out),    */
+	0x14,              /*    Logical Minimum (0),    */
+	0x25, 0x01,        /*    Logical Maximum (1),    */
+	0x75, 0x01,        /*    Report Size (1),        */
+	0x95, 0x04,        /*    Report Count (4),       */
+	0x81, 0x02,        /*    Input (Variable),       */
+	0x95, 0x34,        /*    Report Count (52),      */
+	0x81, 0x01,        /*    Input (Constant),       */
+	0xC0               /*  End Collection            */
+};
+
+static const __u8 mousepen_m508x_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),        */
+	0x09, 0x01,        /*  Usage (Consumer Control),     */
+	0xA1, 0x01,        /*  Collection (Application),     */
+	0x85, 0x12,        /*    Report ID (18),             */
+	0x0A, 0x01, 0x02,  /*    Usage (AC New),             */
+	0x09, 0x40,        /*    Usage (Menu),               */
+	0x0A, 0x6A, 0x02,  /*    Usage (AC Delete),          */
+	0x0A, 0x1A, 0x02,  /*    Usage (AC Undo),            */
+	0x14,              /*    Logical Minimum (0),        */
+	0x25, 0x01,        /*    Logical Maximum (1),        */
+	0x75, 0x01,        /*    Report Size (1),            */
+	0x95, 0x04,        /*    Report Count (4),           */
+	0x81, 0x02,        /*    Input (Variable),           */
+	0x81, 0x01,        /*    Input (Constant),           */
+	0x15, 0xFF,        /*    Logical Minimum (-1),       */
+	0x95, 0x10,        /*    Report Count (16),          */
+	0x81, 0x01,        /*    Input (Constant),           */
+	0x0A, 0x35, 0x02,  /*    Usage (AC Scroll),          */
+	0x0A, 0x2F, 0x02,  /*    Usage (AC Zoom),            */
+	0x0A, 0x38, 0x02,  /*    Usage (AC Pan),             */
+	0x75, 0x08,        /*    Report Size (8),            */
+	0x95, 0x03,        /*    Report Count (3),           */
+	0x81, 0x06,        /*    Input (Variable, Relative), */
+	0x95, 0x01,        /*    Report Count (1),           */
+	0x81, 0x01,        /*    Input (Constant),           */
+	0xC0               /*  End Collection                */
+};
+
 static const __u8 easypen_m406xe_control_rdesc[] = {
 	0x05, 0x0C,        /*  Usage Page (Consumer),          */
 	0x09, 0x01,        /*  Usage (Consumer Control),       */
@@ -77,6 +193,22 @@ static const __u8 easypen_m406xe_control_rdesc[] = {
 	0xC0               /*  End Collection                  */
 };
 
+static const __u8 pensketch_t609a_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),    */
+	0x09, 0x01,        /*  Usage (Consumer Control), */
+	0xA1, 0x01,        /*  Collection (Application), */
+	0x85, 0x12,        /*    Report ID (18),         */
+	0x0A, 0x6A, 0x02,  /*    Usage (AC Delete),      */
+	0x14,              /*    Logical Minimum (0),    */
+	0x25, 0x01,        /*    Logical Maximum (1),    */
+	0x75, 0x01,        /*    Report Size (1),        */
+	0x95, 0x08,        /*    Report Count (8),       */
+	0x81, 0x02,        /*    Input (Variable),       */
+	0x95, 0x37,        /*    Report Count (55),      */
+	0x81, 0x01,        /*    Input (Constant),       */
+	0xC0               /*  End Collection            */
+};
+
 /* Fix indexes in kye_tablet_report_fixup if you change this */
 static const __u8 kye_tablet_rdesc[] = {
 	0x06, 0x00, 0xFF,             /*  Usage Page (FF00h),             */
@@ -189,21 +321,41 @@ static const struct kye_tablet_info {
 	unsigned int control_rsize;
 	const __u8 *control_rdesc;
 } kye_tablets_info[] = {
+	{USB_DEVICE_ID_KYE_EASYPEN_M406,  /* 0x5005 */
+		15360, 10240, 1023,    6,   4,  0, 0x13, false,
+		sizeof(easypen_m406_control_rdesc), easypen_m406_control_rdesc},
+	{USB_DEVICE_ID_KYE_EASYPEN_M506,  /* 0x500F */
+		24576, 20480, 1023,    6,   5,  0, 0x13, false,
+		sizeof(easypen_m506_control_rdesc), easypen_m506_control_rdesc},
 	{USB_DEVICE_ID_KYE_EASYPEN_I405X,  /* 0x5010 */
 		14080, 10240, 1023,   55,  40, -1, 0x13, false},
 	{USB_DEVICE_ID_KYE_MOUSEPEN_I608X,  /* 0x5011 */
 		20480, 15360, 2047,    8,   6,  0, 0x13,  true},
+	{USB_DEVICE_ID_KYE_EASYPEN_M406W,  /* 0x5012 */
+		15360, 10240, 1023,    6,   4,  0, 0x13, false,
+		sizeof(easypen_m406w_control_rdesc), easypen_m406w_control_rdesc},
 	{USB_DEVICE_ID_KYE_EASYPEN_M610X,  /* 0x5013 */
 		40960, 25600, 1023, 1000, 625, -2, 0x13, false,
 		sizeof(easypen_m610x_control_rdesc), easypen_m610x_control_rdesc},
+	{USB_DEVICE_ID_KYE_EASYPEN_340,  /* 0x5014 */
+		10240,  7680, 1023,    4,   3,  0, 0x13, false},
 	{USB_DEVICE_ID_KYE_PENSKETCH_M912,  /* 0x5015 */
 		61440, 46080, 2047,   12,   9,  0, 0x13,  true,
 		sizeof(pensketch_m912_control_rdesc), pensketch_m912_control_rdesc},
+	{USB_DEVICE_ID_KYE_MOUSEPEN_M508WX,  /* 0x5016 */
+		40960, 25600, 2047,    8,   5,  0, 0x13,  true,
+		sizeof(mousepen_m508wx_control_rdesc), mousepen_m508wx_control_rdesc},
+	{USB_DEVICE_ID_KYE_MOUSEPEN_M508X,  /* 0x5017 */
+		40960, 25600, 2047,    8,   5,  0, 0x13,  true,
+		sizeof(mousepen_m508x_control_rdesc), mousepen_m508x_control_rdesc},
 	{USB_DEVICE_ID_KYE_EASYPEN_M406XE,  /* 0x5019 */
 		15360, 10240, 1023,    6,   4,  0, 0x13, false,
 		sizeof(easypen_m406xe_control_rdesc), easypen_m406xe_control_rdesc},
 	{USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2,  /* 0x501A */
 		40960, 30720, 2047,    8,   6,  0, 0x13,  true},
+	{USB_DEVICE_ID_KYE_PENSKETCH_T609A,  /* 0x501B */
+		43520, 28160, 1023,   85,  55, -1, 0x13, false,
+		sizeof(pensketch_t609a_control_rdesc), pensketch_t609a_control_rdesc},
 	{}
 };
 
@@ -425,12 +577,19 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (hid_hw_open(hdev))
 			hid_hw_close(hdev);
 		break;
+	case USB_DEVICE_ID_KYE_EASYPEN_M406:
+	case USB_DEVICE_ID_KYE_EASYPEN_M506:
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
+	case USB_DEVICE_ID_KYE_EASYPEN_M406W:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
+	case USB_DEVICE_ID_KYE_EASYPEN_340:
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_M508WX:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
 	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
+	case USB_DEVICE_ID_KYE_PENSKETCH_T609A:
 		ret = kye_tablet_enable(hdev);
 		if (ret) {
 			hid_err(hdev, "tablet enabling failed\n");
@@ -454,18 +613,32 @@ static const struct hid_device_id kye_devices[] = {
 				USB_DEVICE_ID_GENIUS_MANTICORE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_EASYPEN_M406) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_EASYPEN_M506) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_I405X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_EASYPEN_M406W) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_EASYPEN_340) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_MOUSEPEN_M508WX) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_MOUSEPEN_M508X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_PENSKETCH_T609A) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, kye_devices);
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 479b377f686c..fdb75af75b53 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -105,11 +105,19 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M506), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_I405X), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406W), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_340), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_M508WX), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_M508X), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406XE), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_T609A), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019), HID_QUIRK_ALWAYS_POLL },
-- 
2.39.1

