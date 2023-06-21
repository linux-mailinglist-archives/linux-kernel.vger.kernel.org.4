Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2817386F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjFUO1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFUO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:27:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031A119A3;
        Wed, 21 Jun 2023 07:26:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-987a977f62aso548682466b.1;
        Wed, 21 Jun 2023 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687357601; x=1689949601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcKKa+7GIbUbn3aIE6VV0tQ+KglpEI27I8tdXAPUVmE=;
        b=Rft1ZcHbjS+0PnQAzgXbc0duGtDgNU92Y3/fCrC+UCURUsCbQrKvURpffGO3c1GRB0
         iRY65I9f0YEADwgNBkb9+HRddotuXR6txlKh530OI6wCFl8l1mgbKM7e0BGbeXvuqGyi
         C99Vwgx/6P5p8vRCQZETJYzZYzYaCi9NfKL7sAiEL/CQ5nD6QIMZ5Qucmlab/6bJxsWj
         6tGpc06sw0mpirT+Dl/1qlHghDCTFT3Kd+VXRjD0HeguNyKL0MhtEd9PiA0trfq0qK3q
         czY082pxlYOSIY45KyGw1Gr9v1FVhcFId9Hw1yyjlJFm+DoZV/RtzlFalvl8Hb4ElXkf
         9CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687357601; x=1689949601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcKKa+7GIbUbn3aIE6VV0tQ+KglpEI27I8tdXAPUVmE=;
        b=b9XwKFv4h6TWoQD7EFhcgoTcsKuC5V3byxtwD6/m9DRYyKeqgCC3/5RRO8+HUedUOv
         Sd+QvuGCNx6DqmvEZd8noCWa7EpUXFjuHcFpRWIW/t/yd87TFRGGzNB2p7geyDxXUfWV
         hLP/kz1ZZ76GiSuBb5qX9brkdelQ0Qs/NoNUP7o9/HgqEVDhmfQFt/aykK4wkxT5rfvd
         N6Odvxf1qcYwmEIDbTPxJInfHdIUIenC/45eQN71Clijqn7zaKY8s+RKcfA61dMu3xe1
         cAX5wJG61daTeIIa19QPJSsNl9PjLksHkM/srII1E34djA56SpDJghjCk37DiivJ6CnL
         SpRQ==
X-Gm-Message-State: AC+VfDw1DIySQwv1oZJ3efOFRrV3fAlY7pek0mRJ6EobHIY8nyYFiZ3T
        dhUpdLdjEyVFqeCSEKLHw6c=
X-Google-Smtp-Source: ACHHUZ5G587pM6Aiojr6sHXnPyDfOizNOGotzhHpzsjZmt4xzkyNgnwI/noBBxbBRTt6b8OiDFMWjg==
X-Received: by 2002:a17:907:3f18:b0:983:cb6c:8aa3 with SMTP id hq24-20020a1709073f1800b00983cb6c8aa3mr12795543ejc.59.1687357600935;
        Wed, 21 Jun 2023 07:26:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906644b00b00988956f244csm3266156ejn.6.2023.06.21.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:26:40 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 16:26:28 +0200
Subject: [PATCH v2 2/3] usb: misc: onboard-hub: add support for Cypress HX3
 USB 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v2-2-76a53434c713@skidata.com>
References: <20230620-hx3-v2-0-76a53434c713@skidata.com>
In-Reply-To: <20230620-hx3-v2-0-76a53434c713@skidata.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The HX3 comes in different variants (up to 4 USB 3.0 ports; multi-TT),
e.g. CYUSB330x/CYUSB331x/CYUSB332x/CYUSB230x. It operates with two
different power supplies: 1V2 and 3V3.

Add the support for this hub, for controlling the reset pin and the
power supplies.

Reset time is extracted from data sheet, page 24:
"The RESETN pin can be tied to VDD_IO through an external resistor and
to ground (GND) through an external capacitor (minimum 5 ms time
constant)."
V_IH min is given at 0.7 * 3V3 (page 34), therefore use 10ms.

Also add USB PIDs for the USB 2.0 and USB 3.0 root hub.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 3 +++
 drivers/usb/misc/onboard_usb_hub.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 3de30356a684..06e448b7e8cf 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -349,6 +349,7 @@ static struct platform_driver onboard_hub_driver = {
 
 /************************** USB driver **************************/
 
+#define VENDOR_ID_CYPRESS	0x04b4
 #define VENDOR_ID_GENESYS	0x05e3
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_REALTEK	0x0bda
@@ -427,6 +428,8 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_hub_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 657190bf1799..145e476b1d6c 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -23,6 +23,11 @@ static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 };
 
+static const struct onboard_hub_pdata cypress_hx3_data = {
+	.reset_us = 10000,
+	.supplies_num = 2,
+};
+
 static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 };
@@ -40,6 +45,8 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
+	{ .compatible = "usb4b4,6504", .data = &cypress_hx3_data, },
+	{ .compatible = "usb4b4,6506", .data = &cypress_hx3_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{ .compatible = "usb5e3,610", .data = &genesys_gl852g_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },

-- 
2.34.1

