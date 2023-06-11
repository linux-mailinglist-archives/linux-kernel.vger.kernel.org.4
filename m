Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859172B210
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjFKNZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 09:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjFKNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2E7BC
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 06:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD9636162C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 13:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C792BC4339C;
        Sun, 11 Jun 2023 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686489917;
        bh=iGXfXvl/InzCE01L3sj/3r7/25fU+y8vp67ay4WDSZk=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=sD1d1xsciU4UF1mPeH58L23UrGpOKJhQk5GEDMz+6hGModQ/HE6OnnrEFJcTa7GMV
         7hwFwq8lYECkfqghCj2MY5ssvXEsJMYtFqZiX+StHYim4UFQddL1MgUnFFCrLIt5PZ
         V04QBMLPwi59BumYyf7C4Z37mU+ye5d6eZsEF/RGd45SBD8Ta7PKQRxmtJPVGOd/hH
         AotF4/+qpmcA3Yh38c+We+HO5SljXtFU5mo17NOorcg5CrmctAR/W7wder7ToBLncj
         57K211Y+BCmCjxqUoL/JHFHmSx6UX44keX7O1WyEbOFQZQSn81wm9BbjyGNtB/KizG
         si45pb+eDGnCA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 11 Jun 2023 14:25:02 +0100
Subject: [PATCH 1/2] regmap: Provide a ram backed regmap with raw support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230610-regcache-raw-kunit-v1-1-583112cd28ac@kernel.org>
References: <20230610-regcache-raw-kunit-v1-0-583112cd28ac@kernel.org>
In-Reply-To: <20230610-regcache-raw-kunit-v1-0-583112cd28ac@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=5358; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iGXfXvl/InzCE01L3sj/3r7/25fU+y8vp67ay4WDSZk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhcs58m+HeWH7HY7AiWhG5fOA1XIsYUj4h1lWHnha
 Emy3/gCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIXLOQAKCRAk1otyXVSH0Fn8CA
 CGIdztpdcZxHw5ek5sxzeUB20CaHawbD3CQLm5mE2Sn4AuyVHgE1OoOTlawyCLNn1+n538YoLwud7+
 E2zCUaH/6g+VuMudS7uDrSe6032ZwK6amDcDPyN2anauU+JmXvAe40FbgULzKgMoDsG1ZSfxmQlful
 OJ5OTMb34omIBUAoP+6hVnzTleeoqUowD9GnCBp0rvKdX0LSgb8tX78M0e/Li47+eg0so2szC7ziKE
 SlbShUMBwqAzvHTMOyKVcGu13VAGcMneP6yuJaPWMFcUF8lxP/yNThW8Zx6xdk/lAefJpIFMN/WdZN
 FqN263qa1EvaEjto7p7fEqV8RN/Pg9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple, 16 bit only, RAM backed regmap which supports raw I/O for
use in testing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/Makefile         |   2 +-
 drivers/base/regmap/internal.h       |   8 +++
 drivers/base/regmap/regmap-raw-ram.c | 133 +++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index f6c6cb017200..5fdd0845b45e 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
 obj-$(CONFIG_REGMAP_KUNIT) += regmap-kunit.o
 obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
 obj-$(CONFIG_REGMAP_I2C) += regmap-i2c.o
