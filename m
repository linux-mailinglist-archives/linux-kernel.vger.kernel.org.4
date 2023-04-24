Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7676E5CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjDRJEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjDRJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:03:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765135595;
        Tue, 18 Apr 2023 02:03:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q5so15136942wmo.4;
        Tue, 18 Apr 2023 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808602; x=1684400602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5ABgnLDQ8KTbkSaDaBU5MNns2MpFyYj3L81yoSdygg=;
        b=i95EKG0gRBlJIHdjTZwaZB9TiLivWY4tw3KFlKrvJQr1CId6stMfqhgUccnuNtdaKQ
         hsXik85GvsIvrWoufABQtZvoNOMSMdjD0Hp0UrVClSQAvSfyykYicUdOdGsF8yxxMUnR
         fxhE04E3C7l8oSWmng9wIRrO7zJMO94RZC5mn/WlkPia2D3NAwmj+WAIFH9jWp/2rObL
         8ca9/FM1qHlPWLEMHXpq1Th+dmeidUUk6QDaqIcQ9QZm1Yb9bNm323GjFkOOjU4ta+Lb
         rRjGtT4oP2fUVCe0qqDxp5Mtv/w1Y1Uj7gyVFAX0WpfVw54Jh/RqRl+hhnq0aiWEQ0kB
         Z7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808602; x=1684400602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5ABgnLDQ8KTbkSaDaBU5MNns2MpFyYj3L81yoSdygg=;
        b=a++tgFdnCDKUpytHDFfMs1ABqi8O/7EmZbcMKYjq22H9vSIOtp7jUCQERsCyVghkAJ
         XqZNCl48M2hqmvLk13Wm+ZCH044bVIvvpSZUT6/w3W34VfxXGdM70F+ovgmKZexhRuWe
         kS5qDCdTeyTbsT2XUV82N1ISemAoAV64WPa6zoLclA1IhFjr1zh5PX1MUDQSRT/gm2Ft
         iKNPOGIzk7VuZDGQrtpm2nB14w4B1xgMlyqtEW4T01VuG9qXFGu7fecCOX9/zqnAWXqE
         IV0RtAAI+bb6srzIS2CzhvmDVbIEwZuqP4cQULwtA2QxutcDYj2/ODZUDyrVZUichoWa
         hdPQ==
X-Gm-Message-State: AAQBX9dR6igH5piYuXj2lwPpIJ17dzYWP/5j8fGxRvEHY7iaqIiQGwOG
        7xMnqc6tNh1OXRM6Wf9wq1UCA6Jer8A=
X-Google-Smtp-Source: AKy350ZbtZMJWyeJejrw/UExIEGQY0X27Ycx90OTR8jH7w8k9S3xLokbFGp82zp3Je/vIjn3QsIDDQ==
X-Received: by 2002:a05:600c:2305:b0:3f1:728a:1881 with SMTP id 5-20020a05600c230500b003f1728a1881mr5016090wmo.31.1681808602408;
        Tue, 18 Apr 2023 02:03:22 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bcb07000000b003ee70225ed2sm14341109wmj.15.2023.04.18.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:03:22 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v3 6/9] mips: ralink: mt7620: remove clock related code
Date:   Tue, 18 Apr 2023 11:03:09 +0200
Message-Id: <20230418090312.2818879-7-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
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

A proper clock driver for ralink SoCs has been added. Hence there is no
need to have clock related code in 'arch/mips/ralink' folder anymore.
Since this is the last clock related code removal, remove also remaining
prototypes in 'common.h' header file.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |  35 ----
 arch/mips/ralink/common.h                  |   3 -
 arch/mips/ralink/mt7620.c                  | 226 ---------------------
 3 files changed, 264 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 3e37705ea9cf..62f4f072c003 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -20,52 +20,17 @@
 #define SYSC_REG_CHIP_REV		0x0c
 #define SYSC_REG_SYSTEM_CONFIG0		0x10
 #define SYSC_REG_SYSTEM_CONFIG1		0x14
-#define SYSC_REG_CLKCFG0		0x2c
-#define SYSC_REG_CPU_SYS_CLKCFG		0x3c
-#define SYSC_REG_CPLL_CONFIG0		0x54
-#define SYSC_REG_CPLL_CONFIG1		0x58
 
 #define MT7620_CHIP_NAME0		0x3637544d
 #define MT7620_CHIP_NAME1		0x20203032
 #define MT7628_CHIP_NAME1		0x20203832
 
