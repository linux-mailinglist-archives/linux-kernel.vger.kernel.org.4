Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E60738080
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFUKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFUKDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:03:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3AB19BE;
        Wed, 21 Jun 2023 03:02:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666ecf9a081so4192639b3a.2;
        Wed, 21 Jun 2023 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341778; x=1689933778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaY1ZiTIhvmzDWlBNhgIqxr3952lVFKhm/rXtKJ/wXc=;
        b=AsNHEdnG6Y7TUv0FXTRLiw/3BFL1ZC+PDpfwPOncinM1HE2awMohRLxKhk5yv3f4xX
         ri1FdnfRKnWzk7rnm9FAvLzJhUPv49kqtygtPU61erN1bpwO6Jxk6O2R53N7sCIkFQNj
         6Ac9gLrao2FOtVUE85nWOe9Y2QIYcXbuB9ZYR3ra+efg2KxdC26XfBvvTQXWdVkzOzxw
         Ch/lgJwRmNf6ADevRyrcAZ2Iytf3NjA0TCDueGGlLtq2lh8Rn8UAuNE/zGMYulLEBYpD
         jhEfNz4T9k5aVbHAMI0u9lMs/M7l+3IsEYvD6DnHTbk/5x0MkakCQMDfIMBmZlzlA5fx
         r+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341778; x=1689933778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaY1ZiTIhvmzDWlBNhgIqxr3952lVFKhm/rXtKJ/wXc=;
        b=QX9cIH5L681v11FgHpgsPkCES+JCktV4Q24rrRwUQM9m9RyvOsEel2aa2ZXkfbbBmB
         pl1jYsD9bTRoZ0UBfX90GgJdl3nUjBT6zKDIYiKq22aFw2p5qlLFXXBOgGMo0tj+zpWB
         2oYgQ1XvYsa+Yhaxb/vjng0S5BL5QtcU8xPxPTD51d2gM4P6H4+AJ0GaakalHhz5Ob0Y
         mCsXp0jWugrZvDEOPoK0GTrc5EXZMJNjVQ2y+hlJzmnUh+BxX4unkkAUSe9gWviaqKCS
         oF5iZpBbBUoaOapDHC7gBgwUJXffrK74H+ZrgYiqe4aY0/fqtfWSbLXwHbXnOy2WilcR
         R1qA==
X-Gm-Message-State: AC+VfDxNXpBpHcxeZkh5hbRZRq3/ickT3crtj/OzViWBwPDjnrwYcO5f
        kKo4j8AMd8Ttj+l1fUh/Yig=
X-Google-Smtp-Source: ACHHUZ4xGOfAeXCQkT8PdQTvkn+mK4dCIMtuNJTz+fYfipfUEaU1KkQjGchMKP9tnBUx2OECl8HSsw==
X-Received: by 2002:a05:6a20:9385:b0:11f:92d2:1442 with SMTP id x5-20020a056a20938500b0011f92d21442mr15410782pzh.29.1687341778659;
        Wed, 21 Jun 2023 03:02:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:58 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 20/23] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date:   Wed, 21 Jun 2023 18:01:48 +0800
Message-Id: <20230621100151.6329-21-victorshihgli@gmail.com>
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

This is a UHS-II version of sdhci's add_host/remove_host operation.
Any sdhci drivers which are capable of handling UHS-II cards must
call those functions instead of the corresponding sdhci's.

Updates in V8:
 - Change return type to void for __sdhci_uhs2_add_host_v4().
 - Remove unused variables in __sdhci_uhs2_add_host_v4().

Updates in V7:
 - __sdhci_add_host() to instead of __sdhci_uhs2_add_host()
   in sdhci_uhs2_add_host().
 - Cancel export state of some functions.

Updates in V6:
 - Add complete_work_fn/thread_irq_fn variables in
   struct sdhci_host.
 - Use complete_work_fn/thread_irq_fn variables in
   sdhci_alloc_host() and sdhci_uhs2_add_host().
 - Use sdhci_uhs2_mode() to simplify code in
   __sdhci_uhs2_remove_host().

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 102 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   2 +
 drivers/mmc/host/sdhci.c      |   7 ++-
 drivers/mmc/host/sdhci.h      |   3 +
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index f92a5cd5800d..0adc3e9ca1b0 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -997,6 +998,107 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*****************************************************************************\
+ *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2)
+		mmc->caps2 |= MMC_CAP2_SD_UHS2;
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_CAN_VDD2_180) &&
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
+	if (caps1 & SDHCI_CAN_VDD2_180)
+		mmc->ocr_avail_uhs2 |= MMC_VDD_165_195;
+	else
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+}
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
+
+static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!sdhci_uhs2_mode(host))
+		return;
+
+	if (!dead)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
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
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_add_host_v4(host, host->caps1);
+
+	if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
+		/* host doesn't want to enable UHS2 support */
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+
+	/* overwrite ops */
+	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
+		sdhci_uhs2_host_ops_init(host);
+
+	host->complete_work_fn = sdhci_uhs2_complete_work;
+	host->thread_irq_fn    = sdhci_uhs2_thread_irq;
+
+	/* LED support not implemented for UHS2 */
+	host->quirks |= SDHCI_QUIRK_NO_LED;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_remove_host(host, 0);
+
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
index 3aa2cb4b39d6..bd5aae054c6f 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -186,5 +186,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 144445e9f875..9e1469e76f1e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4106,6 +4106,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->max_timeout_count = 0xE;
 
+	host->complete_work_fn = sdhci_complete_work;
+	host->thread_irq_fn    = sdhci_thread_irq;
+
 	return host;
 }
 
@@ -4855,7 +4858,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	if (!host->complete_wq)
 		return -ENOMEM;
 
-	INIT_WORK(&host->complete_work, sdhci_complete_work);
+	INIT_WORK(&host->complete_work, host->complete_work_fn);
 
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
@@ -4864,7 +4867,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
 				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 20eb0943b402..f660d5040f6a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -626,6 +626,9 @@ struct sdhci_host {
 	struct timer_list timer;	/* Timer for timeouts */
 	struct timer_list data_timer;	/* Timer for data timeouts */
 
+	void		(*complete_work_fn)(struct work_struct *work);
+	irqreturn_t	(*thread_irq_fn)(int irq, void *dev_id);
+
 #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
 	struct dma_chan *rx_chan;
 	struct dma_chan *tx_chan;
-- 
2.25.1

