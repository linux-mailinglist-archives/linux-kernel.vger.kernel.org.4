Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F117380DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFUKD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjFUKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:02:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DC1FF2;
        Wed, 21 Jun 2023 03:02:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687446eaccso2905612b3a.3;
        Wed, 21 Jun 2023 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341731; x=1689933731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC3lp0q4Mb+CxQ7PUZ0jSQlhjZM29av+3JcrTpkGDh8=;
        b=g7mvtcf6lAH/xq7fLPhrHgzQw2oFiUuAadWMyHXz1kwwCziFMc81q0oNTfZTN04oeJ
         5YklmiYggTpF4oUwLqCPVeime2Bia7EFhaahDkR6d+HaY+lHyAKX28KByJd9K1BtdEzQ
         KFNZXaG2Qsob3UXCuiwF2tezAt3zCTQPzgItt4MFTOsXKjRPKbfZP2Ft95SqM5F4/3Sq
         NCO2sDAg4L7mz4saD3OXGNmGMlNzT14i0hBezNGGVsg3A37+fyEHX08opUqAHNpHwkKh
         W6itPvCZnJlL1xIsFltgmrvMiK/dIpRRy4hTYyWbOe0BBLv9Rj3aevJxhseHRVQFlx0p
         fo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341731; x=1689933731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC3lp0q4Mb+CxQ7PUZ0jSQlhjZM29av+3JcrTpkGDh8=;
        b=I3i/L2ViTwsoo2GsSkjxITjovxAWPGNMh46m0g+pxA/fVYlroPvdfKiASbCcjgE3J2
         HJ2WhzsScSzFtMSra4r/i2L1HEBMI/1W4FWHVWDGlwFrhj3aKhzWB0g1xAXE0RALYd1x
         paN3nKx8D6/Yzvf4Z1+O7wFVkwkR07LmOBxRzrMn+txAKm0wdBukUbj9FKPbT178elR6
         7uRWKWPDCdKZBUzeRxhBagKK1s7SOtnOllN7XGVUYUneu8F6RGAdWBKg/gZbMD0BKcXK
         pgJy5Z4EG0ihVcNXOys6VsP27s0BbmFbAcWgTdUKHhtgGL6ISr4txm9yzVOD4sBu702p
         dbCA==
X-Gm-Message-State: AC+VfDyWM3me2NhpHpfVHUeyMb1qy55zkc92p/F8Xq8Y0R16ffnNg/K9
        5+CmB65AlfQdNfhAT45Gy6w=
X-Google-Smtp-Source: ACHHUZ5U3ZYv77UpdFc3km1IlWmTz7y5O8p6haJziGG/ZJkzKLGU0QF0/qC62Gw4G+jorWuHepEwjg==
X-Received: by 2002:a05:6a00:1798:b0:66a:2771:6c42 with SMTP id s24-20020a056a00179800b0066a27716c42mr4320467pfg.0.1687341730809;
        Wed, 21 Jun 2023 03:02:10 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:10 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 04/23] mmc: core: Extend support for mmc regulators with a vqmmc2
Date:   Wed, 21 Jun 2023 18:01:32 +0800
Message-Id: <20230621100151.6329-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621100151.6329-1-victorshihgli@gmail.com>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Updates in V8:
 - Adjust typographic warnings.

Updates in V4:
 - Moved the voltage defines into this patch.

Update in previous version:
To allow an additional external regulator to be controlled by an mmc host
driver, let's add support for a vqmmc2 regulator to the mmc core.

For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
this too.

Note that, to allow for flexibility mmc host drivers need to manage the
enable/disable of the vqmmc2 regulator themselves, while the regulator is
looked up through the common mmc_regulator_get_supply().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 005247a49e51..a2fee9322c93 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -226,6 +226,33 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
 
+/**
+ * mmc_regulator_set_vqmmc2 - Set vqmmc2 as per the ios->vqmmc2_voltage
+ * @mmc: The mmc host to regulate
+ * @ios: The io bus settings
+ *
+ * Sets a new voltage level for the vqmmc2 regulator, which may correspond to
+ * the vdd2 regulator for an SD UHS-II interface. This function is expected to
+ * be called by mmc host drivers.
+ *
+ * Returns a negative error code on failure, zero if the voltage level was
+ * changed successfully or a positive value if the level didn't need to change.
+ */
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	if (IS_ERR(mmc->supply.vqmmc2))
+		return -EINVAL;
+
+	switch (ios->vqmmc2_voltage) {
+	case MMC_VQMMC2_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc2,
+							      1700000, 1800000, 1950000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc2);
+
 #else
 
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
@@ -252,6 +279,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -271,6 +299,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vqmmc2)) {
+		if (PTR_ERR(mmc->supply.vqmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vqmmc2 regulator found\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a27bb520bf9a..703f5ce9713c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -74,6 +74,9 @@ struct mmc_ios {
 #define MMC_SIGNAL_VOLTAGE_180	1
 #define MMC_SIGNAL_VOLTAGE_120	2
 
+	unsigned char	vqmmc2_voltage;
+#define MMC_VQMMC2_VOLTAGE_180	0
+
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
 #define MMC_SET_DRIVER_TYPE_B	0
@@ -324,6 +327,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -605,6 +609,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -618,6 +623,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 {
 	return -EINVAL;
 }
+
+static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
+					   struct mmc_ios *ios)
+{
+	return -EINVAL;
+}
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
-- 
2.25.1

