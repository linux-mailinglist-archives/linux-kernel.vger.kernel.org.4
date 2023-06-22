Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0673992F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFVIRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFVIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:17:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF8D1A4;
        Thu, 22 Jun 2023 01:17:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51bec5c09ecso226025a12.2;
        Thu, 22 Jun 2023 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687421852; x=1690013852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsTfcmeZLSti/WbWnSJd6vFVwFkHrC8fIGZrK2b/Xtc=;
        b=o8thvPezk81i99v1b7tTy4SNJp78pLvwur0omjQNopZthDASYL8truAx+XjOMpHuGk
         1xrP0jfvjpLBot+vNOXdHm2kB6I08Z2az5OOZjhlGLlqIvHpTWhO2DKwU+Yr25Xza6NN
         7L33jUoKexgMSQrUqg6L6LxaOiW4/671wHDYeadMNHBUz/p6H4BQwOisykszxP/TlrMu
         0R312IgXINkE9ACX5t5Tqb9vx0itZB88w0BAdgfEB8ee4xi4uiLdvoUEJA/mKoumyUuG
         LKdfJKQPEAWzSBe86ST4eSm2+m0cPZxu0EL0z67j0bWN1UGCASS/b7QA+wBE5m/lr/JC
         jaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421852; x=1690013852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsTfcmeZLSti/WbWnSJd6vFVwFkHrC8fIGZrK2b/Xtc=;
        b=k7/iqtoe11Tl7dLO+Apu0irWEn5JYRBu4wr/ujgEIrbfuqR+yEesOuQsHC1SCPFJ8O
         ewWsE+ItjKxUukYy8IysBNNA8kpbl7I5sUsqpRYkkL/KXKcuF6SLBpmDf+DyDHuyOpx8
         dq5M2FZIDHQIFzbrOOONPLwR6h5fQbZ+ZFwICYKjUfeq1lZ3v6Bn+EcaUsf21kF/rpJY
         hKeO4EW/Sd4dos/a2aj1Y9vCAOHKFxlAxq5GJ4D3JLzMOGTN+VZQSegNeyWMTTW8GPoR
         QJyrJUL6h5NtX+yHUwiD5NAa+g39CBD/v9y+xupoDmXy80Sjd0zDkD8jSDve0ihIQPPn
         kElQ==
X-Gm-Message-State: AC+VfDx8QGKKuZMeygTljc6cz9DgdHE5jn36+EEstb+luX+uaPfXVAFn
        kiwHVSCbhGSMPhbon6D4IGduC3G2C1KsXw==
X-Google-Smtp-Source: ACHHUZ4p1+u7e5mHg1dqd0Px9ZNy4KBCEjGtP2FLrRg92lTt9lKe5tuN5PINVvC9Bs3H+4X2dz1AWA==
X-Received: by 2002:a05:6402:4b:b0:51b:d79b:28ed with SMTP id f11-20020a056402004b00b0051bd79b28edmr2824607edu.12.1687421851683;
        Thu, 22 Jun 2023 01:17:31 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id k22-20020a056402049600b0051bc58b8dbcsm3577886edv.59.2023.06.22.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:17:31 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 22 Jun 2023 10:17:23 +0200
Subject: [PATCH v5 2/3] usb: misc: onboard-hub: add support for Cypress HX3
 USB 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v5-2-319c9c4c846f@skidata.com>
References: <20230620-hx3-v5-0-319c9c4c846f@skidata.com>
In-Reply-To: <20230620-hx3-v5-0-319c9c4c846f@skidata.com>
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
index 1bbbc6948484..5a528de1189c 100644
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

