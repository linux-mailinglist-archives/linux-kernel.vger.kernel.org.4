Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F45B45C0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIJJoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIJJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:44:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA1F5AD;
        Sat, 10 Sep 2022 02:44:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so5875436edd.13;
        Sat, 10 Sep 2022 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OScyhco9O6uRT8iddKJAEiXM793/knN1pDcTqvXuiMI=;
        b=HhFwVzdvfxgIi0HCYKd+W7tgY3pZFmqATruMIQDJeqEecrIhkdFomVhuBDVKs9oyGZ
         tZ5rIznWMtzcpmusT+0u/yCMyGPB3uZ/AB77PUKgD1aIZVkK+vvkXDaMRYSkx/E0kz/Z
         c/Ee5NKNgXcOLIHVJSEYBDR+WgOoiLLGGngaDzDo4b7FXLEYYEZ1/Cqsey2YWuo72NnZ
         LCvn0MicWHJqQ/wW5Q1Z2IATaligXRg8AaOfNZ/PHoWhP3uKSc7aPuOK6bugoC588qUa
         0CEp/Xz6yx0T7cZDOFTLpmoTPToRD/weCZ1qZROwfMZDy+mdo+NR3wiCbjhUMx9c7Fn3
         gNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OScyhco9O6uRT8iddKJAEiXM793/knN1pDcTqvXuiMI=;
        b=ZUGpd9DqotSn792MmZBCKDuBMSObKVqWF0DRQesZ43WC1OGqMfXYMaj3IQbIE129VM
         vAWMy3nqokSIalgAWEOsXXYEYnShIDDoTj6ZbjjpD3xejpOzNIW0OOg57vejMtOsmDro
         UVukmACZMbWtbYl4GBWAPDnoboTdkw9dZ//OlkfwNhTRJnk5i/nllWGWwHQ4szaLDxLi
         iV+OgOFz4QNz10GyPsIA2oy3NxllHl64B92J0NqlMoJLuWh1iP08qEfsTI5jJrwjy4fX
         v8ucNxD9u6759nBNLAxAuwuIUjgPgNZegQX/bZCckpDjjKJDvaUyHVYVN+Hzmkxum8Yq
         URGQ==
X-Gm-Message-State: ACgBeo1bAwl2WhdvAS+h7qwa33Gxnk5ZWSfvoBaLRlxJMcfkp9WYpTCp
        GBQl+HtRotIBg+wflcAA6BM=
X-Google-Smtp-Source: AA6agR4fB9XRFndVnH2VIdvLIFOvnR+pcr3y7EKJD1tO0tasRPOuGGEm587+aY3F1XESeUchhD4I2Q==
X-Received: by 2002:aa7:dc13:0:b0:443:3f15:8440 with SMTP id b19-20020aa7dc13000000b004433f158440mr14297998edu.274.1662803073628;
        Sat, 10 Sep 2022 02:44:33 -0700 (PDT)
Received: from localhost.localdomain ([5.25.52.35])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906715400b0073d65a95161sm1456240ejj.222.2022.09.10.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:44:33 -0700 (PDT)
From:   Kerem Karabay <kekrby@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kerem Karabay <kekrby@gmail.com>
Subject: [PATCH 1/2] HID: apple: fix key translations where multiple quirks attempt to translate the same key and the ones that depend on other translations
Date:   Sat, 10 Sep 2022 12:43:53 +0300
Message-Id: <20220910094354.12359-1-kekrby@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hid-apple driver does not support chaining translations or
dependencies on other translations. This creates two problems:

