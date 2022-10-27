Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2561610427
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiJ0VMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiJ0VMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:12:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4743E6C;
        Thu, 27 Oct 2022 14:10:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l14so4283585wrw.2;
        Thu, 27 Oct 2022 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmZ4UM9gwFVK7UrOAVwPtX2b4XuKmYZPMX1b8CmgQhc=;
        b=SmhtCM5EZyNGsb9vtdjGzpL3+rw7NGrhdifeQ+WA/eNH8CkWctSMtN2PsDXW4RjLv3
         QfiZQerthmDJYE6PoBYehciGnA3Bw82ucVuvr//e9RUENbq579DQrqYP5Qe21NrQRJGJ
         mVY7gcldnQcmuoKlT61pIoZZNei5C3cCbxafXMXYL9Cq6W121Po5NSVpJe2H7J/m8QoY
         fv42XrNOaBjX9PhPvrsu1mRL1FJ3lmoHvAcqCi0bmB7hIvdQO6u8tYMyFfhZiP/iemr7
         xj2+3JkQ3llqlIXtqKfVt/BGk2kBDkdOz2VWC9AjYZD/ETpfhL2s/AOVCVZd1aEW8dVU
         JK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmZ4UM9gwFVK7UrOAVwPtX2b4XuKmYZPMX1b8CmgQhc=;
        b=r/XqCBWWRq5z0EOWeAw+VAvGNoLasnAtDPTfHEQ++a4HJuEaF+XaMUpWb61XlQJem/
         bqmmBF5X3mc7EvEQwVSsgI5AE8c9UGW1ZSh7y08zwX7JNsXovKdKWKBR4zxi8+yjotLV
         VK8PChQK3cJSG++zrDVPczxAUGArlK3b147P8Kjm6fKZZVR9KdmCAoQQKsm3JnQ2LkA/
         pY6UBE+ks8KpggLfmZfwQng39MFI2LEBZVuCNv4rTKOH1+/wXapq1ru9VZ8o0q5GLHd9
         uiXzAnAK8IVNmt8C2nedqob7NrhDWlb00rvtvbUHFOFDhkIP12YC4jv7LfjH6r1E3HoY
         sTRw==
X-Gm-Message-State: ACrzQf3HyEPrqGPEgOWPuYWDMe7impkVhuwKXoHrEXvjIkt3k0Z+42aX
        0qRVVeqZdES48dWtmBA/gjZhNelE3HYpQg==
X-Google-Smtp-Source: AMsMyM7ROBWLHszmuRHPvDoBGhGTUhxzner3L8KoVpYT5BWc5tDTSt85LkdyCxeUawCxpgfLPRX3gA==
X-Received: by 2002:adf:c5c4:0:b0:236:87bc:a8fa with SMTP id v4-20020adfc5c4000000b0023687bca8famr8199870wrg.151.1666905036129;
        Thu, 27 Oct 2022 14:10:36 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id ba5-20020a0560001c0500b002364835caacsm2118547wrb.112.2022.10.27.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:10:35 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: [PATCH] HID: uclogic: Add support for XP-PEN Deco LW
Date:   Thu, 27 Oct 2022 23:10:21 +0200
Message-Id: <20221027211021.230325-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XP-PEN Deco LW is a UGEE v2 device with a frame with 8 buttons.
Its pen has 2 buttons, supports tilt and pressure.

It can be connected by USB cable or using a USB Bluetooth dongle to use
it in wireless mode. When it is connected using the dongle, the device
battery is used to power it.

Its vendor, product and version are identical to the Deco L. The only
difference reported by their firmware is the product name.
In order to add support for battery reporting, add a new HID descriptor
and a quirk to detect the wireless version of the tablet.

Link: https://github.com/DIGImend/digimend-kernel-drivers/issues/635
Tested-by: Mia Kanashi <chad@redpilled.dev>
Tested-by: Andreas Grosse <andig.mail@t-online.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 73 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 34 +++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  7 +++
 3 files changed, 114 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 34fa991e6267..88b328d4dcec 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1211,6 +1211,70 @@ static int uclogic_params_ugee_v2_init_frame_mouse(struct uclogic_params *p)
 	return rc;
 }
 
