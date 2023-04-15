Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273BC6E3474
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDOXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDOXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:12:14 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A416F119;
        Sat, 15 Apr 2023 16:12:12 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PzTbq3hhTz9t50;
        Sun, 16 Apr 2023 01:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=usGOq1CJVdyzoBS9/FtpRn4wOOe3OcKpt0J8nGiDhmo=;
        b=2FHWamYaZ2WM8wU+sbGCn7qzr1AA3IeEMYavJAGgZap823ocFWASBpWMDf0/PHJTxW/mQi
        Nw0USwKpyfbpyGyGUz1UL3XvkrLzVgd+v2PTaNAj2WmufdTVzZjLWHAcp5KTM5eMFxGIoC
        xwuxvdQZGK3nWjb5vmR87/dn2pwLRiGsvCo6qVBYAjEk4tjtu63Nn2pfvoENp8QQU3AvDv
        vIPeIsE1J0rCuZwYSSulUztPqSjdORS+nGQaVwDt52rRkCMj0dWa3nkoHXkPp3Jzu5LxaR
        u7wfvcoBOHioc27cfy51agx4w8WqPdsxu9Wzg3pdYZRSCUcIYF6p1QeyFaTSiQ==
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
Subject: [PATCH v3 3/6] iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
Date:   Sun, 16 Apr 2023 01:11:27 +0200
Message-Id: <20230415231130.115094-4-mail@mariushoch.de>
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

The lsm303d is basically the lsm9ds0 without the gyroscope
(which the LSM9DS0 IMU driver doesn't handle), as far as I
can tell.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/iio/imu/st_lsm9ds0/Kconfig          | 3 ++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 5 +++++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/Kconfig b/drivers/iio/imu/st_lsm9ds0/Kconfig
index d29558edee60..7aef714b6ecb 100644
--- a/drivers/iio/imu/st_lsm9ds0/Kconfig
+++ b/drivers/iio/imu/st_lsm9ds0/Kconfig
@@ -10,7 +10,8 @@ config IIO_ST_LSM9DS0
 
 	help
 	  Say yes here to build support for STMicroelectronics LSM9DS0 IMU
-	  sensor. Supported devices: accelerometer/magnetometer of lsm9ds0.
+	  sensor. Supported devices: accelerometer/magnetometer of lsm9ds0
+	  and lsm303d.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm9ds0.
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index a90138d8b06a..64fa77d302e2 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -22,12 +22,17 @@ static const struct of_device_id st_lsm9ds0_of_match[] = {
 		.compatible = "st,lsm9ds0-imu",
 		.data = LSM9DS0_IMU_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303d-imu",
+		.data = LSM303D_IMU_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
 
 static const struct i2c_device_id st_lsm9ds0_id_table[] = {
 	{ LSM9DS0_IMU_DEV_NAME },
+	{ LSM303D_IMU_DEV_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index b743bf3546a7..997b5ff792be 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -22,12 +22,17 @@ static const struct of_device_id st_lsm9ds0_of_match[] = {
 		.compatible = "st,lsm9ds0-imu",
 		.data = LSM9DS0_IMU_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303d-imu",
+		.data = LSM303D_IMU_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
 
 static const struct spi_device_id st_lsm9ds0_id_table[] = {
 	{ LSM9DS0_IMU_DEV_NAME },
+	{ LSM303D_IMU_DEV_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
-- 
2.39.2

