Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3C6AF7C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCGVgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCGVf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:35:59 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A12A8808
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:35:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c039f859so150658357b3.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678224948;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UBRLflv0ERmYWEGxux8KOqlDY0ttAP+wczhdOTWc7q0=;
        b=h6ePJYurdp6mVaZhTcXLSGIV8hbDFCoivfyXcPh2EeTMhPrB8iO8CL8lk5emJrslV2
         pKzBWiayBqsS8mEOVZFdHBSYj12D/0YORA8xV8xvBeOt4igBBNkCFStqKkCWa0nOUYuE
         ts2zPRkBvHy9+dF6i+GUCHQrOzoZYdaa5Va6KIcu67GB2GbWvI72A04YmpWm2juj8S9w
         PP82f6TvEoOLLQ3RCxcawjj6/L6X8FVFX23WSronerhSVradTU3C3pMc+NZIm8PjWfMC
         EVSfSeICTXRpw0grj8A5LL4cEcd0mK/pPFOu28fDkv0/tjGpVKm1P9lzf6Qp521CVqy3
         Ag0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678224948;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBRLflv0ERmYWEGxux8KOqlDY0ttAP+wczhdOTWc7q0=;
        b=nr5dIUVr3f+Vp6SkobkUpW9Lp+oqDhZ4Hnognn0jT6XNjkBB1BO94d/rWHoA+IF1eI
         JwEw6bFkJVQc0mU0BzS4psa2aQYc+b98IK9XdNaSkIBpF/r+d6rzQ+2lSHwP1CBJVxBM
         HfEAuRZzxPY4lMnWOl0QB+v4T1SD/8eknafTAVdRuYhKyCxZ992Nr6v+nKRSFtFVoZUf
         vyTc8doPzMEzFxW7KuD0v9xl5yATVP78Ka9REl+iJvUSudV7NKhvRKlW9ZvwkJ+jGDo4
         FawUOt8I9pi7IBg8nWnoz8oXE5ujGF1lYwUXeqN8fd6BMB6G7YXDGGs9Y/tAEnIUa/cN
         YLZg==
X-Gm-Message-State: AO0yUKXzHKAjAQDqD0FAIrZj6JvVyZDPWk2tN0cG23lJaoXr7N/C6mBP
        mzZiQv+Pvu2fODl97rJbh3xtSXQ=
X-Google-Smtp-Source: AK7set/ZbRp1neaq/Th9h/MR15eb7wtXqy0EV4oqwdSkpMVPNAPt+XcwmOJdMWNOoS6hV/i6jm2sgzk=
X-Received: from svv.mtv.corp.google.com ([2620:15c:211:202:94a9:c9e2:405f:e3be])
 (user=svv job=sendgmr) by 2002:a5b:c84:0:b0:b1a:64ba:9cb5 with SMTP id
 i4-20020a5b0c84000000b00b1a64ba9cb5mr1766785ybq.1.1678224948418; Tue, 07 Mar
 2023 13:35:48 -0800 (PST)
Date:   Tue,  7 Mar 2023 13:35:36 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230307213536.2299487-1-svv@google.com>
Subject: [PATCH v2] Add rumble support to latest xbox controllers
From:   Siarhei Vishniakou <svv@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rumble is only supported via bluetooth on a single xbox
controller, called 'model 1708'. On the back of the device, it's named
'wireless controller for xbox one'. However, in 2021, Microsoft released
a firmware update for this controller. As part of this update, the HID
descriptor of the device changed. The product ID was also changed from
0x02fd to 0x0b20. On this controller, rumble was supported via
hid-microsoft, which matched against the old product id (0x02fd). As a
result, the firmware update broke rumble support on this controller.

The hid-microsoft driver actually supports rumble on the new firmware,
as well. So simply adding new product id is sufficient to bring back
this support.

After discussing further with the xbox team, it was pointed out that
another xbox controller, xbox elite series 2, can be supported in a
similar way.

Add rumble support for all of these devices in this patch. Two of the
devices have received firmware updates that caused their product id's to
change. Both old and new firmware versions of these devices were tested.

The tested controllers are:

1. 'wireless controller for xbox one', model 1708
2. 'xbox wireless controller', model 1914. This is also sometimes
   referred to as 'xbox series S|X'.
3. 'elite series 2', model 1797.

The tested configurations are:
1. model 1708, pid 0x02fd (old firmware)
2. model 1708, pid 0x0b20 (new firmware)
3. model 1914, pid 0x0b13
4. model 1797, pid 0x0b05 (old firmware)
5. model 1797, pid 0x0b22 (new firmware)

I verified rumble support on both bluetooth and usb.

Signed-off-by: Siarhei Vishniakou <svv@google.com>
Change-Id: I3337a7ab5f40759c85bf67bf0dbe5d4de31ce1ff
---
 drivers/hid/hid-ids.h       |  6 +++++-
 drivers/hid/hid-microsoft.c | 11 ++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 053853a891c5..c9b75f8ba49a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -903,7 +903,11 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 #define USB_DEVICE_ID_MS_SURFACE3_COVER		0x07de
-#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708	0x02fd
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE	0x0b20
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914	0x0b13
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797	0x0b05
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE	0x0b22
 #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
 #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
 
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..9345e2bfd56e 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -446,7 +446,16 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_PRESENTER },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
 		.driver_data = MS_SURFACE_DIAL },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
+
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),
 		.driver_data = MS_QUIRK_FF },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
 		.driver_data = MS_QUIRK_FF },
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

