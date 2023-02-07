Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FFE68E17F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBGTvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBGTvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:51:43 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1514D12581;
        Tue,  7 Feb 2023 11:51:42 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h24so18180517qtr.0;
        Tue, 07 Feb 2023 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpHxdjVND2Ijxeha+NuAqWy/9hR8PjmDEfYLnrqJ3Gw=;
        b=QiILJlpAWijk5p3sqtTmAeJsYLY6kysn7zAe8OFpYoyW0yeGRS9y7fRYEY3zZ9aNz9
         L9J3SexFkbMREPAHI6hiThtmLoCpvRctoKh+ZG9miEFzxKUu47BskA2gWwkST/xaY4bp
         HptPsXMF9FH0Igwynjyk8PnSAMWO26UesqDBsaR9qpMZQ/NpKejDgpraGHNwGG+OiI5B
         HfmZw3j69fwo/szICAc0BIECFEtUObJfVKjxykQkJcN3xETm9un3EbaEN9mEjfSCr2V6
         LwINcCSmqBGhBlqxYGhZxsNg0gC6DDk97NOk6ACCmYfUZRjbMkenGOETNMTUwKOB1VcY
         zStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpHxdjVND2Ijxeha+NuAqWy/9hR8PjmDEfYLnrqJ3Gw=;
        b=WPX4/W5ilTSdcjvU66DBbaM8xogNgLcNw32DmNx7qZvghq3MDY7TJw8OWTiPtsbI85
         BD43TSBkI0eGLSIAcc9G5Wz2LJPI3BYOpccstLl1hL7EkAH1crWd1VodDAenj4aPvC/2
         zXkC9nTrtqtgRtD00zf0jzZPpMYYmJth6u2CegFe2znxBgbYeQErcvh2C0XBThzTfFm+
         ZWZ28LH72EzfDdktOQLCTOERQGM8Jt1KEW79xXDKAQE8sYU2eh+0hX8J91sP6ktTbEtM
         a3s+Xx/gNhqQiBEgVPbLDs3lJIoIlrDFC/PNrhKOQM/qK6Rb+CWSLFzhc9kx0gPP6mCF
         PrQQ==
X-Gm-Message-State: AO0yUKXoOHFgosJidOaC4Eeb7Pf15Te+FWaGgc8PqihKavbk15zPx9Fg
        e9fVVtlzwvrM9twZIqjTIeVoop7d0YS11l3H
X-Google-Smtp-Source: AK7set/l0NJhZWvp1udTwWEUZnBGgXToR8fzMz2zrn9+6pikaIfBagZni44zyNbXObo06xbeFxKn9w==
X-Received: by 2002:ac8:5fc1:0:b0:3b8:293c:24eb with SMTP id k1-20020ac85fc1000000b003b8293c24ebmr5518633qta.30.1675799500915;
        Tue, 07 Feb 2023 11:51:40 -0800 (PST)
Received: from walt-ROG-Strix.. (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id n13-20020ac81e0d000000b003b9a4a497a1sm10032738qtl.86.2023.02.07.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 11:51:40 -0800 (PST)
From:   Walt Holman <waltholman09@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benjamin.tissoires@redhat.com, Walt Holman <waltholman09@gmail.com>
Subject: [PATCH] Add support for Logitech G923 Xbox Edition steering wheel in hid-logitech-hidpp. We get the same level of features as the regular G920.
Date:   Tue,  7 Feb 2023 13:50:52 -0600
Message-Id: <20230207195051.16373-1-waltholman09@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0f8c11842a3a..de1f385b0ecc 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -819,6 +819,7 @@
 #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
 #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
 #define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
+#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL	0xc26e
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
 #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
 #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index abf2c95e4d0b..4dc833c8a44c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
+	{ /* Logitech G923 Wheel (Xbox version) over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
+		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
 	{ /* Logitech G Pro Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
 
-- 
2.37.2

--signed-of-by: Walt Holman (waltholman09@gmail.com)

