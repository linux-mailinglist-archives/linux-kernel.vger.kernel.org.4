Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F243647715
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLHUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiLHUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:14:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D477A18D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:14:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d6so3710448lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE/MPVWrPkQi2tEjQtLjQ0ec0nKxppkiun4hqaN8bS0=;
        b=VfiUnEVpay226r0SJafv4wdNSH9JKbS4sHULqoggjl1AAPW4hUMbAurBhe+m1U0ZDU
         2VP/ecZVjmYFw1ded4AL/o+FhYs1Nb+vzXb2ZcPP1Mt1n0P0WUw8kdVpF1ldUELQpM0x
         udE8cjVKzBqmwe3I28BuFomBYuGEcQgO4v4cGVCkmftxAQ1wYQ0Pwl4yLe1P/JH3pB6R
         7XDe/0GtvGtFrn8h/FYr0BjuxjokwWLBnwOumwZEc0gYKiPlgyStCFj1vVrgZPAT9bJy
         WiduuTT4MMs9ADylJt6yYex5gWGuxf0c+TPBP345w/cI0dNz1vkdxDc/2v9etuyVK5g6
         1S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE/MPVWrPkQi2tEjQtLjQ0ec0nKxppkiun4hqaN8bS0=;
        b=Ns6oK/qt7dfWqp0UvRWjnOiho8xYiC0RYDrDLqW1iN4uRQu39e4pb8sgO2qZIWfUl5
         LtHeNSafj6TQHZ6Q1vCo5Yk4SSsyQRHOFas0F+irenJVp5iaTduEv1On0xHJ+nuWoRoG
         YTjVOPjtXiJk6bF9dEZaP9Knkm67fLYWvFPBxMgRakCIk0iwBTxV/kXsRmfiOo8A0V3n
         fxePjk3IZgb8ah2gjdYlV9PeU2YY9RXqY6BEBUWyuIyP04EpnH4X8UfGaz5H3Q7qQK2K
         vFaoK0KoU4oSAUFkHeFDpzUa51yLakkqEe42wizAuPn9+U0nmccJQJ946lCYZCrPU5Yh
         JADg==
X-Gm-Message-State: ANoB5pkrtNatpq/DsG9CM8asOHqMOIUZDvN/ik+q83fH5mCSWtJttN2w
        TDA0+KkMrp6xSugw33wKp7Ll8A==
X-Google-Smtp-Source: AA0mqf7u2fLlrZWwWyu1RQ9LRZO7MsSM1CuLsoSJ7575yLTWeMcj0C0Ra1OgLU7Lrm2f2Zxmw6Rpbg==
X-Received: by 2002:a05:6512:10d3:b0:4b5:830d:12bc with SMTP id k19-20020a05651210d300b004b5830d12bcmr3821909lfg.47.1670530461145;
        Thu, 08 Dec 2022 12:14:21 -0800 (PST)
Received: from localhost.localdomain (95.49.125.53.neoplus.adsl.tpnet.pl. [95.49.125.53])
        by smtp.gmail.com with ESMTPSA id bi35-20020a0565120ea300b004ac6a444b26sm3466428lfb.141.2022.12.08.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:14:20 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: qcom: Add Lenovo Tab P11 (J606F/XiaoXin Pad) dts
Date:   Thu,  8 Dec 2022 21:14:01 +0100
Message-Id: <20221208201401.530555-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208201401.530555-1-konrad.dybcio@linaro.org>
References: <20221208201401.530555-1-konrad.dybcio@linaro.org>
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

Add an initial device tree for the Lenovo Tab P11. Currently it
enables:

- simplefb
- SD Card slot via SDHCI2
- gpio-keys & PON keys
- UFS
- RPM regulators
- USB2

This has been validated with a rev (62) device. You can check yours
next to the serial no. on the sticker in the lower portion of the
back side of your tablet.

To get a successful boot run:

cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/\
sm6115p-lenovo-j606f.dtb > .Image.gz-dtb

~/mkbootimg/mkbootimg.py \
--kernel .Image.gz-dtb \
--ramdisk some/initrd.img \
--pagesize 4096 \
--base 0x0 \
--kernel_offset 0x8000 \
--ramdisk_offset 0x1000000 \
--tags_offset 0x100 \
--cmdline 'SOME_CMDLINE' \
--dtb_offset 0x1f00000 \
--header_version 1 \
--os_version 11 \
--os_patch_level 2022-11 \
-o j606f.img

