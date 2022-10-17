Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C70600A32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJQJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiJQJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:14:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D84CA22;
        Mon, 17 Oct 2022 02:13:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m6so10565737pfb.0;
        Mon, 17 Oct 2022 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HwnNcHzfM/xxQ8Jc+59AjKb99BR1HhaEozFHr56zf4=;
        b=WRQVBXWvrvje4YgapPZ5rFGu547dh0vShqh1cJHzvQnVeGnVBx2pl0eABvMwDbCgJ7
         wY4FMJChxEYorx7OrayveMV7RdUSdyphctaSDyYKoAl/Q4J3GhEvHdsRZngUDHFaOKH7
         S0EwsWdyBYxML2eixdO9BUf8/iZlO9RLIppuYH4FTT4W7J8aG9QzJxTJxgAZ69IzpI6T
         1pzU8whP4kf9hHTF1wZgpp5VaOCwmhVUp9WET6k1zUxSnD8orOB4JtFOWtBz60ejhaWd
         3V3EQ0sCdFw6ss1wJDcHdQXTZD10uI1mcaN4CdDCve6g0eKWonI4d+kkcHeh0fh88AsR
         50sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HwnNcHzfM/xxQ8Jc+59AjKb99BR1HhaEozFHr56zf4=;
        b=E+RItTn6eCjLiPoWaQ2sTXkZJ2iaMSOC8TSMPKjTpulKu0ONwKw9fy2scGI2Cu5GKs
         2RI/un+IkpS5R9IeqcvQtFpgga1yeE3UaD7sd5ZPOYG1MNWL2kXfBjsabJFFVTU+PqCZ
         tHnVm/B1mBIVLMTliKFWL2mc9qGzX9r+GqAo2ciyskibFOjzGxP3Av3IPlk/jOuj8WTi
         bl8U6/OIo16pXzP7EzKuTNbv8lt90CkCtYe5pNSxBxybVtwHC5dcT/4ozxCK/MBNtsu/
         VwW2Dv8jK6scJAhjNKm6f1chKRvjLzPb5yG0iWWfbW0Yn9OLKF107IECfx1rzhSXTCea
         uFlg==
X-Gm-Message-State: ACrzQf0nBfo23OTdhR11IVHWYz8s4/6RwXWn9o2YGz1OibFfFGEjRneR
        UcX9bht7y1uXA2BnThQNBY4=
X-Google-Smtp-Source: AMsMyM7Cm87vG3OTS14N24dIk/S7NRVH7Gje6SiOmYT4KsXre4OGmoBJ/RRHDXXPwnRusGi8/YC6zw==
X-Received: by 2002:a62:1684:0:b0:554:cade:6970 with SMTP id 126-20020a621684000000b00554cade6970mr11673547pfw.11.1665998008627;
        Mon, 17 Oct 2022 02:13:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:13:28 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 25/26] mmc: sdhci-pci: add UHS-II support framework
Date:   Mon, 17 Oct 2022 17:11:52 +0800
Message-Id: <20221017091153.454873-26-victor.shih@genesyslogic.com.tw>
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

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index a187379ad204..bf6d579aa992 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -39,6 +39,7 @@
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2130,7 +2131,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2138,6 +2142,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 3661a224fb04..7f4a981c0e63 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -140,6 +140,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -184,6 +185,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.25.1

