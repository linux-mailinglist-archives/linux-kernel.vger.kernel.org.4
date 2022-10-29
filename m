Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD256122C0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ2MFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJ2ME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62113DFA;
        Sat, 29 Oct 2022 05:04:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so9742877wrh.1;
        Sat, 29 Oct 2022 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0H3gS6ENUsKWeShTc04Oxh9TJLnxL4twvq+6xgLItU=;
        b=qmjvl3YwbZ9mkYjbQnkigZC7V3qmEQ2UkKRzeSCA2PEwioQMDglgswpCaUnqSfH9Xc
         3j5TVf51w7mEQcoFE8Gn2UqEGZNW1D/TCM635RxBGHovBX3n776hU4C8kyzKTO7BQ7IL
         LXxys5AXgm6dTws9lozGV9I+zF0lLsIKSLvAYtPWDC9aRFE7DnwHl9sLDfY88+2CM0Mu
         AmpmlSJa6xnU52SXAOa9eYXUvGfNH/B2k69svh5tiFZRSGkqoe2bvWdTAzLMhhJkMDOS
         nNiJTZYwHuRWx27K+gLFTKkFS03rPTKMeja5i0uNUePqfoN3znGR/KbTMMoXrfA2Dp+6
         Du3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0H3gS6ENUsKWeShTc04Oxh9TJLnxL4twvq+6xgLItU=;
        b=omOXRDDqNj5p4KM7H2e6CZDgsZuogpsQAu6tqvrmHLzLSyggskuJa1vvGLcyyixEZI
         Hu384tYWB45bZOQFd5JMFGrBCO/t6av8FlShgSN5gcwIqZJ9nKOUBD2rDEEtIKEpZPR+
         IK35EIfw1urGmaABHnRNbByhDdfGNQLEQtOGu9ADf8OSg0pRqA323pnvcWNDE17Ene8z
         6E9UehiofAyupnl0qYzmawufnQ4P3H20htKH4fJ9DIxcgadzKmZ8KDvE61OuI5avy/AO
         0KDj7S8D3/Iy0gWiKShxX93AsOVmmoly8Xpq97uNz0qdoTn/F1VgG+F/8OQTT3/QfvMR
         tR/g==
X-Gm-Message-State: ACrzQf01XlAzBiHIR+j67OXAQvuPucdnY5eqkVsMm5NffDoIyDoL2He+
        T4VZ972K+PQPd9owpgPfnkm8tEqXf6WyPg==
X-Google-Smtp-Source: AMsMyM6R6lm46LHofH7az0q1px/k2yLCPNdrU5kIBjZo0Fy3rKRfp6gznMV4LthIARbqwRp5ue6iaQ==
X-Received: by 2002:adf:e38d:0:b0:236:7217:827e with SMTP id e13-20020adfe38d000000b002367217827emr2283094wrm.652.1667045075620;
        Sat, 29 Oct 2022 05:04:35 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:35 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 6/7] platform/x86: ideapad-laptop: Keyboard backlight support for more IdeaPads
Date:   Sat, 29 Oct 2022 15:03:11 +0300
Message-Id: <20221029120311.11152-7-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029120311.11152-1-erayorcunus@gmail.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

IdeaPads with HALS_KBD_BL_SUPPORT_BIT have full keyboard light support,
and they send an event via ACPI on light state change. Whereas some
IdeaPads that don't have this bit set, i.e. 520-15ikb, 330-17ich and
5 (15), don't send an event, yet they still support switching keyboard
light via KBLO object on DSDT. Detect these IdeaPads with searching for
KBLO object, set their kbd_bl_partial to true and register led device
for them. Tested on 520-15ikb.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 79 ++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index e8c088e7a53d..b34fbc4d741c 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -149,6 +149,7 @@ struct ideapad_private {
 		bool fn_lock              : 1;
 		bool hw_rfkill_switch     : 1;
 		bool kbd_bl               : 1;
+		bool kbd_bl_partial       : 1;
 		bool cam_ctrl_via_ec      : 1;
 		bool touchpad_ctrl_via_ec : 1;
 		bool usb_charging         : 1;
@@ -157,6 +158,9 @@ struct ideapad_private {
 		bool initialized;
 		struct led_classdev led;
 		unsigned int last_brightness;
+		/* Below are used only if kbd_bl_partial is set */
+		acpi_handle lfcm_mutex;
+		acpi_handle kblo_obj;
 	} kbd_bl;
 };
 
@@ -1300,19 +1304,52 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
 		backlight_force_update(priv->blightdev, BACKLIGHT_UPDATE_HOTKEY);
 }
 
