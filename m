Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51400612462
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJ2QMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJ2QMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:12:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AF3FEE9;
        Sat, 29 Oct 2022 09:12:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso8290631wma.1;
        Sat, 29 Oct 2022 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVq/27+BODVwXDvbhB9aF4lOvnY7b7DgJThrg3Kmek4=;
        b=IIe0TxqD14AXA+JM8LlADgyM6x3tDQlkiVXhQD5xunyEi0NLwjaeJBecup4qovTSCM
         IQ77GaNPAlgTTVB0CsEH0h90yzy93Sti+mIindlAB5uBewRQFIBcYiaxizDPhAbVpYSM
         8aatB/r9Cu17yK/HZBteiA/KxLSLlGtZew8pnp79LVpfsXLvIIAV4LVZnHgEhNnub/LO
         fV45GTf6FpvUIrJ2vLy0zGuTUsXnLMVMf8q6AlO4wtEQPzeaDFOQhb18NEkP3RLlayI9
         29i7VdHxqC5TWvYmsSwqSwHRe5dtg1kP4l4IwV3IvNZaNle+lpn5F95Cv2G+TuXeZ49H
         UD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVq/27+BODVwXDvbhB9aF4lOvnY7b7DgJThrg3Kmek4=;
        b=Av5A9R4yiybZFjRW6dr9jfpomhmJ4U1xVKuvay+8JVGINjdxVbtQXM736e6SzkJIMa
         vQ0jj2WFXGTREHcpxmeKVSuiYSjj3xIIM/vFV54BB6FgWbKDjVtzdxk77W43hzjgwBeY
         p6F/iAulaRoIdc+GCSNO4OpAUUrSpOeH0VEiJlWR1Zdr2QFCJoRp85gqk0dpWQdFOJkn
         L2AoCccP2CjD2ZYKxR0fKx87WqBWnCCoOguHUcTGtJk7jCFZt7zbApyTiCoaao1GQ0bO
         0vQM7cBeYQrNhkIMkKgHkgNLPWU0sie0BVvbY91Oedyx2cr6kZ8kmoWd5LEj/MjNk+D8
         M4aA==
X-Gm-Message-State: ACrzQf1/eGw4zQz3q2LbL/8MZJD25J+Dw2hgXSasaX1LL07Tggs+clSl
        Mm/rq02p9KB3QYzn3JP/msU=
X-Google-Smtp-Source: AMsMyM44lLKJjdFBabamwyZkXKKTcBlE85HP5dtgPSUblHTIfCyZq6I7EGKN8rD+b75Yzvu5Shq+6Q==
X-Received: by 2002:a05:600c:198a:b0:3c6:f6b4:68d5 with SMTP id t10-20020a05600c198a00b003c6f6b468d5mr2745683wmq.14.1667059965123;
        Sat, 29 Oct 2022 09:12:45 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b0022efc4322a9sm1858471wrd.10.2022.10.29.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 09:12:44 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>
Subject: [PATCH v3 1/2] HID: input: do not query XP-PEN Deco LW battery
Date:   Sat, 29 Oct 2022 18:12:39 +0200
Message-Id: <20221029161240.15548-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029161240.15548-1-jose.exposito89@gmail.com>
References: <20221029161240.15548-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XP-PEN Deco LW drawing tablet can be connected by USB cable or using
a USB Bluetooth dongle. When it is connected using the dongle, there
might be a small delay until the tablet is paired with the dongle.

Fetching the device battery during this delay results in random battery
percentage values.

Add a quirk to avoid actively querying the battery percentage and wait
for the device to report it on its own.

Reported-by: Mia Kanashi <chad@redpilled.dev>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 859aeb07542e..d728a94c642e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -340,6 +340,7 @@ static enum power_supply_property hidinput_battery_props[] = {
 #define HID_BATTERY_QUIRK_PERCENT	(1 << 0) /* always reports percent */
 #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
 #define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the battery */
+#define HID_BATTERY_QUIRK_AVOID_QUERY	(1 << 3) /* do not query the battery */
 
 static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
@@ -373,6 +374,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100),
@@ -554,6 +557,9 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
 				   field->physical == HID_DG_STYLUS;
 
+	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
+		dev->battery_avoid_query = true;
+
 	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
-- 
2.25.1

