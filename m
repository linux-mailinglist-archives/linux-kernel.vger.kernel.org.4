Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89E6ED992
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjDYBGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjDYBGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:06:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C027AB473
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:06:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f35dea7b5so9717187276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682384785; x=1684976785;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kJ4dN/YuySrvUIs/enujhHHGSPWuQqyoQR87FuK402Q=;
        b=QI7ARTol+8BwQsCq5jxd1hn2kfCBEx7PDlKSrtbl953Es0s97aJHc42EqM3yHe/w/f
         jNi4AYANNZF5yL28tT3UPxWsee2y3E/BwSvVNO5UX99fcEReY7qhtBA+vyjLcVDZ7ops
         QR7PlCzd5x/ZASA/97xD0PPP+5kVwbmDR4mz2Rb8ogp9XV0Llinj6GtTcVgn1cDps/kt
         0HmnvBPOezTSbg2dc/l24HblZteVUzi6RfVasXQY/387C38HTqHyuNo2G1d/WnZvZ2Qf
         baFg/gi+3QNtqmCtTibHYHATodfq+NPFzYKTzX3hks7s3MF19ag167DUv1J8oFuG0KsG
         KLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682384785; x=1684976785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJ4dN/YuySrvUIs/enujhHHGSPWuQqyoQR87FuK402Q=;
        b=ZPQlZiLtkwpcuulrhGM327nkMI8uRi0LMmC7K9J6MN77zynRPy6jj7mHRVfPjyj8U2
         5enZ8RkYLXfE3xqv5bfQ1wUpt9/sRvMI5+kNuutu1PCjhxx/O/5hpLL75ZIRAGCNXv9y
         NfqMLoVqpMk1aoPrYy1esLn5bFnHGOIY0INd+OcYTEiktKhN5UI31b9aS0JpozHjEFkh
         6id0+rVnuT/E8/7QsexIyozrDuwPs1uVGD07IZ5fYIytpxO6poIZVInA3TsQ3psfv04T
         VMfFJKmtG26r6Ell+8Zx7XNElQYXUiOPxzXpeOgmUY5lvOktHvthpzzutYl5s59GQ6Cn
         bYGA==
X-Gm-Message-State: AAQBX9dpy5Tk5QzjEY7f6E92FErNUz9nNMgb7BddH+EsUYWsXTJOO74o
        jPZyPatxwX5HptDJmY8gExIuSRg=
X-Google-Smtp-Source: AKy350btIErVFFu8o1u284VjPmCyRQUu9JJGrRDwVn6ksxcieXL5vi+CruupFfZUVahx0qpXKYFQa4s=
X-Received: from svv.mtv.corp.google.com ([2620:15c:211:202:4794:ab0f:f56f:803e])
 (user=svv job=sendgmr) by 2002:a25:d7d8:0:b0:b78:8bd8:6e77 with SMTP id
 o207-20020a25d7d8000000b00b788bd86e77mr8274467ybg.8.1682384785659; Mon, 24
 Apr 2023 18:06:25 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:06:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230425010618.2303982-1-svv@google.com>
Subject: [PATCH v3] Add rumble support to latest xbox controllers
From:   Siarhei Vishniakou <svv@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Siarhei Vishniakou <svv@google.com>,
        Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Siarhei Vishniakou <svv@google.com>
---
 drivers/hid/hid-ids.h       |  8 +++++++-
 drivers/hid/hid-microsoft.c | 11 ++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 053853a891c5..5d98b2a3a5e4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -903,7 +903,13 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 #define USB_DEVICE_ID_MS_SURFACE3_COVER		0x07de
-#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
+// For a description of the Xbox controller models, refer to:
+// https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary
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
2.40.0.634.g4ca3ef3211-goog

