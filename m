Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194C6BF58C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCQW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCQW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041582CFFF;
        Fri, 17 Mar 2023 15:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E842B82714;
        Fri, 17 Mar 2023 22:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA91FC433EF;
        Fri, 17 Mar 2023 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093831;
        bh=sgSRwxAxEIt1lhIpJ4LJp0jSf1yP+vzoOjDmNYSjqw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlGymSYrUuAVfpRImmP0NNyhbsdW+qIzm+AJxNMICoBYDGFuUQYjy/PGP/SZV4Sdd
         r4vC5IqmRTNsDVRya/RlQk7GpVJtelcEUl0A25fqoIMXUYztB5yxhrvwI80ZZRWtRz
         XVfXbZsE92ScamVg3IOcdj0fmZzcwM4E3mV5fhpvq2SuoT7CxbUiJ0Zr4BIP91xqiu
         3LopV6B3e9rUX07ViZAs38xkJgCNsYd7S3i6DbpvkHBfXYjI3vbU82lRkedou9pSIF
         dnbChCNbLi2hQ8ZQcyGqshCMa7RciODLh71PnFVfSq8eQXH8cmHY00GId3I3gulUuk
         /Zqv5bQdrR6KA==
Received: by mercury (Postfix, from userid 1000)
        id 88E761062101; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 03/14] power: supply: generic-adc-battery: convert to managed resources
Date:   Fri, 17 Mar 2023 23:56:56 +0100
Message-Id: <20230317225707.1552512-4-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use managed resources to simplify driver code.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 81 ++++++----------------
 1 file changed, 23 insertions(+), 58 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 66039c665dd1..917bd2a6cc52 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -23,6 +23,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
 #include <linux/power/generic-adc-battery.h>
+#include <linux/devm-helpers.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
 
@@ -266,14 +267,13 @@ static int gab_probe(struct platform_device *pdev)
 	 * copying the static properties and allocating extra memory for holding
 	 * the extra configurable properties received from platform data.
 	 */
-	properties = kcalloc(ARRAY_SIZE(gab_props) +
-			     ARRAY_SIZE(gab_chan_name),
-			     sizeof(*properties),
-			     GFP_KERNEL);
-	if (!properties) {
-		ret = -ENOMEM;
-		goto first_mem_fail;
-	}
+	properties = devm_kcalloc(&pdev->dev,
+				  ARRAY_SIZE(gab_props) +
+				  ARRAY_SIZE(gab_chan_name),
+				  sizeof(*properties),
+				  GFP_KERNEL);
+	if (!properties)
+		return -ENOMEM;
 
 	memcpy(properties, gab_props, sizeof(gab_props));
 
@@ -282,12 +282,13 @@ static int gab_probe(struct platform_device *pdev)
 	 * based on the channel supported by consumer device.
 	 */
 	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
-		adc_bat->channel[chan] = iio_channel_get(&pdev->dev,
-							 gab_chan_name[chan]);
+		adc_bat->channel[chan] = devm_iio_channel_get(&pdev->dev, gab_chan_name[chan]);
 		if (IS_ERR(adc_bat->channel[chan])) {
 			ret = PTR_ERR(adc_bat->channel[chan]);
+			if (ret != -ENODEV)
+				return dev_err_probe(&pdev->dev, ret, "Failed to get ADC channel %s\n", gab_chan_name[chan]);
 			adc_bat->channel[chan] = NULL;
-		} else {
+		} else if (adc_bat->channel[chan]) {
 			/* copying properties for supported channels only */
 			int index2;
 
@@ -302,10 +303,8 @@ static int gab_probe(struct platform_device *pdev)
 	}
 
 	/* none of the channels are supported so let's bail out */
-	if (!any) {
-		ret = -ENODEV;
-		goto second_mem_fail;
-	}
+	if (!any)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get any ADC channel\n");
 
 	/*
 	 * Total number of properties is equal to static properties
@@ -316,25 +315,24 @@ static int gab_probe(struct platform_device *pdev)
 	psy_desc->properties = properties;
 	psy_desc->num_properties = index;
 
-	adc_bat->psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
-	if (IS_ERR(adc_bat->psy)) {
-		ret = PTR_ERR(adc_bat->psy);
-		goto err_reg_fail;
-	}
+	adc_bat->psy = devm_power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(adc_bat->psy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adc_bat->psy), "Failed to register power-supply device\n");
 
-	INIT_DELAYED_WORK(&adc_bat->bat_work, gab_work);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &adc_bat->bat_work, gab_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register delayed work\n");
 
-	adc_bat->charge_finished = devm_gpiod_get_optional(&pdev->dev,
-							   "charged", GPIOD_IN);
+	adc_bat->charge_finished = devm_gpiod_get_optional(&pdev->dev, "charged", GPIOD_IN);
 	if (adc_bat->charge_finished) {
 		int irq;
 
 		irq = gpiod_to_irq(adc_bat->charge_finished);
-		ret = request_any_context_irq(irq, gab_charged,
+		ret = devm_request_any_context_irq(&pdev->dev, irq, gab_charged,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"battery charged", adc_bat);
 		if (ret < 0)
-			goto gpio_req_fail;
+			return dev_err_probe(&pdev->dev, ret, "Failed to register irq\n");
 	}
 
 	platform_set_drvdata(pdev, adc_bat);
@@ -343,38 +341,6 @@ static int gab_probe(struct platform_device *pdev)
 	schedule_delayed_work(&adc_bat->bat_work,
 			msecs_to_jiffies(0));
 	return 0;
-
-gpio_req_fail:
-	power_supply_unregister(adc_bat->psy);
-err_reg_fail:
-	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
-		if (adc_bat->channel[chan])
-			iio_channel_release(adc_bat->channel[chan]);
-	}
-second_mem_fail:
-	kfree(properties);
-first_mem_fail:
-	return ret;
-}
-
-static int gab_remove(struct platform_device *pdev)
-{
-	int chan;
-	struct gab *adc_bat = platform_get_drvdata(pdev);
-
-	power_supply_unregister(adc_bat->psy);
-
-	if (adc_bat->charge_finished)
-		free_irq(gpiod_to_irq(adc_bat->charge_finished), adc_bat);
-
-	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
-		if (adc_bat->channel[chan])
-			iio_channel_release(adc_bat->channel[chan]);
-	}
-
-	kfree(adc_bat->psy_desc.properties);
-	cancel_delayed_work_sync(&adc_bat->bat_work);
-	return 0;
 }
 
 static int __maybe_unused gab_suspend(struct device *dev)
@@ -408,7 +374,6 @@ static struct platform_driver gab_driver = {
 		.pm	= &gab_pm_ops,
 	},
 	.probe		= gab_probe,
-	.remove		= gab_remove,
 };
 module_platform_driver(gab_driver);
 
-- 
2.39.2

