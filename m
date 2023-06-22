Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5273A30C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFVO3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjFVO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:29:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BFF1BCA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f90b4ac529so59034505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687444148; x=1690036148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ybjd+QrBvVu0zDRNg4Z7l4eXFNbVwdU/ccLoGQD+UU=;
        b=zRJ1qwcVn3ztbIPDeEsb4lMJvpAOSPLFJyfNerTrP0KV/1vVyt8Xe2pQJcqDY0puNk
         ktg0UyGg9iuE80CcksBWjdFXrD0rtzer+PRbKZXqENlKureUpHx/rApRqUoBCjOhoTTg
         ux5NPRk8jNTL1mIbT1NM7iN9gTfaaF62J9kvTNMB39dUmklRRAluSOvMKVrRwsLvj7N1
         Wt5r7+UvrEc7drWOCpNg8r+MCZpaMDh4bdCMqOgbalQbf89iz9Z+PQr4WBpaCY1zG1p2
         wO74vXY6yMoIGMRoSO3ZIF9T6/nNQOu/9ojW8DL+lsesf+yXFtypI+HPEKoezSrvNrEN
         KvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444148; x=1690036148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ybjd+QrBvVu0zDRNg4Z7l4eXFNbVwdU/ccLoGQD+UU=;
        b=AlDTUE0WzsqIgV+q26HREBZcxXimMx4MYdBWuhE5hNhndKFQZC3yZFRMrR6+x9idJ8
         iJM12Lvf33bBNSZyJMdHS78G/lrqVle4uBuQa5mQRw5UHKwKs29osZMuuDW4EYwY7JyS
         ZfWxU5VN3JOgvFwDzgdWG/8wmuqfXubxvWZciAM0zf88t0R68FBHbihYM4YYeLeR0irt
         LmZxBOrJD2HlxABkdTCRyId3QwBeK+1Lx+AeNV3TGPuzkTyToF4Cr5zJrWseWOEgnr/i
         RHSIXXPxu/0EUMyv4AlFbf1kNGlF+cR9N4yLV9D0/4v5TFreD16cIGGG6GSZiJDiQrYi
         p14g==
X-Gm-Message-State: AC+VfDy0O1PaUYV4VRTaB33msvtKO0+1C1yy80fyFZFuzl5sb+j8VcYQ
        UiIIf4zjQ2Z9TFzMdMgCm44ayw==
X-Google-Smtp-Source: ACHHUZ7qOkQjjlEP6dMiAo75kdjrlCF1m1CVJYn5YbDPxDSh8sygEb8PM2nMBpa5xD9rko4AQD2sRg==
X-Received: by 2002:a5d:5346:0:b0:30f:cb74:35f9 with SMTP id t6-20020a5d5346000000b0030fcb7435f9mr14954445wrv.66.1687444148012;
        Thu, 22 Jun 2023 07:29:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0030ae69920c9sm7168361wru.53.2023.06.22.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:29:07 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 16:29:02 +0200
Subject: [PATCH v3 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v3-4-f0577cead709@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7579;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=M9Fcb2iZK373bguA+9fk5ubbR87iAMaN2qDGauqltKw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklFquIFj8I8Rz3YXa55zo9Uxk5Q2EVWaKYWuq59dt
 1KMCxc6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJRargAKCRB33NvayMhJ0UOBD/
 0SvXrV7M0v4joSSH/rEopz9+VmzuD5/kQJDJLMBhqyHXyd/S7XmFcujD/moyPGlY/IzW2mWILRTals
 FlQzSwIbntt8HO9oyPUDcgFR8JkN7SYZj5TenIZ5YSA9WqVRi4lxX2whDpfa5s93CqeLXqafl1hySc
 y4fd0ojIMq1q9GS5jcMLgKNDeTu7SepWSDMhrN6xundRvF17/KmKo8vAXKC0NBvEJ116yzGa+z1YQm
 7jLAogXEJhu/av4WNyD70T5hemMarvteRp5UnX3tWZ7hDjnVd0O/VChfesLOawxEFRVZT4QXtPanvc
 FpXdni7CWLJAZs0jM/W1k2Wog+n3YOaGQgRSjLBx36GunJQo2OlNt/kGqaMp3sus1X3wtit0IxyxHM
 EOy1W/i/XJUIcPGTyvXQVSAmqefXiBA4wbwN0BvMwhPrylq9YpuK7TNwLW+AWspWguqylClX6eUFIA
 nU8V8+6vf7fRFlzrJJCX108PsnA8tYgj09it26zBNVGFJth17Fp9HfCmlH6BqH9Gbiwnf+gMqDG43Y
 YcgOKgpshiw6LqDm3Z1zEhfkHslz01Jw+l2PXkmYI73V8yEf/I+75Q5DEmNzeoQItKpKN83vWjN9qi
 95j7l95LPgLsMJIlRgcsWMFeZQEM+uD1y46AwBDIC4WHanVtABtF3Pew3idg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the new Goodix "Berlin" touchscreen ICs
over the SPI interface.

The driver doesn't use the regmap_spi code since the SPI messages
needs to be prefixed, thus this custom regmap code.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig             |  13 ++
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/goodix_berlin_spi.c | 172 ++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 5e21cca6025d..2d86615e5090 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -435,6 +435,19 @@ config TOUCHSCREEN_GOODIX_BERLIN_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called goodix_berlin_i2c.
 
+config TOUCHSCREEN_GOODIX_BERLIN_SPI
+	tristate "Goodix Berlin SPI touchscreen"
+	depends on SPI_MASTER
+	select TOUCHSCREEN_GOODIX_BERLIN_CORE
+	help
+	  Say Y here if you have a Goodix Berlin IC connected to
+	  your system via SPI.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called goodix_berlin_spi.
+
 config TOUCHSCREEN_HIDEEP
 	tristate "HiDeep Touch IC"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 921a2da0c2be..29524e8a83db 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)	+= goodix_berlin_spi.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
