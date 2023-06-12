Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD972BEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjFLK3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjFLK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:28:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45B55A5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:09:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977e0fbd742so608736766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564476; x=1689156476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw/rCadAAXL79CFLRSUQPy8XYxYwff3PlTHUSH33OfY=;
        b=Yy86R/Oc3rNRR/mAuTmnPCqBwiae6LQSkw1kBHQr2oe0fE46/Ye6orTjnWq74wAnxG
         I3LMyiWdUP71rYTx14TV+FlVv1U/nKhGC4wcWGHZUMmcS0b/noliqgPpt1vNlbv75KFK
         qCF/PXEvPZLa8Jp9EfMVPyC647VJ20A2AFETBu96JB9FrDXFhMVj2QGb192lIbgbZUma
         wruVg8RMqakGt9kc/TnMCVYtjWfw6WnYV+gs19GGNg6ccji3RLitdFn8mwDbXgwGBQnS
         Tq0/YpT/v0+KdprcUeM6Yk9lXbK0X2ZLK0Q5mmW0S9+X9DUs6xlC9vXCHXc21TWGTmaD
         f2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564476; x=1689156476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw/rCadAAXL79CFLRSUQPy8XYxYwff3PlTHUSH33OfY=;
        b=kwpelxbx+JoJYAITy0MykAvctWRUq4HlvFyGpbNvvpLu1Z26NyWfLCwZEytv5Cvwn/
         0wEKuI7oz0liLNQc823e0mL3QjKoKBxKgVDAnB4DyToPuEsx+9VR1eGg1IM8QSmivUao
         R3+lYvhQ72FlkTcmj785D81zEGZbSCaLZGcxo+puFR6zWOqmAIUUC5RCwZ/jSbsCjV9V
         wJupVFknQuR2OjmqZEPVLkrFBSUG4SCZ8LWcLC/6Zi+rArY59sRQO1ZqcnFczoFjJ7Ye
         FhmsRk1AkaQ18BMkYUyphfFyZQ0lHsXt7js3MeYUpNcgH6RsCp1DHxtGsrgpUBEQPwNA
         zTiQ==
X-Gm-Message-State: AC+VfDzODXGyeFXKFi+7FNjta00bgo5parZlSw4t67xfwPZUkJlQJLIF
        sArCA/LZew3Bh5lb9mAO16CKpYo+V2OsJcCkwEL8Rg==
X-Google-Smtp-Source: ACHHUZ7Nj7K48LPwKpVkcBSYiTeTZq3O2zhydrN5rx9W1UNRx3vSxgd19cnaiULzsBS+PbW1vRvnVg==
X-Received: by 2002:a5d:5486:0:b0:30f:bea9:bf17 with SMTP id h6-20020a5d5486000000b0030fbea9bf17mr2771768wrv.30.1686563857429;
        Mon, 12 Jun 2023 02:57:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:20 +0200
Subject: [PATCH v2 03/19] clk: meson: migrate meson-aoclk out of
 hw_onecell_data to drop NR_CLKS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-3-38172d17c27a@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11916;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=u0XTmnGJ7kpzwSNhseqUxfIkEBUoq9Fep+pYYL8Z2KA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwGPiKIs/zwlWbwuXV2xU1Kn8Cc40zOotivYKlK
 /VSHeJuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsBgAKCRB33NvayMhJ0UgJD/
 9nNiaMTkKwHKUWNcnhTdO8LNn4pUIVSgpnEPDjQ4OL0pBG3c8IGaI72Ge8DzgqmgLBUKEMq2g0KsPe
 lnaQkIvPcPMcKszTEX1cT2fQ40sTSt2lcr2CtAXRpXmEycF+MBg+stk7XXMmpnRlq4jZCME1BUfLfn
 +PFlBScTNgrsASY2CX4Vi8isbE/bPtb1/kLlswNTK3xH+a+YXmQEh+X+AZLK5PObzGzjE7KSgPaB4k
 oHTPgIQDwFjRmi6sR37u7ByKBbzQd1k7CI2Ws4G0Ip7ZSoNNWzZUEGkL0sGDTzSVmPdQiQ/XdGV2QH
 SIfdqQ+8epX0hmp2pysLHKVBNdFBL2ZD04F7/WpYvk2WZhmkXuhpQisImZn1rd3Qo65KvBgZaN4UNO
 VfgmFJc5n4pwvz7AGE+IV1tQvwmI2wTE4lshN3DqGLVJsr7wmuyVenHLfI5feJ/TYVbWkdvTleni6a
 qD6/eLL6wW8ht58n+Cx4l/HiWnUv9WdQZLROtUMwKqK0U22lD8xNK0lWSbenHaGlNLO35MLKmTS4f1
 IkgD641bB3FDFqeAyp2lItKtv6NqxL6fdt8irIY8O/4Zx6Gc/ateEI6zPSaJT+3keCJTkcJg5QIT/y
 xXO/WyOUtUlHKfnAz9UArE2Lg0wOSyEp97DgLoYWaBQxdyh65+7GLhK3SLYg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way hw_onecell_data is declared:
  struct clk_hw_onecell_data {
          unsigned int num;
          struct clk_hw *hws[];
  };

