Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE36BA130
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCNVJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCNVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:09:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7846177
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:09:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u5so17966945plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678828140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOEu3t4L9ULqr83vHX2NhmL+oG7KJxneL5TZLVIC1mc=;
        b=e/M+QikCwdrp85mvAbBkI9ECPq+QgpK/WV4AtcQFTGf9RhW7FgsOunY7gGeb3XZqn9
         zrZX4dEUbkReJ1PBHAfOqKlQ33OIlOMsEngAIS37aJfscTAEwybr/vo/RQde6SkK/CVf
         1kMztF4MXGQjuXX2dk2DHp/C2eq8Qmix6C7HYBBgezpi5XhZHCuPxfJy3n7scRIfdtBw
         vu4vVmAdk2ZHPv0Uf//F8XIeU5B2Lp75Mkbbu4VJMBUlW3J1+TIasnv97mrMgRW5mtwv
         ovdWI4y5vE4I2zq7PNRabtso7gjhz73dmEiKN8RNEjsb4QEL28bM1+721BvLQTGyf5nk
         MeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678828140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOEu3t4L9ULqr83vHX2NhmL+oG7KJxneL5TZLVIC1mc=;
        b=xuZqppoKfPp8h1twxDnFVvkgr3ptCxjThlZkcNyxnU/lWyZThetGGPcX6fTDYAq0Qm
         joDGi2PExW02EJFO2aJ4NElj509Lb6zxAh7ra/yDtlZU5/S9plCpjRfTIao1i4et7yO/
         iQGahHxup9Li+gm4u24sZ8BYY352/nSR8tM2Eg1ASv33RZgGz/N9s9cASKqn3V8OlxYy
         k7jRqF4RhqwjDzy/8X401MVj34m9srOpluuzSSRgE3UEiE2/rB9MKeVlM6yXo7/WiF2U
         vnc2maXtjzQFe8rF7IPtoCSnHiBy9lQiSmj25lcF+YeqKu+7sMXpH1KR1jvFFQZ6ct5/
         qOJg==
X-Gm-Message-State: AO0yUKUrbeT21rHhKp7Ro6bAGWhQMDnW9aNAxyyB4b6AkxHxyXf9HzI0
        mk8QpGM09jXMCqtBf5xxgS+Xkg==
X-Google-Smtp-Source: AK7set9/psM5x7wx9DEhBdAjDqNq+oNCJZqoVe0nSWBGE0cpdQ0Z74Rih2B54yMDw1Sr0qnFJbPXYQ==
X-Received: by 2002:a17:902:f68c:b0:19e:5cc3:8289 with SMTP id l12-20020a170902f68c00b0019e5cc38289mr415360plg.34.1678828140397;
        Tue, 14 Mar 2023 14:09:00 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:1acb:9af6:bd7f:78e7:7ae6])
        by smtp.gmail.com with ESMTPSA id kl8-20020a170903074800b0019edc1b421asm2190150plb.163.2023.03.14.14.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:08:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH 2/2] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Date:   Wed, 15 Mar 2023 02:38:28 +0530
Message-Id: <20230314210828.2049720-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314210828.2049720-1-bhupesh.sharma@linaro.org>
References: <20230314210828.2049720-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.

This adds debug uart, emmc, uSD and tlmm support along with
regulators found on this board.

Also defines the 'xo_board' and 'sleep_clk' frequencies for
this board.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile        |   1 +
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 227 +++++++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 31aa54f0428c..23522778b5b9 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -69,6 +69,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
new file mode 100644
index 000000000000..ed569c3f1c80
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm4250.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
+	compatible = "qcom,qrb4210-rb2", "qcom,sm4250";
+
+	aliases {
+		serial0 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
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
+&xo_board {
+	clock-frequency = <19200000>;
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
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
+		vdd-l1-l7-l17-l18-supply = <&vreg_s6a_1p352>;
+		vdd-l2-l3-l4-supply = <&vreg_s6a_1p352>;
+		vdd-l5-l15-l19-l20-l21-l22-supply = <&vph_pwr>;
+		vdd-l6-l8-supply = <&vreg_s5a_0p848>;
+		vdd-l9-l11-supply = <&vreg_s7a_2p04>;
+		vdd-l10-l13-l14-supply = <&vreg_s7a_2p04>;
+		vdd-l12-l16-supply = <&vreg_s7a_2p04>;
+		vdd-l23-l24-supply = <&vph_pwr>;
+
+		vreg_s5a_0p848: s5 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_s6a_1p352: s6 {
+			regulator-min-microvolt = <304000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		vreg_s7a_2p04: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2080000>;
+		};
+
+		vreg_l1a_1p0: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		vreg_l4a_0p9: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a_2p96: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		vreg_l6a_0p6: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		vreg_l7a_1p256: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l8a_0p664: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l10a_1p8: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l11a_1p8: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l12a_1p8: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		vreg_l13a_1p8: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l14a_1p8: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l15a_3p128: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		vreg_l16a_1p3: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l17a_1p3: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1384000>;
+		};
+
+		vreg_l18a_1p232: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1312000>;
+		};
+
+		vreg_l19a_1p8: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l20a_1p8: l20 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l21a_2p704: l21 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l22a_2p96: l22 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l23a_3p3: l23 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l24a_2p96: l24 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
+			       <49 1>, <52 1>, <54 1>,
+			       <56 3>, <61 2>, <64 1>,
+			       <68 1>, <72 8>, <96 1>;
+};
+
+&sdhc_1 {
+	status = "okay";
+
+	vmmc-supply = <&vreg_l24a_2p96>; /* emmc power line */
+	vqmmc-supply = <&vreg_l11a_1p8>; /* emmc vddq */
+	bus-width = <8>;
+	no-sdio;
+	non-removable;
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
+	vmmc-supply = <&vreg_l22a_2p96>; /* Card power line */
+	vqmmc-supply = <&vreg_l5a_2p96>; /* IO line power */
+	bus-width = <4>;
+	no-sdio;
+	no-emmc;
+};
-- 
2.38.1

