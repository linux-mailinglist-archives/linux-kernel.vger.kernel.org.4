Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBC96A53AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjB1HaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB1H3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:29:51 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA6CC677;
        Mon, 27 Feb 2023 23:29:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m7so11896433lfj.8;
        Mon, 27 Feb 2023 23:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsqApEBQlKEPGyVsiuZgMJvp51SjT+jXo8h7J6aTlqU=;
        b=DBHZA2u5l6sYOQBXU/2/qGXgWNfm4q9o6T31R/JnTWDO8+FcoSjDjHBXuWpemTIAJ2
         zZnTHkzXpgOcUctUStUU7PVZpT45yuNXpJjl9/QvKceCBhaN5wDdBpWNxfKAl09oI14X
         3+M3Q2qL3o0bj/0SBM4rca658rXwm18o+nxUHCLvSgGwWtqnnxK7UsLOn4+EQCzLZPEt
         ZJ10IHLfgOWy9SHq4uqPd8X4t9WhlQ/X/MYiVW2LfGLwdznLxMeo3E32a6gmxjVSLwdA
         fuw50Xk3ahyQ9LaKxVQkfTfdfOc0mIb1Q70ZL0FYsdkbHsF+jPPLKWLm0vaETbpt3c3u
         PcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsqApEBQlKEPGyVsiuZgMJvp51SjT+jXo8h7J6aTlqU=;
        b=rhakyfkN3IWXNr0uma+JReRBTpdCw0/kK+GBy0yej71s8yGsa2x0GqHSxuYCmSukqO
         nYMI7oDgVGiLDWnQm0SPoBsPhCc6Y2ByQ3Qk0ptqK6sYGlc3H9AdRoyiQ/GOy0Mcwod6
         QsNJ6KxpG4L9FgkUm8NKkCbNv+pslhzIPQ+xT0eN0+tPF0OsQm/m8eREv5XGTc8B9b3T
         etPKlF3ibonPxP3BlNnu1LK+skgoiiGd0216ILShneVa0Z71kkNid6CjSgLxdJhm0qJJ
         DkZBDdngRQ8YHeBgYGZXhsOJ4ku9GZcMmSbhj3ZC2l1gZARuMCDrH0YmsyT7p7Upkw9h
         D+1A==
X-Gm-Message-State: AO0yUKV4Ad3sugVWHrqi9/61VccDuPfdBLs0op4Me0PjgKW7A111EkTp
        K3pUNXqS4FuGTJ79ZYf0BEA=
X-Google-Smtp-Source: AK7set/BRw5MnHT0rZU7iDo8+O3cRX17DDUeYCp+iZHDDfDmN9WEg14Yor2SJOus5mnaGa3ZPRsN2A==
X-Received: by 2002:ac2:4117:0:b0:4db:4b7a:d6de with SMTP id b23-20020ac24117000000b004db4b7ad6demr410780lfi.63.1677569388255;
        Mon, 27 Feb 2023 23:29:48 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id l2-20020ac25542000000b004d85a7e8b17sm1229550lfk.269.2023.02.27.23.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:29:47 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 2/2] nvmem: add generic driver for devices with MMIO access
Date:   Tue, 28 Feb 2023 08:29:36 +0100
Message-Id: <20230228072936.1108-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228072936.1108-1-zajec5@gmail.com>
References: <20230228072936.1108-1-zajec5@gmail.com>
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

Some NVMEM devices can be accessed by simply mapping memory and reading
from / writing to it. This driver adds support for a generic
"mmio-nvmem" DT binding used by such devices.

One of such devices is Broadcom's NVRAM. It's already supported (see
NVMEM_BRCM_NVRAM) but existing driver covers both:
1. NVMEM device access
2. NVMEM content parsing

Once we get support for NVMEM layouts then existing NVRAM driver will
get converted into a layout and generic driver will take over
responsibility for data access.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V3: Support "reg-io-width", basic writing & "brcm,nvram" string
V3: Don't duplicate core checks, add 64 b support, complete writing
    support, don't add confusing conditional "brcm,nvram" support (it
    will be handled with layouts migration)
---
 drivers/nvmem/Kconfig  |  10 +++
 drivers/nvmem/Makefile |   2 +
 drivers/nvmem/mmio.c   | 148 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/nvmem/mmio.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 6dec38805041..189ea85bd67d 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -166,6 +166,16 @@ config NVMEM_MICROCHIP_OTPC
 	  This driver enable the OTP controller available on Microchip SAMA7G5
 	  SoCs. It controls the access to the OTP memory connected to it.
 
