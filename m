Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AB168CE41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBGEgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjBGEgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:36:10 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E015115C91;
        Mon,  6 Feb 2023 20:36:08 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m2so14464020plg.4;
        Mon, 06 Feb 2023 20:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeSdZKqtZth6PEjNasbwHyq9Iynmp9ccSKmSfouBDbc=;
        b=dsxxvUUAM4ic7hS9vkmjp40TOOclI/djnOAX5Ry0gYLV6mYB+JER3Cv1azbvrEjAku
         WE71aPYWFwXw9f5JzMgXMjuSeNcSYSecKk6ZL79tb4ZGZ0xJHHpQqMGaewDVqQKcOzkO
         rxXDxywSbwF6tJYfJbWjtkQbUhFS/fyjeCdtij3yIxwTCiFXP99Q6mD/8WAjUisf3eDl
         mC1UjQ528K7GlR0s54ofjiMJpg90EwSGrz8/OvNwpgCJrqGzeM5LdpgGr2TNYQ5Ob3gX
         ulraHZo2h6OsJ2ZhGfUwAXTVkZycWXkffdb6EmDD+54mT9VIRT7Gd1PYEe08F6NA9QMk
         vQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeSdZKqtZth6PEjNasbwHyq9Iynmp9ccSKmSfouBDbc=;
        b=s97WaxP3ZFlHtyfkNDvIuTQno1dlilkIabcZR25F3mQzEmKiRxCWRbz2QQ/WwnWghT
         OlWOcY1bRCS2/dG0Q5ZVSpzrA1q+DmGLiDXfSgY0347RHdPb3NMj87vw8f0JczQygVCg
         Lyh3BWm0tEQO2V8mmZwre+/HKHz8Zuw0g9rxLI3Kj3pziKVY8tCL9RvHM0hbgWkd14tP
         /0u8CXB6Y2nUNRN+uZznC2o5MVPYlVI/nWF3c17kNhML/sXZiZn5XMlnV2wRHt+TaCfu
         UO5VC5KTOuFqbsOetcnmlTt6JjxR/YxGGVapJxQfWu3GsVyrcE8t2uqbHfM8w5t4f7DI
         D4nQ==
X-Gm-Message-State: AO0yUKU+2nERu+hVVwQ84HAwsev+bHE/IB+6g5Dw+4t5M74wc1j+4CCx
        CDLHwoeEC7aqzgeYheD2vRY=
X-Google-Smtp-Source: AK7set/aYeGbQ9RXp3HqcTqbvlZK6riMJbp4RVTgShXqmTyDIIkTcJ9YRqK96VmcX1eOv3sU0BmJcQ==
X-Received: by 2002:a05:6a21:3386:b0:bc:3523:13c6 with SMTP id yy6-20020a056a21338600b000bc352313c6mr2387254pzb.29.1675744568423;
        Mon, 06 Feb 2023 20:36:08 -0800 (PST)
Received: from d.home.yangfl.dn42 ([222.69.200.222])
        by smtp.gmail.com with ESMTPSA id p4-20020a63ab04000000b00499a90cce5bsm6695310pgf.50.2023.02.06.20.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:36:07 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] HID: kye: Sort kye devices
Date:   Tue,  7 Feb 2023 12:33:16 +0800
Message-Id: <20230207043318.23842-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207043318.23842-1-mmyangfl@gmail.com>
References: <20230207043318.23842-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort kye devices by their Produce IDs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/hid/hid-ids.h    |  2 +-
 drivers/hid/hid-kye.c    | 60 ++++++++++++++++++++--------------------
 drivers/hid/hid-quirks.c |  6 ++--
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0f8c11842a3a..dce7e1424672 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -714,10 +714,10 @@
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
 #define USB_DEVICE_ID_KYE_EASYPEN_I405X	0x5010
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
-#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2	0x501a
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
 #define USB_DEVICE_ID_KYE_PENSKETCH_M912	0x5015
 #define USB_DEVICE_ID_KYE_EASYPEN_M406XE	0x5019
+#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2	0x501A
 
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index 03a9ad9057b2..47f5aa5e9d88 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -329,25 +329,25 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rdesc[74] = 0x08;
 		}
 		break;
-	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
-	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
-	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
-	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
-		rdesc = kye_tablet_fixup(hdev, rdesc, rsize);
-		break;
 	case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
 		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
 					"Genius Gila Gaming Mouse");
 		break;
+	case USB_DEVICE_ID_GENIUS_MANTICORE:
+		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
+					"Genius Manticore Keyboard");
+		break;
 	case USB_DEVICE_ID_GENIUS_GX_IMPERATOR:
 		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 83,
 					"Genius Gx Imperator Keyboard");
 		break;
-	case USB_DEVICE_ID_GENIUS_MANTICORE:
-		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
-					"Genius Manticore Keyboard");
+	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
+	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
+	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
+	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
+		rdesc = kye_tablet_fixup(hdev, rdesc, rsize);
 		break;
 	}
 	return rdesc;
@@ -417,26 +417,26 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	switch (id->product) {
+	case USB_DEVICE_ID_GENIUS_MANTICORE:
+		/*
+		 * The manticore keyboard needs to have all the interfaces
+		 * opened at least once to be fully functional.
+		 */
+		if (hid_hw_open(hdev))
+			hid_hw_close(hdev);
+		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
-	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
+	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 		ret = kye_tablet_enable(hdev);
 		if (ret) {
 			hid_err(hdev, "tablet enabling failed\n");
 			goto enabling_err;
 		}
 		break;
-	case USB_DEVICE_ID_GENIUS_MANTICORE:
-		/*
-		 * The manticore keyboard needs to have all the interfaces
-		 * opened at least once to be fully functional.
-		 */
-		if (hid_hw_open(hdev))
-			hid_hw_close(hdev);
-		break;
 	}
 
 	return 0;
@@ -449,23 +449,23 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static const struct hid_device_id kye_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_EASYPEN_I405X) },
+				USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
+				USB_DEVICE_ID_GENIUS_MANTICORE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
+				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
+				USB_DEVICE_ID_KYE_EASYPEN_I405X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE) },
+				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
+				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_GENIUS_MANTICORE) },
+				USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, kye_devices);
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index be3ad02573de..479b377f686c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -104,12 +104,12 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406XE), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019), HID_QUIRK_ALWAYS_POLL },
-- 
2.39.1

