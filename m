Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484EF6DABC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbjDGKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjDGKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:51:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E823AAF17
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:50:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id he13so4231325wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680864646; x=1683456646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pobROSh2uz7IjMKD6CPZ22/5OxIgZon6Ag2yGUjpsjc=;
        b=NLx37X8jtkIIwrNjWlIzdjlfNhscnUbP9GxNOA8r/t3NzzI34YYMnzpKBSyY7E81NN
         6OG0m166qilsrYhkGzzqD7pf2he9/dp5rKRHolKqopBieGRba26UdmCraJTjeR1FJC8L
         UXOtZkuquy6LD+3hCu+f4xq9C9QmYlzrXwBgTOKYQ7CaVYq2UJcX820YpReNKdK0owrU
         FcD2r0EaoTsjnR3so8VVVFKJpXOBxR0edxogUXvRHfHXxGffMdt9fa4Fj6ryAgpbaAL2
         FcSLyqR2MWnnPnqEG699Nsnl2Y5iE2zYNasrM14h2x6onHAxZ0IlsdiljPjREYpnEqFd
         fW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680864646; x=1683456646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pobROSh2uz7IjMKD6CPZ22/5OxIgZon6Ag2yGUjpsjc=;
        b=iog9AUG9Q2edFC51BB2ilY6CARbTXFC/nO/iI9MaZamFYveaeo3+OfeTA6C+yS1CHn
         N2fxI8GMWIMgzl0gp9+qAaBPHkoZFal5HvnZ7UHDpEHDW+5gIj2KEunkkJiL3RjrzCJ8
         qaLCsqBbWTIOjKMfuP4wpFcMvdC1pQ63G3XwKDVth4aq2DsT340902cPyo7+lhygZMt0
         UNTPcWWx+T118qXwKjyMtkaHLD9NpT5Oxp8hV8KZTDk0xV4/dED+kQQee4G9DoHfb+bt
         WbP9LDzfOPlq8eUUv94HLssAHU8t/B+tgam29GVoUQ/xuXw/wWUb2ZCwsfLu5ddazFV3
         z5qg==
X-Gm-Message-State: AAQBX9cec5+RiSg+NT5ATaqbKz06Qnleb9Gah+FZkNVIv0ub9VA+Un9Z
        xJR24/XxRzDJZ1YtCf5O/D4Rxg==
X-Google-Smtp-Source: AKy350aeJ+UqfnHp/nRLtOXvdje8U1PVRQ1XkqUru81kcoKOTqS6L3fB4Ft1tFu9Ae5HU4Qi1EJTMA==
X-Received: by 2002:a7b:c04b:0:b0:3eb:3104:efec with SMTP id u11-20020a7bc04b000000b003eb3104efecmr940323wmc.16.1680864645815;
        Fri, 07 Apr 2023 03:50:45 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c355000b003ede6540190sm8131909wmq.0.2023.04.07.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:50:45 -0700 (PDT)
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
Subject: [PATCH v6 4/6] scsi: ufs: ufs-qcom: Switch to the new ICE API
Date:   Fri,  7 Apr 2023 13:50:27 +0300
Message-Id: <20230407105029.2274111-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407105029.2274111-1-abel.vesa@linaro.org>
References: <20230407105029.2274111-1-abel.vesa@linaro.org>
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

Now that there is a new dedicated ICE driver, drop the ufs-qcom-ice and
use the new ICE api provided by the Qualcomm soc driver ice. The platforms
that already have ICE support will use the API as library since there will
not be a devicetree node, but instead they have reg range. In this case,
the of_qcom_ice_get will return an ICE instance created for the consumer's
device. But if there are platforms that do not have ice reg in the
consumer devicetree node and instead provide a dedicated ICE devicetree
node, the of_qcom_ice_get will look up the device based on qcom,ice
property and will get the ICE instance registered by the probe function
of the ice driver.

The ICE clock is now handle by the new driver. This is done by enabling
it on the creation of the ICE instance and then enabling/disabling it on
UFS runtime resume/suspend.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v5 is here:
https://lore.kernel.org/all/20230403200530.2103099-5-abel.vesa@linaro.org/

