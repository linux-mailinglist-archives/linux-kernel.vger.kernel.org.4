Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882AC6129AD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJ3JoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJ3Jng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:43:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485DD2CC;
        Sun, 30 Oct 2022 02:43:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so6386664wmq.4;
        Sun, 30 Oct 2022 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGW3s7VAfdS0LxK3XABjCKqjaFAM6/EYoTFRFX90Zzg=;
        b=U+dZIB5Rf38yZpmjdy33P2ObW6lqtr2ScbAKSESDDwvyyQkoaA0+lAqlaEzDGaXDUG
         jA/sa3jRmVNuk8Wru2pbM/NAF6v8rAWRr9iI+YkS/3bNUn9E9m563DglnPVD4SKxpe7s
         +XGNtc5doQf/I2ejg3wcDNmlgrYlcXjKZKlp9rctGd3kA9KXdM6Lz8ILcJMJ/mL7DjMi
         aLLsDaFeMmDOLOWNKqyXJPaV8ByYG4/sMmC5PAUXdcqeVMjH+hMtLvS2Xre9oFiDd61h
         wOaL2R2pCi67yII8mgyqOQQqgM6BJPZ4n6nKnJCX/SzIqqAwoPPSMtZ+PTdEg4LmB5jj
         3tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGW3s7VAfdS0LxK3XABjCKqjaFAM6/EYoTFRFX90Zzg=;
        b=MdvRgq8w+Sd3ZZI3W9cM1mnPxyWdBQawb4EP8c8zXlp7bUntXPVBjpMerEfgODOz1a
         FFRL2LcSdeBPDZnRkHOjyYaAzbggnX+c/ppFE3EP07VJsCstUa90bhHvTt5wrLv73/lp
         qaYr1f4cy5r0zGObO/5gjF9QQuGUXDQSyk5boQjrPGqS/sYkKwA3n1GuPgYnhVB/Q8oH
         eqfKch92LLX8wQKJn5QkUG5TsVDHjPyLx1QI/vG6d/ehL0i5gqug0JCUZ+uWOFbSnFoO
         me8xDIIWd2oCE2dVNCuCFgYNkIfO1MKbQVLD6LojsAgADk+hOunC/lVRjqmOaStG1Z89
         6S4g==
X-Gm-Message-State: ACrzQf2KFHY0ljM3esbtRaJkd9JoSMktgvadRo6FWs29i8HkcyUYnhxo
        mWHV+OUx4myAb0rdCMfrVDU=
X-Google-Smtp-Source: AMsMyM63jZ4gtRX0nXL5wOtj0PyiWp4s9Kby1XaTjqhRKKShlq//0+nNflxruEZG4/lZZBOKTEWQrQ==
X-Received: by 2002:a05:600c:3585:b0:3c7:9f:5f87 with SMTP id p5-20020a05600c358500b003c7009f5f87mr15284457wmq.76.1667123010972;
        Sun, 30 Oct 2022 02:43:30 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b003b47b80cec3sm3805282wms.42.2022.10.30.02.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:30 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 8/8] arm64: dts: qcom: sm4250: Add support for oneplus-billie2
Date:   Sun, 30 Oct 2022 11:42:58 +0200
Message-Id: <20221030094258.486428-9-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for OnePlus Nord N100, based on SM4250. Currently
working:
- boots
- usb
- built-in flash storage (UFS)
- SD card reader

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 241 ++++++++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b0558d3389e5..eb2a58b8af5f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -142,6 +142,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
new file mode 100644
index 000000000000..a3f1c7c41fd7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sm4250.dtsi"
+
+/ {
+	model = "OnePlus Nord N100";
+	compatible = "oneplus,billie2", "qcom,sm4250";
+
+	/* required for bootloader to select correct board */
+	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
+	qcom,board-id = <0x1000b 0x00>;
+
+	aliases {
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "framebuffer0";
+
+		framebuffer0: framebuffer@9d400000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x5c000000 0 (1600 * 720 * 4)>;
+			width = <720>;
+			height = <1600>;
+			stride = <(720 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+};
+
+&reserved_memory {
+	bootloader_log_mem: memory@5fff7000 {
+		reg = <0x0 0x5fff7000 0x0 0x8000>;
+		no-map;
+	};
+
+	ramoops@cbe00000 {
+		compatible = "ramoops";
+		reg = <0x0 0xcbe00000 0x0 0x400000>;
+		record-size = <0x40000>;
+		pmsg-size = <0x200000>;
+		console-size = <0x40000>;
+		ftrace-size = <0x40000>;
+	};
+
+	param_mem: memory@cc200000 {
+		reg = <0x0 0xcc200000 0x0 0x100000>;
+		no-map;
+	};
+
+	mtp_mem: memory@cc300000 {
+		reg = <0x00 0xcc300000 0x00 0xb00000>;
+		no-map;
+	};
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		vreg_s6a: s6 {
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		vreg_s7a: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s8a: s8 {
+			regulator-min-microvolt = <1064000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l1a: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		vreg_l4a: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		vreg_l6a: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		vreg_l7a: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l8a: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		vreg_l9a: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l10a: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l11a: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l12a: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		vreg_l13a: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l14a: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l15a: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		vreg_l16a: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l17a: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l18a: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l19a: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l20a: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l21a: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		vreg_l22a: l22 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l23a: l23 {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l24a: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+};
+
+&sleep_clk {
+	clock-frequency = <32764>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&vreg_l22a>;
+	vqmmc-supply = <&vreg_l5a>;
+
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <14 4>;
+};
+
+&ufs_mem_hc {
+	vcc-supply = <&vreg_l24a>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&vreg_l11a>;
+	vccq2-max-microamp = <600000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vddp-ref-clk-supply = <&vreg_l18a>;
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vdda-phy-dpdm-supply = <&vreg_l15a>;
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};
-- 
2.38.1

