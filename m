Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311DD6B0240
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCHJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCHJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:02:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275996F08;
        Wed,  8 Mar 2023 01:02:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id da10so62850208edb.3;
        Wed, 08 Mar 2023 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55SQUAk//QC5U//Z8hGQWQU2CP1NvhaerZos5P4MWWc=;
        b=gWn8+BVpTHoRPUxvtiQ3hKY2CCkGfffM6VhgnzaaI0D0eOJJGoxfuHYd3WGZ39gjbE
         eXm+BWXvQmzpb4PzRaVrm5E4ugykb1mMChvt3IHapyZCRkH0ZfRKr2tvz6PvW+TCM0Kn
         ibZpxPEsyX0iqdOzETv01MpzD4d4A8tc5YJYaeeroG4yJx6TYx4XZpjg6ZQun58RcqS6
         CB3xaxuf3CFDtpOQN6PmBm7nH5mVhoihwaGXLFecA79m8stDq5mzL7UMn7UCFYqkpuGs
         VS8wWGzGO07FX0x8xKh2aGe7QTRtGXAYCFWVq5AOom1LZAOQ5njWertcaBjSJn9t83RY
         mQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55SQUAk//QC5U//Z8hGQWQU2CP1NvhaerZos5P4MWWc=;
        b=sQKvcFDNWKA6/sM6e18hEMPonxqfLVw30HuLFKHU2qFksEdKp0Rg5Pit3QNUzJ6C7O
         QXDuoKVgX+xH1e3YdhcDnc03NcUvreH+xn+SfW0CRsexkbOL2PtTsgRXCkte6re0D2wD
         Ln2pMBaY/aJz4r0ZMXl2NDUiMVkZOZOCQtaY93emzCa6op9zFM0wzgvLqjO07FQyYBYe
         fFQJ5J+C5M4uygdsH1hF3foLtX+NIUgIhGNbDpG0VSzOxXFo5M3R5bfSSLWKDmY4ywtU
         ZO3PhtJ1ZrbXGrgctHslqxpwHVezVA0Q6whBWFylqaEqRkE2+LVHIXU8y1rwLLNOxm32
         EYig==
X-Gm-Message-State: AO0yUKXucJYPVdMdH9IJdVnx/E38mQ0jUswSebIKCexaHr2YT2cZ9Gfl
        2s3GN0QNnTmsN7vNUjFPPIU=
X-Google-Smtp-Source: AK7set+iAwr+86fF7GqTEw4Jo1JPFBRj/AFa1nEg52dp0jhfGWTf2491KdTDH6NYkyv1hPavif+M3Q==
X-Received: by 2002:a17:907:5cb:b0:8b1:3a23:8ec7 with SMTP id wg11-20020a17090705cb00b008b13a238ec7mr22344377ejb.43.1678266150516;
        Wed, 08 Mar 2023 01:02:30 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b008caaae1f1e1sm7153709ejn.110.2023.03.08.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:02:30 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] misc: apds990x: convert to IIO
Date:   Wed,  8 Mar 2023 11:02:18 +0200
Message-Id: <20230308090219.12710-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308090219.12710-1-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert old sysfs export to an IIO look.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/apds990x.c | 794 ++++++++++++++++++++--------------------
 1 file changed, 403 insertions(+), 391 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index c53ead5a575d..0352962d6d89 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -20,6 +20,9 @@
 #include <linux/slab.h>
 #include <linux/platform_data/apds990x.h>
 
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
 /* Register map */
 #define APDS990X_ENABLE	 0x00 /* Enable of states and interrupts */
 #define APDS990X_ATIME	 0x01 /* ALS ADC time  */
@@ -100,6 +103,21 @@
 
 #define APDS990X_LUX_OUTPUT_SCALE 10
 
