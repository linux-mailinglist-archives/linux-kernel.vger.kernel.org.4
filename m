Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5F6962FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjBNMDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjBNMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:03:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F62448A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z13so10814124wmp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zjlfCMq3kx4tTw+pyAfeEJrt6GCR1NkyGmXT1KLCK0=;
        b=t1RXJzJoSqvmnFJAdl9zSj2+FjRlOVj8OJl669S6bhD2cqpB+1UF6lOxXNN3bd/tB8
         DKkuZtpuMZ5RxnVa6sOOQsldJZ/CSQMyTkqDHG6jAw+xNQ/2GJ4YYhROsBCEY4P1qLqN
         CI0Z6P2dyDQgJx7sT+QWAC0B4A+bma6JkWPBkZ+Wl9iQKePNrEMfk40qp3+9azW4iS+t
         qhi4Y2aV4QKdAm0kt8TkDP1aKFiiZqIxwc8l1nHzsVbUTgJqwzkbFmLNewSnu9vnRWsr
         CkXIS5/Gu9HZynzVXTPG5MLnq3a/ytgqmmnO5QHYRAf+EOOu9F1oHweP32IG0vNNOoKw
         0l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zjlfCMq3kx4tTw+pyAfeEJrt6GCR1NkyGmXT1KLCK0=;
        b=ctX05YGEAmGYShm3bhEyYVaTy6jeur7wLieOYKPTWB60ZTL5J4jBWMD7wiCcmHKy1Q
         tfK/XMAjp8xcaKDuE9FYpVdz3GZcBdhVqso2IcxeCJgqQ3FJKNupKTUwWEL/QaZVCyjp
         YGKAduCQo589uSAJRHD+BjWsMsKab8sD2J53inAeUvx6wtp4CCA48ciNOLzq790lTCqW
         yp+h6Cq+KEcXUgW8d31/v70+iAejrWkpAD/xwVmSsJl3Z2BxzpUfDx1JAWFdJ5cT1nHA
         UKyzlh0rZiYSjUp16fg7wGgpDRZW4PhTx/2k1wCt9A+92qTt91F3YmOccJqDEUfhUYGb
         SvJg==
X-Gm-Message-State: AO0yUKUiWpxYWwCaK07bd0knAyM5ILYOjNlioMGwKMNb3UPy+jQGcgCC
        NwkZ+uEcQ41a83mP4SrYaIx1Nw==
X-Google-Smtp-Source: AK7set8ye3QUN+EjN8/pXso7oYbt1Tpx4jqCQmxjTIL64WqDjCKVZUXbWyxblKlTc5lNqYzi30T61Q==
X-Received: by 2002:a05:600c:1607:b0:3e0:185:e93a with SMTP id m7-20020a05600c160700b003e00185e93amr1865588wmn.25.1676376180970;
        Tue, 14 Feb 2023 04:03:00 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b003dd1b00bd9asm18834846wms.32.2023.02.14.04.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 04:03:00 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH 1/5] soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
Date:   Tue, 14 Feb 2023 14:02:49 +0200
Message-Id: <20230214120253.1098426-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214120253.1098426-1-abel.vesa@linaro.org>
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This takes the already existing duplicated support in both ufs-qcom
and sdhci-msm drivers and makes it a dedicated driver that can be used
by both mentioned drivers. The reason for this is because, staring with
SM8550, the ICE IP block is shared between UFS and SDCC, which means we
need to probe a dedicated device and share it between those two
consumers. So let's add the ICE dedicated driver as a soc driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/Kconfig    |  10 ++
 drivers/soc/qcom/Makefile   |   1 +
 drivers/soc/qcom/qcom-ice.c | 315 ++++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h      |  61 +++++++
 4 files changed, 387 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom-ice.c
 create mode 100644 include/soc/qcom/ice.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a8f283086a21..fa76d3ffb4d3 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -275,4 +275,14 @@ config QCOM_ICC_BWMON
 	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
 	  memory throughput even with lower CPU frequencies.
 
