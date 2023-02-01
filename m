Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CDD687001
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBAUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBAUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:45:26 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601D761CE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:45:00 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2500620390;
        Wed,  1 Feb 2023 21:44:58 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: dts: qcom: Use labels with generic node names for ADC channels
Date:   Wed,  1 Feb 2023 21:44:45 +0100
Message-Id: <20230201204447.542385-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201204447.542385-1-marijn.suijten@somainline.org>
References: <20230201204447.542385-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in [1] it is more convenient to use a generic adc-chan node
name for ADC channels while storing a friendly - board-specific instead
of PMIC-specific - name in the label, if/when desired to overwrite the
channel description already contained (but previously unused) in the
driver [2].  Follow up on the dt-bindings adc-chan node name
requirement, and instead provide this (sometimes per-board) channel
description through a label property.

Also remove all the unused label references (not to be confused with
label properties) from pm660, pmp8074 and pms405.

[1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
[2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6125.dtsi          | 18 ++++++---
 arch/arm64/boot/dts/qcom/pm660.dtsi           | 33 ++++++++++------
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |  6 +--
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  8 ++--
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  6 +--
 arch/arm64/boot/dts/qcom/pm8950.dtsi          | 39 ++++++++++++-------
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  6 +--
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  6 +--
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         | 27 ++++++++-----
 arch/arm64/boot/dts/qcom/pms405.dtsi          | 21 ++++++----
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  4 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 39 ++++++++++++-------
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 ++++---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 21 ++++++----
 26 files changed, 187 insertions(+), 106 deletions(-)

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
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index db90c55fa2cf..ba145699eac5 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -90,19 +90,19 @@ pm8150_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
-			ref-gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 66752cc063d6..f413651d07e4 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -76,25 +76,25 @@ pm8150b_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
-			ref-gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
 			};
 
-			chg-temp@9 {
+			adc-chan@9 {
 				reg = <ADC5_CHG_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "chg_temp";
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 135bfb8d629b..7c46c6d454d0 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -70,19 +70,19 @@ pm8150l_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
-			ref-gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index 5ec38b7e335a..054c783166fa 100644
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
 
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index ee1e428d3a6e..c32ccb1105db 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -77,19 +77,19 @@ pmm8155au_1_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
-			ref-gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
index 1da4606e8ee6..98bbfec06d0b 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
@@ -69,19 +69,19 @@ pmm8155au_2_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
-			ref-gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
index 580684411d74..9c98c284182c 100644
--- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -18,57 +18,66 @@ pmp8074_adc: adc@3100 {
 			#size-cells = <0>;
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
 
-			vref-vadc@2 {
+			adc-chan@2 {
 				reg = <ADC5_VREF_VADC>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_vadc";
 			};
 
-			pmic_die: die-temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "pmic_die";
 			};
 
-			xo_therm: xo-temp@76 {
+			adc-chan@76 {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "xo_therm";
 			};
 
-			pa_therm1: thermistor1@77 {
+			adc-chan@77 {
 				reg = <ADC5_AMUX_THM1_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm1";
 			};
 
-			pa_therm2: thermistor2@78 {
+			adc-chan@78 {
 				reg = <ADC5_AMUX_THM2_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm2";
 			};
 
-			pa_therm3: thermistor3@79 {
+			adc-chan@79 {
 				reg = <ADC5_AMUX_THM3_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm3";
 			};
 
-			vph-pwr@131 {
+			adc-chan@131 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 22edb47c6a84..9f7ceafd1e50 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -81,45 +81,52 @@ pms405_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			ref_gnd@0 {
+			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
 			};
 
-			vref_1p25@1 {
+			adc-chan@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
 			};
 
-			pon_1: vph_pwr@131 {
+			adc-chan@131 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 
-			die_temp@6 {
+			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			pa_therm1: thermistor1@77 {
+			adc-chan@77 {
 				reg = <ADC5_AMUX_THM1_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm1";
 			};
 
-			pa_therm3: thermistor3@79 {
+			adc-chan@79 {
 				reg = <ADC5_AMUX_THM3_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm3";
 			};
 
-			xo_therm: xo_temp@76 {
+			adc-chan@76 {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "xo_therm";
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
index b3ba23a88a0b..9df8114e1183 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -145,10 +145,11 @@ &panel {
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
index dcb179b2a3fb..59a3945ed792 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -830,10 +830,11 @@ &mdss_dp_out {
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
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index ba64316b4427..4b901dde2adb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -73,7 +73,7 @@ &nvme_3v3_regulator {
 };
 
 &pmk8350_vadc {
-	pmr735a-die-temp@403 {
+	adc-chan@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 		qcom,pre-scaling = <1 1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 43e61a1aa779..8642651ae1d0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -436,7 +436,7 @@ &pcie1_phy {
 };
 
 &pmk8350_vadc {
-	pmk8350-die-temp@3 {
+	adc-chan@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index cd6ee84b36fd..b0142394a716 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -382,13 +382,13 @@ &pm8350c_pwm {
 };
 
 &pmk8350_vadc {
-	pmk8350-die-temp@3 {
+	adc-chan@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
 
-	pmr735a-die-temp@403 {
+	adc-chan@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 		qcom,pre-scaling = <1 1>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f936b020a71d..5023338a8b8f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -633,78 +633,91 @@ &pmk8280_pon_resin {
 &pmk8280_vadc {
 	status = "okay";
 
-	pmic-die-temp@3 {
+	adc-chan@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
 		qcom,pre-scaling = <1 1>;
+		label = "pmic_die_temp";
 	};
 
-	xo-therm@44 {
+	adc-chan@44 {
 		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "xo_therm";
 	};
 
-	pmic-die-temp@103 {
+	adc-chan@103 {
 		reg = <PM8350_ADC7_DIE_TEMP(1)>;
 		qcom,pre-scaling = <1 1>;
+		label = "pmic_die_temp";
 	};
 
-	sys-therm@144 {
+	adc-chan@144 {
 		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	sys-therm@145 {
+	adc-chan@145 {
 		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	sys-therm@146 {
+	adc-chan@146 {
 		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	sys-therm@147 {
+	adc-chan@147 {
 		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	pmic-die-temp@303 {
+	adc-chan@303 {
 		reg = <PM8350_ADC7_DIE_TEMP(3)>;
 		qcom,pre-scaling = <1 1>;
+		label = "pmic_die_temp";
 	};
 
-	sys-therm@344 {
+	adc-chan@344 {
 		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	sys-therm@345 {
+	adc-chan@345 {
 		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	sys-therm@346 {
+	adc-chan@346 {
 		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	sys-therm@347 {
+	adc-chan@347 {
 		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
+		label = "sys_therm";
 	};
 
-	pmic-die-temp@403 {
+	adc-chan@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		qcom,pre-scaling = <1 1>;
+		label = "pmic_die_temp";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 5b26389b8e72..44eb8cdd1534 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -242,39 +242,44 @@ &pm6125_adc {
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
index 0991b34a8e49..96dfb00173e3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -525,22 +525,25 @@ &i2c15 {
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
 
@@ -570,10 +573,11 @@ pa-therm1@2 {
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
 
@@ -614,22 +618,25 @@ pa-therm2@2 {
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
+	adc-chan@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "pa_therm2";
 	};
 };
 
-- 
2.39.1