+/**
+ * uclogic_params_ugee_v2_has_battery() - check whether a UGEE v2 device has
+ * battery or not.
+ * @hdev:	The HID device of the tablet interface.
+ *
+ * Returns:
+ *	True if the device has battery, false otherwise.
+ */
+static bool uclogic_params_ugee_v2_has_battery(struct hid_device *hdev)
+{
+	/* The XP-PEN Deco LW vendor, product and version are identical to the
+	 * Deco L. The only difference reported by their firmware is the product
+	 * name. Add a quirk to support battery reporting on the wireless
+	 * version.
+	 */
+	if (hdev->vendor == USB_VENDOR_ID_UGEE &&
+	    hdev->product == USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) {
+		struct usb_device *udev = hid_to_usb_dev(hdev);
+		const char *lw_name = "Deco LW";
+
+		if (strncmp(udev->product, lw_name, strlen(lw_name)) == 0)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * uclogic_params_ugee_v2_init_battery() - initialize UGEE v2 battery reporting.
+ * @hdev:	The HID device of the tablet interface, cannot be NULL.
+ * @p:		Parameters to fill in, cannot be NULL.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init_battery(struct hid_device *hdev,
+					       struct uclogic_params *p)
+{
+	int rc = 0;
+
+	if (!hdev || !p)
+		return -EINVAL;
+
+	/* Some tablets contain invalid characters in hdev->uniq, throwing a
+	 * "hwmon: '<name>' is not a valid name attribute, please fix" error.
+	 * Use the device vendor and product IDs instead.
+	 */
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%x-%x", hdev->vendor,
+		 hdev->product);
+
+	rc = uclogic_params_frame_init_with_desc(&p->frame_list[1],
+						 uclogic_rdesc_ugee_v2_battery_template_arr,
+						 uclogic_rdesc_ugee_v2_battery_template_size,
+						 UCLOGIC_RDESC_UGEE_V2_BATTERY_ID);
+	if (rc)
+		return rc;
+
+	p->frame_list[1].suffix = "Battery";
+	p->pen.subreport_list[1].value = 0xf2;
+	p->pen.subreport_list[1].id = UCLOGIC_RDESC_UGEE_V2_BATTERY_ID;
+
+	return rc;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1334,6 +1398,15 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	if (rc)
 		goto cleanup;
 
+	/* Initialize the battery interface*/
+	if (uclogic_params_ugee_v2_has_battery(hdev)) {
+		rc = uclogic_params_ugee_v2_init_battery(hdev, &p);
+		if (rc) {
+			hid_err(hdev, "error initializing battery: %d\n", rc);
+			goto cleanup;
+		}
+	}
+
 output:
 	/* Output parameters */
 	memcpy(params, &p, sizeof(*params));
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 4bd54c4fb5b0..6524b4b61b25 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -1035,6 +1035,40 @@ const __u8 uclogic_rdesc_ugee_v2_frame_mouse_template_arr[] = {
 const size_t uclogic_rdesc_ugee_v2_frame_mouse_template_size =
 			sizeof(uclogic_rdesc_ugee_v2_frame_mouse_template_arr);
 
+/* Fixed report descriptor template for UGEE v2 battery reports */
+const __u8 uclogic_rdesc_ugee_v2_battery_template_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),                   */
+	0x09, 0x07,         /*  Usage (Keypad),                         */
+	0xA1, 0x01,         /*  Collection (Application),               */
+	0x85, UCLOGIC_RDESC_UGEE_V2_BATTERY_ID,
+			    /*      Report ID,                          */
+	0x75, 0x08,         /*      Report Size (8),                    */
+	0x95, 0x02,         /*      Report Count (2),                   */
+	0x81, 0x01,         /*      Input (Constant),                   */
+	0x05, 0x84,         /*      Usage Page (Power Device),          */
+	0x05, 0x85,         /*      Usage Page (Battery System),        */
+	0x09, 0x65,         /*      Usage Page (AbsoluteStateOfCharge), */
+	0x75, 0x08,         /*      Report Size (8),                    */
+	0x95, 0x01,         /*      Report Count (1),                   */
+	0x15, 0x00,         /*      Logical Minimum (0),                */
+	0x26, 0xff, 0x00,   /*      Logical Maximum (255),              */
+	0x81, 0x02,         /*      Input (Variable),                   */
+	0x75, 0x01,         /*      Report Size (1),                    */
+	0x95, 0x01,         /*      Report Count (1),                   */
+	0x15, 0x00,         /*      Logical Minimum (0),                */
+	0x25, 0x01,         /*      Logical Maximum (1),                */
+	0x09, 0x44,         /*      Usage Page (Charging),              */
+	0x81, 0x02,         /*      Input (Variable),                   */
+	0x95, 0x07,         /*      Report Count (7),                   */
+	0x81, 0x01,         /*      Input (Constant),                   */
+	0x75, 0x08,         /*      Report Size (8),                    */
+	0x95, 0x07,         /*      Report Count (7),                   */
+	0x81, 0x01,         /*      Input (Constant),                   */
+	0xC0                /*  End Collection                          */
+};
+const size_t uclogic_rdesc_ugee_v2_battery_template_size =
+			sizeof(uclogic_rdesc_ugee_v2_battery_template_arr);
+
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 0502a0656496..a1f78c07293f 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -161,6 +161,9 @@ extern const size_t uclogic_rdesc_v2_frame_dial_size;
 /* Device ID byte offset in v2 frame dial reports */
 #define UCLOGIC_RDESC_V2_FRAME_DIAL_DEV_ID_BYTE	0x4
 
+/* Report ID for tweaked UGEE v2 battery reports */
+#define UCLOGIC_RDESC_UGEE_V2_BATTERY_ID 0xba
+
 /* Fixed report descriptor template for UGEE v2 pen reports */
 extern const __u8 uclogic_rdesc_ugee_v2_pen_template_arr[];
 extern const size_t uclogic_rdesc_ugee_v2_pen_template_size;
@@ -177,6 +180,10 @@ extern const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size;
 extern const __u8 uclogic_rdesc_ugee_v2_frame_mouse_template_arr[];
 extern const size_t uclogic_rdesc_ugee_v2_frame_mouse_template_size;
 
+/* Fixed report descriptor template for UGEE v2 battery reports */
+extern const __u8 uclogic_rdesc_ugee_v2_battery_template_arr[];
+extern const size_t uclogic_rdesc_ugee_v2_battery_template_size;
+
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

