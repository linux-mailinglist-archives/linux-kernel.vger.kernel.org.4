Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB264ACB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiLMBBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiLMBBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:01:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66161115
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:01:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so13924435plk.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XnFLNyU+f87H6FII1iBQ7OGHIR5aH7bhoxNua0BSvc=;
        b=IEwsHkAMSvqwSKxJanDbH1FYkNgyVXROZc1wRHuqToUiP44PQW0PnNv7/fXGFhndr4
         z4hWVzHYSHqoIApOgZFXypROlR7Xs5kvHF7CCJ+aUBdHgIqmZC+9+J7z+tr4xiBhK/EL
         4TTEG4IOlEYxqjgyl4Hu6orngOL+oEQlHuqGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XnFLNyU+f87H6FII1iBQ7OGHIR5aH7bhoxNua0BSvc=;
        b=d6CBekeGxKrb6aV3zEYG+ckBo9RF+UF+5Ei+cRJL0gRSx7MiUAzc+g+fpGgLNw2jaj
         wJOJga4/lD6Vp0EvW0tB9emvXvIqNn84bCzl6+W3Lc9KtdBqOdNLJR11qTl+2iGrJ2mo
         qBPemCG636v3LrAyg0/BadrTprVdEg7owsLm565Stg3TImbaNYNlppyrw6Ay0Hs8HG1s
         jVRDpaKy9SxKTbO+s3avlZFaZ62ezPsHHhSgxKhSut7fLF1jkOVU70jo//7gZvlia9uD
         Jleuq1YyWn3tjCKysL1v3OOq8RocnfRTKEgVtf8D3zQzJ05z0Z7RrnpJySzkOzwkoHdZ
         xl+g==
X-Gm-Message-State: ANoB5pl3n4FPUSr1Ufd1L6w+PavrltRJG4VcD3R/Y54nvU40K+bPR2ZA
        1ImuRh83p3idKcxXclVNDRdGrQ==
X-Google-Smtp-Source: AA0mqf72s4Gw6+slWR3v0poPoBVzXDtwVYrTM/mNVX1zRboII6F2SKPoRkONon2GNkXBcOnBqiiM3g==
X-Received: by 2002:a05:6a20:28a0:b0:ad:58d4:2a7a with SMTP id q32-20020a056a2028a000b000ad58d42a7amr11270896pzf.22.1670893292214;
        Mon, 12 Dec 2022 17:01:32 -0800 (PST)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b00186a2274382sm7022104plb.76.2022.12.12.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 17:01:31 -0800 (PST)
From:   Allen Ballway <ballway@chromium.org>
To:     dmitry.torokhov@gmail.com
Cc:     ballway@chromium.org, benjamin.tissoires@redhat.com,
        dtor@chromium.org, jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org
Subject: [PATCH v3] HID: multitouch: Add quirks for flipped axes
Date:   Tue, 13 Dec 2022 01:01:12 +0000
Message-Id: <20221213010112.3394537-1-ballway@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <Y5d29JwIxku9ubVb@google.com>
References: <Y5d29JwIxku9ubVb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain touchscreen devices, such as the ELAN9034, are oriented
incorrectly and report touches on opposite points on the X and Y axes.
For example, a 100x200 screen touched at (10,20) would report (90, 180)
and vice versa.

This changed fixes the issue by adding device quirks to transform
the touch points into the correct spaces, from X -> MAX(X) - X,
and Y -> MAX(Y) - Y. These quirks are added in hid-quirks checking
both DMI information and device vendor and product IDs. The quirk
is handled in hid-multitouch to do the actual transformation.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---
V2 -> V3: Use existing HID_QUIRK_*_INVERT and match the quirk in
hid-quirk, passing down to hid-multitouch through the hid device.