-obj-$(CONFIG_REGMAP_RAM) += regmap-ram.o
+obj-$(CONFIG_REGMAP_RAM) += regmap-ram.o regmap-raw-ram.o
 obj-$(CONFIG_REGMAP_SLIMBUS) += regmap-slimbus.o
 obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 9bd0dfd1e259..d987ce182d22 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -312,6 +312,7 @@ struct regmap_ram_data {
 	unsigned int *vals;  /* Allocatd by caller */
 	bool *read;
 	bool *written;
+	enum regmap_endian reg_endian;
 };
 
 /*
@@ -326,5 +327,12 @@ struct regmap *__regmap_init_ram(const struct regmap_config *config,
 #define regmap_init_ram(config, data)					\
 	__regmap_lockdep_wrapper(__regmap_init_ram, #config, config, data)
 
+struct regmap *__regmap_init_raw_ram(const struct regmap_config *config,
+				     struct regmap_ram_data *data,
+				     struct lock_class_key *lock_key,
+				     const char *lock_name);
+
+#define regmap_init_raw_ram(config, data)				\
+	__regmap_lockdep_wrapper(__regmap_init_raw_ram, #config, config, data)
 
 #endif
diff --git a/drivers/base/regmap/regmap-raw-ram.c b/drivers/base/regmap/regmap-raw-ram.c
new file mode 100644
index 000000000000..c9b800885f3b
--- /dev/null
+++ b/drivers/base/regmap/regmap-raw-ram.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - Memory region with raw access
+//
+// This is intended for testing only
+//
+// Copyright (c) 2023, Arm Ltd
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/swab.h>
+
+#include "internal.h"
+
+static unsigned int decode_reg(enum regmap_endian endian, const void *reg)
+{
+	const u16 *r = reg;
+
+	if (endian == REGMAP_ENDIAN_BIG)
+		return be16_to_cpu(*r);
+	else
+		return le16_to_cpu(*r);
+}
+
+static int regmap_raw_ram_gather_write(void *context,
+				       const void *reg, size_t reg_len,
+				       const void *val, size_t val_len)
+{
+	struct regmap_ram_data *data = context;
+	unsigned int r;
+	u16 *our_buf = (u16 *)data->vals;
+	int i;
+
+	if (reg_len != 2)
+		return -EINVAL;
+	if (val_len % 2)
+		return -EINVAL;
+
+	r = decode_reg(data->reg_endian, reg);
+	memcpy(&our_buf[r], val, val_len);
+
+	for (i = 0; i < val_len / 2; i++)
+		data->written[r + i] = true;
+	
+	return 0;
+}
+
+static int regmap_raw_ram_write(void *context, const void *data, size_t count)
+{
+	return regmap_raw_ram_gather_write(context, data, 2,
+					   data + 2, count - 2);
+}
+
+static int regmap_raw_ram_read(void *context,
+			       const void *reg, size_t reg_len,
+			       void *val, size_t val_len)
+{
+	struct regmap_ram_data *data = context;
+	unsigned int r;
+	u16 *our_buf = (u16 *)data->vals;
+	int i;
+
+	if (reg_len != 2)
+		return -EINVAL;
+	if (val_len % 2)
+		return -EINVAL;
+
+	r = decode_reg(data->reg_endian, reg);
+	memcpy(val, &our_buf[r], val_len);
+
+	for (i = 0; i < val_len / 2; i++)
+		data->read[r + i] = true;
+
+	return 0;
+}
+
+static void regmap_raw_ram_free_context(void *context)
+{
+	struct regmap_ram_data *data = context;
+
+	kfree(data->vals);
+	kfree(data->read);
+	kfree(data->written);
+	kfree(data);
+}
+
+static const struct regmap_bus regmap_raw_ram = {
+	.fast_io = true,
+	.write = regmap_raw_ram_write,
+	.gather_write = regmap_raw_ram_gather_write,
+	.read = regmap_raw_ram_read,
+	.free_context = regmap_raw_ram_free_context,
+};
+
+struct regmap *__regmap_init_raw_ram(const struct regmap_config *config,
+				     struct regmap_ram_data *data,
+				     struct lock_class_key *lock_key,
+				     const char *lock_name)
+{
+	struct regmap *map;
+
+	if (config->reg_bits != 16)
+		return ERR_PTR(-EINVAL);
+
+	if (!config->max_register) {
+		pr_crit("No max_register specified for RAM regmap\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	data->read = kcalloc(sizeof(bool), config->max_register + 1,
+			     GFP_KERNEL);
+	if (!data->read)
+		return ERR_PTR(-ENOMEM);
+
+	data->written = kcalloc(sizeof(bool), config->max_register + 1,
+				GFP_KERNEL);
+	if (!data->written)
+		return ERR_PTR(-ENOMEM);
+
+	data->reg_endian = config->reg_format_endian;
+
+	map = __regmap_init(NULL, &regmap_raw_ram, data, config,
+			    lock_key, lock_name);
+
+	return map;
+}
+EXPORT_SYMBOL_GPL(__regmap_init_raw_ram);
+
+MODULE_LICENSE("GPL v2");

-- 
2.30.2

