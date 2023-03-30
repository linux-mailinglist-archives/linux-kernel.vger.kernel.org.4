Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834E86D09BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjC3Pd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjC3PdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:33:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530AE07C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:32:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m2so19518058wrh.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680190353; x=1682782353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0mnRIbGkQTvtA6Sd/6ZGGzaZl2jf/GCphXRThjLz5Y=;
        b=WE17Qre8lYHzyeHrBZm6fwLP1oMW62Te+pOa65fQDXkouN+NUOZNA7Hs/wForonk+z
         aV4iFGWsfqzYxuWbjXX+oXmWeWzhLuFBEOrqwUyzX7Sa49iwsAphwKHjqrs5+tEswKP6
         PRw5pKYt4C2E6oSYmtNWVAZmGyOfFzTczzTxSIRe6uUsRQPQEqQSmiSMQU56jrDHPeRd
         DXwiZOaeQrOlMWRNr6kjJJ5nXRuEGz+/VCAqINxT80nvRlZNqcLcBySgbp0Zhub9W3lA
         a26lk5lv1j+0kfFZwQdMKDlvKZfJKNZS0+wE9hy6OIEbzVfzxmg8Ub3qkgyTEENRLwZh
         TqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190353; x=1682782353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0mnRIbGkQTvtA6Sd/6ZGGzaZl2jf/GCphXRThjLz5Y=;
        b=ptAGBPFu1+NgkgSvawoQYv1+HhKsZ2U+bZKygwQ/c58H3Ii5//PMiqQ0HLPAKfPwBD
         nEEsKddlaEA84yXiG1/44jErY39jsCoeZgO6Hl/JqvCj25GxPWumftjPD6ETn3i3A6pg
         awP+cma9AV/4bJLg5BA6F1/58yMzszu4mTURWVyjFoQuNXoAd5ENDyhpizSmatEhYwBc
         blPVEvIq01SASD5lWhLGIcMIGcaZows35btVUdU1iz0rm6niIpn4f1uGwqVjXm4IyvVK
         y9ScnTuGgqGdoQls1InYcAkfecTepJd19LZPwriEgvrS38XOn+XCSc1wFl8Jj80/1KFv
         Om5Q==
X-Gm-Message-State: AAQBX9fQ1H9Rw1gRnFa8UN42wA2XHbmQBsAuNFmzQRxSSAwdU+1o4CJv
        enu1d1D7XR2MOkJTV+qNR3n1hw==
X-Google-Smtp-Source: AKy350aC+RFjvAWsT892NKWeEYcETiN9cLISo67goew8T74Q9nYZx0MxDAWqnrl2lv5g0dIUeDFrvw==
X-Received: by 2002:adf:e288:0:b0:2ce:a93d:882d with SMTP id v8-20020adfe288000000b002cea93d882dmr18958283wri.11.1680190353713;
        Thu, 30 Mar 2023 08:32:33 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm33151794wrt.20.2023.03.30.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:32:32 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v8 5/5] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Date:   Thu, 30 Mar 2023 16:32:22 +0100
Message-Id: <20230330153222.2875121-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
References: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic booting DTS for the Sony Xperia M4 Aqua aka "tulip".

Tulip is paired with:

- wcn3660
- smb1360 battery charger
- 720p Truly NT35521 Panel

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 184 ++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 31e0ac97fc088..3f8321ecb7e5f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
new file mode 100644
index 0000000000000..cb47bb2413a7c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023, Bryan O'Donoghue.
+ *
+ */
+
+/dts-v1/;
+
+#include "msm8939.dtsi"
+#include "msm8939-pm8916.dtsi"
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/ {
+	model = "Sony Xperia M4 Aqua";
+	compatible = "sony,kanuti-tulip", "qcom,msm8939";
+
+	qcom,board-id = <QCOM_BOARD_ID_MTP 0>;
+	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>;
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&tlmm {
+	usb_id_default: usb-id-default-state {
+		pins = "gpio110";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <8>;
+	};
+};
+
+&pronto {
+	status = "okay";
+
+	iris {
+		compatible = "qcom,wcn3660";
+	};
+};
+
+&smd_rpm_regulators {
+	vdd_l1_l2_l3-supply = <&pm8916_s3>;
+	vdd_l4_l5_l6-supply = <&pm8916_s4>;
+	vdd_l7-supply = <&pm8916_s4>;
+
+	pm8916_s3: s3 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1300000>;
+	};
+
+	pm8916_s4: s4 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2100000>;
+	};
+
+	pm8916_l2: l2 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	pm8916_l4: l4 {
+		regulator-min-microvolt = <2050000>;
+		regulator-max-microvolt = <2050000>;
+	};
+
+	pm8916_l5: l5 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l6: l6 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	pm8916_l7: l7 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l8: l8 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	pm8916_l9: l9 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l10: l10 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l11: l11 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-system-load = <200000>;
+		regulator-allow-set-load;
+	};
+
+	pm8916_l12: l12 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l13: l13 {
+		regulator-min-microvolt = <3075000>;
+		regulator-max-microvolt = <3075000>;
+	};
+
+	pm8916_l14: l14 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l15: l15 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+
+	pm8916_l18: l18 {
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+	};
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc1_default_state>;
+	pinctrl-1 = <&sdc1_sleep_state>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
+
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_default_state>;
+	pinctrl-1 = <&sdc2_sleep_state>;
+	pinctrl-names = "default", "sleep";
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usb {
+	dr_mode = "device";
+	extcon = <&usb_id>, <&usb_id>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
-- 
2.39.2

