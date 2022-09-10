Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3935B45C2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIJJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIJJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:45:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176C118E24;
        Sat, 10 Sep 2022 02:45:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v16so9441975ejr.10;
        Sat, 10 Sep 2022 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DLm5IfI4P+X3M3xAV8JNT2l5OWyOjHa+j7FTqm9Zm9E=;
        b=eKiOjsRxlCmooUsRD7c2HlTL+Wgg1JnmCTVS2MnvADemXtsEhb5ensgk5RZROAeikO
         x1kReeoMpMdUet8TpppYyW9vi7ldmzA/uRyM3WuyEsAtmw+SOAzbDLVaG9UNw3RPWr+x
         94P0auC+YJFWQHhxAoVV6Rkzm4enKPjLIxNpxh2z7YjkxnJqJa1YfkuG5MTC7UIb0vYo
         hzP9dkbWjO3Jyv5Ldpa8i43lVflo2e7ukVuSa9H7rtUO2Mdtf6IZxeYPUJpucBuHFQ1t
         G9Zs0XhLiNHML2PdwGd8xjsm+ISo4Vzm/mOkuXwrjP4Zy+q9ixFIBP3VRQ2HkyyKcQ5j
         PNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DLm5IfI4P+X3M3xAV8JNT2l5OWyOjHa+j7FTqm9Zm9E=;
        b=b+3yyiBpl0/9AK8/xJyk+kjxq68axITvc+ACsqMHyy3t8MY5ZYPy4+AQnP/4FAE9w/
         N5hKgIaFnuDpYu9jaJ3SozqzXAaAnaIX2GPZ07GYF2O+0t4Xkq/plRVzSoqJhgti1Ei0
         FuV7WIO79gvgMciXOIbQIeoniAiQTpM8sL4RSrwiE9sZJ2cdyV8duJmHiS79dLVUQ0fA
         54vG/HwFNNA4IAiRGm4oZDpBX9CEgY0IZmomaCMA0iADMadeP4wr58ROZZGp4ZJA2c/Z
         uiXb/jdgrSTfc5BcNsOngucm7hGsFhVzTAzHWr+3frD8l7qLG9WKruz3wQ/gt/vNGlUt
         zdYw==
X-Gm-Message-State: ACgBeo1tK0qNdOl6EWrL3z4Dlk119U8Uo+7Yga6+d2BNmiBv3yYZFfOV
        C8wmAfXQgur45M0fY2py6MJCjuDKL3A=
X-Google-Smtp-Source: AA6agR64/251tWoRTxqFvxQhmzRFEi25bsNiHYG8zhKJ/FrLarY2amnH2XiTA2qk1uXup9CFipppYQ==
X-Received: by 2002:a17:906:8a6c:b0:772:fe67:f5ea with SMTP id hy12-20020a1709068a6c00b00772fe67f5eamr9713345ejc.488.1662803099667;
        Sat, 10 Sep 2022 02:44:59 -0700 (PDT)
Received: from localhost.localdomain ([5.25.52.35])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906715400b0073d65a95161sm1456240ejj.222.2022.09.10.02.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:44:59 -0700 (PDT)
From:   Kerem Karabay <kekrby@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kerem Karabay <kekrby@gmail.com>
Subject: [PATCH 2/2] HID: apple: enable APPLE_ISO_TILDE_QUIRK for the keyboards of Macs with the T2 chip
Date:   Sat, 10 Sep 2022 12:43:54 +0300
Message-Id: <20220910094354.12359-2-kekrby@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910094354.12359-1-kekrby@gmail.com>
References: <20220910094354.12359-1-kekrby@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iso_layout parameter must be manually set to get the driver to
swap KEY_102ND and KEY_GRAVE. This patch eliminates the need to do that.

This is safe to do, as Macs with keyboards that do not need the quirk
will keep working the same way as the value of hid->country will be
different than HID_COUNTRY_INTERNATIONAL_ISO. This was tested by one
person with a Mac with the WELLSPRINGT2_J152F keyboard with a layout
that does not require the quirk to be set.

Signed-off-by: Kerem Karabay <kekrby@gmail.com>
---
 drivers/hid/hid-apple.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 066e8a85daa5..df994baf547d 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -1000,21 +1000,21 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K),
-		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132),
-		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680),
-		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213),
-		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
-- 
2.37.2

