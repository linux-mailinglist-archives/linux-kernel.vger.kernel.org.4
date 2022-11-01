Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CB614F11
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKAQSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:18:47 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E991C914;
        Tue,  1 Nov 2022 09:18:44 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 418EDD0407;
        Tue,  1 Nov 2022 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667319493; bh=zvhQPufC5PJD5XQqj1MudupKvZYKF2uHkrkysvJe8u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Kx3L2s3t8otKxH6N+dczDfJnDgo+6Y/yE2+rFBiKk6SI17cJMGE4MuMuoaRARUvM1
         Lhj7FoVt9ZYdo6+dP501rjkDBFUy0rF11Sz7G7HzFGQ11SWozD1dxuUkGYd8E6+wIj
         pPlxvdJLWIhk05io5I43Eyw4DKBcFQCqXfLufCT8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950 peripheral
Date:   Tue,  1 Nov 2022 17:18:00 +0100
Message-Id: <20221101161801.1058969-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101161801.1058969-1-luca@z3ntu.xyz>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

The PMI8950 features integrated peripherals like ADC, GPIO controller,
MPPs and others.

[luca@z3ntu.xyz: remove pm8950, style changes for 2022 standards, add wled]
Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes since v2:
* Pick up patch, and adjust as mentioned above sign-offs

 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 97 +++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8950.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
new file mode 100644
index 000000000000..32d27e2187e3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@2 {
+		compatible = "qcom,pmi8950", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi8950_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			adc-chan@0 {
+				reg = <VADC_USBIN>;
+				qcom,pre-scaling = <1 4>;
+				label = "usbin";
+			};
+
+			adc-chan@1 {
+				reg = <VADC_DCIN>;
+				qcom,pre-scaling = <1 4>;
+				label = "dcin";
+			};
+
+			adc-chan@2 {
+				reg = <VADC_VCHG_SNS>;
+				qcom,pre-scaling = <1 1>;
+				label = "vchg_sns";
+			};
+
+			adc-chan@9 {
+				reg = <VADC_REF_625MV>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_625mv";
+			};
+
+			adc-chan@a {
+				reg = <VADC_REF_1250MV>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_1250v";
+			};
+
+			adc-chan@d {
+				reg = <VADC_SPARE2>;
+				qcom,pre-scaling = <1 1>;
+				label = "chg_temp";
+			};
+		};
+
+		pmi8950_mpps: mpps@a000 {
+			compatible = "qcom,pmi8950-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			gpio-ranges = <&pmi8950_mpps 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pmi8950_gpio: gpio@c000 {
+			compatible = "qcom,pmi8950-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pmi8950_gpio 0 0 2>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@3 {
+		compatible = "qcom,pmi8950", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi8950_wled: leds@d800 {
+			compatible = "qcom,pmi8950-wled";
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x3 0xd8 0x02 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "short";
+			label = "backlight";
+
+			status = "disabled";
+		};
+	};
+};
-- 
2.38.1

