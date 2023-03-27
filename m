Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136B96CA668
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC0NsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjC0Nr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:47:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB1A527C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:47:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn12so36514504edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679924871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrhnAOOIgbwUZxe8xXspDurvamg9bhg8SHvM7DDC394=;
        b=zb3kNQ90m9Gk4A+Q7zAQ1zphZZ+m9gtfATBFNosEZ//BwuKqs6wphXItZWPSSZntJ8
         8aMxfHqGlN+3ExJVHXpqVoDo32GXwB4I3/UhQ8TlXSS/tGNYkONoDtBsV1tCEd979y54
         utC1+QMseGdHmL/dS0FMKOHPHtwjirbqTIzLWX5pp5cag8pVQj3qTcPgjJ6O3tBQG+RZ
         zDzR6LiMVrYDVEAywVANnpkvNdXnsuxDZOcUKWc2gK7QJSIcLkOi173YUlbfyY9ODHg9
         oCYsloCaxb4XF8YO+9KHgUwKXp5uKVT8QBCF+8QH1WgtEZG0c8SvJj7mD0brwotmB0OZ
         Xdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679924871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrhnAOOIgbwUZxe8xXspDurvamg9bhg8SHvM7DDC394=;
        b=5LyBaTSTruMjETLpamOzFMAv1DWeb2IMD48HvXwIdCN9cMpDSagEio/WCOI2F8inNn
         +JU0LzJUrokyTf6CjkEoMhGokbbYHKSWFS7v1q4tem+OnQukK2VU7NLbhNMyJ7Z4weYJ
         CbscypcRC4ZbvaZcPjFYstwJwqEuJeQa7Sy/Uclm6OuNkOJeiuDApbRGCF701TE5PakC
         lzb+48spMMEp22Kc3/yPlu41QpHMj2+V/AkXP2LUlbHgmUxHiGtiuDj1d6FvltgEWJgq
         IJqQY2hrUODZYu4qD2JR0ALiDp+OCxyNFgBZE1p/ZGB0+KNeT4YmDEa3U32pABpVS1wi
         Hhtw==
X-Gm-Message-State: AAQBX9cZxR4IYj68stigx3Du+iEm5IB8DRaDUUNg4SBhfHm5JM5N+ZAl
        hs7Ppg6VM7eZ96M+aZ+sz3h5aw==
X-Google-Smtp-Source: AKy350ZmtuIKxSVaEkmHN/+olFQje35wFU7Ax3GEbRB87oRkWmFTFyqkaKCPTyT5TXaAgDYRu6vkrg==
X-Received: by 2002:a05:6402:4c3:b0:4fb:fd9f:737a with SMTP id n3-20020a05640204c300b004fbfd9f737amr12674932edw.4.1679924871036;
        Mon, 27 Mar 2023 06:47:51 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b005023ddb37eesm2394303eda.8.2023.03.27.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:47:50 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v4 4/7] soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
Date:   Mon, 27 Mar 2023 16:47:31 +0300
Message-Id: <20230327134734.3256974-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327134734.3256974-1-abel.vesa@linaro.org>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Platforms that already have ICE supported, will use it as a library
as the of_qcom_ice_get will return an ICE instance created for the
consumer device. This allows the backwards compatibility with old-style
devicetree approach.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v3 (RFC) is here:
https://lore.kernel.org/all/20230313115202.3960700-5-abel.vesa@linaro.org/

Changes since v3:
 * dropped the "QCOM ICE v2.X only" comment
 * dropped question mark after "built-in self-test"
 * dropped comment above qcom_ice_check_supported implementation
 * allowed major version 4 as well, found on SM8550
 * renamed "enable" argument of __qcom_ice_enable to "enable_optimizations"
 * moved qcom_ice_enable implementation above qcom_ice_resume
 * initialized dev in qcom_ice_program_key and dropped assignment below
 * in ice.h, included types.h instead of err.h
 * in ice.h, dropped the #if IS_ENABLED(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)
 * in ice.h, moved of_qcom_ice_get below qcom_ice_evict_key

Changes since v2:
 * reorganized the probe and of_qcom_ice_get to allow support for dts
   legacy approach
 * added suspend API to allow disabling the core clock when not in use
 * reworded the commit message to mention the way the legacy dts approach
   is supported
 * made the qcom_ice definition private to the driver

