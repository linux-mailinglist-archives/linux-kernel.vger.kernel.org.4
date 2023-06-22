Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574B739930
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjFVIRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:17:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A491BCB;
        Thu, 22 Jun 2023 01:17:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9887ebe16d0so612081466b.2;
        Thu, 22 Jun 2023 01:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687421851; x=1690013851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhEqYOleu4e1Mnd0sN9Md8hZQNtCOZtfgYgaY4CTKSY=;
        b=bETU7hckyF82y/dgVR41ALqMliicvHL9VmOMHlKOezpZri7+Wwqe2Jbx+CCSLlawhS
         o9cH11n/d/QeET3nLp1M95DRwbnsew/wMDBJSz1mga7mQAydIopZdfXudEN2LyKXkSAF
         z55nHuyYuankeimGqxo9v+wcfz6v4l0r6kX3msGVwpEXfOqdYFt0yToSCDNI+G3lkBCK
         Qt6WpvOZ78MRnW23k8qxyzqFca1zmz53osX4oE9I2FYazrtOYvDjPo998cS5Sku2SSl/
         3Xzl18/LowUoga84FoNQ23vbf1Hz8JzaaBA0/hi404ZNnH5EaoiPDzNyhF3+oVjwiW86
         I+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421851; x=1690013851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhEqYOleu4e1Mnd0sN9Md8hZQNtCOZtfgYgaY4CTKSY=;
        b=TiSe9Jm3JzaP2xArGonJAdBa0fxUOkl2jPDxSY7R1rs+0tNzwST5eeFavXMa83D7Km
         JeoU0MR+xwC+AZFoh/OEbOT3wGPwjYOLPme1+7Omp6qHLE7dvGFCc+9frbr8PUw6JyXW
         ZGBmIGQu1723TOk4EshEBkCbTbnlsKyGKCVXk0UJ/jPm5p0UceYzDJPwXxk4QBYr7peT
         Q+Jdr/G8fKeFLaZDWMZcVEaeZeXEm0+hg4QmP1AJzgoCxZb+aCVL1KNYPJ8r9mwO6cuZ
         999BFsBx8CLbaFqDlX80tPPL4THqTQ9vfycMMbYShRKKHDL0W9/n6X4dajM1iIp9ht4v
         94EQ==
X-Gm-Message-State: AC+VfDyl9iGh0/BH5WMVlZeRdwxY8aZp70iqlgFDXD9NNcCIQaNaRkkU
        8VtwOGtUSOAAp52Sbyxt0g8=
X-Google-Smtp-Source: ACHHUZ7xuKTPe9mc7rIywbuPM9N04DCJ630BZK/z73DeRwqR4/lgboe+19qnLyPcvUbFtYICCVsY1Q==
X-Received: by 2002:a17:906:6a07:b0:989:a806:d197 with SMTP id qw7-20020a1709066a0700b00989a806d197mr4574413ejc.3.1687421850757;
        Thu, 22 Jun 2023 01:17:30 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id k22-20020a056402049600b0051bc58b8dbcsm3577886edv.59.2023.06.22.01.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:17:30 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 22 Jun 2023 10:17:22 +0200
Subject: [PATCH v5 1/3] usb: misc: onboard-hub: support multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v5-1-319c9c4c846f@skidata.com>
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

As some of the onboard hubs require multiple power supplies, provide the
environment to support them.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
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
index 12fc6eb67c3b..1bbbc6948484 100644
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

