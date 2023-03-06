Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193966ACECA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCFUDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCFUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:03:33 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2C244A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:03:31 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GYgJZ109321;
        Mon, 6 Mar 2023 10:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678120482;
        bh=cJNSToQbSWYZcQYXNHe2CoONpDnHogKbjwJ+fB1yeZ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u6DBaF0zLTtOr72/TX8riGidCm/oYHvlhz4pDa1cxEwvVms061vhLzvCVk+JjoeUC
         3/A/vEKjZmKcSXQvYgOYJquCvyy7n8s/EgYQGGWInXtnjxnjlG6UAZgl5upCaGQjnJ
         5TfLwFXsyE4xKaXexm0nxVaVrXZx/v3Le3mrMXDU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GYgVm075727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:34:42 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:34:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:34:41 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GYfM7110554;
        Mon, 6 Mar 2023 10:34:41 -0600
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qin Jian <qinjian@cqplus1.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 02/10] ARM: mach-asm9260: Move ASM9260 support into Kconfig.platforms
Date:   Mon, 6 Mar 2023 10:34:33 -0600
Message-ID: <20230306163441.16179-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306163441.16179-1-afd@ti.com>
References: <20230306163441.16179-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the need for a dedicated Kconfig and mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig              | 2 --
 arch/arm/Kconfig.platforms    | 9 +++++++++
 arch/arm/mach-asm9260/Kconfig | 9 ---------
 3 files changed, 9 insertions(+), 11 deletions(-)
 delete mode 100644 arch/arm/mach-asm9260/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 495b1d9444ab..2f1713c0f7ce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -360,8 +360,6 @@ source "arch/arm/mach-alpine/Kconfig"
 
 source "arch/arm/mach-artpec/Kconfig"
 
-source "arch/arm/mach-asm9260/Kconfig"
-
 source "arch/arm/mach-aspeed/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index ed1f6da11e24..b80a5b49d276 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -66,3 +66,12 @@ config ARCH_VIRT
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
+
+config MACH_ASM9260
+	bool "Alphascale ASM9260"
+	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
+	select CPU_ARM926T
+	select ASM9260_TIMER
+	help
+	  Support for Alphascale ASM9260 based platform.
diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
deleted file mode 100644
index 74e0f61c74c8..000000000000
--- a/arch/arm/mach-asm9260/Kconfig
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config MACH_ASM9260
-	bool "Alphascale ASM9260"
-	depends on ARCH_MULTI_V5
-	depends on CPU_LITTLE_ENDIAN
-	select CPU_ARM926T
-	select ASM9260_TIMER
-	help
-	  Support for Alphascale ASM9260 based platform.
-- 
2.39.2

