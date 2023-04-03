Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF4D6D51F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjDCUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjDCUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:05:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770AC3AB9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:05:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso18798201wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680552342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+gtDwei0F6yvFOCO73zkeQsAuYg6Pg7WzNnafRRTIA=;
        b=JdB65BFwhkjIQbGoxZSAc6kQvF8J8RN02IRdYXR+f5uHgbmC2JzvCo1bBKjm1gb3h5
         WqQz3PG2wTRLu9SS3wjNgEttb5mhTqDaRRn3rdxpJwghhhv0L/W7UvgKOoEQE1/yF7c0
         YI6436JBfDjvzZNkfdk908pllQqhVUYK756/c+kDh/OATOw9Xbs/iMHUsCCQIeK/jihZ
         lgVM5lSzjy203Tp13dlINF78Emiq7qbTqgDBuGcFh0Drzp4pPWZfzwpeq+ggXpl7+Y61
         0u/bStEkaGSnKbK4PmT2/NLzQM9KBsLPwvcWNaIRqRohZueOtbusjx899fymGZ83xUq1
         MGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+gtDwei0F6yvFOCO73zkeQsAuYg6Pg7WzNnafRRTIA=;
        b=3rR898fUkNm9Luai9a4duznXp1GKIyd59s7pTzJhQqCOTLbJqRPhzvaYSIHEFTBiiA
         HGzg2MTu6K+TF+RNkghTsDFhMzB/Qr+qvS7weXcQ3G43A6iDiX5vDy0JNvyBfF5VFS6w
         GGkn/UxpuwH6tkAwWAbe22GpOvd+ano/VafQb/nb8JOcPwhhKqLuWXZOfgNyskI5s+gI
         /3Ga9uOj+uEFCf55NQ3pBKpuJ1A0WWx3dbldekBA1m525XMpzn57iLhz9xZffwuLYfHP
         5NJuYog6CRCInY+6fyni+OLXyB3CS/Ug3BwgA1jm+GdZMySRZBLestEBrvO/N5u6NHCu
         Es1g==
X-Gm-Message-State: AAQBX9cAOZTfu83o3V4vXF8BxThtHQicI3yAUllU9l9D7eBs3Z0v0epk
        SsqTCtcjgydg9K5k7WJYd89z9w==
X-Google-Smtp-Source: AKy350a7yfJXE9v0oxaJ/WrJufSCDuZtJ/EOcdzsgBBZ8gQ0BEmf5UIjp7FW60icMf89GfMicBeWiw==
X-Received: by 2002:a7b:cb41:0:b0:3eb:29fe:7343 with SMTP id v1-20020a7bcb41000000b003eb29fe7343mr376723wmj.33.1680552341769;
        Mon, 03 Apr 2023 13:05:41 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm20798037wmb.40.2023.04.03.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:05:41 -0700 (PDT)
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
Subject: [PATCH v5 3/6] soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
Date:   Mon,  3 Apr 2023 23:05:27 +0300
Message-Id: <20230403200530.2103099-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403200530.2103099-1-abel.vesa@linaro.org>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
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
devicetree approach. Also, add support to HW version 4.x since it
works out-of-the-box with the current driver. The 4.x HW version is
found on SM8550 platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v4 is here:
https://lore.kernel.org/all/20230327134734.3256974-5-abel.vesa@linaro.org/

