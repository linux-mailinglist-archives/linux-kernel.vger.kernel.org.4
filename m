Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE0624DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKJWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiKJWpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:45:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061249B49
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:45:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p8so5745266lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zHuN6/ooLjXtRGVz1R90Q+fqFIZs4Xcje8w7qmCFzQ=;
        b=TqvnnNl/jAC1RbnCNoVZ+UzFxNVqh3N2spjm4ZGFu0anV/+jQIFTdHHRDG35FaDCYl
         UHBaj+xjXVruAzipw7gsJQRnXB2ETvc8M7zeWIITeem37g8ksy1YSvuAVN2/D//j+lM5
         kqmzojLoma3p4dHp5zPNFzxpwwiOvrnSzXMN0hOvTElw5qAPvxYfniqbV/V8/FKzT6c1
         QTWUrpL02ywgDjqsWA0mZYXwXBTNlgE2Vh2mAnVpo6Bb3IGJSJ9Sv+Q5uoyadZKwq8KR
         SyS3fu0hJuIKcdaFxvn0p+oWumIZ9+ZwjctK/nYi+ji2PHO2Dwnc37QkDD6RIPK4skqc
         tQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zHuN6/ooLjXtRGVz1R90Q+fqFIZs4Xcje8w7qmCFzQ=;
        b=paEgfhoeuZIW/8eBG6a7VdpYRHkyuveXoK7v1W7DMG4gaGQKkP3APls5FXSyk8hBq4
         prk1s9LSjv0p0JVRkpPGLhcOVPZNeaCTbsL8qi9XFL21jsNcMtttTe/T95pHzwrZq1/O
         zRH+1M26e355dh245ljBzpi+uzt8aD4N81Vyo9W7tuO+l1fURFjbz5596Id+UxOW5gRv
         6ln+4LMZDCyyRZeS4VvfiVj9moFJFk6hLW2R8ATHiKCC8xj1ZNFDKdtsl4PqNxtZJUBE
         LMj9TOGWtWyTGfka6mpSUUpdW2I0kcAEqj43jVuR5g8ytxBhLom2hsbCABg32X0uuX3s
         tpqQ==
X-Gm-Message-State: ACrzQf2nS5+QxR/6GsCy2x+AlrggtZK4qgBIz7iCbiHWvws8QiPeDYMU
        z/V4q85Lz0sqmmniQ1QNJVyv/A==
X-Google-Smtp-Source: AMsMyM5IBdvyo3slNMhsLDDhgr/xCWr8Jo2pPxPz/sPtdp5q1/URYidrPhIaziqvRg2B82zBUrSYXw==
X-Received: by 2002:a05:6512:11ec:b0:4a2:4eba:3de0 with SMTP id p12-20020a05651211ec00b004a24eba3de0mr2216715lfs.633.1668120347987;
        Thu, 10 Nov 2022 14:45:47 -0800 (PST)
Received: from localhost.localdomain (95.49.32.193.neoplus.adsl.tpnet.pl. [95.49.32.193])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651239c400b0048a934168c0sm55315lfu.35.2022.11.10.14.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:45:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sm8450-nagara: Separate out Nagara platform dtsi
Date:   Thu, 10 Nov 2022 23:39:27 +0100
Message-Id: <20221110223929.134655-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110223929.134655-1-konrad.dybcio@linaro.org>
References: <20221110223929.134655-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out 1 IV is not the only Nagara device, reflect that in the DTS.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
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

