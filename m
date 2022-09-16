Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754675BAD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiIPMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiIPMVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CEBB0895
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so19767094wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=eUrOtgvMOI3YSlt0vLBZkNkf8tRkFJKEhErIeIBYZk4=;
        b=LxTksKpHKaGM2j6YYlDz4lXBhDTmfQdNoF/bsTDC/GZyGcUZTJfz8iErtsebSEaPLF
         5vGpmtfFKRq60ENVXY4gOwg9eMrhtv3oXHzPckxFV1P36HKGdOXa6/xRggFQywWipmYX
         yqIIb5iznVkkgfCLRbdOw0+qE6uV36AQiWOoNgcQqLt4Ly462BdjFh3fTl2OFOtJjVEl
         zNmmKEsclSjsU/0vX5U9tD2lpH3m7VRPWbYQKlFgCbcMOCcnODqn+0btjemM1P+JOW2p
         j3Kmh1cND8678ujD39daa9+U2H8RMHIXYSuKbuTtGmU2N6UydM5FrP5Q9QwSaskTyg3M
         R60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eUrOtgvMOI3YSlt0vLBZkNkf8tRkFJKEhErIeIBYZk4=;
        b=zZ/0xDadyxpcC9Kknwvtr0K5hgtOwYygSmTcelvVZr0wiS6A6zqwzh6nZ8rDcXyvxQ
         +KXzgAc7jieQoY56StfHtK52gSgW+ltuDvvw9ET3SCb2XVRE/fZnuJ8iE5I8IYBjVycX
         IMICuxANWkrkfRXi7XQcuZe2FBLEL4YPdZ/Sc+dssLvSW+Vkg4Wz3ENhU3+aLpT+Fc6R
         l0q95Dr11xWTeRzh04gjg1jvTdZK2l+TJwzTwuJpxer3UJh3KlSmAK3tUckG9Jey5Dz6
         WSGVEO8RWm3gS7wMCPpijZ/jexo5S3+yWPMTS7rdTbklD5ZdNHXAzt6WQlA9tdv5ofx6
         y8NQ==
X-Gm-Message-State: ACrzQf1tOqO+Zifhl2AVUTY+L8By2o9on/4qcncoYTfZVT/nR1HyXT+o
        Ny+ulNSAZ+gpiVahcgNBaDcSPXtl3j5+pw==
X-Google-Smtp-Source: AMsMyM6Eq6cYKpQz68q8fMt/l11DVD3uMLH2C383CgUN4eDkVSdC9k81K13cSBFDMagB6H04p+f/eA==
X-Received: by 2002:a05:600c:3c96:b0:3a6:59b1:5eb5 with SMTP id bg22-20020a05600c3c9600b003a659b15eb5mr3184168wmb.187.1663330866779;
        Fri, 16 Sep 2022 05:21:06 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/13] nvmem: add driver handling U-Boot environment variables
Date:   Fri, 16 Sep 2022 13:20:48 +0100
Message-Id: <20220916122100.170016-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot stores its setup as environment variables. It's a list of
key-value pairs stored on flash device with a custom header.

This commit adds an NVMEM driver that:
1. Provides NVMEM access to environment vars binary data
2. Extracts variables as NVMEM cells

Current Linux's NVMEM sysfs API allows reading whole NVMEM data block.
It can be used by user-space tools for reading U-Boot env vars block
without the hassle of finding its location. Parsing will still need to
be re-done there.

Kernel-parsed NVMEM cells can be read however by Linux drivers. This may
be useful for Ethernet drivers for reading device MAC address which is
often stored as U-Boot env variable.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS                |   1 +
 drivers/nvmem/Kconfig      |  13 +++
 drivers/nvmem/Makefile     |   2 +
 drivers/nvmem/u-boot-env.c | 218 +++++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 drivers/nvmem/u-boot-env.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..94aa8ef17535 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20731,6 +20731,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
 M:	Zhangfei Gao <zhangfei.gao@linaro.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d72d879a6d34..bab8a29c9861 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -344,4 +344,17 @@ config NVMEM_APPLE_EFUSES
 	  This driver can also be built as a module. If so, the module will
 	  be called nvmem-apple-efuses.
 
