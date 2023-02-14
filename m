Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0153269606F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjBNKNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBNKNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:13:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC5B755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:13:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j23so15098752wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIrDgN4JyR43vYcDhT60k104s6MHUr5B8TWlKtiai1g=;
        b=BlzdLgXd6ZOA4OiVV/CE6aV+ujYyG3cDGMZCq2reja0pX+EgN7mN3bAfudeVxuJC8w
         hOi8EJ6eitSw+Ot4zQS7co19P+us22nTkoaMxgLRPJu9ld61iVV+uyh1/mZTpaxTOQZQ
         129ymNXidO4kF4usefFP1Vz4Yv4WlEG3b0gvNqa+NUxBeJqod7Zrrx9kY3+4BfUO3Ieh
         mmHUko3opf9MpUsugndpKryv+4pjc4HNbKh+11yKrLZuP+015OhfNZ3aLpVB3zEd30+e
         KiT4BtvEDEj+A+bhH0O6visl639XgXhi9O3JWx1/+oyp0SDLpf2LjnMs0c/KRXZZ1ih8
         13ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIrDgN4JyR43vYcDhT60k104s6MHUr5B8TWlKtiai1g=;
        b=aQhsyHZ0fmhynZZ7augD0GxbHTPe3J4dPUITo5uBFnz7sFop/4lTlXrz/llY34R7nB
         HquAFieLlD6j+eq0eqaRAe5Dml4i4gtFAMb30LpZoLVXZsAY1jRgomc4rAY/bGHXgJKQ
         B5e3zMJMNnJsSPQ0Ve+tyHxDhg9oVymBG5S2ILIT8t3daBkyiBoE38+jFQZ6WMeyeKlk
         5ST3xEEJ4RXlzzwRnAaM77DnwkN4CLcc/n69nXPjnQ92BTi2weiQf6a14mkpzK1rvKYn
         nj89ZwPjWrbwyTl1a8yR3RmVmeL5LZ7QLLBuKFqp/3bVy13NDz1IYt+7/WjY2X1cRc3q
         cheA==
X-Gm-Message-State: AO0yUKXzkmrZ/8UdeLzWa/ugkoFGc2SUZP4rbFJWq724SYqvxkSU2+ZJ
        pv/xgGFyKt/WAOl7SHXcKGEklJ0VEw5hgIQMngM=
X-Google-Smtp-Source: AK7set/B0YOfQTwXsoOHXsyQDaRzLNZcdOjSKT6hQKPnlQy1Sy+xTGXY8mhTxs/n//lvPa4Ldz7FJw==
X-Received: by 2002:a5d:500f:0:b0:2c5:505d:9078 with SMTP id e15-20020a5d500f000000b002c5505d9078mr2264731wrt.31.1676369607681;
        Tue, 14 Feb 2023 02:13:27 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe8c6000000b002c55551e6e9sm5799301wrn.108.2023.02.14.02.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:13:27 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max597x: Align for simple_mfd_i2c driver
Date:   Tue, 14 Feb 2023 11:13:20 +0100
Message-Id: <20230214101321.1902855-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap provided by simple_mfd_i2c driver and remove unused variable.
Identify device variant by checking compatible property in DT.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/max597x-regulator.c | 44 ++++++++++++++++++---------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index ab9dc18f98e3..5cc695b9d77a 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -425,41 +425,57 @@ static int max597x_setup_irq(struct device *dev,
 
 static int max597x_regulator_probe(struct platform_device *pdev)
 {
-
-
-	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
+	struct max597x_data *max597x;
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	struct max597x_regulator *data;
-
+	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
-	int num_switches = max597x->num_switches;
+	int num_switches;
 	int ret, i;
 
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	max597x = devm_kzalloc(&i2c->dev, sizeof(struct max597x_data), GFP_KERNEL);
+	if (!max597x)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, max597x);
+
+	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
+		max597x->num_switches = MAX597x_TYPE_MAX5978;
+	else
+		max597x->num_switches = MAX597x_TYPE_MAX5970;
+
+	i2c_set_clientdata(i2c, max597x);
+	num_switches = max597x->num_switches;
+
 	for (i = 0; i < num_switches; i++) {
 		data =
-		    devm_kzalloc(max597x->dev, sizeof(struct max597x_regulator),
+		    devm_kzalloc(&i2c->dev, sizeof(struct max597x_regulator),
 				 GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
 		data->num_switches = num_switches;
-		data->regmap = max597x->regmap;
+		data->regmap = regmap;
 
-		ret = max597x_adc_range(data->regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
+		ret = max597x_adc_range(regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
 		if (ret < 0)
 			return ret;
 
 		data->irng = max597x->irng[i];
 		data->mon_rng = max597x->mon_rng[i];
 
-		config.dev = max597x->dev;
+		config.dev = &i2c->dev;
 		config.driver_data = (void *)data;
 		config.regmap = data->regmap;
-		rdev = devm_regulator_register(max597x->dev,
+		rdev = devm_regulator_register(&i2c->dev,
 					       &regulators[i], &config);
 		if (IS_ERR(rdev)) {
-			dev_err(max597x->dev, "failed to register regulator %s\n",
+			dev_err(&i2c->dev, "failed to register regulator %s\n",
 				regulators[i].name);
 			return PTR_ERR(rdev);
 		}
@@ -467,12 +483,12 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
 	}
 
-	if (max597x->irq) {
+	if (i2c->irq) {
 		ret =
-		    max597x_setup_irq(max597x->dev, max597x->irq, rdevs, num_switches,
+		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
 				      data);
 		if (ret) {
-			dev_err(max597x->dev, "IRQ setup failed");
+			dev_err(&i2c->dev, "IRQ setup failed");
 			return ret;
 		}
 	}

base-commit: ea3efd52e96287ce8d93563b1084429686b6e824
-- 
2.39.1

