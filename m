Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543B65B46CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIJOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIJOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136F491FF;
        Sat, 10 Sep 2022 07:32:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t7so7816356wrm.10;
        Sat, 10 Sep 2022 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0KP4+DvPw8H2XraCq7DVmGrh+MmfdY68pVAk8xlOP9M=;
        b=SILmZi99yu35ydR0RYfV9tGeJ0qa/xOUYpNHbMggNP3vxL40vmgTVKf970KXUY9ayT
         AXL5v1ai5SU4NFCm0KaBkslJ1Ab6nRaK8cAUPYovN1m7UqYSdTb+Q1vvXtv6f9Itai9z
         tW2u91WHX+DCVu4ffsQcby6bFXeyDstSrVpmoUlNwk5OYSUOY22RxUCeGm4f23U20A9M
         /MCB/YHMOiL96e5844XVkTSOdgQU0HYIJbS7sePNMIfqtZzwwfuYPl1ETmP5cbyoKC4e
         hEnN9TeZY+H2RmJVGvlJwk6d+UvNo6gp3PHW/8hobmGwj9jdhEeb8LjR27NrtcB1pTqL
         9b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0KP4+DvPw8H2XraCq7DVmGrh+MmfdY68pVAk8xlOP9M=;
        b=6knyNLeTmw6a2UwvwtgL2FTuYu00c+8dU85xaeoiVH5Qe+xeJJPHT02A8u5BIzAp1p
         SJKlURR2+74B9Nyny6lGU7LjodcGTGpiEYWMRSwqSJ5Jl4Tf3SXPYIBkqHifG68+Rd3Y
         ln8itN/hF62XT1Zq6HOKB6uMWuyeZP0T3glRBKhz8STmiw1cFqCX8ovtEhurwjXjZji3
         +l9Pb2q8WxzJoh7Ssq854Li44RWYGPfJIi9FRtcrqxwdLGwVzppfjc4AIlxDlg2MVxgD
         NzgazGXKSQpdwGdnnB0PaoY3eUwHo70iViuWC1ULGGs9lZuDyRZ3zsD/tck1/4JIJO9D
         H4EQ==
X-Gm-Message-State: ACgBeo2b6Imq0FiVJIi3VjgBssA1K5Qxh1X18gWUgah00HNBg6/uXbS0
        1X/z8oJbspA/wOjz7Q9/b8g=
X-Google-Smtp-Source: AA6agR4TQDpqBEIq9PShOGI/4/ptzgX6DungIY4QdXEVG/cVUMgnnDWQ6nDzqDo7dEXOcZaafiUaEQ==
X-Received: by 2002:a05:6000:1ac8:b0:22a:4cd7:92bc with SMTP id i8-20020a0560001ac800b0022a4cd792bcmr1365822wry.230.1662820358722;
        Sat, 10 Sep 2022 07:32:38 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id q127-20020a1c4385000000b003a5f54e3bbbsm3933139wma.38.2022.09.10.07.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:38 -0700 (PDT)
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
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] arm64: dts: qcom: sm4250: Add support for oneplus-billie2
Date:   Sat, 10 Sep 2022 17:32:13 +0300
Message-Id: <20220910143213.477261-10-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for OnePlus Nord N100, based on SM4250. Currently
working:
- boots
- usb
- buildin flash storage (UFS)
- SD card reader

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 241 ++++++++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f4126f7e7640..5d2570b600e0 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -137,6 +137,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
new file mode 100644
index 000000000000..b9094f1efca0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+&xo_board {
+	clock-frequency = <19200000>;
+};
+
+&sleep_clk {
+	clock-frequency = <32764>;
+};
+
+&reserved_memory {
+	bootloader_log_mem: memory@5fff7000 {
+		reg = <0x00 0x5fff7000 0x00 0x8000>;
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
+		reg = <0x00 0xcc200000 0x00 0x100000>;
+		no-map;
+	};
+
+	mtp_mem: memory@cc300000 {
+		reg = <0x00 0xcc300000 0x00 0xb00000>;
+		no-map;
+	};
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&hsusb_phy {
+	vdd-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vdda-phy-dpdm-supply = <&vreg_l15a>;
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <14 4>;
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
-- 
2.37.2