+config NVMEM_MMIO
+	tristate "MMIO access based NVMEM support"
+	depends on HAS_IOMEM
+	help
+	  This driver provides support for NVMEM devices that can be accessed
+	  using MMIO.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-mmio.
+
 config NVMEM_MTK_EFUSE
 	tristate "Mediatek SoCs EFUSE support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 6a1efffa88f0..767a9db2bfc1 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -35,6 +35,8 @@ obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
 nvmem_meson_mx_efuse-y			:= meson-mx-efuse.o
 obj-$(CONFIG_NVMEM_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
 nvmem-microchip-otpc-y			:= microchip-otpc.o
+obj-$(CONFIG_NVMEM_MMIO)		+= nvmem-mmio.o
+nvmem-mmio-y				:= mmio.o
 obj-$(CONFIG_NVMEM_MTK_EFUSE)		+= nvmem_mtk-efuse.o
 nvmem_mtk-efuse-y			:= mtk-efuse.o
 obj-$(CONFIG_NVMEM_MXS_OCOTP)		+= nvmem-mxs-ocotp.o
diff --git a/drivers/nvmem/mmio.c b/drivers/nvmem/mmio.c
new file mode 100644
index 000000000000..ce51648bb321
--- /dev/null
+++ b/drivers/nvmem/mmio.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+struct mmio_nvmem {
+	void __iomem *base;
+	u32 io_width;
+};
+
+static int mmio_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct mmio_nvmem *priv = context;
+	u64 __maybe_unused *dst64;
+	u32 *dst32;
+	u16 *dst16;
+	u8 *dst8;
+
+	switch (priv->io_width) {
+	case 0:
+		memcpy_fromio(val, priv->base + offset, bytes);
+		break;
+	case 1:
+		for (dst8 = val; bytes; bytes -= 1, offset += 1)
+			*dst8++ = readb(priv->base + offset);
+		break;
+	case 2:
+		for (dst16 = val; bytes; bytes -= 2, offset += 2)
+			*dst16++ = readw(priv->base + offset);
+		break;
+	case 4:
+		for (dst32 = val; bytes; bytes -= 4, offset += 4)
+			*dst32++ = readl(priv->base + offset);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		for (dst64 = val; bytes; bytes -= 8, offset += 8)
+			*dst64++ = readq(priv->base + offset);
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mmio_nvmem_write(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct mmio_nvmem *priv = context;
+	u64 __maybe_unused *dst64;
+	u32 *dst32;
+	u16 *dst16;
+	u8 *dst8;
+
+	switch (priv->io_width) {
+	case 0:
+		memcpy_toio(priv->base + offset, val, bytes);
+		break;
+	case 1:
+		for (dst8 = val; bytes; bytes -= 1, offset += 1)
+			writeb(*dst8++, priv->base + offset);
+		break;
+	case 2:
+		for (dst16 = val; bytes; bytes -= 2, offset += 2)
+			writew(*dst16++, priv->base + offset);
+		break;
+	case 4:
+		for (dst32 = val; bytes; bytes -= 4, offset += 4)
+			writel(*dst32++, priv->base + offset);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		for (dst64 = val; bytes; bytes -= 8, offset += 8)
+			writeq(*dst64++, priv->base + offset);
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mmio_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "mmio-nvmem",
+		.id = NVMEM_DEVID_AUTO,
+		.read_only = true,
+		.reg_read = mmio_nvmem_read,
+		.reg_write = mmio_nvmem_write,
+	};
+	struct device *dev = &pdev->dev;
+	struct mmio_nvmem *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	of_property_read_u32(dev->of_node, "reg-io-width", &priv->io_width);
+
+	config.dev = dev;
+	config.size = resource_size(res);
+	config.word_size = priv->io_width;
+	config.stride = priv->io_width;
+	config.priv = priv;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id mmio_nvmem_of_match_table[] = {
+	{ .compatible = "mmio-nvmem", },
+	{},
+};
+
+static struct platform_driver mmio_nvmem_driver = {
+	.probe = mmio_nvmem_probe,
+	.driver = {
+		.name = "mmio_nvmem",
+		.of_match_table = mmio_nvmem_of_match_table,
+	},
+};
+
+static int __init mmio_nvmem_init(void)
+{
+	return platform_driver_register(&mmio_nvmem_driver);
+}
+
+subsys_initcall_sync(mmio_nvmem_init);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, mmio_nvmem_of_match_table);
-- 
2.34.1

