Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80465636F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiLZOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiLZOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:33:06 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE4663A1;
        Mon, 26 Dec 2022 06:33:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso5213624wmb.3;
        Mon, 26 Dec 2022 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYNAweZ1AcDlKrjIzBiejJuOGZWpzppFV/wft0OI8ho=;
        b=o3J958Lu6aSZsc+6r3mYM2RsgrS5K+m/YBbCcmTXGvMTF/pzPcd4uznaW0qdQlAMiZ
         HWKF9GGUd9QZ/Xy5iK/tIMhNJw5tejeR+ID6qqKY0+dtS+K4qAmPctCQC8j/HCtXo0Tn
         fH2HTo7/orf8l6D1t7Rm28t+fnLyXelPrw9bsIVs1V5c77bhkkjGNNZQgDO7NGvUUnQ9
         laKOTiFFS7BKoOrUVyH2iRe4sTy4MYSdJaxv1R+WBum3xqS5Fjm1PM1+YXcB6/rPTih4
         sAL/HsymxTSeDw3b4aKCnhs9r9YLr21YJOb/nEf/PRi7JLrjUzjS19JdQXIKMBzI/AQi
         A2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYNAweZ1AcDlKrjIzBiejJuOGZWpzppFV/wft0OI8ho=;
        b=L3JyaXJ18TuRvFUmp6U0rfDlEiSgLfHnAT+kHN1FNUmJNtPXtAbqspS0uH+fq15azH
         or3BJhik5TGC9rc/gn4I0hb6IJwPCwREa3Sn0LB44zfBzzsSUR8EetqgCuDJ1OzPib1z
         UglxRUUyo3ySgzdHmUR8PmdgKL7oqbU3c6stELDh9jSYR9QpPAJnjLVsU+xc56FgYicm
         aVf/ixH+Lz7xgXXz2Rwf/spvOwNHudwDKteZbTutn/kgU6BExgNP2SLLSuDIcFQEkcc4
         6uKsrpMw4P1HTg81FU4LqcY6sGfIIs3SStJuXGtbpGOnsedWYrnw7qDN8j1Uv1uqE7Km
         11SQ==
X-Gm-Message-State: AFqh2krOzIGAqqeOOEl3uqGq7bzc1nLWlPxLDVRkXsXretDbCFaY9E21
        0axi54rHdkVRiaf5qE1Y5g7yvlW9578=
X-Google-Smtp-Source: AMrXdXtsCMXh/CoWQCfZ6EuQvD71zX0Zljc1n+nF7nCN0pMw4i/kJmqDLisL9Ihd1Y14tFPAEwA51w==
X-Received: by 2002:a05:600c:17c6:b0:3d2:20ec:24be with SMTP id y6-20020a05600c17c600b003d220ec24bemr13482551wmo.38.1672065178495;
        Mon, 26 Dec 2022 06:32:58 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf75213bb9sm21511754wmq.8.2022.12.26.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 06:32:58 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] iio: pressure: bmp280: Add nvmem operations for BMP580
Date:   Mon, 26 Dec 2022 15:29:24 +0100
Message-Id: <92664164d24cbd9c6541cdbd73b163dbf964ab68.1672062380.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
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
index 44901c6eb2f9..578d145be55d 100644
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
 		return -EIO;
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

