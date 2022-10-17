Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39D4600A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJQJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJQJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:13:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD6220D7;
        Mon, 17 Oct 2022 02:12:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i6so10174079pli.12;
        Mon, 17 Oct 2022 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHBNIUW9z/2UVO1t1aTu9DuLmSyAkbTh3vVXoH3jAOk=;
        b=X31FtlvHC4uad1WJglvo98c/eSXS3V8ftbi0zSAW857PhWnKigvNRvTD7TCDPsvS9n
         0giKWF6ckBbrqczsrI3uCkj6WrOp+KDYYw7VoP1z8cBvM//y6N+d/QnK+WRmThhkRLf5
         Ih73NlZf2sQiFxtBcEC2oZMjhd8sAbtkuuaTEI6PmTuxIZ8BymNDin4+kNHbeAOCdLRA
         JLQ85NQm06CwHubhg8N/X++KqMD23NEMI/7n8UgoPTLrXM8HhCdEosHYDtEAau9180HZ
         v4+0Ic+IhdEpIldJu+tii67IPwZppb831aL6kzX7qcVPj9u58IHK+JQv9KTtSCU92xeT
         U2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHBNIUW9z/2UVO1t1aTu9DuLmSyAkbTh3vVXoH3jAOk=;
        b=QZ/813o9fsNWJmYA694GTmnGshTxQhZfoTpq51Adgohkpr+/mka7z3cqrP16Ms6y9k
         RkgFaaxkzlbmL3Ko2ypTLmfOjj/Mr7UBl8TpDMfryXUlYHkK+dtY/Z8y5P9SerbTpuPn
         Td434zwI7IJDNaFVl5SwKnh78jV+xLL50b4WN0RQrxrdh8tUAZl3XmTeKCmrjcacVqs1
         s/h7IUxSJzu3k8eke0FbKECmvffHS/c3eBr3HtvezjJk8RH3eIt5mvK/XnIcHTadJtyo
         XrSbM15WgND8Rm96DAVN3eSC1flmItvQdy2FmTSTHUL8kxnZlcL0Pr/yVMf0EHP8oUAI
         Lj0Q==
X-Gm-Message-State: ACrzQf218cJnnAD3Z/8dGEhF+no10gKWRpRQ++u/RU4pSCdhWgmCYAzL
        pgZUfohqVDscHRgnXQF5Ub4=
X-Google-Smtp-Source: AMsMyM7gqQmEHTu94ec3LnsGiHnyEAP1dE4qwlYAY0N4lIowH/gGO/O0yVhwTEtnrzgwT5tzSgN/JQ==
X-Received: by 2002:a17:902:7009:b0:178:b9c9:979f with SMTP id y9-20020a170902700900b00178b9c9979fmr10661453plk.39.1665997967011;
        Mon, 17 Oct 2022 02:12:47 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:46 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 12/26] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Mon, 17 Oct 2022 17:11:39 +0800
Message-Id: <20221017091153.454873-13-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
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

