Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721095BD5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiISUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiISUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:48:42 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADC4A83B;
        Mon, 19 Sep 2022 13:48:40 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2C14D3F613;
        Mon, 19 Sep 2022 22:48:39 +0200 (CEST)
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
Subject: [PATCH v3 5/5] arm64: dts: qcom: sm6125-seine: Configure additional trinket thermistors
Date:   Mon, 19 Sep 2022 22:48:26 +0200
Message-Id: <20220919204826.215845-6-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919204826.215845-1-marijn.suijten@somainline.org>
References: <20220919204826.215845-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to PMIC-specific (pm6125) thermistors downstream extends
this set with the rf-pa0/rf-pa1, quiet, camera-flash and UFS/eMMC
thermistors in sm6125 (trinket) board and seine-specific DT files.  All
thermistors report sensible temperature readings in userspace.

The sensors are also added to their respective Thermal Monitor node,
with thermal zones to match where applicable: emmc-ufs and camera-flash
are not available on the TM5 block, hence cannot be configured with a
tripping point and will not have a thermal zone.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index e01ea35f9a62..5d41def2ccc9 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -9,6 +9,7 @@
 #include "pm6125.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	/* required for bootloader to select correct board */
@@ -80,12 +81,162 @@ cmdline_mem: memory@ffd00000 {
 			no-map;
 		};
 	};
+
+	thermal-zones {
+		rf-pa0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm6125_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		quiet-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <5000>;
+			thermal-sensors = <&pm6125_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		xo-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm6125_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		rf-pa1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm6125_adc_tm 3>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
 
 &hsusb_phy1 {
 	status = "okay";
 };
 
+&pm6125_adc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm &rf_pa1_therm>;
+
+	rf-pa0-therm@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+	};
+
+	quiet-therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+	};
+
+	camera-flash-therm@52 {
+		reg = <ADC5_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+	};
+
+	emmc-ufs-therm@54 {
+		reg = <ADC5_GPIO3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+	};
+
+	rf-pa1-therm@55 {
+		reg = <ADC5_GPIO4_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+	};
+};
+
+&pm6125_adc_tm {
+	status = "okay";
+
+	rf-pa0-therm@0 {
+		reg = <0>;
+		io-channels = <&pm6125_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	quiet-therm@1 {
+		reg = <1>;
+		io-channels = <&pm6125_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	xo-therm@2 {
+		reg = <2>;
+		io-channels = <&pm6125_adc ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	rf-pa1-therm@3 {
+		reg = <3>;
+		io-channels = <&pm6125_adc ADC5_GPIO4_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pm6125_gpio {
+	camera_flash_therm: camera-flash-therm-state {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+
+	emmc_ufs_therm: emmc-ufs-therm-state {
+		pins = "gpio6";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+
+	rf_pa1_therm: rf-pa1-therm-state {
+		pins = "gpio7";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
-- 
2.37.3

