Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6E05BD5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiISUsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiISUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:48:42 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843664AD5E;
        Mon, 19 Sep 2022 13:48:41 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A78F53F608;
        Mon, 19 Sep 2022 22:48:37 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] arm64: dts: qcom: Add PM6125 PMIC
Date:   Mon, 19 Sep 2022 22:48:24 +0200
Message-Id: <20220919204826.215845-4-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919204826.215845-1-marijn.suijten@somainline.org>
References: <20220919204826.215845-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This PMIC is commonly used on boards with an SM6125 SoC and looks very
similar in layout to the PM6150.

Downstream declares more nodes to be available, but these have been
omitted from this patch: the pwm/lpg block is unused on my reference
device making it impossible to test/validate, and the spmi-clkdiv does
not have a single device-tree binding using this driver yet, hence
inclusion is better postponed until ie. audio which uses these clocks is
brought up.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/pm6125.dtsi | 154 +++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm6125.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
new file mode 100644
index 000000000000..1c8ccda26ffb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm6125-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm6125_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmic@0 {
+		compatible = "qcom,pm6125", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm6125_pon: pon@800 {
+			compatible = "qcom,pm8998-pon";
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pon_pwrkey: pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				linux,code = <KEY_POWER>;
+				bias-pull-up;
+				status = "disabled";
+			};
+
+			pon_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		pm6125_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm6125_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm6125_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#io-channel-cells = <1>;
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vph-pwr@83 {
+				reg = <ADC5_VPH_PWR>;
+				qcom,pre-scaling = <1 3>;
+			};
+
+			vcoin@85 {
+				reg = <ADC5_VCOIN>;
+				qcom,pre-scaling = <1 3>;
+			};
+
+			xo-therm@4c {
+				reg = <ADC5_XO_THERM_100K_PU>;
+				qcom,pre-scaling = <1 1>;
+				qcom,hw-settle-time = <200>;
+				qcom,ratiometric;
+			};
+		};
+
+		pm6125_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#thermal-sensor-cells = <1>;
+			status = "disabled";
+		};
+
+		pm6125_rtc: rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		pm6125_gpio: gpio@c000 {
+			compatible = "qcom,pm6125-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm6125_gpio 0 0 9>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm6125", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+	};
+};
-- 
2.37.3