+enum {
+	APDS990X_LUX_RANGE_ATTR = 1,
+	APDS990X_LUX_CALIB_FORMAT_ATTR,
+	APDS990X_LUX_CALIB_ATTR,
+	APDS990X_LUX_RATE_AVAIL_ATTR,
+	APDS990X_LUX_RATE_ATTR,
+	APDS990X_LUX_THRESH_ABOVE_ATTR,
+	APDS990X_LUX_THRESH_BELOW_ATTR,
+	APDS990X_PROX_SENSOR_RANGE_ATTR,
+	APDS990X_PROX_THRESH_ABOVE_VALUE_ATTR,
+	APDS990X_PROX_REPORTING_MODE_ATTR,
+	APDS990X_PROX_REPORTING_MODE_AVAIL_ATTR,
+	APDS990X_CHIP_ID_ATTR,
+};
+
 /* Reverse chip factors for threshold calculation */
 struct reverse_factors {
 	u32 afactor;
@@ -116,7 +134,7 @@ struct apds990x_chip {
 	struct regulator_bulk_data	regs[2];
 	wait_queue_head_t		wait;
 
-	int	prox_en;
+	bool	prox_en;
 	bool	prox_continuous_mode;
 	bool	lux_wait_fresh_res;
 
@@ -235,12 +253,8 @@ static int apds990x_write_word(struct apds990x_chip *chip, u8 reg, u16 data)
 
 static int apds990x_mode_on(struct apds990x_chip *chip)
 {
-	/* ALS is mandatory, proximity optional */
 	u8 reg = APDS990X_EN_AIEN | APDS990X_EN_PON | APDS990X_EN_AEN |
-		APDS990X_EN_WEN;
-
-	if (chip->prox_en)
-		reg |= APDS990X_EN_PIEN | APDS990X_EN_PEN;
+		APDS990X_EN_WEN | APDS990X_EN_PIEN | APDS990X_EN_PEN;
 
 	return apds990x_write_byte(chip, APDS990X_ENABLE, reg);
 }
@@ -473,7 +487,8 @@ static int apds990x_ack_int(struct apds990x_chip *chip, u8 mode)
 
 static irqreturn_t apds990x_irq(int irq, void *data)
 {
-	struct apds990x_chip *chip = data;
+	struct iio_dev *indio_dev = data;
+	struct apds990x_chip *chip = iio_priv(indio_dev);
 	u8 status;
 
 	apds990x_read_byte(chip, APDS990X_STATUS, &status);
@@ -498,12 +513,10 @@ static irqreturn_t apds990x_irq(int irq, void *data)
 				chip->lux = chip->lux_raw;
 				chip->lux_wait_fresh_res = false;
 				wake_up(&chip->wait);
-				sysfs_notify(&chip->client->dev.kobj,
-					NULL, "lux0_input");
 			}
 		}
 
-		if ((status & APDS990X_ST_PINT) && chip->prox_en) {
+		if (status & APDS990X_ST_PINT) {
 			u16 clr_ch;
 
 			apds990x_read_word(chip, APDS990X_CDATAL, &clr_ch);
@@ -525,8 +538,6 @@ static irqreturn_t apds990x_irq(int irq, void *data)
 				chip->prox_data = 0;
 			else if (!chip->prox_continuous_mode)
 				chip->prox_data = APDS_PROX_RANGE;
-			sysfs_notify(&chip->client->dev.kobj,
-				NULL, "prox0_raw");
 		}
 	}
 	mutex_unlock(&chip->mutex);
@@ -619,102 +630,67 @@ static int apds990x_chip_off(struct apds990x_chip *chip)
 	return 0;
 }
 
-static ssize_t apds990x_lux_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct apds990x_chip *chip = dev_get_drvdata(dev);
-	ssize_t ret;
-	u32 result;
-	long timeout;
-
-	if (pm_runtime_suspended(dev))
-		return -EIO;
-
-	timeout = wait_event_interruptible_timeout(chip->wait,
-						!chip->lux_wait_fresh_res,
-						msecs_to_jiffies(APDS_TIMEOUT));
-	if (!timeout)
-		return -EIO;
-
-	mutex_lock(&chip->mutex);
-	result = (chip->lux * chip->lux_calib) / APDS_CALIB_SCALER;
-	if (result > (APDS_RANGE * APDS990X_LUX_OUTPUT_SCALE))
-		result = APDS_RANGE * APDS990X_LUX_OUTPUT_SCALE;
-
-	ret = sprintf(buf, "%d.%d\n",
-		result / APDS990X_LUX_OUTPUT_SCALE,
-		result % APDS990X_LUX_OUTPUT_SCALE);
-	mutex_unlock(&chip->mutex);
-	return ret;
-}
+static const char * const reporting_modes[] = { "trigger", "periodic" };
 
