Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D060C6EAFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjDURAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjDUQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:59:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FBC167F4;
        Fri, 21 Apr 2023 09:59:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b73203e0aso15489382b3a.1;
        Fri, 21 Apr 2023 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682096313; x=1684688313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcSR9M+yhOEYbwlfXqz2EsTpkJwGjUgTB7vblZ3wbJM=;
        b=U2znz3jBcmMVdjGF7EGBqpYpxXo0d73vM2H4h5thAUd/ku+MixwuzzQm/AjOGquMrb
         nxV0ZDqx+sdpvtLDcprbQRrxzbL87VULnN7OJ1g1ETJnuAIZqSvL9LvQp9e5ihJQ6ZqY
         S3RxqNMN7AXW6g/2I9RyCWoWe1WnhuI/y446jP2sjLUkcE6IZky+or8IYCd1CDUw2Gkr
         RsloJpUatKIUuAyaEYRYNoNsSKEixcpQIsKnKckrMazVKHzNtvd5j4x3pl9uHW3R1uvK
         YdQ4/7NE6SPtP7Y1wSweY4T3jO7vcqgPLrZjZdGn3yCjF2gCXZZNpyfjKsz4j6jrufPP
         mo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682096313; x=1684688313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcSR9M+yhOEYbwlfXqz2EsTpkJwGjUgTB7vblZ3wbJM=;
        b=BTPOyMvfm6hZEwnIXcX8jvRPhxS5zjZUXzITRnnEZbKkuhyMAxRMojdDt14P+YQQsq
         LEJo8FyVgwvz4iILWFTk6gnk03aTtzci0c477YyFT45ZLH3ScwfwNbD8woPwLSMi7A9d
         0d8Y1+MBJ270r4kMJMbdcodSKQEcX8sfd92aDkCk/8EPrPW7cdiVZ/6HLR+yq7tPOOI8
         co5SkefVRVsr/uEzhQULhhgPKVnmGVZK/VYnTqxaLhf1HftzdIXe3zAupyjXc1Rrgrca
         j9N5pqgKrTfL3S0C0aZwRRFt7tcclO+h+ZENSkzkYMlkUKnIr4vvn9h239oaS+h9z4pK
         NMfw==
X-Gm-Message-State: AAQBX9dXOXoq6/1FmMgrEeYfl/mU5cJS6sugpflnjnhTccA7Z2jJqoJv
        LDsptT9NwTHb9r18twpyA1rRtVpjAbdffIDI
X-Google-Smtp-Source: AKy350a5SGyJ9h+pmjd2vhAKc3j4q3iHL9NdBozt5uI5QjCoFFnd+4BS0TzqqWpg1teI7Yp1DXLbPg==
X-Received: by 2002:a05:6a20:938a:b0:f2:1141:9d20 with SMTP id x10-20020a056a20938a00b000f211419d20mr6250661pzh.24.1682096312454;
        Fri, 21 Apr 2023 09:58:32 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id i189-20020a62c1c6000000b005a8b28c644esm3237444pfg.4.2023.04.21.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:58:31 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>,
        William Zhang <william.zhang@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwrng: histb - Move driver to drivers/char/hw_random/histb-rng.c
Date:   Sat, 22 Apr 2023 00:56:49 +0800
Message-Id: <20230421165700.1481002-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move to drivers/char/hw_random since histb-(t)rng does not provide
cryptography pseudo rng.

histb-rng is pretty like hisi-rng, but after investigation, we confirm
there is no RNG_PHY_SEED register on histb-rng so a separate driver is
needed.

Still we rename relevant function names to match those in hisi-rng.

Link: https://lore.kernel.org/r/20230401164448.1393336-1-mmyangfl@gmail.com
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2: drop the dependency on HW_RANDOM
 drivers/char/hw_random/Kconfig                | 11 +++
 drivers/char/hw_random/Makefile               |  1 +
 .../trng-stb.c => char/hw_random/histb-rng.c} | 83 +++++++++----------
 drivers/crypto/hisilicon/Kconfig              |  7 --
 drivers/crypto/hisilicon/Makefile             |  2 +-
 drivers/crypto/hisilicon/trng/Makefile        |  3 -
 6 files changed, 53 insertions(+), 54 deletions(-)
 rename drivers/{crypto/hisilicon/trng/trng-stb.c => char/hw_random/histb-rng.c} (53%)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 4fdf07ae3c54..c92f146ee89a 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -335,6 +335,17 @@ config HW_RANDOM_HISI
 
 	  If unsure, say Y.
 
