Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A412655DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiLYRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLYRBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 12:01:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923F2675;
        Sun, 25 Dec 2022 09:01:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso6489533wmo.1;
        Sun, 25 Dec 2022 09:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cba7a4CNg3T6ktAC4rnAyxADOxp4yPgdrX7lNI9dXpg=;
        b=H0Aj/Vinm/zwqMAF2JdMoqdNwUcHXNSZjxw25hpLmoeQGxLZI7rhyg8fk0QBLTcJYY
         mhF6/2ucKw07Yr2DZfM/rhjEMG5/43flkqnOFoERH2L96XanqNyYJKepIbnkeaD3Ka7w
         SubIsAasXZO5nNE1TplUqh1R3/ESoKEjY5AQHJAvM1wDD5HwkMK7NcYLPO7p4MeJUvkh
         owE1G92lGsAMkFtAdTB63cc9dh9y5xlVzoaCtZk8WycsKUGODr1cvElxx3BX31vQkI6q
         lBT4InUeoVf4s+fXggMZaDHCanExMhRcx1fvLgmrsmLG9iKRb8v79wxlBSCy7qXu5cjb
         tWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cba7a4CNg3T6ktAC4rnAyxADOxp4yPgdrX7lNI9dXpg=;
        b=nnr4PlGcu1w6ll0EUz3rQCV2AdOpdUsKDj6FqFhT+f8seQJK0BraJWasrLujvYAKsM
         T1TNHx2qMhwxU7OyCoAmORigkExn6KHVkuHIxoVONDwVZTXI92lJzsmLkzI0Agl05/VM
         uIt0WsI/06AN00xqn/iBTpUG7a2JyW3Smi3pgZggcXF6PknsLQ8CVkECuYbJANAUcyLL
         L5UaNqh676/nLnVzgWSJd3yknHAuQFSZYSvTNcxcSVZ2HerV2QRJWD82T9UcF7PnEAwG
         1IoYE6EzJDYDNRK9GkLWqlgYGrMJxyWLNoyHIYh7ZKeTa9KBI3h4AxeS+0zeQ+Aqjvcf
         srEg==
X-Gm-Message-State: AFqh2kpv4+FD3/8my4Y2HtytgyJwaVyvroxxO7dwjQ3noacBdzh5LRiI
        iAtwdHTe/Ekdl608A0HUdIWNVoF2aP0=
X-Google-Smtp-Source: AMrXdXsQlRHT5tu3MNUAE/vWmOJHVJFZx1mw+qmYgPECdDHia48mL8hq6+j4kxauC+pBVCx5LIUrwg==
X-Received: by 2002:a05:600c:5008:b0:3cf:6f4d:c25d with SMTP id n8-20020a05600c500800b003cf6f4dc25dmr11618497wmr.21.1671987687086;
        Sun, 25 Dec 2022 09:01:27 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b003d974076f13sm5812308wms.3.2022.12.25.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 09:01:26 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iio: pressure: bmp280: Add nvmem operations for BMP580
Date:   Sun, 25 Dec 2022 18:00:53 +0100
Message-Id: <b902ef9ee60a6dd05f002916853ba23826eccf9a.1671986815.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671986815.git.ang.iglesiasg@gmail.com>
References: <cover.1671986815.git.ang.iglesiasg@gmail.com>
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
index 005dbaf18607..4e0d89a71eab 100644
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
@@ -1628,8 +1629,140 @@ static const int bmp580_odr_table[][2] = {
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
+		return ret;
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
+		ret = bmp580_cmd(data, BMP580_NVM_READ_CMD);
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
+		return ret;
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
+		ret = bmp580_cmd(data, BMP580_NVM_WRITE_CMD);
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
 
@@ -1653,8 +1786,8 @@ static int bmp580_preinit(struct bmp280_data *data)
 		dev_err(data->dev, "preinit: nvm error on powerup sequence\n");
 		return ret;
 	}
-
-	return 0;
+	/* Register nvmem device */
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
 }
 
 static int bmp580_chip_config(struct bmp280_data *data)
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 27d2abc17d01..e2a093a4f767 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -101,6 +101,9 @@
 #define BMP580_FILTER_63X		6
 #define BMP580_FILTER_127X		7
 
+#define BMP580_NVM_ROW_ADDR_MASK	GENMASK(5, 0)
+#define BMP580_NVM_PROG_EN		BIT(6)
+
 #define BMP580_TEMP_SKIPPED		0x7f7f7f
 #define BMP580_PRESS_SKIPPED		0x7f7f7f
 
-- 
2.39.0

