Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B352460E96F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiJZTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiJZTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:44:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0A11A952;
        Wed, 26 Oct 2022 12:44:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g12so15407491wrs.10;
        Wed, 26 Oct 2022 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE6azSuCc8EUqYAerwdd+9S9IPnt0PRo5gKWCPKCQOE=;
        b=ILlvEt429LwkbGO7/in9jQqADis59od+azklEB/jfc98bCoKyKuCmRAB34MdGZh3Gy
         GsgNolEvGZSn5+u9LCTFWB9++W/XgkzyPw4cmH9DsVp90wuUTnEVtKkcc9YU+J377YpT
         eqAvzFFboYQDMh8TcHonaYtS1rRU3vq4AHd/MGTb1RNwCGR6TwMbN1IBJ9sLQ33M72j3
         dpPQbC4+nlKDsJ2hfrwJKonBiuswwB9w6Tzv/xTQ+Tf/ye5EM/0npCwKA2dCjHgAxyHN
         /e4jS5lSyyP+uuFIcYw3Zdqv/u7Bw4fJZJDK8jB+DBeNEOdrE+wXW5ITSYgMwzPIe1DM
         OC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE6azSuCc8EUqYAerwdd+9S9IPnt0PRo5gKWCPKCQOE=;
        b=oVtjCt5bhubIlQWQEuxyUTbTDviMVYrsGQ4/4HtOAclu6xVwIerGVjPlEuofu9Pfn7
         sr6uESrU3isVgQU8o+xlCm1z9yuMe6thRsGV0aNyfGhGPlM0Wqy2uRksicM18bIPeUhs
         3qGsiGgFofK8c1S6BVs+wzH4EEbcRMD/L8y1iE/SWd1N3L83Axk02ukOmxY4Fepmw3z4
         VvnU0zJ+1A7pAzodm5jquiSyMwaJq6ZDJBEEVaPbgQdn/Y4Dj7uIMMIOx4V25mxUlieJ
         dPldgtPei7va/hjARIGL6SdWsB+/O0uIlOePSl1+9w5vMis926mHzPjKf/s1d5TqwzSk
         2/ZQ==
X-Gm-Message-State: ACrzQf0T2eXTBmcDtpx5kz6H2Po6U9fO2VVTA7ibOPEjGzi9p6igalqg
        LEigoob2goAdTNi3LP7Yzs6NLtcLg/BaKg==
X-Google-Smtp-Source: AMsMyM511lGpmOXeONGG6kS8SqTMVn2idkGvd3tr8ncWeQZJNJEg4ixEBKlWP3ybfFlreWNz8mSduQ==
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id o8-20020a5d6488000000b0022b3b0b5e72mr30550771wri.138.1666813437470;
        Wed, 26 Oct 2022 12:43:57 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id m12-20020a05600c3b0c00b003b47ff307e1sm2754724wms.31.2022.10.26.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:43:57 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] clk: ingenic: Add X1000 audio clocks
Date:   Wed, 26 Oct 2022 20:43:44 +0100
Message-Id: <20221026194345.243007-6-aidanmacdonald.0x0@gmail.com>
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

The X1000's CGU supplies the I2S system clock to the AIC module
and ultimately the audio codec, represented by the "i2s" clock.
It is a simple mux which can either pass through EXCLK or a PLL
multiplied by a fractional divider (the "i2s_pll" clock).

The AIC contains a separate 1/N divider controlled by the I2S
driver, which generates the bit clock from the system clock.
The frame clock is always fixed to 1/64th of the bit clock.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v1 -> v2:
* Fix I2SCDR1 refresh to ensure the register is properly initialized
  and we don't rely on the reset value. Since the I2SDIV_D field can
  be automatically calculated by the hardware we don't need to provide
  it, writing 0 triggers the auto calculation.
* Remove redundant -1 entries from parent clocks.

 drivers/clk/ingenic/x1000-cgu.c | 70 +++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index b2ce3fb83f54..95d5e3a44cee 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/rational.h>
 
 #include <dt-bindings/clock/ingenic,x1000-cgu.h>
 
@@ -168,6 +169,38 @@ static const struct clk_ops x1000_otg_phy_ops = {
 	.is_enabled	= x1000_usb_phy_is_enabled,
 };
 
+static void
+x1000_i2spll_calc_m_n_od(const struct ingenic_cgu_pll_info *pll_info,
+			 unsigned long rate, unsigned long parent_rate,
+			 unsigned int *pm, unsigned int *pn, unsigned int *pod)
+{
+	const unsigned long m_max = GENMASK(pll_info->m_bits - 1, 0);
+	const unsigned long n_max = GENMASK(pll_info->n_bits - 1, 0);
+	unsigned long m, n;
+
+	rational_best_approximation(rate, parent_rate, m_max, n_max, &m, &n);
+
+	/* n should not be less than 2*m */
+	if (n < 2 * m)
+		n = 2 * m;
+
+	*pm = m;
+	*pn = n;
+	*pod = 1;
+}
+
+static void
+x1000_i2spll_set_rate_hook(const struct ingenic_cgu_pll_info *pll_info,
+			   unsigned long rate, unsigned long parent_rate)
+{
+	/*
+	 * Writing 0 causes I2SCDR1.I2SDIV_D to be automatically recalculated
+	 * based on the current value of I2SCDR.I2SDIV_N, which is needed for
+	 * the divider to function correctly.
+	 */
+	writel(0, cgu->base + CGU_REG_I2SCDR1);
+}
+
 static const s8 pll_od_encoding[8] = {
 	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
 };
@@ -319,6 +352,37 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 25 },
 	},
 
+	[X1000_CLK_I2SPLLMUX] = {
+		"i2s_pll_mux", CGU_CLK_MUX,
+		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
+		.mux = { CGU_REG_I2SCDR, 31, 1 },
+	},
+
+	[X1000_CLK_I2SPLL] = {
+		"i2s_pll", CGU_CLK_PLL,
+		.parents = { X1000_CLK_I2SPLLMUX },
+		.pll = {
+			.reg = CGU_REG_I2SCDR,
+			.rate_multiplier = 1,
+			.m_shift = 13,
+			.m_bits = 9,
+			.n_shift = 0,
+			.n_bits = 13,
+			.calc_m_n_od = x1000_i2spll_calc_m_n_od,
+			.set_rate_hook = x1000_i2spll_set_rate_hook,
+		},
+	},
+
+	[X1000_CLK_I2S] = {
+		"i2s", CGU_CLK_MUX,
+		.parents = { X1000_CLK_EXCLK, -1, -1, X1000_CLK_I2SPLL },
+		/*
+		 * NOTE: the mux is at bit 30; bit 29 enables the M/N divider.
+		 * Therefore, the divider is disabled when EXCLK is selected.
+		 */
+		.mux = { CGU_REG_I2SCDR, 29, 2 },
+	},
+
 	[X1000_CLK_LCD] = {
 		"lcd", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
@@ -426,6 +490,12 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 9 },
 	},
 
+	[X1000_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK },
+		.gate = { CGU_REG_CLKGR, 11 },
+	},
+
 	[X1000_CLK_UART0] = {
 		"uart0", CGU_CLK_GATE,
 		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
-- 
2.38.1

