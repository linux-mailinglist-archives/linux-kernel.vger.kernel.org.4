Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909897506F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjGLLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjGLLtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F551FFC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so5158407f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689162496; x=1691754496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNQjkE8rt0loSfu/6IF9XOAi/Sv+jFDCxC5ymTmcAL4=;
        b=QW1OxwFcn9/fM3iz2FPMk84jEGix8ud6DvyCVmxBy/7qEKrS9e/ynEzWm9B+Am0Hg/
         QQmzkhQhEPk14OWaW4uMddOPGEYsw+4C/4LqtG2r4YaDKwhKwwh2w8FJQ16TOnsNzET8
         ymxGgCI2DCwcXjH/0bcJMQlO+w+iaR+QY5GeOT+7C/93teYnYK+UBNGc4E8qFIPyN//b
         rwlaGuN8g0yMFFFSnnyjaMqJXHYHB//ROaId+Dvm8/cXVeyQRREweVth953vMnFKU+69
         eixZmccmqrDJ5M9O03PIuS5DGnkQY0ShbrD2vWEKqPQNRaWPL8qH43rZN3XuaVO43G7i
         H7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162496; x=1691754496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNQjkE8rt0loSfu/6IF9XOAi/Sv+jFDCxC5ymTmcAL4=;
        b=ea9W0v/6KtChmzj/KpQBdUp2g+8cs/Kk8HoiaoNK5GgLiYURpt0XiMfCOxKvBHxlI6
         08MbFuTtWd1fomN50p7bFS4737vOzw1JghWt2j06HBVsEAHeWz8fYh8YC5on4IB83DFx
         vkvzwGOQMXjKcO+d0owdr02hFyv/O9JXej0yMmgGo5F9urScZhspMCHv7DEvqRNTXiwx
         u60nbotE2liUujZZipqZcoElo1MBXWtzGqXu3FPv1eKjqOzEk5u5BXbE6sWrgs1TERwz
         obJ1isIkuvKLJ5LfPzGV4bK72aKvubX2nIzv8dcZYXe93OOZv3z14i/AuGvITCrxRVK9
         UpCQ==
X-Gm-Message-State: ABy/qLZI1fngRym8oewfqeK9S89amnVAqNMb4cI5c/q3HDj02sPkch8r
        kf8tVpLYt7hcC9zNiDDUwhiHPil7ZYI2YCnlydmToA==
X-Google-Smtp-Source: APBJJlEHu+LWsBZwzQyp91w3w+GjYNtGjUEvFktx8zUoyy7jJBprAPT714dEj1P/lQRadTB1gApCwg==
X-Received: by 2002:adf:e483:0:b0:314:1bb7:8a19 with SMTP id i3-20020adfe483000000b003141bb78a19mr15814202wrm.35.1689162496665;
        Wed, 12 Jul 2023 04:48:16 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4867463wrq.63.2023.07.12.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:48:16 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 3/8] hwmon: (pmbus/mp2975) Prepare for MP2973 and MP2971
Date:   Wed, 12 Jul 2023 13:47:44 +0200
Message-ID: <20230712114754.500477-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support for differntiating between the chips.
The following commits will make use of this mechanism.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 130cfde52e42..04778f2dcbdb 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include "pmbus.h"
 
 /* Vendor specific registers. */
@@ -56,8 +57,13 @@
 				 PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | \
 				 PMBUS_HAVE_POUT | PMBUS_PHASE_VIRTUAL)
 
+enum chips {
+	mp2975
+};
+
 struct mp2975_data {
 	struct pmbus_driver_info info;
+	enum chips chip_id;
 	int vout_scale;
 	int vid_step[MP2975_PAGE_NUM];
 	int vref[MP2975_PAGE_NUM];
@@ -68,6 +74,13 @@ struct mp2975_data {
 	int curr_sense_gain[MP2975_PAGE_NUM];
 };
 
+static const struct i2c_device_id mp2975_id[] = {
+	{"mp2975", mp2975},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, mp2975_id);
+
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
 static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
@@ -691,6 +704,11 @@ static int mp2975_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
+	if (client->dev.of_node)
+		data->chip_id = (enum chips)of_device_get_match_data(&client->dev);
+	else
+		data->chip_id = i2c_match_id(mp2975_id, client)->driver_data;
+
 	memcpy(&data->info, &mp2975_info, sizeof(*info));
 	info = &data->info;
 
@@ -739,15 +757,8 @@ static int mp2975_probe(struct i2c_client *client)
 	return pmbus_do_probe(client, info);
 }
 
-static const struct i2c_device_id mp2975_id[] = {
-	{"mp2975", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, mp2975_id);
-
 static const struct of_device_id __maybe_unused mp2975_of_match[] = {
-	{.compatible = "mps,mp2975"},
+	{.compatible = "mps,mp2975", .data = (void *)mp2975},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mp2975_of_match);
-- 
2.41.0

