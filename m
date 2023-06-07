Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A7725C40
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjFGK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjFGK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3032110
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so60387185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135385; x=1688727385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YhkyuhCr2fcUKifDGF/DQw38WaYwj61w7Rb0d767Eg=;
        b=HRX63JQgd2JNG5097PwllVHWo5IE4UYHQk7AVCFo4O10ShIaoKRsVMpj9szbcoQ3/f
         E8Ym/plEQac+MKl4HbBMPSEEImCprtHQJJT0DnDmtmNiDCF3WNSvHk99rfXkBcqTLiOy
         /Uk+yACj4KIGzWJctUs6JAN4bP6dxY8JIggGUYwCTT/Zw13K520/Bl2y8frKyJM2Tqn0
         kUW7WO/xe3RGrCQnY0bniqz5tvxcOlM0dZLWHjmq3spuc5HPs1WYcOjEpIx1pd+6arLg
         UcfmpCYpP28hnqk3wZAjjtiNnErgvJRx5rsPjjAZFtscmBTS/YsIKD6Dzg62zRPN5VHl
         LkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135385; x=1688727385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YhkyuhCr2fcUKifDGF/DQw38WaYwj61w7Rb0d767Eg=;
        b=jkvReMIiFRTNd388ErfDT34fTO8f2L+9xTCAscHZ2E3MPHPk+NVrIVwc7nbwgjESJC
         oU9DcmMUaE4pdALyhnzyJen5J0b6ro5sM0wPzAop1ARfr1h0MQEXw5m02CuSs/dt3K7d
         k/VQHxnniCkjGxGb36xf5GEdAY42/Pe2dbp3nuOWFIezv6UuPB55AJudkQgpPEDhOeC0
         6JACUij5eB7Nrs1/oueHUxucu8TJS5W2rJhWYApvZmc2yxOtWZPsAwV9x2FvAPgPwpx+
         ZaqxMBAgDHT5ftZdic9XxXUQIsowj1NreEgE4LTxITjhRsHTaeYmeci7v9GqkyHqAw1q
         qmMg==
X-Gm-Message-State: AC+VfDzJPwKVm1C7WJIUj8vIEoX66Vgg1vwi3lrBJAChPSFDr7WkwoJY
        7QSCw54bmXyYGTpK93maMiiPpw==
X-Google-Smtp-Source: ACHHUZ6U1+NVF/vZIM66tcHoguLScPT1/TFSEggInzRxr8yOVNNr87udHiBnisNuKsC7EYOHHErpyw==
X-Received: by 2002:a7b:c4d5:0:b0:3f6:7af:8fe7 with SMTP id g21-20020a7bc4d5000000b003f607af8fe7mr4045016wmk.10.1686135385146;
        Wed, 07 Jun 2023 03:56:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:13 +0200
