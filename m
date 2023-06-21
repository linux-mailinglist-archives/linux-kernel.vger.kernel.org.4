Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C647F7380A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjFUKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjFUKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773D10D0;
        Wed, 21 Jun 2023 03:38:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988f066f665so329587666b.2;
        Wed, 21 Jun 2023 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343891; x=1689935891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s3qHdEa4jSrzOALknXiWv89VbVq0ZD8nrJZgk+0QcQ=;
        b=h9aaZN0iJqsREY8nwHt/MFJH7GUe7FNyiW1rkfsHYLygB3Gg5KM5DZYJ0CXPkyKlrX
         IYns6csWboqDv+tiN0WplY/VHz7bJ+ugDeDR8VeXTQ4rtsSw9PD/0+y5JQpb1OQjRz4l
         CUJcZr8vI64Cf1a9I2DliH9SYHdiB0YpF5cGNujc+WwpB0NxkFZGyzL2TLaH+S56AD3s
         I0jV9kGiZNbDNybs1rqvNVs53jlqAtTBv7NSQ1xnk0DODtHpPIAKJcZxC0/dYUFBm7u8
         i4heGXz4nzPjlRvwek2zG01aVRFkoG+qzSnxD8JvL6sfM+h33i1yLlE0bej7Db3jmfya
         UJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343891; x=1689935891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s3qHdEa4jSrzOALknXiWv89VbVq0ZD8nrJZgk+0QcQ=;
        b=QacBsLxc+rkynN1H9v4KS0eLEFjE6/xPXvyudjbYD72lJ3U+UxZPkwroOgDpbmVVgt
         v3SGQq/F7o7mi/rwc3818OoyDHmGiAFVeGLs1kMqX4c19x92yszjWh/W3g1+WWs+quQ1
         p3I81gICw3xo6T6H6YjajVHPMFtTUVJVUzh9cSIj4Rxl2j/csxRsHfSzDKuvlnKHtpar
         6reD40lMpUiTXuOOk6E62fKy/0CWBgSNg9QriX6IJN1ZlYpG/WqG+C5GBnr+KfdbP+H6
         1W7SD4WzIgl3Wb/Ua+wTtvTUZ7tHchSj6Le/U+HGT4+TFoO1EjcNtUZKi31bPlqhY1Pz
         ayLA==
X-Gm-Message-State: AC+VfDxIqeN8Vm18YPFiYBEZTyoTvLb2g7WCCGwvueRMhu7E9XHKkRBZ
        6cNqa7L8q+v5/j4GTiKFsvNFlJn5H6EAwQ==
X-Google-Smtp-Source: ACHHUZ5sYsXlnHgSEzq87FGMxw1OFfeWrR+1aAIlDhUXjchixEU1+y0DUmvEHqt53qZGyR8gPV4mtw==
X-Received: by 2002:a17:907:9804:b0:98c:d355:bb38 with SMTP id ji4-20020a170907980400b0098cd355bb38mr962744ejc.11.1687343891212;
        Wed, 21 Jun 2023 03:38:11 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00987e76827b2sm2873055ejf.53.2023.06.21.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:38:10 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 12:38:02 +0200
Subject: [PATCH 3/4] usb: misc: onboard-hub: add support for Cypress HX3
 USB 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v1-3-3a649b34c85b@skidata.com>
References: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
In-Reply-To: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
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
index 79ba9d8a8fef..1275736637ed 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -351,6 +351,7 @@ static struct platform_driver onboard_hub_driver = {
 
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_TI		0x0451
+#define VENDOR_ID_CYPRESS	0x04b4
 #define VENDOR_ID_GENESYS	0x05e3
 #define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_VIA		0x2109
@@ -431,6 +432,8 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 955aaaf1c31c..551221f02cff 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -19,6 +19,11 @@ static const struct onboard_hub_pdata ti_tusb8041_data = {
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