+config NVMEM_U_BOOT_ENV
+	tristate "U-Boot environment variables support"
+	depends on OF && MTD
+	select CRC32
+	help
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
+
+	  Currently this drivers works only with env variables on top of MTD.
+
+	  If compiled as module it will be called nvmem_u-boot-env.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index c710b64f9fe4..399f9972d45b 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -69,3 +69,5 @@ obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 		:= apple-efuses.o
 obj-$(CONFIG_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
 nvmem-microchip-otpc-y		:= microchip-otpc.o
+obj-$(CONFIG_NVMEM_U_BOOT_ENV)	+= nvmem_u-boot-env.o
+nvmem_u-boot-env-y		:= u-boot-env.o
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
new file mode 100644
index 000000000000..9b9abfb8f187
--- /dev/null
+++ b/drivers/nvmem/u-boot-env.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/crc32.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum u_boot_env_format {
+	U_BOOT_FORMAT_SINGLE,
+	U_BOOT_FORMAT_REDUNDANT,
+};
+
+struct u_boot_env {
+	struct device *dev;
+	enum u_boot_env_format format;
+
+	struct mtd_info *mtd;
+
+	/* Cells */
+	struct nvmem_cell_info *cells;
+	int ncells;
+};
+
+struct u_boot_env_image_single {
+	__le32 crc32;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_redundant {
+	__le32 crc32;
+	u8 mark;
+	uint8_t data[];
+} __packed;
+
+static int u_boot_env_read(void *context, unsigned int offset, void *val,
+			   size_t bytes)
+{
+	struct u_boot_env *priv = context;
+	struct device *dev = priv->dev;
+	size_t bytes_read;
+	int err;
+
+	err = mtd_read(priv->mtd, offset, bytes, &bytes_read, val);
+	if (err && !mtd_is_bitflip(err)) {
+		dev_err(dev, "Failed to read from mtd: %d\n", err);
+		return err;
+	}
+
+	if (bytes_read != bytes) {
+		dev_err(dev, "Failed to read %zu bytes\n", bytes);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
+				size_t data_offset, size_t data_len)
+{
+	struct device *dev = priv->dev;
+	char *data = buf + data_offset;
+	char *var, *value, *eq;
+	int idx;
+
+	priv->ncells = 0;
+	for (var = data; var < data + data_len && *var; var += strlen(var) + 1)
+		priv->ncells++;
+
+	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
+	if (!priv->cells)
+		return -ENOMEM;
+
+	for (var = data, idx = 0;
+	     var < data + data_len && *var;
+	     var = value + strlen(value) + 1, idx++) {
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		*eq = '\0';
+		value = eq + 1;
+
+		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!priv->cells[idx].name)
+			return -ENOMEM;
+		priv->cells[idx].offset = data_offset + value - data;
+		priv->cells[idx].bytes = strlen(value);
+	}
+
+	if (WARN_ON(idx != priv->ncells))
+		priv->ncells = idx;
+
+	return 0;
+}
+
+static int u_boot_env_parse(struct u_boot_env *priv)
+{
+	struct device *dev = priv->dev;
+	size_t crc32_data_offset;
+	size_t crc32_data_len;
+	size_t crc32_offset;
+	size_t data_offset;
+	size_t data_len;
+	uint32_t crc32;
+	uint32_t calc;
+	size_t bytes;
+	uint8_t *buf;
+	int err;
+
+	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
+	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
+		dev_err(dev, "Failed to read from mtd: %d\n", err);
+		goto err_kfree;
+	}
+
+	switch (priv->format) {
+	case U_BOOT_FORMAT_SINGLE:
+		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
+		data_offset = offsetof(struct u_boot_env_image_single, data);
+		break;
+	case U_BOOT_FORMAT_REDUNDANT:
+		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
+		data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		break;
+	}
+	crc32 = le32_to_cpu(*(uint32_t *)(buf + crc32_offset));
+	crc32_data_len = priv->mtd->size - crc32_data_offset;
+	data_len = priv->mtd->size - data_offset;
+
+	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	if (calc != crc32) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[priv->mtd->size - 1] = '\0';
+	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
+	if (err)
+		dev_err(dev, "Failed to add cells: %d\n", err);
+
+err_kfree:
+	kfree(buf);
+err_out:
+	return err;
+}
+
+static int u_boot_env_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "u-boot-env",
+		.reg_read = u_boot_env_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct u_boot_env *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	priv->format = (uintptr_t)of_device_get_match_data(dev);
+
+	priv->mtd = of_get_mtd_device_by_node(np);
+	if (IS_ERR(priv->mtd)) {
+		dev_err_probe(dev, PTR_ERR(priv->mtd), "Failed to get %pOF MTD\n", np);
+		return PTR_ERR(priv->mtd);
+	}
+
+	err = u_boot_env_parse(priv);
+	if (err)
+		return err;
+
+	config.dev = dev;
+	config.cells = priv->cells;
+	config.ncells = priv->ncells;
+	config.priv = priv;
+	config.size = priv->mtd->size;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{},
+};
+
+static struct platform_driver u_boot_env_driver = {
+	.probe = u_boot_env_probe,
+	.driver = {
+		.name = "u_boot_env",
+		.of_match_table = u_boot_env_of_match_table,
+	},
+};
+module_platform_driver(u_boot_env_driver);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
-- 
2.25.1

