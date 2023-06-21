Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F99737985
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjFUDQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFUDQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:16:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF991717;
        Tue, 20 Jun 2023 20:16:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b51780c1b3so42069925ad.1;
        Tue, 20 Jun 2023 20:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687317374; x=1689909374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZYRhdIOpI6JcpqxSSwAgYhHOJQIAFAhkd8OCiGnT4M=;
        b=N+MUNPoB07UV26qEbzfZVlWXf1QzIdr1QxPuOaGkQzZLFM0FXYZ8dNgITga2oH22oQ
         Ys9ovNBnc4mUtlZ76xIiMTOaP7NZg8FF7OlIaWroNVM28pPvP1L3qU0Ry/k/rR71I4P5
         gxK+SCjaa33HmdZyodA3UCLNPVKkmVDEcsk76tIwTjR1FolXBc2Ji6mJKPgyulqaCEPg
         cK3E06IvQ8ERsH0I3vgHYl5i8B4UEpGP0FhrufGymUYYAJ9lj44DLO56e1wmUvVB2b0w
         OK+DPPXeyk7iNecGANuWvw2vhDvcqyv1P1lBCk8fNtiZthPvZAlWFoGMDwd5mr+cSW5c
         7ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687317374; x=1689909374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZYRhdIOpI6JcpqxSSwAgYhHOJQIAFAhkd8OCiGnT4M=;
        b=Ln6SDByZpzp2VXaf9iOs7/UC3uYtG5MXpc2dCrPstZ0Ay5YTPpiE3qPIpd7O+CZ4u4
         7JxSibI6LRCxAB7/729m0FI30XVnnpe6b3zcm03aNBvuhAnriAgwmWzT0YSFg8NgLsS0
         v4LeBCrCFYWVwUy/Whp5KcasySSM9bkeVqAiolNfof+YVs9i+7n3nm/vgLg+T2s68yyz
         qLi27hXciW98o76mjiz13MNM7LRAdcfySD/yrfnE/sVcasNkI3dIfkIkP9u7FOL3VhXL
         Urkvnh7tYXesGF/bZZhvYkkxyhcnaNfBP18mQjVjyqY5cTfiRURh4gTUd84y/YrVuqPg
         ENQQ==
X-Gm-Message-State: AC+VfDzPW9JMopu5eqWH/4DxJzcv+py4KDZo/yaJ/Vn94G/TAM0vtyeP
        E5AidG4rFF/7PRucGD1RZ5U=
X-Google-Smtp-Source: ACHHUZ5Ie6jphqU+xLQnhswWhtk1Hqgf5Aqgmv0+Xk4FtcL0IioGur/LZwe1AIFLsGH1Ak1NY8qKgg==
X-Received: by 2002:a17:902:ab0c:b0:1b5:28a7:d703 with SMTP id ik12-20020a170902ab0c00b001b528a7d703mr13768601plb.41.1687317374137;
        Tue, 20 Jun 2023 20:16:14 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001b01fc7337csm2257747plb.247.2023.06.20.20.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 20:16:13 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v2 1/2] clk: nuvoton: Add clk-ma35d1.h for driver extern functions
Date:   Wed, 21 Jun 2023 03:16:04 +0000
Message-Id: <20230621031605.234149-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621031605.234149-1-ychuang570808@gmail.com>
References: <20230621031605.234149-1-ychuang570808@gmail.com>
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

Moved the declaration of extern functions ma35d1_reg_clk_pll() and
ma35d1_reg_adc_clkdiv() from the .c files to the newly created header
file clk-ma35d1.h.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/clk/nuvoton/clk-ma35d1-divider.c |  7 ++--
 drivers/clk/nuvoton/clk-ma35d1-pll.c     |  5 ++-
 drivers/clk/nuvoton/clk-ma35d1.c         | 42 ++++++++++--------------
 drivers/clk/nuvoton/clk-ma35d1.h         | 18 ++++++++++
 4 files changed, 40 insertions(+), 32 deletions(-)
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
index 297b11585f00..733750dda0f4 100644
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
@@ -42,32 +44,24 @@ static DEFINE_SPINLOCK(ma35d1_lock);
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
 	{ .index = 0 },  /* HXT */
 	{ .index = 1 },  /* CAPLL */
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

