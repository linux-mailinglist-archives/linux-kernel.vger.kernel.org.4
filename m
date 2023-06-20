Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8393F73614D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFTBvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFTBvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:51:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B6010CA;
        Mon, 19 Jun 2023 18:51:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2106099b3a.0;
        Mon, 19 Jun 2023 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687225894; x=1689817894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5prGk6UqZJi1NMGB92IBw/y3Dqc/LcJ2OIWj9PSIAwQ=;
        b=Jq30CfvhkrQK4FN8ovMRC20GfCPPqf3zuzo7MPz+QyruzhF+3x6Nm0BvYmvIWRJoWR
         T/6JwOIMXcd4ZjJ+Y+jQZJqTOksAcewBXSL9j/c4haqJJ/PJ5YyQqlo1MgOHjy4FAccf
         H747Jd3l0FjsmjdhjFJgqnA4PxJLkqVKrdCKFVacqNKv6PSAV01RfsNop7Hq2Za5nP9Z
         CG47Sdf/B/MgMwkC5sm6ZqE1EjMf0gKBvZSvuI1bR4vRvB5cntJ9Bxrujprx7o+JbSB+
         bCCMBuy4G/ZLcGJDEM/ivoFehzPqCHrI/liRzu+iepw80bV5a4Saoqw6+cSX9B831YNi
         CjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687225894; x=1689817894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5prGk6UqZJi1NMGB92IBw/y3Dqc/LcJ2OIWj9PSIAwQ=;
        b=fbzuaa7JU4peun1ZUNss9mYgOl4knjwvnmuexQ+rSgMVO+F6v3P/ZL87L9FngIqsmB
         o6hdTBJf9VWR1NXX21U8dBvvY/60+gzFADKuT9FczvStht1kb7WTWUuj70m1NynmAc9T
         t/YvnSchXEA+Ftb2zbyTjIk7EObXPELh+wApFwwjc9gv4erOQwdRoRY3jUqNsw0ne3ry
         u0TGN3NqJmU6UEMdgT1eFEXXs6il3+InkPv0sL8f0nFOeOLkkyA8Yyel4MTDitavvguP
         0K7zKHyTBW6HWnNXxULBMwAV9qdM3RWHR5I/TpnDZ+r0RaGNvHxABY/R8kQxVtEhRc2Q
         OKeg==
X-Gm-Message-State: AC+VfDzAjXXofKDfQIfmfvaTEBpKZr2u2/50RSQR1BvTL1n2ReXrEMOZ
        1BgVAmoXVAuVBrRJZzZo2HI=
X-Google-Smtp-Source: ACHHUZ524rjoW5IJidRjZ1HAFlJXdZJMf6AlDtHi5uPu5cYwMZImAdXAPyxoiids0hwa/vKdImjbrA==
X-Received: by 2002:a05:6a00:98b:b0:668:7fb2:d991 with SMTP id u11-20020a056a00098b00b006687fb2d991mr5170466pfg.1.1687225893481;
        Mon, 19 Jun 2023 18:51:33 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm240457pfo.167.2023.06.19.18.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 18:51:33 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v16 1/1] clk: nuvoton: Use clk_parent_data instead and add a header file
Date:   Tue, 20 Jun 2023 01:51:20 +0000
Message-Id: <20230620015120.234041-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620015120.234041-1-ychuang570808@gmail.com>
References: <20230620015120.234041-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

1. Update all parent clock string arrays with clk_parent_data structure,
   and replace the usage of clk_hw_register_mux() with
   clk_hw_register_mux_parent_data().
2. Introduce the header file clk-ma35d1.h to include shared external
   functions.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/clk/nuvoton/clk-ma35d1-divider.c |   7 +-
 drivers/clk/nuvoton/clk-ma35d1-pll.c     |   5 +-
 drivers/clk/nuvoton/clk-ma35d1.c         | 737 +++++++++++++----------
 drivers/clk/nuvoton/clk-ma35d1.h         |  18 +
 4 files changed, 447 insertions(+), 320 deletions(-)
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h

diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
index 0c2bed47909a..bb8c23d2b895 100644
--- a/drivers/clk/nuvoton/clk-ma35d1-divider.c
+++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
@@ -9,6 +9,8 @@
 #include <linux/regmap.h>
 #include <linux/spinlock.h>
 
+#include "clk-ma35d1.h"
+
 struct ma35d1_adc_clk_div {
 	struct clk_hw hw;
 	void __iomem *reg;
@@ -20,11 +22,6 @@ struct ma35d1_adc_clk_div {
 	spinlock_t *lock;
 };
 
-struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
-				     struct clk_hw *parent_hw, spinlock_t *lock,
-				     unsigned long flags, void __iomem *reg,
-				     u8 shift, u8 width, u32 mask_bit);
-
 static inline struct ma35d1_adc_clk_div *to_ma35d1_adc_clk_div(struct clk_hw *_hw)
 {
 	return container_of(_hw, struct ma35d1_adc_clk_div, hw);
diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/clk-ma35d1-pll.c
index e4c9f94e6796..ff3fb8b87c24 100644
--- a/drivers/clk/nuvoton/clk-ma35d1-pll.c
+++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
@@ -15,6 +15,8 @@
 #include <linux/units.h>
 #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
 
+#include "clk-ma35d1.h"
+
 /* PLL frequency limits */
 #define PLL_FREF_MAX_FREQ	(200 * HZ_PER_MHZ)
 #define PLL_FREF_MIN_FREQ	(1 * HZ_PER_MHZ)
@@ -71,9 +73,6 @@ struct ma35d1_clk_pll {
 	void __iomem *ctl2_base;
 };
 
-struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode, const char *name,
-				  struct clk_hw *parent_hw, void __iomem *base);
-
 static inline struct ma35d1_clk_pll *to_ma35d1_clk_pll(struct clk_hw *_hw)
 {
 	return container_of(_hw, struct ma35d1_clk_pll, hw);
diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 297b11585f00..e77e06a4a07c 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -12,6 +12,8 @@
 #include <linux/spinlock.h>
 #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
 
+#include "clk-ma35d1.h"
+
 static DEFINE_SPINLOCK(ma35d1_lock);
 
 #define PLL_MAX_NUM		5
@@ -20,19 +22,19 @@ static DEFINE_SPINLOCK(ma35d1_lock);
 #define REG_CLK_PWRCTL		0x00
 #define REG_CLK_SYSCLK0		0x04
 #define REG_CLK_SYSCLK1		0x08
-#define REG_CLK_APBCLK0		0x0C
+#define REG_CLK_APBCLK0		0x0c
 #define REG_CLK_APBCLK1		0x10
 #define REG_CLK_APBCLK2		0x14
 #define REG_CLK_CLKSEL0		0x18
-#define REG_CLK_CLKSEL1		0x1C
+#define REG_CLK_CLKSEL1		0x1c
 #define REG_CLK_CLKSEL2		0x20
 #define REG_CLK_CLKSEL3		0x24
 #define REG_CLK_CLKSEL4		0x28
-#define REG_CLK_CLKDIV0		0x2C
+#define REG_CLK_CLKDIV0		0x2c
 #define REG_CLK_CLKDIV1		0x30
 #define REG_CLK_CLKDIV2		0x34
 #define REG_CLK_CLKDIV3		0x38
-#define REG_CLK_CLKDIV4		0x3C
+#define REG_CLK_CLKDIV4		0x3c
 #define REG_CLK_CLKOCTL		0x40
 #define REG_CLK_STATUS		0x50
 #define REG_CLK_PLL0CTL0	0x60
@@ -42,194 +44,307 @@ static DEFINE_SPINLOCK(ma35d1_lock);
 #define REG_CLK_PLL3CTL0	0x90
 #define REG_CLK_PLL3CTL1	0x94
 #define REG_CLK_PLL3CTL2	0x98
-#define REG_CLK_PLL4CTL0	0xA0
-#define REG_CLK_PLL4CTL1	0xA4
-#define REG_CLK_PLL4CTL2	0xA8
-#define REG_CLK_PLL5CTL0	0xB0
-#define REG_CLK_PLL5CTL1	0xB4
-#define REG_CLK_PLL5CTL2	0xB8
-#define REG_CLK_CLKDCTL		0xC0
-#define REG_CLK_CLKDSTS		0xC4
-#define REG_CLK_CDUPB		0xC8
-#define REG_CLK_CDLOWB		0xCC
-#define REG_CLK_CKFLTRCTL	0xD0
-#define REG_CLK_TESTCLK		0xF0
+#define REG_CLK_PLL4CTL0	0xa0
+#define REG_CLK_PLL4CTL1	0xa4
+#define REG_CLK_PLL4CTL2	0xa8
+#define REG_CLK_PLL5CTL0	0xb0
+#define REG_CLK_PLL5CTL1	0xb4
+#define REG_CLK_PLL5CTL2	0xb8
+#define REG_CLK_CLKDCTL		0xc0
+#define REG_CLK_CLKDSTS		0xc4
+#define REG_CLK_CDUPB		0xc8
+#define REG_CLK_CDLOWB		0xcc
+#define REG_CLK_CKFLTRCTL	0xd0
+#define REG_CLK_TESTCLK		0xf0
 #define REG_CLK_PLLCTL		0x40
 
 #define PLL_MODE_INT            0
 #define PLL_MODE_FRAC           1
 #define PLL_MODE_SS             2
 
-struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode,
-				  const char *name, struct clk_hw *parent_hw,
-				  void __iomem *base);
-struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
-				     struct clk_hw *hw, spinlock_t *lock,
-				     unsigned long flags, void __iomem *reg,
-				     u8 shift, u8 width, u32 mask_bit);
-
 static const struct clk_parent_data ca35clk_sel_clks[] = {
-	{ .index = 0 },  /* HXT */
-	{ .index = 1 },  /* CAPLL */
-	{ .index = 2 }   /* DDRPLL */
+	{ .fw_name = "hxt", },
+	{ .fw_name = "capll", },
+	{ .fw_name = "ddrpll", },
 };
 
