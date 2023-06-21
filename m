Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF67B738E17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjFUSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFUSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:04:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2C1733;
        Wed, 21 Jun 2023 11:04:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-987a977f62aso574308866b.1;
        Wed, 21 Jun 2023 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687370647; x=1689962647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1j4YwkEi9jMqftuoPBxR0zM+sfPx3/qad/W/L12FtA=;
        b=gSfKfMM4hXTQgDlQ+uQHcQToKwYO7wnsCtnIDrQZqySzb+bu37fLG7ZUFftBFNislw
         DJIUbIHMsC9pcnhiYqgfiLj346ibISqCZu8qdYBeUp1RhLBVE0BbvZBTJBYNJMAxkr0x
         zXAA2KFqnPJrUb8G9Q+Dw2ZEbGiiJ7FI20uf1I6tlpRe0zm8UTqNb/HxHXI0bQW9AiN/
         dC8r2rP+2hRPKKpXjUUT3TzqbUFm6T9z7xTDolzA1XPDDtd2/GU6w9RqQA7N2/AYI0mf
         EwUxjyc3rF5s8S5nt8KJdss2kylr2wnSV2BG5jC5IDdOunN8H2uHZdfiTxZnfF807q0R
         Ulag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370647; x=1689962647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1j4YwkEi9jMqftuoPBxR0zM+sfPx3/qad/W/L12FtA=;
        b=ZrF1gGRNChQZpxcYYjs08f1mHIBqvu6X1TbPHd8DY1UBateFyUwCRIj5oSajz8R88k
         pzTYY6PNuANczvmhYcGmI5Yl6mHMSnTqdpi8fifVPwxvF+QtyQRU03q3XvzGtE/P2dGe
         SIGA0EYBCx9ZoiEKQiEsS9CCx4a2er0eKxAuDAmf8rnKO/WwYyyBer5vhSj6Lm5jUzSZ
         i9BPgaRirLC/j00+gQ2AE2EPR0fiHd8sWdm6bzYw4sk0JxVy9aWmtB5pcVYREbIcHSBz
         T0yQnSxXextuhxtmiGON0X5cXbefvFV2D0KJFcYP4zO/1a4RIXfcEn9iDAZ1W+N2IKPE
         HYKw==
X-Gm-Message-State: AC+VfDw3IeTzA91Or53FIH9Y1eT4yO25P6Dr48xj7h7dvqhdBQymz0Ef
        ozr/LWlim25UT1X9TypoZE8zP5fM/RQKpA==
X-Google-Smtp-Source: ACHHUZ4gWms4PNYlWymUTSujRCD3vnu2hOujMKWRFt3jnAzp84SclIUWYHSzZu99wn4l7spE+k7Rpw==
X-Received: by 2002:a17:906:dac3:b0:989:450:e585 with SMTP id xi3-20020a170906dac300b009890450e585mr4763795ejb.45.1687370646906;
        Wed, 21 Jun 2023 11:04:06 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906b10d00b00988955f7b5esm3460779ejy.157.2023.06.21.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:04:06 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 20:04:03 +0200
Subject: [PATCH v4 1/3] usb: misc: onboard-hub: support multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v4-1-e56b3c6db60b@skidata.com>
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

As some of the onboard hubs require multiple power supplies, provide the
environment to support them.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v4:
- set num_supplies=1 for the existing hubs
- drop duplicate num_supplies in onboard_hub struct
- clarify connection between supply_names and MAX_SUPPLIES

v3:
- fix nits mentioned in v2

v2:
- replace (err != 0) with (err)
---
 drivers/usb/misc/onboard_usb_hub.c | 42 ++++++++++++++++++++++++++++++--------
 drivers/usb/misc/onboard_usb_hub.h |  7 +++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 12fc6eb67c3b..067511e8a976 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -27,6 +27,22 @@
 
 #include "onboard_usb_hub.h"
 
+/*
+ * Increase the number of maximum supported supplies if a new hub with more
+ * than the currently supported supplies is added. In this case, also add a new
+ * name for the new supply.
+ */
+#define MAX_SUPPLIES 2
+
+/*
+ * Use generic names, as the actual names might differ between hubs. The number
+ * of entries must be the same as MAX_SUPPLIES.
+ */
+static const char * const supply_names[] = {
+	"vdd",
+	"vdd2",
+};
+
 static void onboard_hub_attach_usb_driver(struct work_struct *work);
 
 static struct usb_device_driver onboard_hub_usbdev_driver;
@@ -40,7 +56,7 @@ struct usbdev_node {
 };
 
 struct onboard_hub {
-	struct regulator *vdd;
+	struct regulator_bulk_data supplies[MAX_SUPPLIES];
 	struct device *dev;
 	const struct onboard_hub_pdata *pdata;
 	struct gpio_desc *reset_gpio;
@@ -55,9 +71,9 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
 {
 	int err;
 
-	err = regulator_enable(hub->vdd);
+	err = regulator_bulk_enable(hub->pdata->num_supplies, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
 		return err;
 	}
 
@@ -75,9 +91,9 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
 
 	gpiod_set_value_cansleep(hub->reset_gpio, 1);
 
-	err = regulator_disable(hub->vdd);
+	err = regulator_bulk_disable(hub->pdata->num_supplies, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
+		dev_err(hub->dev, "failed to disable supplies: %d\n", err);
 		return err;
 	}
 
@@ -232,6 +248,7 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct onboard_hub *hub;
+	unsigned int i;
 	int err;
 
 	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
@@ -246,9 +263,18 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	if (!hub->pdata)
 		return -EINVAL;
 
-	hub->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(hub->vdd))
-		return PTR_ERR(hub->vdd);
+	if (hub->pdata->num_supplies > MAX_SUPPLIES)
+		return dev_err_probe(dev, -EINVAL, "max %d supplies supported!\n",
+				     MAX_SUPPLIES);
+
+	for (i = 0; i < hub->pdata->num_supplies; i++)
+		hub->supplies[i].supply = supply_names[i];
+
+	err = devm_regulator_bulk_get(dev, hub->pdata->num_supplies, hub->supplies);
+	if (err) {
+		dev_err(dev, "Failed to get regulator supplies: %d\n", err);
+		return err;
+	}
 
 	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						  GPIOD_OUT_HIGH);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index aca5f50eb0da..41a4127a92dc 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -8,30 +8,37 @@
 
 struct onboard_hub_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
+	unsigned int num_supplies;	/* number of supplies */
 };
 
 static const struct onboard_hub_pdata microchip_usb424_data = {
 	.reset_us = 1,
+	.num_supplies = 1,
 };
 
 static const struct onboard_hub_pdata realtek_rts5411_data = {
 	.reset_us = 0,
+	.num_supplies = 1,
 };
 
 static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
+	.num_supplies = 1,
 };
 
 static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
+	.num_supplies = 1,
 };
 
 static const struct onboard_hub_pdata genesys_gl852g_data = {
 	.reset_us = 50,
+	.num_supplies = 1,
 };
 
 static const struct onboard_hub_pdata vialab_vl817_data = {
 	.reset_us = 10,
+	.num_supplies = 1,
 };
 
 static const struct of_device_id onboard_hub_match[] = {

-- 
2.34.1

