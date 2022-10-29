Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14236122B1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJ2MEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJ2ME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1F315;
        Sat, 29 Oct 2022 05:04:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so8033512wmr.2;
        Sat, 29 Oct 2022 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bb6ASl23RrFIKXOSlIN+mXfWnuBP94uLLqr0AkpKDA=;
        b=UKY4lfhgMvDyzlpHGK828TVKM8bLmKYfTAbbSosf7Z9b84uk2IIBBGreNKB7zsd0Oe
         YhsjFdEHsTFBOH9hvI5wWplfWVVRKTdlg3VdEkA+rkxHnzl7ZwQcCdinB/clMYnxXFRP
         W7lTS0jxMLMzV0kIVLxjSNXsLxW1ckwMdyP/zWsBOXOJXEA8UElXeqTB5wWzzie+1rVm
         bPV6gcn2brP9Cg+2I83F4U/IV5o10Krrqv8ZY9eng4gOYGNRBjk3621/sLepeXIthPDE
         0EHXPhsmdSFBK0nXg/5SsuNUk2hkYFjhM8vWD82cJU/l9T6WUBrdkoyvl4qjKgz14Oci
         sJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Bb6ASl23RrFIKXOSlIN+mXfWnuBP94uLLqr0AkpKDA=;
        b=Hu7DAdn4GRI9napf+xc7pHBP5EICA/9c3V42/9/6sM8GCPcRoxvlBMKzhYR1hb4Ttc
         mnKswA8ECsF+v5QQuGn66FzjiTHejzMRU/d9R/E8LN/DwEkrC3vTqc/XiZbpq3uWDAnB
         qkArHTPgkwCVULz+3Kmk015CZA+0ZWFyzJywyK5TXJDTNmElVv4F8SDiTOAuIbu3Yj4I
         onF/X8GZC527zqTeMd0aCMTtie4M8T/YF/DOkRFXU3n+3Po8Tw2xHgLTBYVe94QzCAQ9
         tW3nwXtu5VOUrxS7JqGLBt5j4ZLdIpc7rgWmTSaWiuyMH1aoAkSYJrhBOlbxpkT0QorX
         zo2Q==
X-Gm-Message-State: ACrzQf1vGmpjmbZ2xBkeuEHfjx1eonkVjWkT+ymEkd0iHBcd8kZFGX3S
        TJEP8BN74MgyBBsTmz9bcW9qgkJB9OEkWA==
X-Google-Smtp-Source: AMsMyM4blD5KXFo+73nrI0cCUSDVZ0u2eLk1j3hQA9bFmryN7RZlb9mNN95IIWqw1SMHdaPNElMPUQ==
X-Received: by 2002:a05:600c:1da7:b0:3ce:a1:f961 with SMTP id p39-20020a05600c1da700b003ce00a1f961mr12107085wms.175.1667045065486;
        Sat, 29 Oct 2022 05:04:25 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:25 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 2/7] HID: add mapping for camera access keys
Date:   Sat, 29 Oct 2022 15:03:07 +0300
Message-Id: <20221029120311.11152-3-erayorcunus@gmail.com>
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

HUTRR72 added 3 new usage codes for keys that are supposed to enable,
disable and toggle camera access. These are useful, considering many
laptops today have key(s) for toggling access to camera.

This patch adds new key definitions for KEY_CAMERA_ACCESS_ENABLE,
KEY_CAMERA_ACCESS_DISABLE and KEY_CAMERA_ACCESS_TOGGLE. Additionally
hid-debug is adjusted to recognize this new usage codes as well.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-debug.c                | 3 +++
 drivers/hid/hid-input.c                | 3 +++
 include/uapi/linux/input-event-codes.h | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index f48d3534e020..991f880fdbd4 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -936,6 +936,9 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_ASSISTANT] = "Assistant",
 	[KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
 	[KEY_EMOJI_PICKER] = "EmojiPicker",
+	[KEY_CAMERA_ACCESS_ENABLE] = "CameraAccessEnable",
+	[KEY_CAMERA_ACCESS_DISABLE] = "CameraAccessDisable",
+	[KEY_CAMERA_ACCESS_TOGGLE] = "CameraAccessToggle",
 	[KEY_DICTATE] = "Dictate",
 	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
 	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index f197aed6444a..f8e6513e77b8 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -995,6 +995,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
 		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
 
+		case 0x0d5: map_key_clear(KEY_CAMERA_ACCESS_ENABLE);		break;
+		case 0x0d6: map_key_clear(KEY_CAMERA_ACCESS_DISABLE);		break;
+		case 0x0d7: map_key_clear(KEY_CAMERA_ACCESS_TOGGLE);		break;
 		case 0x0d8: map_key_clear(KEY_DICTATE);		break;
 		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
 
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 7989d9483ea7..ef392d0f943f 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -614,6 +614,9 @@
 #define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
 #define KEY_EMOJI_PICKER	0x249	/* Show/hide emoji picker (HUTRR101) */
 #define KEY_DICTATE		0x24a	/* Start or Stop Voice Dictation Session (HUTRR99) */
+#define KEY_CAMERA_ACCESS_ENABLE	0x24b	/* Enables programmatic access to camera devices. (HUTRR72) */
+#define KEY_CAMERA_ACCESS_DISABLE	0x24c	/* Disables programmatic access to camera devices. (HUTRR72) */
+#define KEY_CAMERA_ACCESS_TOGGLE	0x24d	/* Toggles the current state of the camera access control. (HUTRR72) */
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
-- 
2.34.1

