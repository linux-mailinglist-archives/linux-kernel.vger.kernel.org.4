Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70C260435C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiJSLex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiJSLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:33:57 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79EB266D;
        Wed, 19 Oct 2022 04:10:47 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id b2so16908107plc.7;
        Wed, 19 Oct 2022 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z/eLscINV3GBbOtMGwuEQy/2sY+DAl8YV1LNIReyKg=;
        b=iPM+46+GmUKSVUEuMRTW+G5VX+Vt9274qHcMl5ekcbPHe7n8HZk3exGIMkWf5kwWLX
         RUhhhkeU6dmgaobf5hkCrQfyNWikowEnsTC26cRBz4wwypJgkmgrg72Npzb+tsapdLrC
         xBAx4hhVh8d36F8bO6jrMnYFJd2WhJUfPJAs97Qiwy99zFUOD2d904KCsy6mO0n1sYFY
         ANs5bzmhbEBDG1ws/GBYxEtIYDmP61YQU08/xuYqlVubFY/s8aDOCuD6/5wN3N36J7/Z
         vPMHbRkQNxAPaonDQGXz73i5QhzIblyq+RMrRrOO27kwboPlVYDr70DK3LmyIfM/CTpY
         L7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z/eLscINV3GBbOtMGwuEQy/2sY+DAl8YV1LNIReyKg=;
        b=sMN6EPY7XV6ebap8xjXsJrHy2oXPwUpzoXWC874NCsDs/wOmX5pYPAHFw6s1NRn8PX
         Co30IJV5QeQbTOT7UZ8FHEDUBEaKmg9bWHUJwWWrGxQTJx5PdQiGIchvtY4lt++fVCFl
         XKQEJZJjOeTvZQrR7dtf8/YxX9i4aktf25wft3gS67cktt+Xk2jUEAd/OoY5pO4veep9
         36R2JZzhIedmRxxHc51B3KZWpNYYNFgiTvrA+fA10XLtmULLPbVALf+5UCOempl3seDp
         +FED2cei3lSWZfyFCJsSXm8KeWJHQIamgQJdIBs6+wUSQCrICFZF28zNYzCCWcTB6jmV
         fBSQ==
X-Gm-Message-State: ACrzQf1bfqyro5amLm74ize5Ye17mvWlpJ7SdEq+/Pau8ijZy/M0CUUG
        VK3uV58f3O+nxdEy7XNY9Ag=
X-Google-Smtp-Source: AMsMyM72ggzKNoPbtBUDUGTYUSF/mgBhw4JxXl2nnD2Jlp0NyKzHsPtYnpmCP3AKaJaY5kPirX5GeA==
X-Received: by 2002:a17:90a:d990:b0:20d:9c20:90c with SMTP id d16-20020a17090ad99000b0020d9c20090cmr9368752pjv.203.1666177653850;
        Wed, 19 Oct 2022 04:07:33 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:33 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 12/26] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Wed, 19 Oct 2022 19:06:33 +0800
Message-Id: <20221019110647.11076-13-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a UHS-II version of sdhci's set_power operation.
VDD2, as well as VDD, is handled here.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 79 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 drivers/mmc/host/sdhci.c      | 66 ++++++++++++++++-------------
 drivers/mmc/host/sdhci.h      |  2 +
 4 files changed, 120 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0e82f98d1967..896a1c8e55cf 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -117,6 +117,85 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
 
+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
+			  unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr;
+
+	/* FIXME: check if flags & MMC_UHS2_SUPPORT? */
+	if (!(sdhci_uhs2_mode(host))) {
+		sdhci_set_power(host, mode, vdd);
+		return;
+	}
+
+	if (mode != MMC_POWER_OFF) {
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
+
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_off(host);
+	} else {
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
+			/* support 1.8v only for now */
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2,
+					      fls(MMC_VDD2_165_195) - 1);
+
+		/*
+		 * Spec says that we should clear the power reg before setting
+		 * a new value. Some controllers don't seem to like this though.
+		 */
+		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))
+			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		/*
+		 * At least the Marvell CaFe chip gets confused if we set the
+		 * voltage and set turn on power at the same time, so set the
+		 * voltage first.
+		 */
+		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
+			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+		/* vdd first */
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_on(host);
+
+		/*
+		 * Some controllers need an extra 10ms delay of 10ms before
+		 * they can apply clock after applying power
+		 */
+		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
+			mdelay(10);
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 31776dcca5cf..3179915f7f79 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -213,5 +213,7 @@ struct sdhci_host;
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 bool sdhci_uhs2_mode(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
+			  unsigned short vdd);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bd017c59a020..dfa0939a9058 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -23,7 +23,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-
+#include <linux/bug.h>
 #include <linux/leds.h>
 
 #include <linux/mmc/mmc.h>
@@ -186,13 +186,14 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 	sdhci_set_card_detection(host, false);
 }
 
-static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 {
 	if (host->bus_on)
 		return;
 	host->bus_on = true;
 	pm_runtime_get_noresume(mmc_dev(host->mmc));
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_on);
 
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
@@ -2071,41 +2072,48 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 }
 
+unsigned short sdhci_get_vdd_value(unsigned short vdd)
+{
+	u8 pwr;
+
+	switch (1 << vdd) {
+	case MMC_VDD_165_195:
+	/*
+	 * Without a regulator, SDHCI does not support 2.0v
+	 * so we only get here if the driver deliberately
+	 * added the 2.0v range to ocr_avail. Map it to 1.8v
+	 * for the purpose of turning on the power.
+	 */
+	case MMC_VDD_20_21:
+		pwr = SDHCI_POWER_180;
+		break;
+	case MMC_VDD_29_30:
+	case MMC_VDD_30_31:
+		pwr = SDHCI_POWER_300;
+		break;
+	case MMC_VDD_32_33:
+	case MMC_VDD_33_34:
+		pwr = SDHCI_POWER_330;
+		break;
+	default:
+		pwr = 0;
+		break;
+	}
+
+	return pwr;
+}
+EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
+
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd)
 {
 	u8 pwr = 0;
 
 	if (mode != MMC_POWER_OFF) {
-		switch (1 << vdd) {
-		case MMC_VDD_165_195:
-		/*
-		 * Without a regulator, SDHCI does not support 2.0v
-		 * so we only get here if the driver deliberately
-		 * added the 2.0v range to ocr_avail. Map it to 1.8v
-		 * for the purpose of turning on the power.
-		 */
-		case MMC_VDD_20_21:
-			pwr = SDHCI_POWER_180;
-			break;
-		case MMC_VDD_29_30:
-		case MMC_VDD_30_31:
-			pwr = SDHCI_POWER_300;
-			break;
-		case MMC_VDD_32_33:
-		case MMC_VDD_33_34:
-		/*
-		 * 3.4 ~ 3.6V are valid only for those platforms where it's
-		 * known that the voltage range is supported by hardware.
-		 */
-		case MMC_VDD_34_35:
-		case MMC_VDD_35_36:
-			pwr = SDHCI_POWER_330;
-			break;
-		default:
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr) {
 			WARN(1, "%s: Invalid vdd %#x\n",
 			     mmc_hostname(host->mmc), vdd);
-			break;
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 28716105da61..c34ca6ffbff6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -850,6 +850,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
+void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
@@ -860,6 +861,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
 				     unsigned short vdd);
+unsigned short sdhci_get_vdd_value(unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
-- 
2.25.1

