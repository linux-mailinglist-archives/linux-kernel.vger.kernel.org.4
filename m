Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA32D5F0BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiI3MZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiI3MZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:25:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD36773317;
        Fri, 30 Sep 2022 05:25:34 -0700 (PDT)
X-QQ-mid: bizesmtp71t1664540601timrcnbn
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 20:23:20 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: dS+JUNSIibdYmLj5t1I9ugN+S0ksnIEycmIIAPYyEFfZJVg9V/kdWfTdMQPEk
        fjiuX7Oae/U06nm1p3ELka+dZsKdTvpPxceFNxZs2W5d9q7tN+Mlh/tTsnCLp+g6MD8EPCS
        /Omd+8wurSlmyVZfI2W/RsS4n2SttiwKTr4ZAKOIT9PVufqV9TzIFqghUyiauNZC9Ivg2gS
        eYUqfNTfp36XhmArpqvagc+H+BPz+pO2/qJ/vSyY+mlbNx2FTcSMVqpeA7+yi8QJ5ISZxqT
        wVnKrNoH4hnS19Rz8hErC91RmQbG1g+8wjDRa2yNP2JEJ6cXnZdrQjOle67cSq7QT7C55Mw
        60KgXmT3qTPNobR9taWYEIhn5WBP7AMaxciOBVayF+QGM0k/4WYweBP1+XhVPm20wpK3aHZ
        eXD32uXPZCs=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 30/30] RISC-V: Add StarFive JH7100 and JH7110 SoC Kconfig options
Date:   Fri, 30 Sep 2022 20:23:18 +0800
Message-Id: <20220930122318.9244-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig options to select the specified StarFive SoC. Select
necessary Kconfig options required by the specified SoC for booting.

Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 arch/riscv/Kconfig.socs               | 27 ++++++++++++++++++++++++++-
 arch/riscv/boot/dts/starfive/Makefile |  4 ++--
 drivers/clk/starfive/Kconfig          | 14 ++++++--------
 drivers/pinctrl/starfive/Kconfig      |  6 ++----
 drivers/reset/Kconfig                 |  1 -
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 10f68a4359f9..321c448e7b6f 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -22,10 +22,35 @@ config SOC_STARFIVE
 	bool "StarFive SoCs"
 	select PINCTRL
 	select RESET_CONTROLLER
+	select RESET_STARFIVE
+	help
+	  This enables support for StarFive SoC platform hardware.
+
+if SOC_STARFIVE
+
+config SOC_JH7100
+	bool "StarFive JH7100 SoC support"
+	depends on SOC_STARFIVE
 	select SIFIVE_L2
 	select SIFIVE_PLIC
+	select CLK_STARFIVE_JH7100
+	select PINCTRL_STARFIVE_JH7100
+	default SOC_STARFIVE
 	help
-	  This enables support for StarFive SoC platform hardware.
+	  This enables support for StarFive JH7100 SoC.
+
+config SOC_JH7110
+	bool "StarFive JH7110 SoC support"
+	depends on SOC_STARFIVE
+	select SIFIVE_L2
+	select SIFIVE_PLIC
+	select CLK_STARFIVE_JH7110_SYS
+	select PINCTRL_STARFIVE_JH7110
+	default SOC_STARFIVE
+	help
+	  This enables support for StarFive JH7110 SoC.
+
+endif
 
 config SOC_VIRT
 	bool "QEMU Virt Machine"
diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index e1237dbc6aac..a6ecd3c2ec7d 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
-dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-v2.dtb
+dtb-$(CONFIG_SOC_JH7100) += jh7100-beaglev-starlight.dtb
+dtb-$(CONFIG_SOC_JH7110) += jh7110-starfive-visionfive-v2.dtb
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 42aad3b553cb..d0490e9f42db 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -5,36 +5,34 @@ config CLK_STARFIVE
 
 config CLK_STARFIVE_JH7100
 	bool "StarFive JH7100 clock support"
-	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on SOC_JH7100 || COMPILE_TEST
 	select CLK_STARFIVE
-	default SOC_STARFIVE
 	help
 	  Say yes here to support the clock controller on the StarFive JH7100
 	  SoC.
 
 config CLK_STARFIVE_JH7100_AUDIO
 	tristate "StarFive JH7100 audio clock support"
-	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on SOC_JH7100 || COMPILE_TEST
 	select CLK_STARFIVE
-	default m if SOC_STARFIVE
+	default m if SOC_JH7100
 	help
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
 	  SoC.
 
 config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
-	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on SOC_JH7110 || COMPILE_TEST
 	select CLK_STARFIVE
-	default SOC_STARFIVE
 	help
 	  Say yes here to support the system clock controller on the
 	  StarFive JH7110 SoC.
 
 config CLK_STARFIVE_JH7110_AON
 	tristate "StarFive JH7110 always-on clock support"
-	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on SOC_JH7110 || COMPILE_TEST
 	select CLK_STARFIVE
-	default m if SOC_STARFIVE
+	default m if SOC_JH7110
 	help
 	  Say yes here to support the always-on clock controller on the
 	  StarFive JH7110 SoC.
diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index fde39f4a7922..d09bdf6d3029 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -2,7 +2,7 @@
 
 config PINCTRL_STARFIVE_JH7100
 	tristate "Pinctrl and GPIO driver for the StarFive JH7100 SoC"
-	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on SOC_JH7100 || COMPILE_TEST
 	depends on OF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
@@ -10,7 +10,6 @@ config PINCTRL_STARFIVE_JH7100
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
 	select OF_GPIO
-	default SOC_STARFIVE
 	help
 	  Say yes here to support pin control on the StarFive JH7100 SoC.
 	  This also provides an interface to the GPIO pins not used by other
@@ -28,10 +27,9 @@ config PINCTRL_STARFIVE
 
 config PINCTRL_STARFIVE_JH7110
 	bool "Pinctrl and GPIO driver for the StarFive JH7110 SoC"
-	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on SOC_JH7110 || COMPILE_TEST
 	depends on OF
 	select PINCTRL_STARFIVE
-	default SOC_STARFIVE
 	help
 	  Say yes here to support pin control on the StarFive JH7110 SoC.
 	  This also provides an interface to the GPIO pins not used by other
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 8121de5ecc3c..c001879bd890 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -228,7 +228,6 @@ config RESET_SOCFPGA
 config RESET_STARFIVE
 	bool "StarFive SoC Reset Driver"
 	depends on SOC_STARFIVE || COMPILE_TEST
-	default SOC_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive SoCs.
 
-- 
2.17.1

