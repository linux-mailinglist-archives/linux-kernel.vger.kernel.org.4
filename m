Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3642D68A0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjBCRrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjBCRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:47:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBE6AC225
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:47:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso6566863wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzUXV5E/65QiwxBrXaEXN2y4vVWhreFvINSEdAk1xTs=;
        b=FhxA1nwuM+fXkMskZp6KXI/5JgLaGPC0+CLfFaAyVIY9j+yG5YhpvoRVrV1dy/p+rE
         k9p/rSFFejsKYIu7yrrIYF/HdZ6psNDNx2os2YnNjEe0hMz68tZrkoNo2cdfGXrhqpC3
         1NrWP/C2VAS8CvSDodtkyheitGN0T23/NzbVZEZmXRNZfD4U0GkYBvSfA+8v3V8J+JvL
         kbGAEYJ/wtjCIfxYKb7pezmtnZGHT0gnpt2m411LXAKNxjRtM23gID09ytRlZw5bErDH
         plNyT8j4eyWDHQnSp6WxpmcP2J33+UPS6qBOnab/V2XWprTKvSRuC9Yvdk7WKGw8gIiL
         KHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzUXV5E/65QiwxBrXaEXN2y4vVWhreFvINSEdAk1xTs=;
        b=YgWJFDUAgwbCpIA1x9bOJoQtxLHqUJQm4tH4k4AnvFNHzwAh0eWEtmYkOuWKDiJO2o
         XBi8HidpnQ3I4SJh3YKWR1XoyVbQg1cynPEGNmaMr4gBCqUYMgXKF+HYAnb/nkA30kvZ
         eeLnV5HWZJm9xl6HnnPSYd/pnL1ymAciwoa3XTmiWWjTQMQo89qmT6r9D+fY2GtDKHFJ
         iG/mJhvD2N4T+F+Z+ymE24ybULm+cA18LPt8h99jWFz+CVimeFtNVptl+lgVwEPyh2qt
         AKH4IrE+hshda/Bj1EU5bI7Q1DCM8lMRIJS2Kw1ZYWo0yxK6aS7wWQ5G8XznDnLhTqer
         2hBQ==
X-Gm-Message-State: AO0yUKUohjA/12+30+fop7m907DuRUbkfTZBQM8/AaFOdYmqXQrvTLyJ
        JbEUFaStz0hQzHj83JjvexRFKg==
X-Google-Smtp-Source: AK7set+dJn9Xci9D1lDm0nJxvE5eLl4y0RGTOIrAvrY54C+G3HnSLNARC9UtHZNKhmaV2VDlLWtQ/w==
X-Received: by 2002:a05:600c:3b89:b0:3dc:19d1:3c13 with SMTP id n9-20020a05600c3b8900b003dc19d13c13mr10244026wms.12.1675446416243;
        Fri, 03 Feb 2023 09:46:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w14-20020a05600c474e00b003dfe57f6f61sm2964725wmo.33.2023.02.03.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:46:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] pinctrl: qcom: pinctrl-sm8550-lpass-lpi: add SM8550 LPASS
Date:   Fri,  3 Feb 2023 18:46:45 +0100
Message-Id: <20230203174645.597053-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203174645.597053-1-krzysztof.kozlowski@linaro.org>
References: <20230203174645.597053-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add druver for pin controller in Low Power Audio SubSystem (LPASS).  The
driver is similar to SM8450 LPASS pin controller, with differences in
few pin groups (qua_mi2s -> i2s0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig                  |  11 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 .../pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c   | 240 ++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 8d4f871e07cf..6e306992fad9 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -486,6 +486,17 @@ config PINCTRL_SM8550
 	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
 	  Technologies Inc SM8550 platform.
 
+config PINCTRL_SM8550_LPASS_LPI
+	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
+	depends on GPIOLIB
+	depends on ARM64 || COMPILE_TEST
+	depends on PINCTRL_LPASS_LPI
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
+	  (Low Power Island) found on the Qualcomm Technologies Inc SM8550
+	  platform.
+
 config PINCTRL_LPASS_LPI
 	tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
 	select PINMUX
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6763aa8d319c..37bfbcf8234b 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -50,5 +50,6 @@ obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
 obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
 obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8550) += pinctrl-sm8550.o
