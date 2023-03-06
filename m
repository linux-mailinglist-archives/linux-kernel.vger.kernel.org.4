Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893906ACD9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCFTLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCFTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:11:04 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFBF5678F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:10:56 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GYgm3037931;
        Mon, 6 Mar 2023 10:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678120482;
        bh=Eh1WpV4fDdKG+C4wxumCKZNep4NwP56XEWxPlFYIJdA=;
        h=From:To:CC:Subject:Date;
        b=QaiK6dWysfiD74JfvebPkmeHekdAasJfSF3Uk47Ct9w1n2tk1n3Ju4gfaOjnYrQhZ
         5NxNXu72t1+IPbD1GZsCVWkhoF6GI9iD+JuMJMkYDfdqlQ1EDYwx/NKb7Q8noateoa
         47fJbTAwACsqpjYosHTYG3Sg2Ni8Zx++R/OQWt7k=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GYgCR075738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:34:42 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:34:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:34:41 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GYfM6110554;
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
Subject: [PATCH 01/10] ARM: Kconfig: move platform selection into its own Kconfig file
Date:   Mon, 6 Mar 2023 10:34:32 -0600
Message-ID: <20230306163441.16179-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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
index e24a9820e12f..495b1d9444ab 100644
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

