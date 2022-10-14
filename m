Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F45FED77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJNLso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiJNLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83C23E8F;
        Fri, 14 Oct 2022 04:47:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b5so4094444pgb.6;
        Fri, 14 Oct 2022 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBtBje6jwxU6FZyo8pZG+tr7pQu93ik7L6cy2pElzBc=;
        b=AXRUAK4w+P2pT5uQM+ojM5oyQeeQsCrKl+MawPQZ0Mit5NN2yK3aRcAxLRzBzGekTO
         lsbh24++f52Fr6DaeiDFF9GKusFaY+cfFwN5B3Tc/YccyY3WMrSyMT67ZD8Ari2DyCkR
         bT1Yo/5YfiDlwpUm+XqiehN743ZbphnTJWsQd2R5n3HpH6+CHg4s3PDRxWgVJdCklreS
         G5tDujcNwBpdGKeLBTIOnhuwBRKQDl3BhHS8/nmkDaMIHO0jlwHLbbaYzz6RjXddbR/5
         nqtA3Medf5QTuY8hrm5ml1qfeKrEWi8wTSjNYfI4KJdgs1tUZaQaf95lnBfSy2RLwkc/
         zHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBtBje6jwxU6FZyo8pZG+tr7pQu93ik7L6cy2pElzBc=;
        b=DYPKnoUOH4uaYiQ031FnauZ9e/l3HMHxFEdO8nKrCKEn95MwkGZHbEpyDegL98WH0I
         3mZ2TpDqCAInNaSrubcRncxxCDUX14uf2Kp7uzsXJXtVDv/qu9odDcHSGKjVl3a4E2o0
         mxg0g2rIRvBxe9e+tYPLA0ecEVNsQsO+XKqVDLISIeA70RB6yPOjoEhauTxndLUcwCAR
         4g+id4WPfDH/A+wjqQ3njxTXzpbWFxdrAeGVJwmSGLOT8OR6qiaGl1rVas2LJ57777CA
         GbwhUgCgUZX8XWrUAtm2v70F0XXFOMXxiiHlgzYLL3NSWs1A0MQPU/2FkW28vM6gt9Hh
         4+eA==
X-Gm-Message-State: ACrzQf2utI/BIIVahpCotmiW7E4z4Vtpc5LjH3MAC+D5vWCHLyS7HVfT
        dHZ4uFQLs457WfJevgLGJZw=
X-Google-Smtp-Source: AMsMyM71riYWLoRAq2j2LarMGtBqPbzZb24Xq482VsZ+dt2gXbTnWw+xylNTGdW2lHy02mpMM5Sxxw==
X-Received: by 2002:a63:91c2:0:b0:460:609c:e60f with SMTP id l185-20020a6391c2000000b00460609ce60fmr4219865pge.447.1665748062199;
        Fri, 14 Oct 2022 04:47:42 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:41 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 11/26] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Fri, 14 Oct 2022 19:45:46 +0800
Message-Id: <20221014114601.15594-12-victor.shih@genesyslogic.com.tw>
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
index 622b7de96c7f..a187379ad204 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1926,6 +1926,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
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
index 4434838475bf..ab7ea55d9864 100644
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
index 64c2d7e78e29..3787ffe61c78 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -717,6 +717,19 @@ struct sdhci_ops {
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
@@ -839,6 +852,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
-- 
2.25.1

