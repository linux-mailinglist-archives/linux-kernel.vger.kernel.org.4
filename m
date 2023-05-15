Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55087703CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbjEOSfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjEOSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:35:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A50D14E43;
        Mon, 15 May 2023 11:35:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FIZHJj036901;
        Mon, 15 May 2023 13:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684175717;
        bh=xwIE6bmUKSyNu94MutgqMrmchU0RO3UTij1CjBXeXYs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VKgpyqRZ82xyycLB4kjBZAMPEt5SAbnvBYVD6gYQUGHdyZbWjBWfGGBsv5t6gQgYP
         e8+ozk9pzD5HDbNTInN8sO2ieBzUY0N7tXyVK1C54V08dwnpocENZbgV4PIQSPeEWX
         O8gafmw+RqwJqo3KGzripBiGJxgXDWT8I6rNrzIQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FIZHIv126958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 13:35:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 13:35:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 13:35:17 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FIZGXO103396;
        Mon, 15 May 2023 13:35:16 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/5] ARM: keystone: Merge PM function into main support file
Date:   Mon, 15 May 2023 13:35:12 -0500
Message-ID: <20230515183515.509371-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515183515.509371-1-afd@ti.com>
References: <20230515183515.509371-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one function left in this file does not justify a whole extra
file nor the keystone.h support file used to forward declare that
function. Merge this into the main keystone.c file.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-keystone/Makefile    |  3 --
 arch/arm/mach-keystone/keystone.c  | 37 ++++++++++++++++++++--
 arch/arm/mach-keystone/keystone.h  | 16 ----------
 arch/arm/mach-keystone/pm_domain.c | 50 ------------------------------
 4 files changed, 35 insertions(+), 71 deletions(-)
 delete mode 100644 arch/arm/mach-keystone/keystone.h
 delete mode 100644 arch/arm/mach-keystone/pm_domain.c

diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index 0c1d54aec60f..66598d29dd3c 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -1,5 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					:= keystone.o
-
-# PM domain driver for Keystone SOCs
-obj-$(CONFIG_ARCH_KEYSTONE)		+= pm_domain.o
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index fdc7d3621bd0..a870b3f46f1a 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -6,10 +6,13 @@
  *	Cyril Chemparathy <cyril@ti.com>
  *	Santosh Shilimkar <santosh.shillimkar@ti.com>
  */
+
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/dma-map-ops.h>
 #include <linux/init.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_clock.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/memblock.h>
@@ -20,8 +23,6 @@
 #include <asm/mach/time.h>
 #include <asm/memory.h>
 
-#include "keystone.h"
-
 #define KEYSTONE_LOW_PHYS_START		0x80000000ULL
 #define KEYSTONE_LOW_PHYS_SIZE		0x80000000ULL /* 2G */
 #define KEYSTONE_LOW_PHYS_END		(KEYSTONE_LOW_PHYS_START + \
@@ -32,6 +33,38 @@
 #define KEYSTONE_HIGH_PHYS_END		(KEYSTONE_HIGH_PHYS_START + \
 					 KEYSTONE_HIGH_PHYS_SIZE - 1)
 
+static struct dev_pm_domain keystone_pm_domain = {
+	.ops = {
+		USE_PM_CLK_RUNTIME_OPS
+		USE_PLATFORM_PM_SLEEP_OPS
+	},
+};
+
+static struct pm_clk_notifier_block platform_domain_notifier = {
+	.pm_domain = &keystone_pm_domain,
+	.con_ids = { NULL },
+};
+
+static const struct of_device_id of_keystone_table[] = {
+	{.compatible = "ti,k2hk"},
+	{.compatible = "ti,k2e"},
+	{.compatible = "ti,k2l"},
+	{ /* end of list */ },
+};
+
+int __init keystone_pm_runtime_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, of_keystone_table);
+	if (!np)
+		return 0;
+
+	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
+
+	return 0;
+}
+
 #ifdef CONFIG_ARM_LPAE
 static int keystone_platform_notifier(struct notifier_block *nb,
 				      unsigned long event, void *data)
diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
deleted file mode 100644
index 71ff8cd2ee4a..000000000000
--- a/arch/arm/mach-keystone/keystone.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2013 Texas Instruments, Inc.
- *	Cyril Chemparathy <cyril@ti.com>
- *	Santosh Shilimkar <santosh.shillimkar@ti.com>
- */
-
-#ifndef __KEYSTONE_H__
-#define __KEYSTONE_H__
-
-#ifndef __ASSEMBLER__
-
-extern int keystone_pm_runtime_init(void);
-
-#endif /* __ASSEMBLER__ */
-#endif /* __KEYSTONE_H__ */
diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
deleted file mode 100644
index 5eea01cbecf0..000000000000
--- a/arch/arm/mach-keystone/pm_domain.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * PM domain driver for Keystone2 devices
- *
- * Copyright 2013 Texas Instruments, Inc.
- *	Santosh Shilimkar <santosh.shillimkar@ti.com>
- *
- * Based on Kevins work on DAVINCI SOCs
- *	Kevin Hilman <khilman@linaro.org>
- */
-
-#include <linux/init.h>
-#include <linux/pm_runtime.h>
-#include <linux/pm_clock.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-
-#include "keystone.h"
-
-static struct dev_pm_domain keystone_pm_domain = {
-	.ops = {
-		USE_PM_CLK_RUNTIME_OPS
-		USE_PLATFORM_PM_SLEEP_OPS
-	},
-};
-
-static struct pm_clk_notifier_block platform_domain_notifier = {
-	.pm_domain = &keystone_pm_domain,
-	.con_ids = { NULL },
-};
-
-static const struct of_device_id of_keystone_table[] = {
-	{.compatible = "ti,k2hk"},
-	{.compatible = "ti,k2e"},
-	{.compatible = "ti,k2l"},
-	{ /* end of list */ },
-};
-
-int __init keystone_pm_runtime_init(void)
-{
-	struct device_node *np;
-
-	np = of_find_matching_node(NULL, of_keystone_table);
-	if (!np)
-		return 0;
-
-	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
-
-	return 0;
-}
-- 
2.39.2

