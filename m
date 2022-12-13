Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3990864B1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiLMJC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiLMJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:02 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD401AF02;
        Tue, 13 Dec 2022 01:01:40 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 82so10019828pgc.0;
        Tue, 13 Dec 2022 01:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e0Zz1TO8qYEsDMf3o3pWG/i9MXpgx+hqEniREfvFtU=;
        b=T34PB8/8sh9lrWai2hPI6Jo3+AMebb4VsS0skYzisOmkUp1H3Ggcsg+jadp7MpW+gv
         ftN9aTZx6rSdudGOPr4jRvLL+gKyN5Wovu5JsyfPBaWhxfF6btIGvBxggrKd6Y1dlERK
         HrepvWLSyEeDyNWPtX/cmbg5hvXCMynnNKy1aNLxpEyBgcejRP2qJi6WTQefFCyF8qAi
         yMT0qtz+AlTT9NbryKrzRq1emJc6uymIq2PGCoUiACnXKI+16+cnYgD0brvH3VEP1ykD
         ktKebsoxydjNf58dt5lag4bCuAv9Ad4GTkEewhv+UNdGEDid26zbMMj3Qslf7D3lvosT
         VMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e0Zz1TO8qYEsDMf3o3pWG/i9MXpgx+hqEniREfvFtU=;
        b=GQOkwyvMHqxiOxjZzk4PdFmkhe5MdROz9mdDVn7uX8lLbz2n/jY7HA00uTtqIclN9T
         7G+11dXIsKOjUQ3FWgbQ+96QlHK3qPFSA+M8F9t3idvAn6bKtk7sPbaqkgfoWLetUUGN
         Dt/VNa3p95/LsAtG8Dpz0wC0rOMIekuTgesvrE76n4ez/yF7eHnIXUX/f3cc+3smD/JF
         w4XRJcIAbfmU3UJG/7eaZIEZv1JTKec3nTxLbG7aUlm1dN2zcTTNr7o19eS8XLRfdN6k
         V6GFW0uylw8G2Lrsw992NnW28MouytGYmgMT4C8jasehS+IZKA152Cd8EDBW044Jlxr7
         vcHA==
X-Gm-Message-State: ANoB5pl4fgfhjgy1C4yes2DtGLkqY/2G22c6GHitVrG7ovcu9y+J9R4z
        zz3mNa+OElxtqz2DAItL4EQ=
X-Google-Smtp-Source: AA0mqf7oNFZDfFMXty7ZfYyogT31u7WW0+yFHby9ZFzQaBZFBevOLG21AT9CFCr9xDsifmuv+tiYCw==
X-Received: by 2002:a05:6a00:188b:b0:576:9eed:61de with SMTP id x11-20020a056a00188b00b005769eed61demr25838723pfh.4.1670922100392;
        Tue, 13 Dec 2022 01:01:40 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:01:39 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 10/24] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Tue, 13 Dec 2022 17:00:33 +0800
Message-Id: <20221213090047.3805-11-victor.shih@genesyslogic.com.tw>
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

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 7ea15f06fa99..ae862e1eadab 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -10,7 +10,9 @@
  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/iopoll.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -49,6 +51,50 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
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
+	return host->mmc->flags & MMC_UHS2_SUPPORT;
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
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL)
+		host->clock = 0;
+
+	/* Wait max 100 ms */
+	timeout = 100000;
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
index a1fcd7899829..03b9f6675cdc 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -175,5 +175,7 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+bool sdhci_uhs2_mode(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

