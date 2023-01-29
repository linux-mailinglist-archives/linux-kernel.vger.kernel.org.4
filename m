Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B167FC32
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjA2BgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjA2Bfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:35:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E0724109;
        Sat, 28 Jan 2023 17:35:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so392522wms.1;
        Sat, 28 Jan 2023 17:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7EoOIyQeLcoH6apOH/p+8qL29vfGf4A8BXO8aUOa/8=;
        b=RG7uxBvtPo8Vrp57nCfhqwOMrmgry9P8aMSO/97by2iC5Zr1J+bETTR6g36KReXqKi
         e2LJPGKby1NwhYM6ZbsuqIPXxcLfUylDXiWMImFTrtHfOkv6PkO1PtLd7l2Ec5cTbIZh
         7anYN3WZGnzdchvGCHXe0BiXS1BdJlh5PI7DhC45ZpWINi5YwtKS/D226+vaHuvUhaLZ
         iYnvw5mReh7A0R/Y9jS1A6C54min5JnmKb7rljtSCAenZ6muhGqXWKAepCFUMw1xn/Gv
         6sNS6+0o4QgqmvvlUMLxdBkfwBBwwZWtjJdEcCowUIMzrUjnGnu4++z0SzEnV8XSTPz0
         xbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7EoOIyQeLcoH6apOH/p+8qL29vfGf4A8BXO8aUOa/8=;
        b=QaRr3QuEUV0vaQPT6596oUfpdDQU0hbcZM16swZTdgs0kcklWagpx5Pj9OPBHUNRDR
         N/yGId5F7Y123OkICguNe3wGcSLJZm/SSNfe3d/OgPSjq+VUXLPZVeNzuAC/RNZ+s6An
         g/84vNN7tbeA1DTb6Hylyl33WXoxbqTpOaLtdRNwqeIEPTmvrR5KjDeg9a9zjOGIwr2o
         gmb7hqU/lguB190rKy2ON7YB0hnu4ZLlho7lc1PLCAjnAHazfjBuBeOopHGidmxnN3rB
         ZItgr6fSnihQZzEtjf/kHwuIgvJPoVjGuK5oXz8o0CH7dQdni0Isga1WnLiXvXZg6qfG
         1PSw==
X-Gm-Message-State: AFqh2kp8bJoVuSy5XTDLhHJmiD9VzTCrlPzbj25NPSG0mX+ixDjS5B7U
        EwmtaN9wGNKZnflQyPRgso6okrkqbuY=
X-Google-Smtp-Source: AMrXdXv7vZNjbfrNwFGSjOY9aFIOrYvtHPic/PBugevRUWg4bREcM01kNs/YMZotZL672gc2I5iCYg==
X-Received: by 2002:a05:600c:4e05:b0:3db:1d8:9f25 with SMTP id b5-20020a05600c4e0500b003db01d89f25mr43422801wmq.2.1674956116740;
        Sat, 28 Jan 2023 17:35:16 -0800 (PST)
Received: from localhost.localdomain (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003dc3f195abesm5197132wme.39.2023.01.28.17.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 17:35:16 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] iio: pressure: bmp280: Add nvmem operations for BMP580
Date:   Sun, 29 Jan 2023 02:33:09 +0100
Message-Id: <013686653a60092227c842ae2fd0197f2509ad7c.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674954271.git.ang.iglesiasg@gmail.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pressure sensor BMP580 contains a non-volatile memory that stores
trimming and configuration params. That memory provides an programmable
user range of three 2-byte words.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c65fb4025ad9..cc2811c9c6f4 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -28,6 +28,7 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/nvmem-provider.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -1290,6 +1291,88 @@ static int bmp580_soft_reset(struct bmp280_data *data)
 	return 0;
 }
 
