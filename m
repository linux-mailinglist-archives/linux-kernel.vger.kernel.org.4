Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994BA64DF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiLOR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiLOR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:26:55 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0C92AE38
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:26:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so7553531plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZtOedLV/QlyXTghqPz+ASgSdVaeqyqAQ4U3JRPc5GU=;
        b=i+WKoSrnH8ita2jterSOZ0Hd1U94TBZC3RiGtrtyxQHAgF3sFT3O2l0g+tcEgYKDGF
         LcpH8ECS98fZw9T6bDccQJEQ49nLgAl41QluIBA/w4yePbXvEvX0tnh5mOQFl4QZ3BBP
         sUXi2E5vIb+qd8S10yGsneb5r6gekVMLo8K60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZtOedLV/QlyXTghqPz+ASgSdVaeqyqAQ4U3JRPc5GU=;
        b=ufa1wfkaTk1Rw4ynw2AAA/5lCkA5hZ3D23nW+hPfS6nvwIKJmbe2tqKb8yWyzPltVA
         19RmwvOOhaRI2NAOsPBVwu3s9u7y30WVSAr/hkJzWEvEeep+nzdc2ZdqjKG0w/93qeTG
         FXNPw+uT1bn6ckH2CzZPktQRnQ/byCXk89+ZRYBdsMaQG2dYhPpK7+KgeJmyxz+TDVNX
         dNE+B/qm7QoF65g6kNuwpPHz4I+ie7RKB5aVHhEwmEge/pZGW/14kH/RjW5pRDtkmptF
         wWFTfJNr6yDl1wjdUtzcTXOT0sHNJjXxZ23DlptI1iM2txnqPOL62oyXxVn8CMMqYHeO
         Vkqw==
X-Gm-Message-State: ANoB5pmy0FM19q+BoVA4NStyTk+YKoSITnl983P/u0I5+xcPlaAw5dHl
        MJoeXHiEXfb4ywDfpzJGwA7W6w==
X-Google-Smtp-Source: AA0mqf5Jn2JphekoKOtk/pdStxxBBRBF+vfe1kHyk1gZeBtrLsXy6YSUME9j8Nszia7L80YR0qk+3g==
X-Received: by 2002:a05:6a20:6d9f:b0:af:7d08:6703 with SMTP id gl31-20020a056a206d9f00b000af7d086703mr6218942pzb.27.1671125214242;
        Thu, 15 Dec 2022 09:26:54 -0800 (PST)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id m9-20020a654389000000b0047696938911sm1844761pgp.74.2022.12.15.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 09:26:53 -0800 (PST)
From:   Allen Ballway <ballway@chromium.org>
To:     ballway@chromium.org
Cc:     benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        dtor@chromium.org, jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org
Subject: [PATCH v6] HID: multitouch: Add quirks for flipped axes
Date:   Thu, 15 Dec 2022 17:26:44 +0000
Message-Id: <20221215172644.688044-1-ballway@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221214234531.508881-1-ballway@chromium.org>
References: <20221214234531.508881-1-ballway@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain touchscreen devices, such as the ELAN9034, are oriented
incorrectly and report touches on opposite points on the X and Y axes.
For example, a 100x200 screen touched at (10,20) would report (90, 180)
and vice versa.

This is fixed by adding device quirks to transform the touch points
into the correct spaces, from X -> MAX(X) - X, and Y -> MAX(Y) - Y.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---
V5 -> V6: Add another IS_ENABLED check for CONFIG_I2C_DMI_CORE because
the module may not be there at all.

V4 -> V5: Add IS_ENABLED check for CONFIG_DMI to prevent linker error.

V3 -> V4: Move quirk logic to i2c_hid_get_dmi_quirks and remove
duplicate quirks from hid-multitouch.

V2 -> V3: Use existing HID_QUIRK_*_INVERT and match the quirk in
hid-quirk, passing down to hid-multitouch through the hid device.

V1 -> V2: Address review comments, change to use DMI match. Confirmed
MT_TOOL_X/Y require transformation and update orientation based on
flipped axes.


 drivers/hid/hid-multitouch.c             | 39 ++++++++++++++++++---
 drivers/hid/hid-quirks.c                 |  6 ++++
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 43 ++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h            |  3 ++
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 91a4d3fc30e08..622fe6928104c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -71,6 +71,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_SEPARATE_APP_REPORT	BIT(19)
 #define MT_QUIRK_FORCE_MULTI_INPUT	BIT(20)
 #define MT_QUIRK_DISABLE_WAKEUP		BIT(21)