Changes since v4:
 * mentioned the addition of the 4.x HW version in the commit message
 * dropped np member from qcom_ice
 * made the error message from qcom_ice_wait_bist_status a single line
 * dropped clock enable call from qcom_ice_enable
 * changed comment in qcom_ice_program_key above the byte swap according
   to Bjorn's suggestion
 * made the qcom_ice_create function prototype a two-liner
 * changed the first argument of qcom_ice_create to simply device
 * added support for the legacy DT clocks name
 * changed the dev_info to dev_dbg in qcom_ice_create
 * added kernel doc above of_qcom_ice_get
 * made the comments in of_qcom_ice_get more explicit about how the
   legacy and the qcom,ice approach are handled
 * changed the error message on getting the ICE instance failure
 * added devlink between the consumer and the ICE instance in order to
   make sure the supplier doesn't get unbinded/removed from under the
   consumer
 * replace tab with space on the compatible line in the match table

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
 drivers/soc/qcom/ice.c    | 365 ++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h    |  37 ++++
 4 files changed, 407 insertions(+)
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
index 000000000000..1f92b8061a78
--- /dev/null
+++ b/drivers/soc/qcom/ice.c
@@ -0,0 +1,365 @@
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
+	void __iomem *base;
+	struct device_link *link;
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
+		dev_err(ice->dev, "Timed out waiting for ICE self-test to complete\n");
+
+	return err;
+}
+
+int qcom_ice_enable(struct qcom_ice *ice)
+{
+	qcom_ice_low_power_mode_enable(ice);
+	qcom_ice_optimization_enable(ice);
+
+	return qcom_ice_wait_bist_status(ice);
+}
+EXPORT_SYMBOL_GPL(qcom_ice_enable);
+
+int qcom_ice_resume(struct qcom_ice *ice)
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
+	return qcom_ice_wait_bist_status(ice);
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
+	/* The SCM call requires that the key words are encoded in big endian */
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
+static struct qcom_ice *qcom_ice_create(struct device *dev,
+					void __iomem *base)
+{
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
+	engine->dev = dev;
+	engine->base = base;
+
+	/*
+	 * Legacy DT binding uses different clk names for each consumer,
+	 * so lets try those first. If none of those are a match, it means
+	 * the we only have one clock and it is part of the dedicated DT node.
+	 * Also, enable the clock before we check what HW version the driver
+	 * supports.
+	 */
+	engine->core_clk = devm_clk_get_optional_enabled(dev, "ice_core_clk");
+	if (!engine->core_clk)
+		engine->core_clk = devm_clk_get_optional_enabled(dev, "ice");
+	if (!engine->core_clk)
+		engine->core_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(engine->core_clk))
+		return ERR_CAST(engine->core_clk);
+
+	if (!qcom_ice_check_supported(engine))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	dev_dbg(dev, "Registered Qualcomm Inline Crypto Engine\n");
+
+	return engine;
+}
+
+/**
+ * of_qcom_ice_get() - get an ICE instance from a DT node
+ * @dev: device pointer for the consumer device
+ *
+ * This function will provide an ICE instance either by creating one for the
+ * consumer device if its DT node provides the 'ice' reg range and the 'ice'
+ * clock (for legacy DT style). On the other hand, if consumer provides a
+ * phandle via 'qcom,ice' property to an ICE DT, the ICE instance will already
+ * be created and so this function will return that instead.
+ *
+ * Return: ICE pointer on success, NULL if there is no ICE data provided by the
+ * consumer or ERR_PTR() on error.
+ */
+struct qcom_ice *of_qcom_ice_get(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct qcom_ice *ice;
+	struct device_node *node;
+	struct resource *res;
+	void __iomem *base;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	/*
+	 * In order to support legacy style devicetree bindings, we need
+	 * to create the ICE instance using the consumer device and the reg
+	 * range called 'ice' it provides.
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice");
+	if (res) {
+		base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(base))
+			return ERR_CAST(base);
+
+		/* create ICE instance using consumer dev */
+		return qcom_ice_create(&pdev->dev, base);
+	}
+
+	/*
+	 * If the consumer node does not provider an 'ice' reg range
+	 * (legacy DT binding), then it must at least provide a phandle
+	 * to the ICE devicetree node, otherwise ICE is not supported.
+	 */
+	node = of_parse_phandle(dev->of_node, "qcom,ice", 0);
+	if (!node)
+		return NULL;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev) {
+		dev_err(dev, "Cannot find device node %s\n", node->name);
+		ice = ERR_PTR(-EPROBE_DEFER);
+		goto out;
+	}
+
+	ice = platform_get_drvdata(pdev);
+	if (!ice) {
+		dev_err(dev, "Cannot get ice instance from %s\n",
+			dev_name(&pdev->dev));
+		platform_device_put(pdev);
+		ice = ERR_PTR(-EPROBE_DEFER);
+		goto out;
+	}
+
+	ice->link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
+	if (!ice->link) {
+		dev_err(&pdev->dev,
+			"Failed to create device link to consumer %s\n",
+			dev_name(dev));
+		ice = ERR_PTR(-EINVAL);
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
+	engine = qcom_ice_create(&pdev->dev, base);
+	if (IS_ERR(engine))
+		return PTR_ERR(engine);
+
+	platform_set_drvdata(pdev, engine);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_ice_of_match_table[] = {
+	{ .compatible = "qcom,inline-crypto-engine" },
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

