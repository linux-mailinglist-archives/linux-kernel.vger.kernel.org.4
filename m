Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA02604343
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiJSLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiJSLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:32:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B736DEE3;
        Wed, 19 Oct 2022 04:09:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so16441666pjl.3;
        Wed, 19 Oct 2022 04:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPy/Wu6p2dLpXSb6DKO5GwTstFivHbrMcCqV9r5eHbw=;
        b=p8L7V1IxRik3vHXKSuqwxP4WjcBko1v0ELWI41KoUMqPcCbR7/ypGxybSu38DSPbQM
         WjFN9rPmZOh7Jg3445WQPWTujSR6YsmxMfxsc/2jchrMKnFygf/rlVmFru55zbAG5JqB
         t5z3Z9Z+8qV1DGgD/Ljm4F0GMPoo4k4mSryaMWCZxXE/uZy32/oUbL5leFbPIk65YJ/I
         DIx14rsjvp3j8xS9GqUdheJnFaedmQNPXnF9vemqlPAtZD8M7fdiQ1aExZVmPwkTWcbI
         pJyHWmZtgWVHp6mju1C8pCaJEyZga8Mlgwj7vlwaG7o62gNkwv1d4+QBu705kvxP9vHN
         YpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPy/Wu6p2dLpXSb6DKO5GwTstFivHbrMcCqV9r5eHbw=;
        b=v1TXtvVKlT0Uy0XWPBsqgbp7xHrcSZC1Oty45h1o09k7U3LNACkFeOKIGoUBgZKZ/N
         KQvqApCjhl42NCNQ+P71b2GZpIRF8c/79x0KbG6Nnl9gwGZVheuVi/hT+sXINzsNdk1s
         wINB39oa1vSvWi9xrKcSvPF4nFlxaR8xFMZ9sJJYmbypMQ/tyL7KqM2fDRwflFxKta8r
         zeIKAFvvE1NN9gofds3wQR6gwzPuEyL+w7NMrvGKLOjoVSIjnvAIhDu+8HgY0KZcFAbB
         FHAy7my6D7TFzzB1u9xSjhI0EPCjYm3rCx4WXEJ+QOhXJ0mT4lWHYhLV8xfi0036Liny
         +VKw==
X-Gm-Message-State: ACrzQf1GX+q6V7Wb4yBycB3b/VqDcgGUUWmbjv6MUj8p17LZ7GCv6jS2
        /3F1NHoMFD32TDZvjM3DR/s=
X-Google-Smtp-Source: AMsMyM6M5J3f2ooU5c8yYkzhBqb8Y1Hmm53DPUe0Kk1vvh1yK8MNY23kw6BLgRbeS3Ib1OGZ215byQ==
X-Received: by 2002:a17:90b:3804:b0:20d:4e77:373a with SMTP id mq4-20020a17090b380400b0020d4e77373amr44915411pjb.212.1666177650806;
        Wed, 19 Oct 2022 04:07:30 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:30 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 11/26] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Wed, 19 Oct 2022 19:06:32 +0800
Message-Id: <20221019110647.11076-12-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
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

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-core.c |  1 +
 drivers/mmc/host/sdhci-pci-gli.c  |  1 +
 drivers/mmc/host/sdhci-uhs2.c     | 68 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h     |  3 ++
 drivers/mmc/host/sdhci.c          |  3 +-
 drivers/mmc/host/sdhci.h          | 14 +++++++
 6 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 34ea1acbb3cc..cba5bba994b8 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1955,6 +1955,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
 	.reset		= sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
+	.uhs2_reset		= sdhci_uhs2_reset,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4d509f656188..607cf69f45d0 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1097,6 +1097,7 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
 	.reset			= sdhci_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
+	.uhs2_reset		= sdhci_uhs2_reset,
 };
 
 const struct sdhci_pci_fixes sdhci_gl9755 = {
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 08905ed081fb..0e82f98d1967 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -10,6 +10,7 @@
  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 
 #include "sdhci.h"
@@ -49,6 +50,73 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+bool sdhci_uhs2_mode(struct sdhci_host *host)
+{
+	if ((host->mmc->caps2 & MMC_CAP2_SD_UHS2) &&
+	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+		(host->version >= SDHCI_SPEC_400) &&
+		(host->mmc->flags & MMC_UHS2_SUPPORT)))
+		return true;
+	else
+		return false;
+}
+
+/**
+ * sdhci_uhs2_reset - invoke SW reset
+ * @host: SDHCI host
+ * @mask: Control mask
+ *
+ * Invoke SW reset, depending on a bit in @mask and wait for completion.
+ */
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	unsigned long timeout;
+	u32 val;
+
+	if (!(sdhci_uhs2_mode(host))) {
+		/**
+		 * u8  mask for legacy.
+		 * u16 mask for uhs-2.
+		 */
+		u8 u8_mask;
+
+		u8_mask = (mask & 0xFF);
+		sdhci_reset(host, u8_mask);
+
+		return;
+	}
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL) {
+		host->clock = 0;
+		/* Reset-all turns off SD Bus Power */
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_off(host);
+	}
+
+	/* Wait max 100 ms */
+	timeout = 10000;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
+				     timeout, true, host, SDHCI_UHS2_SW_RESET)) {
+		pr_err("%s: %s: Reset 0x%x never completed.\n",
+					       __func__, mmc_hostname(host->mmc), (int)mask);
+		pr_err("%s: clean reset bit\n",
+					       mmc_hostname(host->mmc));
+		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index afdb05d6056b..31776dcca5cf 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -11,6 +11,7 @@
 #define __SDHCI_UHS2_H
 
 #include <linux/bits.h>
+#include <linux/iopoll.h>
 
 /*
  * UHS-II Controller registers
@@ -210,5 +211,7 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+bool sdhci_uhs2_mode(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2cdd183c8ada..bd017c59a020 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -194,13 +194,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 	pm_runtime_get_noresume(mmc_dev(host->mmc));
 }
 
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
 	if (!host->bus_on)
 		return;
 	host->bus_on = false;
 	pm_runtime_put_noidle(mmc_dev(host->mmc));
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
 
 void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bbed850241d4..28716105da61 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -715,6 +715,19 @@ struct sdhci_ops {
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void		(*reset)(struct sdhci_host *host, u8 mask);
+	/**
+	 * The sdhci_uhs2_reset callback is to implement for reset
+	 * @host: SDHCI host
+	 * @mask: Control mask
+	 *
+	 * Invoke reset, depending on a bit in @mask and wait for completion.
+	 * SD mode				UHS-II mode
+	 * SDHCI_RESET_ALL		SDHCI_UHS2_SW_RESET_FULL
+	 * SDHCI_RESET_CMD		SDHCI_RESET_CMD
+	 * SDHCI_RESET_DATA		SDHCI_UHS2_SW_RESET_SD
+	 *
+	 **/
+	void (*uhs2_reset)(struct sdhci_host *host, u16 mask);
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
 	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
@@ -837,6 +850,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
-- 
2.25.1