-static DEVICE_ATTR(lux0_input, S_IRUGO, apds990x_lux_show, NULL);
-
-static ssize_t apds990x_lux_range_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%u\n", APDS_RANGE);
-}
-
-static DEVICE_ATTR(lux0_sensor_range, S_IRUGO, apds990x_lux_range_show, NULL);
-
-static ssize_t apds990x_lux_calib_format_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%u\n", APDS_CALIB_SCALER);
-}
-
-static DEVICE_ATTR(lux0_calibscale_default, S_IRUGO,
-		apds990x_lux_calib_format_show, NULL);
-
-static ssize_t apds990x_lux_calib_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t apds990x_lux_prox_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
 {
-	struct apds990x_chip *chip = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%u\n", chip->lux_calib);
-}
-
-static ssize_t apds990x_lux_calib_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct apds990x_chip *chip = dev_get_drvdata(dev);
-	unsigned long value;
-	int ret;
-
-	ret = kstrtoul(buf, 0, &value);
-	if (ret)
-		return ret;
-
-	chip->lux_calib = value;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds990x_chip *chip = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int i, len = 0;
+
+	mutex_lock(&indio_dev->mlock);
+	switch ((u32)this_attr->address) {
+	case APDS990X_LUX_RANGE_ATTR:
+		len = sprintf(buf, "%u\n", APDS_RANGE);
+		break;
+	case APDS990X_LUX_CALIB_FORMAT_ATTR:
+		len = sprintf(buf, "%u\n", APDS_CALIB_SCALER);
+		break;
+	case APDS990X_LUX_CALIB_ATTR:
+		len = sprintf(buf, "%u\n", chip->lux_calib);
+		break;
+	case APDS990X_LUX_RATE_AVAIL_ATTR:
+		for (i = 0; i < ARRAY_SIZE(arates_hz); i++)
+			len += sprintf(buf + len, "%d ", arates_hz[i]);
+		len = sprintf(buf + len - 1, "\n");
+		break;
+	case APDS990X_LUX_RATE_ATTR:
+		len = sprintf(buf, "%d\n", chip->arate);
+		break;
+	case APDS990X_LUX_THRESH_ABOVE_ATTR:
+		len = sprintf(buf, "%d\n", chip->lux_thres_hi);
+		break;
+	case APDS990X_LUX_THRESH_BELOW_ATTR:
+		len = sprintf(buf, "%d\n", chip->lux_thres_lo);
+		break;
+	case APDS990X_PROX_SENSOR_RANGE_ATTR:
+		len = sprintf(buf, "%u\n", APDS_PROX_RANGE);
+		break;
+	case APDS990X_PROX_THRESH_ABOVE_VALUE_ATTR:
+		len = sprintf(buf, "%d\n", chip->prox_thres);
+		break;
+	case APDS990X_PROX_REPORTING_MODE_ATTR:
+		len = sprintf(buf, "%s\n",
+			      reporting_modes[!!chip->prox_continuous_mode]);
+		break;
+	case APDS990X_PROX_REPORTING_MODE_AVAIL_ATTR:
+		len = sprintf(buf, "%s %s\n",
+			      reporting_modes[0], reporting_modes[1]);
+		break;
+	case APDS990X_CHIP_ID_ATTR:
+		len = sprintf(buf, "%s %d\n", chip->chipname, chip->revision);
+		break;
+	default:
+		return -EINVAL;
+	}
 
+	mutex_unlock(&indio_dev->mlock);
 	return len;
 }
 
-static DEVICE_ATTR(lux0_calibscale, S_IRUGO | S_IWUSR, apds990x_lux_calib_show,
-		apds990x_lux_calib_store);
-
-static ssize_t apds990x_rate_avail(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	int i;
-	int pos = 0;
-
-	for (i = 0; i < ARRAY_SIZE(arates_hz); i++)
-		pos += sprintf(buf + pos, "%d ", arates_hz[i]);
-	sprintf(buf + pos - 1, "\n");
-	return pos;
-}
-
-static ssize_t apds990x_rate_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", chip->arate);
-}
-
 static int apds990x_set_arate(struct apds990x_chip *chip, int rate)
 {
 	int i;
@@ -740,154 +716,8 @@ static int apds990x_set_arate(struct apds990x_chip *chip, int rate)
 			(chip->prox_persistence << APDS990X_PPERS_SHIFT));
 }
 