-#define SYSCFG0_XTAL_FREQ_SEL		BIT(6)
-
 #define CHIP_REV_PKG_MASK		0x1
 #define CHIP_REV_PKG_SHIFT		16
 #define CHIP_REV_VER_MASK		0xf
 #define CHIP_REV_VER_SHIFT		8
 #define CHIP_REV_ECO_MASK		0xf
 
-#define CLKCFG0_PERI_CLK_SEL		BIT(4)
-
-#define CPU_SYS_CLKCFG_OCP_RATIO_SHIFT	16
-#define CPU_SYS_CLKCFG_OCP_RATIO_MASK	0xf
-#define CPU_SYS_CLKCFG_OCP_RATIO_1	0	/* 1:1   (Reserved) */
-#define CPU_SYS_CLKCFG_OCP_RATIO_1_5	1	/* 1:1.5 (Reserved) */
-#define CPU_SYS_CLKCFG_OCP_RATIO_2	2	/* 1:2   */
-#define CPU_SYS_CLKCFG_OCP_RATIO_2_5	3       /* 1:2.5 (Reserved) */
-#define CPU_SYS_CLKCFG_OCP_RATIO_3	4	/* 1:3   */
-#define CPU_SYS_CLKCFG_OCP_RATIO_3_5	5	/* 1:3.5 (Reserved) */
-#define CPU_SYS_CLKCFG_OCP_RATIO_4	6	/* 1:4   */
-#define CPU_SYS_CLKCFG_OCP_RATIO_5	7	/* 1:5   */
-#define CPU_SYS_CLKCFG_OCP_RATIO_10	8	/* 1:10  */
-#define CPU_SYS_CLKCFG_CPU_FDIV_SHIFT	8
-#define CPU_SYS_CLKCFG_CPU_FDIV_MASK	0x1f
-#define CPU_SYS_CLKCFG_CPU_FFRAC_SHIFT	0
-#define CPU_SYS_CLKCFG_CPU_FFRAC_MASK	0x1f
-
-#define CPLL_CFG0_SW_CFG		BIT(31)
-#define CPLL_CFG0_PLL_MULT_RATIO_SHIFT	16
-#define CPLL_CFG0_PLL_MULT_RATIO_MASK   0x7
-#define CPLL_CFG0_LC_CURFCK		BIT(15)
-#define CPLL_CFG0_BYPASS_REF_CLK	BIT(14)
-#define CPLL_CFG0_PLL_DIV_RATIO_SHIFT	10
-#define CPLL_CFG0_PLL_DIV_RATIO_MASK	0x3
-
-#define CPLL_CFG1_CPU_AUX1		BIT(25)
-#define CPLL_CFG1_CPU_AUX0		BIT(24)
-
 #define SYSCFG0_DRAM_TYPE_MASK		0x3
 #define SYSCFG0_DRAM_TYPE_SHIFT		4
 #define SYSCFG0_DRAM_TYPE_SDRAM		0
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 87fc16751281..fcdfc9dc6210 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -23,9 +23,6 @@ extern struct ralink_soc_info soc_info;
 
 extern void ralink_of_remap(void);
 
-extern void ralink_clk_init(void);
-extern void ralink_clk_add(const char *dev, unsigned long rate);
-
 extern void ralink_rst_init(void);
 
 extern void __init prom_soc_init(struct ralink_soc_info *soc_info);
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 4435f50b8d24..f44915b0b0c2 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -36,12 +36,6 @@
 #define PMU1_CFG		0x8C
 #define DIG_SW_SEL		BIT(25)
 
-/* clock scaling */
-#define CLKCFG_FDIV_MASK	0x1f00
-#define CLKCFG_FDIV_USB_VAL	0x0300
-#define CLKCFG_FFRAC_MASK	0x001f
-#define CLKCFG_FFRAC_USB_VAL	0x0003
-
 /* EFUSE bits */
 #define EFUSE_MT7688		0x100000
 
@@ -53,226 +47,6 @@ static int dram_type;
 
 static struct ralink_soc_info *soc_info_ptr;
 