V1 -> V2: Address review comments, change to use DMI match. Confirmed
MT_TOOL_X/Y require transformation and update orientation based on
flipped axes.


 drivers/hid/hid-multitouch.c | 43 ++++++++++++++++++++++++++++++++----
 drivers/hid/hid-quirks.c     | 33 +++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 91a4d3fc30e08..1f4c2aa511359 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -71,6 +71,8 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_SEPARATE_APP_REPORT	BIT(19)
 #define MT_QUIRK_FORCE_MULTI_INPUT	BIT(20)
 #define MT_QUIRK_DISABLE_WAKEUP		BIT(21)
+#define MT_QUIRK_X_INVERT		BIT(22)
+#define MT_QUIRK_Y_INVERT		BIT(23)

 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
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
@@ -1104,6 +1110,16 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			if (azimuth > max_azimuth * 2)
 				azimuth -= max_azimuth * 4;
 			orientation = -azimuth;
+
+			/* Orientation is inverted if the X or Y axes are
+			 * flipped, but normalized if both are inverted.
+			 */
+			if (quirks & (MT_QUIRK_X_INVERT | MT_QUIRK_Y_INVERT) &&
+			    !((quirks & MT_QUIRK_X_INVERT)
+			      && (quirks & MT_QUIRK_Y_INVERT))) {
+				orientation = -orientation;
+			}
+
 		}

 		if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
@@ -1115,10 +1131,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			minor = minor >> 1;
 		}

-		input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
-		input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
-		input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
-		input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
+		x = quirks & MT_QUIRK_X_INVERT ?
+			input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x :
+			*slot->x;
+		y = quirks & MT_QUIRK_Y_INVERT ?
+			input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->y :
+			*slot->y;
+		cx = quirks & MT_QUIRK_X_INVERT ?
+			input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->cx :
+			*slot->cx;
+		cy = quirks & MT_QUIRK_Y_INVERT ?
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
@@ -1735,6 +1764,12 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
 		td->serial_maybe = true;

+	if (hdev->quirks & HID_QUIRK_X_INVERT)
+		td->mtclass.quirks |= MT_QUIRK_X_INVERT;
+
+	if (hdev->quirks & HID_QUIRK_Y_INVERT)
+		td->mtclass.quirks |= MT_QUIRK_Y_INVERT;
+
 	/* This allows the driver to correctly support devices
 	 * that emit events over several HID messages.
 	 */
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 0e9702c7f7d6c..47c6cd62f019a 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/dmi.h>
 #include <linux/input/elan-i2c-ids.h>

 #include "hid-ids.h"
@@ -957,6 +958,29 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
 	{ }
 };

+static const struct hid_device_id elan_flipped_quirks[] = {
+	{ HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, USB_VENDOR_ID_ELAN, 0x2dcd),
+		HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT },
+	{ }
+};
+
+/*
+ * This list contains devices which have specific issues based on the system
+ * they're on and not just the device itself. The driver_data will have a
+ * specific hid device to match against.
+ */
+static const struct dmi_system_id dmi_override_table[] = {
+	{
+		.ident = "DynaBook K50/FR",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "dynabook K50/FR"),
+		},
+		.driver_data = (void *)elan_flipped_quirks,
+	},
+	{ }	/* Terminate list */
+};
+
 bool hid_ignore(struct hid_device *hdev)
 {
 	int i;
@@ -1238,6 +1262,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
 {
 	const struct hid_device_id *bl_entry;
 	unsigned long quirks = 0;
+	const struct dmi_system_id *system_id;

 	if (hid_match_id(hdev, hid_ignore_list))
 		quirks |= HID_QUIRK_IGNORE;
@@ -1249,6 +1274,14 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
 	if (bl_entry != NULL)
 		quirks |= bl_entry->driver_data;

+	system_id = dmi_first_match(dmi_override_table);
+	if (system_id != NULL) {
+		bl_entry = hid_match_id(hdev, system_id->driver_data);
+		if (bl_entry != NULL)
+			quirks |= bl_entry->driver_data;
+	}
+
+
 	if (quirks)
 		dbg_hid("Found squirk 0x%lx for HID device 0x%04x:0x%04x\n",
 			quirks, hdev->vendor, hdev->product);
--
2.39.0.rc1.256.g54fd8350bd-goog

