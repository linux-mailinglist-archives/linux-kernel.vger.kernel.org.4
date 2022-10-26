Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637FD60E96B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiJZTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiJZTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:44:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7537B119BFC;
        Wed, 26 Oct 2022 12:44:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5so3193306wmo.1;
        Wed, 26 Oct 2022 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgTbY0wb7NEE8wsfRVlRc/ObdS/WC2z2i1h/J+MWlCI=;
        b=KY7cMPd1GFfcrGv0PtiHQ5CIfXDiI+sstPxdDLC0fKy9ZpCkfKTaukI07g1MBrNmVA
         zL77VTcV1eiCDazbQjF8hfvixA5jyXmPdIl6gJNgatTKiCOVq1IiLMVEjDlFQcxp9f+h
         Mw5VTwQ4zBarNl911bm/OChOqRHUH6l5cvtcqO/eErY8TeudrfdCiYhAUFADRTsRHH/r
         8l8NxMwp6+PoKWUV2eKqZ9ZmQNj1HNXOB70qziXt9gVT1uvhJMfgfaEN+uv4hYwy8Ni1
         PzRlDSBmUxYZhjJvVZhKB4Vy4haShFsol9Gy8MeNj7Udp9BMEaF7Usip/JLL1o3bi3CC
         H/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgTbY0wb7NEE8wsfRVlRc/ObdS/WC2z2i1h/J+MWlCI=;
        b=4tli4QnkRi8MQuFELRdII8TouQFPe5hCdRqzH5ROcD8FU/o8IUXK84V/1VCKqLKfH0
         258XHVRdkUEXqWHv0N7nbOvgjNg1fX/mtHSDMx1RGjxYVoatdPKw0L/f7W4NVgPiPgRv
         BW34k802pxeXPgE9OTGrLojaJFzItZ11kBlLedgZKo5SrO0/VmUHycyoGzNPWPi7myj4
         O4UYP3maaT2VQWA6fn4pBHUaFXLMJMxYXkM9GrUMzbFrlzsEO+6hu3bMYort+uaIFIjc
         zgn6WdYdYoFHT0dHcENUeswxuUGZrfbWqrOZazvhIjMLddzoXIoIYxgo+xtWi4V7+3w/
         YNZg==
X-Gm-Message-State: ACrzQf33E6HAvJN236fwVAPaAzxcjRZCA3WnMiDKbxwlJMiizk33M03p
        Y2dlSWeejKFjz9/4C9R1zZw=
X-Google-Smtp-Source: AMsMyM7Ilr1r8KPJxosCeQz1/nn4rtexXjzOkrLF8BsmDihsFZPMCGK61eqqOXZToHLPYQwpcNjG2A==
X-Received: by 2002:a05:600c:4e8f:b0:3c9:9657:9c0a with SMTP id f15-20020a05600c4e8f00b003c996579c0amr3725394wmq.157.1666813438756;
        Wed, 26 Oct 2022 12:43:58 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm2492662wmh.44.2022.10.26.12.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:43:58 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] clk: ingenic: Minor cosmetic fixups for X1000
Date:   Wed, 26 Oct 2022 20:43:45 +0100
Message-Id: <20221026194345.243007-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant -1 entries from the parents array and fix
a couple indentation / whitespace issues.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/x1000-cgu.c | 49 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 95d5e3a44cee..feb03eed4fe8 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -216,7 +216,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_APLL] = {
 		"apll", CGU_CLK_PLL,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK },
 		.pll = {
 			.reg = CGU_REG_APLL,
 			.rate_multiplier = 1,
@@ -239,7 +239,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_MPLL] = {
 		"mpll", CGU_CLK_PLL,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK },
 		.pll = {
 			.reg = CGU_REG_MPLL,
 			.rate_multiplier = 1,
@@ -289,7 +289,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		 * system; mark it critical.
 		 */
 		.flags = CLK_IS_CRITICAL,
-		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
+		.parents = { X1000_CLK_CPUMUX },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 30 },
 	},
@@ -301,7 +301,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		 * disabling it or any parent clocks will hang the system.
 		 */
 		.flags = CLK_IS_CRITICAL,
-		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
+		.parents = { X1000_CLK_CPUMUX },
 		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
 	},
 
@@ -320,13 +320,13 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_AHB2] = {
 		"ahb2", CGU_CLK_DIV,
-		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
+		.parents = { X1000_CLK_AHB2PMUX },
 		.div = { CGU_REG_CPCCR, 12, 1, 4, 20, -1, -1 },
 	},
 
 	[X1000_CLK_PCLK] = {
 		"pclk", CGU_CLK_DIV | CGU_CLK_GATE,
-		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
+		.parents = { X1000_CLK_AHB2PMUX },
 		.div = { CGU_REG_CPCCR, 16, 1, 4, 20, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 28 },
 	},
