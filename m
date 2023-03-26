Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998C46C92A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCZFfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 01:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCZFfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 01:35:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AAAA5F5;
        Sat, 25 Mar 2023 22:35:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so5598834pjz.1;
        Sat, 25 Mar 2023 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679808908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+khonTWL58OUZUKKdpO+61yxaCEo0mE/6suCgfy7HI0=;
        b=kDqbJXpACtGq/sBGO+1dmT3492ANjYsmoF5ewMyRkGLbMxKoIb8IzqhJDOwW8/YAU3
         xsRWr809GJrZBLTzouJjoQu0Mv9huEifm4MXwxx7fRqRoVzfp/cBCDejqfMq0H/CgOBu
         bNcmbM9k7qUUMRrIt8P6FCClP56IVIvqkwDnCGTo0EdyTehH2RiJJy/139n80gowaM72
         cQXnKblbSHFyzhK9VJfufWGZ8B8sGuFxl93JfEJPOzEfX959/RPXRQCH51ya5Hdu+gW2
         g1UUYsJOad0EvQz5+AD+LM2cGelvIKIb/SYvKDcUj+E5b4GZPMnoo1WPpXo9Yh0zvkh/
         FONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679808908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+khonTWL58OUZUKKdpO+61yxaCEo0mE/6suCgfy7HI0=;
        b=YVedjnfqSG/lgQta9Qkel6ArHtwMFBjS/KEie3F4GUGkXKzIaHxauO5qmrKB/w45w+
         R9OWeGE/Ln8O/DjiKcqLuNNOow3w2FkErWpdooyoXKkGO2wIKYmi1c3OL9km1zD9tpLf
         omP+2D/ibimM0Uwp4Enhhrqewl2sVMw0i5a7FMFpz4w32QaG8IE6Sq5MNzsfaBIOmRV9
         5piXJHZtIMjaRfCE9bbEx1PmT9C656c28ZUA8lbR4aW+oKSWkoSqyVyPkK2/FPDXnE0f
         o9vjSgOx/AX61p8nYywzIgCrPhjpIa61Ma7romsbPkFwryy9TAnJG7FLHwon8ZLaJopw
         qjVA==
X-Gm-Message-State: AAQBX9cPByresXociDGUdzz6zuRbBsMUCnLHqt5U02AXWL19I4LxRiTs
        7l5TB7kDRhtal9+9yGZNR8ukGGh4iYpQOeh2cDA=
X-Google-Smtp-Source: AKy350aektzCLVMOFIz1Ow9xJbNGzKqeTPDxaaMEOpaZDULH4/ieRe2S7wt1yiHNJvgDC90JItvrtg==
X-Received: by 2002:a17:903:4304:b0:19f:1c64:c9d8 with SMTP id jz4-20020a170903430400b0019f1c64c9d8mr6441948plb.14.1679808908601;
        Sat, 25 Mar 2023 22:35:08 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id p11-20020a170903248b00b0019ac7319ed1sm16750184plw.126.2023.03.25.22.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:35:08 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: hisilicon/trng - add support for HiSTB TRNG
Date:   Sun, 26 Mar 2023 13:34:41 +0800
Message-Id: <20230326053448.299008-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSTB TRNG are found on some HiSilicon STB SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2: fix typo
v3: add option for post process depth, adjust timeout
 drivers/crypto/hisilicon/Kconfig         |   7 +
 drivers/crypto/hisilicon/Makefile        |   2 +-
 drivers/crypto/hisilicon/trng/Makefile   |   3 +
 drivers/crypto/hisilicon/trng/trng-stb.c | 171 +++++++++++++++++++++++
 4 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/hisilicon/trng/trng-stb.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 4137a8bf131f..e8690c223584 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -82,3 +82,10 @@ config CRYPTO_DEV_HISI_TRNG
 	select CRYPTO_RNG
 	help
 	  Support for HiSilicon TRNG Driver.
+
+config CRYPTO_DEV_HISTB_TRNG
+	tristate "Support for HiSTB TRNG Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	select HW_RANDOM
+	help
+	  Support for HiSTB TRNG Driver.
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 8595a5a5d228..fc51e0edec69 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
 hisi_qm-objs = qm.o sgl.o debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
-obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += trng/
+obj-y += trng/
diff --git a/drivers/crypto/hisilicon/trng/Makefile b/drivers/crypto/hisilicon/trng/Makefile
index d909079f351c..cf20b057c66b 100644
--- a/drivers/crypto/hisilicon/trng/Makefile
+++ b/drivers/crypto/hisilicon/trng/Makefile
@@ -1,2 +1,5 @@
 obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += hisi-trng-v2.o
 hisi-trng-v2-objs = trng.o