-static __init u32
-mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
-{
-	u64 t;
-
-	t = ref_rate;
-	t *= mul;
-	do_div(t, div);
-
-	return t;
-}
-
-#define MHZ(x)		((x) * 1000 * 1000)
-
-static __init unsigned long
-mt7620_get_xtal_rate(void)
-{
-	u32 reg;
-
-	reg = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG0);
-	if (reg & SYSCFG0_XTAL_FREQ_SEL)
-		return MHZ(40);
-
-	return MHZ(20);
-}
-
-static __init unsigned long
-mt7620_get_periph_rate(unsigned long xtal_rate)
-{
-	u32 reg;
-
-	reg = rt_sysc_r32(SYSC_REG_CLKCFG0);
-	if (reg & CLKCFG0_PERI_CLK_SEL)
-		return xtal_rate;
-
-	return MHZ(40);
-}
-
-static const u32 mt7620_clk_divider[] __initconst = { 2, 3, 4, 8 };
-
-static __init unsigned long
-mt7620_get_cpu_pll_rate(unsigned long xtal_rate)
-{
-	u32 reg;
-	u32 mul;
-	u32 div;
-
-	reg = rt_sysc_r32(SYSC_REG_CPLL_CONFIG0);
-	if (reg & CPLL_CFG0_BYPASS_REF_CLK)
-		return xtal_rate;
-
-	if ((reg & CPLL_CFG0_SW_CFG) == 0)
-		return MHZ(600);
-
-	mul = (reg >> CPLL_CFG0_PLL_MULT_RATIO_SHIFT) &
-	      CPLL_CFG0_PLL_MULT_RATIO_MASK;
-	mul += 24;
-	if (reg & CPLL_CFG0_LC_CURFCK)
-		mul *= 2;
-
-	div = (reg >> CPLL_CFG0_PLL_DIV_RATIO_SHIFT) &
-	      CPLL_CFG0_PLL_DIV_RATIO_MASK;
-
-	WARN_ON(div >= ARRAY_SIZE(mt7620_clk_divider));
-
-	return mt7620_calc_rate(xtal_rate, mul, mt7620_clk_divider[div]);
-}
-
-static __init unsigned long
-mt7620_get_pll_rate(unsigned long xtal_rate, unsigned long cpu_pll_rate)
-{
-	u32 reg;
-
-	reg = rt_sysc_r32(SYSC_REG_CPLL_CONFIG1);
-	if (reg & CPLL_CFG1_CPU_AUX1)
-		return xtal_rate;
-
-	if (reg & CPLL_CFG1_CPU_AUX0)
-		return MHZ(480);
-
-	return cpu_pll_rate;
-}
-
-static __init unsigned long
-mt7620_get_cpu_rate(unsigned long pll_rate)
-{
-	u32 reg;
-	u32 mul;
-	u32 div;
-
-	reg = rt_sysc_r32(SYSC_REG_CPU_SYS_CLKCFG);
-
-	mul = reg & CPU_SYS_CLKCFG_CPU_FFRAC_MASK;
-	div = (reg >> CPU_SYS_CLKCFG_CPU_FDIV_SHIFT) &
-	      CPU_SYS_CLKCFG_CPU_FDIV_MASK;
-
-	return mt7620_calc_rate(pll_rate, mul, div);
-}
-
-static const u32 mt7620_ocp_dividers[16] __initconst = {
-	[CPU_SYS_CLKCFG_OCP_RATIO_2] = 2,
-	[CPU_SYS_CLKCFG_OCP_RATIO_3] = 3,
-	[CPU_SYS_CLKCFG_OCP_RATIO_4] = 4,
-	[CPU_SYS_CLKCFG_OCP_RATIO_5] = 5,
-	[CPU_SYS_CLKCFG_OCP_RATIO_10] = 10,
-};
-
-static __init unsigned long
-mt7620_get_dram_rate(unsigned long pll_rate)
-{
-	if (dram_type == SYSCFG0_DRAM_TYPE_SDRAM)
-		return pll_rate / 4;
-
-	return pll_rate / 3;
-}
-
-static __init unsigned long
-mt7620_get_sys_rate(unsigned long cpu_rate)
-{
-	u32 reg;
-	u32 ocp_ratio;
-	u32 div;
-
-	reg = rt_sysc_r32(SYSC_REG_CPU_SYS_CLKCFG);
-
-	ocp_ratio = (reg >> CPU_SYS_CLKCFG_OCP_RATIO_SHIFT) &
-		    CPU_SYS_CLKCFG_OCP_RATIO_MASK;
-
-	if (WARN_ON(ocp_ratio >= ARRAY_SIZE(mt7620_ocp_dividers)))
-		return cpu_rate;
-
-	div = mt7620_ocp_dividers[ocp_ratio];
-	if (WARN(!div, "invalid divider for OCP ratio %u", ocp_ratio))
-		return cpu_rate;
-
-	return cpu_rate / div;
-}
-
-void __init ralink_clk_init(void)
-{
-	unsigned long xtal_rate;
-	unsigned long cpu_pll_rate;
-	unsigned long pll_rate;
-	unsigned long cpu_rate;
-	unsigned long sys_rate;
-	unsigned long dram_rate;
-	unsigned long periph_rate;
-	unsigned long pcmi2s_rate;
-
-	xtal_rate = mt7620_get_xtal_rate();
-
-#define RFMT(label)	label ":%lu.%03luMHz "
-#define RINT(x)		((x) / 1000000)
-#define RFRAC(x)	(((x) / 1000) % 1000)
-
-	if (is_mt76x8()) {
-		if (xtal_rate == MHZ(40))
-			cpu_rate = MHZ(580);
-		else
-			cpu_rate = MHZ(575);
-		dram_rate = sys_rate = cpu_rate / 3;
-		periph_rate = MHZ(40);
-		pcmi2s_rate = MHZ(480);
-
-		ralink_clk_add("10000d00.uartlite", periph_rate);
-		ralink_clk_add("10000e00.uartlite", periph_rate);
-	} else {
-		cpu_pll_rate = mt7620_get_cpu_pll_rate(xtal_rate);
-		pll_rate = mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
-
-		cpu_rate = mt7620_get_cpu_rate(pll_rate);
-		dram_rate = mt7620_get_dram_rate(pll_rate);
-		sys_rate = mt7620_get_sys_rate(cpu_rate);
-		periph_rate = mt7620_get_periph_rate(xtal_rate);
-		pcmi2s_rate = periph_rate;
-
-		pr_debug(RFMT("XTAL") RFMT("CPU_PLL") RFMT("PLL"),
-			 RINT(xtal_rate), RFRAC(xtal_rate),
-			 RINT(cpu_pll_rate), RFRAC(cpu_pll_rate),
-			 RINT(pll_rate), RFRAC(pll_rate));
-
-		ralink_clk_add("10000500.uart", periph_rate);
-	}
-
-	pr_debug(RFMT("CPU") RFMT("DRAM") RFMT("SYS") RFMT("PERIPH"),
-		 RINT(cpu_rate), RFRAC(cpu_rate),
-		 RINT(dram_rate), RFRAC(dram_rate),
-		 RINT(sys_rate), RFRAC(sys_rate),
-		 RINT(periph_rate), RFRAC(periph_rate));
-#undef RFRAC
-#undef RINT
-#undef RFMT
-
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("10000100.timer", periph_rate);
-	ralink_clk_add("10000120.watchdog", periph_rate);
-	ralink_clk_add("10000900.i2c", periph_rate);
-	ralink_clk_add("10000a00.i2s", pcmi2s_rate);
-	ralink_clk_add("10000b00.spi", sys_rate);
-	ralink_clk_add("10000b40.spi", sys_rate);
-	ralink_clk_add("10000c00.uartlite", periph_rate);
-	ralink_clk_add("10000d00.uart1", periph_rate);
-	ralink_clk_add("10000e00.uart2", periph_rate);
-	ralink_clk_add("10180000.wmac", xtal_rate);
-
-	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
-		/*
-		 * When the CPU goes into sleep mode, the BUS clock will be
-		 * too low for USB to function properly. Adjust the busses
-		 * fractional divider to fix this
-		 */
-		u32 val = rt_sysc_r32(SYSC_REG_CPU_SYS_CLKCFG);
-
-		val &= ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
-		val |= CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
-
-		rt_sysc_w32(val, SYSC_REG_CPU_SYS_CLKCFG);
-	}
-}
-
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,mt7620a-sysc");
-- 
2.25.1

