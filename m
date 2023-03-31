Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131A96D1E80
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjCaK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCaK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:56:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219D71D923;
        Fri, 31 Mar 2023 03:56:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ja10so20872333plb.5;
        Fri, 31 Mar 2023 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCMev1nbO+uuzvPQJsJ7FQNJs6v52W+KGPPzbe65Jwo=;
        b=Y/fPM0PQSUaFh/SZthdDFBwWRhhuk20FQcvG3ObHvEcEL9fXxMhG/c1Sjvbv/bYkFe
         Cf8RXvgLgISrqy7s6GNT3ekziSFs4mX9AJWorYMk/qhKAFJNiffUlBvagOIECI3cZmJG
         3lvuHWoAESxZiTFuBROpTPgG9qoJ2/fuNyPpRPHUq7q9B3PDfPdLukdjNPoLP6mYIMJt
         oHC6i+QRkPTG6+bHoKt5UeFVC+Ah7WCLc1WzefMheyHwVqMN/FvCv2rt+xRzaDZOGrJq
         BdJnLdJEY3cX3VzPymZc0PKbV3Fm6gP87G5RVQuvIb0Unntj83ov9+AJ/VC0oZH8Wesl
         Cl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCMev1nbO+uuzvPQJsJ7FQNJs6v52W+KGPPzbe65Jwo=;
        b=Ec222QqlOIyHKkd0pGKAiijr2CVfO6+cnyUGwzsonI9j59MJvGqchpa7VQ91oSYR25
         1w2n4DwMn13edrCATKaMk+8eIFn3aIeP/rE6juwyhy0DPk4x7ssJ40htzPpnCk8H876N
         zF2w8aG1QZmc8BP+yoIAgLzKnJzADYpSFjISd5rjFuSNpOYo1eK928ofdweWf99e3pvx
         tdmLeONg3+48GwGYB9XTrRmNcQfcnAZhHZyWWaJsR5OGzOIOl8ZSCwLL9Kc9n5nqpLFB
         WzNb+P0sfb3xmAYW2g0f/8aOzYIIx88sQcsYTHV4ZNYTcOHcRSOw+IcCom+fpRZLSq0e
         kZVg==
X-Gm-Message-State: AAQBX9d04zsQjpropepcS5WRpIJ5yzCRJzaYf1y/EU7Ml+vZ867R6pZj
        D4vv/shZ1XtEkFMEt7bC/ms=
X-Google-Smtp-Source: AKy350bRoKj16Kr9/atAC2g0AOaX4naYf0sKJb+230XssQcJObuCgWWfFBXw7MdHP8hfSaxyuYSJzg==
X-Received: by 2002:a17:90a:35d:b0:237:9a13:5841 with SMTP id 29-20020a17090a035d00b002379a135841mr29400619pjf.3.1680260192611;
        Fri, 31 Mar 2023 03:56:32 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-983f-c7ff-3efd-77d9-6c16.emome-ip6.hinet.net. [2001:b400:e25c:983f:c7ff:3efd:77d9:6c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b0019acd3151d0sm1287665plb.114.2023.03.31.03.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:56:32 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V7 10/23] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Fri, 31 Mar 2023 18:55:33 +0800
Message-Id: <20230331105546.13607-11-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 524d7cb6f2fd..67621eaabafc 100644
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
index e948119348da..6834893eee85 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -178,5 +178,7 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+bool sdhci_uhs2_mode(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