+#define IDEAPAD_ACPI_MUTEX_TIMEOUT 1500
+
 /*
  * keyboard backlight
  */
 static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
 {
-	unsigned long hals;
+	unsigned long ret_val;
 	int err;
+	acpi_status status;
 
-	err = eval_hals(priv->adev->handle, &hals);
+	/*
+	 * Some IdeaPads with partially implemented keyboard lights don't give
+	 * us the light state on HALS_KBD_BL_STATE_BIT in the return value of HALS,
+	 * i.e. 5 (15) and 330-17ich. Fortunately we know how to gather it.
+	 * Even if it won't work, we will still give HALS a try, because
+	 * some IdeaPads with kbd_bl_partial, i.e. 520-15ikb,
+	 * correctly sets HALS_KBD_BL_STATE_BIT in HALS return value.
+	 */
+
+	if (priv->features.kbd_bl_partial &&
+	    priv->kbd_bl.lfcm_mutex != NULL && priv->kbd_bl.kblo_obj != NULL) {
+
+		status = acpi_acquire_mutex(priv->kbd_bl.lfcm_mutex, NULL,
+					    IDEAPAD_ACPI_MUTEX_TIMEOUT);
+
+		if (ACPI_SUCCESS(status)) {
+			err = eval_int(priv->kbd_bl.kblo_obj, NULL, &ret_val);
+
+			status = acpi_release_mutex(priv->kbd_bl.lfcm_mutex, NULL);
+			if (ACPI_FAILURE(status))
+				dev_err(&priv->platform_device->dev,
+					"Failed to release LFCM mutex");
+
+			if (err)
+				return err;
+
+			return !!ret_val;
+		}
+	}
+
+	err = eval_hals(priv->adev->handle, &ret_val);
 	if (err)
 		return err;
 
-	return !!test_bit(HALS_KBD_BL_STATE_BIT, &hals);
+	return !!test_bit(HALS_KBD_BL_STATE_BIT, &ret_val);
 }
 
 static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
@@ -1329,7 +1366,8 @@ static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned
 	if (err)
 		return err;
 
-	priv->kbd_bl.last_brightness = brightness;
+	if (!priv->features.kbd_bl_partial)
+		priv->kbd_bl.last_brightness = brightness;
 
 	return 0;
 }
@@ -1349,6 +1387,9 @@ static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
 	if (!priv->kbd_bl.initialized)
 		return;
 
+	if (priv->features.kbd_bl_partial)
+		return;
+
 	brightness = ideapad_kbd_bl_brightness_get(priv);
 	if (brightness < 0)
 		return;
@@ -1371,17 +1412,20 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 	if (WARN_ON(priv->kbd_bl.initialized))
 		return -EEXIST;
 
-	brightness = ideapad_kbd_bl_brightness_get(priv);
-	if (brightness < 0)
-		return brightness;
+	/* IdeaPads with kbd_bl_partial don't have keyboard backlight event */
+	if (!priv->features.kbd_bl_partial) {
+		brightness = ideapad_kbd_bl_brightness_get(priv);
+		if (brightness < 0)
+			return brightness;
 
-	priv->kbd_bl.last_brightness = brightness;
+		priv->kbd_bl.last_brightness         = brightness;
+		priv->kbd_bl.led.flags               = LED_BRIGHT_HW_CHANGED;
+	}
 
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
 	priv->kbd_bl.led.max_brightness          = 1;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
-	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
 
 	err = led_classdev_register(&priv->platform_device->dev, &priv->kbd_bl.led);
 	if (err)
@@ -1594,8 +1638,25 @@ static void ideapad_check_features(struct ideapad_private *priv)
 			if (test_bit(HALS_FNLOCK_SUPPORT_BIT, &val))
 				priv->features.fn_lock = true;
 
+			/*
+			 * IdeaPads with HALS_KBD_BL_SUPPORT_BIT have full keyboard
+			 * light support, and they send an event via ACPI on light
+			 * state change. Whereas some IdeaPads, at least 520-15ikb
+			 * and 5 (15), don't send an event, yet they still have
+			 * KBLO object. In this case, set kbd_bl_partial to true
+			 * and cache the LFCM mutex, it might be useful while
+			 * getting the brightness.
+			 */
+
 			if (test_bit(HALS_KBD_BL_SUPPORT_BIT, &val))
 				priv->features.kbd_bl = true;
+			else if (ACPI_SUCCESS(acpi_get_handle(handle, "^KBLO",
+							      &priv->kbd_bl.kblo_obj))) {
+				priv->features.kbd_bl = true;
+				priv->features.kbd_bl_partial = true;
+				(void)acpi_get_handle(handle, "^LFCM",
+						      &priv->kbd_bl.lfcm_mutex);
+			}
 
 			if (test_bit(HALS_USB_CHARGING_SUPPORT_BIT, &val))
 				priv->features.usb_charging = true;
-- 
2.34.1