Changes since v5:
 * Reworded the commit message to add information about what happens
   with the ICE clock and who handles it.
 * Added temp ice variable to avoid setting the host ice to any value
   until a valid one is provided.

Changes since v4:
 * moved the setting of the UFSHCD_CAP_CRYPTO in the ufs_qcom_ice_init

Changes since v3:
 * since ufs-qcom-ice is being dropped, switch back to single file for CONFIG_SCSI_UFS_QCOM
 * handle properly the not-supported error returned by of_qcom_ice_get
 * drop cfg->crypto_cap_idx argument from qcom_ice_program_key call
 * added back the clearing of UFSHCD_CAP_CRYPTO and its checks in resume and enable

Changes since v2:
 * added the suspend API call for ICE
 * kept old wrappers over ICE API in

Changes since v1:
 * Added a check for supported algorithm and key size
   and passed the ICE defined values for algorithm and key size
 * Added call to evict function

 drivers/ufs/host/Kconfig        |   2 +-
 drivers/ufs/host/Makefile       |   4 +-
 drivers/ufs/host/ufs-qcom-ice.c | 244 --------------------------------
 drivers/ufs/host/ufs-qcom.c     |  99 ++++++++++++-
 drivers/ufs/host/ufs-qcom.h     |  32 +----
 5 files changed, 104 insertions(+), 277 deletions(-)
 delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c

diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 8793e3433580..16624ba08050 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -59,7 +59,7 @@ config SCSI_UFS_QCOM
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
 	depends on GENERIC_MSI_IRQ
 	depends on RESET_CONTROLLER
-	select QCOM_SCM if SCSI_UFS_CRYPTO
+	select QCOM_INLINE_CRYPTO_ENGINE if SCSI_UFS_CRYPTO
 	help
 	  This selects the QCOM specific additions to UFSHCD platform driver.
 	  UFS host on QCOM needs some vendor specific configuration before
diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
index d7c5bf7fa512..4573aead02eb 100644
--- a/drivers/ufs/host/Makefile
+++ b/drivers/ufs/host/Makefile
@@ -3,9 +3,7 @@
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.o
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-dwc-g210.o
 obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
-obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
-ufs_qcom-y += ufs-qcom.o
-ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
+obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_SCSI_UFS_EXYNOS) += ufs-exynos.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
diff --git a/drivers/ufs/host/ufs-qcom-ice.c b/drivers/ufs/host/ufs-qcom-ice.c
deleted file mode 100644
index 453978877ae9..000000000000
--- a/drivers/ufs/host/ufs-qcom-ice.c
+++ /dev/null
@@ -1,244 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Qualcomm ICE (Inline Crypto Engine) support.
- *
- * Copyright (c) 2014-2019, The Linux Foundation. All rights reserved.
- * Copyright 2019 Google LLC
- */
-
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/firmware/qcom/qcom_scm.h>
-
-#include "ufs-qcom.h"
-
-#define AES_256_XTS_KEY_SIZE			64
-
-/* QCOM ICE registers */
-
-#define QCOM_ICE_REG_CONTROL			0x0000
-#define QCOM_ICE_REG_RESET			0x0004
-#define QCOM_ICE_REG_VERSION			0x0008
-#define QCOM_ICE_REG_FUSE_SETTING		0x0010
-#define QCOM_ICE_REG_PARAMETERS_1		0x0014
-#define QCOM_ICE_REG_PARAMETERS_2		0x0018
-#define QCOM_ICE_REG_PARAMETERS_3		0x001C
-#define QCOM_ICE_REG_PARAMETERS_4		0x0020
-#define QCOM_ICE_REG_PARAMETERS_5		0x0024
-
-/* QCOM ICE v3.X only */
-#define QCOM_ICE_GENERAL_ERR_STTS		0x0040
-#define QCOM_ICE_INVALID_CCFG_ERR_STTS		0x0030
-#define QCOM_ICE_GENERAL_ERR_MASK		0x0044
-
-/* QCOM ICE v2.X only */
-#define QCOM_ICE_REG_NON_SEC_IRQ_STTS		0x0040
-#define QCOM_ICE_REG_NON_SEC_IRQ_MASK		0x0044
-
-#define QCOM_ICE_REG_NON_SEC_IRQ_CLR		0x0048
-#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME1	0x0050
-#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME2	0x0054
-#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME1	0x0058
-#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME2	0x005C
-#define QCOM_ICE_REG_STREAM1_BIST_ERROR_VEC	0x0060
-#define QCOM_ICE_REG_STREAM2_BIST_ERROR_VEC	0x0064
-#define QCOM_ICE_REG_STREAM1_BIST_FINISH_VEC	0x0068
-#define QCOM_ICE_REG_STREAM2_BIST_FINISH_VEC	0x006C
-#define QCOM_ICE_REG_BIST_STATUS		0x0070
-#define QCOM_ICE_REG_BYPASS_STATUS		0x0074
-#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
-#define QCOM_ICE_REG_ENDIAN_SWAP		0x1004
-#define QCOM_ICE_REG_TEST_BUS_CONTROL		0x1010
-#define QCOM_ICE_REG_TEST_BUS_REG		0x1014
-
-/* BIST ("built-in self-test"?) status flags */
-#define QCOM_ICE_BIST_STATUS_MASK		0xF0000000
-
-#define QCOM_ICE_FUSE_SETTING_MASK		0x1
-#define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
-#define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
-
-#define qcom_ice_writel(host, val, reg)	\
-	writel((val), (host)->ice_mmio + (reg))
-#define qcom_ice_readl(host, reg)	\
-	readl((host)->ice_mmio + (reg))
-
-static bool qcom_ice_supported(struct ufs_qcom_host *host)
-{
-	struct device *dev = host->hba->dev;
-	u32 regval = qcom_ice_readl(host, QCOM_ICE_REG_VERSION);
-	int major = regval >> 24;
-	int minor = (regval >> 16) & 0xFF;
-	int step = regval & 0xFFFF;
-
-	/* For now this driver only supports ICE version 3. */
-	if (major != 3) {
-		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
-			 major, minor, step);
-		return false;
-	}
-
-	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
-		 major, minor, step);
-
-	/* If fuses are blown, ICE might not work in the standard way. */
-	regval = qcom_ice_readl(host, QCOM_ICE_REG_FUSE_SETTING);
-	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
-		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
-		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
-		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
-		return false;
-	}
-	return true;
-}
-
-int ufs_qcom_ice_init(struct ufs_qcom_host *host)
-{
-	struct ufs_hba *hba = host->hba;
-	struct device *dev = hba->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
-	int err;
-
-	if (!(ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES) &
-	      MASK_CRYPTO_SUPPORT))
-		return 0;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice");
-	if (!res) {
-		dev_warn(dev, "ICE registers not found\n");
-		goto disable;
-	}
-
-	if (!qcom_scm_ice_available()) {
-		dev_warn(dev, "ICE SCM interface not found\n");
-		goto disable;
-	}
-
-	host->ice_mmio = devm_ioremap_resource(dev, res);
-	if (IS_ERR(host->ice_mmio)) {
-		err = PTR_ERR(host->ice_mmio);
-		return err;
-	}
-
-	if (!qcom_ice_supported(host))
-		goto disable;
-
-	return 0;
-
-disable:
-	dev_warn(dev, "Disabling inline encryption support\n");
-	hba->caps &= ~UFSHCD_CAP_CRYPTO;
-	return 0;
-}
-
-static void qcom_ice_low_power_mode_enable(struct ufs_qcom_host *host)
-{
-	u32 regval;
-
-	regval = qcom_ice_readl(host, QCOM_ICE_REG_ADVANCED_CONTROL);
-	/*
-	 * Enable low power mode sequence
-	 * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
-	 */
-	regval |= 0x7000;
-	qcom_ice_writel(host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
-}
-
-static void qcom_ice_optimization_enable(struct ufs_qcom_host *host)
-{
-	u32 regval;
-
-	/* ICE Optimizations Enable Sequence */
-	regval = qcom_ice_readl(host, QCOM_ICE_REG_ADVANCED_CONTROL);
-	regval |= 0xD807100;
-	/* ICE HPG requires delay before writing */
-	udelay(5);
-	qcom_ice_writel(host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
-	udelay(5);
-}
-
-int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
-{
-	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
-		return 0;
-	qcom_ice_low_power_mode_enable(host);
-	qcom_ice_optimization_enable(host);
-	return ufs_qcom_ice_resume(host);
-}
-
-/* Poll until all BIST bits are reset */
-static int qcom_ice_wait_bist_status(struct ufs_qcom_host *host)
-{
-	int count;
-	u32 reg;
-
-	for (count = 0; count < 100; count++) {
-		reg = qcom_ice_readl(host, QCOM_ICE_REG_BIST_STATUS);
-		if (!(reg & QCOM_ICE_BIST_STATUS_MASK))
-			break;
-		udelay(50);
-	}
-	if (reg)
-		return -ETIMEDOUT;
-	return 0;
-}
-
-int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
-{
-	int err;
-
-	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
-		return 0;
-
-	err = qcom_ice_wait_bist_status(host);
-	if (err) {
-		dev_err(host->hba->dev, "BIST status error (%d)\n", err);
-		return err;
-	}
-	return 0;
-}
-
-/*
- * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
- * vendor-specific SCM calls for this; it doesn't support the standard way.
- */
-int ufs_qcom_ice_program_key(struct ufs_hba *hba,
-			     const union ufs_crypto_cfg_entry *cfg, int slot)
-{
-	union ufs_crypto_cap_entry cap;
-	union {
-		u8 bytes[AES_256_XTS_KEY_SIZE];
-		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
-	} key;
-	int i;
-	int err;
-
-	if (!(cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE))
-		return qcom_scm_ice_invalidate_key(slot);
-
-	/* Only AES-256-XTS has been tested so far. */
-	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
-	if (cap.algorithm_id != UFS_CRYPTO_ALG_AES_XTS ||
-	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256) {
-		dev_err_ratelimited(hba->dev,
-				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
-				    cap.algorithm_id, cap.key_size);
-		return -EINVAL;
-	}
-
-	memcpy(key.bytes, cfg->crypto_key, AES_256_XTS_KEY_SIZE);
-
-	/*
-	 * The SCM call byte-swaps the 32-bit words of the key.  So we have to
-	 * do the same, in order for the final key be correct.
-	 */
-	for (i = 0; i < ARRAY_SIZE(key.words); i++)
-		__cpu_to_be32s(&key.words[i]);
-
-	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
-				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
-				   cfg->data_unit_size);
-	memzero_explicit(&key, sizeof(key));
-	return err;
-}
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 82d02e7f3b4f..e3c2b5c868c7 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -15,6 +15,8 @@
 #include <linux/reset-controller.h>
 #include <linux/devfreq.h>
 
+#include <soc/qcom/ice.h>
+
 #include <ufs/ufshcd.h>
 #include "ufshcd-pltfrm.h"
 #include <ufs/unipro.h>
@@ -55,6 +57,100 @@ static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 	return container_of(rcd, struct ufs_qcom_host, rcdev);
 }
 
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+
+static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
+{
+	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
+		qcom_ice_enable(host->ice);
+}
+
+static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
+{
+	struct ufs_hba *hba = host->hba;
+	struct device *dev = hba->dev;
+	struct qcom_ice *ice;
+
+	ice = of_qcom_ice_get(dev);
+	if (ice == ERR_PTR(-EOPNOTSUPP)) {
+		dev_warn(dev, "Disabling inline encryption support\n");
+		ice = NULL;
+	}
+
+	if (IS_ERR_OR_NULL(ice))
+		return PTR_ERR_OR_ZERO(ice);
+
+	host->ice = ice;
+	hba->caps |= UFSHCD_CAP_CRYPTO;
+
+	return 0;
+}
+
+static inline int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
+{
+	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
+		return qcom_ice_resume(host->ice);
+
+	return 0;
+}
+
+static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
+{
+	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
+		return qcom_ice_suspend(host->ice);
+
+	return 0;
+}
+
+static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
+				    const union ufs_crypto_cfg_entry *cfg,
+				    int slot)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	union ufs_crypto_cap_entry cap;
+	bool config_enable =
+		cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE;
+
+	/* Only AES-256-XTS has been tested so far. */
+	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
+	if (cap.algorithm_id != UFS_CRYPTO_ALG_AES_XTS ||
+	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
+		return -EINVAL;
+
+	if (config_enable)
+		return qcom_ice_program_key(host->ice,
+					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
+					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
+					    cfg->crypto_key,
+					    cfg->data_unit_size, slot);
+	else
+		return qcom_ice_evict_key(host->ice, slot);
+}
+
+#else
+
+#define ufs_qcom_ice_program_key NULL
+
+static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
+{
+}
+
+static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
+{
+	return 0;
+}
+
+static inline int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
+{
+	return 0;
+}
+
+static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
+{
+	return 0;
+}
+#endif
+
 static int ufs_qcom_host_clk_get(struct device *dev,
 		const char *name, struct clk **clk_out, bool optional)
 {
@@ -607,7 +703,7 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 		ufs_qcom_disable_lane_clks(host);
 	}
 
