Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A666B648A66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLIVxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLIVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:53:27 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C1A385F;
        Fri,  9 Dec 2022 13:53:21 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 435C01F963;
        Fri,  9 Dec 2022 22:53:18 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] arm64: dts: qcom: Use labels with generic node names for ADC channels
Date:   Fri,  9 Dec 2022 22:53:07 +0100
Message-Id: <20221209215308.1781047-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in [1] the DT should use labels to describe ADC channels,
with generic node names, since the IIO drivers now moved to the fwnode
API where node names include the `@xx` address suffix.

Especially for the ADC5 driver that uses extend_name - which cannot be
removed for compatibility reasons - this results in sysfs files with the
@xx name that wasn't previously present, and leads to an unpleasant
file-browsing experience.

Also remove all the unused channel labels in pm660.dtsi.

[1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/pm6125.dtsi          | 18 ++++++---
 arch/arm64/boot/dts/qcom/pm660.dtsi           | 33 ++++++++++------
 arch/arm64/boot/dts/qcom/pm8950.dtsi          | 39 ++++++++++++-------
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 15 ++++---
 .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  3 +-
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  2 +-
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
 .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  3 +-
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  3 +-
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 ++++---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 21 ++++++----
 15 files changed, 109 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index 59092a551a16..7cfd73f8707e 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -85,36 +85,42 @@ pm6125_adc: adc@3100 {
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#io-channel-cells = <1>;
 
-			ref-gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			vph-pwr@83 {
+			adc-chan@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 
-			vcoin@85 {
+			adc-chan@85 {
 				reg = <ADC5_VCOIN>;
 				qcom,pre-scaling = <1 3>;
+				label = "vcoin";
 			};
 
-			xo-therm@4c {
+			adc-chan@4c {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "xo_therm";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index fc0eccaccdf6..d05bd8f2170b 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -91,82 +91,93 @@ pm660_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			ref_gnd: ref_gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
 			};
 
-			vref_1p25: vref_1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
 			};
 
-			die_temp: die_temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			xo_therm: xo_therm@4c {
+			adc-chan@4c {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "xo_therm";
 			};
 
-			msm_therm: msm_therm@4d {
+			adc-chan@4d {
 				reg = <ADC5_AMUX_THM1_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "msm_therm";
 			};
 
-			emmc_therm: emmc_therm@4e {
+			adc-chan@4e {
 				reg = <ADC5_AMUX_THM2_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "emmc_therm";
 			};
 
-			pa_therm0: thermistor0@4f {
+			adc-chan@4f {
 				reg = <ADC5_AMUX_THM3_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "pa_therm0";
 			};
 
-			pa_therm1: thermistor1@50 {
+			adc-chan@50 {
 				reg = <ADC5_AMUX_THM4_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "pa_therm1";
 			};
 
-			quiet_therm: quiet_therm@51 {
+			adc-chan@51 {
 				reg = <ADC5_AMUX_THM5_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "quiet_therm";
 			};
 
-			vadc_vph_pwr: vph_pwr@83 {
+			adc-chan@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 
-			vcoin: vcoin@85 {
+			adc-chan@85 {
 				reg = <ADC5_VCOIN>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 3>;
+				label = "vcoin";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index 631761f98999..c07572b732dc 100644
--- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -50,77 +50,90 @@ pm8950_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			vcoin@5 {
+			adc-chan@5 {
 				reg = <VADC_VCOIN>;
 				qcom,pre-scaling = <1 1>;
+				label = "vcoin";
 			};
 
-			vph-pwr@7 {
+			adc-chan@7 {
 				reg = <VADC_VSYS>;
 				qcom,pre-scaling = <1 1>;
+				label = "vph_pwr";
 			};
 
-			die-temp@8 {
+			adc-chan@8 {
 				reg = <VADC_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			ref-625mv@9 {
+			adc-chan@9 {
 				reg = <VADC_REF_625MV>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_625mv";
 			};
 
-			ref-1250mv@a {
+			adc-chan@a {
 				reg = <VADC_REF_1250MV>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_1250mv";
 			};
 
-			ref-buf-625mv@c {
+			adc-chan@c {
 				reg = <VADC_SPARE1>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_buf_625mv";
 			};
 
-			ref-gnd@e {
+			adc-chan@e {
 				reg = <VADC_GND_REF>;
+				label = "ref_gnd";
 			};
 
-			ref-vdd@f {
+			adc-chan@f {
 				reg = <VADC_VDD_VADC>;
+				label = "ref_vdd";
 			};
 
-			pa-therm1@11 {
+			adc-chan@11 {
 				reg = <VADC_P_MUX2_1_1>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "pa_therm1";
 			};
 
-			case-therm@13 {
+			adc-chan@13 {
 				reg = <VADC_P_MUX4_1_1>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "case_therm";
 			};
 
-			xo-therm@32 {
+			adc-chan@32 {
 				reg = <VADC_LR_MUX3_XO_THERM>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "xo_therm";
 			};
 
-			pa-therm0@36 {
+			adc-chan@36 {
 				reg = <VADC_LR_MUX7_HW_ID>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "pa_therm0";
 			};
 
-			xo-therm-buf@3c {
+			adc-chan@3c {
 				reg = <VADC_LR_MUX3_BUF_XO_THERM>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "xo_therm_buf";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8c64cb060e21..4ebf2e0fe838 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -644,16 +644,18 @@ &mdss_mdp {
 };
 
 &pm8150_adc {
-	xo-therm@4c {
+	adc-chan@4c {
 		reg = <ADC5_XO_THERM_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "xo_therm";
 	};
 
-	wifi-therm@4e {
+	adc-chan@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "wifi_therm";
 	};
 };
 
@@ -721,10 +723,11 @@ &pm8150_gpios {
 };
 
 &pm8150b_adc {
-	conn-therm@4f {
+	adc-chan@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "conn_therm";
 	};
 };
 
@@ -756,16 +759,18 @@ &pm8150b_gpios {
 };
 
 &pm8150l_adc {
-	skin-msm-therm@4e {
+	adc-chan@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_msm_therm";
 	};
 
-	pm8150l-therm@4f {
+	adc-chan@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "pm8150l_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
index edfcd47e1a00..2db57ecd71c5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
@@ -24,8 +24,8 @@ &charger_thermal {
 };
 
 &pm6150_adc {
-	/delete-node/ skin-temp-thermistor@4e;
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ adc-chan@4e;
+	/delete-node/ adc-chan@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 8b8ea8af165d..4dd51ba62f6f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -119,10 +119,11 @@ &panel {
 };
 
 &pm6150_adc {
-	skin-temp-thermistor@4e {
+	adc-chan@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index d3cf64c16dcd..1511c48f5278 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -127,10 +127,11 @@ &panel {
 };
 
 &pm6150_adc {
-	skin-temp-thermistor@4d {
+	adc-chan@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 269007d73162..508d7e4bdf62 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -55,7 +55,7 @@ &panel {
 };
 
 &pm6150_adc {
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ adc-chan@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
index 8467ff41e6d5..b2a0164529d4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
@@ -27,7 +27,7 @@ &charger_thermal {
 };
 
 &pm6150_adc {
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ adc-chan@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
index 88cf2246c18a..e620001240db 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
@@ -24,7 +24,7 @@ &charger_thermal {
 };
 
 &pm6150_adc {
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ adc-chan@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 6c5287bd27d6..701ec7892b42 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -148,10 +148,11 @@ &pen_insert {
 };
 
 &pm6150_adc {
-	5v-choke-thermistor@4e {
+	adc-chan@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "5v_choke_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 9832e752da35..5eccb7860711 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -168,10 +168,11 @@ ap_ts: touchscreen@1 {
 };
 
 &pm6150_adc {
-	skin-temp-thermistor@4d {
+	adc-chan@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index b82956f8f1cf..3c3031aa0e55 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -820,10 +820,11 @@ &mdss_dp {
 };
 
 &pm6150_adc {
-	charger-thermistor@4f {
+	adc-chan@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "charger_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 650819c028b6..2805a490a6df 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -149,39 +149,44 @@ &pm6125_adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm &rf_pa1_therm>;
 
-	rf-pa0-therm@4d {
+	adc-chan@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "rf_pa0_therm";
 	};
 
-	quiet-therm@4e {
+	adc-chan@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "quiet_therm";
 	};
 
-	camera-flash-therm@52 {
+	adc-chan@52 {
 		reg = <ADC5_GPIO1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "camera_flash_therm";
 	};
 
-	emmc-ufs-therm@54 {
+	adc-chan@54 {
 		reg = <ADC5_GPIO3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "emmc_ufs_therm";
 	};
 
-	rf-pa1-therm@55 {
+	adc-chan@55 {
 		reg = <ADC5_GPIO4_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "rf_pa1_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 3ed8c84e25b8..f4ac617dfab4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -502,22 +502,25 @@ &i2c15 {
 };
 
 &pm8150_adc {
-	xo-therm@4c {
+	adc-chan@4c {
 		reg = <ADC5_XO_THERM_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "xo_therm";
 	};
 
-	skin-therm@4d {
+	adc-chan@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 
-	pa-therm1@4e {
+	adc-chan@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "pa_therm1";
 	};
 };
 
@@ -547,10 +550,11 @@ pa-therm1@2 {
 };
 
 &pm8150b_adc {
-	conn-therm@4f {
+	adc-chan@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "conn_therm";
 	};
 };
 
@@ -591,22 +595,25 @@ pa-therm2@2 {
 };
 
 &pm8150l_adc {
-	camera-flash-therm@4d {
+	adc-chan@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "camera_flash_therm";
 	};
 
-	skin-msm-therm@4e {
+	adc-chan@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_msm_therm";
 	};
 
-	pa-therm2@4f {
+	adc-chan2@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "pa_therm";
 	};
 };
 
-- 
2.38.1