+obj-$(CONFIG_PINCTRL_SM8550_LPASS_LPI) += pinctrl-sm8550-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SC8280XP_LPASS_LPI) += pinctrl-sc8280xp-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
new file mode 100644
index 000000000000..c2bdd936d27f
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Linaro Ltd.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-lpass-lpi.h"
+
+enum lpass_lpi_functions {
+	LPI_MUX_dmic1_clk,
+	LPI_MUX_dmic1_data,
+	LPI_MUX_dmic2_clk,
+	LPI_MUX_dmic2_data,
+	LPI_MUX_dmic3_clk,
+	LPI_MUX_dmic3_data,
+	LPI_MUX_dmic4_clk,
+	LPI_MUX_dmic4_data,
+	LPI_MUX_i2s0_clk,
+	LPI_MUX_i2s0_data,
+	LPI_MUX_i2s0_ws,
+	LPI_MUX_i2s1_clk,
+	LPI_MUX_i2s1_data,
+	LPI_MUX_i2s1_ws,
+	LPI_MUX_i2s2_clk,
+	LPI_MUX_i2s2_data,
+	LPI_MUX_i2s2_ws,
+	LPI_MUX_i2s3_clk,
+	LPI_MUX_i2s3_data,
+	LPI_MUX_i2s3_ws,
+	LPI_MUX_i2s4_clk,
+	LPI_MUX_i2s4_data,
+	LPI_MUX_i2s4_ws,
+	LPI_MUX_slimbus_clk,
+	LPI_MUX_slimbus_data,
+	LPI_MUX_swr_rx_clk,
+	LPI_MUX_swr_rx_data,
+	LPI_MUX_swr_tx_clk,
+	LPI_MUX_swr_tx_data,
+	LPI_MUX_wsa_swr_clk,
+	LPI_MUX_wsa_swr_data,
+	LPI_MUX_wsa2_swr_clk,
+	LPI_MUX_wsa2_swr_data,
+	LPI_MUX_ext_mclk1_a,
+	LPI_MUX_ext_mclk1_b,
+	LPI_MUX_ext_mclk1_c,
+	LPI_MUX_ext_mclk1_d,
+	LPI_MUX_ext_mclk1_e,
+	LPI_MUX_gpio,
+	LPI_MUX__,
+};
+
+static int gpio0_pins[] = { 0 };
+static int gpio1_pins[] = { 1 };
+static int gpio2_pins[] = { 2 };
+static int gpio3_pins[] = { 3 };
+static int gpio4_pins[] = { 4 };
+static int gpio5_pins[] = { 5 };
+static int gpio6_pins[] = { 6 };
+static int gpio7_pins[] = { 7 };
+static int gpio8_pins[] = { 8 };
+static int gpio9_pins[] = { 9 };
+static int gpio10_pins[] = { 10 };
+static int gpio11_pins[] = { 11 };
+static int gpio12_pins[] = { 12 };
+static int gpio13_pins[] = { 13 };
+static int gpio14_pins[] = { 14 };
+static int gpio15_pins[] = { 15 };
+static int gpio16_pins[] = { 16 };
+static int gpio17_pins[] = { 17 };
+static int gpio18_pins[] = { 18 };
+static int gpio19_pins[] = { 19 };
+static int gpio20_pins[] = { 20 };
+static int gpio21_pins[] = { 21 };
+static int gpio22_pins[] = { 22 };
+
+static const struct pinctrl_pin_desc sm8550_lpi_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "gpio12"),
+	PINCTRL_PIN(13, "gpio13"),
+	PINCTRL_PIN(14, "gpio14"),
+	PINCTRL_PIN(15, "gpio15"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
+	PINCTRL_PIN(19, "gpio19"),
+	PINCTRL_PIN(20, "gpio20"),
+	PINCTRL_PIN(21, "gpio21"),
+	PINCTRL_PIN(22, "gpio22"),
+};
+
+static const char * const dmic1_clk_groups[] = { "gpio6" };
+static const char * const dmic1_data_groups[] = { "gpio7" };
+static const char * const dmic2_clk_groups[] = { "gpio8" };
+static const char * const dmic2_data_groups[] = { "gpio9" };
+static const char * const dmic3_clk_groups[] = { "gpio12" };
+static const char * const dmic3_data_groups[] = { "gpio13" };
+static const char * const dmic4_clk_groups[] = { "gpio17" };
+static const char * const dmic4_data_groups[] = { "gpio18" };
+static const char * const i2s0_clk_groups[] = { "gpio0" };
+static const char * const i2s0_ws_groups[] = { "gpio1" };
+static const char * const i2s0_data_groups[] = { "gpio2", "gpio3", "gpio4", "gpio5" };
+static const char * const i2s1_clk_groups[] = { "gpio6" };
+static const char * const i2s1_ws_groups[] = { "gpio7" };
+static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
+static const char * const i2s2_clk_groups[] = { "gpio10" };
+static const char * const i2s2_ws_groups[] = { "gpio11" };
+static const char * const i2s2_data_groups[] = { "gpio15", "gpio16" };
+static const char * const i2s3_clk_groups[] = { "gpio12" };
+static const char * const i2s3_ws_groups[] = { "gpio13" };
+static const char * const i2s3_data_groups[] = { "gpio17", "gpio18" };
+static const char * const i2s4_clk_groups[] = { "gpio19"};
+static const char * const i2s4_ws_groups[] = { "gpio20"};
+static const char * const i2s4_data_groups[] = { "gpio21", "gpio22"};
+static const char * const slimbus_clk_groups[] = { "gpio19"};
+static const char * const slimbus_data_groups[] = { "gpio20"};
+static const char * const swr_tx_clk_groups[] = { "gpio0" };
+static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio14" };
+static const char * const swr_rx_clk_groups[] = { "gpio3" };
+static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5", "gpio15" };
+static const char * const wsa_swr_clk_groups[] = { "gpio10" };
+static const char * const wsa_swr_data_groups[] = { "gpio11" };
+static const char * const wsa2_swr_clk_groups[] = { "gpio15" };
+static const char * const wsa2_swr_data_groups[] = { "gpio16" };
+static const char * const ext_mclk1_c_groups[] = { "gpio5" };
+static const char * const ext_mclk1_b_groups[] = { "gpio9" };
+static const char * const ext_mclk1_a_groups[] = { "gpio13" };
+static const char * const ext_mclk1_d_groups[] = { "gpio14" };
+static const char * const ext_mclk1_e_groups[] = { "gpio22" };
+
+static const struct lpi_pingroup sm8550_groups[] = {
+	LPI_PINGROUP(0, 0, swr_tx_clk, i2s0_clk, _, _),
+	LPI_PINGROUP(1, 2, swr_tx_data, i2s0_ws, _, _),
+	LPI_PINGROUP(2, 4, swr_tx_data, i2s0_data, _, _),
+	LPI_PINGROUP(3, 8, swr_rx_clk, i2s0_data, _, _),
+	LPI_PINGROUP(4, 10, swr_rx_data, i2s0_data, _, _),
+	LPI_PINGROUP(5, 12, swr_rx_data, ext_mclk1_c, i2s0_data, _),
+	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
+	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
+	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
+	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, ext_mclk1_b, _),
+	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
+	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
+	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s3_clk, _, _),
+	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s3_ws, ext_mclk1_a, _),
+	LPI_PINGROUP(14, 6, swr_tx_data, ext_mclk1_d, _, _),
+	LPI_PINGROUP(15, 20, i2s2_data, wsa2_swr_clk, _, _),
+	LPI_PINGROUP(16, 22, i2s2_data, wsa2_swr_data, _, _),
+	LPI_PINGROUP(17, LPI_NO_SLEW, dmic4_clk, i2s3_data, _, _),
+	LPI_PINGROUP(18, LPI_NO_SLEW, dmic4_data, i2s3_data, _, _),
+	LPI_PINGROUP(19, LPI_NO_SLEW, i2s4_clk, slimbus_clk, _, _),
+	LPI_PINGROUP(20, LPI_NO_SLEW, i2s4_ws, slimbus_data, _, _),
+	LPI_PINGROUP(21, LPI_NO_SLEW, i2s4_data, _, _, _),
+	LPI_PINGROUP(22, LPI_NO_SLEW, i2s4_data, ext_mclk1_e, _, _),
+};
+
+static const struct lpi_function sm8550_functions[] = {
+	LPI_FUNCTION(dmic1_clk),
+	LPI_FUNCTION(dmic1_data),
+	LPI_FUNCTION(dmic2_clk),
+	LPI_FUNCTION(dmic2_data),
+	LPI_FUNCTION(dmic3_clk),
+	LPI_FUNCTION(dmic3_data),
+	LPI_FUNCTION(dmic4_clk),
+	LPI_FUNCTION(dmic4_data),
+	LPI_FUNCTION(i2s0_clk),
+	LPI_FUNCTION(i2s0_data),
+	LPI_FUNCTION(i2s0_ws),
+	LPI_FUNCTION(i2s1_clk),
+	LPI_FUNCTION(i2s1_data),
+	LPI_FUNCTION(i2s1_ws),
+	LPI_FUNCTION(i2s2_clk),
+	LPI_FUNCTION(i2s2_data),
+	LPI_FUNCTION(i2s2_ws),
+	LPI_FUNCTION(i2s3_clk),
+	LPI_FUNCTION(i2s3_data),
+	LPI_FUNCTION(i2s3_ws),
+	LPI_FUNCTION(i2s4_clk),
+	LPI_FUNCTION(i2s4_data),
+	LPI_FUNCTION(i2s4_ws),
+	LPI_FUNCTION(slimbus_clk),
+	LPI_FUNCTION(slimbus_data),
+	LPI_FUNCTION(swr_rx_clk),
+	LPI_FUNCTION(swr_rx_data),
+	LPI_FUNCTION(swr_tx_clk),
+	LPI_FUNCTION(swr_tx_data),
+	LPI_FUNCTION(wsa_swr_clk),
+	LPI_FUNCTION(wsa_swr_data),
+	LPI_FUNCTION(wsa2_swr_clk),
+	LPI_FUNCTION(wsa2_swr_data),
+	LPI_FUNCTION(ext_mclk1_a),
+	LPI_FUNCTION(ext_mclk1_b),
+	LPI_FUNCTION(ext_mclk1_c),
+	LPI_FUNCTION(ext_mclk1_d),
+	LPI_FUNCTION(ext_mclk1_e),
+};
+
+static const struct lpi_pinctrl_variant_data sm8550_lpi_data = {
+	.pins = sm8550_lpi_pins,
+	.npins = ARRAY_SIZE(sm8550_lpi_pins),
+	.groups = sm8550_groups,
+	.ngroups = ARRAY_SIZE(sm8550_groups),
+	.functions = sm8550_functions,
+	.nfunctions = ARRAY_SIZE(sm8550_functions),
+};
+
+static const struct of_device_id lpi_pinctrl_of_match[] = {
+	{
+	       .compatible = "qcom,sm8550-lpass-lpi-pinctrl",
+	       .data = &sm8550_lpi_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
+
+static struct platform_driver lpi_pinctrl_driver = {
+	.driver = {
+		   .name = "qcom-sm8550-lpass-lpi-pinctrl",
+		   .of_match_table = lpi_pinctrl_of_match,
+	},
+	.probe = lpi_pinctrl_probe,
+	.remove = lpi_pinctrl_remove,
+};
+
+module_platform_driver(lpi_pinctrl_driver);
+MODULE_DESCRIPTION("Qualcomm SM8550 LPI GPIO pin control driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