-static ssize_t apds990x_rate_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-	unsigned long value;
-	int ret;
-
-	ret = kstrtoul(buf, 0, &value);
-	if (ret)
-		return ret;
-
-	mutex_lock(&chip->mutex);
-	ret = apds990x_set_arate(chip, value);
-	mutex_unlock(&chip->mutex);
-
-	if (ret < 0)
-		return ret;
-	return len;
-}
-
-static DEVICE_ATTR(lux0_rate_avail, S_IRUGO, apds990x_rate_avail, NULL);
-
-static DEVICE_ATTR(lux0_rate, S_IRUGO | S_IWUSR, apds990x_rate_show,
-						 apds990x_rate_store);
-
-static ssize_t apds990x_prox_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	ssize_t ret;
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-
-	if (pm_runtime_suspended(dev) || !chip->prox_en)
-		return -EIO;
-
-	mutex_lock(&chip->mutex);
-	ret = sprintf(buf, "%d\n", chip->prox_data);
-	mutex_unlock(&chip->mutex);
-	return ret;
-}
-
-static DEVICE_ATTR(prox0_raw, S_IRUGO, apds990x_prox_show, NULL);
-
-static ssize_t apds990x_prox_range_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%u\n", APDS_PROX_RANGE);
-}
-
-static DEVICE_ATTR(prox0_sensor_range, S_IRUGO, apds990x_prox_range_show, NULL);
-
-static ssize_t apds990x_prox_enable_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", chip->prox_en);
-}
-
-static ssize_t apds990x_prox_enable_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-	unsigned long value;
-	int ret;
-
-	ret = kstrtoul(buf, 0, &value);
-	if (ret)
-		return ret;
-
-	mutex_lock(&chip->mutex);
-
-	if (!chip->prox_en)
-		chip->prox_data = 0;
-
-	if (value)
-		chip->prox_en++;
-	else if (chip->prox_en > 0)
-		chip->prox_en--;
-
-	if (!pm_runtime_suspended(dev))
-		apds990x_mode_on(chip);
-	mutex_unlock(&chip->mutex);
-	return len;
-}
-
-static DEVICE_ATTR(prox0_raw_en, S_IRUGO | S_IWUSR, apds990x_prox_enable_show,
-						   apds990x_prox_enable_store);
-
-static const char *reporting_modes[] = {"trigger", "periodic"};
-
-static ssize_t apds990x_prox_reporting_mode_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n",
-		reporting_modes[!!chip->prox_continuous_mode]);
-}
-
-static ssize_t apds990x_prox_reporting_mode_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-	int ret;
-
-	ret = sysfs_match_string(reporting_modes, buf);
-	if (ret < 0)
-		return ret;
-
-	chip->prox_continuous_mode = ret;
-	return len;
-}
-
-static DEVICE_ATTR(prox0_reporting_mode, S_IRUGO | S_IWUSR,
-		apds990x_prox_reporting_mode_show,
-		apds990x_prox_reporting_mode_store);
-
-static ssize_t apds990x_prox_reporting_avail_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%s %s\n", reporting_modes[0], reporting_modes[1]);
-}
-
-static DEVICE_ATTR(prox0_reporting_mode_avail, S_IRUGO | S_IWUSR,
-		apds990x_prox_reporting_avail_show, NULL);
-
-
-static ssize_t apds990x_lux_thresh_above_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", chip->lux_thres_hi);
-}
-
-static ssize_t apds990x_lux_thresh_below_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", chip->lux_thres_lo);
-}
-
-static ssize_t apds990x_set_lux_thresh(struct apds990x_chip *chip, u32 *target,
-				const char *buf)
+static int apds990x_set_lux_thresh(struct apds990x_chip *chip, u32 *target,
+				   const char *buf)
 {
 	unsigned long thresh;
 	int ret;
@@ -908,98 +738,165 @@ static ssize_t apds990x_set_lux_thresh(struct apds990x_chip *chip, u32 *target,
 	if (!chip->lux_wait_fresh_res)
 		apds990x_refresh_athres(chip);
 	mutex_unlock(&chip->mutex);
-	return ret;
 
+	return ret;
 }
 
-static ssize_t apds990x_lux_thresh_above_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
+static ssize_t apds990x_lux_prox_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
 {
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-	int ret = apds990x_set_lux_thresh(chip, &chip->lux_thres_hi, buf);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds990x_chip *chip = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned long value;
+	int ret;
 
-	if (ret < 0)
+	ret = kstrtoul(buf, 0, &value);
+	if (ret)
 		return ret;
-	return len;
-}
 
-static ssize_t apds990x_lux_thresh_below_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-	int ret = apds990x_set_lux_thresh(chip, &chip->lux_thres_lo, buf);
-
-	if (ret < 0)
-		return ret;
-	return len;
-}
+	mutex_lock(&indio_dev->mlock);
+	switch ((u32)this_attr->address) {
+	case APDS990X_LUX_CALIB_ATTR:
+		chip->lux_calib = value;
+		break;
+	case APDS990X_LUX_RATE_ATTR:
+		mutex_lock(&chip->mutex);
+		ret = apds990x_set_arate(chip, value);
+		mutex_unlock(&chip->mutex);
 
-static DEVICE_ATTR(lux0_thresh_above_value, S_IRUGO | S_IWUSR,
-		apds990x_lux_thresh_above_show,
-		apds990x_lux_thresh_above_store);
+		if (ret < 0)
+			return ret;
+		break;
+	case APDS990X_LUX_THRESH_ABOVE_ATTR:
+		ret = apds990x_set_lux_thresh(chip,
+					      &chip->lux_thres_hi, buf);
 
-static DEVICE_ATTR(lux0_thresh_below_value, S_IRUGO | S_IWUSR,
-		apds990x_lux_thresh_below_show,
-		apds990x_lux_thresh_below_store);
+		if (ret < 0)
+			return ret;
+		break;
+	case APDS990X_LUX_THRESH_BELOW_ATTR:
+		ret = apds990x_set_lux_thresh(chip,
+					      &chip->lux_thres_lo, buf);
 
-static ssize_t apds990x_prox_threshold_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
+		if (ret < 0)
+			return ret;
+		break;
+	case APDS990X_PROX_THRESH_ABOVE_VALUE_ATTR:
+		if (value > APDS_RANGE || value == 0 ||
+		    value < APDS_PROX_HYSTERESIS)
+			return -EINVAL;
 
-	return sprintf(buf, "%d\n", chip->prox_thres);
-}
+		mutex_lock(&chip->mutex);
 