+
+obj-$(CONFIG_CRYPTO_DEV_HISTB_TRNG) += histb-trng.o
+histb-trng-objs += trng-stb.o
diff --git a/drivers/crypto/hisilicon/trng/trng-stb.c b/drivers/crypto/hisilicon/trng/trng-stb.c
new file mode 100644
index 000000000000..44ee071fd348
--- /dev/null
+++ b/drivers/crypto/hisilicon/trng/trng-stb.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device driver for True RNG in HiSTB SoCs
+ *
+ * Copyright (c) 2023 David Yang
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/timekeeping.h>
+
+#define HISTB_TRNG_CTRL		0x0
+#define  RNG_SOURCE			GENMASK(1, 0)
+#define  DROP_ENABLE			BIT(5)
+#define  POST_PROCESS_ENABLE		BIT(7)
+#define  POST_PROCESS_DEPTH		GENMASK(15, 8)
+#define HISTB_TRNG_NUMBER	0x4
+#define HISTB_TRNG_STAT		0x8
+#define  DATA_COUNT			GENMASK(2, 0)	/* max 4 */
+
+/*
+ * Observed:
+ * depth = 1 -> ~1ms
+ * depth = 255 -> ~16ms
+ */
+static int histb_trng_wait(struct hwrng *rng)
+{
+	void __iomem *base = (void __iomem *) rng->priv;
+	u32 val;
+
+	return readl_relaxed_poll_timeout(base + HISTB_TRNG_STAT,
+					  val, val & DATA_COUNT, 1000,
+					  30 * 1000);
+}
+
+static void histb_trng_init(struct hwrng *rng, unsigned int depth)
+{
+	void __iomem *base = (void __iomem *) rng->priv;
+	u32 val;
+
+	val = readl_relaxed(base + HISTB_TRNG_CTRL);
+
+	val &= ~RNG_SOURCE;
+	val |= 2;
+
+	val &= ~POST_PROCESS_DEPTH;
+	val |= min(depth, 0xffu) << 8;
+
+	val |= POST_PROCESS_ENABLE;
+	val |= DROP_ENABLE;
+
+	writel_relaxed(val, base + HISTB_TRNG_CTRL);
+}
+
+static int histb_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	void __iomem *base = (void __iomem *) rng->priv;
+	size_t i;
+
+	for (i = 0; i < max; i += sizeof(u32)) {
+		if (!(readl_relaxed(base + HISTB_TRNG_STAT) & DATA_COUNT)) {
+			if (!wait)
+				break;
+			if (histb_trng_wait(rng)) {
+				pr_err("failed to generate random number, generated %zu\n",
+				       i);
+				if (i)
+					break;
+				return -ETIMEDOUT;
+			}
+		}
+		*(u32 *) (data + i) = readl_relaxed(base + HISTB_TRNG_NUMBER);
+	}
+
+	return i;
+}
+
+static unsigned int histb_trng_get_depth(struct hwrng *rng)
+{
+	void __iomem *base = (void __iomem *) rng->priv;
+	u32 val = readl_relaxed(base + HISTB_TRNG_CTRL);
+
+	return (val & POST_PROCESS_DEPTH) >> 8;
+}
+
+static ssize_t
+depth_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hwrng *rng = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", histb_trng_get_depth(rng));
+}
+
+static ssize_t
+depth_store(struct device *dev, struct device_attribute *attr,
+	    const char *buf, size_t count)
+{
+	struct hwrng *rng = dev_get_drvdata(dev);
+	unsigned int depth;
+
+	if (kstrtouint(buf, 0, &depth))
+		return -ERANGE;
+
+	histb_trng_init(rng, depth);
+	return count;
+}
+
+static DEVICE_ATTR_RW(depth);
+
+static struct attribute *histb_trng_attrs[] = {
+	&dev_attr_depth.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(histb_trng);
+
+static int histb_trng_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hwrng *rng;
+	int ret;
+
+	rng = devm_kzalloc(dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	rng->priv = (unsigned long) devm_platform_ioremap_resource(pdev, 0);
+	if (rng->priv <= 0)
+		return -ENOMEM;
+
+	histb_trng_init(rng, 144);
+	if (histb_trng_wait(rng))
+		return -ENODEV;
+
+	rng->name = KBUILD_MODNAME;
+	rng->read = histb_trng_read;
+
+	ret = devm_hwrng_register(dev, rng);
+	if (ret) {
+		dev_err(dev, "failed to register %s (%d)\n", rng->name, ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, rng);
+	dev_set_drvdata(dev, rng);
+	return 0;
+}
+
+static const struct of_device_id histb_trng_of_match[] = {
+	{ .compatible = "hisilicon,histb-trng", },
+	{ }
+};
+
+static struct platform_driver histb_trng_driver = {
+	.probe = histb_trng_probe,
+	.driver = {
+		.name = "histb-trng",
+		.of_match_table = of_match_ptr(histb_trng_of_match),
+		.dev_groups = histb_trng_groups,
+	},
+};
+
+module_platform_driver(histb_trng_driver);
+
+MODULE_DESCRIPTION("HiSTB True RNG");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.39.2

