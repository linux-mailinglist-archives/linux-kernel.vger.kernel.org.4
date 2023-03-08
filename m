Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF0A6B0E00
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjCHQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjCHP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:59:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC45D46F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:59:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1640688wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEs1t8veFU2tAvwhzpLGeaw/srw6hGu66SINC0C8SMg=;
        b=lZMITYyUo2Wp2TP36HtU79j/jz+BNlG/tLVNUMGd+ZpkK0G3NATNqrdmAca9aUgyZJ
         pGwuUef/Ben0+2BkPjTqG27BzXM/gV/TzxlHGRSSwUIlk9L8v+TknI6BEQ8JP5CbdYjv
         rvQ47t++gIJVvjIKDo23YrTCRW0qnbWRBrp4DeK0TRrHg14oq1n0ZiXWTuoKvwwSOBMy
         TN5ek2xsVC4OrB/vbQHSu88X9r2dzwVhudBQOzrxXkotE2iL9KGZjwzSiO5VInavujXv
         wzOiwhXyfKh0kVQPnO5qxTVvlh5ZtFwOPp80WDHxbsj2AodaWmn2YK4PTi7hR9NuWuCE
         3cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEs1t8veFU2tAvwhzpLGeaw/srw6hGu66SINC0C8SMg=;
        b=gBWC5y4S57fWW5dPWaiST7zRjUYt2V7ODvY8nczGdi8LzBoxV+42LuocOJfExQOnnp
         s3jP2n2aqJhtgSgJElHhGGQBmJHSkXJmRWrCQCG8YmaN86f+MpAWn5k29ZGEZcclPXNq
         yClEPpsz92FTs2QgWTN7ejQxCVPkL8aIALUL8Wskw5FpjrTnHA3whh3+uc1Lwj63+BuY
         dYN0KARt5KbyJzzTp0AXYzamzMtWHPjaXkwOimlQF6QFB69eDekRNEKTrdmYS9wUaAuy
         mnhmUsoTXJH4vc3Q6BUwMF3KYP/SePioPQE8FwtwGacsZxhfXGBqls3tLFDJudm/ByWu
         LkJQ==
X-Gm-Message-State: AO0yUKXD7RcRIsM+/ngThff4j/8vVKsYssGbwDt6OwEOrg3OH7GZSFtW
        DzYeoiYLgJwe1RY8XUdGGpuQvQ==
X-Google-Smtp-Source: AK7set9MsjueZmqXimsxiGvEXrQp3DQHRFoAipS7VoLWqI6/qLv1FpLCsvZmdICdbJExSZtaVDAi+w==
X-Received: by 2002:a05:600c:3ac8:b0:3da:28a9:a900 with SMTP id d8-20020a05600c3ac800b003da28a9a900mr16554117wms.41.1678291156126;
        Wed, 08 Mar 2023 07:59:16 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2548430wmf.2.2023.03.08.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:59:15 -0800 (PST)
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
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH v2 5/7] scsi: ufs: ufs-qcom: Switch to the new ICE API
Date:   Wed,  8 Mar 2023 17:58:36 +0200
Message-Id: <20230308155838.1094920-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308155838.1094920-1-abel.vesa@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is a new dedicated ICE driver, drop the ufs-qcom-ice and
use the new ICE api provided by the Qualcomm soc driver qcom-ice.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * Added a check for supported algorithm and key size
   and passed the ICE defined values for algorithm and key size
 * Added call to evict function

 drivers/ufs/host/Kconfig        |   2 +-
 drivers/ufs/host/Makefile       |   1 -
 drivers/ufs/host/ufs-qcom-ice.c | 244 --------------------------------
 drivers/ufs/host/ufs-qcom.c     |  50 +++++--
 drivers/ufs/host/ufs-qcom.h     |  30 +---
 5 files changed, 46 insertions(+), 281 deletions(-)
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
index d7c5bf7fa512..081b332fe7ce 100644
--- a/drivers/ufs/host/Makefile
+++ b/drivers/ufs/host/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-d
 obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
 ufs_qcom-y += ufs-qcom.o
-ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
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
index 34fc453f3eb1..f61f957e6d32 100644
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
@@ -378,7 +380,7 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 		/* check if UFS PHY moved from DISABLED to HIBERN8 */
 		err = ufs_qcom_check_hibern8(hba);
 		ufs_qcom_enable_hw_clk_gating(hba);
-		ufs_qcom_ice_enable(host);
+		qcom_ice_enable(host->ice);
 		break;
 	default:
 		dev_err(hba->dev, "%s: invalid status %d\n", __func__, status);
@@ -634,7 +636,10 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			return err;
 	}
 
-	return ufs_qcom_ice_resume(host);
+	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
+		return 0;
+
+	return qcom_ice_resume(host->ice);
 }
 
 static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_qcom_host *host, bool enable)
@@ -1034,9 +1039,9 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	ufs_qcom_set_caps(hba);
 	ufs_qcom_advertise_quirks(hba);
 
-	err = ufs_qcom_ice_init(host);
-	if (err)
-		goto out_variant_clear;
+	host->ice = of_qcom_ice_get(dev);
+	if (IS_ERR(host->ice))
+		return PTR_ERR(host->ice);
 
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 
@@ -1384,8 +1389,8 @@ static int ufs_qcom_device_reset(struct ufs_hba *hba)
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
-					struct devfreq_dev_profile *p,
-					struct devfreq_simple_ondemand_data *d)
+					  struct devfreq_dev_profile *p,
+					  struct devfreq_simple_ondemand_data *d)
 {
 	p->polling_ms = 60;
 	d->upthreshold = 70;
@@ -1399,6 +1404,33 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+int ufs_qcom_program_key(struct ufs_hba *hba,
+			 const union ufs_crypto_cfg_entry *cfg, int slot)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	union ufs_crypto_cap_entry cap;
+	bool config_enable =
+		cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE;
+
+	/* Only AES-256-XTS has been tested so far. */
+	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
+	if (cap.algorithm_id != UFS_CRYPTO_ALG_AES_XTS ||
+		cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
+		return -EINVAL;
+
+	if (config_enable)
+		return qcom_ice_program_key(host->ice,
+					    cfg->crypto_cap_idx,
+					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
+					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
+					    cfg->crypto_key,
+					    cfg->data_unit_size, slot);
+	else
+		return qcom_ice_evict_key(host->ice, slot);
+}
+#endif
+
 static void ufs_qcom_reinit_notify(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1651,7 +1683,9 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.dbg_register_dump	= ufs_qcom_dump_dbg_regs,
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
-	.program_key		= ufs_qcom_ice_program_key,
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	.program_key		= ufs_qcom_program_key,
+#endif
 	.reinit_notify		= ufs_qcom_reinit_notify,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 39e774254fb2..fea39ccd90fc 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -7,6 +7,7 @@
 
 #include <linux/reset-controller.h>
 #include <linux/reset.h>
+#include <soc/qcom/ice.h>
 #include <ufs/ufshcd.h>
 
 #define MAX_UFS_QCOM_HOSTS	1
@@ -205,12 +206,11 @@ struct ufs_qcom_host {
 	struct clk *tx_l1_sync_clk;
 	bool is_lane_clks_enabled;
 
+	struct qcom_ice *ice;
+
 	void __iomem *dev_ref_clk_ctrl_mmio;
 	bool is_dev_ref_clk_enabled;
 	struct ufs_hw_version hw_ver;
-#ifdef CONFIG_SCSI_UFS_CRYPTO
-	void __iomem *ice_mmio;
-#endif
 
 	u32 dev_ref_clk_en_mask;
 
@@ -248,28 +248,4 @@ static inline bool ufs_qcom_cap_qunipro(struct ufs_qcom_host *host)
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