makes it impossible to have the clk_hw table declared outside while
using ARRAY_SIZE() to determine ".num" due to ".hws" being a flexible
array member.

Completely move out of hw_onecell_data and add a custom
devm_of_clk_add_hw_provider() "get" callback to retrieve the clk_hw
from the meson_aoclk_data struct to finally get rid on the
NR_CLKS define.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/Kconfig       |  1 +
 drivers/clk/meson/axg-aoclk.c   | 44 +++++++++++++-------------
 drivers/clk/meson/axg-aoclk.h   |  2 --
 drivers/clk/meson/g12a-aoclk.c  | 68 ++++++++++++++++++++---------------------
 drivers/clk/meson/g12a-aoclk.h  |  2 --
 drivers/clk/meson/gxbb-aoclk.c  | 10 +++---
 drivers/clk/meson/gxbb-aoclk.h  |  2 --
 drivers/clk/meson/meson-aoclk.c |  9 +++---
 drivers/clk/meson/meson-aoclk.h |  3 +-
 9 files changed, 68 insertions(+), 73 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 5bf901da8a63..caadaf973317 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -36,6 +36,7 @@ config COMMON_CLK_MESON_CLKC_UTILS
 config COMMON_CLK_MESON_AO_CLKC
 	tristate
 	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_CLKC_UTILS
 	select RESET_CONTROLLER
 
 config COMMON_CLK_MESON_EE_CLKC
diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index af6db437bcd8..2d1dad8657e0 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -288,27 +288,24 @@ static struct clk_regmap *axg_aoclk_regmap[] = {
 	&axg_aoclk_saradc_gate,
 };
 
