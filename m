Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF56E04D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjDMCrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjDMCre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:47:34 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754FD974D;
        Wed, 12 Apr 2023 19:46:52 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PxkN31FL5z9sb6;
        Thu, 13 Apr 2023 04:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681353651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=usGOq1CJVdyzoBS9/FtpRn4wOOe3OcKpt0J8nGiDhmo=;
        b=TZKDdSchNdL2FRjSGpdzfn7EZVw32kQ6v19POPmppGLeGnKkha8lq254z5KvcV5gb5KxEe
        IVRlAErdAsnstZPgwEgjWyMYvgyPfrXJpJaU5QpfvKQrqxUQkeFOL63BIrp1LYCvQTyFZI
        KFY2/mSmFZkBYNvVo2No0aQuKFLXoIosKoy7vmBnxmJxJ5ad1oKxxLJ3o0qYHDWVXYjx6l
        1OppeeJsXZcwYvIoBkSw+Zuli9WvaXSOHEp7AhPUzxGHw7zptzRdaXJeMjZlmorwRjGqEu
        0QV2BTOlMtA08aerS/n1kKk6vOGEAXAANSxfy4+JSEyu0G3iPUT8VszJ6S2cLg==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH v2 3/6] iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
Date:   Thu, 13 Apr 2023 04:40:10 +0200
Message-Id: <20230413024013.450165-4-mail@mariushoch.de>
In-Reply-To: <20230413024013.450165-1-mail@mariushoch.de>
References: <20230413024013.450165-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PxkN31FL5z9sb6
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

