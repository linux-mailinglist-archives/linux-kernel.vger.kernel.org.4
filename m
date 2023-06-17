Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7D733E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjFQFZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjFQFYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F71FD3;
        Fri, 16 Jun 2023 22:24:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3111547c8f9so1213827f8f.1;
        Fri, 16 Jun 2023 22:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979485; x=1689571485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5ABgnLDQ8KTbkSaDaBU5MNns2MpFyYj3L81yoSdygg=;
        b=bOh2XS13WRiw93Cb2CSgzfV6DiTtlyilokylA7UEgr8i8HDPUyBJ3Wq7ch0CETWyqb
         wpZFx6P4gGgX38I8ivVGUy/8pG5pCxUKZzLGe2oBZGnM1SaKQJFf9GWzTKlF4lEuSYg9
         /IAx/bKbkDYzeXXMfp/wI/5Q6Nv7Q1iiABkGk+7mt2QkRFh3Qby26wXernJXhmOxty3h
         lNCiCClCzN+YcffZTS6c7bwKReYBZY69KoFMN7QC7+1OcsmqU8u5QPxzJJ2EVwVuE8Q1
         NFvrkleK9Ek0pUYhzwg56FNxBHwi+R+Qy+CNQDgGXffWn6vlSWqColBs9UZ5FzpJCQdX
         G0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979485; x=1689571485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5ABgnLDQ8KTbkSaDaBU5MNns2MpFyYj3L81yoSdygg=;
        b=hVejmFoUh74/XePL3r5ULr7G8Hv7qkX9mwBgxDSdqAtkuX496ZQuBEbdicG9Ro/5iL
         Q3MBD7NqubDrZB1Jn7ksFuR4ju276M2L0fCxnVNsy2RVp3uX+v4tT108/xxdfUJ/g6tk
         FSJ5n1GAzisHiDYgvG6rBDDqVq7kzf9ZZ3m1wgMEmbl5rUGCZClZH2cidfOAV3LmKFqO
         6O82/aKLBoBv5yL/Fby7wtJ47zqODrHURP8FMjmu4iYWgGXwFqmOxxxekO3+a16Tx0z3
         hcSp9SR+QG9V3D5vL9SasR8+6C1khAR4YcHUmvB975k26qUCztxNkRyNEVhteTzOpi0x
         fzkw==
X-Gm-Message-State: AC+VfDxi8Sin1sjPxOepVLPiwpXIpyhTs+jqBOOXPugwlo3j3t9OzSDC
        Iarr4tX/S+c+Fe41X5CNJxt5eNvInkE=
X-Google-Smtp-Source: ACHHUZ5J3M7cIxENg56SvRSRvnlmS01/BqgaIBAUEOWLk0Pk2M9gYMBH8jf7M/KjnQqfzibZFPpnjQ==
X-Received: by 2002:adf:ecc5:0:b0:309:4368:a8a0 with SMTP id s5-20020adfecc5000000b003094368a8a0mr2712673wro.68.1686979484677;
        Fri, 16 Jun 2023 22:24:44 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:44 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 6/9] mips: ralink: mt7620: remove clock related code
Date:   Sat, 17 Jun 2023 07:24:32 +0200
Message-Id: <20230617052435.359177-7-sergio.paracuellos@gmail.com>
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