-static const char *const sysclk0_sel_clks[] = {
-	"epll_div2", "syspll"
+static const struct clk_parent_data sysclk0_sel_clks[] = {
+	{ .fw_name = "epll_div2", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const sysclk1_sel_clks[] = {
-	"hxt", "syspll"
+static const struct clk_parent_data sysclk1_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const axiclk_sel_clks[] = {
-	"capll_div2", "capll_div4"
+static const struct clk_parent_data axiclk_sel_clks[] = {
+	{ .fw_name = "capll_div2", },
+	{ .fw_name = "capll_div4", },
 };
 
-static const char *const ccap_sel_clks[] = {
-	"hxt", "vpll", "apll", "syspll"
+static const struct clk_parent_data ccap_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "vpll", },
+	{ .fw_name = "apll", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const sdh_sel_clks[] = {
-	"syspll", "apll", "dummy", "dummy"
+static const struct clk_parent_data sdh_sel_clks[] = {
+	{ .fw_name = "syspll", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const dcu_sel_clks[] = {
-	"epll_div2", "syspll"
+static const struct clk_parent_data dcu_sel_clks[] = {
+	{ .fw_name = "epll_div2", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const gfx_sel_clks[] = {
-	"epll", "syspll"
+static const struct clk_parent_data gfx_sel_clks[] = {
+	{ .fw_name = "epll", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const dbg_sel_clks[] = {
-	"hirc", "syspll"
+static const struct clk_parent_data dbg_sel_clks[] = {
+	{ .fw_name = "hirc", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const timer0_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer0_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer1_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer1_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer2_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer2_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer3_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer3_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer4_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer4_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer5_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer5_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer6_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer6_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer7_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer7_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer8_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer8_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer9_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer9_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer10_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer10_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer11_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer11_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const uart_sel_clks[] = {
-	"hxt", "sysclk1_div2", "dummy", "dummy"
+static const struct clk_parent_data uart_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "sysclk1_div2", },
 };
 
-static const char *const wdt0_sel_clks[] = {
-	"dummy", "lxt", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wdt0_sel_clks[] = {
+	{ .index = -1, },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wdt1_sel_clks[] = {
-	"dummy", "lxt", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wdt1_sel_clks[] = {
+	{ .index = -1, },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wdt2_sel_clks[] = {
-	"dummy", "lxt", "pclk4_div4096", "lirc"
+static const struct clk_parent_data wdt2_sel_clks[] = {
+	{ .index = -1, },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk4_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wwdt0_sel_clks[] = {
-	"dummy", "dummy", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wwdt0_sel_clks[] = {
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wwdt1_sel_clks[] = {
-	"dummy", "dummy", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wwdt1_sel_clks[] = {
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wwdt2_sel_clks[] = {
-	"dummy", "dummy", "pclk4_div4096", "lirc"
+static const struct clk_parent_data wwdt2_sel_clks[] = {
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "pclk4_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const spi0_sel_clks[] = {
-	"pclk1", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi0_sel_clks[] = {
+	{ .fw_name = "pclk1", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const spi1_sel_clks[] = {
-	"pclk2", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi1_sel_clks[] = {
+	{ .fw_name = "pclk2", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const spi2_sel_clks[] = {
-	"pclk1", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi2_sel_clks[] = {
+	{ .fw_name = "pclk1", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const spi3_sel_clks[] = {
-	"pclk2", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi3_sel_clks[] = {
+	{ .fw_name = "pclk2", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const qspi0_sel_clks[] = {
-	"pclk0", "apll", "dummy", "dummy"
+static const struct clk_parent_data qspi_sel_clks[] = {
+	{ .fw_name = "pclk0", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const qspi1_sel_clks[] = {
-	"pclk0", "apll", "dummy", "dummy"
+static const struct clk_parent_data i2s_sel_clks[] = {
+	{ .fw_name = "apll", },
+	{ .fw_name = "sysclk1_div2", },
 };
 
-static const char *const i2s0_sel_clks[] = {
-	"apll", "sysclk1_div2", "dummy", "dummy"
+static const struct clk_parent_data can_sel_clks[] = {
+	{ .fw_name = "apll", },
+	{ .fw_name = "vpll", },
 };
 
-static const char *const i2s1_sel_clks[] = {
-	"apll", "sysclk1_div2", "dummy", "dummy"
+static const struct clk_parent_data cko_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "hirc", },
+	{ .fw_name = "lirc", },
+	{ .fw_name = "capll_div4", },
+	{ .fw_name = "syspll", },
+	{ .fw_name = "ddrpll", },
+	{ .fw_name = "epll_div2", },
+	{ .fw_name = "apll", },
+	{ .fw_name = "vpll", },
 };
 
-static const char *const can_sel_clks[] = {
-	"apll", "vpll"
+static const struct clk_parent_data smc_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "pclk4", },
 };
 
-static const char *const cko_sel_clks[] = {
-	"hxt", "lxt", "hirc", "lirc", "capll_div4", "syspll",
-	"ddrpll", "epll_div2", "apll", "vpll", "dummy", "dummy",
-	"dummy", "dummy", "dummy", "dummy"
-};
-
-static const char *const smc_sel_clks[] = {
-	"hxt", "pclk4"
-};
-
-static const char *const kpi_sel_clks[] = {
-	"hxt", "lxt"
+static const struct clk_parent_data kpi_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
 };
 
 static const struct clk_div_table ip_div_table[] = {
@@ -249,25 +364,16 @@ static struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
-static struct clk_hw *ma35d1_clk_mux_parent(struct device *dev, const char *name,
-					    void __iomem *reg, u8 shift, u8 width,
-					    const struct clk_parent_data *pdata,
-					    int num_pdata)
+static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
+				     void __iomem *reg, u8 shift, u8 width,
+				     const struct clk_parent_data *pdata,
+				     int num_pdata)
 {
 	return clk_hw_register_mux_parent_data(dev, name, pdata, num_pdata,
 					       CLK_SET_RATE_NO_REPARENT, reg, shift,
 					       width, 0, &ma35d1_lock);
 }
 
-static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
-				     void __iomem *reg, u8 shift, u8 width,
-				     const char *const *parents, int num_parents)
-{
-	return devm_clk_hw_register_mux(dev, name, parents, num_parents,
-					CLK_SET_RATE_NO_REPARENT, reg, shift,
-					width, 0, &ma35d1_lock);
-}
-
 static struct clk_hw *ma35d1_clk_divider(struct device *dev, const char *name,
 					 const char *parent, void __iomem *reg,
 					 u8 shift, u8 width)
@@ -389,22 +495,22 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EPLL_DIV4] = ma35d1_clk_fixed_factor(dev, "epll_div4", "epll", 1, 4);
 	hws[EPLL_DIV8] = ma35d1_clk_fixed_factor(dev, "epll_div8", "epll", 1, 8);
 
-	hws[CA35CLK_MUX] = ma35d1_clk_mux_parent(dev, "ca35clk_mux",
-						 clk_base + REG_CLK_CLKSEL0, 0, 2,
-						 ca35clk_sel_clks,
-						 ARRAY_SIZE(ca35clk_sel_clks));
+	hws[CA35CLK_MUX] = ma35d1_clk_mux(dev, "ca35clk_mux", clk_base + REG_CLK_CLKSEL0, 0, 2,
+					  ca35clk_sel_clks, ARRAY_SIZE(ca35clk_sel_clks));
+
 	hws[AXICLK_DIV2] = ma35d1_clk_fixed_factor(dev, "capll_div2", "ca35clk_mux", 1, 2);
 	hws[AXICLK_DIV4] = ma35d1_clk_fixed_factor(dev, "capll_div4", "ca35clk_mux", 1, 4);
 
-	hws[AXICLK_MUX] = ma35d1_clk_mux(dev, "axiclk_mux", clk_base + REG_CLK_CLKDIV0,
-					 26, 1, axiclk_sel_clks,
-					 ARRAY_SIZE(axiclk_sel_clks));
-	hws[SYSCLK0_MUX] = ma35d1_clk_mux(dev, "sysclk0_mux", clk_base + REG_CLK_CLKSEL0,
-					  2, 1, sysclk0_sel_clks,
-					  ARRAY_SIZE(sysclk0_sel_clks));
-	hws[SYSCLK1_MUX] = ma35d1_clk_mux(dev, "sysclk1_mux", clk_base + REG_CLK_CLKSEL0,
-					  4, 1, sysclk1_sel_clks,
-					  ARRAY_SIZE(sysclk1_sel_clks));
+	hws[AXICLK_MUX] = ma35d1_clk_mux(dev, "axiclk_mux", clk_base + REG_CLK_CLKDIV0, 26, 1,
+					 axiclk_sel_clks, ARRAY_SIZE(axiclk_sel_clks));
+
+	hws[SYSCLK0_MUX] = ma35d1_clk_mux(dev, "sysclk0_mux",
+					  clk_base + REG_CLK_CLKSEL0, 2, 1,
+					  sysclk0_sel_clks, ARRAY_SIZE(sysclk0_sel_clks));
+
+	hws[SYSCLK1_MUX] = ma35d1_clk_mux(dev, "sysclk1_mux", clk_base + REG_CLK_CLKSEL0, 4, 1,
+					  sysclk1_sel_clks, ARRAY_SIZE(sysclk1_sel_clks));
+
 	hws[SYSCLK1_DIV2] = ma35d1_clk_fixed_factor(dev, "sysclk1_div2", "sysclk1_mux", 1, 2);
 
 	/* HCLK0~3 & PCLK0~4 */
@@ -428,41 +534,45 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[DDR6_GATE] = ma35d1_clk_gate(dev, "ddr6_gate", "ddrpll",
 					 clk_base + REG_CLK_SYSCLK0, 5);
 
-	hws[CAN0_MUX] = ma35d1_clk_mux(dev, "can0_mux", clk_base + REG_CLK_CLKSEL4,
-				       16, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+	hws[CAN0_MUX] = ma35d1_clk_mux(dev, "can0_mux", clk_base + REG_CLK_CLKSEL4, 16, 1,
+				       can_sel_clks, ARRAY_SIZE(can_sel_clks));
 	hws[CAN0_DIV] = ma35d1_clk_divider_table(dev, "can0_div", "can0_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 0, 3, ip_div_table);
 	hws[CAN0_GATE] = ma35d1_clk_gate(dev, "can0_gate", "can0_div",
 					 clk_base + REG_CLK_SYSCLK0, 8);
-	hws[CAN1_MUX] = ma35d1_clk_mux(dev, "can1_mux", clk_base + REG_CLK_CLKSEL4,
-				       17, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+
+	hws[CAN1_MUX] = ma35d1_clk_mux(dev, "can1_mux", clk_base + REG_CLK_CLKSEL4, 17, 1,
+				       can_sel_clks, ARRAY_SIZE(can_sel_clks));
 	hws[CAN1_DIV] = ma35d1_clk_divider_table(dev, "can1_div", "can1_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 4, 3, ip_div_table);
 	hws[CAN1_GATE] = ma35d1_clk_gate(dev, "can1_gate", "can1_div",
 					 clk_base + REG_CLK_SYSCLK0, 9);
-	hws[CAN2_MUX] = ma35d1_clk_mux(dev, "can2_mux", clk_base + REG_CLK_CLKSEL4,
-				       18, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+
+	hws[CAN2_MUX] = ma35d1_clk_mux(dev, "can2_mux", clk_base + REG_CLK_CLKSEL4, 18, 1,
+				       can_sel_clks, ARRAY_SIZE(can_sel_clks));
 	hws[CAN2_DIV] = ma35d1_clk_divider_table(dev, "can2_div", "can2_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 8, 3, ip_div_table);
 	hws[CAN2_GATE] = ma35d1_clk_gate(dev, "can2_gate", "can2_div",
 					 clk_base + REG_CLK_SYSCLK0, 10);
-	hws[CAN3_MUX] = ma35d1_clk_mux(dev, "can3_mux", clk_base + REG_CLK_CLKSEL4,
-				       19, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+
+	hws[CAN3_MUX] = ma35d1_clk_mux(dev, "can3_mux", clk_base + REG_CLK_CLKSEL4, 19, 1,
+				       can_sel_clks, ARRAY_SIZE(can_sel_clks));
 	hws[CAN3_DIV] = ma35d1_clk_divider_table(dev, "can3_div", "can3_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 12, 3, ip_div_table);
 	hws[CAN3_GATE] = ma35d1_clk_gate(dev, "can3_gate", "can3_div",
 					 clk_base + REG_CLK_SYSCLK0, 11);
 
-	hws[SDH0_MUX] = ma35d1_clk_mux(dev, "sdh0_mux", clk_base + REG_CLK_CLKSEL0,
-				       16, 2, sdh_sel_clks, ARRAY_SIZE(sdh_sel_clks));
+	hws[SDH0_MUX] = ma35d1_clk_mux(dev, "sdh0_mux", clk_base + REG_CLK_CLKSEL0, 16, 2,
+				       sdh_sel_clks, ARRAY_SIZE(sdh_sel_clks));
 	hws[SDH0_GATE] = ma35d1_clk_gate(dev, "sdh0_gate", "sdh0_mux",
 					 clk_base + REG_CLK_SYSCLK0, 16);
-	hws[SDH1_MUX] = ma35d1_clk_mux(dev, "sdh1_mux", clk_base + REG_CLK_CLKSEL0,
-				       18, 2, sdh_sel_clks, ARRAY_SIZE(sdh_sel_clks));
+
+	hws[SDH1_MUX] = ma35d1_clk_mux(dev, "sdh1_mux", clk_base + REG_CLK_CLKSEL0, 18, 2,
+				       sdh_sel_clks, ARRAY_SIZE(sdh_sel_clks));
 	hws[SDH1_GATE] = ma35d1_clk_gate(dev, "sdh1_gate", "sdh1_mux",
 					 clk_base + REG_CLK_SYSCLK0, 17);
 
@@ -478,14 +588,15 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[HUSBH1_GATE] = ma35d1_clk_gate(dev, "husbh1_gate", "usbphy0",
 					   clk_base + REG_CLK_SYSCLK0, 22);
 
-	hws[GFX_MUX] = ma35d1_clk_mux(dev, "gfx_mux", clk_base + REG_CLK_CLKSEL0,
-				      26, 1, gfx_sel_clks, ARRAY_SIZE(gfx_sel_clks));
+	hws[GFX_MUX] = ma35d1_clk_mux(dev, "gfx_mux", clk_base + REG_CLK_CLKSEL0, 26, 1,
+				      gfx_sel_clks, ARRAY_SIZE(gfx_sel_clks));
 	hws[GFX_GATE] = ma35d1_clk_gate(dev, "gfx_gate", "gfx_mux",
 					clk_base + REG_CLK_SYSCLK0, 24);
 	hws[VC8K_GATE] = ma35d1_clk_gate(dev, "vc8k_gate", "sysclk0_mux",
 					 clk_base + REG_CLK_SYSCLK0, 25);
-	hws[DCU_MUX] = ma35d1_clk_mux(dev, "dcu_mux", clk_base + REG_CLK_CLKSEL0,
-				      24, 1, dcu_sel_clks, ARRAY_SIZE(dcu_sel_clks));
+
+	hws[DCU_MUX] = ma35d1_clk_mux(dev, "dcu_mux", clk_base + REG_CLK_CLKSEL0, 24, 1,
+				      dcu_sel_clks, ARRAY_SIZE(dcu_sel_clks));
 	hws[DCU_GATE] = ma35d1_clk_gate(dev, "dcu_gate", "dcu_mux",
 					clk_base + REG_CLK_SYSCLK0, 26);
 	hws[DCUP_DIV] = ma35d1_clk_divider_table(dev, "dcup_div", "vpll",
@@ -497,14 +608,15 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EMAC1_GATE] = ma35d1_clk_gate(dev, "emac1_gate", "epll_div2",
 					  clk_base + REG_CLK_SYSCLK0, 28);
 
-	hws[CCAP0_MUX] = ma35d1_clk_mux(dev, "ccap0_mux", clk_base + REG_CLK_CLKSEL0,
-					12, 1, ccap_sel_clks, ARRAY_SIZE(ccap_sel_clks));
+	hws[CCAP0_MUX] = ma35d1_clk_mux(dev, "ccap0_mux", clk_base + REG_CLK_CLKSEL0, 12, 1,
+					ccap_sel_clks, ARRAY_SIZE(ccap_sel_clks));
 	hws[CCAP0_DIV] = ma35d1_clk_divider(dev, "ccap0_div", "ccap0_mux",
 					    clk_base + REG_CLK_CLKDIV1, 8, 4);
 	hws[CCAP0_GATE] = ma35d1_clk_gate(dev, "ccap0_gate", "ccap0_div",
 					  clk_base + REG_CLK_SYSCLK0, 29);
-	hws[CCAP1_MUX] = ma35d1_clk_mux(dev, "ccap1_mux", clk_base + REG_CLK_CLKSEL0,
-					14, 1, ccap_sel_clks, ARRAY_SIZE(ccap_sel_clks));
+
+	hws[CCAP1_MUX] = ma35d1_clk_mux(dev, "ccap1_mux", clk_base + REG_CLK_CLKSEL0, 14, 1,
+					ccap_sel_clks, ARRAY_SIZE(ccap_sel_clks));
 	hws[CCAP1_DIV] = ma35d1_clk_divider(dev, "ccap1_div", "ccap1_mux",
 					    clk_base + REG_CLK_CLKDIV1,
 					    12, 4);
@@ -542,13 +654,13 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[TRA_GATE] = ma35d1_clk_gate(dev, "tra_gate", "hclk0",
 					clk_base + REG_CLK_SYSCLK1, 11);
 
-	hws[DBG_MUX] = ma35d1_clk_mux(dev, "dbg_mux", clk_base + REG_CLK_CLKSEL0,
-				      27, 1, dbg_sel_clks, ARRAY_SIZE(dbg_sel_clks));
+	hws[DBG_MUX] = ma35d1_clk_mux(dev, "dbg_mux", clk_base + REG_CLK_CLKSEL0, 27, 1,
+				      dbg_sel_clks, ARRAY_SIZE(dbg_sel_clks));
 	hws[DBG_GATE] = ma35d1_clk_gate(dev, "dbg_gate", "hclk0",
 					clk_base + REG_CLK_SYSCLK1, 12);
 
-	hws[CKO_MUX] = ma35d1_clk_mux(dev, "cko_mux", clk_base + REG_CLK_CLKSEL4,
-				      24, 4, cko_sel_clks, ARRAY_SIZE(cko_sel_clks));
+	hws[CKO_MUX] = ma35d1_clk_mux(dev, "cko_mux", clk_base + REG_CLK_CLKSEL4, 24, 4,
+				      cko_sel_clks, ARRAY_SIZE(cko_sel_clks));
 	hws[CKO_DIV] = ma35d1_clk_divider_pow2(dev, "cko_div", "cko_mux",
 					       clk_base + REG_CLK_CLKOCTL, 0, 4);
 	hws[CKO_GATE] = ma35d1_clk_gate(dev, "cko_gate", "cko_div",
@@ -586,184 +698,182 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[GPN_GATE] = ma35d1_clk_gate(dev, "gpn_gate", "hclk0",
 					clk_base + REG_CLK_SYSCLK1, 29);
 
-	hws[TMR0_MUX] = ma35d1_clk_mux(dev, "tmr0_mux", clk_base + REG_CLK_CLKSEL1,
-				       0, 3, timer0_sel_clks,
-				       ARRAY_SIZE(timer0_sel_clks));
+	hws[TMR0_MUX] = ma35d1_clk_mux(dev, "tmr0_mux", clk_base + REG_CLK_CLKSEL1, 0, 3,
+				       timer0_sel_clks, ARRAY_SIZE(timer0_sel_clks));
 	hws[TMR0_GATE] = ma35d1_clk_gate(dev, "tmr0_gate", "tmr0_mux",
 					 clk_base + REG_CLK_APBCLK0, 0);
-	hws[TMR1_MUX] = ma35d1_clk_mux(dev, "tmr1_mux", clk_base + REG_CLK_CLKSEL1,
-				       4, 3, timer1_sel_clks,
-				       ARRAY_SIZE(timer1_sel_clks));
+
+	hws[TMR1_MUX] = ma35d1_clk_mux(dev, "tmr1_mux", clk_base + REG_CLK_CLKSEL1, 4, 3,
+				       timer1_sel_clks, ARRAY_SIZE(timer1_sel_clks));
 	hws[TMR1_GATE] = ma35d1_clk_gate(dev, "tmr1_gate", "tmr1_mux",
 					 clk_base + REG_CLK_APBCLK0, 1);
-	hws[TMR2_MUX] = ma35d1_clk_mux(dev, "tmr2_mux", clk_base + REG_CLK_CLKSEL1,
-				       8, 3, timer2_sel_clks,
-				       ARRAY_SIZE(timer2_sel_clks));
+
+	hws[TMR2_MUX] = ma35d1_clk_mux(dev, "tmr2_mux", clk_base + REG_CLK_CLKSEL1, 8, 3,
+				       timer2_sel_clks, ARRAY_SIZE(timer2_sel_clks));
 	hws[TMR2_GATE] = ma35d1_clk_gate(dev, "tmr2_gate", "tmr2_mux",
 					 clk_base + REG_CLK_APBCLK0, 2);
-	hws[TMR3_MUX] = ma35d1_clk_mux(dev, "tmr3_mux", clk_base + REG_CLK_CLKSEL1,
-				       12, 3, timer3_sel_clks,
-				       ARRAY_SIZE(timer3_sel_clks));
+
+	hws[TMR3_MUX] = ma35d1_clk_mux(dev, "tmr3_mux", clk_base + REG_CLK_CLKSEL1, 12, 3,
+				       timer3_sel_clks, ARRAY_SIZE(timer3_sel_clks));
 	hws[TMR3_GATE] = ma35d1_clk_gate(dev, "tmr3_gate", "tmr3_mux",
 					 clk_base + REG_CLK_APBCLK0, 3);
-	hws[TMR4_MUX] = ma35d1_clk_mux(dev, "tmr4_mux", clk_base + REG_CLK_CLKSEL1,
-				       16, 3, timer4_sel_clks,
-				       ARRAY_SIZE(timer4_sel_clks));
+
+	hws[TMR4_MUX] = ma35d1_clk_mux(dev, "tmr4_mux", clk_base + REG_CLK_CLKSEL1, 16, 3,
+				       timer4_sel_clks, ARRAY_SIZE(timer4_sel_clks));
 	hws[TMR4_GATE] = ma35d1_clk_gate(dev, "tmr4_gate", "tmr4_mux",
 					 clk_base + REG_CLK_APBCLK0, 4);
-	hws[TMR5_MUX] = ma35d1_clk_mux(dev, "tmr5_mux", clk_base + REG_CLK_CLKSEL1,
-				       20, 3, timer5_sel_clks,
-				       ARRAY_SIZE(timer5_sel_clks));
+
+	hws[TMR5_MUX] = ma35d1_clk_mux(dev, "tmr5_mux", clk_base + REG_CLK_CLKSEL1, 20, 3,
+				       timer5_sel_clks, ARRAY_SIZE(timer5_sel_clks));
 	hws[TMR5_GATE] = ma35d1_clk_gate(dev, "tmr5_gate", "tmr5_mux",
 					 clk_base + REG_CLK_APBCLK0, 5);
-	hws[TMR6_MUX] = ma35d1_clk_mux(dev, "tmr6_mux", clk_base + REG_CLK_CLKSEL1,
-				       24, 3, timer6_sel_clks,
-				       ARRAY_SIZE(timer6_sel_clks));
+
+	hws[TMR6_MUX] = ma35d1_clk_mux(dev, "tmr6_mux", clk_base + REG_CLK_CLKSEL1, 24, 3,
+				       timer6_sel_clks, ARRAY_SIZE(timer6_sel_clks));
 	hws[TMR6_GATE] = ma35d1_clk_gate(dev, "tmr6_gate", "tmr6_mux",
 					 clk_base + REG_CLK_APBCLK0, 6);
-	hws[TMR7_MUX] = ma35d1_clk_mux(dev, "tmr7_mux", clk_base + REG_CLK_CLKSEL1,
-				       28, 3, timer7_sel_clks,
-				       ARRAY_SIZE(timer7_sel_clks));
+
+	hws[TMR7_MUX] = ma35d1_clk_mux(dev, "tmr7_mux", clk_base + REG_CLK_CLKSEL1, 28, 3,
+				       timer7_sel_clks, ARRAY_SIZE(timer7_sel_clks));
 	hws[TMR7_GATE] = ma35d1_clk_gate(dev, "tmr7_gate", "tmr7_mux",
 					 clk_base + REG_CLK_APBCLK0, 7);
-	hws[TMR8_MUX] = ma35d1_clk_mux(dev, "tmr8_mux", clk_base + REG_CLK_CLKSEL2,
-				       0, 3, timer8_sel_clks,
-				       ARRAY_SIZE(timer8_sel_clks));
+
+	hws[TMR8_MUX] = ma35d1_clk_mux(dev, "tmr8_mux", clk_base + REG_CLK_CLKSEL2, 0, 3,
+				       timer8_sel_clks, ARRAY_SIZE(timer8_sel_clks));
 	hws[TMR8_GATE] = ma35d1_clk_gate(dev, "tmr8_gate", "tmr8_mux",
 					 clk_base + REG_CLK_APBCLK0, 8);
-	hws[TMR9_MUX] = ma35d1_clk_mux(dev, "tmr9_mux", clk_base + REG_CLK_CLKSEL2,
-				       4, 3, timer9_sel_clks,
-				       ARRAY_SIZE(timer9_sel_clks));
+
+	hws[TMR9_MUX] = ma35d1_clk_mux(dev, "tmr9_mux", clk_base + REG_CLK_CLKSEL2, 4, 3,
+				       timer9_sel_clks, ARRAY_SIZE(timer9_sel_clks));
 	hws[TMR9_GATE] = ma35d1_clk_gate(dev, "tmr9_gate", "tmr9_mux",
 					 clk_base + REG_CLK_APBCLK0, 9);
-	hws[TMR10_MUX] = ma35d1_clk_mux(dev, "tmr10_mux", clk_base + REG_CLK_CLKSEL2,
-					8, 3, timer10_sel_clks,
-					ARRAY_SIZE(timer10_sel_clks));
+
+	hws[TMR10_MUX] = ma35d1_clk_mux(dev, "tmr10_mux", clk_base + REG_CLK_CLKSEL2, 8, 3,
+					timer10_sel_clks, ARRAY_SIZE(timer10_sel_clks));
 	hws[TMR10_GATE] = ma35d1_clk_gate(dev, "tmr10_gate", "tmr10_mux",
 					  clk_base + REG_CLK_APBCLK0, 10);
-	hws[TMR11_MUX] = ma35d1_clk_mux(dev, "tmr11_mux", clk_base + REG_CLK_CLKSEL2,
-					12, 3, timer11_sel_clks,
-					ARRAY_SIZE(timer11_sel_clks));
+
+	hws[TMR11_MUX] = ma35d1_clk_mux(dev, "tmr11_mux", clk_base + REG_CLK_CLKSEL2, 12, 3,
+					timer11_sel_clks, ARRAY_SIZE(timer11_sel_clks));
 	hws[TMR11_GATE] = ma35d1_clk_gate(dev, "tmr11_gate", "tmr11_mux",
 					  clk_base + REG_CLK_APBCLK0, 11);
 
-	hws[UART0_MUX] = ma35d1_clk_mux(dev, "uart0_mux", clk_base + REG_CLK_CLKSEL2,
-					16, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART0_MUX] = ma35d1_clk_mux(dev, "uart0_mux", clk_base + REG_CLK_CLKSEL2, 16, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART0_DIV] = ma35d1_clk_divider(dev, "uart0_div", "uart0_mux",
-					    clk_base + REG_CLK_CLKDIV1,
-					    16, 4);
+					    clk_base + REG_CLK_CLKDIV1, 16, 4);
 	hws[UART0_GATE] = ma35d1_clk_gate(dev, "uart0_gate", "uart0_div",
 					  clk_base + REG_CLK_APBCLK0, 12);
-	hws[UART1_MUX] = ma35d1_clk_mux(dev, "uart1_mux", clk_base + REG_CLK_CLKSEL2,
-					18, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART1_MUX] = ma35d1_clk_mux(dev, "uart1_mux", clk_base + REG_CLK_CLKSEL2, 18, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART1_DIV] = ma35d1_clk_divider(dev, "uart1_div", "uart1_mux",
-					    clk_base + REG_CLK_CLKDIV1,
-					    20, 4);
+					    clk_base + REG_CLK_CLKDIV1, 20, 4);
 	hws[UART1_GATE] = ma35d1_clk_gate(dev, "uart1_gate", "uart1_div",
 					  clk_base + REG_CLK_APBCLK0, 13);
-	hws[UART2_MUX] = ma35d1_clk_mux(dev, "uart2_mux", clk_base + REG_CLK_CLKSEL2,
-					20, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART2_MUX] = ma35d1_clk_mux(dev, "uart2_mux", clk_base + REG_CLK_CLKSEL2, 20, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART2_DIV] = ma35d1_clk_divider(dev, "uart2_div", "uart2_mux",
-					    clk_base + REG_CLK_CLKDIV1,
-					    24, 4);
+					    clk_base + REG_CLK_CLKDIV1, 24, 4);
 	hws[UART2_GATE] = ma35d1_clk_gate(dev, "uart2_gate", "uart2_div",
 					  clk_base + REG_CLK_APBCLK0, 14);
-	hws[UART3_MUX] = ma35d1_clk_mux(dev, "uart3_mux", clk_base + REG_CLK_CLKSEL2,
-					22, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART3_MUX] = ma35d1_clk_mux(dev, "uart3_mux", clk_base + REG_CLK_CLKSEL2, 22, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART3_DIV] = ma35d1_clk_divider(dev, "uart3_div", "uart3_mux",
-					    clk_base + REG_CLK_CLKDIV1,
-					    28, 4);
+					    clk_base + REG_CLK_CLKDIV1, 28, 4);
 	hws[UART3_GATE] = ma35d1_clk_gate(dev, "uart3_gate", "uart3_div",
 					  clk_base + REG_CLK_APBCLK0, 15);
-	hws[UART4_MUX] = ma35d1_clk_mux(dev, "uart4_mux", clk_base + REG_CLK_CLKSEL2,
-					24, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART4_MUX] = ma35d1_clk_mux(dev, "uart4_mux", clk_base + REG_CLK_CLKSEL2, 24, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART4_DIV] = ma35d1_clk_divider(dev, "uart4_div", "uart4_mux",
-					    clk_base + REG_CLK_CLKDIV2,
-					    0, 4);
+					    clk_base + REG_CLK_CLKDIV2, 0, 4);
 	hws[UART4_GATE] = ma35d1_clk_gate(dev, "uart4_gate", "uart4_div",
 					  clk_base + REG_CLK_APBCLK0, 16);
-	hws[UART5_MUX] = ma35d1_clk_mux(dev, "uart5_mux", clk_base + REG_CLK_CLKSEL2,
-					26, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART5_MUX] = ma35d1_clk_mux(dev, "uart5_mux", clk_base + REG_CLK_CLKSEL2, 26, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART5_DIV] = ma35d1_clk_divider(dev, "uart5_div", "uart5_mux",
-					    clk_base + REG_CLK_CLKDIV2,
-					    4, 4);
+					    clk_base + REG_CLK_CLKDIV2, 4, 4);
 	hws[UART5_GATE] = ma35d1_clk_gate(dev, "uart5_gate", "uart5_div",
 					  clk_base + REG_CLK_APBCLK0, 17);
-	hws[UART6_MUX] = ma35d1_clk_mux(dev, "uart6_mux", clk_base + REG_CLK_CLKSEL2,
-					28, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART6_MUX] = ma35d1_clk_mux(dev, "uart6_mux", clk_base + REG_CLK_CLKSEL2, 28, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART6_DIV] = ma35d1_clk_divider(dev, "uart6_div", "uart6_mux",
-					    clk_base + REG_CLK_CLKDIV2,
-					    8, 4);
+					    clk_base + REG_CLK_CLKDIV2, 8, 4);
 	hws[UART6_GATE] = ma35d1_clk_gate(dev, "uart6_gate", "uart6_div",
 					  clk_base + REG_CLK_APBCLK0, 18);
-	hws[UART7_MUX] = ma35d1_clk_mux(dev, "uart7_mux", clk_base + REG_CLK_CLKSEL2,
-					30, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART7_MUX] = ma35d1_clk_mux(dev, "uart7_mux", clk_base + REG_CLK_CLKSEL2, 30, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART7_DIV] = ma35d1_clk_divider(dev, "uart7_div", "uart7_mux",
-					    clk_base + REG_CLK_CLKDIV2,
-					    12, 4);
+					    clk_base + REG_CLK_CLKDIV2, 12, 4);
 	hws[UART7_GATE] = ma35d1_clk_gate(dev, "uart7_gate", "uart7_div",
 					  clk_base + REG_CLK_APBCLK0, 19);
-	hws[UART8_MUX] = ma35d1_clk_mux(dev, "uart8_mux", clk_base + REG_CLK_CLKSEL3,
-					0, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART8_MUX] = ma35d1_clk_mux(dev, "uart8_mux", clk_base + REG_CLK_CLKSEL3, 0, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART8_DIV] = ma35d1_clk_divider(dev, "uart8_div", "uart8_mux",
-					    clk_base + REG_CLK_CLKDIV2,
-					    16, 4);
+					    clk_base + REG_CLK_CLKDIV2, 16, 4);
 	hws[UART8_GATE] = ma35d1_clk_gate(dev, "uart8_gate", "uart8_div",
 					  clk_base + REG_CLK_APBCLK0, 20);
-	hws[UART9_MUX] = ma35d1_clk_mux(dev, "uart9_mux", clk_base + REG_CLK_CLKSEL3,
-					2, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART9_MUX] = ma35d1_clk_mux(dev, "uart9_mux", clk_base + REG_CLK_CLKSEL3, 2, 1,
+					uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART9_DIV] = ma35d1_clk_divider(dev, "uart9_div", "uart9_mux",
-					    clk_base + REG_CLK_CLKDIV2,
-					    20, 4);
+					    clk_base + REG_CLK_CLKDIV2, 20, 4);
 	hws[UART9_GATE] = ma35d1_clk_gate(dev, "uart9_gate", "uart9_div",
 					  clk_base + REG_CLK_APBCLK0, 21);
-	hws[UART10_MUX] = ma35d1_clk_mux(dev, "uart10_mux", clk_base + REG_CLK_CLKSEL3,
-					 4, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART10_MUX] = ma35d1_clk_mux(dev, "uart10_mux", clk_base + REG_CLK_CLKSEL3, 4, 1,
+					 uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART10_DIV] = ma35d1_clk_divider(dev, "uart10_div", "uart10_mux",
-					     clk_base + REG_CLK_CLKDIV2,
-					     24, 4);
+					     clk_base + REG_CLK_CLKDIV2, 24, 4);
 	hws[UART10_GATE] = ma35d1_clk_gate(dev, "uart10_gate", "uart10_div",
 					   clk_base + REG_CLK_APBCLK0, 22);
-	hws[UART11_MUX] = ma35d1_clk_mux(dev, "uart11_mux", clk_base + REG_CLK_CLKSEL3,
-					 6, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART11_MUX] = ma35d1_clk_mux(dev, "uart11_mux", clk_base + REG_CLK_CLKSEL3, 6, 1,
+					 uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART11_DIV] = ma35d1_clk_divider(dev, "uart11_div", "uart11_mux",
-					     clk_base + REG_CLK_CLKDIV2,
-					     28, 4);
+					     clk_base + REG_CLK_CLKDIV2, 28, 4);
 	hws[UART11_GATE] = ma35d1_clk_gate(dev, "uart11_gate", "uart11_div",
 					   clk_base + REG_CLK_APBCLK0, 23);
-	hws[UART12_MUX] = ma35d1_clk_mux(dev, "uart12_mux", clk_base + REG_CLK_CLKSEL3,
-					 8, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART12_MUX] = ma35d1_clk_mux(dev, "uart12_mux", clk_base + REG_CLK_CLKSEL3, 8, 1,
+					 uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART12_DIV] = ma35d1_clk_divider(dev, "uart12_div", "uart12_mux",
-					     clk_base + REG_CLK_CLKDIV3,
-					     0, 4);
+					     clk_base + REG_CLK_CLKDIV3, 0, 4);
 	hws[UART12_GATE] = ma35d1_clk_gate(dev, "uart12_gate", "uart12_div",
 					   clk_base + REG_CLK_APBCLK0, 24);
-	hws[UART13_MUX] = ma35d1_clk_mux(dev, "uart13_mux", clk_base + REG_CLK_CLKSEL3,
-					 10, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART13_MUX] = ma35d1_clk_mux(dev, "uart13_mux", clk_base + REG_CLK_CLKSEL3, 10, 1,
+					 uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART13_DIV] = ma35d1_clk_divider(dev, "uart13_div", "uart13_mux",
-					     clk_base + REG_CLK_CLKDIV3,
-					     4, 4);
+					     clk_base + REG_CLK_CLKDIV3, 4, 4);
 	hws[UART13_GATE] = ma35d1_clk_gate(dev, "uart13_gate", "uart13_div",
 					   clk_base + REG_CLK_APBCLK0, 25);
-	hws[UART14_MUX] = ma35d1_clk_mux(dev, "uart14_mux", clk_base + REG_CLK_CLKSEL3,
-					 12, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART14_MUX] = ma35d1_clk_mux(dev, "uart14_mux", clk_base + REG_CLK_CLKSEL3, 12, 1,
+					 uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART14_DIV] = ma35d1_clk_divider(dev, "uart14_div", "uart14_mux",
-					     clk_base + REG_CLK_CLKDIV3,
-					     8, 4);
+					     clk_base + REG_CLK_CLKDIV3, 8, 4);
 	hws[UART14_GATE] = ma35d1_clk_gate(dev, "uart14_gate", "uart14_div",
 					   clk_base + REG_CLK_APBCLK0, 26);
-	hws[UART15_MUX] = ma35d1_clk_mux(dev, "uart15_mux", clk_base + REG_CLK_CLKSEL3,
-					 14, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART15_MUX] = ma35d1_clk_mux(dev, "uart15_mux", clk_base + REG_CLK_CLKSEL3, 14, 1,
+					 uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART15_DIV] = ma35d1_clk_divider(dev, "uart15_div", "uart15_mux",
-					     clk_base + REG_CLK_CLKDIV3,
-					     12, 4);
+					     clk_base + REG_CLK_CLKDIV3, 12, 4);
 	hws[UART15_GATE] = ma35d1_clk_gate(dev, "uart15_gate", "uart15_div",
 					   clk_base + REG_CLK_APBCLK0, 27);
-	hws[UART16_MUX] = ma35d1_clk_mux(dev, "uart16_mux", clk_base + REG_CLK_CLKSEL3,
-					 16, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+
+	hws[UART16_MUX] = ma35d1_clk_mux(dev, "uart16_mux", clk_base + REG_CLK_CLKSEL3, 16, 1,
+					 uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
 	hws[UART16_DIV] = ma35d1_clk_divider(dev, "uart16_div", "uart16_mux",
-					     clk_base + REG_CLK_CLKDIV3,
-					     16, 4);
+					     clk_base + REG_CLK_CLKDIV3, 16, 4);
 	hws[UART16_GATE] = ma35d1_clk_gate(dev, "uart16_gate", "uart16_div",
 					   clk_base + REG_CLK_APBCLK0, 28);
 
@@ -772,11 +882,10 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[DDR_GATE] = ma35d1_clk_gate(dev, "ddr_gate", "ddrpll",
 					clk_base + REG_CLK_APBCLK0, 30);
 
-	hws[KPI_MUX] = ma35d1_clk_mux(dev, "kpi_mux", clk_base + REG_CLK_CLKSEL4,
-				      30, 1, kpi_sel_clks, ARRAY_SIZE(kpi_sel_clks));
+	hws[KPI_MUX] = ma35d1_clk_mux(dev, "kpi_mux", clk_base + REG_CLK_CLKSEL4, 30, 1,
+				      kpi_sel_clks, ARRAY_SIZE(kpi_sel_clks));
 	hws[KPI_DIV] = ma35d1_clk_divider(dev, "kpi_div", "kpi_mux",
-					  clk_base + REG_CLK_CLKDIV4,
-					  24, 8);
+					  clk_base + REG_CLK_CLKDIV4, 24, 8);
 	hws[KPI_GATE] = ma35d1_clk_gate(dev, "kpi_gate", "kpi_div",
 					clk_base + REG_CLK_APBCLK0, 31);
 
@@ -793,49 +902,53 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[I2C5_GATE] = ma35d1_clk_gate(dev, "i2c5_gate", "pclk2",
 					 clk_base + REG_CLK_APBCLK1, 5);
 
-	hws[QSPI0_MUX] = ma35d1_clk_mux(dev, "qspi0_mux", clk_base + REG_CLK_CLKSEL4,
-					8, 2, qspi0_sel_clks, ARRAY_SIZE(qspi0_sel_clks));
+	hws[QSPI0_MUX] = ma35d1_clk_mux(dev, "qspi0_mux", clk_base + REG_CLK_CLKSEL4, 8, 1,
+					qspi_sel_clks, ARRAY_SIZE(qspi_sel_clks));
 	hws[QSPI0_GATE] = ma35d1_clk_gate(dev, "qspi0_gate", "qspi0_mux",
 					  clk_base + REG_CLK_APBCLK1, 6);
-	hws[QSPI1_MUX] = ma35d1_clk_mux(dev, "qspi1_mux", clk_base + REG_CLK_CLKSEL4,
-					10, 2, qspi1_sel_clks, ARRAY_SIZE(qspi1_sel_clks));
+
+	hws[QSPI1_MUX] = ma35d1_clk_mux(dev, "qspi1_mux", clk_base + REG_CLK_CLKSEL4, 10, 1,
+					qspi_sel_clks, ARRAY_SIZE(qspi_sel_clks));
 	hws[QSPI1_GATE] = ma35d1_clk_gate(dev, "qspi1_gate", "qspi1_mux",
 					  clk_base + REG_CLK_APBCLK1, 7);
 
-	hws[SMC0_MUX] = ma35d1_clk_mux(dev, "smc0_mux", clk_base + REG_CLK_CLKSEL4,
-					28, 1, smc_sel_clks, ARRAY_SIZE(smc_sel_clks));
+	hws[SMC0_MUX] = ma35d1_clk_mux(dev, "smc0_mux", clk_base + REG_CLK_CLKSEL4, 28, 1,
+				       smc_sel_clks, ARRAY_SIZE(smc_sel_clks));
 	hws[SMC0_DIV] = ma35d1_clk_divider(dev, "smc0_div", "smc0_mux",
-					   clk_base + REG_CLK_CLKDIV1,
-					   0, 4);
+					   clk_base + REG_CLK_CLKDIV1, 0, 4);
 	hws[SMC0_GATE] = ma35d1_clk_gate(dev, "smc0_gate", "smc0_div",
 					 clk_base + REG_CLK_APBCLK1, 12);
-	hws[SMC1_MUX] = ma35d1_clk_mux(dev, "smc1_mux", clk_base + REG_CLK_CLKSEL4,
-					 29, 1, smc_sel_clks, ARRAY_SIZE(smc_sel_clks));
+
+	hws[SMC1_MUX] = ma35d1_clk_mux(dev, "smc1_mux", clk_base + REG_CLK_CLKSEL4, 29, 1,
+				       smc_sel_clks, ARRAY_SIZE(smc_sel_clks));
 	hws[SMC1_DIV] = ma35d1_clk_divider(dev, "smc1_div", "smc1_mux",
-					   clk_base + REG_CLK_CLKDIV1,
-					   4, 4);
+					   clk_base + REG_CLK_CLKDIV1, 4, 4);
 	hws[SMC1_GATE] = ma35d1_clk_gate(dev, "smc1_gate", "smc1_div",
 					 clk_base + REG_CLK_APBCLK1, 13);
 
-	hws[WDT0_MUX] = ma35d1_clk_mux(dev, "wdt0_mux", clk_base + REG_CLK_CLKSEL3,
-				       20, 2, wdt0_sel_clks, ARRAY_SIZE(wdt0_sel_clks));
+	hws[WDT0_MUX] = ma35d1_clk_mux(dev, "wdt0_mux", clk_base + REG_CLK_CLKSEL3, 20, 2,
+				       wdt0_sel_clks, ARRAY_SIZE(wdt0_sel_clks));
 	hws[WDT0_GATE] = ma35d1_clk_gate(dev, "wdt0_gate", "wdt0_mux",
 					 clk_base + REG_CLK_APBCLK1, 16);
-	hws[WDT1_MUX] = ma35d1_clk_mux(dev, "wdt1_mux", clk_base + REG_CLK_CLKSEL3,
-				       24, 2, wdt1_sel_clks, ARRAY_SIZE(wdt1_sel_clks));
+
+	hws[WDT1_MUX] = ma35d1_clk_mux(dev, "wdt1_mux", clk_base + REG_CLK_CLKSEL3, 24, 2,
+				       wdt1_sel_clks, ARRAY_SIZE(wdt1_sel_clks));
 	hws[WDT1_GATE] = ma35d1_clk_gate(dev, "wdt1_gate", "wdt1_mux",
 					 clk_base + REG_CLK_APBCLK1, 17);
-	hws[WDT2_MUX] = ma35d1_clk_mux(dev, "wdt2_mux", clk_base + REG_CLK_CLKSEL3,
-				       28, 2, wdt2_sel_clks, ARRAY_SIZE(wdt2_sel_clks));
+
+	hws[WDT2_MUX] = ma35d1_clk_mux(dev, "wdt2_mux", clk_base + REG_CLK_CLKSEL3, 28, 2,
+				       wdt2_sel_clks, ARRAY_SIZE(wdt2_sel_clks));
 	hws[WDT2_GATE] = ma35d1_clk_gate(dev, "wdt2_gate", "wdt2_mux",
 				       clk_base + REG_CLK_APBCLK1, 18);
 
-	hws[WWDT0_MUX] = ma35d1_clk_mux(dev, "wwdt0_mux", clk_base + REG_CLK_CLKSEL3,
-					22, 2, wwdt0_sel_clks, ARRAY_SIZE(wwdt0_sel_clks));
-	hws[WWDT1_MUX] = ma35d1_clk_mux(dev, "wwdt1_mux", clk_base + REG_CLK_CLKSEL3,
-					26, 2, wwdt1_sel_clks, ARRAY_SIZE(wwdt1_sel_clks));
-	hws[WWDT2_MUX] = ma35d1_clk_mux(dev, "wwdt2_mux", clk_base + REG_CLK_CLKSEL3,
-					30, 2, wwdt2_sel_clks, ARRAY_SIZE(wwdt2_sel_clks));
+	hws[WWDT0_MUX] = ma35d1_clk_mux(dev, "wwdt0_mux", clk_base + REG_CLK_CLKSEL3, 22, 2,
+					wwdt0_sel_clks, ARRAY_SIZE(wwdt0_sel_clks));
+
+	hws[WWDT1_MUX] = ma35d1_clk_mux(dev, "wwdt1_mux", clk_base + REG_CLK_CLKSEL3, 26, 2,
+					wwdt1_sel_clks, ARRAY_SIZE(wwdt1_sel_clks));
+
+	hws[WWDT2_MUX] = ma35d1_clk_mux(dev, "wwdt2_mux", clk_base + REG_CLK_CLKSEL3, 30, 2,
+					wwdt2_sel_clks, ARRAY_SIZE(wwdt2_sel_clks));
 
 	hws[EPWM0_GATE] = ma35d1_clk_gate(dev, "epwm0_gate", "pclk1",
 					  clk_base + REG_CLK_APBCLK1, 24);
@@ -844,12 +957,13 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EPWM2_GATE] = ma35d1_clk_gate(dev, "epwm2_gate", "pclk1",
 					  clk_base + REG_CLK_APBCLK1, 26);
 
-	hws[I2S0_MUX] = ma35d1_clk_mux(dev, "i2s0_mux", clk_base + REG_CLK_CLKSEL4,
-				       12, 2, i2s0_sel_clks, ARRAY_SIZE(i2s0_sel_clks));
+	hws[I2S0_MUX] = ma35d1_clk_mux(dev, "i2s0_mux", clk_base + REG_CLK_CLKSEL4, 12, 1,
+				       i2s_sel_clks, ARRAY_SIZE(i2s_sel_clks));
 	hws[I2S0_GATE] = ma35d1_clk_gate(dev, "i2s0_gate", "i2s0_mux",
 					 clk_base + REG_CLK_APBCLK2, 0);
-	hws[I2S1_MUX] = ma35d1_clk_mux(dev, "i2s1_mux", clk_base + REG_CLK_CLKSEL4,
-				       14, 2, i2s1_sel_clks, ARRAY_SIZE(i2s1_sel_clks));
+
+	hws[I2S1_MUX] = ma35d1_clk_mux(dev, "i2s1_mux", clk_base + REG_CLK_CLKSEL4, 14, 1,
+				       i2s_sel_clks, ARRAY_SIZE(i2s_sel_clks));
 	hws[I2S1_GATE] = ma35d1_clk_gate(dev, "i2s1_gate", "i2s1_mux",
 					 clk_base + REG_CLK_APBCLK2, 1);
 
@@ -858,20 +972,23 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[SSPCC_GATE] = ma35d1_clk_gate(dev, "sspcc_gate", "pclk3",
 					  clk_base + REG_CLK_APBCLK2, 3);
 
-	hws[SPI0_MUX] = ma35d1_clk_mux(dev, "spi0_mux", clk_base + REG_CLK_CLKSEL4,
-				       0, 2, spi0_sel_clks, ARRAY_SIZE(spi0_sel_clks));
+	hws[SPI0_MUX] = ma35d1_clk_mux(dev, "spi0_mux", clk_base + REG_CLK_CLKSEL4, 0, 1,
+				       spi0_sel_clks, ARRAY_SIZE(spi0_sel_clks));
 	hws[SPI0_GATE] = ma35d1_clk_gate(dev, "spi0_gate", "spi0_mux",
 					 clk_base + REG_CLK_APBCLK2, 4);
-	hws[SPI1_MUX] = ma35d1_clk_mux(dev, "spi1_mux", clk_base + REG_CLK_CLKSEL4,
-				       2, 2, spi1_sel_clks, ARRAY_SIZE(spi1_sel_clks));
+
+	hws[SPI1_MUX] = ma35d1_clk_mux(dev, "spi1_mux", clk_base + REG_CLK_CLKSEL4, 2, 1,
+				       spi1_sel_clks, ARRAY_SIZE(spi1_sel_clks));
 	hws[SPI1_GATE] = ma35d1_clk_gate(dev, "spi1_gate", "spi1_mux",
 					 clk_base + REG_CLK_APBCLK2, 5);
-	hws[SPI2_MUX] = ma35d1_clk_mux(dev, "spi2_mux", clk_base + REG_CLK_CLKSEL4,
-				       4, 2, spi2_sel_clks, ARRAY_SIZE(spi2_sel_clks));
+
+	hws[SPI2_MUX] = ma35d1_clk_mux(dev, "spi2_mux", clk_base + REG_CLK_CLKSEL4, 4, 1,
+				       spi2_sel_clks, ARRAY_SIZE(spi2_sel_clks));
 	hws[SPI2_GATE] = ma35d1_clk_gate(dev, "spi2_gate", "spi2_mux",
 					 clk_base + REG_CLK_APBCLK2, 6);
-	hws[SPI3_MUX] = ma35d1_clk_mux(dev, "spi3_mux", clk_base + REG_CLK_CLKSEL4,
-				       6, 2, spi3_sel_clks, ARRAY_SIZE(spi3_sel_clks));
+
+	hws[SPI3_MUX] = ma35d1_clk_mux(dev, "spi3_mux", clk_base + REG_CLK_CLKSEL4, 6, 1,
+				       spi3_sel_clks, ARRAY_SIZE(spi3_sel_clks));
 	hws[SPI3_GATE] = ma35d1_clk_gate(dev, "spi3_gate", "spi3_mux",
 					 clk_base + REG_CLK_APBCLK2, 7);
 
@@ -889,10 +1006,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[QEI2_GATE] = ma35d1_clk_gate(dev, "qei2_gate", "pclk1",
 					 clk_base + REG_CLK_APBCLK2, 14);
 
-	hws[ADC_DIV] = ma35d1_reg_adc_clkdiv(dev, "adc_div", hws[PCLK0],
-					     &ma35d1_lock, 0,
-					     clk_base + REG_CLK_CLKDIV4,
-					     4, 17, 0x1ffff);
+	hws[ADC_DIV] = ma35d1_reg_adc_clkdiv(dev, "adc_div", hws[PCLK0], &ma35d1_lock, 0,
+					     clk_base + REG_CLK_CLKDIV4, 4, 17, 0x1ffff);
 	hws[ADC_GATE] = ma35d1_clk_gate(dev, "adc_gate", "adc_div",
 					clk_base + REG_CLK_APBCLK2, 24);
 
@@ -902,9 +1017,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EADC_GATE] = ma35d1_clk_gate(dev, "eadc_gate", "eadc_div",
 					 clk_base + REG_CLK_APBCLK2, 25);
 
-	return devm_of_clk_add_hw_provider(dev,
-					   of_clk_hw_onecell_get,
-					   ma35d1_hw_data);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, ma35d1_hw_data);
 }
 
 static const struct of_device_id ma35d1_clk_of_match[] = {
diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-ma35d1.h
new file mode 100644
index 000000000000..3adee440f60a
--- /dev/null
+++ b/drivers/clk/nuvoton/clk-ma35d1.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Nuvoton Technology Corp.
+ * Author: Chi-Fang Li <cfli0@nuvoton.com>
+ */
+
+#ifndef __DRV_CLK_NUVOTON_MA35D1_H
+#define __DRV_CLK_NUVOTON_MA35D1_H
+
+struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode, const char *name,
+				  struct clk_hw *parent_hw, void __iomem *base);
+
+struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
+				     struct clk_hw *parent_hw, spinlock_t *lock,
+				     unsigned long flags, void __iomem *reg,
+				     u8 shift, u8 width, u32 mask_bit);
+
+#endif /* __DRV_CLK_NUVOTON_MA35D1_H */
-- 
2.34.1

