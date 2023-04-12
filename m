Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2706E01EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDLWhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDLWhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:37:05 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223240D3;
        Wed, 12 Apr 2023 15:37:04 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Pxcyj2rNyz9t4f;
        Thu, 13 Apr 2023 00:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681339021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OflZ1RQRYS0/eVL+f/CPrQlcwSt09TX0tGm9J6rHhqk=;
        b=h7qusGoSLdrfx8DItFUEDDNlXRyLftV+S9hq0L+tIawAReu0zJGwhAuxTnK9qC8Ir1w22M
        poNzRhHXvzGM8BKVp1ivP60gMtW6lWSytoF46eTMqwcTcmNMQHW5k2LpXfvWBs/DeCtJM4
        sS9TlJGs5sovibQZXCJcP8hKqoYqKGzm0zJXfBhADBWRoOAvo+djKOjl9YczosAHglSQ3f
        dXSP3sdDFg70jn3VGWYoSoSQdCRtETcOyznDDiCj4fr6BBGetk7/ssGYZLFSClmz1kEN11
        KiUxy87NjPJSPJo2E0plFHdCBBg//6Tg64i/6n2j974KKvV3X2Y9+On5WECCwg==
From:   mail@mariushoch.de
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU driver
Date:   Thu, 13 Apr 2023 00:36:25 +0200
Message-Id: <20230412223627.442963-5-mail@mariushoch.de>
In-Reply-To: <20230412223627.442963-1-mail@mariushoch.de>
References: <20230412223627.442963-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Pxcyj2rNyz9t4f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Hoch <mail@mariushoch.de>

The lsm303d can be found as ACCL0001 on various Lenovo devices,
including the Lenovo Yoga Tablet 2 1051-F, where I tested this
patch.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 10 ++++++++++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 64fa77d302e2..79be8d28d965 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
 
@@ -37,6 +38,14 @@ static const struct i2c_device_id st_lsm9ds0_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
+	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
+#endif
+
 static const struct regmap_config st_lsm9ds0_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -73,6 +82,7 @@ static struct i2c_driver st_lsm9ds0_driver = {
 	.driver = {
 		.name = "st-lsm9ds0-i2c",
 		.of_match_table = st_lsm9ds0_of_match,
+		.acpi_match_table = ACPI_PTR(st_lsm9ds0_acpi_match),
 	},
 	.probe_new = st_lsm9ds0_i2c_probe,
 	.id_table = st_lsm9ds0_id_table,
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 997b5ff792be..27c5d99ce0e3 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 
 #include <linux/iio/common/st_sensors_spi.h>
 
@@ -37,6 +38,14 @@ static const struct spi_device_id st_lsm9ds0_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
+	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
+#endif
+
 static const struct regmap_config st_lsm9ds0_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -72,6 +81,7 @@ static struct spi_driver st_lsm9ds0_driver = {
 	.driver = {
 		.name = "st-lsm9ds0-spi",
 		.of_match_table = st_lsm9ds0_of_match,
+		.acpi_match_table = ACPI_PTR(st_lsm9ds0_acpi_match),
 	},
 	.probe = st_lsm9ds0_spi_probe,
 	.id_table = st_lsm9ds0_id_table,
-- 
2.39.2