@@ -393,13 +393,13 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_MSCMUX] = {
 		"msc_mux", CGU_CLK_MUX,
-		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL},
+		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
 		.mux = { CGU_REG_MSC0CDR, 31, 1 },
 	},
 
 	[X1000_CLK_MSC0] = {
 		"msc0", CGU_CLK_DIV | CGU_CLK_GATE,
-		.parents = { X1000_CLK_MSCMUX, -1, -1, -1 },
+		.parents = { X1000_CLK_MSCMUX },
 		.div = { CGU_REG_MSC0CDR, 0, 2, 8, 29, 28, 27 },
 		.gate = { CGU_REG_CLKGR, 4 },
 	},
@@ -413,8 +413,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_OTG] = {
 		"otg", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
-		.parents = { X1000_CLK_EXCLK, -1,
-					 X1000_CLK_APLL, X1000_CLK_MPLL },
+		.parents = { X1000_CLK_EXCLK, -1, X1000_CLK_APLL, X1000_CLK_MPLL },
 		.mux = { CGU_REG_USBCDR, 30, 2 },
 		.div = { CGU_REG_USBCDR, 0, 1, 8, 29, 28, 27 },
 		.gate = { CGU_REG_CLKGR, 3 },
@@ -422,7 +421,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_SSIPLL] = {
 		"ssi_pll", CGU_CLK_MUX | CGU_CLK_DIV,
-		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
+		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
 		.mux = { CGU_REG_SSICDR, 31, 1 },
 		.div = { CGU_REG_SSICDR, 0, 1, 8, 29, 28, 27 },
 	},
@@ -435,7 +434,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_SSIMUX] = {
 		"ssi_mux", CGU_CLK_MUX,
-		.parents = { X1000_CLK_EXCLK, X1000_CLK_SSIPLL_DIV2, -1, -1 },
+		.parents = { X1000_CLK_EXCLK, X1000_CLK_SSIPLL_DIV2 },
 		.mux = { CGU_REG_SSICDR, 30, 1 },
 	},
 
@@ -456,37 +455,37 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_EMC] = {
 		"emc", CGU_CLK_GATE,
-		.parents = { X1000_CLK_AHB2, -1, -1, -1 },
+		.parents = { X1000_CLK_AHB2 },
 		.gate = { CGU_REG_CLKGR, 0 },
 	},
 
 	[X1000_CLK_EFUSE] = {
 		"efuse", CGU_CLK_GATE,
-		.parents = { X1000_CLK_AHB2, -1, -1, -1 },
+		.parents = { X1000_CLK_AHB2 },
 		.gate = { CGU_REG_CLKGR, 1 },
 	},
 
 	[X1000_CLK_SFC] = {
 		"sfc", CGU_CLK_GATE,
-		.parents = { X1000_CLK_SSIPLL, -1, -1, -1 },
+		.parents = { X1000_CLK_SSIPLL },
 		.gate = { CGU_REG_CLKGR, 2 },
 	},
 
 	[X1000_CLK_I2C0] = {
 		"i2c0", CGU_CLK_GATE,
-		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_PCLK },
 		.gate = { CGU_REG_CLKGR, 7 },
 	},
 
 	[X1000_CLK_I2C1] = {
 		"i2c1", CGU_CLK_GATE,
-		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_PCLK },
 		.gate = { CGU_REG_CLKGR, 8 },
 	},
 
 	[X1000_CLK_I2C2] = {
 		"i2c2", CGU_CLK_GATE,
-		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_PCLK },
 		.gate = { CGU_REG_CLKGR, 9 },
 	},
 
@@ -498,43 +497,43 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_UART0] = {
 		"uart0", CGU_CLK_GATE,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK },
 		.gate = { CGU_REG_CLKGR, 14 },
 	},
 
 	[X1000_CLK_UART1] = {
 		"uart1", CGU_CLK_GATE,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK},
 		.gate = { CGU_REG_CLKGR, 15 },
 	},
 
 	[X1000_CLK_UART2] = {
 		"uart2", CGU_CLK_GATE,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK },
 		.gate = { CGU_REG_CLKGR, 16 },
 	},
 
 	[X1000_CLK_TCU] = {
 		"tcu", CGU_CLK_GATE,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK },
 		.gate = { CGU_REG_CLKGR, 18 },
 	},
 
 	[X1000_CLK_SSI] = {
 		"ssi", CGU_CLK_GATE,
-		.parents = { X1000_CLK_SSIMUX, -1, -1, -1 },
+		.parents = { X1000_CLK_SSIMUX },
 		.gate = { CGU_REG_CLKGR, 19 },
 	},
 
 	[X1000_CLK_OST] = {
 		"ost", CGU_CLK_GATE,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK },
 		.gate = { CGU_REG_CLKGR, 20 },
 	},
 
 	[X1000_CLK_PDMA] = {
 		"pdma", CGU_CLK_GATE,
-		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.parents = { X1000_CLK_EXCLK },
 		.gate = { CGU_REG_CLKGR, 21 },
 	},
 };
-- 
2.38.1

