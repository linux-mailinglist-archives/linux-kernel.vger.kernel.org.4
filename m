Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23B738197
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjFUKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjFUKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7FD10CE;
        Wed, 21 Jun 2023 03:38:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98746d7f35dso737455566b.2;
        Wed, 21 Jun 2023 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343890; x=1689935890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kj3Q14SJNrQ3JSHI9cNWmMd16rBe5tEjbiWTFGj9d0k=;
        b=AbTY0AdMgEer052uhylU+TwfBuFONE8s1AkDgtCX200PSJN8VFNARe3rehDbkL+NXW
         mK7gdgttkSV3AR2TmSP2zsKwxAMCjzYrOaUmKIjQHd6d77t/tLgp/gGUZW3PkLou5FAp
         iR+ZXq0R7Q+OIycVpYxE16oGjOkWODAXJ8/CljyXTQrSLcMqJq7KcHJF/LqrEANooPHk
         N/EmKgUwsZrg7pypVWjDiQcqs7d0wfQiDt0zgoxu0b9yKXELRw/Wh2lmBkBuWD6YFb2A
         B3LOsK11hOq+eUSr+/BMLDkrYXE82u1cxcGAP9Si5spWP36WPG3d9ul0Peh1kucgv4s1
         HkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343890; x=1689935890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj3Q14SJNrQ3JSHI9cNWmMd16rBe5tEjbiWTFGj9d0k=;
        b=gTGLKVwxFbt91ygjW3+9rU1kNMGM/1KvK8ikV0lRab6neBLqDFuFEpF0+VbPclO0bM
         yUNT/FxviVQW7JWLhdEbKyOyOE03z/7PSQnCRctH0JZIyzrSjt9B95sCyaoEXKja7j2c
         a5dQtH4nlsWNxXM5V0knaDxWyT9sNEJI0FXQvBx26bkp3tsJ/YHYp0LOHVrMZBHqBtca
         lSdBs6N7jJYM0hZE4PbS5lV4bBgikGfF/hq1n1JoiriP1HdcNptpwaNKanxXjpno4d4I
         ScxBJ4APxO9ZufNbBSwwdmU5fZW6yBIhkDIjXKCNk3awxOWCUFiVHuoeuXJg4noqAksd
         L8Pw==
X-Gm-Message-State: AC+VfDzweo/zjQmrxNekVb7GZE3IWc4fZyenDDBwYZdcQoSmbVQAUjTe
        iOaD3OajKZl4WMvqcY0nYwuzo1FIu7xMMA==
X-Google-Smtp-Source: ACHHUZ4SHyejqMIThtQv9NhbFQL2/85x6Au+NaFs31LZTZF+nQnfNXkGcNg5ziSITUdN7Q2FuYATRw==
X-Received: by 2002:a17:907:320d:b0:974:1c90:b3d3 with SMTP id xg13-20020a170907320d00b009741c90b3d3mr14043166ejb.12.1687343890459;
        Wed, 21 Jun 2023 03:38:10 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00987e76827b2sm2873055ejf.53.2023.06.21.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:38:10 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 12:38:01 +0200
Subject: [PATCH 2/4] usb: misc: onboard-hub: support multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v1-2-3a649b34c85b@skidata.com>
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

As some of the onboard hubs require multiple power supplies, provide the
environment to support them.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 40 ++++++++++++++++++++++++++++----------
 drivers/usb/misc/onboard_usb_hub.h |  1 +
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 94006714c273..79ba9d8a8fef 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -27,6 +27,12 @@
 
 #include "onboard_usb_hub.h"
 
+#define SUPPLIES_NUM_MAX 2
+static const char * const supply_names[] = {
+	"vdd",
+	"vdd2",
+};
+
 static void onboard_hub_attach_usb_driver(struct work_struct *work);
 
 static struct usb_device_driver onboard_hub_usbdev_driver;
@@ -40,7 +46,8 @@ struct usbdev_node {
 };
 
 struct onboard_hub {
-	struct regulator *vdd;
+	struct regulator_bulk_data supplies[SUPPLIES_NUM_MAX];
+	unsigned int supplies_num;
 	struct device *dev;
 	const struct onboard_hub_pdata *pdata;
 	struct gpio_desc *reset_gpio;
@@ -55,9 +62,9 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
 {
 	int err;
 
-	err = regulator_enable(hub->vdd);
-	if (err) {
-		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+	err = regulator_bulk_enable(hub->supplies_num, hub->supplies);
+	if (err != 0) {
+		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
 		return err;
 	}
 
@@ -75,9 +82,9 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
 
 	gpiod_set_value_cansleep(hub->reset_gpio, 1);
 
-	err = regulator_disable(hub->vdd);
-	if (err) {
-		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
+	err = regulator_bulk_disable(hub->supplies_num, hub->supplies);
+	if (err != 0) {
+		dev_err(hub->dev, "failed to disable supplies: %d\n", err);
 		return err;
 	}
 
@@ -232,6 +239,7 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct onboard_hub *hub;
+	unsigned int i;
 	int err;
 
 	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
@@ -246,9 +254,21 @@ static int onboard_hub_probe(struct platform_device *pdev)
 	if (!hub->pdata)
 		return -EINVAL;
 
-	hub->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(hub->vdd))
-		return PTR_ERR(hub->vdd);
+	if (hub->pdata->supplies_num > SUPPLIES_NUM_MAX)
+		return dev_err_probe(dev, -EINVAL, "max %d supplies supported!\n",
+				     SUPPLIES_NUM_MAX);
+	hub->supplies_num = 1;
+	if (hub->pdata->supplies_num > 1)
+		hub->supplies_num = hub->pdata->supplies_num;
+
+	for (i = 0; i < SUPPLIES_NUM_MAX; i++)
+		hub->supplies[i].supply = supply_names[i];
+
+	err = devm_regulator_bulk_get(dev, hub->supplies_num, hub->supplies);
+	if (err) {
+		dev_err(dev, "Failed to get regulator supplies: %d\n", err);
+		return err;
+	}
 
 	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						  GPIOD_OUT_HIGH);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index ff8925aa6d3a..955aaaf1c31c 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -8,6 +8,7 @@
 
 struct onboard_hub_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
+	unsigned int supplies_num;	/* num of supplies: 0 considered as 1 */
 };
 
 static const struct onboard_hub_pdata microchip_usb424_data = {

-- 
2.34.1

