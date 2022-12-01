Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77363F7D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLATES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLATEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:04:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5351EB5DAB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:04:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso2423126wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qJrq6T31sJxCZwbEqlMuOvpG+K/8IjspbhkPV4Km1Q=;
        b=BieDI7j0p2k4UdvUw+VseK1zFN/ztcclH0dB7sS8W8Y/OxGaD60WT2GdYKQxhMAeIb
         9wTFwgyyGGXiObTgAO8mQbDW/RqBv032O2a0OdeSgUprDsLQGl+Amt8OAB+OAXV0WZwL
         GViNwHvMUEiuSzwnqP4JY7wAFw3Qbkn3I8/K0tCqdLdV9mEqD7w09jvud1SRCmk+xHlS
         Om854Z9Wej7HDLmz9QPUk9fkLa9nsHzHAp9NRXu+K9izFTIzoJLiEku2nFeMfQ9vx+9P
         9Vn9r4zcWc8q4O5R00GiDkjNl49P0pEO1f8ErU5eeyUqckBm5KWYRJw/qZIQgojrKLXR
         Qhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qJrq6T31sJxCZwbEqlMuOvpG+K/8IjspbhkPV4Km1Q=;
        b=f0pi9zTcrAegRrfWeyBfil40r6lTaG/2O0+DusLTbsZNaXCl5OGJJZCcy7mstbhgqb
         GLhqoXJ7gbHBno5Sv6CdKHsXEYq01B0O5dbCOknjzyASPF33mQ/5qMWB5qB3N6btQB1E
         UmGgurtYijglqwi3Y4O0WxuV/4fq1ArcuOVMdcDh/DSwXufjQlQoH2wkjVDOnKeRsMrL
         c4cdqwuDPMojXGSmOoDqRhbJi2jYlDr+4YotI0ZRodmafOZjwXkF2q+ikZ4T+c/sk/zi
         eUHJu1VIB10egSpRktDf9n42zW6U+yGtQH03OFqYYZzSrIIZIBz+LZ32FS3XO/RoZEYz
         Fw3A==
X-Gm-Message-State: ANoB5pnjIN0bgn5uxfv2/curUZy11VZhs0zgsGe4f5P04IobYWh4jDPE
        Gd5OHV66qvCjnuhUWCz+LFwLCtMc2V/sP7i9
X-Google-Smtp-Source: AA0mqf4fIEZTSOeRw64Yxt3yShlZP2ND8snsB+jMWw6ZZXDJYGyu3r+mKmhyCxA+ooxov0eeyZ4D8w==
X-Received: by 2002:a1c:f617:0:b0:3cf:e0ef:1f69 with SMTP id w23-20020a1cf617000000b003cfe0ef1f69mr36382054wmc.163.1669921452846;
        Thu, 01 Dec 2022 11:04:12 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm11848474wmq.43.2022.12.01.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:04:12 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 1/5] hwmon: (pmbus/core): Add rdev in pmbus_data struct
Date:   Thu,  1 Dec 2022 20:03:50 +0100
Message-Id: <20221201190354.1512790-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
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
 drivers/hwmon/pmbus/pmbus_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..7a23794c0b93 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -81,6 +81,7 @@ struct pmbus_label {
 struct pmbus_data {
 	struct device *dev;
 	struct device *hwmon_dev;
+	struct regulator_dev **rdevs;
 
 	u32 flags;		/* from platform data */
 
@@ -3053,6 +3054,11 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 	struct regulator_dev *rdev;
 	int i;
 
+	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
+				  GFP_KERNEL);
+	if (!data->rdevs)
+		return -ENOMEM;
+
 	for (i = 0; i < info->num_regulators; i++) {
 		struct regulator_config config = { };
 
@@ -3062,7 +3068,7 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 		if (pdata && pdata->reg_init_data)
 			config.init_data = &pdata->reg_init_data[i];
 
-		rdev = devm_regulator_register(dev, &info->reg_desc[i],
+		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
 					       &config);
 		if (IS_ERR(rdev))
 			return dev_err_probe(dev, PTR_ERR(rdev),

base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
-- 
2.37.3

