Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67C613D84
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJaSjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJaSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:39:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E923DFBE;
        Mon, 31 Oct 2022 11:39:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so8592488wma.3;
        Mon, 31 Oct 2022 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO0hR+mA7XsIVW5Nnr5hXmEUqr6a0eEpTl+MenNMsiI=;
        b=EMqKYq4M+t5u9621Qu0FJlRVcBZRHqqApW+FBqNK0JDwLVaH80E5AoY5ooKsaR0gwL
         BF7q7D8U4YVSoRq4sNW1xdjD12vJXF606ToGLjhBJ+NB5vIQZsXQcm4TNPcCGkG6MOad
         RcRhPJYsv7/9csRevNZVxBtf0Bsbv6iw06zFngvEW6LUFal8Y2zK2Ie2DOAZgD33pg77
         B+ZIYUppfz+Amd493iXjge38V4EjydEzPCaDgR8+gv9GQ537X7fsZh3NY7X4NrUzHdqs
         cC/deeZOUrpW4prxRCzn6EcUa4viQ/nZZPK4d3MS537rDYATQAPF2PuBGf1TPZcpxCWx
         VJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO0hR+mA7XsIVW5Nnr5hXmEUqr6a0eEpTl+MenNMsiI=;
        b=zKKyaaHmNsG+fWQTux2/aHPLF8LkWPk+G1BPccDr2OtbftncBzR4Wb/2+AWhK/0ZCw
         3SYQ2TyH/obPADPkAJlV/SQ7pffY4GO4yauza3Cgx32aXa2MQei8hURyzMBKlRezsPhm
         gQzyMfkjHO5uO/8qd5YEv3AEGf4TAOS+1NOR1eV3AbxpFO140zna6sUpCJL05ulGKxb0
         WhIeoBbz8Tg5rNvPOmAQo59e75F+BsYaBkfgiYsjlOKeeKiXFcbrQKOpkgixO/CjQaoM
         Pz3WbyOltLNgbHwF3/Afbi8mNzERc8Pi81PRiwUtHVEpMgJeSkrG9BHL1/f9hR8VCBLf
         pdkw==
X-Gm-Message-State: ACrzQf3wMOH14B/ksC2EutoYEq9mxdq4NkDQ6UBFUnLmuTXD2p2mD399
        +2OQRmV7W56MMHNtcIvcuBg=
X-Google-Smtp-Source: AMsMyM50eH2U3ydPrRlqJlFFXHKqwNbsc84ktqj6f++WiRdCsFvzz7+B35XJxIh8b+HnTaqQuVu8aQ==
X-Received: by 2002:a05:600c:5127:b0:3c6:47ff:5d33 with SMTP id o39-20020a05600c512700b003c647ff5d33mr9623522wms.68.1667241585031;
        Mon, 31 Oct 2022 11:39:45 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003cf55844453sm9065067wmp.22.2022.10.31.11.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:39:44 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v7 1/1] clk: Add Ingenic JZ4755 CGU driver
