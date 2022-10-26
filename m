Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2417460E839
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiJZTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiJZTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:03:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71861213FC;
        Wed, 26 Oct 2022 12:01:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 21so9182689edv.3;
        Wed, 26 Oct 2022 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFFOZJ/VadBNjE26xEB3SXj8jNBR5pKnqYBmJKPPaoI=;
        b=VVUaU8P58x2uWpriSK+QJTdSu6sPvez31gYpX8vt5AcwLa8R1dGZK0SGG8OVQvbpU3
         LDvLtme+1it9dkDEASp+iphuJ/pWpbJw+MN+k+JftJ/9EApWzCuBHqjWgWyPeogiQbzB
         BtHiK0JjO8WMXviLW1RvGXGMFzaG5XdpHp+w1MeP4nFueM8uRA/HjJvlyhj4Ul2JWNaE
         ho7x+AcvCGPAO+Rl809Dlz1HMTj2tGnGKvjES5NevbmJyXf8ZXI/Iro5yYn3zJPa2c32
         pLyBnnz51hzLiwlmp2BdpC7rlLVfZlSqcaIgFEa/ah4Y/nGqDXl+mGV1SqC46I8iegrs
         qGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFFOZJ/VadBNjE26xEB3SXj8jNBR5pKnqYBmJKPPaoI=;
        b=eo1aAaLir/aF9VjJ6WsdMLxaAfnhkWKPOHX17c3bbkvMmWbATeSBMlZdhPLl0WEGwA
         6PdukPMt0hvcn7JlfHVRjBffk5RyZtsk+rXUIPY+JEo6Z3c/eU8Uy1nIUzpMKW2ekpqF
         RFORYMmYI7uxobgSxgfyufB7G9Fdj+sM6mOmapo2h1OYTFP7UwKlRCIhkKKnkP6aCpWX
         W4bG24LYRiyZpgc6Yl1yjndGjwGJW9umvtpE3BZ/tq6XYrofqpkrLc1d+P0kP3+EEK/M
         HAyENkKJsDaLY+PXn7H5kkBwwtWEv9Wsb1cEnD4oRdBwLj+fT6RyT5/ojVN5TiOZFEmd
         UOkg==
X-Gm-Message-State: ACrzQf3Nx/pmSH8CxO4Q3cJdj6Qtwice0WGjkNMck/U3xZTl3UuyrpXt
        p1ssjxHvfChDcRA9tOK85BLAth0bCVBl5A==
X-Google-Smtp-Source: AMsMyM4TTmpDq0EIr1Nameij72nB33a84SDhB5xmTXiBFKWJ1JC1fEcF66fKvCvi1MbsSdEl0RSKZg==
X-Received: by 2002:a05:6402:274c:b0:461:9921:60cf with SMTP id z12-20020a056402274c00b00461992160cfmr20464459edd.353.1666810877183;
        Wed, 26 Oct 2022 12:01:17 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id r18-20020a1709063d7200b0076ff600bf2csm3342945ejf.63.2022.10.26.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:01:16 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH 6/6] platform/x86: ideapad-laptop: Keyboard backlight support for more IdeaPads
Date:   Wed, 26 Oct 2022 22:01:06 +0300
Message-Id: <20221026190106.28441-7-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026190106.28441-1-erayorcunus@gmail.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
index 65eea2e65bbe..c30bbe0ca156 100644
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
 
@@ -1302,19 +1306,52 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
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
@@ -1331,7 +1368,8 @@ static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned
 	if (err)
 		return err;
 
-	priv->kbd_bl.last_brightness = brightness;
+	if (!priv->features.kbd_bl_partial)
+		priv->kbd_bl.last_brightness = brightness;
 
 	return 0;
 }
@@ -1351,6 +1389,9 @@ static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
 	if (!priv->kbd_bl.initialized)
 		return;
 
+	if (priv->features.kbd_bl_partial)
+		return;
+
 	brightness = ideapad_kbd_bl_brightness_get(priv);
 	if (brightness < 0)
 		return;
@@ -1373,17 +1414,20 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
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
@@ -1595,8 +1639,25 @@ static void ideapad_check_features(struct ideapad_private *priv)
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

