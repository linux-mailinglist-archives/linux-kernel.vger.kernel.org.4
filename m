Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6269E5FED7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJNLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJNLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3723E95;
        Fri, 14 Oct 2022 04:47:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so4605728pjl.0;
        Fri, 14 Oct 2022 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHBNIUW9z/2UVO1t1aTu9DuLmSyAkbTh3vVXoH3jAOk=;
        b=lndqAbzXT9LczmuO2D+w7BdOTRkq8T/J+klhb1Mc4I93lpb7zSi4FOMqeiRsXe1kfH
         fUtDdNOhiI7qT21VG7i9XkOz6b/mLYZhC+GA7uMH70ZRRtG279ahOfE0T7a49ZLl0QDh
         bggXev/nHFm3+tKaE6hYhX/q9qw7d86RhR7DFrKScuWRGCdZPiyeCYtkEOtbxVK/8XLo
         ntrUtRAgR0SxVBcuq1sT77qxAxHNw20Prlmi7CEQnG/XtM8MykoYqAPJPRJba/PDER0K
         GJZYW3r8nbX7Lk0cv0BR+o6uLEZaLil6kmlU6lBFJOyeYWqh3RPo7PoLl/VhnOS83PC8
         8Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHBNIUW9z/2UVO1t1aTu9DuLmSyAkbTh3vVXoH3jAOk=;
        b=Q0oAZ0H2colYmkf623JvQHNwHItTblEgkTKG08iu3oIMJIZgcNXlyEYd8Yno2l2Zw8
         913Ko7BBINU+5vQwtsHuV92jFAnB3FgXyxLk8UQmo6mZm3NEDzIGiyM8URdVy4tPB/ka
         RGdUjW44+AK91GUm0ZH6gcFccrbtCNHU8ZRIEF7lokcKUQLQVMLurP6/89bZ1+V8VTqU
         5MLVUZbgKsc4oVKSQlEMLOP6aynXqNIKhpMP/3Ae45EX4nfFkLZCNPoDCNf8nSo6HGi8
         mVQg58E75E30b5iFzjc0bJovygDT47+g/O48q5FAk879/adsr0vV8VhNvoPFvDbsCBRL
         Ii8Q==
X-Gm-Message-State: ACrzQf2mmVXKHBxg9vXAxoGZIHvSp9ZcPz0L26FV5zzS02SQqd7mNiH2
        +cvP9noM9lA3b8ljovcI3BQ=
X-Google-Smtp-Source: AMsMyM5TR09ZIPoUWoa8oi2RAm+ksTQ2dnDaCGKyxnyKowZ6/tCeHi6H75rbd3UEsYiEO4ZnWgZ04Q==
X-Received: by 2002:a17:902:f806:b0:184:4a8c:f91f with SMTP id ix6-20020a170902f80600b001844a8cf91fmr4742305plb.45.1665748065038;
        Fri, 14 Oct 2022 04:47:45 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:44 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 12/26] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Fri, 14 Oct 2022 19:45:47 +0800
Message-Id: <20221014114601.15594-13-victor.shih@genesyslogic.com.tw>
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
index ab7ea55d9864..509e34f46659 100644
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
@@ -2036,41 +2037,48 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
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
index 3787ffe61c78..0d34ff4dca4e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -852,6 +852,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
+void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
@@ -862,6 +863,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
 				     unsigned short vdd);
+unsigned short sdhci_get_vdd_value(unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
-- 
2.25.1

