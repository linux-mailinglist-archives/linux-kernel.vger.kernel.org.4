Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6D6ACF3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCFUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCFUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:31:51 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B654DE32
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:31:50 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GYgRF073604;
        Mon, 6 Mar 2023 10:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678120482;
        bh=6e48yvpsOYbOjJpZ8sUHSVISN5B0TUdJ7JBAIuys27M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vDZyNBBXOuf276OVFbalHqcByOvEL6ZBDyW3WEwE4vnx2iIVbF66Q5qTZ+T8n27/d
         yNnhJdaFpXxrdQoK2c8t1+UwYYQRJmV1lrnk7KrOR5neg8h2yEwnx18lm8quOqXcLL
         LYQiSjMeGDx7q2DdTQImM8B4yASAKLOR8tP+MiCw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GYg9c075730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:34:42 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:34:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:34:41 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GYfM8110554;
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
Subject: [PATCH 03/10] ARM: mach-rda: Move RDA Micro support into Kconfig.platforms
Date:   Mon, 6 Mar 2023 10:34:34 -0600
Message-ID: <20230306163441.16179-3-afd@ti.com>
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

This removes the need for a dedicated Kconfig and empty mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig           | 2 --
 arch/arm/Kconfig.platforms | 8 ++++++++
 arch/arm/mach-rda/Kconfig  | 8 --------
 3 files changed, 8 insertions(+), 10 deletions(-)
 delete mode 100644 arch/arm/mach-rda/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f1713c0f7ce..d378ebced6ac 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -436,8 +436,6 @@ source "arch/arm/mach-pxa/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
 
-source "arch/arm/mach-rda/Kconfig"
-
 source "arch/arm/mach-realtek/Kconfig"
 
 source "arch/arm/mach-rpc/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index b80a5b49d276..80f5b040e6ef 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -75,3 +75,11 @@ config MACH_ASM9260
 	select ASM9260_TIMER
 	help
 	  Support for Alphascale ASM9260 based platform.
+
+config ARCH_RDA
+	bool "RDA Micro SoCs"
+	depends on ARCH_MULTI_V7
+	select RDA_INTC
+	select RDA_TIMER
+	help
+	  This enables support for the RDA Micro 8810PL SoC family.
diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
deleted file mode 100644
index 4d2e4e046cb3..000000000000
--- a/arch/arm/mach-rda/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_RDA
-	bool "RDA Micro SoCs"
-	depends on ARCH_MULTI_V7
-	select RDA_INTC
-	select RDA_TIMER
-	help
-	  This enables support for the RDA Micro 8810PL SoC family.
-- 
2.39.2

