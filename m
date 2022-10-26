Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8795760E834
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiJZTDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiJZTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:02:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1910CF89;
        Wed, 26 Oct 2022 12:01:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t25so18502318ejb.8;
        Wed, 26 Oct 2022 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkZbKsWATbAJjypqKd57ux62RrGOy/eY6B4J6gXFedg=;
        b=C/ow4uw755Nyc8QdIC8LF4jIUJukOE1w/eQKeoX4AZW2iJKQ49pvP4ZfjZDI0owBws
         YRuJtIb9obY4QIVgsZNJ4/TqJAL3WJy+1kDxSdYePSfB/gIAaO3kzJhFJRQGBkZYUiwF
         Cbl/T9e7ixd4ZaQSnnWd4zNAR8HgDw5zsqaL2XPIR6eGFuKD1vCM6Rz6WTY3ndAfe5jh
         ndXG6Ji9Ch4nShNwaHUQz9herW3Hvk4UrgJWpVjOCdd58TNHRj2tENGOMx0RFLe6uBtR
         GJI4tbEmo3FIm7co2HwZPOqubfuzJ0UfEaz4flKTv8QMvgxja3MbJ1uHU89y0P5egj4X
         fRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkZbKsWATbAJjypqKd57ux62RrGOy/eY6B4J6gXFedg=;
        b=uN5EkAYzqgT9GaPoSsIFTl31F8jQHK1wB2OrqyMcu795XhIKt0Lin4gYd1groySjpX
         pxRSzbiqvYfSrngsLq9fYLZsXJiTPK14ymblBhesfKTeShENlClnV7UCkK9h6ydWFsjA
         2aPXfT2A9txQpFU8kJrfa1o8JiMcM4rf7F5wewayhjjfK1hQPRhT+8yDQxt8AhDRHBTa
         KyAVgEat0+XaYYnGTBqu6SE9KCeitPZ/GbaLOt9GUZqWFQZyv6cRhJ/vH55mORnaVkIX
         ttIZhGBHUYtySSUHXXG28PFp+jt9+3yvWWH+mmE2pLj0aMWG25U/sjuCTTGgUVOzeNQW
         ALtw==
X-Gm-Message-State: ACrzQf0WwmHyl/haCY/qrv3tjVE/H80gQvRd33GAKsdrt7Hm8qkdvxBx
        uQThrYE6pyJUI8pIdaFXUM09YToSpXyFwA==
X-Google-Smtp-Source: AMsMyM72TN2TBwquLfC2nTirS9GH+kpJmhzjFi44n2cmAfIY8REWMZO1Jk64HBVPNcDoH6Ar4O0Hpg==
X-Received: by 2002:a17:907:75e9:b0:7a4:31c:ae0d with SMTP id jz9-20020a17090775e900b007a4031cae0dmr19129734ejc.79.1666810871408;
        Wed, 26 Oct 2022 12:01:11 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id r18-20020a1709063d7200b0076ff600bf2csm3342945ejf.63.2022.10.26.12.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:01:11 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH 2/6] HID: add mapping for camera access keys
Date:   Wed, 26 Oct 2022 22:01:02 +0300
Message-Id: <20221026190106.28441-3-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026190106.28441-1-erayorcunus@gmail.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com>
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