Changes since v1:
 * renamed filename to simply ice.c
 * kept all the copyrights from UFS and SDHC drivers
 * Used GENMASK like Konrad suggested
 * Fixed the comment about "ICE instance is supported currently",
   like Konrad suggested
 * Used FIELD_GET
 * Dropped extra comment from qcom_ice_low_power_mode_enable
 * Used lowercase in hex values
 * Dropped double space from comment above the qcom_ice_program_key
   function
 * Changed the dev_info about engine being registered to dev_dbg
 * Made the compatible entry in the match table a single line
 * Made the qcom_ice_driver definition consistent with respect to
   spaces/tabs
 * Switched QCOM_INLINE_CRYPTO_ENGINE to tristate and made it built-in
   if any of the UFS or the SDHC drivers are built-in. This is to allow
   the API to be available even if the built-in driver doesn't have
   crypto enabled.
 * Dropped the engine container state. The of_qcom_ice_get will look up
   the ICE device based on the phandle and get the ICE data from dev
   data.
 * Dropped the supported field from qcom_ice definition.
 * Marked all funtions that are local as static.
 * Replaced qcom_ice_wait_bist_status function implementation with the
   one dropped from sdhci-msm.c
 * Added a separate function for key eviction


 drivers/soc/qcom/Kconfig  |   4 +
 drivers/soc/qcom/Makefile |   1 +
 drivers/soc/qcom/ice.c    | 342 ++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h    |  37 +++++
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/soc/qcom/ice.c
 create mode 100644 include/soc/qcom/ice.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a25df9e3c70e..a491718f8064 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -275,4 +275,8 @@ config QCOM_ICC_BWMON
 	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
 	  memory throughput even with lower CPU frequencies.
 
