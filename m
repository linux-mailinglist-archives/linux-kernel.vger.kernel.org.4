Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63384600057
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJPPDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJPPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:03:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9599C41993;
        Sun, 16 Oct 2022 08:03:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m15so12785333edb.13;
        Sun, 16 Oct 2022 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oicZhaFyYQwyfEJAZw8xjpjgeEJyH48EiK4Wz1kX8mo=;
        b=gE5zkGQCXBMLIitfa424vPCkVcC/e6nBLnolVrHfT04HN1dc46usB/vZ5lI6lnjtCS
         erFHKZiLRN32XlGHnCd3VJsMhwngb4WSHwslamTYfK8XA5WGUMEoIyo4X1XbB0zCfG2Z
         Zh1Xr622F8BToMQv+DLkXVktsQY9w2NLBQWevQNkB/BdUMxTOiek9S5i3BX9WPVt7pAB
         XFeNLNZfqzgG2D/uHqR182kpe5fRBuGVe4J1mas149L0QpAvY61TMplxL8yzgqE9G6PZ
         ZNlfgDrrpEevNRgVnm+oITCW90rqLREihyIoxxMfoj4w8CkxmmpWyYJwc9AoCjgnSyPX
         XaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oicZhaFyYQwyfEJAZw8xjpjgeEJyH48EiK4Wz1kX8mo=;
        b=5EZTNfq7ZXQSAA/QkpsMCM6nw4u7zvA5cdfRdu8zv9i9FVTtPWHV1pX9ZxhlavQMyy
         Igfv5CF/EpXn5aEeQ/iWa7+CrMqMVAGDqgzTQBe8ooee3hs+Wq3/MGNvLP6TAsBxhdDM
         JB2KgtcLjFWei7caeCwghtvd0uZ7LU9OxSAxp31kxdV19UDmG4vicSlVS+7ajvrOpd/O
         1SWKiG8sNBYBSrW6VYAer9OeDMqMvsCaTfG/v5QjaC+DF5HW5tHSf//RbXrKcHqxfT2k
         fka1ZecsLLzQytMl3nswz359TVkQoROH/jSs4YgCJ7/jmuS5AJFJEBWdYGVuXWu3rEoZ
         l2bA==
X-Gm-Message-State: ACrzQf3Fn4hxs6Ce6fzytFpbR99DELKQQoyXx1abMnqqO7TLl2ChfExY
        K5BMmcqnUIzSzOljL2TA5Sc=
X-Google-Smtp-Source: AMsMyM7kMNUzB0vOdNwtSUDlAfBgGPuO63eGi9zL6FNYH/oJdIUOKoNPGsUk+Yyz6rCLuPbqHgUaow==
X-Received: by 2002:aa7:c0cf:0:b0:45c:6a06:ea9a with SMTP id j15-20020aa7c0cf000000b0045c6a06ea9amr6399924edp.211.1665932595816;
        Sun, 16 Oct 2022 08:03:15 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090657c800b0078c1e174e11sm4645699ejr.136.2022.10.16.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:03:15 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 4/4] clk: Add Ingenic JZ4755 CGU driver
Date:   Sun, 16 Oct 2022 18:01:09 +0300
Message-Id: <20221016150110.3020451-5-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016150110.3020451-1-lis8215@gmail.com>
References: <20221016150110.3020451-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the clocks provided by the CGU in the Ingenic JZ4755
SoC.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/clk/ingenic/Kconfig      |  10 +
 drivers/clk/ingenic/Makefile     |   1 +
 drivers/clk/ingenic/jz4755-cgu.c | 350 +++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 drivers/clk/ingenic/jz4755-cgu.c

diff --git a/drivers/clk/ingenic/Kconfig b/drivers/clk/ingenic/Kconfig
index 898f1bc47..f80ac4f29 100644
--- a/drivers/clk/ingenic/Kconfig
+++ b/drivers/clk/ingenic/Kconfig
@@ -15,6 +15,16 @@ config INGENIC_CGU_JZ4740
 
 	  If building for a JZ4740 SoC, you want to say Y here.
 
+config INGENIC_CGU_JZ4755
+	bool "Ingenic JZ4755 CGU driver"
+	default MACH_JZ4755
+	select INGENIC_CGU_COMMON
+	help
+	  Support the clocks provided by the CGU hardware on Ingenic JZ4755
+	  and compatible SoCs.
+
+	  If building for a JZ4755 SoC, you want to say Y here.
+
 config INGENIC_CGU_JZ4725B
 	bool "Ingenic JZ4725B CGU driver"
 	default MACH_JZ4725B
diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
index 9edfaf461..81d8e23c2 100644
--- a/drivers/clk/ingenic/Makefile
+++ b/drivers/clk/ingenic/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_INGENIC_CGU_COMMON)	+= cgu.o pm.o
 obj-$(CONFIG_INGENIC_CGU_JZ4740)	+= jz4740-cgu.o
+obj-$(CONFIG_INGENIC_CGU_JZ4755)	+= jz4755-cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4725B)	+= jz4725b-cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4760)	+= jz4760-cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4770)	+= jz4770-cgu.o
diff --git a/drivers/clk/ingenic/jz4755-cgu.c b/drivers/clk/ingenic/jz4755-cgu.c
new file mode 100644
index 000000000..16728546a
--- /dev/null
+++ b/drivers/clk/ingenic/jz4755-cgu.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic JZ4755 SoC CGU driver
+ * Heavily based on JZ4725b CGU driver
+ *
+ * Copyright (C) 2022 Siarhei Volkau
+ * Author: Siarhei Volkau <lis8215@gmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
+#include <dt-bindings/clock/ingenic,jz4755-cgu.h>
+
+#include "cgu.h"
+#include "pm.h"
+
+/* CGU register offsets */
+#define CGU_REG_CPCCR		0x00
+#define CGU_REG_LCR		0x04
+#define CGU_REG_CPPCR		0x10
+#define CGU_REG_CLKGR		0x20
+#define CGU_REG_OPCR		0x24
+#define CGU_REG_I2SCDR		0x60
+#define CGU_REG_LPCDR		0x64
+#define CGU_REG_MSCCDR		0x68
+#define CGU_REG_SSICDR		0x74
+#define CGU_REG_CIMCDR		0x7C
+
+/* bits within the LCR register */
+#define LCR_SLEEP		BIT(0)
+
+static struct ingenic_cgu *cgu;
+
+static const s8 pll_od_encoding[4] = {
+	0x0, 0x1, -1, 0x3,
+};
+
+static const u8 jz4755_cgu_cpccr_div_table[] = {
+	1, 2, 3, 4, 6, 8,
+};
+
+static const u8 jz4755_cgu_pll_half_div_table[] = {
+	2, 1,
+};
+
+static const struct ingenic_cgu_clk_info jz4755_cgu_clocks[] = {
+
+	/* External clocks */
+
+	[JZ4755_CLK_EXT] = { "ext", CGU_CLK_EXT },
+	[JZ4755_CLK_OSC32K] = { "osc32k", CGU_CLK_EXT },
+
+	[JZ4755_CLK_PLL] = {
+		"pll", CGU_CLK_PLL,
+		.parents = { JZ4755_CLK_EXT, -1, -1, -1 },
+		.pll = {
+			.reg = CGU_REG_CPPCR,
+			.rate_multiplier = 1,
+			.m_shift = 23,
+			.m_bits = 9,
+			.m_offset = 2,
+			.n_shift = 18,
+			.n_bits = 5,
+			.n_offset = 2,
+			.od_shift = 16,
+			.od_bits = 2,
+			.od_max = 4,
+			.od_encoding = pll_od_encoding,
+			.stable_bit = 10,
+			.bypass_reg = CGU_REG_CPPCR,
+			.bypass_bit = 9,
+			.enable_bit = 8,
+		},
+	},
+
+	/* Muxes & dividers */
+
+	[JZ4755_CLK_PLL_HALF] = {
+		"pll half", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1, 0,
+			jz4755_cgu_pll_half_div_table,
+		},
+	},
+
+	[JZ4755_CLK_EXT_HALF] = {
+		"ext half", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_EXT, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 30, 1, 1, -1, -1, -1, 0,
+			NULL,
+		},
+	},
+
+	[JZ4755_CLK_CCLK] = {
+		"cclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_H0CLK] = {
+		"hclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_PCLK] = {
+		"pclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_MCLK] = {
+		"mclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_H1CLK] = {
+		"h1clk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_UDC] = {
+		"udc", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, JZ4755_CLK_PLL_HALF, -1, -1 },
+		.mux = { CGU_REG_CPCCR, 29, 1 },
+		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 10 },
+	},
+
+	[JZ4755_CLK_LCD] = {
+		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF, -1, -1, -1 },
+		.div = { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 9 },
+	},
+
+	[JZ4755_CLK_MMC] = {
+		"mmc", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL_HALF, -1, -1, -1 },
+		.div = { CGU_REG_MSCCDR, 0, 1, 5, -1, -1, -1 },
+	},
+
+	[JZ4755_CLK_I2S] = {
+		"i2s", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_EXT_HALF, JZ4755_CLK_PLL_HALF, -1, -1 },
+		.mux = { CGU_REG_CPCCR, 31, 1 },
+		.div = { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
+	},
+
+	[JZ4755_CLK_SPI] = {
+		"spi", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF, -1, -1, -1 },
+		.div = { CGU_REG_SSICDR, 0, 1, 4, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 4 },
+	},
+
+	[JZ4755_CLK_TVE] = {
+		"tve", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_LCD, JZ4755_CLK_EXT, -1, -1 },
+		.mux = { CGU_REG_LPCDR, 31, 1 },
+		.gate = { CGU_REG_CLKGR, 18 },
+	},
+
+	[JZ4755_CLK_RTC] = {
+		"rtc", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT512, JZ4755_CLK_OSC32K, -1, -1 },
+		.mux = { CGU_REG_OPCR, 2, 1},
+		.gate = { CGU_REG_CLKGR, 2 },
+	},
+
+	[JZ4755_CLK_CIM] = {
+		"cim", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF, -1, -1, -1 },
+		.div = { CGU_REG_CIMCDR, 0, 1, 8, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 8 },
+	},
+
+	/* Gate-only clocks */
+
+	[JZ4755_CLK_UART0] = {
+		"uart0", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 0 },
+	},
+
+	[JZ4755_CLK_UART1] = {
+		"uart1", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 14 },
+	},
+
+	[JZ4755_CLK_UART2] = {
+		"uart2", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 15 },
+	},
+
+	[JZ4755_CLK_ADC] = {
+		"adc", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 7 },
+	},
+
+	[JZ4755_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_I2S, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 5 },
+	},
+
+	[JZ4755_CLK_I2C] = {
+		"i2c", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 3 },
+	},
+
+	[JZ4755_CLK_BCH] = {
+		"bch", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_MCLK/* not sure */, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 11 },
+	},
+
+	[JZ4755_CLK_TCU] = {
+		"tcu", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 1 },
+	},
+
+	[JZ4755_CLK_DMA] = {
+		"dma", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 12 },
+	},
+
+	[JZ4755_CLK_MMC0] = {
+		"mmc0", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_MMC, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 6 },
+	},
+
+	[JZ4755_CLK_MMC1] = {
+		"mmc1", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_MMC, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 16 },
+	},
+
+	[JZ4755_CLK_AUX_CPU] = {
+		"aux_cpu", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 24 },
+	},
+
+	[JZ4755_CLK_AHB1] = {
+		"ahb1", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 23 },
+	},
+
+	[JZ4755_CLK_IDCT] = {
+		"idct", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 22 },
+	},
+
+	[JZ4755_CLK_DB] = {
+		"db", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 21 },
+	},
+
+	[JZ4755_CLK_ME] = {
+		"me", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 20 },
+	},
+
+	[JZ4755_CLK_MC] = {
+		"mc", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 19 },
+	},
+
+	[JZ4755_CLK_TSSI] = {
+		"tssi", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF/* not sure */, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 17 },
+	},
+
+	[JZ4755_CLK_IPU] = {
+		"ipu", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF/* not sure */, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 13 },
+	},
+
+	[JZ4755_CLK_EXT512] = {
+		"ext/512", CGU_CLK_FIXDIV,
+		.parents = { JZ4755_CLK_EXT },
+
+		/* JZ4725b doc calls it EXT512, but it seems to be /256...
+		 * Not sure if it applied to JZ4755 too, and which actual
+		 * source is used EXT or EXT_HALF
+		 */
+		.fixdiv = { 256 },
+	},
+
+	[JZ4755_CLK_UDC_PHY] = {
+		"udc_phy", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, -1, -1, -1 },
+		.gate = { CGU_REG_OPCR, 6, true },
+	},
+};
+
+static void __init jz4755_cgu_init(struct device_node *np)
+{
+	int retval;
+
+	cgu = ingenic_cgu_new(jz4755_cgu_clocks,
+			      ARRAY_SIZE(jz4755_cgu_clocks), np);
+	if (!cgu) {
+		pr_err("%s: failed to initialise CGU\n", __func__);
+		return;
+	}
+
+	retval = ingenic_cgu_register_clocks(cgu);
+	if (retval)
+		pr_err("%s: failed to register CGU Clocks\n", __func__);
+
+	ingenic_cgu_register_syscore_ops(cgu);
+}
+CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu", jz4755_cgu_init);
-- 
2.36.1

