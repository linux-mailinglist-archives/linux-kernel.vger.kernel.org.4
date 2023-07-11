Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8303A74F21F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjGKOYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjGKOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:23:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982131BDA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so8646779e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085360; x=1691677360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8/R65mfXAHzbxX/Yt/oiagP1RewF0H/jSZoqHRKyvw=;
        b=dCOHcZgRV7aQaBQJZEZkD8dFT9zvxOL0hkhcvBNSBUON9Vq4i7QBWmjlgIK0rUhj5G
         X8bilbLBLi4EO2GlwctmtGL0ZCFgHrPHSaGK5pf5J5yip06zF6HeHRI57NNcaOYcOh66
         ZquLBr6OKIgvq5KwVU/MeHe1sfkNZ+qprXu0K3+H5E0/8ghjptf9HJb3ZHEuxzdE9Ypo
         wgQnTFka3NbUsTQOR7Q4yOkpIbswbJRDqOWDQQV7yvsB5kG/P2BLIRxF9WSzupo9q9OK
         yAl0MFVP+1ity570RkO9aeo3VDFQnA2p4hEkl0EA1DJNAVSX/NSZFHFM1jDEYHgbl1rm
         Wr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085360; x=1691677360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8/R65mfXAHzbxX/Yt/oiagP1RewF0H/jSZoqHRKyvw=;
        b=HjI2QPfiz8ma9CJyLBSeqDR2qUbtkF4jxuSxfvUSwHd73bhPFlBrqy+zfx8zicHbrk
         Hnk9lmEPSdSJHhIVTynRR24IJPYXYfObqwYvJOnKR0sjoSVHlCCyRxmC8K9sg4/DSnKd
         x12k94/0eARFSdpA2l12YIiS4WcOSijfsbQ1GayoCYYoItK5vG2/QpwHfduBm8YqRXmf
         /Hmi0dsTtzFLvpJSbwboZjBBmEHXmSIWEoPylWSKT1Fc/FC4vSJIkY9FJKKFYiLwcHnn
         fTnodNV/bd1nd1CRDg1UnrXNIBMn7/ozEuuHiTP44uSjcxnNcom5vi8FALTp7nMDeH0c
         TZ6w==
X-Gm-Message-State: ABy/qLa4jpyCOGpKxba5GdJGZjZOBwqfu29Lgy1csB2Y3U2hMlnBjSyY
        eY8p4uhtS+PikOrC2Odt6wy9rg==
X-Google-Smtp-Source: APBJJlE/tivtaqrrtnHL9NcH9jALxO9JvYPsHziSzSo82znvSr4dpsGom1ZqDwK6Qbzn+voN8gwwvw==
X-Received: by 2002:a05:6512:2017:b0:4fb:89e2:fc27 with SMTP id a23-20020a056512201700b004fb89e2fc27mr12392141lfb.54.1689085359868;
        Tue, 11 Jul 2023 07:22:39 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id eo29-20020a056512481d00b004f85885cff1sm337106lfb.134.2023.07.11.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 17/18] ARM: ux500: Convert power-domain code into a regular platform driver
Date:   Tue, 11 Jul 2023 16:22:37 +0200
Message-Id: <20230711142237.751837-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the code more standalone and moveable, let's convert it into a
platform driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |  5 -----
 arch/arm/mach-ux500/pm_domains.c | 25 ++++++++++++++++++++-----
 arch/arm/mach-ux500/pm_domains.h | 17 -----------------
 3 files changed, 20 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/pm_domains.h

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 7cc0dd8ed991..b1a70f203372 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -26,8 +26,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
-#include "pm_domains.h"
-
 static int __init ux500_l2x0_unlock(void)
 {
 	int i;
@@ -115,9 +113,6 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 
 static void __init u8500_init_machine(void)
 {
-	/* Initialize ux500 power domains */
-	ux500_pm_domains_init();
-
 	of_platform_populate(NULL, u8500_local_bus_nodes,
 			     NULL, NULL);
 }
diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 427b9ac4af6c..3d4f111ed156 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -6,6 +6,9 @@
  *
  * Implements PM domains using the generic PM domain for ux500.
  */
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -13,7 +16,6 @@
 #include <linux/pm_domain.h>
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
-#include "pm_domains.h"
 
 static int pd_power_off(struct generic_pm_domain *domain)
 {
@@ -49,18 +51,17 @@ static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
 	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
 };
 
-static const struct of_device_id ux500_pm_domain_matches[] __initconst = {
+static const struct of_device_id ux500_pm_domain_matches[] = {
 	{ .compatible = "stericsson,ux500-pm-domains", },
 	{ },
 };
 
-int __init ux500_pm_domains_init(void)
+static int ux500_pm_domains_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
+	struct device_node *np = pdev->dev.of_node;
 	struct genpd_onecell_data *genpd_data;
 	int i;
 
-	np = of_find_matching_node(NULL, ux500_pm_domain_matches);
 	if (!np)
 		return -ENODEV;
 
@@ -77,3 +78,17 @@ int __init ux500_pm_domains_init(void)
 	of_genpd_add_provider_onecell(np, genpd_data);
 	return 0;
 }
+
+static struct platform_driver ux500_pm_domains_driver = {
+	.probe  = ux500_pm_domains_probe,
+	.driver = {
+		.name = "ux500_pm_domains",
+		.of_match_table = ux500_pm_domain_matches,
+	},
+};
+
+static int __init ux500_pm_domains_init(void)
+{
+	return platform_driver_register(&ux500_pm_domains_driver);
+}
+arch_initcall(ux500_pm_domains_init);
diff --git a/arch/arm/mach-ux500/pm_domains.h b/arch/arm/mach-ux500/pm_domains.h
deleted file mode 100644
index 33c55f2c6b3c..000000000000
--- a/arch/arm/mach-ux500/pm_domains.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2014 Linaro Ltd.
- *
- * Author: Ulf Hansson <ulf.hansson@linaro.org>
- */
-
-#ifndef __MACH_UX500_PM_DOMAINS_H
-#define __MACH_UX500_PM_DOMAINS_H
-
-#ifdef CONFIG_PM_GENERIC_DOMAINS
-extern int __init ux500_pm_domains_init(void);
-#else
-static inline int ux500_pm_domains_init(void) { return 0; }
-#endif
-
-#endif
-- 
2.34.1

