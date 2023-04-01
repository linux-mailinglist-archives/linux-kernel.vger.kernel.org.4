Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BBA6D2FE0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDALTu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Apr 2023 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDALTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:19:48 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD07020339;
        Sat,  1 Apr 2023 04:19:46 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5E36F24E22F;
        Sat,  1 Apr 2023 19:19:45 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:45 +0800
Received: from ubuntu.localdomain (113.72.144.76) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:44 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 08/22] reset: Create subdirectory for StarFive drivers
Date:   Sat, 1 Apr 2023 19:19:20 +0800
Message-ID: <20230401111934.130844-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230401111934.130844-1-hal.feng@starfivetech.com>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.76]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

This moves the StarFive JH7100 reset driver to a new subdirectory in
preparation for adding more StarFive reset drivers.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/reset/Kconfig                                | 8 +-------
 drivers/reset/Makefile                               | 2 +-
 drivers/reset/starfive/Kconfig                       | 8 ++++++++
 drivers/reset/starfive/Makefile                      | 2 ++
 drivers/reset/{ => starfive}/reset-starfive-jh7100.c | 0
 5 files changed, 12 insertions(+), 8 deletions(-)
 create mode 100644 drivers/reset/starfive/Kconfig
 create mode 100644 drivers/reset/starfive/Makefile
 rename drivers/reset/{ => starfive}/reset-starfive-jh7100.c (100%)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 6ae5aa46a6b2..6aa8f243b30c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -232,13 +232,6 @@ config RESET_SOCFPGA
 	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
 	  driver gets initialized early during platform init calls.
 
-config RESET_STARFIVE_JH7100
-	bool "StarFive JH7100 Reset Driver"
-	depends on ARCH_STARFIVE || COMPILE_TEST
-	default ARCH_STARFIVE
-	help
-	  This enables the reset controller driver for the StarFive JH7100 SoC.
-
 config RESET_SUNPLUS
 	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
 	default ARCH_SUNPLUS
@@ -320,6 +313,7 @@ config RESET_ZYNQ
 	help
 	  This enables the reset controller driver for Xilinx Zynq SoCs.
 
+source "drivers/reset/starfive/Kconfig"
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
 source "drivers/reset/tegra/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 3e7e5fd633a8..7fec5af6c964 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core.o
 obj-y += hisilicon/
+obj-y += starfive/
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
@@ -30,7 +31,6 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
-obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
new file mode 100644
index 000000000000..abbf0c52d03e
--- /dev/null
+++ b/drivers/reset/starfive/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RESET_STARFIVE_JH7100
+	bool "StarFive JH7100 Reset Driver"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	default ARCH_STARFIVE
+	help
+	  This enables the reset controller driver for the StarFive JH7100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
new file mode 100644
index 000000000000..670d049423f5
--- /dev/null
+++ b/drivers/reset/starfive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
similarity index 100%
rename from drivers/reset/reset-starfive-jh7100.c
rename to drivers/reset/starfive/reset-starfive-jh7100.c
-- 
2.38.1

