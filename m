Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5B7506FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjGLLt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjGLLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45582136
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so7800863f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689162501; x=1691754501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRZ8NxnOXW8JvRWNhwwvJBRU3h2xQilhA7rCBni0gfM=;
        b=KLuKSdTkted1k+klbAISadfrB0aMXnWX4BClAnoYzFLEAXLGw5nw55vaJUSFmDbisS
         xsAaZE7jTejPP8p5sMas5oCuBto/nSHHPjWVPQiTBHQtWnF51qcLn0CI674lYH6qcutZ
         8eStdOxCH4k8UIfwVxPjIAfUVGRorz8e7AshkQOKU+g1KeNlCqPET+x5s8hLupTl0MpI
         sM0VMyJzOZz8OLYkRXDjM0MdVCTwPwJX9aP/7Dx/AfVyYuuSOHXHEpEvEWo8NDtno/NP
         e3v7ygUiNsxs95+oPWlTaF6OM9KzCJ7+9mnfnOzm0W8ZsS4fqzxtsxGVC4TLYBklanWf
         rYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162501; x=1691754501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRZ8NxnOXW8JvRWNhwwvJBRU3h2xQilhA7rCBni0gfM=;
        b=chruerIbdPx1FkVYb6luMj4zTXc4KiLXw6QnDLkhLCb9asVx0QnLTERw2nKmQ4hia6
         WvJb41GCw8goFyqlnDFhE3C7yYN4MqWf9KJZMMCzgtq4APe1Yl6WTamTnwEbx0ce9b1J
         QXHNeQ33UpAjw+bV0nDVxT/FFeUED+1N1456ZQp23sBhhhutO4kWKhj/YiJhgOf8DUhe
         w4c2jLM9dG2JgzXYQHS4yQI8PhfczYaYZ0R8esMy9LpXUi8nEgml405iBxOeuu4vdh2M
         7rjDcrc5cLB3rBFniuqHYH2ddZ9Xb+nF4/wUleadmeLV7E0ePn8gVCdbe4BB4HL90H1u
         hm0Q==
X-Gm-Message-State: ABy/qLaNP5CJG00vcwOlXkin0HOLvjn7KMoLJRaGVC+0BpiIALQOnf6y
        32FN82A7mn2BrUDgKUHKs4wycw==
X-Google-Smtp-Source: APBJJlESDehq8e1onr0l4wZzPt3//1D1eOaNbwRus24bQ0Locw7joy+FRDbz8Z3auluLgcmBjp9kSw==
X-Received: by 2002:adf:f604:0:b0:313:f6fc:1f48 with SMTP id t4-20020adff604000000b00313f6fc1f48mr23901670wrp.14.1689162501667;
        Wed, 12 Jul 2023 04:48:21 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4867463wrq.63.2023.07.12.04.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:48:21 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 7/8] hwmon: (pmbus/mp2975) Add regulator support
Date:   Wed, 12 Jul 2023 13:47:48 +0200
Message-ID: <20230712114754.500477-7-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support to expose the PMBUS regulator.

Tested on MP2973 and MP2971.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/Kconfig  |  7 +++++++
 drivers/hwmon/pmbus/mp2975.c | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 270b6336b76d..b4e93bd5835e 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -317,6 +317,13 @@ config SENSORS_MP2975
 	  This driver can also be built as a module. If so, the module will
 	  be called mp2975.
 
+config SENSORS_MP2975_REGULATOR
+	depends on SENSORS_MP2975 && REGULATOR
+	bool "Regulator support for MPS MP2975"
+	help
+	  If you say yes here you get regulator support for MPS MP2975
+	  Dual Loop Digital Multi-Phase Controller.
+
 config SENSORS_MP5023
 	tristate "MPS MP5023"
 	help
diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 83242595ccbe..27a9724aed68 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -115,6 +115,11 @@ static const struct i2c_device_id mp2975_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, mp2975_id);
 
+static const struct regulator_desc __maybe_unused mp2975_reg_desc[] = {
+	PMBUS_REGULATOR("vout", 0),
+	PMBUS_REGULATOR("vout", 1),
+};
+
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
 static int
@@ -807,6 +812,10 @@ static struct pmbus_driver_info mp2975_info = {
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
 	.read_word_data = mp2975_read_word_data,
+#if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
+	.num_regulators = 1,
+	.reg_desc = mp2975_reg_desc,
+#endif
 };
 
 static struct pmbus_driver_info mp2973_info = {
@@ -824,6 +833,10 @@ static struct pmbus_driver_info mp2973_info = {
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
 	.read_word_data = mp2973_read_word_data,
+#if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
+	.num_regulators = 1,
+	.reg_desc = mp2975_reg_desc,
+#endif
 };
 
 static int mp2975_probe(struct i2c_client *client)
@@ -862,6 +875,8 @@ static int mp2975_probe(struct i2c_client *client)
 		data->info.pages = MP2975_PAGE_NUM;
 		data->info.phases[1] = ret;
 		data->info.func[1] = MP2975_RAIL2_FUNC;
+		if (CONFIG_SENSORS_MP2975_REGULATOR)
+			data->info.num_regulators = MP2975_PAGE_NUM;
 	}
 
 	if (data->chip_id == mp2975) {
-- 
2.41.0