Subject: [PATCH 02/18] clk: meson: migrate meson-aoclk out of
 hw_onecell_data to drop NR_CLKS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-2-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11825;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZYZo03qA6TCCfGG8iDc0CvE0APVLodiNcINMmhZuIOs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJOExBoEUZNooX0uUV+ss5+LU5vAnCCrEZ+5ITW
 0Z/abE6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiTgAKCRB33NvayMhJ0RbaEA
 DJDJGZ/APL8uQaGr04b9u1RumIk4Q9UvCKbvCyNGDqLIoz/sxqfm7A9PJbfnHu3h5BYEU5m/rf+PJ1
 wBLUXEJz5M4rJxjYvRVRvd+AFH/r5Wu0peyWwQJfhA9WToxHv+8SkrULQxvsjizaKBN6o3K5v8YE8u
 fctRGj54b9IxyN9S0zsGNB0gZGp+ku+3bWr73Lco7D+1oBsR3oTxvhUP4tsfJRn4KH0jWomGvv47eH
 i8PaNiXEemFxIYZDul3RQa70lwsun4gCtbq63zHaOr79hEtl4Rf65vx4kkh2DtS+UITUu9Wx3tbku4
 YCjqyiSHbRyIh9A682npsK3lWmYCsr5m+y0xtbfg+K2JpIONMSzJSFTqRxzVtR879KdLXDqw9Lc9Nw
 tZjYNyUAzY3ccnaPPkZ1GZ+PuKQb/ChLgK/7iHsb8sPB5d4UOdve+ZbEhEHHW0xyfzwwCmkgzjak+s
 2IXVu1ZEmuLxIfL0ZlmUopv5S3ZQpgcubdj0K0jzCaxz4H2RtmXv3UwVvYcIeXlCH74/HUSrIEODeR
 cATQF8ucwt9tp8ub70BgvtQLhcq+c67YJ6oczsBWR6MJ9BWyEsz3EUbnQfrSCaJXM11etyYF0l5+li
 jp5oD8KwV0eaX6D7bd4aiNXol2FP3Zyfes3ThDqLY4U6LpwJrqI6KvgAA6YQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/clk/meson/axg-aoclk.c   | 42 +++++++++++++-------------
 drivers/clk/meson/axg-aoclk.h   |  2 --
 drivers/clk/meson/g12a-aoclk.c  | 66 ++++++++++++++++++++---------------------
 drivers/clk/meson/g12a-aoclk.h  |  2 --
 drivers/clk/meson/gxbb-aoclk.c  |  8 ++---
 drivers/clk/meson/gxbb-aoclk.h  |  2 --
 drivers/clk/meson/meson-aoclk.c | 22 ++++++++++----
 drivers/clk/meson/meson-aoclk.h |  3 +-
 8 files changed, 74 insertions(+), 73 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index af6db437bcd8..db5b53146bcc 100644
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
@@ -317,7 +314,8 @@ static const struct meson_aoclk_data axg_aoclkc_data = {
 	.reset		= axg_aoclk_reset,
 	.num_clks	= ARRAY_SIZE(axg_aoclk_regmap),
 	.clks		= axg_aoclk_regmap,
-	.hw_data	= &axg_aoclk_onecell_data,
+	.hw_clks	= axg_aoclk_hw_clks,
+	.hw_clk_num	= ARRAY_SIZE(axg_aoclk_hw_clks),
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
index b52990e574d2..52501ec709f7 100644
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
@@ -452,7 +449,8 @@ static const struct meson_aoclk_data g12a_aoclkc_data = {
 	.reset		= g12a_aoclk_reset,
 	.num_clks	= ARRAY_SIZE(g12a_aoclk_regmap),
 	.clks		= g12a_aoclk_regmap,
-	.hw_data	= &g12a_aoclk_onecell_data,
+	.hw_clks	= g12a_aoclk_hw_clks,
+	.hw_clk_num	= ARRAY_SIZE(g12a_aoclk_hw_clks),
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
index fce95cf89836..b08f60f5a73d 100644
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
@@ -278,7 +275,8 @@ static const struct meson_aoclk_data gxbb_aoclkc_data = {
 	.reset		= gxbb_aoclk_reset,
 	.num_clks	= ARRAY_SIZE(gxbb_aoclk),
 	.clks		= gxbb_aoclk,
-	.hw_data	= &gxbb_aoclk_onecell_data,
+	.hw_clks	= gxbb_aoclk_hw_clks,
+	.hw_clk_num	= ARRAY_SIZE(gxbb_aoclk_hw_clks),
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
index 434cd8f9de82..3515144aaee5 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -33,6 +33,19 @@ static const struct reset_control_ops meson_aoclk_reset_ops = {
 	.reset = meson_aoclk_do_reset,
 };
 
+static struct clk_hw *meson_aoclkc_hw_get(struct of_phandle_args *clkspec, void *clk_data)
+{
+	const struct meson_aoclk_data *data = clk_data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= data->hw_clk_num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return data->hw_clks[idx];
+}
+
 int meson_aoclkc_probe(struct platform_device *pdev)
 {
 	struct meson_aoclk_reset_controller *rstc;
@@ -75,19 +88,18 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		data->clks[clkid]->map = regmap;
 
 	/* Register all clks */
-	for (clkid = 0; clkid < data->hw_data->num; clkid++) {
-		if (!data->hw_data->hws[clkid])
+	for (clkid = 0; clkid < data->hw_clk_num; clkid++) {
+		if (!data->hw_clks[clkid])
 			continue;
 
-		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
+		ret = devm_clk_hw_register(dev, data->hw_clks[clkid]);
 		if (ret) {
 			dev_err(dev, "Clock registration failed\n");
 			return ret;
 		}
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-		(void *) data->hw_data);
+	return devm_of_clk_add_hw_provider(dev, meson_aoclkc_hw_get, data);
 }
 EXPORT_SYMBOL_GPL(meson_aoclkc_probe);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index 605b43855a69..4b7dda9c997d 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -24,7 +24,8 @@ struct meson_aoclk_data {
 	const unsigned int			*reset;
 	const int				num_clks;
 	struct clk_regmap			**clks;
-	const struct clk_hw_onecell_data	*hw_data;
+	struct clk_hw				**hw_clks;
+	unsigned int				hw_clk_num;
 };
 
 struct meson_aoclk_reset_controller {

-- 
2.34.1

