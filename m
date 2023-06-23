Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1373B183
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjFWH2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjFWH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:28:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380519BF;
        Fri, 23 Jun 2023 00:28:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98cd280cf94so29181666b.1;
        Fri, 23 Jun 2023 00:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687505296; x=1690097296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tE3E2dKV+FoleDfxJ/RhJkgCbuoMdh5riKIj8EEGJsc=;
        b=harcNWpa5uQa0AwY39eMRlXzFMQH33Cl9t+0B407s3RoASvRIxvrWRtEJ6yueYjjU+
         KaKn7mj2QRZxZRMJ2rnArdB/JVVnZgOJzu/APgLYNKUz4yDKN6l0iiuTMtRwafnh32qP
         MumN77C8jkzXoLYIqxpwNFWyW07MGhYHZ981GAAPTiME7x3KbwB6yEAOYXFzJwHHBEAH
         ow+MzPWC508jeh/pPJgCs3RUBRC169hxhWrHzTAC5imUj3bPUi4csQ8Ir+lLpvcWah9W
         GmLoRbF2FkrN9q7/gpy5IENE6mIi2YKJFrDZOxADxpF82/iu140YlI8MpV954DGrrXL1
         0/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687505296; x=1690097296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE3E2dKV+FoleDfxJ/RhJkgCbuoMdh5riKIj8EEGJsc=;
        b=XHpGqj0OXrxOalyZXnYDEJZzKcSQODHcRbOnSdzwA9NPnYH23ewgH7o1RBhGpQX4Gi
         H1MstKbrJb8SGnlmv8F/1Jj7yapNpMG8QIho4S/QSY+MftFivI005ZkxA7bzTgNlwFnQ
         1NQgC5IvEctvieLrOzjFQj/53y+xZpmKUOwWqe6uiNUILDlUISE/qg6gAojNi4QirQVI
         xrMLJD34qTPouYLW/sjKzQcv7akErUr4wopqoinvFpyeTOGzulVKFt7kgmzfLtQAcYoF
         2V1WRrdaf4Ae9+NdKSlty+8M7PFj/UX3sGySpTtJ4jY7FuYfqIRrEkao545kiEHMY+8x
         hjUA==
X-Gm-Message-State: AC+VfDw3SM82IwQtRXvdQnVCTcqzF9FevO3PnU4hTR9N3ROwCAlDuFIB
        F4fQe18c3DD/Jx8l5AogcSU=
X-Google-Smtp-Source: ACHHUZ5MOAGy5T6hlzGL3bZBFVsMq0IywnIyOLtA6gREYcCTA8aT4zxjlsGxwAinkCurKzB3auftWw==
X-Received: by 2002:a17:907:2d91:b0:977:cbaf:bc56 with SMTP id gt17-20020a1709072d9100b00977cbafbc56mr20732424ejc.43.1687505295974;
        Fri, 23 Jun 2023 00:28:15 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090614d300b00982d0563b11sm5637811ejc.197.2023.06.23.00.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:28:15 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 23 Jun 2023 09:28:12 +0200
Subject: [PATCH v7 1/3] usb: misc: onboard-hub: support multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v7-1-f79b4b22a1bf@skidata.com>
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

As some of the onboard hubs require multiple power supplies, provide the
environment to support them.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v7:
- %ld -> %zu

v6:
- %d -> %ld

v5:
- use ARRAY_SIZE(supply_names) for MAX_SUPPLIES

v4:
- set num_supplies=1 for the existing hubs
- drop duplicate num_supplies in onboard_hub struct
- clarify connection between supply_names and MAX_SUPPLIES

v3:
- fix nits mentioned in v2

v2:
- replace (err != 0) with (err)
---
 drivers/usb/misc/onboard_usb_hub.c | 37 +++++++++++++++++++++++++++++--------
 drivers/usb/misc/onboard_usb_hub.h |  7 +++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 12fc6eb67c3b..b31548cd60e7 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -27,6 +27,17 @@
 
 #include "onboard_usb_hub.h"
 
+/*
+ * Use generic names, as the actual names might differ between hubs. If a new
+ * hub requires more than the currently supported supplies, add a new one here.
+ */
+static const char * const supply_names[] = {
+	"vdd",
+	"vdd2",
+};
+
+#define MAX_SUPPLIES ARRAY_SIZE(supply_names)
+
 static void onboard_hub_attach_usb_driver(struct work_struct *work);
 
 static struct usb_device_driver onboard_hub_usbdev_driver;
@@ -40,7 +51,7 @@ struct usbdev_node {
 };
 
 struct onboard_hub {
-	struct regulator *vdd;
+	struct regulator_bulk_data supplies[MAX_SUPPLIES];
 	struct device *dev;
 	const struct onboard_hub_pdata *pdata;
 	struct gpio_desc *reset_gpio;
@@ -55,9 +66,9 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
 {
 	int err;
 
-	err = regulator_enable(hub->vdd);
+	err = regulator_bulk_enable(hub->pdata->num_supplies, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
 		return err;
 	}
 
@@ -75,9 +86,9 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
 
 	gpiod_set_value_cansleep(hub->reset_gpio, 1);
 
-	err = regulator_disable(hub->vdd);
+	err = regulator_bulk_disable(hub->pdata->num_supplies, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
+		dev_err(hub->dev, "failed to disable supplies: %d\n", err);
 		return err;
 	}
 
@@ -232,6 +243,7 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct onboard_hub *hub;
+	unsigned int i;
 	int err;
 
 	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
@@ -246,9 +258,18 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	if (!hub->pdata)
 		return -EINVAL;
 
-	hub->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(hub->vdd))
-		return PTR_ERR(hub->vdd);
+	if (hub->pdata->num_supplies > MAX_SUPPLIES)
+		return dev_err_probe(dev, -EINVAL, "max %zu supplies supported!\n",
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