+#define NVM_READ	false
+#define NVM_WRITE	true
+
+/**
+ * bmp580_nvm_operation() - Helper function to commit NVM memory operations
+ * @data: sensor data struct
+ * @is_write: flag to signal write operation
+ */
+static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
+{
+	unsigned long deadline;
+	unsigned int reg;
+	int ret;
+
+	/* Check NVM ready flag */
+	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to check nvm status\n");
+		return ret;
+	}
+	if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {
+		dev_err(data->dev, "sensor's nvm is not ready\n");
+		return -EIO;
+	}
+
+	/* Send NVM operation sequence */
+	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SEQ_0);
+	if (ret) {
+		dev_err(data->dev, "failed to send nvm operation's first sequence\n");
+		return ret;
+	}
+	if (is_write) {
+		/* Send NVM write sequence */
+		ret = regmap_write(data->regmap, BMP580_REG_CMD,
+				   BMP580_CMD_NVM_WRITE_SEQ_1);
+		if (ret) {
+			dev_err(data->dev, "failed to send nvm write sequence\n");
+			return ret;
+		}
+		/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
+		usleep_range(10000, 10500);
+		deadline = jiffies + msecs_to_jiffies(10);
+	} else {
+		/* Send NVM read sequence */
+		ret = regmap_write(data->regmap, BMP580_REG_CMD,
+				   BMP580_CMD_NVM_READ_SEQ_1);
+		if (ret) {
+			dev_err(data->dev, "failed to send nvm read sequence\n");
+			return ret;
+		}
+		/* Datasheet says on 4.8.1.1 it takes approximately 200us */
+		usleep_range(200, 250);
+		deadline = jiffies + usecs_to_jiffies(200);
+	}
+	if (ret) {
+		dev_err(data->dev, "failed to write command sequence\n");
+		return -EIO;
+	}
+
+	/* Wait until NVM is ready again */
+	do {
+		ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
+		if (ret) {
+			dev_err(data->dev, "failed to check nvm status\n");
+			reg &= ~BMP580_STATUS_NVM_RDY_MASK;
+		}
+	} while (time_before(jiffies, deadline) && !(reg & BMP580_STATUS_NVM_RDY_MASK));
+	if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {
+		dev_err(data->dev,
+			"reached timeout waiting for nvm operation completion\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Check NVM error flags */
+	if ((reg & BMP580_STATUS_NVM_ERR_MASK) || (reg & BMP580_STATUS_NVM_CMD_ERR_MASK)) {
+		dev_err(data->dev, "error processing nvm operation\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * Contrary to previous sensors families, compensation algorithm is builtin.
  * We are only required to read the register raw data and adapt the ranges
@@ -1384,8 +1467,140 @@ static const int bmp580_odr_table[][2] = {
 	[BMP580_ODR_0_125HZ] =	{0, 125000},
 };
 
+const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
+
+static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct bmp280_data *data = priv;
+	u16 *dst = val;
+	int ret, addr;
+
+	pm_runtime_get_sync(data->dev);
+	mutex_lock(&data->lock);
+
+	/* Set sensor in standby mode */
+	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
+				 BMP580_ODR_DEEPSLEEP_DIS |
+				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
+	if (ret) {
+		dev_err(data->dev, "failed to change sensor to standby mode\n");
+		goto exit;
+	}
+	/* Wait standby transition time */
+	usleep_range(2500, 3000);
+
+	while (bytes >= sizeof(u16)) {
+		addr = bmp580_nvmem_addrs[offset / sizeof(u16)];
+
+		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
+				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
+		if (ret) {
+			dev_err(data->dev, "error writing nvm address\n");
+			goto exit;
+		}
+
+		ret = bmp580_nvm_operation(data, NVM_READ);
+		if (ret)
+			goto exit;
+
+		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
+				       sizeof(data->le16));
+		if (ret) {
+			dev_err(data->dev, "error reading nvm data regs\n");
+			goto exit;
+		}
+
+		*dst++ = le16_to_cpu(data->le16);
+		bytes -= sizeof(u16);
+		offset += sizeof(u16);
+	}
+exit:
+	/* Restore chip config */
+	data->chip_info->chip_config(data);
+	mutex_unlock(&data->lock);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
+static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct bmp280_data *data = priv;
+	u16 *buf = val;
+	int ret, addr;
+
+	pm_runtime_get_sync(data->dev);
+	mutex_lock(&data->lock);
+
+	/* Set sensor in standby mode */
+	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
+				 BMP580_ODR_DEEPSLEEP_DIS |
+				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
+	if (ret) {
+		dev_err(data->dev, "failed to change sensor to standby mode\n");
+		goto exit;
+	}
+	/* Wait standby transition time */
+	usleep_range(2500, 3000);
+
+	while (bytes >= sizeof(u16)) {
+		addr = bmp580_nvmem_addrs[offset / sizeof(u16)];
+
+		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PROG_EN |
+				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
+		if (ret) {
+			dev_err(data->dev, "error writing nvm address\n");
+			goto exit;
+		}
+		data->le16 = cpu_to_le16(*buf++);
+
+		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
+					sizeof(data->le16));
+		if (ret) {
+			dev_err(data->dev, "error writing LSB NVM data regs\n");
+			goto exit;
+		}
+
+		ret = bmp580_nvm_operation(data, NVM_WRITE);
+		if (ret)
+			goto exit;
+
+		/* Disable programming mode bit */
+		ret = regmap_update_bits(data->regmap, BMP580_REG_NVM_ADDR,
+					 BMP580_NVM_PROG_EN, 0);
+		if (ret) {
+			dev_err(data->dev, "error resetting nvm write\n");
+			goto exit;
+		}
+
+		bytes -= sizeof(u16);
+		offset += sizeof(u16);
+	}
+exit:
+	/* Restore chip config */
+	data->chip_info->chip_config(data);
+	mutex_unlock(&data->lock);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
 static int bmp580_preinit(struct bmp280_data *data)
 {
+	struct nvmem_config config = {
+		.dev = data->dev,
+		.priv = data,
+		.name = "bmp580_nvmem",
+		.word_size = sizeof(u16),
+		.stride = sizeof(u16),
+		.size = 3 * sizeof(u16),
+		.reg_read = bmp580_nvmem_read,
+		.reg_write = bmp580_nvmem_write,
+	};
 	unsigned int reg;
 	int ret;
 
@@ -1413,7 +1628,8 @@ static int bmp580_preinit(struct bmp280_data *data)
 		return -EIO;
 	}
 
-	return 0;
+	/* Register nvmem device */
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
 }
 
 static int bmp580_chip_config(struct bmp280_data *data)
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index f29d44b09efc..1c942b3dc384 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -104,6 +104,9 @@
 #define BMP580_FILTER_63X		6
 #define BMP580_FILTER_127X		7
 
+#define BMP580_NVM_ROW_ADDR_MASK	GENMASK(5, 0)
+#define BMP580_NVM_PROG_EN		BIT(6)
+
 #define BMP580_TEMP_SKIPPED		0x7f7f7f
 #define BMP580_PRESS_SKIPPED		0x7f7f7f
 
-- 
2.39.1

