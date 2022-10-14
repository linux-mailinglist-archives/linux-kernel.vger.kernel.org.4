Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70135FED63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJNLrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJNLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:47:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E52E10D6B6;
        Fri, 14 Oct 2022 04:47:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 204so4661194pfx.10;
        Fri, 14 Oct 2022 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCH8Igg1orUCvBJ3wNzvtOpE3BVsidt9yGsLk/7NTnE=;
        b=TUz5JqfxAn047ecKHPyQ5cKY5bFxO0YV4ofPoKW8vCVlGjHbYRKdaXzo8UHZHE8tmF
         B6/LJyVdTwItSbpsDyzDBV8u4+TiQR1SH1F5e7WiW2eUzOCFj1DC2SA+rMrN1/xts4tj
         21t3OjqyhQE5TPryv7IEeh4m+W7dEoyPHFF4KB4rJQXHBh8F1Of1a8Uc+14xhnGnCZaC
         FkzZ+lZR+rzIcjjVOvkgIgv5SdmpZVS2C7FMFDZhsLK06zgo9xmFc9fQGLH9gR4iSUvB
         2Q/rSemq1rl66yHenxhAW5IStRcv7Nhkj/U5EXWx9AYagKJm9bvndwenkg3oay76LFx8
         w+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCH8Igg1orUCvBJ3wNzvtOpE3BVsidt9yGsLk/7NTnE=;
        b=A0neF8mjTiXlcM4rqGSu6LduPcgQp5Ec4BmmdMKMh0u41o1e7v2O/PQGgl2aYtiXhs
         GCw1jYE4HbRbfM4CrtyDlbTFvwh5ft4a3LuArHQ0bkychbW/uGtSVqVMNqGWeObvul1B
         TVyImmoHqgxiVSvQ9hWbEpIBeTx+/3YCb1ny311cqVuC24gQJ2Bq8Q6qPzbh1CatS1iM
         7WKlIkdux4qHNKVAw41K3gKzSbCxoxwvyN00pkC+43wbzIpgP9IR39yuuDkkGA14Akvd
         H9Dd+OVAFYHVRc4MFGXIQ3ChpxQQYhtuLiYAfeUwE/MohbpZFB72aPlOqxGABa7m09l3
         4A/Q==
X-Gm-Message-State: ACrzQf3bwWavs3K7MQgniY2+PAAyrkVkJGFHc8n72XEooYoFwKZaxAS3
        L7/duwrsg8WbZhwC54cVFZI=
X-Google-Smtp-Source: AMsMyM7xCUcHwRSPyXzfrorrw0OMUL8B5l13gEoVgAWBKMHyqc96t+rqEqQ6ig+oaTLha12wwW/kBg==
X-Received: by 2002:a63:fe13:0:b0:452:2b86:50fb with SMTP id p19-20020a63fe13000000b004522b8650fbmr4178384pgh.167.1665748041293;
        Fri, 14 Oct 2022 04:47:21 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:20 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 04/26] mmc: core: Extend support for mmc regulators with a vqmmc2
Date:   Fri, 14 Oct 2022 19:45:39 +0800
Message-Id: <20221014114601.15594-5-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

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
---
 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a467ef..3c189682797c 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -223,6 +223,33 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
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
+		return mmc_regulator_set_voltage_if_supported(
+			mmc->supply.vqmmc2, 1700000, 1800000, 1950000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc2);
+
 #else
 
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
@@ -249,6 +276,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -268,6 +296,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
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
index 0b4122b26352..cc2cd502ae29 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -71,6 +71,9 @@ struct mmc_ios {
 #define MMC_SIGNAL_VOLTAGE_180	1
 #define MMC_SIGNAL_VOLTAGE_120	2
 
+	unsigned char	vqmmc2_voltage;
+#define MMC_VQMMC2_VOLTAGE_180	0
+
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
 #define MMC_SET_DRIVER_TYPE_B	0
@@ -321,6 +324,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -600,6 +604,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -613,6 +618,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
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

