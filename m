Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1516474C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLHQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLHQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:59:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F67680B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:59:09 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so2070069pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASRKRaXrVIIOkZO1WIOXBaqyzBqar9YDmRMNGtlTR7g=;
        b=F9SEm1rXTKd7sKeT3rZSAkqCyUcAEVmPRbNAQFQ/9Sx3d0S7kaXh1U83V2OAW2O+8y
         DnbWhxZcP0JOyKCqa67l+5okwUd6INAUxaArnjy3eqMR/vaYNWyS42ktlyzS661tOruv
         cxLRBi7Pa6Q7FPIZQmMfaD/lkRK59BnQFek+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASRKRaXrVIIOkZO1WIOXBaqyzBqar9YDmRMNGtlTR7g=;
        b=XyljyiajCAn1tJ7MYoHnFV9AMZbAgTC2FOSme5c6p7X3xSIu6iqJ2eoesZFniDsXQe
         qCXKieeqfac7AT9adpzgRIFpaEpMiivjsoq/cYKrjfztBtiKWk4A9VqG3OLxyXn8/4bR
         W19juhbh6rwxjfbjgaebLnf1kzD4qyVtjDfefS5xvHyhC3YS3epQ5aJrZQsgm+JlYfHA
         0M+dXG+nnIhCDC/ILl03bVkGeJJAnmFrVopHbkJOxSo35EoLBWVtVu4zbyvOJAWdRUEe
         Hby5sKIB+snJelcgLI0cnc/5HxXqg4GMe9VrI4En3KyC3FXblSvmIoXZ/3HMB+jtZ67O
         wO0w==
X-Gm-Message-State: ANoB5plJ4vmqdEabK+29Wby05cSS9/zJEp23OBuE2VvhrozoXFnOmhUn
        kjpYegs3jr8aKxN4FxMy1aFO5Q==
X-Google-Smtp-Source: AA0mqf5m4JmgZSGbe85/oxXWpGL20n55etjxV4/ljtbD3IXY6GVMut8BfJf1vkGHH5Y40WE9BYacbQ==
X-Received: by 2002:a17:902:ab97:b0:189:315f:1d40 with SMTP id f23-20020a170902ab9700b00189315f1d40mr2663330plr.69.1670518748522;
        Thu, 08 Dec 2022 08:59:08 -0800 (PST)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b00189b2b8dbedsm14944923plh.228.2022.12.08.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:59:07 -0800 (PST)
From:   Allen Ballway <ballway@chromium.org>
To:     dtor@chromium.org
Cc:     ballway@chromium.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org
Subject: [PATCH v2] HID: multitouch: Add quirks for flipped axes
Date:   Thu,  8 Dec 2022 16:58:36 +0000
Message-Id: <20221208165145.1.I69657e84c0606b2e5ccfa9fedbf42b7676a1e129@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <CAE_wzQ-WrjOgSADCn4v80ESwicOFif_Trn3Wrq=5toy2+y+q=g@mail.gmail.com>
References: <CAE_wzQ-WrjOgSADCn4v80ESwicOFif_Trn3Wrq=5toy2+y+q=g@mail.gmail.com>
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

This is fixed by adding device quirks to transform the touch points
into the correct spaces, from X -> MAX(X) - X, and Y -> MAX(Y) - Y.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---
V1 -> V2: Address review comments, change to use DMI match. Confirmed
MT_TOOL_X/Y require transformation and update orientation based on
flipped axes.

 drivers/hid/hid-multitouch.c | 72 +++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 91a4d3fc30e08..8a4f77e534a75 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -39,6 +39,7 @@
 #include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/timer.h>
+#include <linux/dmi.h>


 MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
@@ -71,6 +72,8 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_SEPARATE_APP_REPORT	BIT(19)
 #define MT_QUIRK_FORCE_MULTI_INPUT	BIT(20)
 #define MT_QUIRK_DISABLE_WAKEUP		BIT(21)
+#define MT_QUIRK_FLIP_X			BIT(22)
+#define MT_QUIRK_FLIP_Y			BIT(23)

 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -212,6 +215,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_GOOGLE				0x0111
 #define MT_CLS_RAZER_BLADE_STEALTH		0x0112
 #define MT_CLS_SMART_TECH			0x0113
+#define MT_CLS_ELAN_FLIPPED			0x0114

 #define MT_DEFAULT_MAXCONTACT	10
 #define MT_MAX_MAXCONTACT	250
@@ -396,9 +400,36 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_SEPARATE_APP_REPORT,
 	},
+	{ .name = MT_CLS_ELAN_FLIPPED,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_HOVERING |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_STICKY_FINGERS |
+			MT_QUIRK_WIN8_PTP_BUTTONS |
+			MT_QUIRK_FLIP_X |
+			MT_QUIRK_FLIP_Y,
+		.export_all_inputs = true },
+
 	{ }
 };

+/*
+ * This list contains devices which have specific issues based on the system
+ * they're on and not just the device itself.
+ */
+static const struct dmi_system_id mt_devices_dmi_override_table[] = {
+	{
+		.ident = "DynaBook K50/FR",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "dynabook K50/FR"),
+		},
+		.driver_data = (void *)MT_CLS_ELAN_FLIPPED,
+	},
+	{ }	/* Terminate list */
+};
+
 static ssize_t mt_show_quirks(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
@@ -1086,6 +1117,10 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		int orientation = wide;
 		int max_azimuth;
 		int azimuth;
+		int x;
+		int y;
+		int cx;
+		int cy;

 		if (slot->a != DEFAULT_ZERO) {
 			/*
@@ -1104,6 +1139,16 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			if (azimuth > max_azimuth * 2)
 				azimuth -= max_azimuth * 4;
 			orientation = -azimuth;
+
+			/* Orientation is inverted if the X or Y axes are
+			 * flipped, but normalized if both are inverted.
+			 */
+			if (quirks & (MT_QUIRK_FLIP_X | MT_QUIRK_FLIP_Y) &&
+			    !((quirks & MT_QUIRK_FLIP_X)
+			      && (quirks & MT_QUIRK_FLIP_Y))) {
+				orientation = -orientation;
+			}
+
 		}

 		if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
@@ -1115,10 +1160,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			minor = minor >> 1;
 		}

-		input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
-		input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
-		input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
-		input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
+		x = quirks & MT_QUIRK_FLIP_X ?
+			input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x :
+			*slot->x;
+		y = quirks & MT_QUIRK_FLIP_Y ?
+			input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->y :
+			*slot->y;
+		cx = quirks & MT_QUIRK_FLIP_X ?
+			input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->cx :
+			*slot->cx;
+		cy = quirks & MT_QUIRK_FLIP_Y ?
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
@@ -1711,9 +1769,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret, i;
 	struct mt_device *td;
 	const struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
+	const struct dmi_system_id *system_id
+			= dmi_first_match(mt_devices_dmi_override_table);
+	const long driver_data_name = system_id ?
+			(long)(system_id->driver_data) : id->driver_data;

 	for (i = 0; mt_classes[i].name ; i++) {
-		if (id->driver_data == mt_classes[i].name) {
+		if (driver_data_name == mt_classes[i].name) {
 			mtclass = &(mt_classes[i]);
 			break;
 		}
--
2.39.0.rc1.256.g54fd8350bd-goog

