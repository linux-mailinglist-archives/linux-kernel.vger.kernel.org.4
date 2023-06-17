Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869D7733E5B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbjFQFZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjFQFYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492F1FDD;
        Fri, 16 Jun 2023 22:24:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso1041547f8f.2;
        Fri, 16 Jun 2023 22:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979482; x=1689571482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAgPAF+zjeuI/E9IUlDFcsX7pn0c4FT4mD/fF6VQFeU=;
        b=WPAkvsO6R8/539r1dAieioMt3hHo0ICoaveFFkglmusSLXxUflbxZb9PPpUkZEXgQz
         H68f8bkDGoF3XPIoGC24Xzyz4kMmLNpCyOmsufYNaS0ULpcTaFZu7BL0u6sG5VNybB0P
         2pC8WlaRRDZdZL1Gx72XFOTyDIb5y5m3bFAUHCxyO0lz/b0rT0nvJqMh4PPL62ZzXWxU
         Wrh/vBQp99naMcBnSYCnD2V3vZ4vWrEubtD+u7xTMRub+gI/iBXMROLnL9lMScM4S5lZ
         8HXoDCvTDkuHIUAqjCVaKQiP9jW+ECpQylFWe4i1V6UzfZ+6KNTOXjB7aJLcGVmXGrXz
         TYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979482; x=1689571482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAgPAF+zjeuI/E9IUlDFcsX7pn0c4FT4mD/fF6VQFeU=;
        b=cp2uPJw+T43NYxk/rmXi44IE51pjBwac0sUgvChrNJb3xdYADE8Xe7cbXevHoJBNzt
         +KrkV4HluWmlZ/fhHRzeftAFwDmbYn+++pslya6zHE2gxrggawlfPpQB3e5DG7L7iAMR
         Q2sqV26sovFM+CjLTHFVuzLyT0pG0Nf/4AhoTiQ1K8+pln9Obfl1rBE5BPKBUhELnmR7
         wc/V/WbX3ALTAKmW4aAxznr+wtEQwJjJNsxgXklQ7rrBH2JA2nH7rMv8VlVlcw0vPIrT
         sL/zeEozZ+Yj+omMT2Z94EqkkPuXbYlvki+KCAWObPZPJG+vlt/h3PzyaPxDQEXgUXn8
         uqBA==
X-Gm-Message-State: AC+VfDwiyG72lmMXk/BpY6hmYoXhwiY96LooyqDr9vI0uimSrX2e1qAK
        LH5hivM6Y2OHn1AXgRAL2heeVuFBabU=
X-Google-Smtp-Source: ACHHUZ4ZuyE9rTX7GhcBshOKiLztcsqkNQZqtq/efvyIv98/b3Ugin9lq/OjQ4qq4Hsdz6nrW4N20A==
X-Received: by 2002:adf:e591:0:b0:30e:1103:2e39 with SMTP id l17-20020adfe591000000b0030e11032e39mr2893331wrm.58.1686979482223;
        Fri, 16 Jun 2023 22:24:42 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:41 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 4/9] mips: ralink: rt305x: remove clock related code
Date:   Sat, 17 Jun 2023 07:24:30 +0200
Message-Id: <20230617052435.359177-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A properly clock driver for ralink SoCs has been added. Hence there is no
need to have clock related code in 'arch/mips/ralink' folder anymore.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/rt305x.h | 21 ------
 arch/mips/ralink/rt305x.c                  | 78 ----------------------
 2 files changed, 99 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index ef58f7bff957..4fc5c279cd75 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -67,26 +67,9 @@ static inline int soc_is_rt5350(void)
 #define CHIP_ID_ID_SHIFT		8
 #define CHIP_ID_REV_MASK		0xff
 
-#define RT305X_SYSCFG_CPUCLK_SHIFT		18
-#define RT305X_SYSCFG_CPUCLK_MASK		0x1
-#define RT305X_SYSCFG_CPUCLK_LOW		0x0
-#define RT305X_SYSCFG_CPUCLK_HIGH		0x1
-
 #define RT305X_SYSCFG_SRAM_CS0_MODE_SHIFT	2
-#define RT305X_SYSCFG_CPUCLK_MASK		0x1
 #define RT305X_SYSCFG_SRAM_CS0_MODE_WDT		0x1
 
-#define RT3352_SYSCFG0_CPUCLK_SHIFT	8
-#define RT3352_SYSCFG0_CPUCLK_MASK	0x1
-#define RT3352_SYSCFG0_CPUCLK_LOW	0x0
-#define RT3352_SYSCFG0_CPUCLK_HIGH	0x1
-
-#define RT5350_SYSCFG0_CPUCLK_SHIFT	8
-#define RT5350_SYSCFG0_CPUCLK_MASK	0x3
-#define RT5350_SYSCFG0_CPUCLK_360	0x0
-#define RT5350_SYSCFG0_CPUCLK_320	0x2
-#define RT5350_SYSCFG0_CPUCLK_300	0x3
-
 #define RT5350_SYSCFG0_DRAM_SIZE_SHIFT  12
 #define RT5350_SYSCFG0_DRAM_SIZE_MASK   7
 #define RT5350_SYSCFG0_DRAM_SIZE_2M     0
