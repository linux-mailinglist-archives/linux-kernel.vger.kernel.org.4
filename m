Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1164600A14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJQJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiJQJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:12:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6204B9B1;
        Mon, 17 Oct 2022 02:12:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 129so9918590pgc.5;
        Mon, 17 Oct 2022 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbX3cykqxMRH6bMF8u/S2MS3pREEeejjqIbnD23P3/8=;
        b=lJ/fZTzQhpKNFK5Y7vzvy2IxjVPNTZMxXdoskyurdQjVFWGdRta3keIlfdihKlJehB
         rltXVx7xJ8ODKeRPTv5xP37gLaXqWDUhgpOkTVJsJwzZofzpJy4J2cax+PcqfUUCh1vA
         c5fcTQ39cC1mffHfmrXj7kFd8lqNKaMWqlucqhVAUw4IRjj67T4boYFCK0iI8SlVsaaa
         B3O7YqNfvt/KLdUnPXnMU/6EN6c8e3F+Vf0/kzlel3tEZQwKgf07sxCWHxhDHA2ZF0y3
         yqZ+2bH4UzUkuKwhVwnYdzVlUDK0kD4jxiy9IqWMxtHzTzWgBrnxO1+zQWjcni8/Up2i
         JO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbX3cykqxMRH6bMF8u/S2MS3pREEeejjqIbnD23P3/8=;
        b=tZ/ocHWY2Uy5js0PpI+FoHTC+ubutHdupI7z41XJyvS6Si5df4E9oszEai1N7KJEBI
         MnC0OUDVcUTV6PXXyzIJYhD/HSuEkva7+Tw75yMgYMZ27bS5d5EuQOe9fbLU+lS+IeRd
         9fqLGFpv5PJSIpKj7wdTJvUkE/JPnxWayFiVfV1isWs5O3p56CJ//lvm9f2FGnfuQ5m2
         A0vAOfmEUMm6KQgC72GtHQMGMMA+YRVBhrL88b8fRP8JgNopbBJFkLbXOsmt7OltN4WU
         rrji0JSTi+1fXU3UG2sCvK6z0Se48jP9ig2oY01sXYgW89cRKuhZJMKqTi+WtBtXEriY
         TZyQ==
X-Gm-Message-State: ACrzQf0TC8+BDNUt5E4TYmUKIwk+vnDNGwDB9PG3kKWRalX0Z6gNn9S6
        12A8EkIr5f1h+RGHJbPQ848=
X-Google-Smtp-Source: AMsMyM6UTmvWGMZ7kxFLBLorZbmV5d/2VkjXCmsh6YrgN9C0M46Pbb+YRLtb2G6yaNpUueuAR33Z9w==
X-Received: by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP id cg6-20020a056a00290600b0052abc7ff801mr11884010pfb.49.1665997957479;
        Mon, 17 Oct 2022 02:12:37 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:37 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 09/26] mmc: sdhci: add UHS-II module
Date:   Mon, 17 Oct 2022 17:11:36 +0800
Message-Id: <20221017091153.454873-10-victor.shih@genesyslogic.com.tw>
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

This patch adds sdhci-uhs2.c as a module for UHS-II support.
This is a skelton for further development in this patch series.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4e4ceb32c4b4..c4ae7c6d9c04 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
new file mode 100644
index 000000000000..f29d3a4ed43c
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
+ *  Interface driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *  Copyright (C) 2020 Genesys Logic, Inc.
+ *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *  Copyright (C) 2020 Linaro Limited
+ *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <linux/module.h>
+
+#include "sdhci.h"
+#include "sdhci-uhs2.h"
+
+#define DRIVER_NAME "sdhci_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static int __init sdhci_uhs2_mod_init(void)
+{
+	return 0;
+}
+module_init(sdhci_uhs2_mod_init);
+
+static void __exit sdhci_uhs2_exit(void)
+{
+}
+module_exit(sdhci_uhs2_exit);
+
+MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
+MODULE_DESCRIPTION("MMC UHS-II Support");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

