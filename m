Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95197738E19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjFUSET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFUSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:04:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA79118;
        Wed, 21 Jun 2023 11:04:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98bcc533490so134274166b.0;
        Wed, 21 Jun 2023 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687370648; x=1689962648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRlhBIlz2LBzIDKg7c8oPwkHRIFdsrq3VDzDlliE8AY=;
        b=B361posBnVUUzTMbNdV1X+3MlLjtLpn5ot+En1Dk52GIdnNCxgTfqt5eCW8vOsvIJO
         FdAHN2bwwuWlfyY8a5VzqM93TUsS5KJvuhTwqGrZAiNyvFJo4xhPoO6odL5cMvrpZmWe
         nxAQtb1PHJvJChtBg67kGdEUyrnwlADZ+IE9h7FYP8X5sFJznkZKUfxIBi8mO6H1aT2/
         e+cyADZdAVP2g2eX8FFdaYzTyzFAHKkAtGGRapzoff2QWTrw6X5SkcGwigPJuFin1kS1
         PgvgJb/muQuR6DLOUJUdkRvYvyPuxq3WnCKfNQFSlfUJU5Hh3CvuTrixMaTNQDv3Sxu9
         YmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370648; x=1689962648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRlhBIlz2LBzIDKg7c8oPwkHRIFdsrq3VDzDlliE8AY=;
        b=Z2btpfzxA0wQOo4Z/nEr7e8wrTNcmAuqeO97lICqRvQbt5SlhQeHl5Ri1OXa2qowdj
         2d88eotp7uKtxvxxPNQnAgVjeqLt06dvPYLM0++q/HPrvr1BAHtOs6G3W3O/YjaEMlC5
         5eRd/vCZE5i7E0egoY5T+6slUTdlEnuExrHy4y4lpD1Z2Q19GsBhBn2N+UBJ8o6rF4X1
         AYi5h7DY7H/v357MIGI/5AhSANmBiPZlB3MNUIW/JwEL9kilLEEktM9SE5DKDRDVm2VS
         Lnvwb2rLL4c9++7MrZUk4xa1Q7ylqVv+Od08EbxovAPVkPDNKlovW3Vwo3Xqc907yGdX
         tHrg==
X-Gm-Message-State: AC+VfDy1KWwVZRp3b0Iyqo3+aNcELsqYLAOSd0bvbY3/WEZBhNGg9JC1
        Nn0+BghYYat+H2vJjf5EEAzjRMcdR146Dw==
X-Google-Smtp-Source: ACHHUZ4VxTdGPJSlkAPBjj3MztWnwqotVqadZ2VDxGdbSpCpslW03BdxN7HvRAowNwXDi3oLVfX0EQ==
X-Received: by 2002:a17:907:803:b0:973:ca9c:3e43 with SMTP id wv3-20020a170907080300b00973ca9c3e43mr14325037ejb.45.1687370647736;
        Wed, 21 Jun 2023 11:04:07 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906b10d00b00988955f7b5esm3460779ejy.157.2023.06.21.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:04:07 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 20:04:04 +0200
Subject: [PATCH v4 2/3] usb: misc: onboard-hub: add support for Cypress HX3
 USB 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v4-2-e56b3c6db60b@skidata.com>
References: <20230620-hx3-v4-0-e56b3c6db60b@skidata.com>
In-Reply-To: <20230620-hx3-v4-0-e56b3c6db60b@skidata.com>
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
index 067511e8a976..dff95f9047f2 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -355,6 +355,7 @@ static struct platform_driver onboard_hub_driver = {
 
 /************************** USB driver **************************/
 
+#define VENDOR_ID_CYPRESS	0x04b4
 #define VENDOR_ID_GENESYS	0x05e3
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_REALTEK	0x0bda
@@ -433,6 +434,8 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
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

