Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA17386F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjFUO1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjFUO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:27:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F7199E;
        Wed, 21 Jun 2023 07:26:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988e6fc41ccso371907666b.3;
        Wed, 21 Jun 2023 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687357601; x=1689949601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQRV2/BxFxsagJLIgXBd9RLpWbGBv5scvqVn53g9A3w=;
        b=RRHhMySXXhM1+I1TSh9pvr3SQPRMDnfzmf6IOmFPO3S11q93DLutkYmb6GhV5RPZr/
         ytwYv8EDHekMVBtRhPLZRxM2T879d7aHd/LiN1uWCP0SoZqdhcFKVBHrDI2dydLDRsA+
         dhlnf0txq1cSwyNYKQAjeiShStH3RRYShHQdqWVpKVmxx7gAQvQwiy18p5+G5mwP0SsQ
         Cn5yWFK1PreJ8M8znbC/APDbHvvQRSDgWKnackcKSk2HWouAeabHhZz/Rm4BD+QTILdB
         UYtJf1Z5RfEyUGYyjULfDDFqcJ1oD+3gxV2410jyhZbR0DQkIPSBsQuiaBQKbvdjfnod
         OBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687357601; x=1689949601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQRV2/BxFxsagJLIgXBd9RLpWbGBv5scvqVn53g9A3w=;
        b=TuWdRpnoFDy2/7Pv1iVILhCv6r66zwIz0606V0tyWfevClfqE6hJctf90N/ILDnlkb
         doRAK/92jiVIhCsCYmPcNfVi0iP7aiQ7wwU8sO2LaEz19+Yt5NsHrDpQSVQ+bg2tu7+l
         8/UjW+P1P1KDKbhwEHY+gbfz8Iw8S4b62UTbKCEbWbJdMGqlQO5N/yXtOsuJaX21KK9a
         Wm9PLSNBLrfBPohGcPlwhrr3b7Iy6ZUz6sMytMD3ElvlV0rYo31cmQHpavGCRGDGucA+
         E9hDqC+GvuEBALn+jPRJkSozcwScfrXzOOpY0zhAArVMByKqVW6gWFYd91DY4DcGZeyb
         1DVQ==
X-Gm-Message-State: AC+VfDw044WnXS5D+zaWHcJh4k2NgkbZC8xg2ANuC5QWXRl4mHOCHgT3
        pmqARy2vC/lZ5kRmfql3ETM=
X-Google-Smtp-Source: ACHHUZ68LoexcxdjYtLwc0swpBCHwId4MTQmcf+Fa3BiKkZvXVLtD6lfuopIL9cq7pfgnVodivB6mw==
X-Received: by 2002:a17:906:7943:b0:988:7d1:f5a5 with SMTP id l3-20020a170906794300b0098807d1f5a5mr9254549ejo.28.1687357600304;
        Wed, 21 Jun 2023 07:26:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906644b00b00988956f244csm3266156ejn.6.2023.06.21.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:26:40 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 16:26:27 +0200
Subject: [PATCH v2 1/3] usb: misc: onboard-hub: support multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v2-1-76a53434c713@skidata.com>
References: <20230620-hx3-v2-0-76a53434c713@skidata.com>
In-Reply-To: <20230620-hx3-v2-0-76a53434c713@skidata.com>
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
v2:
- replace (err != 0) with (err)
---
 drivers/usb/misc/onboard_usb_hub.c | 36 ++++++++++++++++++++++++++++--------
 drivers/usb/misc/onboard_usb_hub.h |  1 +
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 12fc6eb67c3b..3de30356a684 100644
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
+	err = regulator_bulk_enable(hub->supplies_num, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
 		return err;
 	}
 
@@ -75,9 +82,9 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
 
 	gpiod_set_value_cansleep(hub->reset_gpio, 1);
 
-	err = regulator_disable(hub->vdd);
+	err = regulator_bulk_disable(hub->supplies_num, hub->supplies);
 	if (err) {
-		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
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
index aca5f50eb0da..657190bf1799 100644
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

