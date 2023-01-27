Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3E67ECE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjA0R6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjA0R6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:58:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A637D2BD;
        Fri, 27 Jan 2023 09:58:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id fi26so5424670edb.7;
        Fri, 27 Jan 2023 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17/xEWC1WmOjlte8h0eDRTmEFdiv+lS1lWx2rWU4nVc=;
        b=lXG0lVpDyWFmskbnUS03gA72O+I5FXCzECuk+XOYf33HOHpv1AvKHBp9VBTv52jA+W
         GRxq7EP4pkvXeZYbXpRaMUJGxqtrDItw0c1t0Fij7ny/38Pm8a0Ex94EEkQZwYvwyCJn
         VBnFdRJbGmNfyBH3XZ6Obni3BhSmC4Tc+QLIx97O1rUBmIPG5vRn8YkVKRIIPN+NgZ+O
         x8/MHATBonft0FENTqEz2wZcWPywNNLy7DwbFFf6ywJHVSxVsp/mbhPmfy2T4iqyCM63
         MVfnBzjA3GOMIfg7WPnzSZd/QRPqty4Vg9iOtDIlAi3hHcOUykPfjqhQDs213I+6dS+c
         Rkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17/xEWC1WmOjlte8h0eDRTmEFdiv+lS1lWx2rWU4nVc=;
        b=LJFfyvhZMPXpWomsYoHp6CBTljtBSpkcFpw5sCkoPppLRhyoGoVjI/DCJ6N75q6W5H
         ejUnC94iqg73UUZ6Q6CkAJl355y9/BcS3iryLH0Qy2xBEjPeOe+YtaSYU1mWdtAxiR8c
         Ay2e0pJRf2n5Fk2Gc5aQVLKtDJ+Q0BWE2+UzJ+0JBgI5QDLdYD+/yzimLxZnuIrZC1cS
         Pi9x6Pj0qePkfQcgksIwdy8lA0cqMBBS0aBi1M26aztGwsP2Jq3VEf56vjlcc2wGH/ql
         t/B5L5leFbRcV2o/c6NXXVgaeUkwO+UX0DLvh+6r4DryQIrMdqSf1wfHdX5ac5XbfYUI
         nsVw==
X-Gm-Message-State: AFqh2koTdjWofTfEUFN2+UJQ3EguftZw7gJHtYQ0QYh4YkVNOim6ZzTo
        bbuZdghvLMMiRPN+tR6dWuE=
X-Google-Smtp-Source: AMrXdXthBjfeJGbjwTfS/yY7ImMNDD+PXI0nFRdpjGlUGxb66VhdMue8cgJPy/yV/1yZEzlOg/ya0g==
X-Received: by 2002:aa7:cc81:0:b0:47e:eaae:9a5b with SMTP id p1-20020aa7cc81000000b0047eeaae9a5bmr41321458edt.42.1674842322849;
        Fri, 27 Jan 2023 09:58:42 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709067e5600b0087276f66c6asm2600508ejr.115.2023.01.27.09.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:58:42 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] nvmem: add generic driver for devices with I/O based access
Date:   Fri, 27 Jan 2023 18:58:31 +0100
Message-Id: <20230127175831.26753-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127175831.26753-1-zajec5@gmail.com>
References: <20230127175831.26753-1-zajec5@gmail.com>
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

With nvmem layouts in place we should now work on plain content access
NVMEM drivers (e.g. IO one). Actual NVMEM content handling should go to
layout drivers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/Kconfig  |  7 ++++
 drivers/nvmem/Makefile |  2 ++
 drivers/nvmem/io.c     | 79 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 drivers/nvmem/io.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 789729ff7e50..e77bfe6eb52e 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -90,6 +90,13 @@ config NVMEM_IMX_OCOTP_SCU
 	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
 	  available on i.MX8 SoCs.
 
+config NVMEM_IO
+	tristate "IO access based NVMEM support"
+	depends on HAS_IOMEM
+	help
+	  This driver provides support for NVMEM devices that can be accessed
+	  using I/O mapping.
+
 config NVMEM_JZ4780_EFUSE
 	tristate "JZ4780 EFUSE Memory Support"
 	depends on MACH_INGENIC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 442f9a4876a5..82db0a89c4d6 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y			:= imx-ocotp.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
 nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
+obj-$(CONFIG_NVMEM_IO)			+= nvmem-io.o
+nvmem-io-y				:= io.o
 obj-$(CONFIG_NVMEM_JZ4780_EFUSE)	+= nvmem_jz4780_efuse.o
 nvmem_jz4780_efuse-y			:= jz4780-efuse.o
 obj-$(CONFIG_NVMEM_LAN9662_OTPC)	+= nvmem-lan9662-otpc.o
diff --git a/drivers/nvmem/io.c b/drivers/nvmem/io.c
new file mode 100644
index 000000000000..307526fda036
--- /dev/null
+++ b/drivers/nvmem/io.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+struct io_nvmem {
+	void __iomem *base;
+};
+
+static int io_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct io_nvmem *priv = context;
+	u8 *dst = val;
+
+	while (bytes--)
+		*dst++ = readb(priv->base + offset++);
+
+	return 0;
+}
+
+static int io_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "io-nvmem",
+		.reg_read = io_nvmem_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct io_nvmem *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	config.dev = dev;
+	config.priv = priv;
+	config.size = resource_size(res);
+
+	if (!device_property_present(dev, "read-only"))
+		dev_warn(dev, "Writing is not supported yet");
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id io_nvmem_of_match_table[] = {
+	{ .compatible = "io-nvmem", },
+	{},
+};
+
+static struct platform_driver io_nvmem_driver = {
+	.probe = io_nvmem_probe,
+	.driver = {
+		.name = "io_nvmem",
+		.of_match_table = io_nvmem_of_match_table,
+	},
+};
+
+static int __init io_nvmem_init(void)
+{
+	return platform_driver_register(&io_nvmem_driver);
+}
+
+subsys_initcall_sync(io_nvmem_init);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, io_nvmem_of_match_table);
-- 
2.34.1

