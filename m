Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C51E6D32A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDAQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 12:46:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433541BC0;
        Sat,  1 Apr 2023 09:46:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ja10so24274380plb.5;
        Sat, 01 Apr 2023 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680367567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGS7uHHPY4zPwy39uB9qQd2tevoGOxfOwbQGl/abX1c=;
        b=M5TkZ/RS0C2W5RKhnUUc0zcBxKrizBs1midgSWmNP63PyPlM9VfzYdSqxbo+OBgMZt
         r1fEK7rC5uyVZdMf7/hvvS0/Qp1EMQ7wKvTrdb80aUyMVKkGHJ7qzO9768tVGAUu0/Q2
         8V9a/OmntzX4PHgfvlMV3sdFHevNJJ8R086rvOdc2WoZ33ngzWedIwY0V/CjjbRwHbFn
         jU0FAkuqgMfK1k45b6oMX+OsTYofz2XNMEVv2vNNdH8OPjF7OKfUXmALRGL3iWreZ3ZM
         98pX1idAwir9zpFOPTZQmRanmgJRC/2rLfCuoDZVfdO7Pwvoy+ZYHUfYPWUfPSMoqdfo
         dNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680367567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGS7uHHPY4zPwy39uB9qQd2tevoGOxfOwbQGl/abX1c=;
        b=rANkF4Rnixfa/ChirMWM4n+aIv8SvT0hm3cattqCOOQuXRaWJrwAiNhKyA3L/rX8MY
         YHvcNrRz4gWnmrPEjEJdCLQxcJwLYXljFj4VD+dTkpgP+gQzcHljsnU+zEP4DfOKBMXk
         lJokDKtc+5KsERKEO5zuzWzL9HZYLb7714Nle5p0mn+r7I/BfHEFjJ30minDMc/FblTN
         xhU8zBqjwfxXVOk/Yt0HSV+kCYvcBxbBA7YbBdbHYmnVxxyPBQ6rws+XirfcCPjyGI2x
         8Qiq8BhcfEfyWdlHSqg6u6rscr0VxcLgg8sujTp8Txnb92XS0YM4t7nHgmh/QqoqvCkl
         4j/g==
X-Gm-Message-State: AO0yUKV6/tlUqB4e/lnnH5LIA05AHLjrB/+XFlCi8FkH83wUdjniuzAi
        FSYx6lcn/ls6CMBmpna/WdpB/7+BnsK62JDaGew=
X-Google-Smtp-Source: AK7set8L//UR2WRlMRzl3xqm9sRfaY2SJIpMVlvMPtZ9B9Keis6Ck0KvCCwM4ifQtGQ7Eg12mR2Cjg==
X-Received: by 2002:a05:6a20:c2a7:b0:d6:ba0b:c82c with SMTP id bs39-20020a056a20c2a700b000d6ba0bc82cmr27469329pzb.38.1680367567339;
        Sat, 01 Apr 2023 09:46:07 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.203])
        by smtp.gmail.com with ESMTPSA id j12-20020a63e74c000000b00512fbdd8c47sm3404747pgk.45.2023.04.01.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 09:46:06 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] crypto: hisilicon/trng - add support for HiSTB TRNG
Date:   Sun,  2 Apr 2023 00:44:40 +0800
Message-Id: <20230401164448.1393336-1-mmyangfl@gmail.com>
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
v4: do not case to __iomem, as requested
v5: do not use rng->priv at all
 drivers/crypto/hisilicon/Kconfig         |   7 +
 drivers/crypto/hisilicon/Makefile        |   2 +-
 drivers/crypto/hisilicon/trng/Makefile   |   3 +
 drivers/crypto/hisilicon/trng/trng-stb.c | 176 +++++++++++++++++++++++
 4 files changed, 187 insertions(+), 1 deletion(-)
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
index 000000000000..29200a7d3d81
--- /dev/null
+++ b/drivers/crypto/hisilicon/trng/trng-stb.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device driver for True RNG in HiSTB SoCs
+ *
+ * Copyright (c) 2023 David Yang
+ */
+
+#include <crypto/internal/rng.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
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
+struct histb_trng_priv {
+	struct hwrng rng;
+	void __iomem *base;
+};
+
+/*
+ * Observed:
+ * depth = 1 -> ~1ms
+ * depth = 255 -> ~16ms
+ */
+static int histb_trng_wait(void __iomem *base)
+{
+	u32 val;
+
+	return readl_relaxed_poll_timeout(base + HISTB_TRNG_STAT, val,
+					  val & DATA_COUNT, 1000, 30 * 1000);
+}
+
+static void histb_trng_init(void __iomem *base, unsigned int depth)
+{
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
+	struct histb_trng_priv *priv = container_of(rng, typeof(*priv), rng);
+	void __iomem *base = priv->base;
+
+	for (int i = 0; i < max; i += sizeof(u32)) {
+		if (!(readl_relaxed(base + HISTB_TRNG_STAT) & DATA_COUNT)) {
+			if (!wait)
+				return i;
+			if (histb_trng_wait(base)) {
+				pr_err("failed to generate random number, generated %d\n",
+				       i);
+				return i ? i : -ETIMEDOUT;
+			}
+		}
+		*(u32 *) (data + i) = readl_relaxed(base + HISTB_TRNG_NUMBER);
+	}
+
+	return max;
+}
+
+static unsigned int histb_trng_get_depth(void __iomem *base)
+{
+	return (readl_relaxed(base + HISTB_TRNG_CTRL) & POST_PROCESS_DEPTH) >> 8;
+}
+
+static ssize_t
+depth_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct histb_trng_priv *priv = dev_get_drvdata(dev);
+	void __iomem *base = priv->base;
+
+	return sprintf(buf, "%d\n", histb_trng_get_depth(base));
+}
+
+static ssize_t
+depth_store(struct device *dev, struct device_attribute *attr,
+	    const char *buf, size_t count)
+{
+	struct histb_trng_priv *priv = dev_get_drvdata(dev);
+	void __iomem *base = priv->base;
+	unsigned int depth;
+
+	if (kstrtouint(buf, 0, &depth))
+		return -ERANGE;
+
+	histb_trng_init(base, depth);
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
+	struct histb_trng_priv *priv;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return -ENOMEM;
+
+	histb_trng_init(base, 144);
+	if (histb_trng_wait(base)) {
+		dev_err(dev, "cannot bring up device\n");
+		return -ENODEV;
+	}
+
+	priv->base = base;
+	priv->rng.name = pdev->name;
+	priv->rng.read = histb_trng_read;
+	ret = devm_hwrng_register(dev, &priv->rng);
+	if (ret) {
+		dev_err(dev, "failed to register hwrng: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	dev_set_drvdata(dev, priv);
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
+		.of_match_table = histb_trng_of_match,
+		.dev_groups = histb_trng_groups,
+	},
+};
+
+module_platform_driver(histb_trng_driver);
+
+MODULE_DESCRIPTION("HiSTB True RNG");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-- 
2.39.2

