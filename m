Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D795E8B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiIXJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiIXJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:54:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B221180A;
        Sat, 24 Sep 2022 02:54:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso4631692wmq.4;
        Sat, 24 Sep 2022 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SGS7ZGHA9U7JhRNEjJ9IGXDqpK+gxBOatJJDrYnLUls=;
        b=KrT9OEebP5sUhfxIMlKzH3o6WDrprCnDPzLmfJyApLurRi1iTtZxVPCAyXsqJI8bfT
         J2sBikNGUYOfngm78P9FnYDFC3ax3HJAQf8v3h1zdbHpRxwJgxYD1rIW/2WNI5FaxEoX
         AoiNXKVewAgRjpYc0XWjJhtHfgSPxJg7x8H4/4kEgPbbmE93wFd/0lQg/CT+C8cR0oYj
         uic4NglcV+0S+hs/SHvPtcoVVNk6kYHybhtzX9C9exY8f9NNQmUNC8yLdkiSX2FZ8Tbo
         /t6z38Ky2eI/Wdz4iNoFsotPg87DhP4kO4vLUfZpA9Y+NhlxHWRMyD6artMSrPTsnrNc
         ohKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SGS7ZGHA9U7JhRNEjJ9IGXDqpK+gxBOatJJDrYnLUls=;
        b=FRzSWug61Et/dUtDEtTtWMiOl9Loni37Krs+YElIp05uq8Jl/kT5qmx0KmOEEcqsM8
         p28Cvp9SEOilFy3d+W6aELg22xfBjQTKmyPGSbE//pz0UvC0MTBa4wHfZ0T7WGs5tySb
         hmgw3rWhpe2TVHTZHjFSfm1kTTZpDIkzkbv5RZG4nNyI1kYkB5P8IAXEVhyTZSINV3FS
         YpdMsASZ7HrEgnQbCTNbNzpyzvU+agKXtV/j2c+fvwvCV4UrWkyuJgTeDXJL5QARKjzr
         3ozku7t1gw6g+Ys+AVQfbfJuQn0PfUngeVbxZm+uEDjIcGDOVXBqAwVshsT/w/8125si
         15pQ==
X-Gm-Message-State: ACrzQf0C1mG9KUNEYlY9sLlZTqNJApx1cZ16Jl7lcWx4MZ0F37pB477V
        E+l9qCxfXWjRzRtedfnTRXc=
X-Google-Smtp-Source: AMsMyM4//1rI33+tVAS8HxUW4ySLfywsljYUaJjmrnvosoA5ozuLAZh2U4mUgJCqikYdwv0wXNBruA==
X-Received: by 2002:a05:600c:20b:b0:3b4:86ff:cd with SMTP id 11-20020a05600c020b00b003b486ff00cdmr15680385wmi.35.1664013274864;
        Sat, 24 Sep 2022 02:54:34 -0700 (PDT)
Received: from localhost.localdomain ([5.25.100.2])
        by smtp.gmail.com with ESMTPSA id c2-20020a7bc2a2000000b003a844885f88sm4776835wmk.22.2022.09.24.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:54:34 -0700 (PDT)
From:   Kerem Karabay <kekrby@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kerem Karabay <kekrby@gmail.com>
Subject: [PATCH v2 2/2] HID: apple: enable APPLE_ISO_TILDE_QUIRK for the keyboards of Macs with the T2 chip
Date:   Sat, 24 Sep 2022 12:53:06 +0300
Message-Id: <20220924095306.8852-3-kekrby@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220924095306.8852-1-kekrby@gmail.com>
References: <20220924095306.8852-1-kekrby@gmail.com>
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
index e86bbf85b87e..c671ce94671c 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -997,21 +997,21 @@ static const struct hid_device_id apple_devices[] = {
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