+config QCOM_INLINE_CRYPTO_ENGINE
+	bool "QCOM UFS & SDCC Inline Crypto Engine driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on SCSI_UFS_CRYPTO || MMC_CRYPTO
+	select QCOM_SCM
+	help
+	  Say yes here to support the Qualcomm Inline Crypto Engine driver,
+	  providing crypto support to Qualcomm storage drivers like UFS
+	  and SDCC.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 6e88da899f60..30219c164cb0 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
+obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom-ice.o
diff --git a/drivers/soc/qcom/qcom-ice.c b/drivers/soc/qcom/qcom-ice.c
new file mode 100644
index 000000000000..40c9adbc2666
--- /dev/null
+++ b/drivers/soc/qcom/qcom-ice.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm ICE (Inline Crypto Engine) support.
+ *
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/qcom_scm.h>
+
+#include <soc/qcom/ice.h>
+
+#define AES_256_XTS_KEY_SIZE			64
+
+/* QCOM ICE registers */
+
+#define QCOM_ICE_REG_CONTROL			0x0000
+#define QCOM_ICE_REG_RESET			0x0004
+#define QCOM_ICE_REG_VERSION			0x0008
+#define QCOM_ICE_REG_FUSE_SETTING		0x0010
+#define QCOM_ICE_REG_PARAMETERS_1		0x0014
+#define QCOM_ICE_REG_PARAMETERS_2		0x0018
+#define QCOM_ICE_REG_PARAMETERS_3		0x001C
+#define QCOM_ICE_REG_PARAMETERS_4		0x0020
+#define QCOM_ICE_REG_PARAMETERS_5		0x0024
+
+/* QCOM ICE v3.X only */
+#define QCOM_ICE_GENERAL_ERR_STTS		0x0040
+#define QCOM_ICE_INVALID_CCFG_ERR_STTS		0x0030
+#define QCOM_ICE_GENERAL_ERR_MASK		0x0044
+
+/* QCOM ICE v2.X only */
+#define QCOM_ICE_REG_NON_SEC_IRQ_STTS		0x0040
+#define QCOM_ICE_REG_NON_SEC_IRQ_MASK		0x0044
+
+#define QCOM_ICE_REG_NON_SEC_IRQ_CLR		0x0048
+#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME1	0x0050
+#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME2	0x0054
+#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME1	0x0058
+#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME2	0x005C
+#define QCOM_ICE_REG_STREAM1_BIST_ERROR_VEC	0x0060
+#define QCOM_ICE_REG_STREAM2_BIST_ERROR_VEC	0x0064
+#define QCOM_ICE_REG_STREAM1_BIST_FINISH_VEC	0x0068
+#define QCOM_ICE_REG_STREAM2_BIST_FINISH_VEC	0x006C
+#define QCOM_ICE_REG_BIST_STATUS		0x0070
+#define QCOM_ICE_REG_BYPASS_STATUS		0x0074
+#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
+#define QCOM_ICE_REG_ENDIAN_SWAP		0x1004
+#define QCOM_ICE_REG_TEST_BUS_CONTROL		0x1010
+#define QCOM_ICE_REG_TEST_BUS_REG		0x1014
+
+/* BIST ("built-in self-test"?) status flags */
+#define QCOM_ICE_BIST_STATUS_MASK		0xF0000000
+
+#define QCOM_ICE_FUSE_SETTING_MASK		0x1
+#define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
+#define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
+
+#define qcom_ice_writel(engine, val, reg)	\
+	writel((val), (engine)->base + (reg))
+
+#define qcom_ice_readl(engine, reg)	\
+	readl((engine)->base + (reg))
+
+/* Only one ICE instance is supported currently by HW */
+static struct qcom_ice *engine;
+
+static bool qcom_ice_check_supported(struct qcom_ice *ice)
+{
+	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
+	struct device *dev = ice->dev;
+	int major = regval >> 24;
+	int minor = (regval >> 16) & 0xFF;
+	int step = regval & 0xFFFF;
+
+	ice->supported = true;
+
+	/* For now this driver only supports ICE version 3. */
+	if (major != 3) {
+		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
+			 major, minor, step);
+		ice->supported = false;
+		goto out;
+	}
+
+	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
+		 major, minor, step);
+
+	/* If fuses are blown, ICE might not work in the standard way. */
+	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
+	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
+		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
+		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
+		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
+		ice->supported = false;
+		goto out;
+	}
+out:
+	return ice->supported;
+}
+
+void qcom_ice_low_power_mode_enable(struct qcom_ice *ice)
+{
+	u32 regval;
+
+	if (!ice)
+		return;
+
+	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
+	/*
+	 * Enable low power mode sequence
+	 * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
+	 */
+	regval |= 0x7000;
+	qcom_ice_writel(ice, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
+}
+
+static void qcom_ice_optimization_enable(struct qcom_ice *ice)
+{
+	u32 regval;
+
+	if (!ice)
+		return;
+
+	/* ICE Optimizations Enable Sequence */
+	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
+	regval |= 0xD807100;
+	/* ICE HPG requires delay before writing */
+	udelay(5);
+	qcom_ice_writel(ice, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
+	udelay(5);
+}
+
+/* Poll until all BIST bits are reset */
+static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
+{
+	int count;
+	u32 reg;
+
+	if (!ice)
+		return 0;
+
+	for (count = 0; count < 100; count++) {
+		reg = qcom_ice_readl(ice, QCOM_ICE_REG_BIST_STATUS);
+		if (!(reg & QCOM_ICE_BIST_STATUS_MASK))
+			break;
+		udelay(50);
+	}
+
+	if (reg)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int qcom_ice_resume(struct qcom_ice *ice)
+{
+	struct device *dev = ice->dev;
+	int err;
+
+	if (!ice)
+		return 0;
+
+	err = qcom_ice_wait_bist_status(ice);
+	if (err) {
+		dev_err(dev, "BIST status error (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_resume);
+
+int qcom_ice_enable(struct qcom_ice *ice)
+{
+	if (!ice)
+		return 0;
+
+	qcom_ice_low_power_mode_enable(ice);
+	qcom_ice_optimization_enable(ice);
+
+	return qcom_ice_resume(ice);
+}
+EXPORT_SYMBOL_GPL(qcom_ice_enable);
+
+/*
+ * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
+ * vendor-specific SCM calls for this; it doesn't support the standard way.
+ */
+int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
+			 u8 crypto_cap_idx, u8 algorithm_id,
+			 u8 key_size, const u8 crypto_key[],
+			 u8 data_unit_size, int slot)
+{
+	struct device *dev = ice->dev;
+	union {
+		u8 bytes[AES_256_XTS_KEY_SIZE];
+		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
+	} key;
+	int i;
+	int err;
+
+	if (!config_enable)
+		return qcom_scm_ice_invalidate_key(slot);
+
+	/* Only AES-256-XTS has been tested so far. */
+	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
+	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
+		dev_err_ratelimited(dev,
+				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
+				    algorithm_id, key_size);
+		return -EINVAL;
+	}
+
+	memcpy(key.bytes, crypto_key, AES_256_XTS_KEY_SIZE);
+
+	/*
+	 * The SCM call byte-swaps the 32-bit words of the key.  So we have to
+	 * do the same, in order for the final key be correct.
+	 */
+	for (i = 0; i < ARRAY_SIZE(key.words); i++)
+		__cpu_to_be32s(&key.words[i]);
+
+	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
+				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
+				   data_unit_size);
+
+	memzero_explicit(&key, sizeof(key));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_program_key);
+
+struct qcom_ice *of_qcom_ice_get(struct device *dev)
+{
+	struct qcom_ice *ice = ERR_PTR(-EPROBE_DEFER);
+	struct device_node *np, *node;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	np = dev->of_node;
+
+	node = of_parse_phandle(np, "qcom,ice", 0);
+
+	if (engine && engine->supported)
+		if (node == engine->np)
+			ice = engine;
+
+	of_node_put(node);
+
+	return ice;
+}
+EXPORT_SYMBOL_GPL(of_qcom_ice_get);
+
+int qcom_ice_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	if (!qcom_scm_ice_available()) {
+		dev_warn(dev, "ICE SCM interface not found\n");
+		return 0;
+	}
+
+	engine = devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
+	if (!engine)
+		return -ENOMEM;
+
+	engine->dev = dev;
+	engine->np = np;
+
+	engine->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(engine->base))
+		return PTR_ERR(engine->base);
+
+	engine->core_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(engine->core_clk))
+		return dev_err_probe(dev, PTR_ERR(engine->core_clk),
+				     "failed to get core clk\n");
+
+	if (!qcom_ice_check_supported(engine))
+		return -EOPNOTSUPP;
+
+	dev_set_drvdata(dev, engine);
+
+	dev_info(dev, "Registered Qualcomm Inline Crypto Engine\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_ice_of_match_table[] = {
+	{
+		.compatible = "qcom,inline-crypto-engine",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
+
+static struct platform_driver qcom_ice_driver = {
+	.probe		= qcom_ice_probe,
+	.driver = {
+		.name	= "qcom-ice",
+		.of_match_table = qcom_ice_of_match_table,
+	},
+};
+
+module_platform_driver(qcom_ice_driver);
+
+MODULE_DESCRIPTION("Qualcomm Inline Crypto Engine driver");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
new file mode 100644
index 000000000000..3ee8add7aeb9
--- /dev/null
+++ b/include/soc/qcom/ice.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __QCOM_ICE_H__
+#define __QCOM_ICE_H__
+
+#include <linux/err.h>
+
+struct qcom_ice {
+	struct device *dev;
+	struct device_node *np;
+	void __iomem *base;
+
+	struct clk *core_clk;
+
+	bool supported;
+};
+
+enum qcom_ice_crypto_key_size {
+	QCOM_ICE_CRYPTO_KEY_SIZE_INVALID	= 0x0,
+	QCOM_ICE_CRYPTO_KEY_SIZE_128		= 0x1,
+	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
+	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
+	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
+};
+
+enum qcom_ice_crypto_alg {
+	QCOM_ICE_CRYPTO_ALG_AES_XTS		= 0x0,
+	QCOM_ICE_CRYPTO_ALG_BITLOCKER_AES_CBC	= 0x1,
+	QCOM_ICE_CRYPTO_ALG_AES_ECB		= 0x2,
+	QCOM_ICE_CRYPTO_ALG_ESSIV_AES_CBC	= 0x3,
+};
+
+#if IS_ENABLED(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)
+int qcom_ice_enable(struct qcom_ice *ice);
+int qcom_ice_resume(struct qcom_ice *ice);
+struct qcom_ice *of_qcom_ice_get(struct device *dev);
+int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
+			 u8 crypto_cap_idx, u8 algorithm_id, u8 key_size,
+			 const u8 crypto_key[], u8 data_unit_size,
+			 int slot);
+#else
+static int qcom_ice_enable(struct qcom_ice *ice) { return 0; }
+static int qcom_ice_resume(struct qcom_ice *ice) { return 0; }
+
+static struct qcom_ice *of_qcom_ice_get(struct device *dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
+			 u8 crypto_cap_idx, u8 algorithm_id, u8 key_size,
+			 const u8 crypto_key[], u8 data_unit_size,
+			 int slot)
+{
+	return 0;
+}
+#endif /* CONFIG_QCOM_INLINE_CRYPTO_ENGINE */
+#endif /* __QCOM_ICE_H__ */
-- 
2.34.1

