Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E83738A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjFUP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjFUP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:58:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1341F1;
        Wed, 21 Jun 2023 08:58:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98bcc533490so120995166b.0;
        Wed, 21 Jun 2023 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687363125; x=1689955125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCPr+EfHlZTTO9JEAGikCO7r8p4Wro+SruNHk/6WAj8=;
        b=kjrMisJLe4zIjhjFexTLiQ6L3aIXSHRJVYspOPhK2eVWwf388l+JcXV/zpsKqTfe69
         E1d5PxUJASm1md2G5G2DkByJ5J2wpRnsdyVugYL9ShCgF0q8+cg6dKIQddQizDajX2wP
         R9JUxRwPIw4YW1YLp0veNnuRCwc4ZfBXXj1oICLOCQKSJoBsVxgFcb26eWYYYP/9mjnX
         3nJRE/xgHq1t/xgnftT2Xn3AWUfOQMvXn+LZLUXf/QkY9GsZl2i97rN0odYQInHa/Rjw
         V4aWV1bATYPRRaqmkOyOfzpMvjXzCKYvy1zic5qmni6eA6ijWhNv2h5+6bQ0krUq5eMC
         uR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363125; x=1689955125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCPr+EfHlZTTO9JEAGikCO7r8p4Wro+SruNHk/6WAj8=;
        b=E/fzAKntjvp2yIbg/IlAF2z2kEircLWHz9TY1QIr7opu/2uR2fh9AgR4SlRJy7KZ50
         K4OEyNdcOi7hxwX8uwQdmmR+1+e6JFcwbab1OP6PGvUqXSlDM8TLJ71nny0NZUwvwiCf
         lciRCujUK4skPcuxaluxrW8x0gmRAizyuPAfwYf6judmqw7FVr2ScVTjbV/wkJqBI/gq
         YBHpUsfYOhLtG6PV4urSKRk10fpCbjYt5OORG0WpZOI3W9JGv8yMS9bRpx6VrdW1uEaH
         55KPFfXi+3BrQMf7SzscrQkjoXNPlIzzAFISzlMI+wncy4eWjFiuJpKd+onD0u2t/T5K
         7lOQ==
X-Gm-Message-State: AC+VfDzLSP3XLAQWS6qstV1vnTQIFl9REwa8BMfcCaAnurvmo5aAGu3e
        4culGgwssAbouNtkXeIebrk=
X-Google-Smtp-Source: ACHHUZ7fMKapLIJ1aUqKY51NhYvdy53Hfxxf04628jLhouWXzuhizLSYZB/EPsOWor608TZvngXUvA==
X-Received: by 2002:a17:907:848:b0:988:aeb7:2a37 with SMTP id ww8-20020a170907084800b00988aeb72a37mr8123254ejb.33.1687363125237;
        Wed, 21 Jun 2023 08:58:45 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709060a1400b00977eec7b7e8sm3349316ejf.68.2023.06.21.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:58:45 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 17:58:30 +0200
Subject: [PATCH v3 1/3] usb: misc: onboard-hub: support multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v3-1-2acbc03ca949@skidata.com>
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

As some of the onboard hubs require multiple power supplies, provide the
environment to support them.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v3:
- fix nits mentioned in v2

v2:
- replace (err != 0) with (err)
---
 drivers/usb/misc/onboard_usb_hub.c | 39 ++++++++++++++++++++++++++++++--------
 drivers/usb/misc/onboard_usb_hub.h |  1 +
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 12fc6eb67c3b..a56e712d3a45 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -27,6 +27,13 @@
 
 #include "onboard_usb_hub.h"
 
+#define MAX_SUPPLIES 2
+
+static const char * const supply_names[] = {
+	"vdd",
+	"vdd2",
+};
+
 static void onboard_hub_attach_usb_driver(struct work_struct *work);
 
 static struct usb_device_driver onboard_hub_usbdev_driver;
@@ -40,7 +47,8 @@ struct usbdev_node {
 };
 
 struct onboard_hub {
-	struct regulator *vdd;
+	struct regulator_bulk_data supplies[MAX_SUPPLIES];
+	unsigned int num_supplies;
 	struct device *dev;
 	const struct onboard_hub_pdata *pdata;
 	struct gpio_desc *reset_gpio;
@@ -55,9 +63,9 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
 {
 	int err;
 
-	err = regulator_enable(hub->vdd);
+	err = regulator_bulk_enable(hub->num_supplies, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
 		return err;
 	}
 
@@ -75,9 +83,9 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
 
 	gpiod_set_value_cansleep(hub->reset_gpio, 1);
 
-	err = regulator_disable(hub->vdd);
+	err = regulator_bulk_disable(hub->num_supplies, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
+		dev_err(hub->dev, "failed to disable supplies: %d\n", err);
 		return err;
 	}
 
@@ -232,6 +240,7 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct onboard_hub *hub;
+	unsigned int i;
 	int err;
 
 	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
@@ -246,9 +255,23 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	if (!hub->pdata)
 		return -EINVAL;
 
-	hub->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(hub->vdd))
-		return PTR_ERR(hub->vdd);
+	if (hub->pdata->num_supplies > MAX_SUPPLIES)
+		return dev_err_probe(dev, -EINVAL, "max %d supplies supported!\n",
+				     MAX_SUPPLIES);
+
+	if (hub->pdata->num_supplies)
+		hub->num_supplies = hub->pdata->num_supplies;
+	else
+		hub->num_supplies = 1;
+
+	for (i = 0; i < MAX_SUPPLIES; i++)
+		hub->supplies[i].supply = supply_names[i];
+
+	err = devm_regulator_bulk_get(dev, hub->num_supplies, hub->supplies);
+	if (err) {
+		dev_err(dev, "Failed to get regulator supplies: %d\n", err);
+		return err;
+	}
 
 	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						  GPIOD_OUT_HIGH);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index aca5f50eb0da..7a6d497ce849 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -8,6 +8,7 @@
 
 struct onboard_hub_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
+	unsigned int num_supplies;	/* number of supplies: 0 considered as 1 */
 };
 
 static const struct onboard_hub_pdata microchip_usb424_data = {

-- 
2.34.1

