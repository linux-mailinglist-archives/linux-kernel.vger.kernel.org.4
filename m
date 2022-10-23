Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E660942C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJWO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:57:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B35C97B;
        Sun, 23 Oct 2022 07:57:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso5039358wmb.5;
        Sun, 23 Oct 2022 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFj+0g9zC945JfgR9vxO7Ms2xSVk7a3nRyoILt5SjhM=;
        b=HjAWWLBr2kEf7p1VaqiGbzqwOt0zJ6cdDBbwqgi7VVAnNs2J4k0wf7oVKh6hAFAGRP
         e0KQh+W/DzAfb4/8yyM3CEPegwqICG2RfnumnGcvadIWjucdvNBmEUOFKz/1qHXyuz6n
         siYeaEx0ijMQDm/XfFdQ9+6zj9jU7hq4g45OrgvY7iTVKznU+mesB1MKw7QwLxVza21C
         XG1zzw5H34g643YpeeIM/Lg12lGsS30Hyu6DmJ+aTZUUPdy3HMZqyNIVdn+G/HBUnMfW
         aLkPitcfjsbHboG5wQVHVnIiZ+s3rrliVKV6E2au2RA7RWOAyP2ypUICizEtHVWp3Pg+
         1WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFj+0g9zC945JfgR9vxO7Ms2xSVk7a3nRyoILt5SjhM=;
        b=ocGHGmekFKUX2IKcKmuwCDrckEBMYaflPdbRQUfSO29ODwotmfX7K17M0MhfhqxYV3
         TTvMpa3OUWNoaq9Ck/QuKJW5aRFI35IbcvKvTQWMuu9euajeqKopgFP2MbzJw/HAkh7z
         kPUpT0onV2cAHA2SRe+FPCakslb9lEWLiOzrpGgEUyppb/krNmTzMOkrvHWXL8nelQKQ
         8E3MRgqsVddBLdV7b9ChTjsv/YCwHHCdQxG7KM0wL98mkfUvYtIcBJbFS62l0Z9Fv09Y
         CDPtaHzDb8q3vJtD5Azlz7V4NHZ3G+IF/ThRjtoWGi8Sqs/Jrl4y7qs6K2OIyVjIaEv5
         lS6Q==
X-Gm-Message-State: ACrzQf0zHLk6z+nR8p/6lcXUdHdXtVHstbNSWyzJg0ADWtgVDG3bp0XG
        WSNo6srU130ehvuqSsBsQMg=
X-Google-Smtp-Source: AMsMyM6K+feSGR7UlA9AzzeCWHxBkSa7NMQLfVqzBsHLhj/RVhDQit81k3PILc6V2Yy+7qDYAXfDvg==
X-Received: by 2002:a05:600c:1e89:b0:3c7:1e:acc2 with SMTP id be9-20020a05600c1e8900b003c7001eacc2mr18476310wmb.44.1666537028420;
        Sun, 23 Oct 2022 07:57:08 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id hg16-20020a05600c539000b003c6b70a4d69sm8345331wmb.42.2022.10.23.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:57:08 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] clk: ingenic: Add X1000 audio clocks
Date:   Sun, 23 Oct 2022 15:56:53 +0100
Message-Id: <20221023145653.177234-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
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
 drivers/clk/ingenic/x1000-cgu.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index b2ce3fb83f54..341276e5e1ef 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/rational.h>
 
 #include <dt-bindings/clock/ingenic,x1000-cgu.h>
 
@@ -168,6 +169,37 @@ static const struct clk_ops x1000_otg_phy_ops = {
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
+	 * For some reason, the I2S divider doesn't work properly after
+	 * updating I2SCDR unless I2SCDR1 is read & written back.
+	 */
+	writel(readl(cgu->base + CGU_REG_I2SCDR1), cgu->base + CGU_REG_I2SCDR1);
+}
+
 static const s8 pll_od_encoding[8] = {
 	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
 };
@@ -319,6 +351,37 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 25 },
 	},
 
+	[X1000_CLK_I2SPLLMUX] = {
+		"i2s_pll_mux", CGU_CLK_MUX,
+		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
+		.mux = { CGU_REG_I2SCDR, 31, 1 },
+	},
+
+	[X1000_CLK_I2SPLL] = {
+		"i2s_pll", CGU_CLK_PLL,
+		.parents = { X1000_CLK_I2SPLLMUX, -1, -1, -1 },
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
@@ -426,6 +489,12 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 9 },
 	},
 
+	[X1000_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 11 },
+	},
+
 	[X1000_CLK_UART0] = {
 		"uart0", CGU_CLK_GATE,
 		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
-- 
2.38.1