-static const struct clk_hw_onecell_data axg_aoclk_onecell_data = {
-	.hws = {
-		[CLKID_AO_REMOTE]	= &axg_aoclk_remote.hw,
-		[CLKID_AO_I2C_MASTER]	= &axg_aoclk_i2c_master.hw,
-		[CLKID_AO_I2C_SLAVE]	= &axg_aoclk_i2c_slave.hw,
-		[CLKID_AO_UART1]	= &axg_aoclk_uart1.hw,
-		[CLKID_AO_UART2]	= &axg_aoclk_uart2.hw,
-		[CLKID_AO_IR_BLASTER]	= &axg_aoclk_ir_blaster.hw,
-		[CLKID_AO_SAR_ADC]	= &axg_aoclk_saradc.hw,
-		[CLKID_AO_CLK81]	= &axg_aoclk_clk81.hw,
-		[CLKID_AO_SAR_ADC_SEL]	= &axg_aoclk_saradc_mux.hw,
-		[CLKID_AO_SAR_ADC_DIV]	= &axg_aoclk_saradc_div.hw,
-		[CLKID_AO_SAR_ADC_CLK]	= &axg_aoclk_saradc_gate.hw,
-		[CLKID_AO_CTS_OSCIN]	= &axg_aoclk_cts_oscin.hw,
-		[CLKID_AO_32K_PRE]	= &axg_aoclk_32k_pre.hw,
-		[CLKID_AO_32K_DIV]	= &axg_aoclk_32k_div.hw,
-		[CLKID_AO_32K_SEL]	= &axg_aoclk_32k_sel.hw,
-		[CLKID_AO_32K]		= &axg_aoclk_32k.hw,
-		[CLKID_AO_CTS_RTC_OSCIN] = &axg_aoclk_cts_rtc_oscin.hw,
-	},
-	.num = NR_CLKS,
+static struct clk_hw *axg_aoclk_hw_clks[] = {
+	[CLKID_AO_REMOTE]	= &axg_aoclk_remote.hw,
+	[CLKID_AO_I2C_MASTER]	= &axg_aoclk_i2c_master.hw,
+	[CLKID_AO_I2C_SLAVE]	= &axg_aoclk_i2c_slave.hw,
+	[CLKID_AO_UART1]	= &axg_aoclk_uart1.hw,
+	[CLKID_AO_UART2]	= &axg_aoclk_uart2.hw,
+	[CLKID_AO_IR_BLASTER]	= &axg_aoclk_ir_blaster.hw,
+	[CLKID_AO_SAR_ADC]	= &axg_aoclk_saradc.hw,
+	[CLKID_AO_CLK81]	= &axg_aoclk_clk81.hw,
+	[CLKID_AO_SAR_ADC_SEL]	= &axg_aoclk_saradc_mux.hw,
+	[CLKID_AO_SAR_ADC_DIV]	= &axg_aoclk_saradc_div.hw,
+	[CLKID_AO_SAR_ADC_CLK]	= &axg_aoclk_saradc_gate.hw,
+	[CLKID_AO_CTS_OSCIN]	= &axg_aoclk_cts_oscin.hw,
+	[CLKID_AO_32K_PRE]	= &axg_aoclk_32k_pre.hw,
+	[CLKID_AO_32K_DIV]	= &axg_aoclk_32k_div.hw,
+	[CLKID_AO_32K_SEL]	= &axg_aoclk_32k_sel.hw,
+	[CLKID_AO_32K]		= &axg_aoclk_32k.hw,
+	[CLKID_AO_CTS_RTC_OSCIN] = &axg_aoclk_cts_rtc_oscin.hw,
 };
 
 static const struct meson_aoclk_data axg_aoclkc_data = {
@@ -317,7 +314,10 @@ static const struct meson_aoclk_data axg_aoclkc_data = {
 	.reset		= axg_aoclk_reset,
 	.num_clks	= ARRAY_SIZE(axg_aoclk_regmap),
 	.clks		= axg_aoclk_regmap,
-	.hw_data	= &axg_aoclk_onecell_data,
+	.hw_clks 	= {
+		.hws	= axg_aoclk_hw_clks,
+		.num	= ARRAY_SIZE(axg_aoclk_hw_clks),
+	},
 };
 
 static const struct of_device_id axg_aoclkc_match_table[] = {
diff --git a/drivers/clk/meson/axg-aoclk.h b/drivers/clk/meson/axg-aoclk.h
index 3cc27e85170f..fe23dc53aa73 100644
--- a/drivers/clk/meson/axg-aoclk.h
+++ b/drivers/clk/meson/axg-aoclk.h
@@ -10,8 +10,6 @@
 #ifndef __AXG_AOCLKC_H
 #define __AXG_AOCLKC_H
 
-#define NR_CLKS	17
-
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/reset/axg-aoclkc.h>
 
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index b52990e574d2..9b258c1bc2d1 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -411,39 +411,36 @@ static struct clk_regmap *g12a_aoclk_regmap[] = {
 	&g12a_aoclk_saradc_gate,
 };
 
-static const struct clk_hw_onecell_data g12a_aoclk_onecell_data = {
-	.hws = {
-		[CLKID_AO_AHB]		= &g12a_aoclk_ahb.hw,
-		[CLKID_AO_IR_IN]	= &g12a_aoclk_ir_in.hw,
-		[CLKID_AO_I2C_M0]	= &g12a_aoclk_i2c_m0.hw,
-		[CLKID_AO_I2C_S0]	= &g12a_aoclk_i2c_s0.hw,
-		[CLKID_AO_UART]		= &g12a_aoclk_uart.hw,
-		[CLKID_AO_PROD_I2C]	= &g12a_aoclk_prod_i2c.hw,
-		[CLKID_AO_UART2]	= &g12a_aoclk_uart2.hw,
-		[CLKID_AO_IR_OUT]	= &g12a_aoclk_ir_out.hw,
-		[CLKID_AO_SAR_ADC]	= &g12a_aoclk_saradc.hw,
-		[CLKID_AO_MAILBOX]	= &g12a_aoclk_mailbox.hw,
-		[CLKID_AO_M3]		= &g12a_aoclk_m3.hw,
-		[CLKID_AO_AHB_SRAM]	= &g12a_aoclk_ahb_sram.hw,
-		[CLKID_AO_RTI]		= &g12a_aoclk_rti.hw,
-		[CLKID_AO_M4_FCLK]	= &g12a_aoclk_m4_fclk.hw,
-		[CLKID_AO_M4_HCLK]	= &g12a_aoclk_m4_hclk.hw,
-		[CLKID_AO_CLK81]	= &g12a_aoclk_clk81.hw,
-		[CLKID_AO_SAR_ADC_SEL]	= &g12a_aoclk_saradc_mux.hw,
-		[CLKID_AO_SAR_ADC_DIV]	= &g12a_aoclk_saradc_div.hw,
-		[CLKID_AO_SAR_ADC_CLK]	= &g12a_aoclk_saradc_gate.hw,
-		[CLKID_AO_CTS_OSCIN]	= &g12a_aoclk_cts_oscin.hw,
-		[CLKID_AO_32K_PRE]	= &g12a_aoclk_32k_by_oscin_pre.hw,
-		[CLKID_AO_32K_DIV]	= &g12a_aoclk_32k_by_oscin_div.hw,
-		[CLKID_AO_32K_SEL]	= &g12a_aoclk_32k_by_oscin_sel.hw,
-		[CLKID_AO_32K]		= &g12a_aoclk_32k_by_oscin.hw,
-		[CLKID_AO_CEC_PRE]	= &g12a_aoclk_cec_pre.hw,
-		[CLKID_AO_CEC_DIV]	= &g12a_aoclk_cec_div.hw,
-		[CLKID_AO_CEC_SEL]	= &g12a_aoclk_cec_sel.hw,
-		[CLKID_AO_CEC]		= &g12a_aoclk_cec.hw,
-		[CLKID_AO_CTS_RTC_OSCIN] = &g12a_aoclk_cts_rtc_oscin.hw,
-	},
-	.num = NR_CLKS,
+static struct clk_hw *g12a_aoclk_hw_clks[] = {
+	[CLKID_AO_AHB]		= &g12a_aoclk_ahb.hw,
+	[CLKID_AO_IR_IN]	= &g12a_aoclk_ir_in.hw,
+	[CLKID_AO_I2C_M0]	= &g12a_aoclk_i2c_m0.hw,
+	[CLKID_AO_I2C_S0]	= &g12a_aoclk_i2c_s0.hw,
+	[CLKID_AO_UART]		= &g12a_aoclk_uart.hw,
+	[CLKID_AO_PROD_I2C]	= &g12a_aoclk_prod_i2c.hw,
+	[CLKID_AO_UART2]	= &g12a_aoclk_uart2.hw,
+	[CLKID_AO_IR_OUT]	= &g12a_aoclk_ir_out.hw,
+	[CLKID_AO_SAR_ADC]	= &g12a_aoclk_saradc.hw,
+	[CLKID_AO_MAILBOX]	= &g12a_aoclk_mailbox.hw,
+	[CLKID_AO_M3]		= &g12a_aoclk_m3.hw,
+	[CLKID_AO_AHB_SRAM]	= &g12a_aoclk_ahb_sram.hw,
+	[CLKID_AO_RTI]		= &g12a_aoclk_rti.hw,
+	[CLKID_AO_M4_FCLK]	= &g12a_aoclk_m4_fclk.hw,
+	[CLKID_AO_M4_HCLK]	= &g12a_aoclk_m4_hclk.hw,
+	[CLKID_AO_CLK81]	= &g12a_aoclk_clk81.hw,
+	[CLKID_AO_SAR_ADC_SEL]	= &g12a_aoclk_saradc_mux.hw,
+	[CLKID_AO_SAR_ADC_DIV]	= &g12a_aoclk_saradc_div.hw,
+	[CLKID_AO_SAR_ADC_CLK]	= &g12a_aoclk_saradc_gate.hw,
+	[CLKID_AO_CTS_OSCIN]	= &g12a_aoclk_cts_oscin.hw,
+	[CLKID_AO_32K_PRE]	= &g12a_aoclk_32k_by_oscin_pre.hw,
+	[CLKID_AO_32K_DIV]	= &g12a_aoclk_32k_by_oscin_div.hw,
+	[CLKID_AO_32K_SEL]	= &g12a_aoclk_32k_by_oscin_sel.hw,
+	[CLKID_AO_32K]		= &g12a_aoclk_32k_by_oscin.hw,
+	[CLKID_AO_CEC_PRE]	= &g12a_aoclk_cec_pre.hw,
+	[CLKID_AO_CEC_DIV]	= &g12a_aoclk_cec_div.hw,
+	[CLKID_AO_CEC_SEL]	= &g12a_aoclk_cec_sel.hw,
+	[CLKID_AO_CEC]		= &g12a_aoclk_cec.hw,
+	[CLKID_AO_CTS_RTC_OSCIN] = &g12a_aoclk_cts_rtc_oscin.hw,
 };
 
 static const struct meson_aoclk_data g12a_aoclkc_data = {
@@ -452,7 +449,10 @@ static const struct meson_aoclk_data g12a_aoclkc_data = {
 	.reset		= g12a_aoclk_reset,
 	.num_clks	= ARRAY_SIZE(g12a_aoclk_regmap),
 	.clks		= g12a_aoclk_regmap,
-	.hw_data	= &g12a_aoclk_onecell_data,
+	.hw_clks 	= {
+		.hws	= g12a_aoclk_hw_clks,
+		.num	= ARRAY_SIZE(g12a_aoclk_hw_clks),
+	},
 };
 
 static const struct of_device_id g12a_aoclkc_match_table[] = {
diff --git a/drivers/clk/meson/g12a-aoclk.h b/drivers/clk/meson/g12a-aoclk.h
index a67c8a7cd7c4..077bd25b94a1 100644
--- a/drivers/clk/meson/g12a-aoclk.h
+++ b/drivers/clk/meson/g12a-aoclk.h
@@ -24,8 +24,6 @@
 #define CLKID_AO_CEC_DIV	25
 #define CLKID_AO_CEC_SEL	26
 
-#define NR_CLKS	29
-
 #include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/reset/g12a-aoclkc.h>
 
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index fce95cf89836..736c35d126f5 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -252,8 +252,7 @@ static struct clk_regmap *gxbb_aoclk[] = {
 	&ao_cts_cec,
 };
 
-static const struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
-	.hws = {
+static struct clk_hw *gxbb_aoclk_hw_clks[] = {
 		[CLKID_AO_REMOTE] = &remote_ao.hw,
 		[CLKID_AO_I2C_MASTER] = &i2c_master_ao.hw,
 		[CLKID_AO_I2C_SLAVE] = &i2c_slave_ao.hw,
@@ -268,8 +267,6 @@ static const struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
 		[CLKID_AO_32K] = &ao_32k.hw,
 		[CLKID_AO_CTS_RTC_OSCIN] = &ao_cts_rtc_oscin.hw,
 		[CLKID_AO_CLK81] = &ao_clk81.hw,
-	},
-	.num = NR_CLKS,
 };
 
 static const struct meson_aoclk_data gxbb_aoclkc_data = {
@@ -278,7 +275,10 @@ static const struct meson_aoclk_data gxbb_aoclkc_data = {
 	.reset		= gxbb_aoclk_reset,
 	.num_clks	= ARRAY_SIZE(gxbb_aoclk),
 	.clks		= gxbb_aoclk,
-	.hw_data	= &gxbb_aoclk_onecell_data,
+	.hw_clks 	= {
+		.hws	= gxbb_aoclk_hw_clks,
+		.num	= ARRAY_SIZE(gxbb_aoclk_hw_clks),
+	},
 };
 
 static const struct of_device_id gxbb_aoclkc_match_table[] = {
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index 1db16f9b37d4..94197b957512 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -7,8 +7,6 @@
 #ifndef __GXBB_AOCLKC_H
 #define __GXBB_AOCLKC_H
 
-#define NR_CLKS	14
-
 #include <dt-bindings/clock/gxbb-aoclkc.h>
 #include <dt-bindings/reset/gxbb-aoclkc.h>
 
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index 434cd8f9de82..e7a72bdd0db0 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -75,19 +75,18 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		data->clks[clkid]->map = regmap;
 
 	/* Register all clks */
-	for (clkid = 0; clkid < data->hw_data->num; clkid++) {
-		if (!data->hw_data->hws[clkid])
+	for (clkid = 0; clkid < data->hw_clks.num; clkid++) {
+		if (!data->hw_clks.hws[clkid])
 			continue;
 
-		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
+		ret = devm_clk_hw_register(dev, data->hw_clks.hws[clkid]);
 		if (ret) {
 			dev_err(dev, "Clock registration failed\n");
 			return ret;
 		}
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-		(void *) data->hw_data);
+	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
 }
 EXPORT_SYMBOL_GPL(meson_aoclkc_probe);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index 605b43855a69..308be3e4814a 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -17,6 +17,7 @@
 #include <linux/reset-controller.h>
 
 #include "clk-regmap.h"
+#include "meson-clkc-utils.h"
 
 struct meson_aoclk_data {
 	const unsigned int			reset_reg;
@@ -24,7 +25,7 @@ struct meson_aoclk_data {
 	const unsigned int			*reset;
 	const int				num_clks;
 	struct clk_regmap			**clks;
-	const struct clk_hw_onecell_data	*hw_data;
+	struct meson_clk_hw_data		hw_clks;
 };
 
 struct meson_aoclk_reset_controller {

-- 
2.34.1

