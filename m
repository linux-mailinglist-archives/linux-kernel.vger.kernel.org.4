Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B5738A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjFUP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjFUP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:58:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFC710A;
        Wed, 21 Jun 2023 08:58:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-987a977f62aso560032066b.1;
        Wed, 21 Jun 2023 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687363126; x=1689955126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz7/LsPoj07PHZZXl5TA0hPQYcayGa5OFB1Suxc3qHk=;
        b=HxS/vtFfvo1S+gNIE8SlCZwfaiMOw4gQjS/nLFWlpFbMkPlzJXA4FVQkSr8RGqkDWm
         MAXBitqAD1qthvkeiCebCZhGD7RXpgfnCtVCqtv1BdjIbeEcoT5zy7UgLl8hIyRtYW7T
         EInl+Vtt0buAhjrBnSwl/X+ruDz90x8AfKpHd2hereqBsQJqliQ84pB9ev0wF+Y3pSWC
         /oDOEk15dw2YdJjodu+OsUtn6LAxSn1B0cSn0ZR3UiytUlZjd6MeB8mMQ4yS9NSORUHM
         wmu0ao3qEwUQL1uzrPE1MXBZFZ208sUCzYTW/F1bF5MT3t64KD29fqlpPiCkw2KsgU5D
         Iy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363126; x=1689955126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz7/LsPoj07PHZZXl5TA0hPQYcayGa5OFB1Suxc3qHk=;
        b=dKHhiUJfwOSeRU0xhVGCKQWC69rnZUEDPPfKWjXoItjHbsBM0Ox6P/b7U4kRtdbCnY
         bzUtmm8LhLcKYNXNNeBHdnO+mgCHoGlEvzJ3T3R2q0yi9NZRTGFIVUrufUL4fkjpjw5t
         vGUwGsUZ1yMU1aALfgZZ9YrS64HzkOOqA55rAu2z5wrEUJq6CRhwmEqawwMayImTVeWc
         Ph242jKRP3ZJX6dWUn633BE4flrrBPAqDoBU9d1FiqR+jwiM/koh0JtHcTQggXZbjdar
         27CMc898hnBeNAEmDs7m9chiZCP7n24S2yaJMxfs0Q3xCkjCtbL6IYPkC0i0EdoUmftY
         NcwQ==
X-Gm-Message-State: AC+VfDxF59AVJUObGch4ZH38LoKyU8KZIBQw0XPA23fOAiI9eUNGSxiZ
        oJeuY0TOD4fiKPSwrozb1C0=
X-Google-Smtp-Source: ACHHUZ5xqgn171ILi/CO5qFwGxxRXF5fl94v+gA61qXv1JQ9zIfx5YWlkYU/1TKufvBqvUX2prP1SA==
X-Received: by 2002:a17:907:d17:b0:989:57c0:444f with SMTP id gn23-20020a1709070d1700b0098957c0444fmr2826474ejc.77.1687363126001;
        Wed, 21 Jun 2023 08:58:46 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709060a1400b00977eec7b7e8sm3349316ejf.68.2023.06.21.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:58:45 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 17:58:31 +0200
Subject: [PATCH v3 2/3] usb: misc: onboard-hub: add support for Cypress HX3
 USB 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v3-2-2acbc03ca949@skidata.com>
References: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
In-Reply-To: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
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

Acked-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 3 +++
 drivers/usb/misc/onboard_usb_hub.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index a56e712d3a45..3826f4fdcaee 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -352,6 +352,7 @@ static struct platform_driver onboard_hub_driver = {
 
 /************************** USB driver **************************/
 
+#define VENDOR_ID_CYPRESS	0x04b4
 #define VENDOR_ID_GENESYS	0x05e3
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_REALTEK	0x0bda
@@ -430,6 +431,8 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_hub_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 7a6d497ce849..8f8e1001368e 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -23,6 +23,11 @@ static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 };
 
+static const struct onboard_hub_pdata cypress_hx3_data = {
+	.reset_us = 10000,
+	.num_supplies = 2,
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