-	return 0;
+	return ufs_qcom_ice_suspend(host);
 }
 
 static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
@@ -853,7 +949,6 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
 	hba->caps |= UFSHCD_CAP_CLK_SCALING | UFSHCD_CAP_WB_WITH_CLK_SCALING;
 	hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
 	hba->caps |= UFSHCD_CAP_WB_EN;
-	hba->caps |= UFSHCD_CAP_CRYPTO;
 	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
 	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 39e774254fb2..6289ad5a42d0 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -7,6 +7,7 @@
 
 #include <linux/reset-controller.h>
 #include <linux/reset.h>
+#include <soc/qcom/ice.h>
 #include <ufs/ufshcd.h>
 
 #define MAX_UFS_QCOM_HOSTS	1
@@ -205,12 +206,13 @@ struct ufs_qcom_host {
 	struct clk *tx_l1_sync_clk;
 	bool is_lane_clks_enabled;
 
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	struct qcom_ice *ice;
+#endif
+
 	void __iomem *dev_ref_clk_ctrl_mmio;
 	bool is_dev_ref_clk_enabled;
 	struct ufs_hw_version hw_ver;
-#ifdef CONFIG_SCSI_UFS_CRYPTO
-	void __iomem *ice_mmio;
-#endif
 
 	u32 dev_ref_clk_en_mask;
 
@@ -248,28 +250,4 @@ static inline bool ufs_qcom_cap_qunipro(struct ufs_qcom_host *host)
 	return host->caps & UFS_QCOM_CAP_QUNIPRO;
 }
 
-/* ufs-qcom-ice.c */
-
-#ifdef CONFIG_SCSI_UFS_CRYPTO
-int ufs_qcom_ice_init(struct ufs_qcom_host *host);
-int ufs_qcom_ice_enable(struct ufs_qcom_host *host);
-int ufs_qcom_ice_resume(struct ufs_qcom_host *host);
-int ufs_qcom_ice_program_key(struct ufs_hba *hba,
-			     const union ufs_crypto_cfg_entry *cfg, int slot);
-#else
-static inline int ufs_qcom_ice_init(struct ufs_qcom_host *host)
-{
-	return 0;
-}
-static inline int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
-{
-	return 0;
-}
-static inline int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
-{
-	return 0;
-}
-#define ufs_qcom_ice_program_key NULL
-#endif /* !CONFIG_SCSI_UFS_CRYPTO */
-
 #endif /* UFS_QCOM_H_ */
-- 
2.34.1

