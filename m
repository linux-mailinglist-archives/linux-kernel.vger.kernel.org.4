Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3764B1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiLMJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiLMJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:04 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B5B1B1DC;
        Tue, 13 Dec 2022 01:01:44 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a14so1749823pfa.1;
        Tue, 13 Dec 2022 01:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLdW/4JhcA/FBpV6VuVkXlXWUSLT0iXj+6y89s8Gs48=;
        b=VQk31gV22yzNYD9p5E9Nlo8U0EybYLZV/LMTt69a5IB0aYYhirBcj6tSTmEvsfPEKd
         JI7c99OYHYjJ4aVe3ffXAhvahC3o3XJUbBHE2pV6S9mz7KX3C4f3uhdqzw5UE3PowFjK
         exBX1eZBNOD8V1abSx4XdXZCdLx26/5j1S1J0N9qX+ieX+o/eyM2/JJBY8EDwvZq37l3
         btMKad9Ikof42tPzd1D22wkptSt1qkaFfmlhwcbkW4jCO4ctO8neq+sZSZYcc08AWWzA
         mDPvk0iN/A5jUxuqAwe/MuSOtPtyaZZeRjwgHXT2t36dlaIbl/sR3iqy6nTh8vc9oFV7
         N92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLdW/4JhcA/FBpV6VuVkXlXWUSLT0iXj+6y89s8Gs48=;
        b=a0J6NKCcqZl3zQhmA+IOOgBIJaqx+E8OJqMF8aT4mALZbMLCXrWP8hAP3MCaFpMmmG
         XsJ9sSS1/qhsWk/hUcxb21SyGMrey/r+HDqSs04JH9qu6hXvPQURwkQXG0mpm35eeh77
         JmqDwQbvYtB5EQRsYfQ+dxbqMq59plv2jAYEyPKre9qZ7ED+90aI0U1Eid7RLxzx8sgX
         2G+dGu473nPxcgU50vFFl6tMotm965xu27kmP+wt7A0mQBEbZs9pvqG0QcF956zAD+K9
         kgJ2End1IM1+VYDXJBVeoLpeWKNaNnADSu4Z1DYJbSJCtWFPUJgJGCyE4jwlv89htfUi
         XbjA==
X-Gm-Message-State: ANoB5pmgKOZiPqELyHLm07glntZGz7YvGa/7xv+v6bifS56NfRv5lClM
        ufzrmKRzIoJ7YiXBAF6kfbI=
X-Google-Smtp-Source: AA0mqf7OudpW7dFi3UqStvzAUMmL7afVh0EBeJW+ft9RcXm9oh22BuTXkIbUIT+ydq/Nk2vIEHIp6Q==
X-Received: by 2002:aa7:920e:0:b0:566:900d:a1de with SMTP id 14-20020aa7920e000000b00566900da1demr18596953pfo.26.1670922103881;
        Tue, 13 Dec 2022 01:01:43 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:01:43 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 11/24] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Tue, 13 Dec 2022 17:00:34 +0800
Message-Id: <20221213090047.3805-12-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
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
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      | 63 +++++++++++++++++++----------------
 drivers/mmc/host/sdhci.h      |  1 +
 3 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index ae862e1eadab..780491781613 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
  *                                                                           *
 \*****************************************************************************/
 
+static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
+					    struct regulator *supply,
+					    unsigned short vdd_bit)
+{
+	return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
+}
+
 bool sdhci_uhs2_mode(struct sdhci_host *host)
 {
 	return host->mmc->flags & MMC_UHS2_SUPPORT;
@@ -95,6 +102,45 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
 
+static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
+			  unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr;
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
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
+	} else {
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		/* support 1.8v only for now */
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC_VDD2_165_195) - 1);
+
+		/* vdd first */
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9b66b9a32c72..99633a3ef549 100644
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
@@ -2061,41 +2061,48 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
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
index f41c19c76994..df7fa0c0ebf8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -840,6 +840,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
 				     unsigned short vdd);
+unsigned short sdhci_get_vdd_value(unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
-- 
2.25.1

