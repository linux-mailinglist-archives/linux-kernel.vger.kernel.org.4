Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACA663EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbjAJKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbjAJKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41358FA1;
        Tue, 10 Jan 2023 02:54:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c17so16899665edj.13;
        Tue, 10 Jan 2023 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmyqQiyVRmFOYXu2QDS2W36W/FBaUp726XptlAMZsWw=;
        b=C4w2ryEpWmmmLMnP5N7qhckTFtP0fKcI8wSrRoV+o5k4orXcq567QMwSlXJmqWwf/p
         nBn+V1j62Z+9oEchALJmriNG8GVQqK9PRqSiLsCDvQL68yWmcf1WhkOl3gkBiG7re+lQ
         SL+L9n/Nowg6ZBV4skY6fB3Ovc8SZtxquXANK9SHmciBqhdv6FskQMLnv0sums2mOXoC
         0zFfYhq2WFyqVtqX+eBtJXGk9B00Yp3G9tb8D4jxVYtXRecUUffImEWESbH2ZobWoMlQ
         VI94yoH2K9pjOlas6c60IpnfAmOWIJDH3RNehnbSReNMBOBxEr3BAlWe0SMrChvCzGnt
         xUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmyqQiyVRmFOYXu2QDS2W36W/FBaUp726XptlAMZsWw=;
        b=zGe3trI5h4dwd5i8wItCeuCcByyMv/k+EYtR/rTCMwLOQJmnMMvEfBunQksrz2Kq+u
         JzAfIl4/tzkjw9HngAvc3iwEK1xwFnJm78vE2bxJxg5L3beW7VHN/CaStnSh90n9aLCF
         5c3EZMTjY9qF6AWVtvpQHVMHZv5gcU9MQb1Ydb1TKiNGR8aLEv9cyRlWXQQbar8WhEoN
         BHtgMmikAC/s3TWUZicQsFva9gnewH98E1QrExckYJ9BXhx6jUAiETjqJOX8vfKSgq6v
         V1ulaOWhw1fcMazPgwHUuNS76/8ntWBx+vr2MIjeuY+vb4fZBpAbpzQcwRMlDyRLtUZd
         h4jQ==
X-Gm-Message-State: AFqh2kr1EIAMSTP7PBguaqxX7PJYIaKfGJgsORYMkVXrz6d7oSew7OGq
        17DfdhXAy1APMbO2G6eEBG8=
X-Google-Smtp-Source: AMrXdXuMmiAS5CQc8ZMzHqiyRin8fv767BLT2Ch4nTfKwilZM5AUijtZL2U+SVLHvX95NzHtpOaKUw==
X-Received: by 2002:a05:6402:4141:b0:469:ee22:d97a with SMTP id x1-20020a056402414100b00469ee22d97amr62099196eda.32.1673348079841;
        Tue, 10 Jan 2023 02:54:39 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm4818199edr.32.2023.01.10.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:54:39 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 4/6] nvmem: u-boot-env: convert to layout driver
Date:   Tue, 10 Jan 2023 11:54:23 +0100
Message-Id: <20230110105425.13188-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110105425.13188-1-zajec5@gmail.com>
References: <20230110105425.13188-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot environment variables can be found on various NVMEM devices (not
just MTD) so convert this driver to a generic layout one.

This way - thanks to using NVMEM generic API - this driver can be reused
in other scenarios.