-static ssize_t apds990x_prox_threshold_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-	unsigned long value;
-	int ret;
+		chip->prox_thres = value;
+		apds990x_force_p_refresh(chip);
 
-	ret = kstrtoul(buf, 0, &value);
-	if (ret)
-		return ret;
+		mutex_unlock(&chip->mutex);
+		break;
+	case APDS990X_PROX_REPORTING_MODE_ATTR:
+		ret = sysfs_match_string(reporting_modes, buf);
+		if (ret < 0)
+			return ret;
 
-	if ((value > APDS_RANGE) || (value == 0) ||
-		(value < APDS_PROX_HYSTERESIS))
+		chip->prox_continuous_mode = ret;
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	mutex_lock(&chip->mutex);
-	chip->prox_thres = value;
-
-	apds990x_force_p_refresh(chip);
-	mutex_unlock(&chip->mutex);
+	mutex_unlock(&indio_dev->mlock);
 	return len;
 }
 
-static DEVICE_ATTR(prox0_thresh_above_value, S_IRUGO | S_IWUSR,
-		apds990x_prox_threshold_show,
-		apds990x_prox_threshold_store);
+/* ALS ATTRIBUTES */
+static IIO_DEVICE_ATTR(in_illuminance_range, 0444,
+			apds990x_lux_prox_show,
+			NULL,
+			APDS990X_LUX_RANGE_ATTR);
+
+static IIO_DEVICE_ATTR(in_illuminance_calib_format, 0444,
+			apds990x_lux_prox_show,
+			NULL,
+			APDS990X_LUX_CALIB_FORMAT_ATTR);
+
+static IIO_DEVICE_ATTR(in_illuminance_calibscale, 0644,
+			apds990x_lux_prox_show,
+			apds990x_lux_prox_store,
+			APDS990X_LUX_CALIB_ATTR);
+
+static IIO_DEVICE_ATTR(in_illuminance_rate_avail, 0444,
+			apds990x_lux_prox_show,
+			NULL,
+			APDS990X_LUX_RATE_AVAIL_ATTR);
+
+static IIO_DEVICE_ATTR(in_illuminance_rate, 0644,
+			apds990x_lux_prox_show,
+			apds990x_lux_prox_store,
+			APDS990X_LUX_RATE_ATTR);
+
+static IIO_DEVICE_ATTR(in_illuminance_thresh_above_value, 0644,
+			apds990x_lux_prox_show,
+			apds990x_lux_prox_store,
+			APDS990X_LUX_THRESH_ABOVE_ATTR);
+
+static IIO_DEVICE_ATTR(in_illuminance_thresh_below_value, 0644,
+			apds990x_lux_prox_show,
+			apds990x_lux_prox_store,
+			APDS990X_LUX_THRESH_BELOW_ATTR);
+
+/* PROX ATTRIBUTES */
+static IIO_DEVICE_ATTR(in_proximity_sensor_range, 0444,
+			apds990x_lux_prox_show,
+			NULL,
+			APDS990X_PROX_SENSOR_RANGE_ATTR);
+
+static IIO_DEVICE_ATTR(in_proximity_reporting_mode, 0644,
+			apds990x_lux_prox_show,
+			apds990x_lux_prox_store,
+			APDS990X_PROX_REPORTING_MODE_ATTR);
+
+static IIO_DEVICE_ATTR(in_proximity_reporting_mode_avail, 0644,
+			apds990x_lux_prox_show,
+			NULL,
+			APDS990X_PROX_REPORTING_MODE_AVAIL_ATTR);
+
+static IIO_DEVICE_ATTR(in_proximity_thresh_above_value, 0644,
+			apds990x_lux_prox_show,
+			apds990x_lux_prox_store,
+			APDS990X_PROX_THRESH_ABOVE_VALUE_ATTR);
+
+static IIO_DEVICE_ATTR(chip_id, 0444,
+			apds990x_lux_prox_show,
+			NULL,
+			APDS990X_CHIP_ID_ATTR);
+
+static struct attribute *apds990x_attributes[] = {
+	&iio_dev_attr_in_illuminance_calib_format.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_range.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_calibscale.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_rate.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_rate_avail.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_thresh_above_value.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_thresh_below_value.dev_attr.attr,
+	&iio_dev_attr_in_proximity_sensor_range.dev_attr.attr,
+	&iio_dev_attr_in_proximity_thresh_above_value.dev_attr.attr,
+	&iio_dev_attr_in_proximity_reporting_mode.dev_attr.attr,
+	&iio_dev_attr_in_proximity_reporting_mode_avail.dev_attr.attr,
+	&iio_dev_attr_chip_id.dev_attr.attr,
+	NULL
+};
 
