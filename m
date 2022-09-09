Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D144F5B3CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiIIQQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIIQQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:16:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835E25FD;
        Fri,  9 Sep 2022 09:16:23 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:d3c:a31c:505b:8c33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 675A66601FCE;
        Fri,  9 Sep 2022 17:16:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662740182;
        bh=P73UmruTIgGwoattykcVFsS34pWZY7pFVqf6/g55H4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzK2hwt7nLsGVliAf0YWzjfOswbsoIdmwWeGdXPIF7YuWBft4k+wDXrIse9UBpTVZ
         +38t7ZkmbqWaJmMvuEgGiD1X1y4woGORKqg1DksM/oNPezQKyqKbf1JeTKN0t3w39w
         oJTfXeGy5aqtLsUPFN1xrs8Sy6oOsMEzzwxK2jWRwkl6UhqABtcou8supIFV8myE87
         9QxlhjpTWSYqqyf7C4+n2opPFUcrwWQmtlqJFdZ9ZwiCFtZkEtyuZN7useASXNmq8X
         vkfkViqUjfapr00baWBnstbiOAC+QJpXQbwTOZj4v9lOOeJvUrSKKhJ4LaqOFX6s8N
         Egv6tasImHDoA==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.co.uk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: pressure: st_pressure: Add support for LPS22DF
Date:   Fri,  9 Sep 2022 17:16:10 +0100
Message-Id: <20220909161611.780720-2-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909161611.780720-1-martyn.welch@collabora.co.uk>
References: <20220909161611.780720-1-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ST LPS22DF pressure sensor.

Datasheet: https://www.st.com/resource/en/datasheet/lps22df.pdf
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/iio/pressure/st_pressure.h      |  2 +
 drivers/iio/pressure/st_pressure_core.c | 70 +++++++++++++++++++++++++
 drivers/iio/pressure/st_pressure_i2c.c  |  5 ++
 drivers/iio/pressure/st_pressure_spi.c  |  5 ++
 4 files changed, 82 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 156e6a72dc5c..6e11bea784fa 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -22,6 +22,7 @@ enum st_press_type {
 	LPS33HW,
 	LPS35HW,
 	LPS22HH,
+	LPS22DF,
 	ST_PRESS_MAX,
 };
 
@@ -32,6 +33,7 @@ enum st_press_type {
 #define LPS33HW_PRESS_DEV_NAME		"lps33hw"
 #define LPS35HW_PRESS_DEV_NAME		"lps35hw"
 #define LPS22HH_PRESS_DEV_NAME		"lps22hh"
+#define LPS22DF_PRESS_DEV_NAME		"lps22df"
 
 /**
  * struct st_sensors_platform_data - default press platform data
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 76913a2028d2..80176e3083af 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -552,6 +552,76 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
+	{
+		/*
+		 * CUSTOM VALUES FOR LPS22DF SENSOR
+		 * See LPS22DF datasheet:
+		 * http://www.st.com/resource/en/datasheet/lps22df.pdf
+		 */
+		.wai = 0xb4,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LPS22DF_PRESS_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_press_lps22hb_channels,
+		.num_ch = ARRAY_SIZE(st_press_lps22hb_channels),
+		.odr = {
+			.addr = 0x10,
+			.mask = 0x78,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01 },
+				{ .hz = 4, .value = 0x02 },
+				{ .hz = 10, .value = 0x03 },
+				{ .hz = 25, .value = 0x04 },
+				{ .hz = 50, .value = 0x05 },
+				{ .hz = 75, .value = 0x06 },
+				{ .hz = 100, .value = 0x07 },
+				{ .hz = 200, .value = 0x08 },
+			},
+		},
+		.pw = {
+			.addr = 0x10,
+			.mask = 0x78,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.fs = {
+			.fs_avl = {
+				/*
+				 * Pressure and temperature sensitivity values
+				 * as defined in table 2 of LPS22DF datasheet.
+				 */
+				[0] = {
+					.num = ST_PRESS_FS_AVL_1260MB,
+					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
+					.gain2 = ST_PRESS_LPS22HB_LSB_PER_CELSIUS,
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x11,
+			.mask = BIT(3),
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x13,
+				.mask = BIT(5),
+				.addr_od = 0x12,
+				.mask_od = BIT(1),
+			},
+			.addr_ihl = 0x12,
+			.mask_ihl = BIT(3),
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x03,
+			},
+		},
+		.sim = {
+			.addr = 0x0E,
+			.value = BIT(5),
+		},
+		.multi_read_bit = false,
+		.bootime = 2,
+	},
 };
 
 static int st_press_write_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 7035777fd988..58fede861891 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -47,6 +47,10 @@ static const struct of_device_id st_press_of_match[] = {
 		.compatible = "st,lps22hh",
 		.data = LPS22HH_PRESS_DEV_NAME,
 	},
+	{
+		.compatible = "st,lps22df",
+		.data = LPS22DF_PRESS_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
@@ -67,6 +71,7 @@ static const struct i2c_device_id st_press_id_table[] = {
 	{ LPS33HW_PRESS_DEV_NAME, LPS33HW },
 	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
 	{ LPS22HH_PRESS_DEV_NAME, LPS22HH },
+	{ LPS22DF_PRESS_DEV_NAME, LPS22DF },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_press_id_table);
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index bfab8e7fb061..25cca5ad7c55 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -51,6 +51,10 @@ static const struct of_device_id st_press_of_match[] = {
 		.compatible = "st,lps22hh",
 		.data = LPS22HH_PRESS_DEV_NAME,
 	},
+	{
+		.compatible = "st,lps22df",
+		.data = LPS22DF_PRESS_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
@@ -97,6 +101,7 @@ static const struct spi_device_id st_press_id_table[] = {
 	{ LPS33HW_PRESS_DEV_NAME },
 	{ LPS35HW_PRESS_DEV_NAME },
 	{ LPS22HH_PRESS_DEV_NAME },
+	{ LPS22DF_PRESS_DEV_NAME },
 	{ "lps001wp-press" },
 	{ "lps25h-press", },
 	{ "lps331ap-press" },
-- 
2.35.1

