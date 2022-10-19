Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6E604354
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiJSLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiJSLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:33:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564117FD71;
        Wed, 19 Oct 2022 04:10:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b5so15933267pgb.6;
        Wed, 19 Oct 2022 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPQVys15eu1tuvKpjQ4yda21hY2zSbE/62rYU9h8DZU=;
        b=d97RiKxRQF250fibCNEkSj5gw9g2cqxuqkt55EiJVHbAFamyrfGSTK+u01/+rCM6Nr
         QAl9Y/hIhG4/ogDVf6litFcJfcOlab5VrbHXXtr6xTleH37+fD9xP7ZEoIFid4FJBXHM
         MwH5saSNxmkYcu16OluxbPtb9ow4y4xn5fOeRP1ERScCCrJHWUhI+UuiHmXRLbt+yJOt
         Lx2ZBEeL/Xpfux/0pNZ3YB28beo4+b1gylArNhFxDevPREHHEo89UTnEJaT+VR8H1isJ
         RnryhRq4xdykTjkyajQJhQn/XWA5mDYaTs3SFzn2cMJYI7yoSEplxtVs9fyiY1DOv9wM
         v9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPQVys15eu1tuvKpjQ4yda21hY2zSbE/62rYU9h8DZU=;
        b=mHzYjKMQLN5DN4szgID/S6r11mwfoxV9e8d4HCJL8gK7w+uKKEelTybHTbEo6gSh+h
         ZvLwI6hbL6bhrnXpA63Th8v/9hFDUgxe7k3s55VP1HcV6/Jlna9Dxlp35MWKKlEfn5Zu
         8pd79O1K3fWq+2TtZ95DRbiAbe85c8IoIMCma+1IAZNQ8Rom1SBrK/3BbAVaDuBQOqFc
         aZP3WF7YaElq2F023cpKh5dxP26WAnU4D7HB/Cb1FFWtYYt7AeZK1loERmfXDaVDmbHt
         nNf6oDTjUNVLjts1aTJClMtVU6q+V0Slio6TUNZaCNrNZHrIIRN/MDxObrk2VyuhjTNt
         CMKQ==
X-Gm-Message-State: ACrzQf0RvyjguMEujNSQb0ztUEJcdxPjZbyMvFR16zyEJss/ehG0c6AQ
        Pd9JH9TNEaGiJtY+4xDWkJI=
X-Google-Smtp-Source: AMsMyM6EPuRCjzFe33RDymbR6nXdB9T6yoXEgAHIYv8mwp5hwhThG6ER4GCi5wUXkjtnWRWbYPYqOw==
X-Received: by 2002:a65:6bc7:0:b0:44a:dcee:18a5 with SMTP id e7-20020a656bc7000000b0044adcee18a5mr6642067pgw.413.1666177681470;
        Wed, 19 Oct 2022 04:08:01 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:08:01 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 21/26] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date:   Wed, 19 Oct 2022 19:06:42 +0800
Message-Id: <20221019110647.11076-22-victor.shih@genesyslogic.com.tw>
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