1 - In Non-English keyboards of Macs, KEY_102ND and KEY_GRAVE are
swapped and the APPLE_ISO_TILDE_QUIRK is used to work around this
problem. The quirk is not set for the Macs where these bugs happen yet
(see the 2nd patch for that), but this can be forced by setting the
iso_layout parameter. Unfortunately, this only partially works.
KEY_102ND gets translated to KEY_GRAVE, but KEY_GRAVE does not get
translated to KEY_102ND, so both of them end up functioning as
KEY_GRAVE. This is because the driver translates the keys as if Fn was
pressed and the original is sent if it is not pressed, without any
further translations happening on the key[#463]. KEY_GRAVE is present at
macbookpro_no_esc_fn_keys[#195], so this is what happens:

    - KEY_GRAVE -> KEY_ESC (as if Fn is pressed)
    - KEY_GRAVE is returned (Fn isn't pressed, so translation is discarded)
    - KEY_GRAVE -> KEY_102ND (this part is not reached!)
    ...

2 - In case the touchbar does not work, the driver supports sending
Escape when Fn+KEY_GRAVE is pressed. As mentioned previously, KEY_102ND
is actually KEY_GRAVE and needs to be translated before this happens.

Normally, these are the steps that should happen:

    - KEY_102ND -> KEY_GRAVE
    - KEY_GRAVE -> KEY_ESC (Fn is pressed)
    - KEY_ESC is returned

Though this is what happens instead, as dependencies on other
translations are not supported:

    - KEY_102ND -> KEY_ESC (Fn is pressed)
    - KEY_ESC is returned

This patch fixes both bugs by ordering the translations correctly and by
making the translations continue and not return immediately after
translating a key so that chained translations work and translations can
depend on other ones.

This patch also simplifies the implementation of the swap_fn_leftctrl
option a little bit, as it makes it simply use a normal translation
instead adding extra code to translate a key to KEY_FN[#381]. This change
wasn't put in another patch as the code that translates the Fn key needs
to be changed because of the changes in the patch, and those changes
would be discarded with the next patch anyway (the part that originally
translates KEY_FN to KEY_LEFTCTRL needs to be made an else-if branch of
the part that transltes KEY_LEFTCTRL to KEY_FN).

Note: Line numbers (#XYZ) are for drivers/hid/hid-apple.c at commit
20afcc462579 ("HID: apple: Add "GANSS" to the non-Apple list").

Note: These bugs are only present on Macs with a keyboard with no
dedicated escape key and a non-English layout.

Signed-off-by: Kerem Karabay <kekrby@gmail.com>
---
 drivers/hid/hid-apple.c | 99 ++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 55 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 6970797cdc56..066e8a85daa5 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -314,6 +314,7 @@ static const struct apple_key_translation swapped_option_cmd_keys[] = {
 
 static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 	{ KEY_FN, KEY_LEFTCTRL },
+	{ KEY_LEFTCTRL, KEY_FN },
 	{ }
 };
 
@@ -375,24 +376,40 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	struct apple_sc *asc = hid_get_drvdata(hid);
 	const struct apple_key_translation *trans, *table;
 	bool do_translate;
-	u16 code = 0;
+	u16 code = usage->code;
 	unsigned int real_fnmode;
 
-	u16 fn_keycode = (swap_fn_leftctrl) ? (KEY_LEFTCTRL) : (KEY_FN);
-
-	if (usage->code == fn_keycode) {
-		asc->fn_on = !!value;
-		input_event_with_scancode(input, usage->type, KEY_FN,
-				usage->hid, value);
-		return 1;
-	}
-
 	if (fnmode == 3) {
 		real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
 	} else {
 		real_fnmode = fnmode;
 	}
 
+	if (swap_fn_leftctrl) {
+		trans = apple_find_translation(swapped_fn_leftctrl_keys, code);
+
+		if (trans)
+			code = trans->to;
+	}
+
+	if (iso_layout > 0 || (iso_layout < 0 && (asc->quirks & APPLE_ISO_TILDE_QUIRK) &&
+			hid->country == HID_COUNTRY_INTERNATIONAL_ISO)) {
+		trans = apple_find_translation(apple_iso_keyboard, code);
+
+		if (trans)
+			code = trans->to;
+	}
+
+	if (swap_opt_cmd) {
+		trans = apple_find_translation(swapped_option_cmd_keys, code);
+
+		if (trans)
+			code = trans->to;
+	}
+
+	if (code == KEY_FN)
+		asc->fn_on = !!value;
+
 	if (real_fnmode) {
 		if (hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI ||
 		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO ||
@@ -430,15 +447,18 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		else
 			table = apple_fn_keys;
 
-		trans = apple_find_translation (table, usage->code);
+		trans = apple_find_translation(table, code);
 
 		if (trans) {
-			if (test_bit(trans->from, input->key))
+			bool from_is_set = test_bit(trans->from, input->key);
+			bool to_is_set = test_bit(trans->to, input->key);
+
+			if (from_is_set)
 				code = trans->from;
-			else if (test_bit(trans->to, input->key))
+			else if (to_is_set)
 				code = trans->to;
 
-			if (!code) {
+			if (!(from_is_set || to_is_set)) {
 				if (trans->flags & APPLE_FLAG_FKEY) {
 					switch (real_fnmode) {
 					case 1:
@@ -455,62 +475,31 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 					do_translate = asc->fn_on;
 				}
 
-				code = do_translate ? trans->to : trans->from;
+				if (do_translate)
+					code = trans->to;
 			}
-
-			input_event_with_scancode(input, usage->type, code,
-					usage->hid, value);
-			return 1;
 		}
 
 		if (asc->quirks & APPLE_NUMLOCK_EMULATION &&
-				(test_bit(usage->code, asc->pressed_numlock) ||
+				(test_bit(code, asc->pressed_numlock) ||
 				test_bit(LED_NUML, input->led))) {
-			trans = apple_find_translation(powerbook_numlock_keys,
-					usage->code);
+			trans = apple_find_translation(powerbook_numlock_keys, code);
 
 			if (trans) {
 				if (value)
-					set_bit(usage->code,
-							asc->pressed_numlock);
+					set_bit(code, asc->pressed_numlock);
 				else
-					clear_bit(usage->code,
-							asc->pressed_numlock);
+					clear_bit(code, asc->pressed_numlock);
 
-				input_event_with_scancode(input, usage->type,
-						trans->to, usage->hid, value);
+				code = trans->to;
 			}
-
-			return 1;
 		}
 	}
 
-	if (iso_layout > 0 || (iso_layout < 0 && (asc->quirks & APPLE_ISO_TILDE_QUIRK) &&
-			hid->country == HID_COUNTRY_INTERNATIONAL_ISO)) {
-		trans = apple_find_translation(apple_iso_keyboard, usage->code);
-		if (trans) {
-			input_event_with_scancode(input, usage->type,
-					trans->to, usage->hid, value);
-			return 1;
-		}
-	}
+	if (usage->code != code) {
+		input_event_with_scancode(input, usage->type, code, usage->hid, value);
 
-	if (swap_opt_cmd) {
-		trans = apple_find_translation(swapped_option_cmd_keys, usage->code);
-		if (trans) {
-			input_event_with_scancode(input, usage->type,
-					trans->to, usage->hid, value);
-			return 1;
-		}
-	}
-
-	if (swap_fn_leftctrl) {
-		trans = apple_find_translation(swapped_fn_leftctrl_keys, usage->code);
-		if (trans) {
-			input_event_with_scancode(input, usage->type,
-					trans->to, usage->hid, value);
-			return 1;
-		}
+		return 1;
 	}
 
 	return 0;
-- 
2.37.2

