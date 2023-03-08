Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F338C6B023E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCHJCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCHJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:02:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A8995E2E;
        Wed,  8 Mar 2023 01:02:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so62712222edb.9;
        Wed, 08 Mar 2023 01:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEL5i+l5uJgUeWQVuHHqsyYYkfIaU6CMwZkdIb7+3Eo=;
        b=HcERTqYKjrUqYLYOThQfCLeydPrBYa/Wj5A1D8Q2PYj/5MMPtCnDCYIB5Y7AndyFHG
         T9jRhZ159tegwOhWRZXJ5FGj12/B6Iwr0zU5AE+eIUY1kf6QyHsm7OcAWiDOa1kk+f8l
         kKkjebrwIhay65THKbPPIHUFYDl0bXYGNytWGLbnIvYvadUNgccu1sk1TijyORw/JVtC
         k3/GQnhYEnhWgbGRfwSTcDLuk0uOQhHwQxZtHX6kNCC6PfPszAj6wYR6fsBdwPNnKYqU
         gJxxhK2IxQp3c1kezVY9SGFbFlnZ6a7N8lvtzJGW0adkc21jo0LVJj/Gr9Qq9WZQVdCX
         uGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEL5i+l5uJgUeWQVuHHqsyYYkfIaU6CMwZkdIb7+3Eo=;
        b=LQXY5wW3MYMCkWEZbO4rF2JYfjZwunZu0v8GeVq1iF2NDaeIgVySE5GAKDOBBW2JQH
         4IhXlOvy/XHa5PsEFMQbIXcoXgqTKzQdnGn04mHJAtly+44etFUsTCU7lHTAWxsRnUXz
         P/67VRonWK2HYysdZtC1bF4iYH+NsLGFlc46rV9tTWubmiPvgfCLUZS911eBi1Vg4xCl
         nk44+AdKH9Z8388eFUvFNZm5lkyMcHdHhBtZAcELRURRuF5clgQHHXtPLGWwKKOFW0iW
         UhZmA5AAyoElyF2hy9xfKb7/MBVgETbRWSfDYeHC0ZW1EZYdyF36zZk6RTelbpg2Z/NP
         /8Qg==
X-Gm-Message-State: AO0yUKX9AE90ETXSXb4b3MtJcXmMp4Jnkx91WOrNHNTY9wpSrrEsX8Wf
        Ap1H6wLDJXxeu1wvj6qupu8=
X-Google-Smtp-Source: AK7set/SYcFJiRyBlvkO2tEjGpZR+UBfQahL6euCMfuLhnXzkzel4FuxUkMdtFuvt+63xrutBqNiNA==
X-Received: by 2002:a17:906:ca5a:b0:8b2:abc7:1ef9 with SMTP id jx26-20020a170906ca5a00b008b2abc71ef9mr17204205ejb.68.1678266149422;
        Wed, 08 Mar 2023 01:02:29 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b008caaae1f1e1sm7153709ejn.110.2023.03.08.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:02:29 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] misc: adps990x: convert to OF
Date:   Wed,  8 Mar 2023 11:02:17 +0200
Message-Id: <20230308090219.12710-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308090219.12710-1-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ability to get essential values from device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/apds990x.c | 56 +++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 0024503ea6db..c53ead5a575d 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -180,8 +180,8 @@ static const u16 arates_hz[] = {10, 5, 2, 1};
 static const u8 apersis[] = {1, 2, 4, 5};
 
 /* Regulators */
-static const char reg_vcc[] = "Vdd";
-static const char reg_vled[] = "Vled";
+static const char reg_vcc[] = "vdd";
+static const char reg_vled[] = "vled";
 
 static int apds990x_read_byte(struct apds990x_chip *chip, u8 reg, u8 *data)
 {
@@ -1048,9 +1048,38 @@ static struct attribute *sysfs_attrs_ctrl[] = {
 };
 
 static const struct attribute_group apds990x_attribute_group[] = {
-	{.attrs = sysfs_attrs_ctrl },
+	{ .attrs = sysfs_attrs_ctrl },
 };
 
+static int apds990x_of_probe(struct i2c_client *client,
+			     struct apds990x_chip *chip)
+{
+	struct apds990x_platform_data *pdata;
+	u32 ret, val;
+
+	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	ret = device_property_read_u32(&client->dev, "avago,pdrive", &val);
+	if (ret) {
+		dev_info(&client->dev, "pdrive property is missing: ret %d\n", ret);
+		return ret;
+	}
+	pdata->pdrive = val;
+
+	ret = device_property_read_u32(&client->dev, "avago,ppcount", &val);
+	if (ret) {
+		dev_info(&client->dev, "ppcount property is missing: ret %d\n", ret);
+		return ret;
+	}
+	pdata->ppcount = val;
+
+	chip->pdata = pdata;
+
+	return 0;
+}
+
 static int apds990x_probe(struct i2c_client *client)
 {
 	struct apds990x_chip *chip;
@@ -1065,13 +1094,10 @@ static int apds990x_probe(struct i2c_client *client)
 
 	init_waitqueue_head(&chip->wait);
 	mutex_init(&chip->mutex);
-	chip->pdata	= client->dev.platform_data;
 
-	if (chip->pdata == NULL) {
-		dev_err(&client->dev, "platform data is mandatory\n");
-		err = -EINVAL;
-		goto fail1;
-	}
+	chip->pdata = client->dev.platform_data;
+	if (!chip->pdata)
+		apds990x_of_probe(client, chip);
 
 	if (chip->pdata->cf.ga == 0) {
 		/* set uncovered sensor default parameters */
@@ -1160,8 +1186,7 @@ static int apds990x_probe(struct i2c_client *client)
 
 	err = request_threaded_irq(client->irq, NULL,
 				apds990x_irq,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_LOW |
-				IRQF_ONESHOT,
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"apds990x", chip);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n",
@@ -1252,11 +1277,16 @@ static int apds990x_runtime_resume(struct device *dev)
 
 #endif
 
+static const struct of_device_id apds990x_match_table[] = {
+	{ .compatible = "avago,apds990x" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, apds990x_match_table);
+
 static const struct i2c_device_id apds990x_id[] = {
 	{"apds990x", 0 },
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, apds990x_id);
 
 static const struct dev_pm_ops apds990x_pm_ops = {
@@ -1270,12 +1300,12 @@ static struct i2c_driver apds990x_driver = {
 	.driver	 = {
 		.name	= "apds990x",
 		.pm	= &apds990x_pm_ops,
+		.of_match_table = apds990x_match_table,
 	},
 	.probe_new = apds990x_probe,
 	.remove	  = apds990x_remove,
 	.id_table = apds990x_id,
 };
-
 module_i2c_driver(apds990x_driver);
 
 MODULE_DESCRIPTION("APDS990X combined ALS and proximity sensor");
-- 
2.37.2

