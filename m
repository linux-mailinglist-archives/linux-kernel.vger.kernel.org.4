Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD56279D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiKNJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiKNJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:58:39 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FCD1EC65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:14 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id x21so12424195ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKRpWEd6SRKdKka600x441uAXe5GcB7KgKP2gi886SA=;
        b=oql4MhYE1uDNSwtF617WVYnjHP8hhWadKWk5RcHd4rCO+pX5jzFxNIJaqoAjdNoUJb
         nsZoQX6Vm67HxOqjc4gje2Bfj7ncEuxx9krJl7/XfyiZJT0sTiic6BsE50fPJyuLOXAJ
         GsDbJdrFctEIXHcYZu3t/j06baygifcnwtq6VNjt4Qi9pQI7rWPXKGmT3/xpzw5HspCp
         JnqDqATwcxj7gKimoNNFlkv0zVroj5Vu+guvzjeo/QNmfWuisNcpkcy9ohMV1qQNpZWY
         n3x0n0AEclanMyjuSqNiTECZyV89hxyxYKIfd+8KclBUmfmIr+09Trr1NMfJ47jkDXPP
         s0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKRpWEd6SRKdKka600x441uAXe5GcB7KgKP2gi886SA=;
        b=nN6eKWLI12HXm9juWjnvbSBbupWytxWhHMG9ej5+9ZBQjpy2wW/3itViSf7eOtYNFz
         ASeUZ1MzlECrRrbKR3oio1ZsBtrfEWdF3DVioubbFtEs3An+v+IZ/UfhgTHrDOHk98Lu
         GQtoDk90nXiTb5nC5+bXTkNmumWjMJCpkxUDF6bY1JPBK7meEUuGDbib++/LG7Th6Go2
         cpMm8BiGmxVdmewsAN64oydULu9LtiMvXv+H7piu4B+eYGxmwxF21sfyi8QoYnVtCZp1
         6exs5tKHMcj/iDyMYuEPjbmMHigVWjN3DQc2VpBGGaiajAx/xPrzkrOtFyM4FY9HeDE4
         tuzw==
X-Gm-Message-State: ANoB5pnbzXWK4VOaoOZb71GdUuoDTo3+8DlRsNAGVMBGMRnABC0iGZw+
        Z85y0wkktmsasYKtPEnRtSeI4Q==
X-Google-Smtp-Source: AA0mqf7birobBN8kc0YSwWcDb044f68rIeuD3trq7xL1ggewMcTW9IeBLw7IrE/7QrPxkhzsx3cmFQ==
X-Received: by 2002:a2e:92d7:0:b0:277:7678:60db with SMTP id k23-20020a2e92d7000000b00277767860dbmr3621798ljh.289.1668419823627;
        Mon, 14 Nov 2022 01:57:03 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id p12-20020a2eb98c000000b00278e7800715sm1832012ljp.16.2022.11.14.01.57.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 01:57:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8450-nagara: Separate out Nagara platform dtsi
Date:   Mon, 14 Nov 2022 10:56:52 +0100
Message-Id: <20221114095654.34561-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114095654.34561-1-konrad.dybcio@linaro.org>
References: <20221114095654.34561-1-konrad.dybcio@linaro.org>
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

Turns out 1 IV is not the only Nagara device, reflect that in the DTS.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes since v1

 .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 602 +----------------
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   | 608 ++++++++++++++++++
 2 files changed, 610 insertions(+), 600 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
index ae8ba297b0b6..3ab145877094 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
@@ -1,612 +1,14 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
  * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Linaro Limited
  */
 
 /dts-v1/;
 
