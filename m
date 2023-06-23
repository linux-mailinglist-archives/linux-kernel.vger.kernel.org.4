Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8455F73B0B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFWGVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFWGUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:20:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E6E4B;
        Thu, 22 Jun 2023 23:20:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so215124a12.0;
        Thu, 22 Jun 2023 23:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687501250; x=1690093250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKQjc5YOaB7vV1Sz+98uyUAdeeRITnOW1R8Lc1F6Nwc=;
        b=R+0OED0+j0mYjghdhNh9bI7zUt8CAjQFnoaAVGEwEHx0jI/7HMhqtXZrov5lEArqoj
         cabqckZRmGecOshEe1NCfxuhV+/nHArMc0GtSdoafGvfvRYC2DXiCvKADHq6gPpaRIVE
         sN4jPjNPptF2paYWmCI1NBXzwXRwhGVsJcY4fnBuAR/O1uOvx4yK7vXY4x3mOOYuBXEf
         uva1U3SeBZAKSeSPtntDFZhgay4BoEN4F4qRVPDbSKtk/xoXdVCGFhW1knepZDlBSidB
         8TTCkEQVpaW27bEaa1wAg2ds8ft2SWzgmOqKbDvg7UHZzM3pM+awElcGjokwBa/lnEgU
         1A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687501250; x=1690093250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKQjc5YOaB7vV1Sz+98uyUAdeeRITnOW1R8Lc1F6Nwc=;
        b=UDSYFTtck30m/GZqLUHPsvsLEzwRTApIcKurrTk6wWjY/UdcA5Ps13l1qEvM8YsaHv
         YQahlZOwumrTvKk8TuT5eFCxBX6Ks2Qj9wO1/NmKrka9d8cG/ySXTXKBRxsFO5r3PzaH
         Cwk9KhFl218Euu/w9MSeIor8LUQBGWsMUXBqiLckk/4Zp5W/hXFcmtSuNTFMOk1SlIb8
         rMiVbWKh+cG8HpW+f6bUtrsYC3m0+FwPTVqoKGkPUwYflV0DHiTyjNu9HVtt+TOK4XeE
         6LzJnsD45oQmaeEYs7f9cc1nTZ5v8B3cIDu9Iqh5YsHXiBdiuSTa4Ta7ORrqOi4NDgDM
         EQBQ==
X-Gm-Message-State: AC+VfDxOQ4lu6vqY8Lgn3uvwEY2LMY059pYCF5h1CdD2O0kYZGhkmXoj
        xtvw686s+yvdxlYnQZSAb94=
X-Google-Smtp-Source: ACHHUZ7dWAO2ZTry9ZnDPqWePVehQaKq5eRH4aBgeDdCYBFQ0M2Y8AFWxz9HZqQJKDtgnLmV8/nn7w==
X-Received: by 2002:a17:907:6d9c:b0:988:9763:9517 with SMTP id sb28-20020a1709076d9c00b0098897639517mr11788916ejc.43.1687501249809;
        Thu, 22 Jun 2023 23:20:49 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906725400b009878b0b5302sm5630346ejk.98.2023.06.22.23.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 23:20:49 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 23 Jun 2023 08:20:37 +0200
Subject: [PATCH v6 2/3] usb: misc: onboard-hub: add support for Cypress HX3
 USB 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v6-2-6a1d6f8ce689@skidata.com>
References: <20230620-hx3-v6-0-6a1d6f8ce689@skidata.com>
In-Reply-To: <20230620-hx3-v6-0-6a1d6f8ce689@skidata.com>
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
index ff0bdd49ada5..c61317352503 100644
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