Date:   Mon, 31 Oct 2022 21:39:29 +0300
Message-Id: <20221031183930.1338009-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221031183930.1338009-1-lis8215@gmail.com>
References: <20221031183930.1338009-1-lis8215@gmail.com>
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
 drivers/clk/ingenic/jz4755-cgu.c | 346 +++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)
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
index 000000000..f2c2d848d
--- /dev/null
+++ b/drivers/clk/ingenic/jz4755-cgu.c
@@ -0,0 +1,346 @@
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
+#define CGU_REG_CPPCR		0x10
+#define CGU_REG_CLKGR		0x20
+#define CGU_REG_OPCR		0x24
+#define CGU_REG_I2SCDR		0x60
+#define CGU_REG_LPCDR		0x64
+#define CGU_REG_MSCCDR		0x68
+#define CGU_REG_SSICDR		0x74
+#define CGU_REG_CIMCDR		0x7C
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
+		.parents = { JZ4755_CLK_EXT, },
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
+		.parents = { JZ4755_CLK_PLL, },
+		.div = {
+			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1, 0,
+			jz4755_cgu_pll_half_div_table,
+		},
+	},
+
+	[JZ4755_CLK_EXT_HALF] = {
+		"ext half", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_EXT, },
+		.div = {
+			CGU_REG_CPCCR, 30, 1, 1, -1, -1, -1, 0,
+			NULL,
+		},
+	},
+
+	[JZ4755_CLK_CCLK] = {
+		"cclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, },
+		.div = {
+			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_H0CLK] = {
+		"hclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, },
+		.div = {
+			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_PCLK] = {
+		"pclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, },
+		.div = {
+			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_MCLK] = {
+		"mclk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, },
+		.div = {
+			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_H1CLK] = {
+		"h1clk", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL, },
+		.div = {
+			CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1, 0,
+			jz4755_cgu_cpccr_div_table,
+		},
+	},
+
+	[JZ4755_CLK_UDC] = {
+		"udc", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, JZ4755_CLK_PLL_HALF, },
+		.mux = { CGU_REG_CPCCR, 29, 1 },
+		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 10 },
+	},
+
+	[JZ4755_CLK_LCD] = {
+		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF, },
+		.div = { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 9 },
+	},
+
+	[JZ4755_CLK_MMC] = {
+		"mmc", CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_PLL_HALF, },
+		.div = { CGU_REG_MSCCDR, 0, 1, 5, -1, -1, -1 },
+	},
+
+	[JZ4755_CLK_I2S] = {
+		"i2s", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4755_CLK_EXT_HALF, JZ4755_CLK_PLL_HALF, },
+		.mux = { CGU_REG_CPCCR, 31, 1 },
+		.div = { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
+	},
+
+	[JZ4755_CLK_SPI] = {
+		"spi", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF, },
+		.div = { CGU_REG_SSICDR, 0, 1, 4, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 4 },
+	},
+
+	[JZ4755_CLK_TVE] = {
+		"tve", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_LCD, JZ4755_CLK_EXT, },
+		.mux = { CGU_REG_LPCDR, 31, 1 },
+		.gate = { CGU_REG_CLKGR, 18 },
+	},
+
+	[JZ4755_CLK_RTC] = {
+		"rtc", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT512, JZ4755_CLK_OSC32K, },
+		.mux = { CGU_REG_OPCR, 2, 1},
+		.gate = { CGU_REG_CLKGR, 2 },
+	},
+
+	[JZ4755_CLK_CIM] = {
+		"cim", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF, },
+		.div = { CGU_REG_CIMCDR, 0, 1, 8, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 8 },
+	},
+
+	/* Gate-only clocks */
+
+	[JZ4755_CLK_UART0] = {
+		"uart0", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, },
+		.gate = { CGU_REG_CLKGR, 0 },
+	},
+
+	[JZ4755_CLK_UART1] = {
+		"uart1", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, },
+		.gate = { CGU_REG_CLKGR, 14 },
+	},
+
+	[JZ4755_CLK_UART2] = {
+		"uart2", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, },
+		.gate = { CGU_REG_CLKGR, 15 },
+	},
+
+	[JZ4755_CLK_ADC] = {
+		"adc", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, },
+		.gate = { CGU_REG_CLKGR, 7 },
+	},
+
+	[JZ4755_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, },
+		.gate = { CGU_REG_CLKGR, 5 },
+	},
+
+	[JZ4755_CLK_I2C] = {
+		"i2c", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, },
+		.gate = { CGU_REG_CLKGR, 3 },
+	},
+
+	[JZ4755_CLK_BCH] = {
+		"bch", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, },
+		.gate = { CGU_REG_CLKGR, 11 },
+	},
+
+	[JZ4755_CLK_TCU] = {
+		"tcu", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT, },
+		.gate = { CGU_REG_CLKGR, 1 },
+	},
+
+	[JZ4755_CLK_DMA] = {
+		"dma", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PCLK, },
+		.gate = { CGU_REG_CLKGR, 12 },
+	},
+
+	[JZ4755_CLK_MMC0] = {
+		"mmc0", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_MMC, },
+		.gate = { CGU_REG_CLKGR, 6 },
+	},
+
+	[JZ4755_CLK_MMC1] = {
+		"mmc1", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_MMC, },
+		.gate = { CGU_REG_CLKGR, 16 },
+	},
+
+	[JZ4755_CLK_AUX_CPU] = {
+		"aux_cpu", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, },
+		.gate = { CGU_REG_CLKGR, 24 },
+	},
+
+	[JZ4755_CLK_AHB1] = {
+		"ahb1", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, },
+		.gate = { CGU_REG_CLKGR, 23 },
+	},
+
+	[JZ4755_CLK_IDCT] = {
+		"idct", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, },
+		.gate = { CGU_REG_CLKGR, 22 },
+	},
+
+	[JZ4755_CLK_DB] = {
+		"db", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, },
+		.gate = { CGU_REG_CLKGR, 21 },
+	},
+
+	[JZ4755_CLK_ME] = {
+		"me", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, },
+		.gate = { CGU_REG_CLKGR, 20 },
+	},
+
+	[JZ4755_CLK_MC] = {
+		"mc", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_H1CLK, },
+		.gate = { CGU_REG_CLKGR, 19 },
+	},
+
+	[JZ4755_CLK_TSSI] = {
+		"tssi", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF/* not sure */, },
+		.gate = { CGU_REG_CLKGR, 17 },
+	},
+
+	[JZ4755_CLK_IPU] = {
+		"ipu", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_PLL_HALF/* not sure */, },
+		.gate = { CGU_REG_CLKGR, 13 },
+	},
+
+	[JZ4755_CLK_EXT512] = {
+		"ext/512", CGU_CLK_FIXDIV,
+		.parents = { JZ4755_CLK_EXT, },
+
+		.fixdiv = { 512 },
+	},
+
+	[JZ4755_CLK_UDC_PHY] = {
+		"udc_phy", CGU_CLK_GATE,
+		.parents = { JZ4755_CLK_EXT_HALF, },
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
+/*
+ * CGU has some children devices, this is useful for probing children devices
+ * in the case where the device node is compatible with "simple-mfd".
+ */
+CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu", jz4755_cgu_init);
-- 
2.36.1

