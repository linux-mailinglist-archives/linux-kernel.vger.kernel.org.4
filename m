Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB02685FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBAGwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBAGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:52:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4DDA274;
        Tue, 31 Jan 2023 22:52:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bk15so48420136ejb.9;
        Tue, 31 Jan 2023 22:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fPObB622ZHAsw7bG4ZtmD1WDgZDX6KJYI3QC9H/s34=;
        b=ljP+fzclIJjlHMmWQaVJkSQr2M+/sTDBmC+RbHmj5xcO8zNyuRjC8NiPadP5CH96UW
         hwstXaExliDwmXvG1q/3NxIPr7E+9PQRx9y/kd0XAoZiMRNDf63pdddE1YvA+jj0pEaR
         qsTyR8XSWJELU4ZcN2936SYxGUbKHcq8gl+mj0yvFtNQD0PW6Jti18z/hGicmmlcdNdM
         77B9IlMXefaRaJSkGlyMHK4J41FUZX+ggKo+nU9VziXYgfXWlkxN2h0llCnQndKl36vV
         sT47hAfA9Q+cNGgDxchrI1Pz1bK2pG6isyveGc04kdPYWNfuGjsGRrvz+RKF7s2g4iQ0
         NzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fPObB622ZHAsw7bG4ZtmD1WDgZDX6KJYI3QC9H/s34=;
        b=ge5REmIvnQeRS4JQ9/sM4MLugD/5d5ax7LokELoQ6LGLugs/rM6zDoXLxv/QcFZycC
         6lJTPHgLZqe45gSbmiqdm1wM/gRjtmbB6PE8PnzvFt7NJPIL6QtMQJ7VZV1iIR4s1P6q
         4XwKMSD+AayyVX247PQkgssiKlp/ivWuHxELg6LhH3ttzqyqWKFZRXbLEh/l/+6zUAWA
         HrovNJ7KRw7HE6+534Y6LPELdS9OHCjC8A2WTrUMLyj/+5XgfC1NiIhdIKLwdNEG0IW2
         qBBVKzp+iuB8D6c1+gz1t3wBvuufpcPy78xMdj02m0LbLFI+bopSDcYfUCQDAUc+h0AA
         RGuw==
X-Gm-Message-State: AO0yUKWkvhBkDajaq3C34GIBht94Unjw7d1NNUyJd30uZYP8xDL4CSSF
        ZMShB4BDapakYYNYYMJL1Xo=
X-Google-Smtp-Source: AK7set9xqKbGnzuL5L4PM1F4eU43RdssaMCIk3qlYJ+LGtln8nEmEMKDbshH9HM1j4tonfQ/w2p3Ow==
X-Received: by 2002:a17:907:9909:b0:887:9a7f:4326 with SMTP id ka9-20020a170907990900b008879a7f4326mr1108784ejc.8.1675234356056;
        Tue, 31 Jan 2023 22:52:36 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b008720c458bd4sm9509608eju.3.2023.01.31.22.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 22:52:35 -0800 (PST)
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
Subject: [PATCH 4/4] nvmem: uniphier-efuse: replace driver with a generic MMIO one
Date:   Wed,  1 Feb 2023 07:47:17 +0100
Message-Id: <20230201064717.18410-5-zajec5@gmail.com>
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

UniPhier eFuse uses a simple MMIO that can be handled with a generic
driver. Replace this driver to avoid code duplication.

Keep Kconfig symbol for a release or two to help with "make oldconfig".

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/Kconfig          |  7 ++-
 drivers/nvmem/Makefile         |  2 -
 drivers/nvmem/mmio.c           |  1 +
 drivers/nvmem/uniphier-efuse.c | 78 ----------------------------------
 4 files changed, 4 insertions(+), 84 deletions(-)
 delete mode 100644 drivers/nvmem/uniphier-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 4d652c7382a6..d65950da39b0 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -359,12 +359,11 @@ config NVMEM_UNIPHIER_EFUSE
 	tristate "UniPhier SoCs eFuse support"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on HAS_IOMEM
+	select NVMEM_MMIO
 	help
-	  This is a simple driver to dump specified values of UniPhier SoC
-	  from eFuse.
+	  This driver has been replaced by a generic MMIO implementation.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-uniphier-efuse.
+	  Update your config as this symbol will be dropped in the next release.
 
 config NVMEM_VF610_OCOTP
 	tristate "VF610 SoC OCOTP support"
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 7a8e29ea408e..70dd1154c832 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -67,8 +67,6 @@ obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y			:= sunxi_sid.o
-obj-$(CONFIG_NVMEM_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
-nvmem-uniphier-efuse-y			:= uniphier-efuse.o
 obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y			:= vf610-ocotp.o
 obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
diff --git a/drivers/nvmem/mmio.c b/drivers/nvmem/mmio.c
index 253ade72e0c3..f44ff2a56c56 100644
--- a/drivers/nvmem/mmio.c
+++ b/drivers/nvmem/mmio.c
@@ -60,6 +60,7 @@ static const struct of_device_id mmio_nvmem_of_match_table[] = {
 	/* Custom bindings that were introduced before the mmio one */
 	{ .compatible = "mediatek,mt8173-efuse", },
 	{ .compatible = "mediatek,efuse", },
+	{ .compatible = "socionext,uniphier-efuse", },
 	{},
 };
 
diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
deleted file mode 100644
index aca910b3b6f8..000000000000
--- a/drivers/nvmem/uniphier-efuse.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * UniPhier eFuse driver
- *
- * Copyright (C) 2017 Socionext Inc.
- */
-
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/nvmem-provider.h>
-#include <linux/platform_device.h>
-
-struct uniphier_efuse_priv {
-	void __iomem *base;
-};
-
-static int uniphier_reg_read(void *context,
-			     unsigned int reg, void *_val, size_t bytes)
-{
-	struct uniphier_efuse_priv *priv = context;
-	u8 *val = _val;
-	int offs;
-
-	for (offs = 0; offs < bytes; offs += sizeof(u8))
-		*val++ = readb(priv->base + reg + offs);
-
-	return 0;
-}
-
-static int uniphier_efuse_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-	struct nvmem_device *nvmem;
-	struct nvmem_config econfig = {};
-	struct uniphier_efuse_priv *priv;
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	econfig.stride = 1;
-	econfig.word_size = 1;
-	econfig.read_only = true;
-	econfig.reg_read = uniphier_reg_read;
-	econfig.size = resource_size(res);
-	econfig.priv = priv;
-	econfig.dev = dev;
-	nvmem = devm_nvmem_register(dev, &econfig);
-
-	return PTR_ERR_OR_ZERO(nvmem);
-}
-
-static const struct of_device_id uniphier_efuse_of_match[] = {
-	{ .compatible = "socionext,uniphier-efuse",},
-	{/* sentinel */},
-};
-MODULE_DEVICE_TABLE(of, uniphier_efuse_of_match);
-
-static struct platform_driver uniphier_efuse_driver = {
-	.probe = uniphier_efuse_probe,
-	.driver = {
-		.name = "uniphier-efuse",
-		.of_match_table = uniphier_efuse_of_match,
-	},
-};
-module_platform_driver(uniphier_efuse_driver);
-
-MODULE_AUTHOR("Keiji Hayashibara <hayashibara.keiji@socionext.com>");
-MODULE_DESCRIPTION("UniPhier eFuse driver");
-MODULE_LICENSE("GPL v2");
-- 
2.34.1

