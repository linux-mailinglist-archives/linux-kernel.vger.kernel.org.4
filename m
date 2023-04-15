Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAF6E3471
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDOXMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjDOXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:12:14 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A396FD8;
        Sat, 15 Apr 2023 16:12:12 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PzTbs1M44z9t5J;
        Sun, 16 Apr 2023 01:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WwL9O2qJHa3oAVrL3RtZPgGuUcuaz3nWHKZHdcckfE=;
        b=t8cnwrEDXGqyObXq8Ob/gBnWBO/8SjRfyoSAYDWozunBkZTRgy2fI5AlwY2vSrUh0vYiYy
        7KhlPdTs3JWS8BfXbWA/S2FMs5CnBp/5WkAnhXjxS2Fbw7F3EViP/DhY9S+DC5fuLJoqi3
        o5ATap13cpZ07IPihn0W33cBmkdJSEBl1MvP7cxfB2pmiNazrsEHuBq2VSsBuveNxDUC9+
        VsJp0pWHUKvlHbppMI4B0YDK1IPU+aadSizYqZo3jl6+Aciu1cXkmrylkkrRWxXrwOUH2j
        cGWUh14rfzKRD6VraM3hIkSTy7BHGgwa2zvwVBzbW3V+zf/Q0HFDAY3iWMeTiw==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH v3 4/6] iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU driver
Date:   Sun, 16 Apr 2023 01:11:28 +0200
Message-Id: <20230415231130.115094-5-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-1-mail@mariushoch.de>
References: <20230415231130.115094-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lsm303d can be found as ACCL0001 on various Lenovo devices,
including the Lenovo Yoga Tablet 2 1051-F, where I tested this
patch.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 7 +++++++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 64fa77d302e2..52f1ea6c457f 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -37,6 +37,12 @@ static const struct i2c_device_id st_lsm9ds0_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
 
+static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
+	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
+
 static const struct regmap_config st_lsm9ds0_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -73,6 +79,7 @@ static struct i2c_driver st_lsm9ds0_driver = {
 	.driver = {
 		.name = "st-lsm9ds0-i2c",
 		.of_match_table = st_lsm9ds0_of_match,
+		.acpi_match_table = st_lsm9ds0_acpi_match,
 	},
 	.probe_new = st_lsm9ds0_i2c_probe,
 	.id_table = st_lsm9ds0_id_table,
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 997b5ff792be..55f3738193af 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -37,6 +37,12 @@ static const struct spi_device_id st_lsm9ds0_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
 
+static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
+	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
+
 static const struct regmap_config st_lsm9ds0_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -72,6 +78,7 @@ static struct spi_driver st_lsm9ds0_driver = {
 	.driver = {
 		.name = "st-lsm9ds0-spi",
 		.of_match_table = st_lsm9ds0_of_match,
+		.acpi_match_table = st_lsm9ds0_acpi_match,
 	},
 	.probe = st_lsm9ds0_spi_probe,
 	.id_table = st_lsm9ds0_id_table,
-- 
2.39.2

