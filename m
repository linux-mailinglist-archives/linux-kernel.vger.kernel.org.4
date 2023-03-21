Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5AD6C3DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCUWdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCUWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:33:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9844FAB1;
        Tue, 21 Mar 2023 15:33:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so17933399pjp.1;
        Tue, 21 Mar 2023 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679438018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tX8xvAVFZKTqI7vUXDNrblrC3elmwRfPb1uVZ3LjE7w=;
        b=idwjHABsJoQhOKjchQUjb9zysZvH+mmxjBplmk1ZgOJxoMeEVaW6aDY6/ZbIkS8HaK
         y0P3tqfKo/mYr0iWJbOPnAwFGm6eNpC0u7apGEHSQnK++avs7U7mRIJX14RpI5jUwOws
         TmubWhnDh6b1z0qs4japlZpSBsR1mAfbRuGGPrw16XMbkRocJJM+ssqLO1GqsZhqvHks
         0WmU0OqVfc11XX7xWC4Wk3P3aeIyKKMCnVG2Qbmf0L7UvrhtssdYNSbmgzLkPTq3ql8Q
         wTgptr6ICFMA4c9SQL/5u48gWzYlOvYB2b6McWOHvafH38NQzh5OiqI5jaEuO5Rj6Bvn
         O+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX8xvAVFZKTqI7vUXDNrblrC3elmwRfPb1uVZ3LjE7w=;
        b=C39Hmm5qAFS4riYlpnFcxtqGfwmYZa5GrPJZ9XLkBmrs3X1Yn63Fc5v6L+doo/Ud4K
         QVxbA1cZWurGbj2Jvb1CrCNJhaPzAz0Xrv2jRwV8zvdPwPNEKgBJfP/7fe6QiD0xf+9s
         BGMwFSTgx8gmkVBiEZ/Jyl4a4lcopMK+9RtlxFws+4lXLotEHRa7F3gf1A+p+ViGS/BE
         H6qsLmNLnxKG4k2hu1eFzVAcz6K21THST7lBq6hVbiJfVdjx9Zq4WOVW8ajBp6kmV76y
         ei+oFCYOKF6JgXE61NYwbSBGcPpluHwesRlS2ulbAybo955Mx6fOYpcKcgyvSgZBFecj
         iXGQ==
X-Gm-Message-State: AO0yUKUFHCO2jdMpX2sFLZC0MWvS9IBp9DuiC/lZ7IaGuI/85pwBNUe/
        9Y5VQAHjEF8fkQVnIu7DHmk=
X-Google-Smtp-Source: AK7set+rNYXFr/gXYLWPjvNlu5pTXTNQhJzXLhDRtdtUse1WQU06n4rU5ndF4A8bHEQHccTVWSpHPA==
X-Received: by 2002:a17:90b:1c04:b0:23f:48b9:266d with SMTP id oc4-20020a17090b1c0400b0023f48b9266dmr1273655pjb.21.1679438017678;
        Tue, 21 Mar 2023 15:33:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b0019cbec6c17bsm9222982plg.190.2023.03.21.15.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:33:37 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH v2] crypto: hisilicon/trng - add support for HiSTB TRNG
Date:   Wed, 22 Mar 2023 06:33:26 +0800
Message-Id: <20230321223328.1908817-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSTB TRNG are found on some HiSilicon STB SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2: fix typo
 drivers/crypto/hisilicon/Kconfig         |   7 ++
 drivers/crypto/hisilicon/Makefile        |   2 +-
 drivers/crypto/hisilicon/trng/Makefile   |   3 +
 drivers/crypto/hisilicon/trng/trng-stb.c | 127 +++++++++++++++++++++++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/hisilicon/trng/trng-stb.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 4137a8bf1..e8690c223 100644
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
index 8595a5a5d..fc51e0ede 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
 hisi_qm-objs = qm.o sgl.o debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
-obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += trng/
+obj-y += trng/
diff --git a/drivers/crypto/hisilicon/trng/Makefile b/drivers/crypto/hisilicon/trng/Makefile
index d909079f3..cf20b057c 100644
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
index 000000000..6a4e92ab2
--- /dev/null
+++ b/drivers/crypto/hisilicon/trng/trng-stb.c
@@ -0,0 +1,127 @@
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
+
+#define HISTB_TRNG_CTRL		0x0
+#define HISTB_TRNG_NUMBER	0x4
+#define HISTB_TRNG_STAT		0x8
+
+#define SLEEP_US		10
+#define TIMEOUT_US		10000
+
+static int histb_trng_wait(struct hwrng *rng)
+{
+	void __iomem *base = (void __iomem *) rng->priv;
+	u32 val;
+
+	return readl_relaxed_poll_timeout(base + HISTB_TRNG_STAT,
+					  val, val & 0x7, SLEEP_US, TIMEOUT_US);
+}
+
+static int histb_trng_init(struct hwrng *rng)
+{
+	void __iomem *base = (void __iomem *) rng->priv;
+	u32 val;
+
+	val = readl_relaxed(base + HISTB_TRNG_CTRL);
+
+	/* select rng source 2 */
+	val &= ~0x3;
+	val |= 2;
+	/* post_process_depth */
+	val &= ~(0xf << 8);
+	val |= 9 << 8;
+
+	val |= BIT(7);  /* post_process_enable */
+	val |= BIT(5);  /* drop_enable */
+
+	writel_relaxed(val, base + HISTB_TRNG_CTRL);
+
+	if (histb_trng_wait(rng)) {
+		pr_err("failed to bring up rng device, does it exist?\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int histb_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	void __iomem *base = (void __iomem *) rng->priv;
+	size_t i;
+	int ret;
+
+	for (i = 0; i < max; i += sizeof(u32)) {
+		ret = histb_trng_wait(rng);
+		if (ret) {
+			pr_err("failed to generate random number, generated %zu\n", i);
+			return i ? i : ret;
+		}
+
+		*((u32 *) data + i) = readl_relaxed(base + HISTB_TRNG_NUMBER);
+	}
+
+	return i;
+}
+
+static int histb_trng_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hwrng *rng;
+	struct resource *res;
+	int ret;
+
+	rng = devm_kzalloc(dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	rng->priv = (unsigned long) devm_ioremap(dev, res->start, resource_size(res));
+	if (!rng->priv)
+		return -ENOMEM;
+
+	rng->name = KBUILD_MODNAME;
+	rng->init = histb_trng_init;
+	rng->read = histb_trng_read;
+
+	ret = devm_hwrng_register(dev, rng);
+	if (ret) {
+		dev_err(dev, "failed to register %s (%d)\n", rng->name, ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, rng);
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
+	},
+};
+
+module_platform_driver(histb_trng_driver);
+
+MODULE_DESCRIPTION("HiSTB True RNG");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.39.2

