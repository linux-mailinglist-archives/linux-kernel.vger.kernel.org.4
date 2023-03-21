Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA96C2A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCUF6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCUF6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:58:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1719C7B;
        Mon, 20 Mar 2023 22:58:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso19127452pjb.0;
        Mon, 20 Mar 2023 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679378314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYxpXAP3Qj4XTQVGxwubY62608RIpaMdDRQuTEZG/7I=;
        b=C3bCMTMJtg07k0iGiCNW8mWUJq6oNQ2v7wb2CB1ifFJWuqJW52nmku229LbCM1n0jv
         S4zV5lc4HyFwbYMBXs7t5Sy3hR9KCqpPQ/rLcrt/mm3Hxmyzazreyz/BuO+NdauAe4KU
         EhRGJQOhqf1rm6aoR52Q2xHeDQt4X38DieGzSjxK4PWzo1RkDpyN83dzfjfbDV0wDgr+
         vimX932KglU5qNs+eonV13JbsUZi4U2ndlEiWSwDpnfCdByJ5ZDB6gNzEncdSikqBxRW
         OOsaWPSQN3HnseL1Ox/1NJfLbUJ6DXnCfEoqLPvMHzO+l+ekS6ISm3mkftAt3UPNBxyu
         0lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679378314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYxpXAP3Qj4XTQVGxwubY62608RIpaMdDRQuTEZG/7I=;
        b=ztRV8FnoZR1VN3IXNnDLi3BVd5udbIL+RnnyqW2A2tAINJ/VNRMi2ay1sRGbFSM+xs
         Y0vOCPTw+jX5mJzjpFmoewyqgvWab+s2mfzWOZpBx9odivnJGky5vYJyqVu+9+NyCmNG
         uDpe+YIbrmZrMM1+CXS7k8Huy0BTtrYaWtHIsTToXt9KWtwiT7w3qoqslz228VuvSJx2
         RqIQNAjmERTNkvLopvA4ZsDgqErhsIsL6m3l3KDR2uTOtjSmUeAKztU+lxHQqrXGAp+z
         n5ujfYsachMH2baIh/r96Ed7CEt05K7DLIyNRtvWBdBBvcv7JMesT/q66R5iKMj3spsB
         6YBA==
X-Gm-Message-State: AO0yUKXwMjhnRq6wHXi6IaCyvhhFTEsnNf9JmQBA819L4E/XFW64Fbl1
        GemGpJ92vV7BEefsM5zvN5xH4PxuO6t7G9NMeGc=
X-Google-Smtp-Source: AK7set8oqkKf73lv4AMrasm0StsbRGWWZNbidFz7IWqXOj+c/WxbF2TB2OBckkwG3lXcXxqXTVJ+yg==
X-Received: by 2002:a05:6a20:8b1d:b0:cc:f47b:9a with SMTP id l29-20020a056a208b1d00b000ccf47b009amr1173232pzh.1.1679378313665;
        Mon, 20 Mar 2023 22:58:33 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.205])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78dcd000000b0062809b2cb05sm1745467pfr.155.2023.03.20.22.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:58:33 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: hisilicon/trng - add support for HiSTB TRNG
Date:   Tue, 21 Mar 2023 13:58:20 +0800
Message-Id: <20230321055822.1611239-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSTB TRNG are found on some HiSilicon STB SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/crypto/hisilicon/Kconfig         |   7 ++
 drivers/crypto/hisilicon/Makefile        |   2 +-
 drivers/crypto/hisilicon/trng/Makefile   |   3 +
 drivers/crypto/hisilicon/trng/trng-stb.c | 128 +++++++++++++++++++++++
 4 files changed, 139 insertions(+), 1 deletion(-)
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
index 000000000..e083f7b4c
--- /dev/null
+++ b/drivers/crypto/hisilicon/trng/trng-stb.c
@@ -0,0 +1,128 @@
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
+	/* is device up? */
+	if (histb_trng_wait(rng)) {
+		pr_err("failed to init rng device\n");
+		return -EINVAL;
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
+			pr_err("failed to generate random number, generated %d\n", i);
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

