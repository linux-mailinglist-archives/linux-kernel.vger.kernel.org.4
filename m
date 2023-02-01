Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20629685FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBAGwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBAGwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:52:34 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225069740;
        Tue, 31 Jan 2023 22:52:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw12so32546222ejc.2;
        Tue, 31 Jan 2023 22:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPyU19+VhmMuIMMpSU5GySmAIP6oqfiCTnK5b5e8Lus=;
        b=WrbOhXAP/9dmBsWhH17HvQ/1RmrjVeZyRRbdY5B8ueOrb3gEhdOqTxM7CW4PMPYFL4
         TfCfQoI9GAnc2vHMfMEMPctNOI+K95B9YLclNRWNuuTXcKzKWmoLgIucD5Ri2dRB9+Rm
         QLv/KzB8rnUvez0ZHoG4nZrJ85jQDhii7gbbkQKCmrmEKC4KDkfntN51xX569+x5XVeb
         dFpPQPuZ6oaAADR43HGvkfC2TBXTPPPMjpzuxkmHkQI9fkG2WBMeiFoFY8mWgPOubeq/
         Dz6XsYizMF8UQYUJihKY5arEzzl4iYYd4W6XzB6rUSmkhwPwjD5UKxN8KKLZxC+7L1v9
         Ohug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPyU19+VhmMuIMMpSU5GySmAIP6oqfiCTnK5b5e8Lus=;
        b=AiKbHyMlDb58NdhA+ElbaltreNx2XylkShr9ukdTYtWaQhrEO360y+wcAR0Qek0qqB
         riB+aiL/0D7WPsJt5JOM8cOYTCUSRAYPOoAFtRhpWkzU5ZfBquQ/jjEjViEZryzbTTNH
         9fT29rANC0/SmxslgVOTRG0otMb9X/tKhjCzVkLn4yAxlA132CQi8o73BtiMSJFsP+I3
         bVY5l9xCPIPGZCXD3NkLTDfSCpW73rl65wwfPT0cn+46n0Dg1UuShxwA3i3gusHFbbQi
         7A2cq8ip1yaWoHgi9AnHqOrmx7JOw8THEzXMSlZGLPO8gsf4e9Bxn29iTASK7ZA0OniV
         FZYg==
X-Gm-Message-State: AO0yUKWbc46c2tM6y4w+nxsNQBbxDM5y0YQu9kc7BhB4KLZWfgx81bUl
        55RKVZ03FjSI8zyxVniCB+s=
X-Google-Smtp-Source: AK7set9i41akd5yXdQqcl/yGbOzAYiYzmbj+ird09ej50uN9MO10IRnAkqTkHdnPFbklxuI5P/WbBQ==
X-Received: by 2002:a17:907:7244:b0:886:323c:dc39 with SMTP id ds4-20020a170907724400b00886323cdc39mr562016ejc.55.1675234351419;
        Tue, 31 Jan 2023 22:52:31 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b008720c458bd4sm9509608eju.3.2023.01.31.22.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 22:52:30 -0800 (PST)
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
Subject: [PATCH 2/4] nvmem: add generic driver for devices with MMIO access
Date:   Wed,  1 Feb 2023 07:47:15 +0100
Message-Id: <20230201064717.18410-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201064717.18410-1-zajec5@gmail.com>
References: <20230201064717.18410-1-zajec5@gmail.com>
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
NVMEM drivers (e.g. MMIO one). Actual NVMEM content handling should go
to layout drivers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/Kconfig  | 10 ++++++
 drivers/nvmem/Makefile |  2 ++
 drivers/nvmem/mmio.c   | 80 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/nvmem/mmio.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 789729ff7e50..9eb5e93f0455 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -170,6 +170,16 @@ config NVMEM_MICROCHIP_OTPC
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
index 442f9a4876a5..2f2bed7cdf24 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -36,6 +36,8 @@ obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
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
index 000000000000..19c8880dc675
--- /dev/null
+++ b/drivers/nvmem/mmio.c
@@ -0,0 +1,80 @@
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
+struct mmio_nvmem {
+	void __iomem *base;
+};
+
+static int mmio_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct mmio_nvmem *priv = context;
+
+	memcpy_fromio(val, priv->base, bytes);
+
+	return 0;
+}
+
+static int mmio_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "mmio-nvmem",
+		.read_only = true,
+		.reg_read = mmio_nvmem_read,
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
+	config.dev = dev;
+	config.size = resource_size(res);
+	config.word_size = sizeof(u8);
+	config.stride = sizeof(u8);
+	config.priv = priv;
+
+	if (!device_property_present(dev, "read-only"))
+		dev_warn(dev, "Writing is not supported yet");
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