+config QCOM_INLINE_CRYPTO_ENGINE
+	tristate
+	select QCOM_SCM
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 6e88da899f60..0f43a88b4894 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
+obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
new file mode 100644
index 000000000000..497f94109b77
--- /dev/null
+++ b/drivers/soc/qcom/ice.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm ICE (Inline Crypto Engine) support.
+ *
+ * Copyright (c) 2013-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019, Google LLC
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/of_platform.h>
+
+#include <linux/firmware/qcom/qcom_scm.h>
+
+#include <soc/qcom/ice.h>
+
+#define AES_256_XTS_KEY_SIZE			64
+
+/* QCOM ICE registers */
+#define QCOM_ICE_REG_VERSION			0x0008
+#define QCOM_ICE_REG_FUSE_SETTING		0x0010
+#define QCOM_ICE_REG_BIST_STATUS		0x0070
+#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
+
+/* BIST ("built-in self-test") status flags */
+#define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)
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
+struct qcom_ice {
+	struct device *dev;
+	struct device_node *np;
+	void __iomem *base;
+
+	struct clk *core_clk;
+};
+
+static bool qcom_ice_check_supported(struct qcom_ice *ice)
+{
+	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
+	struct device *dev = ice->dev;
+	int major = FIELD_GET(GENMASK(31, 24), regval);
+	int minor = FIELD_GET(GENMASK(23, 16), regval);
+	int step = FIELD_GET(GENMASK(15, 0), regval);
+
+	/* For now this driver only supports ICE version 3 and 4. */
+	if (major != 3 && major != 4) {
+		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
+			 major, minor, step);
+		return false;
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
+		return false;
+	}
+
+	return true;
+}
+
+static void qcom_ice_low_power_mode_enable(struct qcom_ice *ice)
+{
+	u32 regval;
+
+	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
+
+	/* Enable low power mode sequence */
+	regval |= 0x7000;
+	qcom_ice_writel(ice, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
+}
+
+static void qcom_ice_optimization_enable(struct qcom_ice *ice)
+{
+	u32 regval;
+
+	/* ICE Optimizations Enable Sequence */
+	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
+	regval |= 0xd807100;
+	/* ICE HPG requires delay before writing */
+	udelay(5);
+	qcom_ice_writel(ice, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
+	udelay(5);
+}
+
+/*
+ * Wait until the ICE BIST (built-in self-test) has completed.
+ *
+ * This may be necessary before ICE can be used.
+ * Note that we don't really care whether the BIST passed or failed;
+ * we really just want to make sure that it isn't still running. This is
+ * because (a) the BIST is a FIPS compliance thing that never fails in
+ * practice, (b) ICE is documented to reject crypto requests if the BIST
+ * fails, so we needn't do it in software too, and (c) properly testing
+ * storage encryption requires testing the full storage stack anyway,
+ * and not relying on hardware-level self-tests.
+ */
+static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
+{
+	u32 regval;
+	int err;
+
+	err = readl_poll_timeout(ice->base + QCOM_ICE_REG_BIST_STATUS,
+				 regval, !(regval & QCOM_ICE_BIST_STATUS_MASK),
+				 50, 5000);
+	if (err)
+		dev_err(ice->dev,
+			"Timed out waiting for ICE self-test to complete\n");
+	return err;
+}
+
+static int __qcom_ice_enable(struct qcom_ice *ice,
+			     bool enable_optimizations)
+{
+	struct device *dev = ice->dev;
+	int err;
+
+	err = clk_prepare_enable(ice->core_clk);
+	if (err) {
+		dev_err(dev, "failed to enable core clock (%d)\n",
+			err);
+		return err;
+	}
+
+	if (enable_optimizations) {
+		qcom_ice_low_power_mode_enable(ice);
+		qcom_ice_optimization_enable(ice);
+	}
+
+	err = qcom_ice_wait_bist_status(ice);
+	if (err) {
+		dev_err(dev, "BIST status error (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int qcom_ice_enable(struct qcom_ice *ice)
+{
+	return __qcom_ice_enable(ice, true);
+}
+EXPORT_SYMBOL_GPL(qcom_ice_enable);
+
+int qcom_ice_resume(struct qcom_ice *ice)
+{
+	return __qcom_ice_enable(ice, false);
+}
+EXPORT_SYMBOL_GPL(qcom_ice_resume);
+
+int qcom_ice_suspend(struct qcom_ice *ice)
+{
+	clk_disable_unprepare(ice->core_clk);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_suspend);
+
+int qcom_ice_program_key(struct qcom_ice *ice,
+			 u8 algorithm_id, u8 key_size,
+			 const u8 crypto_key[], u8 data_unit_size,
+			 int slot)
+{
+	struct device *dev = ice->dev;
+	union {
+		u8 bytes[AES_256_XTS_KEY_SIZE];
+		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
+	} key;
+	int i;
+	int err;
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
+	 * The SCM call byte-swaps the 32-bit words of the key.
+	 * So we have to do the same, in order for the final key be correct.
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
+int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
+{
+	return qcom_scm_ice_invalidate_key(slot);
+}
+EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
+
+static struct qcom_ice *qcom_ice_create(struct platform_device *pdev, void __iomem *base)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct qcom_ice *engine;
+
+	if (!qcom_scm_is_available())
+		return ERR_PTR(-EPROBE_DEFER);
+
+	if (!qcom_scm_ice_available()) {
+		dev_warn(dev, "ICE SCM interface not found\n");
+		return NULL;
+	}
+
+	engine = devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
+	if (!engine)
+		return ERR_PTR(-ENOMEM);
+
+	engine->dev = &pdev->dev;
+	engine->np = np;
+	engine->base = base;
+
+	engine->core_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(engine->core_clk))
+		return ERR_CAST(engine->core_clk);
+
+	if (!qcom_ice_check_supported(engine))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	dev_info(dev, "Registered Qualcomm Inline Crypto Engine\n");
+
+	return engine;
+}
+
+struct qcom_ice *of_qcom_ice_get(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct qcom_ice *ice = ERR_PTR(-EPROBE_DEFER);
+	struct device_node *node;
+	struct resource *res;
+	void __iomem *base;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	/* legacy has ice reg range in the consumer DT node */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice");
+	if (res) {
+		base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(base))
+			return base;
+
+		/* create ICE instance using consumer dev */
+		return qcom_ice_create(pdev, base);
+	}
+
+	node = of_parse_phandle(dev->of_node, "qcom,ice", 0);
+	if (!node) {
+		ice = NULL;
+		goto out;
+	}
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev) {
+		dev_err(dev, "Cannot find device node %s\n", node->name);
+		goto out;
+	}
+
+	ice = platform_get_drvdata(pdev);
+	if (!ice) {
+		dev_err(dev, "Cannot get ice\n");
+		put_device(&pdev->dev);
+		return ERR_PTR(-ENODEV);
+	}
+
+out:
+	of_node_put(node);
+
+	return ice;
+}
+EXPORT_SYMBOL_GPL(of_qcom_ice_get);
+
+static int qcom_ice_probe(struct platform_device *pdev)
+{
+	struct qcom_ice *engine;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base)) {
+		dev_warn(&pdev->dev, "ICE registers not found\n");
+		return PTR_ERR(base);
+	}
+
+	engine = qcom_ice_create(pdev, base);
+	if (IS_ERR(engine))
+		return PTR_ERR(engine);
+
+	platform_set_drvdata(pdev, engine);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_ice_of_match_table[] = {
+	{	.compatible = "qcom,inline-crypto-engine" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
+
+static struct platform_driver qcom_ice_driver = {
+	.probe	= qcom_ice_probe,
+	.driver = {
+		.name = "qcom-ice",
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
index 000000000000..5870a94599a2
--- /dev/null
+++ b/include/soc/qcom/ice.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __QCOM_ICE_H__
+#define __QCOM_ICE_H__
+
+#include <linux/types.h>
+
+struct qcom_ice;
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
+int qcom_ice_enable(struct qcom_ice *ice);
+int qcom_ice_resume(struct qcom_ice *ice);
+int qcom_ice_suspend(struct qcom_ice *ice);
+int qcom_ice_program_key(struct qcom_ice *ice,
+			 u8 algorithm_id, u8 key_size,
+			 const u8 crypto_key[], u8 data_unit_size,
+			 int slot);
+int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
+struct qcom_ice *of_qcom_ice_get(struct device *dev);
+#endif /* __QCOM_ICE_H__ */
-- 
2.34.1

