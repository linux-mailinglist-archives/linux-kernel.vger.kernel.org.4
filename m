Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F564C4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiLNIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiLNIH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:07:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFAB1EECE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:07:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h7so18417228wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPKbqc0ak5V4UJgzOj7j3ooXS6vGnBnkbq2OKYA/WT4=;
        b=GKMFGf7uTwbrGxI72tbBYjGVoIHtTjvHBLWSUmjOvGwhKnjG1sd1NNkSsecFPljB5r
         lg4ycYrz/8FSi/Ai9o9t2R5Bm26ByJEKc2jeKMSywKSSMzsocU8Rmx18GjSXxnxofumH
         pV1u8y2fyS6V3BIYWr3Kej7OcY67raaFmiuwQN0IymI8mIWzsZRGTTOsWplLnu6mZXN4
         HQAyAQa3zUFAoN9rnDDjdfKxmRxfSBJc9+EZkzdbubpCPbrh84SXui/oRRJc2XXcdEic
         gd/VnYDd8PoaypUf8V134FPEvEf/KbMTmLoJ/BeR+5GJdO2B3ZeaYOsaH/qTUAlwkSMn
         1krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPKbqc0ak5V4UJgzOj7j3ooXS6vGnBnkbq2OKYA/WT4=;
        b=jnFAxo2luAIXhaDA/DNAXYtKY0byQ+kN75WDN0gO7tuLO5VvTkQe7mDrVq6mw+Nqaj
         QpCIRi4NvLmA9EHGd+3l8v0g7uBLSh3HC2WJ9n7WpqscOPqmla7rEzR2+rwRs0lAJnU5
         mOQ8rxKxjcG5wpo8xFJXz53y3lEF8N87mnMbNBCOm3kLhrDd9Xczpjblmghp08Cj0lVu
         4HJUK6IitvXQQ31AKgn4uuXUhGaZvYOBn0Kx8CcGj/MnXOzgVNNEQF0K928R2LeyfmpI
         uw0E2GWmlfmqOai+yUCJYTCFwwhBUNCqLk26nGfOMG3IF4fMcPGd47enf/VHv8E3bO2j
         C7rA==
X-Gm-Message-State: ANoB5pkuIQCRNztlfdPX6JJ2G0gibI2iExchGymRqUs3F7YKENAlQ5hn
        wzcSUFQwJQh8udQKwV1P0zkrrw==
X-Google-Smtp-Source: AA0mqf7UtxNoaFBj73SD2lWLqolQ01D/5JfjnxsBZ67/H+DBrzDzvRHvJdoB1ZaFnM4TSoqX4AJJAA==
X-Received: by 2002:adf:fc8a:0:b0:242:14bb:439d with SMTP id g10-20020adffc8a000000b0024214bb439dmr13317808wrr.43.1671005244192;
        Wed, 14 Dec 2022 00:07:24 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d5183000000b002422bc69111sm2500781wrv.9.2022.12.14.00.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:07:23 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH RESEND v6 3/5] hwmon: (pmbus/core): Add rdev in pmbus_data struct
Date:   Wed, 14 Dec 2022 09:07:13 +0100
Message-Id: <20221214080715.2700442-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
References: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
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

Add regulator device in pmbus_data & initialize the same during PMBus
regulator register.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

---
Change in V5:
- Fix error check for rdev
---
 drivers/hwmon/pmbus/pmbus_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index b005a1c8ad7e..afd98e639b4f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -81,6 +81,7 @@ struct pmbus_label {
 struct pmbus_data {
 	struct device *dev;
 	struct device *hwmon_dev;
+	struct regulator_dev **rdevs;
 
 	u32 flags;		/* from platform data */
 
@@ -3095,9 +3096,13 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 	struct device *dev = data->dev;
 	const struct pmbus_driver_info *info = data->info;
 	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
-	struct regulator_dev *rdev;
 	int i;
 
+	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
+				  GFP_KERNEL);
+	if (!data->rdevs)
+		return -ENOMEM;
+
 	for (i = 0; i < info->num_regulators; i++) {
 		struct regulator_config config = { };
 
@@ -3107,10 +3112,10 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 		if (pdata && pdata->reg_init_data)
 			config.init_data = &pdata->reg_init_data[i];
 
-		rdev = devm_regulator_register(dev, &info->reg_desc[i],
+		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
 					       &config);
-		if (IS_ERR(rdev))
-			return dev_err_probe(dev, PTR_ERR(rdev),
+		if (IS_ERR(data->rdevs[i]))
+			return dev_err_probe(dev, PTR_ERR(data->rdevs[i]),
 					     "Failed to register %s regulator\n",
 					     info->reg_desc[i].name);
 	}
-- 
2.37.3