This is a UHS-II version of sdhci's add_host/remove_host operation.
Any sdhci drivers which are capable of handling UHS-II cards must
call those functions instead of the corresponding sdhci's.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 172 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   2 +
 drivers/mmc/host/sdhci.c      |  21 +++--
 drivers/mmc/host/sdhci.h      |   9 ++
 4 files changed, 197 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 883e18d849ad..eb3241bf95a2 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -15,6 +15,7 @@
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mmc/mmc.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -1177,6 +1178,177 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*****************************************************************************\
+ *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	if (host->version < SDHCI_SPEC_400)
+		return 0;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2)
+		mmc->caps2 |= MMC_CAP2_SD_UHS2;
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_SUPPORT_VDD2_180) &&
+	    !max_current_caps2 &&
+	    !IS_ERR(mmc->supply.vmmc2)) {
+		/* UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vmmc2);
+
+		if (curr > 0) {
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr / 1000;  /* convert to mA */
+			curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
+			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps2 = curr;
+		}
+	}
+
+	if (caps1 & SDHCI_SUPPORT_VDD2_180) {
+		mmc->ocr_avail_uhs2 |= MMC_VDD2_165_195;
+		/*
+		 * UHS2 doesn't require this. Only UHS-I bus needs to set
+		 * max current.
+		 */
+		mmc->max_current_180_vdd2 = (max_current_caps2 &
+					SDHCI_MAX_CURRENT_VDD2_180_MASK) *
+					SDHCI_MAX_CURRENT_MULTIPLIER;
+	} else {
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+	}
+
+	return 0;
+}
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
+
+static int __sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI;
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	if ((mmc->caps2 & MMC_CAP2_CQE) &&
+	    (host->quirks & SDHCI_QUIRK_BROKEN_CQE)) {
+		mmc->caps2 &= ~MMC_CAP2_CQE;
+		mmc->cqe_ops = NULL;
+	}
+
+	/* overwrite ops */
+	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
+		sdhci_uhs2_host_ops_init(host);
+
+	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
+	if (!host->complete_wq)
+		return -ENOMEM;
+
+	INIT_WORK(&host->complete_work, sdhci_uhs2_complete_work);
+
+	timer_setup(&host->timer, sdhci_timeout_timer, 0);
+	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
+
+	init_waitqueue_head(&host->buf_ready_int);
+
+	sdhci_init(host, 0);
+
+	ret = request_threaded_irq(host->irq, sdhci_irq,
+				   sdhci_uhs2_thread_irq,
+				   IRQF_SHARED,	mmc_hostname(mmc), host);
+	if (ret) {
+		pr_err("%s: Failed to request IRQ %d: %d\n",
+		       mmc_hostname(mmc), host->irq, ret);
+		goto unwq;
+	}
+
+	ret = mmc_add_host(mmc);
+		if (ret)
+			return 1;
+
+	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
+		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+		host->use_external_dma ? "External DMA" :
+		(host->flags & SDHCI_USE_ADMA) ?
+		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
+		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
+
+	sdhci_enable_card_detection(host);
+
+	return 0;
+
+unwq:
+	destroy_workqueue(host->complete_wq);
+
+	return ret;
+}
+
+static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!(host->mmc) || !(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return;
+
+	if (!dead)
+		host->ops->uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_SIG_EN);
+	host->mmc->flags &= ~MMC_UHS2_INITIALIZED;
+}
+
+int sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	if (host->version >= SDHCI_SPEC_400) {
+		ret = __sdhci_uhs2_add_host_v4(host, host->caps1);
+		if (ret)
+			goto cleanup;
+	}
+
+	if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
+		/* host doesn't want to enable UHS2 support */
+		/* FIXME: Do we have to do some cleanup here? */
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+
+	ret = __sdhci_uhs2_add_host(host);
+	if (ret)
+		goto cleanup2;
+
+	return 0;
+
+cleanup2:
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_remove_host(host, 0);
+cleanup:
+	sdhci_cleanup_host(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
+
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	__sdhci_uhs2_remove_host(host, dead);
+
+	sdhci_remove_host(host, dead);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
+
 void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index d32a8602d045..54241a7adfca 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -220,5 +220,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e44ede049559..df433ad0ba66 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -173,10 +173,11 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
-static void sdhci_enable_card_detection(struct sdhci_host *host)
+void sdhci_enable_card_detection(struct sdhci_host *host)
 {
 	sdhci_set_card_detection(host, true);
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_card_detection);
 
 static void sdhci_disable_card_detection(struct sdhci_host *host)
 {
@@ -365,7 +366,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
-static void sdhci_init(struct sdhci_host *host, int soft)
+void sdhci_init(struct sdhci_host *host, int soft)
 {
 	struct mmc_host *mmc = host->mmc;
 	unsigned long flags;
@@ -390,6 +391,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_init);
 
 static void sdhci_reinit(struct sdhci_host *host)
 {
@@ -454,7 +456,7 @@ static void sdhci_led_control(struct led_classdev *led,
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_led_register(struct sdhci_host *host)
+int sdhci_led_register(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
@@ -471,14 +473,16 @@ static int sdhci_led_register(struct sdhci_host *host)
 
 	return led_classdev_register(mmc_dev(mmc), &host->led);
 }
+EXPORT_SYMBOL_GPL(sdhci_led_register);
 
-static void sdhci_led_unregister(struct sdhci_host *host)
+void sdhci_led_unregister(struct sdhci_host *host)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_LED)
 		return;
 
 	led_classdev_unregister(&host->led);
 }
+EXPORT_SYMBOL_GPL(sdhci_led_unregister);
 
 static inline void sdhci_led_activate(struct sdhci_host *host)
 {
@@ -3244,7 +3248,7 @@ static void sdhci_complete_work(struct work_struct *work)
 		;
 }
 
-static void sdhci_timeout_timer(struct timer_list *t)
+void sdhci_timeout_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -3265,8 +3269,9 @@ static void sdhci_timeout_timer(struct timer_list *t)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_timeout_timer);
 
-static void sdhci_timeout_data_timer(struct timer_list *t)
+void sdhci_timeout_data_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -3297,6 +3302,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_timeout_data_timer);
 
 /*****************************************************************************\
  *                                                                           *
@@ -3560,7 +3566,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 		data->host_cookie == COOKIE_MAPPED);
 }
 
-static irqreturn_t sdhci_irq(int irq, void *dev_id)
+irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS] = {0};
 	irqreturn_t result = IRQ_NONE;
@@ -3701,6 +3707,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(sdhci_irq);
 
 static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 49de8fdbd7a3..0970fe392d49 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -851,8 +851,14 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 }
 
 bool sdhci_data_line_cmd(struct mmc_command *cmd);
+void sdhci_enable_card_detection(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
+void sdhci_init(struct sdhci_host *host, int soft);
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+int sdhci_led_register(struct sdhci_host *host);
+void sdhci_led_unregister(struct sdhci_host *host);
+#endif
 void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
 void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
 void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
@@ -900,6 +906,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
 void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
 bool sdhci_request_done(struct sdhci_host *host);
+void sdhci_timeout_timer(struct timer_list *t);
+void sdhci_timeout_data_timer(struct timer_list *t);
+irqreturn_t sdhci_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
-- 
2.25.1