new file mode 100644
index 000000000000..3a1bc251b32d
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_spi.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Berlin Touchscreen Driver
+ *
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <asm/unaligned.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "goodix_berlin.h"
+
+#define SPI_TRANS_PREFIX_LEN	1
+#define REGISTER_WIDTH		4
+#define SPI_READ_DUMMY_LEN	3
+#define SPI_READ_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH + SPI_READ_DUMMY_LEN)
+#define SPI_WRITE_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH)
+
+#define SPI_WRITE_FLAG		0xF0
+#define SPI_READ_FLAG		0xF1
+
+static int goodix_berlin_spi_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	struct spi_device *spi = context;
+	struct spi_transfer xfers;
+	struct spi_message spi_msg;
+	const u32 *reg = reg_buf; /* reg is stored as native u32 at start of buffer */
+	u8 *buf;
+	int ret;
+
+	if (reg_size != REGISTER_WIDTH)
+		return -EINVAL;
+
+	buf = kzalloc(SPI_READ_PREFIX_LEN + val_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spi_message_init(&spi_msg);
+	memset(&xfers, 0, sizeof(xfers));
+
+	/* buffer format: 0xF1 + addr(4bytes) + dummy(3bytes) + data */
+	buf[0] = SPI_READ_FLAG;
+	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
+	memset(buf + SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH, 0xff,
+	       SPI_READ_DUMMY_LEN);
+
+	xfers.tx_buf = buf;
+	xfers.rx_buf = buf;
+	xfers.len = SPI_READ_PREFIX_LEN + val_size;
+	xfers.cs_change = 0;
+	spi_message_add_tail(&xfers, &spi_msg);
+
+	ret = spi_sync(spi, &spi_msg);
+	if (ret < 0)
+		dev_err(&spi->dev, "transfer error:%d", ret);
+	else
+		memcpy(val_buf, buf + SPI_READ_PREFIX_LEN, val_size);
+
+	kfree(buf);
+	return ret;
+}
+
+static int goodix_berlin_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	unsigned int len = count - REGISTER_WIDTH;
+	struct spi_device *spi = context;
+	struct spi_transfer xfers;
+	struct spi_message spi_msg;
+	const u32 *reg = data; /* reg is stored as native u32 at start of buffer */
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(SPI_WRITE_PREFIX_LEN + len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spi_message_init(&spi_msg);
+	memset(&xfers, 0, sizeof(xfers));
+
+	buf[0] = SPI_WRITE_FLAG;
+	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
+	memcpy(buf + SPI_WRITE_PREFIX_LEN, data + REGISTER_WIDTH, len);
+
+	xfers.tx_buf = buf;
+	xfers.len = SPI_WRITE_PREFIX_LEN + len;
+	xfers.cs_change = 0;
+	spi_message_add_tail(&xfers, &spi_msg);
+
+	ret = spi_sync(spi, &spi_msg);
+	if (ret < 0)
+		dev_err(&spi->dev, "transfer error:%d", ret);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct regmap_config goodix_berlin_spi_regmap_conf = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.read = goodix_berlin_spi_read,
+	.write = goodix_berlin_spi_write,
+};
+
+/* vendor & product left unassigned here, should probably be updated from fw info */
+static const struct input_id goodix_berlin_spi_input_id = {
+	.bustype = BUS_SPI,
+};
+
+static int goodix_berlin_spi_probe(struct spi_device *spi)
+{
+	struct regmap_config *regmap_config;
+	struct regmap *regmap;
+	size_t max_size;
+	int error = 0;
+
+	regmap_config = devm_kmemdup(&spi->dev, &goodix_berlin_spi_regmap_conf,
+				     sizeof(*regmap_config), GFP_KERNEL);
+	if (!regmap_config)
+		return -ENOMEM;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+	error = spi_setup(spi);
+	if (error)
+		return error;
+
+	max_size = spi_max_transfer_size(spi);
+	regmap_config->max_raw_read = max_size - SPI_READ_PREFIX_LEN;
+	regmap_config->max_raw_write = max_size - SPI_WRITE_PREFIX_LEN;
+
+	regmap = devm_regmap_init(&spi->dev, NULL, spi, regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return goodix_berlin_probe(&spi->dev, spi->irq,
+				   &goodix_berlin_spi_input_id, regmap);
+}
+
+static const struct spi_device_id goodix_berlin_spi_ids[] = {
+	{ "gt9916" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, goodix_berlin_spi_ids);
+
+static const struct of_device_id goodix_berlin_spi_of_match[] = {
+	{ .compatible = "goodix,gt9916", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_berlin_spi_of_match);
+
+static struct spi_driver goodix_berlin_spi_driver = {
+	.driver = {
+		.name = "goodix-berlin-spi",
+		.of_match_table = goodix_berlin_spi_of_match,
+		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
+	},
+	.probe = goodix_berlin_spi_probe,
+	.id_table = goodix_berlin_spi_ids,
+};
+module_spi_driver(goodix_berlin_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin SPI Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1

