Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFEE7381DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjFUKiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjFUKiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FFD2113;
        Wed, 21 Jun 2023 03:37:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-988aefaa44eso481525066b.2;
        Wed, 21 Jun 2023 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343844; x=1689935844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alj5XJx3xHWqgp1qRnBOikrTF0Qcwk6IxtFo9ldPUY0=;
        b=V8sUi6N1QcFViw01BPLMNc8AWo+BTiT+q71Zv3r5/V3ytoTusospV5+0s0IHPKiwTS
         Cc9l+DSoK1FGn1s7jvABtw1jscyRVtQ+Eh0dIdfayoAdiV72xxPpvNpt24MSOJ5PvUN5
         l5M/W8WkTKzmwXxZAm3Qx5M6//SLmwYELFZknAWBhcL+nhhzCDGFOaI0NrzuVUZrYIT4
         gKrhEMdxYeAtf9lMB8pDeYz6TZdLD5FQ8F4VhDVRzNE7/IzHAePk3JksClAh3/Ou7VjS
         zkfri1Okqha9Z3xEeF3M+KbkwthsVqiAT0WSPq9o5iA2CeL1x/T6QB6kxiaxHGLeR4GT
         wHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343844; x=1689935844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alj5XJx3xHWqgp1qRnBOikrTF0Qcwk6IxtFo9ldPUY0=;
        b=TRA1s6QA2wLzpr+iPJceeEOj/bW2wz5em3EzemhUTzEkOB85PUZT+GygcH+6ZxDoZ+
         wdgGY7EGGkSePjqq9UfxCVZ+9NOwC2y8FtRzYhDc/A0yfXwhHfDnGGhMX/wbAoRA1aNH
         ot4VLk9B/ovZa/+JujjUKZ0XHB3+yV8TZqvDFUA+wmmpgapVVTnDEK5+ZX4SlcaHkwZD
         PbNB1yUZZWuvE6EdGwtPHGQmtb/TGFKlkb6fgS4//e4YD5sFVuKNXDA0npx/qe0PMxs3
         F8LB69MljAQ2pWEB6Plu9pbDtMv577M3uIg5m1HPyQoRlEZ4Qa+arZDJN6gLYlUGMt8r
         NTyg==
X-Gm-Message-State: AC+VfDycywUiy9WVAvvsVOxFEjMzt48F6Jy+hDpsHDRY2lwm/EwCEMce
        a0mf6opcLdUACNGJmeq1Rtk=
X-Google-Smtp-Source: ACHHUZ5BUFCWo5dwef6cuqNstsM8TxYPLk8NNGHFFZr/YOvGVLoFEzk3Vhk9bH2ZEjfHIG/Y/GNyLQ==
X-Received: by 2002:a17:907:7245:b0:982:a454:6d24 with SMTP id ds5-20020a170907724500b00982a4546d24mr13502589ejc.74.1687343843679;
        Wed, 21 Jun 2023 03:37:23 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id c2-20020a1709060fc200b0098880feae36sm2931758ejk.153.2023.06.21.03.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:37:23 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 12:37:16 +0200
Subject: [PATCH 1/4] usb: misc: onboard-hub: resort by VID and PID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v1-1-690000b6d60d@skidata.com>
References: <20230620-hx3-v1-0-690000b6d60d@skidata.com>
In-Reply-To: <20230620-hx3-v1-0-690000b6d60d@skidata.com>
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

Resort the existing entries by VID and then by PID to be able to find
entries easier.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 12 ++++++------
 drivers/usb/misc/onboard_usb_hub.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 12fc6eb67c3b..94006714c273 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -329,10 +329,10 @@ static struct platform_driver onboard_hub_driver = {
 
 /************************** USB driver **************************/
 
-#define VENDOR_ID_GENESYS	0x05e3
 #define VENDOR_ID_MICROCHIP	0x0424
-#define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
+#define VENDOR_ID_GENESYS	0x05e3
+#define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_VIA		0x2109
 
 /*
@@ -407,16 +407,16 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_hub_id_table[] = {
-	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
-	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
-	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
 	{}
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index aca5f50eb0da..ff8925aa6d3a 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -14,10 +14,6 @@ static const struct onboard_hub_pdata microchip_usb424_data = {
 	.reset_us = 1,
 };
 
-static const struct onboard_hub_pdata realtek_rts5411_data = {
-	.reset_us = 0,
-};
-
 static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 };
@@ -30,6 +26,10 @@ static const struct onboard_hub_pdata genesys_gl852g_data = {
 	.reset_us = 50,
 };
 
+static const struct onboard_hub_pdata realtek_rts5411_data = {
+	.reset_us = 0,
+};
+
 static const struct onboard_hub_pdata vialab_vl817_data = {
 	.reset_us = 10,
 };

-- 
2.34.1

