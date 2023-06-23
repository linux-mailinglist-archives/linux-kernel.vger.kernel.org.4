Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5507B73B185
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjFWH2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjFWH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:28:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8048E1BF7;
        Fri, 23 Jun 2023 00:28:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bec86b9c9so271873a12.2;
        Fri, 23 Jun 2023 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687505297; x=1690097297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzzWIUqJqm2OuJAK4dd8g4504MuqeTJf8AOG83ShyXE=;
        b=eybeGszegtYlu85i8eqPO8VWOoRF4h+nnaYfdo6yu/jE/3s4D3eDra73Y21vyvzbtY
         f8DMnhqvUdz/nxIzLGpHfSzuKjNdfBSWZ8D+6iRS4ttbYGJV12m4UUY1gracHXB5qFu6
         Pm5gQXDm0e+fA+xafKGWB83hg3q3SCCoGkstRELAIrmM4f4t/PF5DzYl0raGFyQIjw+3
         UGbxEH+/YDoB9MW74008yBA4gCFZsBe89VFco1pJHwx7Qq5p1m+GYAjnQ/yDGdbKhEZx
         hWnQb8BLGqZgdS2IpH37GpXVCNW7qjppT0JaFFXFDu6gKVALb2NLFUfKyO6v44RDdFs6
         MWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687505297; x=1690097297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzzWIUqJqm2OuJAK4dd8g4504MuqeTJf8AOG83ShyXE=;
        b=J1sCLdOCutQXDj+rcaEQq6YuMliMQKdz/OwR4k7gQuqN6yS6UH6GNXldsFol5qSpVk
         i3D3+CXW29PObb4Pn7JMxOkUJ4wcvB5LffVqLeUwVF6hu0yMhmi8ZOZBecX1UBLmtuHl
         yzN2nNW1IetqHbIE+VKAAHC+g38u/FV4JDnbERPV6ZegbRdB1eJvC5ALtWu7QEl8lYg5
         Xy81MMyPWM/PPoxHlffFuIRGCLyLDgA0UIUNvWDzYQO9vriRLOMWhj85RNUghSVZFXVv
         pN3+SQeulnmfZ/jHar1FLEfu7PiyqUZ4SW8Q5g9WUlkbksvOX7Is3ZLhQmE/vpgK3nH1
         jZOQ==
X-Gm-Message-State: AC+VfDxBnWLen4yVcKouOPdAznVPJtdzI7y8FaH8DZ5+51CUFHbAD5s8
        75w4qy1n2vXVelJds6ReOdY=
X-Google-Smtp-Source: ACHHUZ4zFfs6lrFuFXitVlLCFimYeiT8ZJNngc8oYzOFzjbjQwkYh+FPMaMFxMs5F8fhzkkmv4YhHA==
X-Received: by 2002:a17:907:843:b0:982:84c9:96c5 with SMTP id ww3-20020a170907084300b0098284c996c5mr19530961ejb.60.1687505296795;
        Fri, 23 Jun 2023 00:28:16 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090614d300b00982d0563b11sm5637811ejc.197.2023.06.23.00.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:28:16 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 23 Jun 2023 09:28:13 +0200
Subject: [PATCH v7 2/3] usb: misc: onboard-hub: add support for Cypress HX3
 USB 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v7-2-f79b4b22a1bf@skidata.com>
References: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
In-Reply-To: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Acked-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 3 +++
 drivers/usb/misc/onboard_usb_hub.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index b31548cd60e7..b8d6b26cd531 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -350,6 +350,7 @@ static struct platform_driver onboard_hub_driver = {
 
 /************************** USB driver **************************/
 
+#define VENDOR_ID_CYPRESS	0x04b4
 #define VENDOR_ID_GENESYS	0x05e3
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_REALTEK	0x0bda
@@ -428,6 +429,8 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_hub_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 41a4127a92dc..6f446fe7d2f7 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -26,6 +26,11 @@ static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.num_supplies = 1,
 };
 
+static const struct onboard_hub_pdata cypress_hx3_data = {
+	.reset_us = 10000,
+	.num_supplies = 2,
+};
+
 static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 	.num_supplies = 1,
@@ -46,6 +51,8 @@ static const struct of_device_id onboard_hub_match[] = {
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