-#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include "sm8450.dtsi"
-
-/delete-node/ &adsp_mem;
-/delete-node/ &rmtfs_mem;
-/delete-node/ &video_mem;
+#include "sm8450-sony-xperia-nagara.dtsi"
 
 / {
 	model = "Sony Xperia 1 IV";
 	compatible = "sony,pdx223", "qcom,sm8450";
-	chassis-type = "handset";
-
-	aliases {
-		serial0 = &uart7;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	reserved-memory {
-		adsp_mem: memory@85700000 {
-			reg = <0x0 0x85700000 0x0 0x2800000>;
-			no-map;
-		};
-
-		video_mem: memory@9fd00000 {
-			reg = <0x0 0x9fd00000 0x0 0x700000>;
-			no-map;
-		};
-
-		rmtfs_mem: memory@f3300000 {
-			compatible = "qcom,rmtfs-mem";
-			reg = <0x0 0xf3300000 0x0 0x280000>;
-			no-map;
-
-			qcom,client-id = <1>;
-			qcom,vmid = <15>;
-		};
-
-		ramoops@ffc00000 {
-			compatible = "ramoops";
-			reg = <0 0xffc00000 0 0x200000>;
-			console-size = <0x40000>;
-			record-size = <0x1000>;
-			ecc-size = <16>;
-			no-map;
-		};
-	};
-
-	/* Sadly, the voltages for these GPIO regulators are unknown. */
-	imx650_vana_vreg: imx650-vana-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "imx650_vana_vreg";
-		gpio = <&tlmm 23 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vph_pwr: vph-pwr-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vph_pwr";
-		regulator-min-microvolt = <3700000>;
-		regulator-max-microvolt = <3700000>;
-
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&apps_rsc {
-	pm8350-rpmh-regulators {
-		compatible = "qcom,pm8350-rpmh-regulators";
-		qcom,pmic-id = "b";
-
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-supply = <&vph_pwr>;
-		vdd-s4-supply = <&vph_pwr>;
-		vdd-s5-supply = <&vph_pwr>;
-		vdd-s6-supply = <&vph_pwr>;
-		vdd-s7-supply = <&vph_pwr>;
-		vdd-s8-supply = <&vph_pwr>;
-		vdd-s9-supply = <&vph_pwr>;
-		vdd-s10-supply = <&vph_pwr>;
-		vdd-s11-supply = <&vph_pwr>;
-		vdd-s12-supply = <&vph_pwr>;
-
-		vdd-l1-l4-supply = <&pm8350_s11>;
-		vdd-l2-l7-supply = <&vreg_bob>;
-		vdd-l3-l5-supply = <&vreg_bob>;
-		vdd-l6-l9-l10-supply = <&pm8350_s12>;
-
-		/*
-		 * ARC regulators:
-		 * s5 - gfx.lvl
-		 * l8 - lcx.lvl
-		 */
-
-		pm8350_s10: smps10 {
-			regulator-name = "pm8350_s10";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8350_s11: smps11 {
-			regulator-name = "pm8350_s11";
-			regulator-min-microvolt = <848000>;
-			regulator-max-microvolt = <1104000>;
-		};
-
-		pm8350_s12: smps12 {
-			regulator-name = "pm8350_s12";
-			regulator-min-microvolt = <1224000>;
-			regulator-max-microvolt = <1400000>;
-		};
-
-		pm8350_l1: ldo1 {
-			regulator-name = "pm8350_l1";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <920000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350_l2: ldo2 {
-			regulator-name = "pm8350_l2";
-			regulator-min-microvolt = <3072000>;
-			regulator-max-microvolt = <3072000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350_l3: ldo3 {
-			regulator-name = "pm8350_l3";
-			regulator-min-microvolt = <904000>;
-			regulator-max-microvolt = <904000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350_l5: ldo5 {
-			regulator-name = "pm8350_l5";
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350_l6: ldo6 {
-			regulator-name = "pm8350_l6";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350_l7: ldo7 {
-			regulator-name = "pm8350_l7";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <2504000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350_l9: ldo9 {
-			regulator-name = "pm8350_l9";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-	};
-
-	pm8350c-rpmh-regulators {
-		compatible = "qcom,pm8350c-rpmh-regulators";
-		qcom,pmic-id = "c";
-
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-supply = <&vph_pwr>;
-		vdd-s4-supply = <&vph_pwr>;
-		vdd-s5-supply = <&vph_pwr>;
-		vdd-s6-supply = <&vph_pwr>;
-		vdd-s7-supply = <&vph_pwr>;
-		vdd-s8-supply = <&vph_pwr>;
-		vdd-s9-supply = <&vph_pwr>;
-		vdd-s10-supply = <&vph_pwr>;
-
-		vdd-l1-l12-supply = <&vreg_bob>;
-		vdd-l2-l8-supply = <&vreg_bob>;
-		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
-		vdd-l6-l9-l11-supply = <&vreg_bob>;
-		vdd-l10-supply = <&pm8350_s12>;
-
-		vdd-bob-supply = <&vph_pwr>;
-
-		/*
-		 * ARC regulators:
-		 * s2 - mxc.lvl
-		 * s4 - mss.lvl
-		 * s6 - cx.lvl
-		 */
-
-		pm8350c_s1: smps1 {
-			regulator-name = "pm8350c_s1";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2024000>;
-		};
-
-		pm8350c_s10: smps10 {
-			regulator-name = "pm8350c_s10";
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1100000>;
-		};
-
-		vreg_bob: bob {
-			regulator-name = "vreg_bob";
-			regulator-min-microvolt = <3400000>;
-			regulator-max-microvolt = <3960000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
-		};
-
-		pm8350c_l1: ldo1 {
-			regulator-name = "pm8350c_l1";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l2: ldo2 {
-			regulator-name = "pm8350c_l2";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l3: ldo3 {
-			regulator-name = "pm8350c_l3";
-			regulator-min-microvolt = <3296000>;
-			regulator-max-microvolt = <3304000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l4: ldo4 {
-			regulator-name = "pm8350c_l4";
-			regulator-min-microvolt = <1704000>;
-			regulator-max-microvolt = <3000000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l5: ldo5 {
-			regulator-name = "pm8350c_l5";
-			regulator-min-microvolt = <1704000>;
-			regulator-max-microvolt = <3000000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l6: ldo6 {
-			regulator-name = "pm8350c_l6";
-			regulator-min-microvolt = <2960000>;
-			/* Originally max = 3008000 but SDHCI expects 2960000 */
-			regulator-max-microvolt = <2960000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l7: ldo7 {
-			regulator-name = "pm8350c_l7";
-			regulator-min-microvolt = <3008000>;
-			regulator-max-microvolt = <3008000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l8: ldo8 {
-			regulator-name = "pm8350c_l8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l9: ldo9 {
-			regulator-name = "pm8350c_l9";
-			regulator-min-microvolt = <2960000>;
-			/* Originally max = 3008000 but SDHCI expects 2960000 */
-			regulator-max-microvolt = <2960000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l10: ldo10 {
-			regulator-name = "pm8350c_l10";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l12: ldo12 {
-			regulator-name = "pm8350c_l12";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1968000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8350c_l13: ldo13 {
-			regulator-name = "pm8350c_l13";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-	};
-
-	pm8450-rpmh-regulators {
-		compatible = "qcom,pm8450-rpmh-regulators";
-		qcom,pmic-id = "h";
-
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-supply = <&vph_pwr>;
-		vdd-s4-supply = <&vph_pwr>;
-		vdd-s5-supply = <&vph_pwr>;
-		vdd-s6-supply = <&vph_pwr>;
-
-		vdd-l2-supply = <&vreg_bob>;
-		vdd-l3-supply = <&vreg_bob>;
-		vdd-l4-supply = <&vreg_bob>;
-
-		/*
-		 * ARC regulators:
-		 * S2 - ebi.lvl
-		 * S4 - mmcx.lvl
-		 * S6 - mx.lvl
-		 * L1 - lmx.lvl
-		 */
-
-		pm8450_s3: smps3 {
-			regulator-name = "pm8450_s3";
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <600000>;
-		};
-
-		pm8450_l2: ldo2 {
-			regulator-name = "pm8450_l2";
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		pm8450_l3: ldo3 {
-			regulator-name = "pm8450_l3";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-	};
-
-	pmr735a-rpmh-regulators {
-		compatible = "qcom,pmr735a-rpmh-regulators";
-		qcom,pmic-id = "e";
-
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-supply = <&vph_pwr>;
-
-		vdd-l1-l2-supply = <&pmr735a_s2>;
-		vdd-l3-supply = <&pmr735a_s1>;
-		vdd-l4-supply = <&pm8350c_s1>;
-		vdd-l5-l6-supply = <&pm8350c_s1>;
-		vdd-l7-bob-supply = <&vreg_bob>;
-
-		pmr735a_s1: smps1 {
-			regulator-name = "pmr735a_s1";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1296000>;
-		};
-
-		pmr735a_s2: smps2 {
-			regulator-name = "pmr735a_s2";
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1040000>;
-		};
-
-		pmr735a_s3: smps3 {
-			regulator-name = "pmr735a_s3";
-			regulator-min-microvolt = <435000>;
-			regulator-max-microvolt = <2352000>;
-		};
-
-		pmr735a_l1: ldo1 {
-			regulator-name = "pmr735a_l1";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-		};
-
-		pmr735a_l2: ldo2 {
-			regulator-name = "pmr735a_l2";
-			regulator-min-microvolt = <480000>;
-			regulator-max-microvolt = <912000>;
-		};
-
-		pmr735a_l3: ldo3 {
-			regulator-name = "pmr735a_l3";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pmr735a_l4: ldo4 {
-			regulator-name = "pmr735a_l4";
-			regulator-min-microvolt = <1776000>;
-			regulator-max-microvolt = <1776000>;
-		};
-
-		pmr735a_l5: ldo5 {
-			regulator-name = "pmr735a_l5";
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <880000>;
-		};
-
-		pmr735a_l6: ldo6 {
-			regulator-name = "pmr735a_l6";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pmr735a_l7: ldo7 {
-			regulator-name = "pmr735a_l7";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-		};
-	};
-};
-
-&gpi_dma0 {
-	status = "okay";
-};
-
-&gpi_dma1 {
-	status = "okay";
-};
-
-&gpi_dma2 {
-	status = "okay";
-};
-
-/* I2C4 is used, it hosts a Samsung touchscreen, but GPI DMA is broken.. */
-
-&i2c5 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	/* Dialog SLG51000 CMIC @ 75 */
-};
-
-&i2c9 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	/* NXP SN1X0 NFC @ 28 */
-};
-
-&i2c13 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	/* Richwave RTC6226 FM Radio Receiver @ 64 */
-};
-
-&i2c14 {
-	clock-frequency = <1000000>;
-	status = "okay";
-
-	cs35l41_l: speaker-amp@40 {
-		compatible = "cirrus,cs35l41";
-		reg = <0x40>;
-		interrupt-parent = <&tlmm>;
-		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
-		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
-		cirrus,boost-peak-milliamp = <4000>;
-		cirrus,boost-ind-nanohenry = <1000>;
-		cirrus,boost-cap-microfarad = <15>;
-		cirrus,gpio2-src-select = <2>;
-		cirrus,gpio2-output-enable;
-		cirrus,asp-sdout-hiz = <3>;
-		#sound-dai-cells = <1>;
-	};
-
-	cs35l41_r: speaker-amp@41 {
-		compatible = "cirrus,cs35l41";
-		reg = <0x41>;
-		interrupt-parent = <&tlmm>;
-		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
-		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
-		cirrus,boost-peak-milliamp = <4000>;
-		cirrus,boost-ind-nanohenry = <1000>;
-		cirrus,boost-cap-microfarad = <15>;
-		cirrus,gpio2-src-select = <2>;
-		cirrus,gpio2-output-enable;
-		cirrus,asp-sdout-hiz = <3>;
-		#sound-dai-cells = <1>;
-	};
-};
-
-&i2c15 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	/* AMS TCS3490 RGB+IR color sensor @ 72 */
-};
-
-&i2c19 {
-	clock-frequency = <1000000>;
-	status = "okay";
-
-	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
-};
-
-&pcie0 {
-	max-link-speed = <2>;
-	status = "okay";
-};
-
-&pcie0_phy {
-	vdda-phy-supply = <&pm8350_l5>;
-	vdda-pll-supply = <&pm8350_l6>;
-	status = "okay";
-};
-
-&remoteproc_adsp {
-	firmware-name = "qcom/sm8350/Sony/nagara/adsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_cdsp {
-	firmware-name = "qcom/sm8350/Sony/nagara/cdsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_slpi {
-	firmware-name = "qcom/sm8350/Sony/nagara/slpi.mbn";
-	status = "okay";
-};
-
-&qupv3_id_0 {
-	status = "okay";
-};
-
-&qupv3_id_1 {
-	status = "okay";
-};
-
-&qupv3_id_2 {
-	status = "okay";
-};
-
-&sdhc_2 {
-	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
-	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
-	vmmc-supply = <&pm8350c_l9>;
-	vqmmc-supply = <&pm8350c_l6>;
-	no-sdio;
-	no-mmc;
-	status = "okay";
-};
-
-&spi10 {
-	status = "okay";
-
-	/* NXP SN1X0 NFC Secure Element @ 0 */
-};
-
-&tlmm {
-	gpio-reserved-ranges = <28 4>;
-
-	ts_int_default: ts-int-default-state {
-		pins = "gpio23";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-		input-enable;
-	};
-
-	sdc2_card_det_n: sd-card-det-n-state {
-		pins = "gpio92";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
-};
-
-&uart7 {
-	status = "okay";
-};
-
-&usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	dr_mode = "peripheral";
-};
-
-&usb_1_hsphy {
-	vdda-pll-supply = <&pm8350_l5>;
-	vdda18-supply = <&pm8350c_l1>;
-	vdda33-supply = <&pm8350_l2>;
-	status = "okay";
-};
-
-&usb_1_qmpphy {
-	vdda-phy-supply = <&pm8350_l6>;
-	vdda-pll-supply = <&pm8350_l1>;
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
new file mode 100644
index 000000000000..0d8d1519a23b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8450.dtsi"
+
+/delete-node/ &adsp_mem;
+/delete-node/ &rmtfs_mem;
+/delete-node/ &video_mem;
+
+/ {
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		adsp_mem: memory@85700000 {
+			reg = <0x0 0x85700000 0x0 0x2800000>;
+			no-map;
+		};
+
+		video_mem: memory@9fd00000 {
+			reg = <0x0 0x9fd00000 0x0 0x700000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@f3300000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xf3300000 0x0 0x280000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		ramoops@ffc00000 {
+			compatible = "ramoops";
+			reg = <0 0xffc00000 0 0x200000>;
+			console-size = <0x40000>;
+			record-size = <0x1000>;
+			ecc-size = <16>;
+			no-map;
+		};
+	};
+
+	/* Sadly, the voltages for these GPIO regulators are unknown. */
+	imx650_vana_vreg: imx650-vana-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "imx650_vana_vreg";
+		gpio = <&tlmm 23 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&apps_rsc {
+	pm8350-rpmh-regulators {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-s11-supply = <&vph_pwr>;
+		vdd-s12-supply = <&vph_pwr>;
+
+		vdd-l1-l4-supply = <&pm8350_s11>;
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_bob>;
+		vdd-l6-l9-l10-supply = <&pm8350_s12>;
+
+		/*
+		 * ARC regulators:
+		 * s5 - gfx.lvl
+		 * l8 - lcx.lvl
+		 */
+
+		pm8350_s10: smps10 {
+			regulator-name = "pm8350_s10";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8350_s11: smps11 {
+			regulator-name = "pm8350_s11";
+			regulator-min-microvolt = <848000>;
+			regulator-max-microvolt = <1104000>;
+		};
+
+		pm8350_s12: smps12 {
+			regulator-name = "pm8350_s12";
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1400000>;
+		};
+
+		pm8350_l1: ldo1 {
+			regulator-name = "pm8350_l1";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l2: ldo2 {
+			regulator-name = "pm8350_l2";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l3: ldo3 {
+			regulator-name = "pm8350_l3";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l5: ldo5 {
+			regulator-name = "pm8350_l5";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l6: ldo6 {
+			regulator-name = "pm8350_l6";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l7: ldo7 {
+			regulator-name = "pm8350_l7";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l9: ldo9 {
+			regulator-name = "pm8350_l9";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pm8350c-rpmh-regulators {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l12-supply = <&vreg_bob>;
+		vdd-l2-l8-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
+		vdd-l6-l9-l11-supply = <&vreg_bob>;
+		vdd-l10-supply = <&pm8350_s12>;
+
+		vdd-bob-supply = <&vph_pwr>;
+
+		/*
+		 * ARC regulators:
+		 * s2 - mxc.lvl
+		 * s4 - mss.lvl
+		 * s6 - cx.lvl
+		 */
+
+		pm8350c_s1: smps1 {
+			regulator-name = "pm8350c_s1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2024000>;
+		};
+
+		pm8350c_s10: smps10 {
+			regulator-name = "pm8350c_s10";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3400000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		pm8350c_l1: ldo1 {
+			regulator-name = "pm8350c_l1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l2: ldo2 {
+			regulator-name = "pm8350c_l2";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l3: ldo3 {
+			regulator-name = "pm8350c_l3";
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l4: ldo4 {
+			regulator-name = "pm8350c_l4";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l5: ldo5 {
+			regulator-name = "pm8350c_l5";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l6: ldo6 {
+			regulator-name = "pm8350c_l6";
+			regulator-min-microvolt = <2960000>;
+			/* Originally max = 3008000 but SDHCI expects 2960000 */
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l7: ldo7 {
+			regulator-name = "pm8350c_l7";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l8: ldo8 {
+			regulator-name = "pm8350c_l8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l9: ldo9 {
+			regulator-name = "pm8350c_l9";
+			regulator-min-microvolt = <2960000>;
+			/* Originally max = 3008000 but SDHCI expects 2960000 */
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l10: ldo10 {
+			regulator-name = "pm8350c_l10";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l12: ldo12 {
+			regulator-name = "pm8350c_l12";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1968000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l13: ldo13 {
+			regulator-name = "pm8350c_l13";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pm8450-rpmh-regulators {
+		compatible = "qcom,pm8450-rpmh-regulators";
+		qcom,pmic-id = "h";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+
+		vdd-l2-supply = <&vreg_bob>;
+		vdd-l3-supply = <&vreg_bob>;
+		vdd-l4-supply = <&vreg_bob>;
+
+		/*
+		 * ARC regulators:
+		 * S2 - ebi.lvl
+		 * S4 - mmcx.lvl
+		 * S6 - mx.lvl
+		 * L1 - lmx.lvl
+		 */
+
+		pm8450_s3: smps3 {
+			regulator-name = "pm8450_s3";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <600000>;
+		};
+
+		pm8450_l2: ldo2 {
+			regulator-name = "pm8450_l2";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8450_l3: ldo3 {
+			regulator-name = "pm8450_l3";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pmr735a-rpmh-regulators {
+		compatible = "qcom,pmr735a-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+
+		vdd-l1-l2-supply = <&pmr735a_s2>;
+		vdd-l3-supply = <&pmr735a_s1>;
+		vdd-l4-supply = <&pm8350c_s1>;
+		vdd-l5-l6-supply = <&pm8350c_s1>;
+		vdd-l7-bob-supply = <&vreg_bob>;
+
+		pmr735a_s1: smps1 {
+			regulator-name = "pmr735a_s1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1296000>;
+		};
+
+		pmr735a_s2: smps2 {
+			regulator-name = "pmr735a_s2";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1040000>;
+		};
+
+		pmr735a_s3: smps3 {
+			regulator-name = "pmr735a_s3";
+			regulator-min-microvolt = <435000>;
+			regulator-max-microvolt = <2352000>;
+		};
+
+		pmr735a_l1: ldo1 {
+			regulator-name = "pmr735a_l1";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		pmr735a_l2: ldo2 {
+			regulator-name = "pmr735a_l2";
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <912000>;
+		};
+
+		pmr735a_l3: ldo3 {
+			regulator-name = "pmr735a_l3";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l4: ldo4 {
+			regulator-name = "pmr735a_l4";
+			regulator-min-microvolt = <1776000>;
+			regulator-max-microvolt = <1776000>;
+		};
+
+		pmr735a_l5: ldo5 {
+			regulator-name = "pmr735a_l5";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+		};
+
+		pmr735a_l6: ldo6 {
+			regulator-name = "pmr735a_l6";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l7: ldo7 {
+			regulator-name = "pmr735a_l7";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+	};
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
+/* I2C4 is used, it hosts a Samsung touchscreen, but GPI DMA is broken.. */
+
+&i2c5 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Dialog SLG51000 CMIC @ 75 */
+};
+
+&i2c9 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* NXP SN1X0 NFC @ 28 */
+};
+
+&i2c13 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Richwave RTC6226 FM Radio Receiver @ 64 */
+};
+
+&i2c14 {
+	clock-frequency = <1000000>;
+	status = "okay";
+
+	cs35l41_l: speaker-amp@40 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x40>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,gpio2-src-select = <2>;
+		cirrus,gpio2-output-enable;
+		cirrus,asp-sdout-hiz = <3>;
+		#sound-dai-cells = <1>;
+	};
+
+	cs35l41_r: speaker-amp@41 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x41>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,gpio2-src-select = <2>;
+		cirrus,gpio2-output-enable;
+		cirrus,asp-sdout-hiz = <3>;
+		#sound-dai-cells = <1>;
+	};
+};
+
+&i2c15 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* AMS TCS3490 RGB+IR color sensor @ 72 */
+};
+
+&i2c19 {
+	clock-frequency = <1000000>;
+	status = "okay";
+
+	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
+};
+
+&pcie0 {
+	max-link-speed = <2>;
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&pm8350_l5>;
+	vdda-pll-supply = <&pm8350_l6>;
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sm8350/Sony/nagara/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8350/Sony/nagara/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_slpi {
+	firmware-name = "qcom/sm8350/Sony/nagara/slpi.mbn";
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
+	vmmc-supply = <&pm8350c_l9>;
+	vqmmc-supply = <&pm8350c_l6>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+&spi10 {
+	status = "okay";
+
+	/* NXP SN1X0 NFC Secure Element @ 0 */
+};
+
+&tlmm {
+	gpio-reserved-ranges = <28 4>;
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio23";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&pm8350_l5>;
+	vdda18-supply = <&pm8350c_l1>;
+	vdda33-supply = <&pm8350_l2>;
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&pm8350_l6>;
+	vdda-pll-supply = <&pm8350_l1>;
+	status = "okay";
+};
-- 
2.38.1

