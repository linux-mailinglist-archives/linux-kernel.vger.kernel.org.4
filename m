Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1F600A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiJQJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiJQJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:13:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C5F4C638;
        Mon, 17 Oct 2022 02:12:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p14so10531578pfq.5;
        Mon, 17 Oct 2022 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBtBje6jwxU6FZyo8pZG+tr7pQu93ik7L6cy2pElzBc=;
        b=UxnETf7MYzw7P6abezqdTGQS5YZFycb+b52bdAKmN5xRNfjZs/l/cCgb1ivMwq2flM
         jjtf3GABSfMXd/Q2DM63NHfk9wwRbQ1jSQXXXZc+cQjcSVcJ8DO7jFc6pcNh2XEtcWKG
         UI+M4SMCGZp65QIKx4m5j3BmPF4+sWLlIrKXoNCdal20+8OadRHtnLTfcrchRgevZSHi
         HR4BQxVtR0xglRUwU9lkiS9ehGCeS90Dmvd4YYlt6EISU6GDjOAkYcRwGGjlqweiEcxU
         66vL3RhKVK1kPpkmY6yoe1TA+VOUtahjX+6soXHZB1djuCJlsRsolV0OEZUpShaxdKv1
         UowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBtBje6jwxU6FZyo8pZG+tr7pQu93ik7L6cy2pElzBc=;
        b=UlMiFOkcEp6wiVJX7gWl7w//9YyxK/f6DcFq15FcKD84VZdbmH2W9CZnIENZ0wiOtw
         MyBtQpaOt2dRqW1TgqeGPZD9yhoyCOmratSB2t0GXVK77H5rP0VpzYXv131on1DHChdU
         Zz2IfI4dyaWlANbLbHnRGWOXT6t4ZkcAQLdnIpaZuNu42GyJc1yap1k7mAioi99UOs0w
         MdWSTHzUwQPzIj0llWGw/VwJk2Nm4GBhuy3x4z5/TTfTc4oN2EGHG4XHqoQsvf0uLuSa
         Rg0lnMOL+eh80QWYIS+ouS89QMnX5/SeDcXRzo2Z+5JVvlQZNH2PRYobuAX0X1NL7sy+
         vZaw==
X-Gm-Message-State: ACrzQf0CdwOI1gYJjFV0vSKp2CT5o2BT2yIhIQvZYZV7P28+a9KULM2p
        xnSIE0twdu5AmCGx76rVcQA=
X-Google-Smtp-Source: AMsMyM4Ty+zSrlbvfx4ZqEptYlAqoLaNpTgDtPvjKcTY0WGpeN3Ja0zjdSY/6M8AMUMlrghFkQSMDg==
X-Received: by 2002:a63:187:0:b0:43b:cf3c:c64d with SMTP id 129-20020a630187000000b0043bcf3cc64dmr9895772pgb.359.1665997963702;
        Mon, 17 Oct 2022 02:12:43 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:43 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 11/26] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Mon, 17 Oct 2022 17:11:38 +0800
Message-Id: <20221017091153.454873-12-victor.shih@genesyslogic.com.tw>
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

