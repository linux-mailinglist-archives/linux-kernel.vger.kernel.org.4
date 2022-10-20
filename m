Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB14606583
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJTQOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJTQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:14:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF4DEE7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:14:29 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z9-20020a17090a468900b00202fdb32ba1so1871499pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hkX5nKlhQ/TrI2mbSx0miDUCy9S+/kM4hXZnMa/gNZs=;
        b=LBnxNhJE5Ik9FjyUR6Uw01rjCvO4wgUO+BCw9GX/+ayIWVLOkx3bCwr2ETERe66Eo+
         xjw2IWH2V+0nl0rgUX0g7s6bB4mse2E6XRC29GHmSomTfJJnwZALGJJyhZWPlZnaOZbx
         BKct+2L7uWOeyL4tjBBeTYYBbY6rjB2eo+KXrTrBolSW44U+lnfuAEu6ocrjyNl19XZX
         L3juAmNUi4GcF/a6PTXdQzPkajHgX0q7QPkKU7HONItJzoHwF7fLbiDJdyd0oIAyw3se
         ACdAJkywSHGKPGkez3dkCufZwGl18lQGMliWsWm46z7CQByMCxwvjnGklzglEROIlTvT
         RotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkX5nKlhQ/TrI2mbSx0miDUCy9S+/kM4hXZnMa/gNZs=;
        b=H2ualglaD6NGS/5Fan7/lkPEX6S6fxOc6oJabQ2LSd8FmlRu0pA2G7oJ4tvA+4ozco
         p4fv4mhrm3XXr7fiYcuIEPwJQj9GchyUGyx7OJ3t+ppU1FvQhRRcoDZVtOk6PkJWLV2w
         y7xPLGe6ZKZGvDc7dQFZ+t8uyVy80Bs+3KpMnTD7j7EbC4AKF/OPD+39ZbGwJ8c+Aaex
         SMhY3tHNl5jrBMWY/YTegEgB32tSF76h4wxzPRA+VawB9DqZSIeKyM+nNE9qg0wGzis2
         JhanlvZ/fghBzp3I5+z6eZKydgSb4nqSivuIASVxhbhlGm8/AUBXnMJACnpo6hFsKegX
         E+Qg==
X-Gm-Message-State: ACrzQf0LOPqtI34HnIr4xIDbbInMQJbyX1cP78JlH7Zzww+IGmFbipji
        H8hfFue9g/8Zdd6XjvZcg4zaUsQ=
X-Google-Smtp-Source: AMsMyM7T+fFcJkP1w/E13ym1azio4l49QEJ9D+j2qYquJ7qqA+6cxLumXVBGVl+L3p6PuCzC/vNJIwM=
X-Received: from svv0.mtv.corp.google.com ([2620:15c:211:202:b62c:23f0:d55a:5c42])
 (user=svv job=sendgmr) by 2002:a63:6b83:0:b0:460:c07c:553b with SMTP id
 g125-20020a636b83000000b00460c07c553bmr12370283pgc.209.1666282468718; Thu, 20
 Oct 2022 09:14:28 -0700 (PDT)
Date:   Thu, 20 Oct 2022 09:14:01 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020161401.941927-1-svv@google.com>
Subject: [PATCH] Add rumble support to latest xbox controllers
From:   Siarhei Vishniakou <svv@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
other xbox controllers, such as xbox elite, should also be possible to
support in a similar way. However, I could only verify this on 2
controllers so far.

In this patch, add rumble support for the following 2 controllers:
1. 'wireless controller for xbox one', model 1708, after applying the
   most recent firmware update as of 2022-10-20.
2. 'xbox wireless controller', model 1914. This is also sometimes
   referred to as 'xbox series S|X'.

I verified rumble support on both bluetooth and usb.

Signed-off-by: Siarhei Vishniakou <svv@google.com>
---
 drivers/hid/hid-ids.h       | 2 ++
 drivers/hid/hid-microsoft.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index da86565f04d4..e9c7eae849b6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -914,6 +914,8 @@
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 #define USB_DEVICE_ID_MS_SURFACE3_COVER		0x07de
 #define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
+#define USB_DEVICE_ID_MS_XBOX_ONE_S_2021_FIRMWARE 0x0b20
+#define USB_DEVICE_ID_MS_XBOX_WIRELESS_CONTROLLER 0x0b13
 #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
 #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
 
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..2973e91fc7a1 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -448,6 +448,10 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_SURFACE_DIAL },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
 		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_2021_FIRMWARE),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_WIRELESS_CONTROLLER),
+		.driver_data = MS_QUIRK_FF },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
 		.driver_data = MS_QUIRK_FF },
 	{ }
-- 
2.38.0.135.g90850a2211-goog