-static ssize_t apds990x_power_state_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n", !pm_runtime_suspended(dev));
-	return 0;
-}
+static const struct attribute_group apds990x_attribute_group = {
+	.attrs = apds990x_attributes,
+};
 
-static ssize_t apds990x_power_state_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
+static void apds990x_power_state_switch(struct apds990x_chip *chip, bool state)
 {
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
-	unsigned long value;
-	int ret;
+	struct device *dev = &chip->client->dev;
 
-	ret = kstrtoul(buf, 0, &value);
-	if (ret)
-		return ret;
-
-	if (value) {
+	if (state) {
 		pm_runtime_get_sync(dev);
 		mutex_lock(&chip->mutex);
 		chip->lux_wait_fresh_res = true;
@@ -1010,46 +907,80 @@ static ssize_t apds990x_power_state_store(struct device *dev,
 		if (!pm_runtime_suspended(dev))
 			pm_runtime_put(dev);
 	}
-	return len;
 }
 
-static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
-		apds990x_power_state_show,
-		apds990x_power_state_store);
-
-static ssize_t apds990x_chip_id_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static int apds990x_lux_raw(struct apds990x_chip *chip)
 {
-	struct apds990x_chip *chip =  dev_get_drvdata(dev);
+	struct device *dev = &chip->client->dev;
+	int ret;
+	long timeout;
+
+	if (pm_runtime_suspended(dev))
+		return -EIO;
+
+	timeout = wait_event_interruptible_timeout(chip->wait,
+						   !chip->lux_wait_fresh_res,
+						   msecs_to_jiffies(APDS_TIMEOUT));
+	if (!timeout)
+		return -EIO;
+
+	mutex_lock(&chip->mutex);
+
+	ret = (chip->lux * chip->lux_calib) / APDS_CALIB_SCALER;
+	if (ret > (APDS_RANGE * APDS990X_LUX_OUTPUT_SCALE))
+		ret = APDS_RANGE * APDS990X_LUX_OUTPUT_SCALE;
 
-	return sprintf(buf, "%s %d\n", chip->chipname, chip->revision);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
 }
 
-static DEVICE_ATTR(chip_id, S_IRUGO, apds990x_chip_id_show, NULL);
-
-static struct attribute *sysfs_attrs_ctrl[] = {
-	&dev_attr_lux0_calibscale.attr,
-	&dev_attr_lux0_calibscale_default.attr,
-	&dev_attr_lux0_input.attr,
-	&dev_attr_lux0_sensor_range.attr,
-	&dev_attr_lux0_rate.attr,
-	&dev_attr_lux0_rate_avail.attr,
-	&dev_attr_lux0_thresh_above_value.attr,
-	&dev_attr_lux0_thresh_below_value.attr,
-	&dev_attr_prox0_raw_en.attr,
-	&dev_attr_prox0_raw.attr,
-	&dev_attr_prox0_sensor_range.attr,
-	&dev_attr_prox0_thresh_above_value.attr,
-	&dev_attr_prox0_reporting_mode.attr,
-	&dev_attr_prox0_reporting_mode_avail.attr,
-	&dev_attr_chip_id.attr,
-	&dev_attr_power_state.attr,
-	NULL
-};
+static int apds990x_prox_raw(struct apds990x_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	long timeout;
+	u16 clr_ch;
 
-static const struct attribute_group apds990x_attribute_group[] = {
-	{ .attrs = sysfs_attrs_ctrl },
-};
+	if (!chip->prox_en) {
+		chip->prox_data = 0;
+		return chip->prox_data;
+	}
+
+	if (pm_runtime_suspended(dev))
+		return -EIO;
+
+	timeout = wait_event_interruptible_timeout(chip->wait,
+						   !chip->lux_wait_fresh_res,
+						   msecs_to_jiffies(APDS_TIMEOUT));
+	if (!timeout)
+		return -EIO;
+
+	mutex_lock(&chip->mutex);
+
+	apds990x_read_word(chip, APDS990X_CDATAL, &clr_ch);
+	/*
+	 * If ALS channel is saturated at min gain,
+	 * proximity gives false posivite values.
+	 * Just ignore them.
+	 */
+	if (chip->again_meas == 0 &&
+	    clr_ch == chip->a_max_result)
+		chip->prox_data = 0;
+	else
+		apds990x_read_word(chip,
+				   APDS990X_PDATAL,
+				   &chip->prox_data);
+
+	apds990x_refresh_pthres(chip, chip->prox_data);
+	if (chip->prox_data < chip->prox_thres)
+		chip->prox_data = 0;
+	else if (!chip->prox_continuous_mode)
+		chip->prox_data = 1;
+
+	mutex_unlock(&chip->mutex);
+
+	return chip->prox_data;
+}
 
 static int apds990x_of_probe(struct i2c_client *client,
 			     struct apds990x_chip *chip)
@@ -1080,15 +1011,114 @@ static int apds990x_of_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int apds990x_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct apds990x_chip *chip = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		apds990x_power_state_switch(chip, true);
+
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*val = apds990x_lux_raw(chip);
+			break;
+		case IIO_PROXIMITY:
+			*val = apds990x_prox_raw(chip);
+			break;
+		default:
+			break;
+		}
+
+		apds990x_power_state_switch(chip, false);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+		case IIO_PROXIMITY:
+		default:
+			*val = 1;
+			break;
+		}
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_ENABLE:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*val = chip->prox_en;
+		default:
+			break;
+		}
+
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static int apds990x_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct apds990x_chip *chip = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			mutex_lock(&chip->mutex);
+			chip->prox_en = val;
+			mutex_unlock(&chip->mutex);
+		default:
+			break;
+		}
+
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec apds990x_channels[] = {
+	{
+		.type	= IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type	= IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_ENABLE),
+	},
+};
+
+static const struct iio_info apds990x_info = {
+	.attrs		= &apds990x_attribute_group,
+	.read_raw	= apds990x_read_raw,
+	.write_raw	= apds990x_write_raw,
+};
+
 static int apds990x_probe(struct i2c_client *client)
 {
 	struct apds990x_chip *chip;
+	struct iio_dev *indio_dev;
 	int err;
 
-	chip = kzalloc(sizeof *chip, GFP_KERNEL);
-	if (!chip)
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
 		return -ENOMEM;
 
+	indio_dev->info = &apds990x_info;
+	indio_dev->name = "apds990x";
+	indio_dev->channels = apds990x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(apds990x_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	chip = iio_priv(indio_dev);
 	i2c_set_clientdata(client, chip);
 	chip->client  = client;
 
@@ -1140,17 +1170,17 @@ static int apds990x_probe(struct i2c_client *client)
 	chip->regs[0].supply = reg_vcc;
 	chip->regs[1].supply = reg_vled;
 
-	err = regulator_bulk_get(&client->dev,
-				 ARRAY_SIZE(chip->regs), chip->regs);
+	err = devm_regulator_bulk_get(&client->dev,
+				      ARRAY_SIZE(chip->regs), chip->regs);
 	if (err < 0) {
 		dev_err(&client->dev, "Cannot get regulators\n");
-		goto fail1;
+		return err;
 	}
 
 	err = regulator_bulk_enable(ARRAY_SIZE(chip->regs), chip->regs);
 	if (err < 0) {
 		dev_err(&client->dev, "Cannot enable regulators\n");
-		goto fail2;
+		return err;
 	}
 
 	usleep_range(APDS_STARTUP_DELAY, 2 * APDS_STARTUP_DELAY);
@@ -1158,7 +1188,7 @@ static int apds990x_probe(struct i2c_client *client)
 	err = apds990x_detect(chip);
 	if (err < 0) {
 		dev_err(&client->dev, "APDS990X not found\n");
-		goto fail3;
+		return err;
 	}
 
 	pm_runtime_set_active(&client->dev);
@@ -1173,39 +1203,29 @@ static int apds990x_probe(struct i2c_client *client)
 		err = chip->pdata->setup_resources();
 		if (err) {
 			err = -EINVAL;
-			goto fail3;
+			goto fail;
 		}
 	}
 
-	err = sysfs_create_group(&chip->client->dev.kobj,
-				apds990x_attribute_group);
-	if (err < 0) {
-		dev_err(&chip->client->dev, "Sysfs registration failed\n");
-		goto fail4;
-	}
-
-	err = request_threaded_irq(client->irq, NULL,
-				apds990x_irq,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				"apds990x", chip);
+	err = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, apds990x_irq,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"apds990x", indio_dev);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n",
 			client->irq);
-		goto fail5;
+		goto fail;
 	}
-	return err;
-fail5:
-	sysfs_remove_group(&chip->client->dev.kobj,
-			&apds990x_attribute_group[0]);
-fail4:
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto fail;
+
+	return 0;
+fail:
 	if (chip->pdata && chip->pdata->release_resources)
 		chip->pdata->release_resources();
-fail3:
-	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
-fail2:
-	regulator_bulk_free(ARRAY_SIZE(chip->regs), chip->regs);
-fail1:
-	kfree(chip);
+
 	return err;
 }
 
@@ -1213,10 +1233,6 @@ static void apds990x_remove(struct i2c_client *client)
 {
 	struct apds990x_chip *chip = i2c_get_clientdata(client);
 
-	free_irq(client->irq, chip);
-	sysfs_remove_group(&chip->client->dev.kobj,
-			apds990x_attribute_group);
-
 	if (chip->pdata && chip->pdata->release_resources)
 		chip->pdata->release_resources();
 
@@ -1225,10 +1241,6 @@ static void apds990x_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-
-	regulator_bulk_free(ARRAY_SIZE(chip->regs), chip->regs);
-
-	kfree(chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.37.2

