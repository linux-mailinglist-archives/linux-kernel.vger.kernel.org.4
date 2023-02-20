Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C477569D25C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjBTRtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjBTRts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:49:48 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A41BAD5;
        Mon, 20 Feb 2023 09:49:44 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b13so2911609ljf.6;
        Mon, 20 Feb 2023 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhssXeqm+u6yl3pDx1ZAyAVMMEL8ZFFRhcJTQvtxCBI=;
        b=hSUvjOtME4HgSAQKag2+v/BtCpNfKz8hzOD5kqu+liLI1J5DuDG1cxlX9HU0ru5HyJ
         zH8YRWlNlsUQbzDU19zR0XPL+wan25qyhe5DOVV1Hu4xB5v5m0LgViiEvxHh1OWVlQ0O
         NsflWNicEeMBKj5DDTWTAyM+A/O9Q/Fe6tXslTKRq4++1sRvgUZbfSJPpx0IKiHo6oh/
         nVgUmmDbiSZZ4l2V6BOOt/xkAxUgSNcfl+5kfnkD5VZYV5nj4f3SZ/YxU8X+Vx/I9p91
         dIjoEC3tFzjfnYF/Fxnhj7DwnuHVvxzvBwscxKsi3Lnmwmz8r81KxPn3p3k5R8GlR9xE
         o0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhssXeqm+u6yl3pDx1ZAyAVMMEL8ZFFRhcJTQvtxCBI=;
        b=dFB6YB++j0sUXrHdQGr97KOaBt6mxQdwWWBu0CrOwinLZKSK5NMYV1d/xTGZlSj5IB
         8PTvueCe5FDCKZCN++6Kp/CEb43WYjPvffjOBoFgpjrcYXFw0BNCrd1aU+9CjvuRaEwN
         0fl/R82OnKXHAkTtyjrD9UZyjC57z+rRFTqjEJB7FFFbYwMf3L2WvzViefKy/OCLFe1K
         15tm5tsWJP78lD4DK8EBAC+fXcm5zY5sU79Rqg8I/QoSUKm1rGeC4tPDF8mPKj5zKn6S
         dV2rIVYAArrO1HgT+obsBqIMPT6rhQJYwadu0zUlF/I2BR7FaSO8hmtxb9TwgB6r3q3q
         jXag==
X-Gm-Message-State: AO0yUKUdtQpGRoGNMQhPGRnO81EK14+w77S0XSqDObZEHLR4YmXBBRHd
        S26Mz6lHEDdVNLBukDgAyi4=
X-Google-Smtp-Source: AK7set9BeWUmq3qyME/gGxXjti3Uxi1/rFzuL0jJolvPeOuhsOqSX9jChGIUxLIWp+xuC4bWBPMK1Q==
X-Received: by 2002:a05:651c:1505:b0:293:341f:a62 with SMTP id e5-20020a05651c150500b00293341f0a62mr962640ljf.21.1676915382724;
        Mon, 20 Feb 2023 09:49:42 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e9f16000000b0029353491df6sm294695ljk.48.2023.02.20.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:49:42 -0800 (PST)
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
Subject: [PATCH V3 2/2] nvmem: add generic driver for devices with MMIO access
Date:   Mon, 20 Feb 2023 18:49:30 +0100
Message-Id: <20230220174930.7440-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220174930.7440-1-zajec5@gmail.com>
References: <20230220174930.7440-1-zajec5@gmail.com>
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
responsibility for data access. That's why it claims "brcm,nvram"
(conditionally for now).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V3: Support "reg-io-width", basic writing & "brcm,nvram" string
---
 drivers/nvmem/Kconfig  |  10 ++++
 drivers/nvmem/Makefile |   2 +
 drivers/nvmem/mmio.c   | 125 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
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
index 000000000000..e247c943eea2
--- /dev/null
+++ b/drivers/nvmem/mmio.c
@@ -0,0 +1,125 @@
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
+	u32 *dst32;
+	u16 *dst16;
+	u8 *dst8;
+
+	if (priv->io_width && WARN_ON(bytes % priv->io_width))
+		return -EINVAL;
+
+	switch (priv->io_width) {
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
+	default:
+		memcpy_fromio(val, priv->base + offset, bytes);
+	}
+
+	return 0;
+}
+
+static int mmio_nvmem_write(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct mmio_nvmem *priv = context;
+
+	switch (priv->io_width) {
+	case 1:
+	case 2:
+	case 4:
+		return -EOPNOTSUPP;
+	default:
+		memcpy_toio(priv->base + offset, val, bytes);
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
+	if (!device_property_present(dev, "read-only"))
+		config.reg_write = mmio_nvmem_write;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id mmio_nvmem_of_match_table[] = {
+	{ .compatible = "mmio-nvmem", },
+	/* Custom bindings */
+#if !IS_ENABLED(CONFIG_NVMEM_BRCM_NVRAM)
+	{ .compatible = "brcm,nvram", },
+#endif
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