fastboot flash boot j606f.img
fastboot flash dtbo empty.img
fastboot flash recovery empty.img
fastboot reboot

Where empty.img is 2 zero-bytes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    | 290 ++++++++++++++++++
 2 files changed, 291 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 3e79496292e7..5d281436172d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -156,6 +156,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
new file mode 100644
index 000000000000..102730dd49a7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2022 Linaro Limited
+ */
+
+/dts-v1/;
+
+#include "sm6115.dtsi"
+#include "pm6125.dtsi"
+
+/ {
+	model = "Lenovo Tab P11";
+	compatible = "lenovo,j606f", "qcom,sm6115p", "qcom,sm6115";
+	chassis-type = "tablet";
+
+	/* required for bootloader to select correct board */
+	qcom,msm-id = <445 0x10000>, <420 0x10000>;
+	qcom,board-id = <34 3>;
+
+	aliases {
+		mmc0 = &sdhc_2;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer0: framebuffer@5c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x5c000000 0 (2000 * 1200 * 4)>;
+			width = <1200>;
+			height = <2000>;
+			stride = <(1200 * 4)>;
+			format = "a8r8g8b8";
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_n>;
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm6125_gpio 5 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+	};
+};
+
+&dispcc {
+	/* HACK: disable until a panel driver is ready to retain simplefb */
+	status = "disabled";
+};
+
+&pm6125_gpio {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio5";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		pm6125_s6: s6 {
+			regulator-min-microvolt = <304000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		pm6125_s7: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2080000>;
+		};
+
+		pm6125_s8: s8 {
+			regulator-min-microvolt = <1064000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l1: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		pm6125_l4: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm6125_l5: l5 {
+			regulator-min-microvolt = <1648000>;
+			/* 3.056V capped to 2.96V for SDHCI */
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+			/* Broken hw, this one can't be turned off or SDHCI will break! */
+			regulator-always-on;
+		};
+
+		pm6125_l6: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		pm6125_l7: l7 {
+			/* 1.2V-1.304V fixed at 1.256V for SDHCI bias */
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
+			/*
+			 * TODO: SDHCI seems to also work with this one turned off, however
+			 * there exists a possibility that it may not work with some very
+			 * specific SDCard types, perhaps validating this against a wide
+			 * range of models could rule that out, saving some power would
+			 * certainly be nice..
+			 */
+			regulator-always-on;
+		};
+
+		pm6125_l8: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		pm6125_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l10: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l11: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		pm6125_l12: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		pm6125_l13: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		pm6125_l14: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l15: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		pm6125_l16: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l17: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1384000>;
+		};
+
+		pm6125_l18: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1312000>;
+		};
+
+		pm6125_l19: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l20: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l21: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3600000>;
+		};
+
+		pm6125_l22: l22 {
+			regulator-min-microvolt = <2952000>;
+			/* 3.304V capped to 2.96V for SDHCI */
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+			/* Broken hw, this one can't be turned off or SDHCI will break! */
+			regulator-always-on;
+		};
+
+		pm6125_l23: l23 {
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l24: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_state_on &sdc2_gate_pin>;
+	pinctrl-1 = <&sdc2_state_off>;
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32764>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <14 4>;
+
+	/*
+	 * This is a wholly undocumented pin (other than a single vague "pwr-gpios" reference)
+	 * that needs to be toggled for the SD Card slot to work properly..
+	 */
+	sdc2_gate_pin: sdc2-gate-state {
+		pins = "gpio45";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+		output-high;
+	};
+};
+
+&ufs_mem_hc {
+	vcc-supply = <&pm6125_l24>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&pm6125_l11>;
+	vccq2-max-microamp = <600000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&pm6125_l4>;
+	vdda-pll-supply = <&pm6125_l12>;
+	vddp-ref-clk-supply = <&pm6125_l18>;
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&pm6125_l4>;
+	vdda-pll-supply = <&pm6125_l12>;
+	vdda-phy-dpdm-supply = <&pm6125_l15>;
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};
-- 
2.38.1

