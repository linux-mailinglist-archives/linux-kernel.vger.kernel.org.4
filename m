Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354B737FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjFUKD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjFUKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:02:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB0F1730;
        Wed, 21 Jun 2023 03:02:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6686ef86110so2148536b3a.2;
        Wed, 21 Jun 2023 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341743; x=1689933743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdKdcWVoH2jKHlp9q6ke+3s3vsNelEBW0r+3FXA6pZ8=;
        b=gx/uTVrUYjFxZEm+Iu6oxOlI3T47oeQ4hOUFAnAMUK5UlETMexf1A4+7IHTAGSMSuf
         OpNag53m+0cgaKT4C8J456846Lvt183HqQEvktsbhqeWRZI6XgnTlAsahNGIL8tvAaAG
         VIyWWajpJ702ii+Dx2RflnD2VW1FbiWyuK7Brj1YBsLP7EymvG/mJhzXAkdTp2pg8bs1
         5pQe5rq+LhMPaqTmILBETPhGPS5qjM4w5wLrNz7s9JkAU/2DoghwAhS2dJK5hEmqgPn6
         c8tF4+/bl4kFlXmEOGr1yOZMJKInC+twfyAbJ0MwUtvqtf4LkqXFmS9+2bsw/b0XeBSM
         yiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341743; x=1689933743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdKdcWVoH2jKHlp9q6ke+3s3vsNelEBW0r+3FXA6pZ8=;
        b=Y8L64iqTsrIhGzlejULggLgAfqxv4KSmetdc9eWOCYb1PWbbVY3pz5hYZvqe72pFMl
         bnd7ACZmzrU/w1AV5Ey0+F2TdWcOr33ip1qUifvU2x4ECnRrFmcWVX7KgBAF4lUf9+uR
         SjFa0Fa94S+vPqcXzRsIHmKrvdBosEwUofSXMB2OnJgUqjXamx68VzkpMMni2YEYVF2f
         Ka7VZlNEiOuOXVLffR4fIixqsL/AJjPbxYHLbQmpCMIcH7x8MbAC8uCCb/wf1nM73yXh
         HBFLIl1Hyeg+PjGzOOT+SxOf1JN3nuS96IDiPmEdZQFUCSVRi/S88zoGdglQkPr96qrx
         wSfg==
X-Gm-Message-State: AC+VfDzBplHXgPEnZDWsoBpgNnq1HPdBJSbje+xxdeQgogkYq3Bv+fvn
        JakcuDkuNOXPzsdzGVtUS4vN63gXu5ZahA==
X-Google-Smtp-Source: ACHHUZ6vuH7zKC6Ayp7XsTbM8SVn2FTuRCnBbs5CQJeHWy2nJ7/8JEFQDBcTfEp8f52NZMpDcwKrWw==
X-Received: by 2002:a05:6a00:1515:b0:668:73f5:dcf0 with SMTP id q21-20020a056a00151500b0066873f5dcf0mr6857912pfu.23.1687341743132;
        Wed, 21 Jun 2023 03:02:23 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:22 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 08/23] mmc: sdhci: add UHS-II module and add a kernel configuration
Date:   Wed, 21 Jun 2023 18:01:36 +0800
Message-Id: <20230621100151.6329-9-victorshihgli@gmail.com>
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

This patch adds sdhci-uhs2.c as a module for UHS-II support.
This is a skelton for further development in this patch series.

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Updates in V8:
 - Modify MODULE_LICENSE from "GPL v2" to "GPL".

Updates in V6:
 - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/Kconfig      |  9 +++++++
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 159a3e9490ae..215f1ab011dd 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index a693fa3d3f1c..799f21d1f81f 100644
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
index 000000000000..608f8ad5aaed
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
+static void __exit sdhci_uhs2_mod_exit(void)
+{
+}
+module_exit(sdhci_uhs2_mod_exit);
+
+MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
+MODULE_DESCRIPTION("MMC UHS-II Support");
+MODULE_LICENSE("GPL");
-- 
2.25.1