+#define MT_QUIRK_ORIENTATION_INVERT	BIT(22)

 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -1009,6 +1010,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			    struct mt_usages *slot)
 {
 	struct input_mt *mt = input->mt;
+	struct hid_device *hdev = td->hdev;
 	__s32 quirks = app->quirks;
 	bool valid = true;
 	bool confidence_state = true;
@@ -1086,6 +1088,10 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		int orientation = wide;
 		int max_azimuth;
 		int azimuth;
+		int x;
+		int y;
+		int cx;
+		int cy;

 		if (slot->a != DEFAULT_ZERO) {
 			/*
@@ -1104,6 +1110,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			if (azimuth > max_azimuth * 2)
 				azimuth -= max_azimuth * 4;
 			orientation = -azimuth;
+			if (quirks & MT_QUIRK_ORIENTATION_INVERT)
+				orientation = -orientation;
+
 		}

 		if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
@@ -1115,10 +1124,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			minor = minor >> 1;
 		}

-		input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
-		input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
-		input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
-		input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
+		x = hdev->quirks & HID_QUIRK_X_INVERT ?
+			input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x :
+			*slot->x;
+		y = hdev->quirks & HID_QUIRK_Y_INVERT ?
+			input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->y :
+			*slot->y;
+		cx = hdev->quirks & HID_QUIRK_X_INVERT ?
+			input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->cx :
+			*slot->cx;
+		cy = hdev->quirks & HID_QUIRK_Y_INVERT ?
+			input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->cy :
+			*slot->cy;
+
+		input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
+		input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
+		input_event(input, EV_ABS, ABS_MT_TOOL_X, cx);
+		input_event(input, EV_ABS, ABS_MT_TOOL_Y, cy);
 		input_event(input, EV_ABS, ABS_MT_DISTANCE, !*slot->tip_state);
 		input_event(input, EV_ABS, ABS_MT_ORIENTATION, orientation);
 		input_event(input, EV_ABS, ABS_MT_PRESSURE, *slot->p);
@@ -1735,6 +1757,15 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
 		td->serial_maybe = true;

+
+	/* Orientation is inverted if the X or Y axes are
+	 * flipped, but normalized if both are inverted.
+	 */
+	if (hdev->quirks & (HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT) &&
+	    !((hdev->quirks & HID_QUIRK_X_INVERT)
+	      && (hdev->quirks & HID_QUIRK_Y_INVERT)))
+		td->mtclass.quirks = MT_QUIRK_ORIENTATION_INVERT;
+
 	/* This allows the driver to correctly support devices
 	 * that emit events over several HID messages.
 	 */
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 0e9702c7f7d6c..78452faf3c9b4 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -19,6 +19,7 @@
 #include <linux/input/elan-i2c-ids.h>

 #include "hid-ids.h"
+#include "i2c-hid/i2c-hid.h"

 /*
  * Alphabetically sorted by vendor then product.
@@ -1298,6 +1299,11 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev)
 		quirks = hid_gets_squirk(hdev);
 	mutex_unlock(&dquirks_lock);

+	/* Get quirks specific to I2C devices */
+	if (IS_ENABLED(CONFIG_I2C_DMI_CORE) && IS_ENABLED(CONFIG_DMI) &&
+	    hdev->bus == BUS_I2C)
+		quirks |= i2c_hid_get_dmi_quirks(hdev->vendor, hdev->product);
+
 	return quirks;
 }
 EXPORT_SYMBOL_GPL(hid_lookup_quirk);
diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 8e0f67455c098..554a7dc285365 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -10,8 +10,10 @@
 #include <linux/types.h>
 #include <linux/dmi.h>
 #include <linux/mod_devicetable.h>
+#include <linux/hid.h>

 #include "i2c-hid.h"
+#include "../hid-ids.h"


 struct i2c_hid_desc_override {
@@ -416,6 +418,28 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 	{ }	/* Terminate list */
 };

+static const struct hid_device_id i2c_hid_elan_flipped_quirks = {
+	HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, USB_VENDOR_ID_ELAN, 0x2dcd),
+		HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT
+};
+
+/*
+ * This list contains devices which have specific issues based on the system
+ * they're on and not just the device itself. The driver_data will have a
+ * specific hid device to match against.
+ */
+static const struct dmi_system_id i2c_hid_dmi_quirk_table[] = {
+	{
+		.ident = "DynaBook K50/FR",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "dynabook K50/FR"),
+		},
+		.driver_data = (void *)&i2c_hid_elan_flipped_quirks,
+	},
+	{ }	/* Terminate list */
+};
+

 struct i2c_hid_desc *i2c_hid_get_dmi_i2c_hid_desc_override(uint8_t *i2c_name)
 {
@@ -450,3 +474,22 @@ char *i2c_hid_get_dmi_hid_report_desc_override(uint8_t *i2c_name,
 	*size = override->hid_report_desc_size;
 	return override->hid_report_desc;
 }
+
+u32 i2c_hid_get_dmi_quirks(const u16 vendor, const u16 product)
+{
+	u32 quirks = 0;
+	const struct dmi_system_id *system_id =
+			dmi_first_match(i2c_hid_dmi_quirk_table);
+
+	if (system_id) {
+		const struct hid_device_id *device_id =
+				(struct hid_device_id *)(system_id->driver_data);
+
+		if (device_id && device_id->vendor == vendor &&
+		    device_id->product == product)
+			quirks = device_id->driver_data;
+	}
+
+	return quirks;
+}
+EXPORT_SYMBOL_GPL(i2c_hid_get_dmi_quirks);
diff --git a/drivers/hid/i2c-hid/i2c-hid.h b/drivers/hid/i2c-hid/i2c-hid.h
index 96c75510ad3f1..2c7b66d5caa0f 100644
--- a/drivers/hid/i2c-hid/i2c-hid.h
+++ b/drivers/hid/i2c-hid/i2c-hid.h
@@ -9,6 +9,7 @@
 struct i2c_hid_desc *i2c_hid_get_dmi_i2c_hid_desc_override(uint8_t *i2c_name);
 char *i2c_hid_get_dmi_hid_report_desc_override(uint8_t *i2c_name,
 					       unsigned int *size);
+u32 i2c_hid_get_dmi_quirks(const u16 vendor, const u16 product);
 #else
 static inline struct i2c_hid_desc
 		   *i2c_hid_get_dmi_i2c_hid_desc_override(uint8_t *i2c_name)
@@ -16,6 +17,8 @@ static inline struct i2c_hid_desc
 static inline char *i2c_hid_get_dmi_hid_report_desc_override(uint8_t *i2c_name,
 							     unsigned int *size)
 { return NULL; }
+static inline u32 i2c_hid_get_dmi_quirks(const u16 vendor, const u16 product)
+{ return 0; }
 #endif

 /**
--
2.39.0.rc1.256.g54fd8350bd-goog

