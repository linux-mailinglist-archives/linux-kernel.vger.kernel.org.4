Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E742703217
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbjEOQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbjEOQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:03:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D3E4A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:03:12 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2adM005215;
        Mon, 15 May 2023 11:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684166556;
        bh=Oa6IBatsIaVeBtx9IqnQa720cOdZAC2k9zv9qk3N9Lk=;
        h=From:To:CC:Subject:Date;
        b=boe9RsqSyH737gaG1kMrwQlxo4AJG4qxTkrby/Dd2N4gNUiFT1xTNYt1Q9qi5eYO1
         RbVs41jR0y1dH1ibQ0vHeZotxrAjEIAR5N+8YKEYxPdyhgbiYAzq2sdmpoPRfeSuyS
         wr9rQqSKdofBI9CWXIdXVQp9nQdqJZHlewZerhH0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FG2aUY034512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:02:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:02:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:02:35 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2ZR0029578;
        Mon, 15 May 2023 11:02:35 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 01/10] ARM: Kconfig: move platform selection into its own Kconfig file
Date:   Mon, 15 May 2023 11:02:25 -0500
Message-ID: <20230515160234.289631-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

Mostly just for better organization for now. This matches what is done on
some other platforms including ARM64. This also lets us start to reduce
the number of mach- directories that only exist to store the platform
selection.

Start with "Platform selection" and ARCH_VIRT.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig           | 67 +------------------------------------
 arch/arm/Kconfig.platforms | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/Kconfig.platforms

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..23e3e344f9c0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -336,72 +336,7 @@ config ARCH_MULTIPLATFORM
 	  Selecting N here allows using those options, including
 	  DEBUG_UNCOMPRESS, XIP_KERNEL and ZBOOT_ROM. If unsure, say Y.
 
-menu "Platform selection"
-	depends on MMU
-
-comment "CPU Core family selection"
-
-config ARCH_MULTI_V4
-	bool "ARMv4 based platforms (FA526, StrongARM)"
-	depends on !ARCH_MULTI_V6_V7
-	# https://github.com/llvm/llvm-project/issues/50764
-	depends on !LD_IS_LLD || LLD_VERSION >= 160000
-	select ARCH_MULTI_V4_V5
-	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
-
-config ARCH_MULTI_V4T
-	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
-	depends on !ARCH_MULTI_V6_V7
-	# https://github.com/llvm/llvm-project/issues/50764
-	depends on !LD_IS_LLD || LLD_VERSION >= 160000
-	select ARCH_MULTI_V4_V5
-	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
-		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
-		CPU_ARM925T || CPU_ARM940T)
-
-config ARCH_MULTI_V5
-	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
-	depends on !ARCH_MULTI_V6_V7
-	select ARCH_MULTI_V4_V5
-	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
-		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
-		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
-
-config ARCH_MULTI_V4_V5
-	bool
-
-config ARCH_MULTI_V6
-	bool "ARMv6 based platforms (ARM11)"
-	select ARCH_MULTI_V6_V7
-	select CPU_V6K
-
-config ARCH_MULTI_V7
-	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
-	default y
-	select ARCH_MULTI_V6_V7
-	select CPU_V7
-	select HAVE_SMP
-
-config ARCH_MULTI_V6_V7
-	bool
-	select MIGHT_HAVE_CACHE_L2X0
-
-config ARCH_MULTI_CPU_AUTO
-	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
-	select ARCH_MULTI_V5
-
-endmenu
-
-config ARCH_VIRT
-	bool "Dummy Virtual Machine"
-	depends on ARCH_MULTI_V7
-	select ARM_AMBA
-	select ARM_GIC
-	select ARM_GIC_V2M if PCI
-	select ARM_GIC_V3
-	select ARM_GIC_V3_ITS if PCI
-	select ARM_PSCI
-	select HAVE_ARM_ARCH_TIMER
+source "arch/arm/Kconfig.platforms"
 
 config ARCH_AIROHA
 	bool "Airoha SoC Support"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
new file mode 100644
index 000000000000..ed1f6da11e24
--- /dev/null
+++ b/arch/arm/Kconfig.platforms
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Platform selection"
+	depends on MMU
+
+comment "CPU Core family selection"
+
+config ARCH_MULTI_V4
+	bool "ARMv4 based platforms (FA526, StrongARM)"
+	depends on !ARCH_MULTI_V6_V7
+	# https://github.com/llvm/llvm-project/issues/50764
+	depends on !LD_IS_LLD || LLD_VERSION >= 160000
+	select ARCH_MULTI_V4_V5
+	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
+
+config ARCH_MULTI_V4T
+	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
+	depends on !ARCH_MULTI_V6_V7
+	# https://github.com/llvm/llvm-project/issues/50764
+	depends on !LD_IS_LLD || LLD_VERSION >= 160000
+	select ARCH_MULTI_V4_V5
+	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
+		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
+		CPU_ARM925T || CPU_ARM940T)
+
+config ARCH_MULTI_V5
+	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
+	depends on !ARCH_MULTI_V6_V7
+	select ARCH_MULTI_V4_V5
+	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
+		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
+		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
+
+config ARCH_MULTI_V4_V5
+	bool
+
+config ARCH_MULTI_V6
+	bool "ARMv6 based platforms (ARM11)"
+	select ARCH_MULTI_V6_V7
+	select CPU_V6K
+
+config ARCH_MULTI_V7
+	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
+	default y
+	select ARCH_MULTI_V6_V7
+	select CPU_V7
+	select HAVE_SMP
+
+config ARCH_MULTI_V6_V7
+	bool
+	select MIGHT_HAVE_CACHE_L2X0
+
+config ARCH_MULTI_CPU_AUTO
+	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
+	select ARCH_MULTI_V5
+
+endmenu
+
+config ARCH_VIRT
+	bool "Dummy Virtual Machine"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GIC_V2M if PCI
+	select ARM_GIC_V3
+	select ARM_GIC_V3_ITS if PCI
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
-- 
2.39.2

