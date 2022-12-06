Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5334F644A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiLFRlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiLFRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:40:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D73C6ED
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:39:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso18737433pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=973PYywfBJwx+1YHGPEQhiaFBM29rwzirc5WG9+xT+I=;
        b=AEComhb/RlxEk4aTrp+LmK6kUTtYReRjP+2zbl0PND/NKS2PmCM9qlMAfr1Ka9o/ir
         YHtadcFo7hR+s5sW9B3Ip99PLCo8cilwNCZWcdLIXuKrFClTiAOoSLUMmMnSOhmLZdxK
         +sIjlFXDPGHbma3GhrGLGW5UaYuJQOU4Q1hZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=973PYywfBJwx+1YHGPEQhiaFBM29rwzirc5WG9+xT+I=;
        b=tqAeJgGeToicpduE70js6O/KgoEsPjhA9wGz9Y94yhAUhmir6XtNawbTUbZKsMxsiP
         fvLD5cwRg5Up3u5dtAn1+Yfy4F1f+tznMkaOgJIFBZTFmzZ6WxwWNNbo6N/8Yo8qtKvb
         S4eDYanf5r87lOzIAMiHQCWjultSO3lcRZqElHwKsji58seoUKP5OJr40x/0JnY0vFJM
         rxobzJpsDn6QRSbP61UrHQgx5LMr5o5KWE7hKytIF36cXRwAeUthHTMJRJzewNPTLdPq
         hhHSMA9Qk4ZNq0U4xG8so688SO+423SuZRll1BpLd1J5PrnrPh3o5zyxmNLFHsfdWLlr
         /ghQ==
X-Gm-Message-State: ANoB5pm8LJ+UTrX6hXz8ztq6TjHj25u2fT0PmvGRaT+J8d9KbqH8ojgU
        MtkFlIL2pLE5aIN9INInrK12MCS+sB3iCUAl
X-Google-Smtp-Source: AA0mqf73xZWg2CmIRkzo10HbSDdlWsVdYDyGiq9A4LURVqFGRJVT93ZOx9BYyXjm5shhDMmPeIhYPQ==
X-Received: by 2002:a17:90b:19c8:b0:219:aa6a:4fa3 with SMTP id nm8-20020a17090b19c800b00219aa6a4fa3mr17634612pjb.9.1670348352814;
        Tue, 06 Dec 2022 09:39:12 -0800 (PST)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id b16-20020aa79510000000b00574f83c5d51sm12007886pfp.198.2022.12.06.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:39:12 -0800 (PST)
From:   Allen Ballway <ballway@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Allen Ballway <ballway@chromium.org>
Subject: [PATCH] HID: multitouch: Add quirks for flipped axes
Date:   Tue,  6 Dec 2022 17:38:52 +0000
Message-Id: <20221206173819.1.I69657e84c0606b2e5ccfa9fedbf42b7676a1e129@changeid>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
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

 drivers/hid/hid-multitouch.c | 46 ++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 91a4d3fc30e08..5e14cc4b00f53 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -71,6 +71,8 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_SEPARATE_APP_REPORT	BIT(19)
 #define MT_QUIRK_FORCE_MULTI_INPUT	BIT(20)
 #define MT_QUIRK_DISABLE_WAKEUP		BIT(21)
+#define MT_QUIRK_FLIP_X			BIT(22)
+#define MT_QUIRK_FLIP_Y			BIT(23)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -212,6 +214,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_GOOGLE				0x0111
 #define MT_CLS_RAZER_BLADE_STEALTH		0x0112
 #define MT_CLS_SMART_TECH			0x0113
+#define MT_CLS_ELAN_FLIPPED			0x0114
 
 #define MT_DEFAULT_MAXCONTACT	10
 #define MT_MAX_MAXCONTACT	250
@@ -396,6 +399,17 @@ static const struct mt_class mt_classes[] = {
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
 
@@ -1115,10 +1129,30 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			minor = minor >> 1;
 		}
 
-		input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
-		input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
-		input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
-		input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
+		if (quirks & MT_QUIRK_FLIP_X) {
+			/* Inputs with a flipped X axis need to report MAX - X */
+			int x = input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x;
+			int cx = input_abs_get_max(input, ABS_MT_TOOL_X) - *slot->cx;
+
+			input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
+			input_event(input, EV_ABS, ABS_MT_TOOL_X, cx);
+		} else {
+			input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
+			input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
+		}
+
+		if (quirks & MT_QUIRK_FLIP_Y) {
+			/* Inputs with a flipped Y axis need to report MAX - Y */
+			int y = input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->y;
+			int cy = input_abs_get_max(input, ABS_MT_TOOL_Y) - *slot->cy;
+
+			input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
+			input_event(input, EV_ABS, ABS_MT_TOOL_Y, cy);
+		} else {
+			input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
+			input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
+		}
+
 		input_event(input, EV_ABS, ABS_MT_DISTANCE, !*slot->tip_state);
 		input_event(input, EV_ABS, ABS_MT_ORIENTATION, orientation);
 		input_event(input, EV_ABS, ABS_MT_PRESSURE, *slot->p);
@@ -1963,6 +1997,10 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
 
 	/* Elan devices */
+	{ .driver_data = MT_CLS_ELAN_FLIPPED,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ELAN, 0x2dcd) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ELAN, 0x313a) },
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