For backward DT compatibility we need to support the old compatible
brinding string for now. Luckily it's just a one line of code.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 MAINTAINERS                        |   2 +-
 drivers/mtd/mtdcore.c              |   7 +-
 drivers/nvmem/Kconfig              |  14 +-
 drivers/nvmem/Makefile             |   2 -
 drivers/nvmem/layouts/Kconfig      |  10 ++
 drivers/nvmem/layouts/Makefile     |   1 +
 drivers/nvmem/layouts/u-boot-env.c | 176 ++++++++++++++++++++++
 drivers/nvmem/u-boot-env.c         | 233 -----------------------------
 8 files changed, 199 insertions(+), 246 deletions(-)
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 delete mode 100644 drivers/nvmem/u-boot-env.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e13ee875c77..ace29081c613 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21137,7 +21137,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
-F:	drivers/nvmem/u-boot-env.c
+F:	drivers/nvmem/layouts/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
 M:	Zhangfei Gao <zhangfei.gao@linaro.org>
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 0feacb9fbdac..621e0b87b781 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -518,6 +518,11 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 {
 	struct device_node *node = mtd_get_of_node(mtd);
 	struct nvmem_config config = {};
+	bool use_dev_of_node = false;
+
+	if (of_device_is_compatible(node, "nvmem-cells") ||
+	    (IS_ENABLED(CONFIG_NVMEM_U_BOOT_ENV) && of_device_is_compatible(node, "brcm,env")))
+		use_dev_of_node = true;
 
 	config.id = -1;
 	config.dev = &mtd->dev;
@@ -530,7 +535,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.read_only = true;
 	config.root_only = true;
 	config.ignore_wp = true;
-	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
+	config.no_of_node = !use_dev_of_node;
 	config.priv = mtd;
 
 	mtd->nvmem = nvmem_register(&config);
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0e10b5b094b9..980734ba8ddc 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -327,17 +327,13 @@ config NVMEM_SUNXI_SID
 	  will be called nvmem_sunxi_sid.
 
 config NVMEM_U_BOOT_ENV
-	tristate "U-Boot environment variables support"
+	bool "U-Boot environment variables deprecated binding support"
 	depends on OF && MTD
-	select CRC32
+	select NVMEM_LAYOUT_U_BOOT_ENV
 	help
-	  U-Boot stores its setup as environment variables. This driver adds
-	  support for verifying & exporting such data. It also exposes variables
-	  as NVMEM cells so they can be referenced by other drivers.
-
-	  Currently this drivers works only with env variables on top of MTD.
-
-	  If compiled as module it will be called nvmem_u-boot-env.
+	  This option enables support for deprecated DT binding for U-Boot
+	  environment variables. It was used by DT files before introducing
+	  nvmem-layout node based syntax.
 
 config NVMEM_UNIPHIER_EFUSE
 	tristate "UniPhier SoCs eFuse support"
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4cf87ef6c24d..3b827ce96f6d 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -66,8 +66,6 @@ obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y			:= sunxi_sid.o
-obj-$(CONFIG_NVMEM_U_BOOT_ENV)		+= nvmem_u-boot-env.o
-nvmem_u-boot-env-y			:= u-boot-env.o
 obj-$(CONFIG_NVMEM_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
 nvmem-uniphier-efuse-y			:= uniphier-efuse.o
 obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 9ad50474cb77..8a38c514943a 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -20,4 +20,14 @@ config NVMEM_LAYOUT_ONIE_TLV
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_U_BOOT_ENV
+	bool "U-Boot environment variables support"
+	select CRC32
+	help
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 2974bd7d33ed..4940c9db0665 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
+obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
new file mode 100644
index 000000000000..95c314553952
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/crc32.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum u_boot_env_format {
+	U_BOOT_FORMAT_SINGLE,
+	U_BOOT_FORMAT_REDUNDANT,
+	U_BOOT_FORMAT_BROADCOM,
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
+struct u_boot_env_image_broadcom {
+	__le32 magic;
+	__le32 len;
+	__le32 crc32;
+	uint8_t data[];
+} __packed;
+
+static int u_boot_env_parse_data(struct device *dev, struct nvmem_device *nvmem, uint8_t *buf,
+				 size_t data_offset, size_t data_len)
+{
+	struct device_node *np;
+	char *data = buf + data_offset;
+	char *var, *value, *eq;
+	int err = 0;
+
+	np = of_nvmem_layout_get_container(nvmem);
+	if (!np)
+		return -ENOENT;
+
+	for (var = data;
+	     var < data + data_len && *var;
+	     var = value + strlen(value) + 1) {
+		struct nvmem_cell_info info = {};
+
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		*eq = '\0';
+		value = eq + 1;
+
+		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!info.name) {
+			err = -ENOMEM;
+			break;
+		}
+		info.offset = data_offset + value - data;
+		info.bytes = strlen(value);
+		info.np = of_get_child_by_name(np, info.name);
+
+		err = nvmem_add_one_cell(nvmem, &info);
+		if (err) {
+			dev_err(dev, "Failed to add \"%s\" cell: %d\n", info.name, err);
+			break;
+		}
+	}
+
+	of_node_put(np);
+
+	return err;
+}
+
+static int u_boot_env_add_cells(struct device *dev, struct nvmem_device *nvmem,
+				struct nvmem_layout *layout)
+{
+	enum u_boot_env_format format;
+	size_t crc32_data_offset;
+	size_t crc32_data_len;
+	size_t crc32_offset;
+	size_t data_offset;
+	size_t data_len;
+	size_t dev_size;
+	uint32_t crc32;
+	uint32_t calc;
+	size_t bytes;
+	uint8_t *buf;
+	int err;
+
+	format = (uintptr_t)nvmem_layout_get_match_data(nvmem, layout);
+
+	dev_size = nvmem_dev_size(nvmem);
+
+	buf = kcalloc(1, dev_size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0 || bytes != dev_size) {
+		dev_err(dev, "Failed to read from NVMEM device: %zd\n", bytes);
+		goto err_kfree;
+	}
+
+	switch (format) {
+	case U_BOOT_FORMAT_SINGLE:
+		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
+		data_offset = offsetof(struct u_boot_env_image_single, data);
+		break;
+	case U_BOOT_FORMAT_REDUNDANT:
+		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		break;
+	case U_BOOT_FORMAT_BROADCOM:
+		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		break;
+	}
+	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
+
+	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	if (calc != crc32) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[dev_size - 1] = '\0';
+	err = u_boot_env_parse_data(dev, nvmem, buf, data_offset, data_len);
+	if (err)
+		dev_err(dev, "Failed to parse cells: %d\n", err);
+
+err_kfree:
+	kfree(buf);
+err_out:
+	return err;
+}
+
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
+	{},
+};
+
+static struct nvmem_layout u_boot_env_layout = {
+	.name = "U-Boot environment variables layout",
+	.of_match_table = u_boot_env_of_match_table,
+	.add_cells = u_boot_env_add_cells,
+};
+
+static int __init u_boot_env_init(void)
+{
+	return nvmem_layout_register(&u_boot_env_layout);
+}
+subsys_initcall(u_boot_env_init);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
deleted file mode 100644
index 29b1d87a3c51..000000000000
--- a/drivers/nvmem/u-boot-env.c
+++ /dev/null
@@ -1,233 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2022 Rafał Miłecki <rafal@milecki.pl>
- */
-
-#include <linux/crc32.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/mtd/mtd.h>
-#include <linux/nvmem-consumer.h>
-#include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-enum u_boot_env_format {
-	U_BOOT_FORMAT_SINGLE,
-	U_BOOT_FORMAT_REDUNDANT,
-	U_BOOT_FORMAT_BROADCOM,
-};
-
-struct u_boot_env {
-	struct device *dev;
-	enum u_boot_env_format format;
-
-	struct mtd_info *mtd;
-
-	/* Cells */
-	struct nvmem_cell_info *cells;
-	int ncells;
-};
-
-struct u_boot_env_image_single {
-	__le32 crc32;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_redundant {
-	__le32 crc32;
-	u8 mark;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_broadcom {
-	__le32 magic;
-	__le32 len;
-	__le32 crc32;
-	uint8_t data[0];
-} __packed;
-
-static int u_boot_env_read(void *context, unsigned int offset, void *val,
-			   size_t bytes)
-{
-	struct u_boot_env *priv = context;
-	struct device *dev = priv->dev;
-	size_t bytes_read;
-	int err;
-
-	err = mtd_read(priv->mtd, offset, bytes, &bytes_read, val);
-	if (err && !mtd_is_bitflip(err)) {
-		dev_err(dev, "Failed to read from mtd: %d\n", err);
-		return err;
-	}
-
-	if (bytes_read != bytes) {
-		dev_err(dev, "Failed to read %zu bytes\n", bytes);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
-				size_t data_offset, size_t data_len)
-{
-	struct device *dev = priv->dev;
-	char *data = buf + data_offset;
-	char *var, *value, *eq;
-	int idx;
-
-	priv->ncells = 0;
-	for (var = data; var < data + data_len && *var; var += strlen(var) + 1)
-		priv->ncells++;
-
-	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
-	if (!priv->cells)
-		return -ENOMEM;
-
-	for (var = data, idx = 0;
-	     var < data + data_len && *var;
-	     var = value + strlen(value) + 1, idx++) {
-		eq = strchr(var, '=');
-		if (!eq)
-			break;
-		*eq = '\0';
-		value = eq + 1;
-
-		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!priv->cells[idx].name)
-			return -ENOMEM;
-		priv->cells[idx].offset = data_offset + value - data;
-		priv->cells[idx].bytes = strlen(value);
-		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
-	}
-
-	if (WARN_ON(idx != priv->ncells))
-		priv->ncells = idx;
-
-	return 0;
-}
-
-static int u_boot_env_parse(struct u_boot_env *priv)
-{
-	struct device *dev = priv->dev;
-	size_t crc32_data_offset;
-	size_t crc32_data_len;
-	size_t crc32_offset;
-	size_t data_offset;
-	size_t data_len;
-	uint32_t crc32;
-	uint32_t calc;
-	size_t bytes;
-	uint8_t *buf;
-	int err;
-
-	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
-	if (!buf) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
-	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
-		dev_err(dev, "Failed to read from mtd: %d\n", err);
-		goto err_kfree;
-	}
-
-	switch (priv->format) {
-	case U_BOOT_FORMAT_SINGLE:
-		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
-		data_offset = offsetof(struct u_boot_env_image_single, data);
-		break;
-	case U_BOOT_FORMAT_REDUNDANT:
-		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		break;
-	case U_BOOT_FORMAT_BROADCOM:
-		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		break;
-	}
-	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
-
-	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
-	if (calc != crc32) {
-		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
-		err = -EINVAL;
-		goto err_kfree;
-	}
-
-	buf[priv->mtd->size - 1] = '\0';
-	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
-	if (err)
-		dev_err(dev, "Failed to add cells: %d\n", err);
-
-err_kfree:
-	kfree(buf);
-err_out:
-	return err;
-}
-
-static int u_boot_env_probe(struct platform_device *pdev)
-{
-	struct nvmem_config config = {
-		.name = "u-boot-env",
-		.reg_read = u_boot_env_read,
-	};
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct u_boot_env *priv;
-	int err;
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-	priv->dev = dev;
-
-	priv->format = (uintptr_t)of_device_get_match_data(dev);
-
-	priv->mtd = of_get_mtd_device_by_node(np);
-	if (IS_ERR(priv->mtd)) {
-		dev_err_probe(dev, PTR_ERR(priv->mtd), "Failed to get %pOF MTD\n", np);
-		return PTR_ERR(priv->mtd);
-	}
-
-	err = u_boot_env_parse(priv);
-	if (err)
-		return err;
-
-	config.dev = dev;
-	config.cells = priv->cells;
-	config.ncells = priv->ncells;
-	config.priv = priv;
-	config.size = priv->mtd->size;
-
-	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
-}
-
-static const struct of_device_id u_boot_env_of_match_table[] = {
-	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
-	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
-	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
-	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
-	{},
-};
-
-static struct platform_driver u_boot_env_driver = {
-	.probe = u_boot_env_probe,
-	.driver = {
-		.name = "u_boot_env",
-		.of_match_table = u_boot_env_of_match_table,
-	},
-};
-module_platform_driver(u_boot_env_driver);
-
-MODULE_AUTHOR("Rafał Miłecki");
-MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
-- 
2.34.1