@@ -117,13 +100,9 @@ static inline int soc_is_rt5350(void)
 
 #define RT3352_SYSC_REG_SYSCFG0		0x010
 #define RT3352_SYSC_REG_SYSCFG1         0x014
-#define RT3352_SYSC_REG_CLKCFG1         0x030
 #define RT3352_SYSC_REG_RSTCTRL         0x034
 #define RT3352_SYSC_REG_USB_PS          0x05c
 
-#define RT3352_CLKCFG0_XTAL_SEL		BIT(20)
-#define RT3352_CLKCFG1_UPHY0_CLK_EN	BIT(18)
-#define RT3352_CLKCFG1_UPHY1_CLK_EN	BIT(20)
 #define RT3352_RSTCTRL_UHST		BIT(22)
 #define RT3352_RSTCTRL_UDEV		BIT(25)
 #define RT3352_SYSCFG1_USB0_HOST_MODE	BIT(10)
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index d8dcc5cc66cc..9cffe69dd11d 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -56,84 +56,6 @@ static unsigned long rt5350_get_mem_size(void)
 	return ret;
 }
 
-void __init ralink_clk_init(void)
-{
-	unsigned long cpu_rate, sys_rate, wdt_rate, uart_rate;
-	unsigned long wmac_rate = 40000000;
-
-	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
-
-	if (soc_is_rt305x() || soc_is_rt3350()) {
-		t = (t >> RT305X_SYSCFG_CPUCLK_SHIFT) &
-		     RT305X_SYSCFG_CPUCLK_MASK;
-		switch (t) {
-		case RT305X_SYSCFG_CPUCLK_LOW:
-			cpu_rate = 320000000;
-			break;
-		case RT305X_SYSCFG_CPUCLK_HIGH:
-			cpu_rate = 384000000;
-			break;
-		}
-		sys_rate = uart_rate = wdt_rate = cpu_rate / 3;
-	} else if (soc_is_rt3352()) {
-		t = (t >> RT3352_SYSCFG0_CPUCLK_SHIFT) &
-		     RT3352_SYSCFG0_CPUCLK_MASK;
-		switch (t) {
-		case RT3352_SYSCFG0_CPUCLK_LOW:
-			cpu_rate = 384000000;
-			break;
-		case RT3352_SYSCFG0_CPUCLK_HIGH:
-			cpu_rate = 400000000;
-			break;
-		}
-		sys_rate = wdt_rate = cpu_rate / 3;
-		uart_rate = 40000000;
-	} else if (soc_is_rt5350()) {
-		t = (t >> RT5350_SYSCFG0_CPUCLK_SHIFT) &
-		     RT5350_SYSCFG0_CPUCLK_MASK;
-		switch (t) {
-		case RT5350_SYSCFG0_CPUCLK_360:
-			cpu_rate = 360000000;
-			sys_rate = cpu_rate / 3;
-			break;
-		case RT5350_SYSCFG0_CPUCLK_320:
-			cpu_rate = 320000000;
-			sys_rate = cpu_rate / 4;
-			break;
-		case RT5350_SYSCFG0_CPUCLK_300:
-			cpu_rate = 300000000;
-			sys_rate = cpu_rate / 3;
-			break;
-		default:
-			BUG();
-		}
-		uart_rate = 40000000;
-		wdt_rate = sys_rate;
-	} else {
-		BUG();
-	}
-
-	if (soc_is_rt3352() || soc_is_rt5350()) {
-		u32 val = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG0);
-
-		if (!(val & RT3352_CLKCFG0_XTAL_SEL))
-			wmac_rate = 20000000;
-	}
-
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("sys", sys_rate);
-	ralink_clk_add("10000900.i2c", uart_rate);
-	ralink_clk_add("10000a00.i2s", uart_rate);
-	ralink_clk_add("10000b00.spi", sys_rate);
-	ralink_clk_add("10000b40.spi", sys_rate);
-	ralink_clk_add("10000100.timer", wdt_rate);
-	ralink_clk_add("10000120.watchdog", wdt_rate);
-	ralink_clk_add("10000500.uart", uart_rate);
-	ralink_clk_add("10000c00.uartlite", uart_rate);
-	ralink_clk_add("10100000.ethernet", sys_rate);
-	ralink_clk_add("10180000.wmac", wmac_rate);
-}
-
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,rt3050-sysc");
-- 
2.25.1

