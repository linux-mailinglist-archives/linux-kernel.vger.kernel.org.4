Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C696562BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiLZMzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiLZMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:55:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B762B61;
        Mon, 26 Dec 2022 04:55:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so7460040wms.4;
        Mon, 26 Dec 2022 04:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eus7P8yeikk4wwlMHasaNl/bqp6teGVXQaOvLono3cc=;
        b=cFkqhRsdx4Ct059TDURmokgku6aJS+e9/6oDHYqnaqpdXyrmB/CL0ae+XD+1e7+E0G
         5aiBlsveIM7L8iobuciqo+YSiaguuXbBrjRoSz06yeDvj/aQX9/YFXo6Jo8SzYDkMex9
         FMKWrfiDYT4Sl5iUq2y9gS8uaIp3y8J+pdVOcTPivrLLddnZS0ypMRw/vnjsOO7JCC/L
         GX4PjD4a8xILmW6Yw2iWmi8dXwtsebx2U7tNOWb/5JlzqiT42SYdqsXzT9xDGqrpOYJf
         /GNGGoHriUFbVCyqQs+P8fobOye05F/qj8gkemQc4+RMULAdinDxZjl0jFTgC+FQsSyv
         xmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eus7P8yeikk4wwlMHasaNl/bqp6teGVXQaOvLono3cc=;
        b=WpKDSCqfbZs+COTfWnI0ODtFgTP7Qa2XYh7ZUc4hmzB/w3fPh6WE2Civ87kdZuNznM
         CrHXRWPUIwuMRzqhRGQpd0voPuJBGGcKLRwhOBB2J1C+bFCabCwdv6pDsUG4Q0fz70gy
         E4RaP08vtJIZjuXjBEqDlZfcNy8Zf2NgkNz+zAMyDSTyJJqKzEPvlNElegtr1pZHy2lc
         gQq/kd1KOEOfsRlPKT76pTFHfsRXTeDt+RruGuKt3vOczRs2Zgxxizmvpf3KumHultLe
         4qeyQrkR/bY9STSEv9F3oXgDaNbki1gY80sDfu89Ac/GBHdJEXvbyBouStP4N/mhaVsz
         zvlw==
X-Gm-Message-State: AFqh2kr9DE2q817UQn15q1Dive5ovo43/4bFZ+XvxplC0f8iVOMJ4/1d
        dcmD2NI56pijsXl+e3zOQgg=
X-Google-Smtp-Source: AMrXdXvQrkxNqV5g5d8M0FQEOciZElF8fYHwEn93imuugUf2VMe/qM6luMaAiyJTtN8DHdQOrVxEDA==
X-Received: by 2002:a05:600c:4fcf:b0:3cf:68f8:790b with SMTP id o15-20020a05600c4fcf00b003cf68f8790bmr13213891wmq.11.1672059313074;
        Mon, 26 Dec 2022 04:55:13 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm13684497wmq.25.2022.12.26.04.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:55:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: [PATCH 6/6] HID: uclogic: Add support for XP-PEN Deco Pro MW
Date:   Mon, 26 Dec 2022 13:54:54 +0100
Message-Id: <20221226125454.16106-7-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226125454.16106-1-jose.exposito89@gmail.com>
References: <20221226125454.16106-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XP-PEN Deco Pro MW is a UGEE v2 device with a frame with 8 buttons,
a bitmap dial and a mouse. Its pen has 2 buttons, supports tilt and
pressure.

It can be connected using a USB cable or, to use it in wireless mode,
using a USB Bluetooth dongle. When it is connected in wireless mode the
device battery is used to power it.

All the pieces to support it are already in place. Add its ID and
quirks in order to support the device.

Link: https://github.com/DIGImend/digimend-kernel-drivers/issues/622
Tested-by: Andreas Grosse <andig.mail@t-online.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-input.c          | 2 ++
 drivers/hid/hid-uclogic-core.c   | 3 +++
 drivers/hid/hid-uclogic-params.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d8a8028761ed..5df7f4e4d610 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1296,6 +1296,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640	0x0094
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW	0x0934
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S	0x0909
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW	0x0933
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c4d9a95774cc..4f6596febedf 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -376,6 +376,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15),
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index cfef6f9af62d..a31e06b38a67 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -540,6 +540,9 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW),
+		.driver_data = UCLOGIC_MOUSE_FRAME_QUIRK | UCLOGIC_BATTERY_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 39a9259aa447..7fdb87a2714b 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1765,6 +1765,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		     USB_DEVICE_ID_UGEE_PARBLO_A610_PRO):
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L):
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW):
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S):
 	case VID_PID(USB_VENDOR_ID_UGEE,
-- 
2.38.1