+config HW_RANDOM_HISTB
+	tristate "Hisilicon STB Random Number Generator support"
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
+	help
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Hisilicon Hi37xx SoC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called histb-rng.
+
 config HW_RANDOM_ST
 	tristate "ST Microelectronics HW Random Number Generator support"
 	depends on HW_RANDOM && ARCH_STI
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 09bde4a0f971..32549a1186dc 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_HW_RANDOM_NOMADIK) += nomadik-rng.o
 obj-$(CONFIG_HW_RANDOM_PSERIES) += pseries-rng.o
 obj-$(CONFIG_HW_RANDOM_POWERNV) += powernv-rng.o
 obj-$(CONFIG_HW_RANDOM_HISI)	+= hisi-rng.o
+obj-$(CONFIG_HW_RANDOM_HISTB) += histb-rng.o
 obj-$(CONFIG_HW_RANDOM_BCM2835) += bcm2835-rng.o
 obj-$(CONFIG_HW_RANDOM_IPROC_RNG200) += iproc-rng200.o
 obj-$(CONFIG_HW_RANDOM_ST) += st-rng.o
diff --git a/drivers/crypto/hisilicon/trng/trng-stb.c b/drivers/char/hw_random/histb-rng.c
similarity index 53%
rename from drivers/crypto/hisilicon/trng/trng-stb.c
rename to drivers/char/hw_random/histb-rng.c
index 29200a7d3d81..f652e1135e4b 100644
--- a/drivers/crypto/hisilicon/trng/trng-stb.c
+++ b/drivers/char/hw_random/histb-rng.c
@@ -1,31 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Device driver for True RNG in HiSTB SoCs
- *
  * Copyright (c) 2023 David Yang
  */
 
-#include <crypto/internal/rng.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
-#define HISTB_TRNG_CTRL		0x0
+#define RNG_CTRL		0x0
 #define  RNG_SOURCE			GENMASK(1, 0)
 #define  DROP_ENABLE			BIT(5)
 #define  POST_PROCESS_ENABLE		BIT(7)
 #define  POST_PROCESS_DEPTH		GENMASK(15, 8)
-#define HISTB_TRNG_NUMBER	0x4
-#define HISTB_TRNG_STAT		0x8
+#define RNG_NUMBER		0x4
+#define RNG_STAT		0x8
 #define  DATA_COUNT			GENMASK(2, 0)	/* max 4 */
 
