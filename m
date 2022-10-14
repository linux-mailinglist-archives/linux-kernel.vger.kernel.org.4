Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B86F5FED6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJNLsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJNLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:47:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ECB156269;
        Fri, 14 Oct 2022 04:47:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l6so4096963pgu.7;
        Fri, 14 Oct 2022 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbX3cykqxMRH6bMF8u/S2MS3pREEeejjqIbnD23P3/8=;
        b=QT0mFdNafB5u6LtRngrWvuw3LbOrhY02Cw2yWUZ1DBV6WYPfE94f4HQnbuYJGhVkjC
         Whf61B6ex3oZKdBAOMlrYgTuAv69rqpVgdWkbKiV3uF4e6F+nLmxYC5OxNg0YIpjMYMq
         kKP+ohO7ZmHT7wQC8PN0BmFj/sXEGIR6mtFByi3OcJt21IruFWo6zS6uqW1O0EfogLjJ
         Eamcx6CsxuaZChJ8CbIi1wgpHNIH5083vjh1o9h8FeJYTHML07hGxi+HsAnkPN9ZRFMg
         DmjLJc3l8M5M44K2rUFNFwqz9f+PCqz/EXnPR/dnkv244sGN7qye1yb6uU7WgH33VlC8
         sDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbX3cykqxMRH6bMF8u/S2MS3pREEeejjqIbnD23P3/8=;
        b=nT5A+esfQDGeIXsEx5xyh0K6RH4faCFrbVhTP7n1xjftjZk6QXV4jfNeMGdEBZ6JZR
         jvmBCDNY1wy7K3kjgEhuZGIlEionUBIEHGZrIruK6l/WXyBw7XGQk8/+3AhOP+ekKbby
         4ZrmLFRvef8E2QnHY0hrl0yM8h7Gwh/xcGbHxHI3E99DztSheQ8h3Xw/EqFOI2jYAHam
         IP1jCgTyq1JO4HSJmnKo3KHQsWzqZcDmhYD9QBB3VIalJM/PPdXhUde8z6OHxcMFyUx3
         jRwg0DrU3LbNmdoE6LjeuRqxWLtpCU398NnUmnQqchLEq2aoez+xMkFFgdfYP8I8bDlk
         nRRg==
X-Gm-Message-State: ACrzQf3UFZA1qSlWTjiCQk/FfLnaPDwvam12j+gJkpq+G39T7gpczciR
        /0m2H0TQ8qN5snt1PIyQX2c=
X-Google-Smtp-Source: AMsMyM42TQiOw88ykMirfVn/XytKaEf0iduphfPCpQF6rsTr8KwPF0AaijdEidWN4FaXJTIP1d/x+Q==
X-Received: by 2002:a63:fa42:0:b0:44d:b59c:674b with SMTP id g2-20020a63fa42000000b0044db59c674bmr4133629pgk.207.1665748056443;
        Fri, 14 Oct 2022 04:47:36 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:36 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 09/26] mmc: sdhci: add UHS-II module
Date:   Fri, 14 Oct 2022 19:45:44 +0800
Message-Id: <20221014114601.15594-10-victor.shih@genesyslogic.com.tw>
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