-struct histb_trng_priv {
+struct histb_rng_priv {
 	struct hwrng rng;
 	void __iomem *base;
 };
@@ -35,19 +31,19 @@ struct histb_trng_priv {
  * depth = 1 -> ~1ms
  * depth = 255 -> ~16ms
  */
-static int histb_trng_wait(void __iomem *base)
+static int histb_rng_wait(void __iomem *base)
 {
 	u32 val;
 
-	return readl_relaxed_poll_timeout(base + HISTB_TRNG_STAT, val,
+	return readl_relaxed_poll_timeout(base + RNG_STAT, val,
 					  val & DATA_COUNT, 1000, 30 * 1000);
 }
 
-static void histb_trng_init(void __iomem *base, unsigned int depth)
+static void histb_rng_init(void __iomem *base, unsigned int depth)
 {
 	u32 val;
 
-	val = readl_relaxed(base + HISTB_TRNG_CTRL);
+	val = readl_relaxed(base + RNG_CTRL);
 
 	val &= ~RNG_SOURCE;
 	val |= 2;
@@ -58,72 +54,72 @@ static void histb_trng_init(void __iomem *base, unsigned int depth)
 	val |= POST_PROCESS_ENABLE;
 	val |= DROP_ENABLE;
 
-	writel_relaxed(val, base + HISTB_TRNG_CTRL);
+	writel_relaxed(val, base + RNG_CTRL);
 }
 
-static int histb_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+static int histb_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
-	struct histb_trng_priv *priv = container_of(rng, typeof(*priv), rng);
+	struct histb_rng_priv *priv = container_of(rng, typeof(*priv), rng);
 	void __iomem *base = priv->base;
 
 	for (int i = 0; i < max; i += sizeof(u32)) {
-		if (!(readl_relaxed(base + HISTB_TRNG_STAT) & DATA_COUNT)) {
+		if (!(readl_relaxed(base + RNG_STAT) & DATA_COUNT)) {
 			if (!wait)
 				return i;
-			if (histb_trng_wait(base)) {
+			if (histb_rng_wait(base)) {
 				pr_err("failed to generate random number, generated %d\n",
 				       i);
 				return i ? i : -ETIMEDOUT;
 			}
 		}
-		*(u32 *) (data + i) = readl_relaxed(base + HISTB_TRNG_NUMBER);
+		*(u32 *) (data + i) = readl_relaxed(base + RNG_NUMBER);
 	}
 
 	return max;
 }
 
-static unsigned int histb_trng_get_depth(void __iomem *base)
+static unsigned int histb_rng_get_depth(void __iomem *base)
 {
-	return (readl_relaxed(base + HISTB_TRNG_CTRL) & POST_PROCESS_DEPTH) >> 8;
+	return (readl_relaxed(base + RNG_CTRL) & POST_PROCESS_DEPTH) >> 8;
 }
 
 static ssize_t
 depth_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct histb_trng_priv *priv = dev_get_drvdata(dev);
+	struct histb_rng_priv *priv = dev_get_drvdata(dev);
 	void __iomem *base = priv->base;
 
-	return sprintf(buf, "%d\n", histb_trng_get_depth(base));
+	return sprintf(buf, "%d\n", histb_rng_get_depth(base));
 }
 
 static ssize_t
 depth_store(struct device *dev, struct device_attribute *attr,
 	    const char *buf, size_t count)
 {
-	struct histb_trng_priv *priv = dev_get_drvdata(dev);
+	struct histb_rng_priv *priv = dev_get_drvdata(dev);
 	void __iomem *base = priv->base;
 	unsigned int depth;
 
 	if (kstrtouint(buf, 0, &depth))
 		return -ERANGE;
 
-	histb_trng_init(base, depth);
+	histb_rng_init(base, depth);
 	return count;
 }
 
 static DEVICE_ATTR_RW(depth);
 
-static struct attribute *histb_trng_attrs[] = {
+static struct attribute *histb_rng_attrs[] = {
 	&dev_attr_depth.attr,
 	NULL,
 };
 
-ATTRIBUTE_GROUPS(histb_trng);
+ATTRIBUTE_GROUPS(histb_rng);
 
-static int histb_trng_probe(struct platform_device *pdev)
+static int histb_rng_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct histb_trng_priv *priv;
+	struct histb_rng_priv *priv;
 	void __iomem *base;
 	int ret;
 
@@ -133,17 +129,17 @@ static int histb_trng_probe(struct platform_device *pdev)
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
-		return -ENOMEM;
+		return PTR_ERR(base);
 
-	histb_trng_init(base, 144);
-	if (histb_trng_wait(base)) {
+	histb_rng_init(base, 144);
+	if (histb_rng_wait(base)) {
 		dev_err(dev, "cannot bring up device\n");
 		return -ENODEV;
 	}
 
 	priv->base = base;
 	priv->rng.name = pdev->name;
-	priv->rng.read = histb_trng_read;
+	priv->rng.read = histb_rng_read;
 	ret = devm_hwrng_register(dev, &priv->rng);
 	if (ret) {
 		dev_err(dev, "failed to register hwrng: %d\n", ret);
@@ -155,22 +151,23 @@ static int histb_trng_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id histb_trng_of_match[] = {
-	{ .compatible = "hisilicon,histb-trng", },
+static const struct of_device_id histb_rng_of_match[] = {
+	{ .compatible = "hisilicon,histb-rng", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, histb_rng_of_match);
 
-static struct platform_driver histb_trng_driver = {
-	.probe = histb_trng_probe,
+static struct platform_driver histb_rng_driver = {
+	.probe = histb_rng_probe,
 	.driver = {
-		.name = "histb-trng",
-		.of_match_table = histb_trng_of_match,
-		.dev_groups = histb_trng_groups,
+		.name = "histb-rng",
+		.of_match_table = histb_rng_of_match,
+		.dev_groups = histb_rng_groups,
 	},
 };
 
-module_platform_driver(histb_trng_driver);
+module_platform_driver(histb_rng_driver);
 
-MODULE_DESCRIPTION("HiSTB True RNG");
+MODULE_DESCRIPTION("Hisilicon STB random number generator driver");
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index e8690c223584..4137a8bf131f 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -82,10 +82,3 @@ config CRYPTO_DEV_HISI_TRNG
 	select CRYPTO_RNG
 	help
 	  Support for HiSilicon TRNG Driver.
-
-config CRYPTO_DEV_HISTB_TRNG
-	tristate "Support for HiSTB TRNG Driver"
-	depends on ARCH_HISI || COMPILE_TEST
-	select HW_RANDOM
-	help
-	  Support for HiSTB TRNG Driver.
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index fc51e0edec69..8595a5a5d228 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
 hisi_qm-objs = qm.o sgl.o debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
-obj-y += trng/
+obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += trng/
diff --git a/drivers/crypto/hisilicon/trng/Makefile b/drivers/crypto/hisilicon/trng/Makefile
index cf20b057c66b..d909079f351c 100644
--- a/drivers/crypto/hisilicon/trng/Makefile
+++ b/drivers/crypto/hisilicon/trng/Makefile
@@ -1,5 +1,2 @@
 obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += hisi-trng-v2.o
 hisi-trng-v2-objs = trng.o
-
-obj-$(CONFIG_CRYPTO_DEV_HISTB_TRNG) += histb-trng.o
-histb-trng-objs += trng-stb.o
-- 
2.39.2

