Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07695FE218
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiJMSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiJMSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:51:57 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2431DC4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:49:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a24so2293630qto.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaEGKgKJEuewevHsz7+h3melZX83ZKfCZgmJT2s+C2M=;
        b=GRMBqdMDuI0R05Fh0/h4TxpLqN3cCUiSMp8Vr/a+x36MScgNekKNIqstLtm2Ky0BkH
         ULEWH1QVE6G6HCdX8VIRbjsZ4cMMvMlpUr2bMUbUTKWOx2Ax/5rBzmldLuWw0Aiteq8g
         PtbyjjkjR8+d8hdO3pVi8/ujxm3/1sohuuuVLZxZgUCJLslx0aj3aDDMfJFRPmQ9Hzj9
         9wKJi0ueoyTNrBGBsFMekX19BzwGdY+GFzPUWYhFKqlLzRoo+iHL/4qibuH0DlsnJtie
         d7359v00fiweb/hpSK3gDJHfrHArER5wJ/0qFA+jO4JQDyIvG2J8t304zDYFOluScAEz
         LM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaEGKgKJEuewevHsz7+h3melZX83ZKfCZgmJT2s+C2M=;
        b=p32aNKFjTQRYBr0v5Mj+M2YxX5qqElUWSSy5P4pCLzOY1fYQaD6t4Bd1Ufo3AJflv4
         i2iuid0XdVHX58ti8D9BSoNcmYRHd/wVB9scBq7YPOXDrbIe6Oah1iaMVjilt2ZwW702
         L8PYESuoPZI8XC6YpY9ji0AHsNzEUnYr/SZHh9iTJY9yKIGukmXUmlg1+xKu8gLKzqeB
         ov2oGpm/ZGOHVUiym9Ru3BUSOcaoCP+eLUG28nmamN7M3RJMxoyyG1Ma7GtJrQeOFvRU
         8WjyhP3dJ3OcyHn+cVC3zSs+o7s0ym/2fYN9kcse/j+Si2paytZP4PbnVFW2qKpK4Vv2
         y/vg==
X-Gm-Message-State: ACrzQf0LlavzjymHv3fJXjuVclOGLN2BK6lZDYu/4BUlzk6tD26EMs6U
        UHz8aNBQNLuEsnMMha4aOndQkQ==
X-Google-Smtp-Source: AMsMyM6T538XTF6bG76JTr8etFuEWWN8vUhYwOJo1HTIVhq0llMmGxmUyLr3MNBpHVlou75zD/vEZg==
X-Received: by 2002:a05:622a:356:b0:35d:55ae:43ab with SMTP id r22-20020a05622a035600b0035d55ae43abmr1128693qtw.430.1665686945485;
        Thu, 13 Oct 2022 11:49:05 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006e16dcf99c8sm400748qko.71.2022.10.13.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:49:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sc7180: align TLMM pin configuration with DT schema
Date:   Thu, 13 Oct 2022 14:46:59 -0400
Message-Id: <20221013184700.87260-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
References: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Merge subnodes named 'pinconf' and 'pinmux' into one entry, add function
where missing (required by bindings for GPIOs) and reorganize overriding
pins by boards.

Split the SPI and UART configuration into separate nodes
1. SPI (MOSI, MISO, SCLK), SPI chip-select, SPI chip-select via GPIO,
2. UART per each pin: TX, RX and optional CTS/RTS.

This allows each board to customize them easily without adding any new
nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Split SPI and UART nodes, after discussion with Doug.

Not tested on hardware.

Cc: Doug Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 236 +++----
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  36 +-
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  47 +-
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  16 +-
 .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |   8 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  16 +-
 .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  25 +-
 .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi |  72 +-
 .../qcom/sc7180-trogdor-parade-ps8640.dtsi    |  32 +-
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |   8 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  14 +-
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |  56 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   8 +-
 .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |  16 +-
 .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  25 +-
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  72 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 652 +++++++-----------
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 597 ++++++++--------
 18 files changed, 786 insertions(+), 1150 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 9dee131b1e24..70fd9ff8dfa2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -481,287 +481,261 @@ pinconf {
 };
 
 &qspi_clk {
-	pinconf {
-		pins = "gpio63";
-		bias-disable;
-	};
+	bias-disable;
 };
 
 &qspi_cs0 {
-	pinconf {
-		pins = "gpio68";
-		bias-disable;
-	};
+	bias-disable;
 };
 
 &qspi_data01 {
-	pinconf {
-		pins = "gpio64", "gpio65";
-
-		/* High-Z when no transfers; nice to park the lines */
-		bias-pull-up;
-	};
+	/* High-Z when no transfers; nice to park the lines */
+	bias-pull-up;
 };
 
 &qup_i2c2_default {
-	pinconf {
-		pins = "gpio15", "gpio16";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c4_default {
-	pinconf {
-		pins = "gpio115", "gpio116";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c7_default {
-	pinconf {
-		pins = "gpio6", "gpio7";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c9_default {
-	pinconf {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
-&qup_uart3_default {
-	pinconf-cts {
-		/*
-		 * Configure a pull-down on CTS to match the pull of
-		 * the Bluetooth module.
-		 */
-		pins = "gpio38";
-		bias-pull-down;
-	};
+&qup_uart3_cts {
+	/*
+	 * Configure a pull-down on CTS to match the pull of
+	 * the Bluetooth module.
+	 */
+	bias-pull-down;
+};
 
-	pinconf-rts {
-		/* We'll drive RTS, so no pull */
-		pins = "gpio39";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart3_rts {
+	/* We'll drive RTS, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
 
-	pinconf-tx {
-		/* We'll drive TX, so no pull */
-		pins = "gpio40";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart3_tx {
+	/* We'll drive TX, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
 
-	pinconf-rx {
-		/*
-		 * Configure a pull-up on RX. This is needed to avoid
-		 * garbage data when the TX pin of the Bluetooth module is
-		 * in tri-state (module powered off or not driving the
-		 * signal yet).
-		 */
-		pins = "gpio41";
-		bias-pull-up;
-	};
+&qup_uart3_rx {
+	/*
+	 * Configure a pull-up on RX. This is needed to avoid
+	 * garbage data when the TX pin of the Bluetooth module is
+	 * in tri-state (module powered off or not driving the
+	 * signal yet).
+	 */
+	bias-pull-up;
 };
 
-&qup_uart8_default {
-	pinconf-tx {
-		pins = "gpio44";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart8_tx {
+	drive-strength = <2>;
+	bias-disable;
+};
 
-	pinconf-rx {
-		pins = "gpio45";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
+&qup_uart8_rx {
+	drive-strength = <2>;
+	bias-pull-up;
 };
 
-&qup_spi0_default {
-	pinconf {
-		pins = "gpio34", "gpio35", "gpio36", "gpio37";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_spi0_spi {
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_spi6_default {
-	pinconf {
-		pins = "gpio59", "gpio60", "gpio61", "gpio62";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_spi0_cs {
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_spi10_default {
-	pinconf {
-		pins = "gpio86", "gpio87", "gpio88", "gpio89";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_spi6_spi {
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&tlmm {
-	qup_uart3_sleep: qup-uart3-sleep {
-		pinmux {
-			pins = "gpio38", "gpio39",
-			       "gpio40", "gpio41";
-			function = "gpio";
-		};
+&qup_spi6_cs {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_spi10_spi {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_spi10_cs {
+	drive-strength = <2>;
+	bias-disable;
+};
 
-		pinconf-cts {
+&tlmm {
+	qup_uart3_sleep: qup-uart3-sleep-state {
+		cts-pins {
 			/*
 			 * Configure a pull-down on CTS to match the pull of
 			 * the Bluetooth module.
 			 */
 			pins = "gpio38";
+			function = "gpio";
 			bias-pull-down;
 		};
 
-		pinconf-rts {
+		rts-pins {
 			/*
 			 * Configure pull-down on RTS. As RTS is active low
 			 * signal, pull it low to indicate the BT SoC that it
 			 * can wakeup the system anytime from suspend state by
 			 * pulling RX low (by sending wakeup bytes).
 			 */
-			 pins = "gpio39";
-			 bias-pull-down;
+			pins = "gpio39";
+			function = "gpio";
+			bias-pull-down;
 		};
 
-		pinconf-tx {
+		tx-pins {
 			/*
 			 * Configure pull-up on TX when it isn't actively driven
 			 * to prevent BT SoC from receiving garbage during sleep.
 			 */
 			pins = "gpio40";
+			function = "gpio";
 			bias-pull-up;
 		};
 
-		pinconf-rx {
+		rx-pins {
 			/*
 			 * Configure a pull-up on RX. This is needed to avoid
 			 * garbage data when the TX pin of the Bluetooth module
 			 * is floating which may cause spurious wakeups.
 			 */
 			pins = "gpio41";
+			function = "gpio";
 			bias-pull-up;
 		};
 	};
 
-	sdc1_on: sdc1-on {
-		pinconf-clk {
+	sdc1_on: sdc1-on-state {
+		clk-pins {
 			pins = "sdc1_clk";
 			bias-disable;
 			drive-strength = <16>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc1_cmd";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc1_data";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		pinconf-rclk {
+		rclk-pins {
 			pins = "sdc1_rclk";
 			bias-pull-down;
 		};
 	};
 
-	sdc1_off: sdc1-off {
-		pinconf-clk {
+	sdc1_off: sdc1-off-state {
+		clk-pins {
 			pins = "sdc1_clk";
 			bias-disable;
 			drive-strength = <2>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc1_cmd";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc1_data";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-rclk {
+		rclk-pins {
 			pins = "sdc1_rclk";
 			bias-pull-down;
 		};
 	};
 
-	sdc2_on: sdc2-on {
-		pinconf-clk {
+	sdc2_on: sdc2-on-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;
 			drive-strength = <16>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc2_data";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		pinconf-sd-cd {
+		sd-cd-pins {
 			pins = "gpio69";
+			function = "gpio";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 	};
 
-	sdc2_off: sdc2-off {
-		pinconf-clk {
+	sdc2_off: sdc2-off-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;
 			drive-strength = <2>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc2_data";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-sd-cd {
+		sd-cd-pins {
 			pins = "gpio69";
+			function = "gpio";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 7ee407f7b6bb..8b8ea8af165d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -181,23 +181,15 @@ &sound_multimedia0_codec {
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &en_pp3300_dx_edp {
-	pinmux  {
-		pins = "gpio67";
-	};
-
-	pinconf {
-		pins = "gpio67";
-	};
+	pins = "gpio67";
 };
 
 &ts_reset_l {
-	pinconf {
-		/*
-		 * We want reset state by default and it will be up to the
-		 * driver to disable this when it's ready.
-		 */
-		output-low;
-	};
+	/*
+	 * We want reset state by default and it will be up to the
+	 * driver to disable this when it's ready.
+	 */
+	output-low;
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -327,16 +319,10 @@ &tlmm {
 			  "DP_HOT_PLUG_DET",
 			  "EC_IN_RW_ODL";
 
-	dmic_clk_en: dmic_clk_en {
-		pinmux {
-			pins = "gpio83";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio83";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
+	dmic_clk_en: dmic-clk-en-state {
+		pins = "gpio83";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index bfab67f4a7c9..c66568a882b3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -180,36 +180,19 @@ &wifi {
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &en_pp3300_dx_edp {
-	pinmux {
-		pins = "gpio67";
-	};
-
-	pinconf {
-		pins = "gpio67";
-	};
+	pins = "gpio67";
 };
 
 &sec_mi2s_active{
-	pinmux {
-		pins = "gpio49", "gpio50", "gpio51", "gpio52";
-		function = "mi2s_1";
-	};
-
-	pinconf {
-		pins = "gpio49", "gpio50", "gpio51", "gpio52";
-		drive-strength = <2>;
-		bias-pull-down;
-	};
+	pins = "gpio49", "gpio50", "gpio51", "gpio52";
 };
 
 &ts_reset_l {
-	pinconf {
-		/*
-		 * We want reset state by default and it will be up to the
-		 * driver to disable this when it's ready.
-		 */
-		output-low;
-	};
+	/*
+	 * We want reset state by default and it will be up to the
+	 * driver to disable this when it's ready.
+	 */
+	output-low;
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -339,16 +322,10 @@ &tlmm {
 			  "DP_HOT_PLUG_DET",
 			  "EC_IN_RW_ODL";
 
-	en_pp3300_touch: en-pp3300-touch {
-		pinmux {
-			pins = "gpio87";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio87";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	en_pp3300_touch: en-pp3300-touch-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
index 1a62e8d435ab..3abd6222fe46 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
@@ -29,16 +29,10 @@ &pp3300_fp_tp {
 };
 
 &tlmm {
-	en_fp_rails: en-fp-rails {
-		pinmux {
-			pins = "gpio74";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio74";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	en_fp_rails: en-fp-rails-state {
+		pins = "gpio74";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
index 74f0e07ea5cf..4156ad6dbd96 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
@@ -87,13 +87,7 @@ &wifi {
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &en_pp3300_dx_edp {
-	pinmux {
-		pins = "gpio67";
-	};
-
-	pinconf {
-		pins = "gpio67";
-	};
+	pins = "gpio67";
 };
 
 /* PINCTRL - board-specific pinctrl */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 002663d752da..269007d73162 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -75,21 +75,13 @@ &wifi {
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &trackpad_int_1v8_odl {
-	pinmux {
-		pins = "gpio58";
-	};
-
-	pinconf {
-		pins = "gpio58";
-	};
+	pins = "gpio58";
 };
 
 &ts_reset_l {
-	pinconf {
-		/* This pin is not connected on -rev0, pull up to park. */
-		/delete-property/bias-disable;
-		bias-pull-up;
-	};
+	/* This pin is not connected on -rev0, pull up to park. */
+	/delete-property/bias-disable;
+	bias-pull-up;
 };
 
 /* PINCTRL - board-specific pinctrl */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
index 7bc8402c018e..f4c1f3813664 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
@@ -24,30 +24,13 @@ &v1p8_mipi {
 
 /* PINCTRL - modifications to sc7180-trogdor-mrbland.dtsi */
 &avdd_lcd_en {
-	pinmux {
-		pins = "gpio80";
-	};
-
-	pinconf {
-		pins = "gpio80";
-	};
+	pins = "gpio80";
 };
 
 &mipi_1800_en {
-	pinmux {
-		pins = "gpio81";
-	};
-
-	pinconf {
-		pins = "gpio81";
-	};
+	pins = "gpio81";
 };
-&vdd_reset_1800 {
-	pinmux {
-		pins = "gpio76";
-	};
 
-	pinconf {
-		pins = "gpio76";
-	};
+&vdd_reset_1800 {
+	pins = "gpio76";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
index 97cba7f8064f..5e563655baec 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
@@ -160,13 +160,7 @@ pp3300_disp_on: &pp3300_dx_edp {
  */
 
 tp_en: &en_pp3300_dx_edp {
-	pinmux {
-		pins = "gpio85";
-	};
-
-	pinconf {
-		pins = "gpio85";
-	};
+	pins = "gpio85";
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -296,55 +290,31 @@ &tlmm {
 			  "DP_HOT_PLUG_DET",
 			  "EC_IN_RW_ODL";
 
-	avdd_lcd_en: avdd-lcd-en {
-		pinmux {
-			pins = "gpio88";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio88";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	avdd_lcd_en: avdd-lcd-en-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	avee_lcd_en: avee-lcd-en {
-		pinmux {
-			pins = "gpio21";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio21";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	avee_lcd_en: avee-lcd-en-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	mipi_1800_en: mipi-1800-en {
-		pinmux {
-			pins = "gpio86";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio86";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	mipi_1800_en: mipi-1800-en-state {
+		pins = "gpio86";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	vdd_reset_1800: vdd-reset-1800 {
-		pinmux {
-			pins = "gpio87";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio87";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	vdd_reset_1800: vdd-reset-1800-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
index 6a84fba178d6..070b3acb7baa 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
@@ -83,29 +83,17 @@ panel_in_edp: endpoint {
 };
 
 &tlmm {
-	edp_brij_ps8640_rst: edp-brij-ps8640-rst {
-		pinmux {
-			pins = "gpio11";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio11";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	edp_brij_ps8640_rst: edp-brij-ps8640-rst-state {
+		pins = "gpio11";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	en_pp3300_edp_brij_ps8640: en-pp3300-edp-brij-ps8640 {
-		pinmux {
-			pins = "gpio32";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio32";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	en_pp3300_edp_brij_ps8640: en-pp3300-edp-brij-ps8640-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
index 56d787785fd5..d06cc4ea3375 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -84,13 +84,7 @@ &pp3300_dx_edp {
 };
 
 &en_pp3300_dx_edp {
-	pinmux {
-		pins = "gpio67";
-	};
-
-	pinconf {
-		pins = "gpio67";
-	};
+	pins = "gpio67";
 };
 
 /* PINCTRL - board-specific pinctrl */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index a7582fb547ee..6c5287bd27d6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -312,15 +312,9 @@ &tlmm {
 			  "DP_HOT_PLUG_DET",
 			  "EC_IN_RW_ODL";
 
-	dmic_sel: dmic-sel {
-		pinmux {
-			pins = "gpio86";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio86";
-			bias-pull-down;
-		};
+	dmic_sel: dmic-sel-state {
+		pins = "gpio86";
+		function = "gpio";
+		bias-pull-down;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 695b04fe7221..c1367999eafb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -147,13 +147,7 @@ pp3300_disp_on: &pp3300_dx_edp {
  */
 
 tp_en: &en_pp3300_dx_edp {
-	pinmux {
-		pins = "gpio67";
-	};
-
-	pinconf {
-		pins = "gpio67";
-	};
+	pins = "gpio67";
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -283,42 +277,24 @@ &tlmm {
 			  "DP_HOT_PLUG_DET",
 			  "EC_IN_RW_ODL";
 
-	lcd_rst: lcd-rst {
-		pinmux {
-			pins = "gpio87";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio87";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	lcd_rst: lcd-rst-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	ppvar_lcd_en: ppvar-lcd-en {
-		pinmux {
-			pins = "gpio88";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio88";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	ppvar_lcd_en: ppvar-lcd-en-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	pp1800_disp_on: pp1800-disp-on {
-		pinmux {
-			pins = "gpio86";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio86";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	pp1800_disp_on: pp1800-disp-on-state {
+		pins = "gpio86";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index bc097d1b1b23..671b3691f1bb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -63,13 +63,7 @@ &usb_hub_3_x {
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &trackpad_int_1v8_odl {
-	pinmux {
-		pins = "gpio58";
-	};
-
-	pinconf {
-		pins = "gpio58";
-	};
+	pins = "gpio58";
 };
 
 /* PINCTRL - board-specific pinctrl */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
index f869e6a343c1..65333709e529 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
@@ -76,16 +76,10 @@ panel_in_edp: endpoint {
 };
 
 &tlmm {
-	edp_brij_irq: edp-brij-irq {
-		pinmux {
-			pins = "gpio11";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio11";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	edp_brij_irq: edp-brij-irq-state {
+		pins = "gpio11";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
index db29e0cba29d..7f272c6e95f6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
@@ -24,30 +24,13 @@ &v1p8_mipi {
 
 /* PINCTRL - modifications to sc7180-trogdor-wormdingler.dtsi */
 &avdd_lcd_en {
-	pinmux {
-		pins = "gpio80";
-	};
-
-	pinconf {
-		pins = "gpio80";
-	};
+	pins = "gpio80";
 };
 
 &mipi_1800_en {
-	pinmux {
-		pins = "gpio81";
-	};
-
-	pinconf {
-		pins = "gpio81";
-	};
+	pins = "gpio81";
 };
-&vdd_reset_1800 {
-	pinmux {
-		pins = "gpio76";
-	};
 
-	pinconf {
-		pins = "gpio76";
-	};
+&vdd_reset_1800 {
+	pins = "gpio76";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 6312108e8b3e..123989ba97e1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -222,13 +222,7 @@ pp3300_disp_on: &pp3300_dx_edp {
  */
 
 tp_en: &en_pp3300_dx_edp {
-	pinmux {
-		pins = "gpio85";
-	};
-
-	pinconf {
-		pins = "gpio85";
-	};
+	pins = "gpio85";
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -358,55 +352,31 @@ &tlmm {
 			  "DP_HOT_PLUG_DET",
 			  "EC_IN_RW_ODL";
 
-	avdd_lcd_en: avdd-lcd-en {
-		pinmux {
-			pins = "gpio88";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio88";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	avdd_lcd_en: avdd-lcd-en-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	avee_lcd_en: avee-lcd-en {
-		pinmux {
-			pins = "gpio21";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio21";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	avee_lcd_en: avee-lcd-en-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	mipi_1800_en: mipi-1800-en {
-		pinmux {
-			pins = "gpio86";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio86";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	mipi_1800_en: mipi-1800-en-state {
+		pins = "gpio86";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	vdd_reset_1800: vdd-reset-1800 {
-		pinmux {
-			pins = "gpio87";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio87";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	vdd_reset_1800: vdd-reset-1800-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index eae22e6e97c1..37abe131951c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -880,7 +880,7 @@ &sdhc_2 {
 };
 
 &spi0 {
-	pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_cs_gpio>;
+	pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_spi>;
 	cs-gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
 };
 
@@ -997,175 +997,141 @@ wifi-firmware {
 /* PINCTRL - additions to nodes defined in sc7180.dtsi */
 
 &dp_hot_plug_det {
-	pinconf {
-		pins = "gpio117";
-		bias-disable;
-	};
+	bias-disable;
 };
 
 &pri_mi2s_active {
-	pinconf {
-		pins = "gpio53", "gpio54", "gpio55", "gpio56";
-		drive-strength = <2>;
-		bias-pull-down;
-	};
+	drive-strength = <2>;
+	bias-pull-down;
 };
 
 &pri_mi2s_mclk_active {
-	pinconf {
-		pins = "gpio57";
-		drive-strength = <2>;
-		bias-pull-down;
-	};
+	drive-strength = <2>;
+	bias-pull-down;
 };
 
 &qspi_cs0 {
-	pinconf {
-		pins = "gpio68";
-		bias-disable;
-	};
+	bias-disable;
 };
 
 &qspi_clk {
-	pinconf {
-		pins = "gpio63";
-		drive-strength = <8>;
-		bias-disable;
-	};
+	drive-strength = <8>;
+	bias-disable;
 };
 
 &qspi_data01 {
-	pinconf {
-		pins = "gpio64", "gpio65";
-
-		/* High-Z when no transfers; nice to park the lines */
-		bias-pull-up;
-	};
+	/* High-Z when no transfers; nice to park the lines */
+	bias-pull-up;
 };
 
 &qup_i2c2_default {
-	pinconf {
-		pins = "gpio15", "gpio16";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c4_default {
-	pinconf {
-		pins = "gpio115", "gpio116";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c5_default {
-	pinconf {
-		pins = "gpio25", "gpio26";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c7_default {
-	pinconf {
-		pins = "gpio6", "gpio7";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c9_default {
-	pinconf {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
+};
+
+&qup_spi0_spi {
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_spi0_cs_gpio {
-	pinconf {
-		pins = "gpio34", "gpio35", "gpio36", "gpio37";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_spi6_spi {
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_spi6_cs_gpio {
-	pinconf {
-		pins = "gpio59", "gpio60", "gpio61", "gpio62";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_spi10_spi {
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_spi10_cs_gpio {
-	pinconf {
-		pins = "gpio86", "gpio87", "gpio88", "gpio89";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_uart3_default {
-	pinconf-cts {
-		/*
-		 * Configure a pull-down on CTS to match the pull of
-		 * the Bluetooth module.
-		 */
-		pins = "gpio38";
-		bias-pull-down;
-	};
+&qup_uart3_cts {
+	/*
+	 * Configure a pull-down on CTS to match the pull of
+	 * the Bluetooth module.
+	 */
+	bias-pull-down;
+};
 
-	pinconf-rts-tx {
-		/* We'll drive RTS and TX, so no pull */
-		pins = "gpio39", "gpio40";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart3_rts {
+	/* We'll drive RTS, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
 
-	pinconf-rx {
-		/*
-		 * Configure a pull-up on RX. This is needed to avoid
-		 * garbage data when the TX pin of the Bluetooth module is
-		 * in tri-state (module powered off or not driving the
-		 * signal yet).
-		 */
-		pins = "gpio41";
-		bias-pull-up;
-	};
+&qup_uart3_tx {
+	/* We'll drive TX, so no pull */
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_uart8_default {
-	pinconf-tx {
-		pins = "gpio44";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart3_rx {
+	/*
+	 * Configure a pull-up on RX. This is needed to avoid
+	 * garbage data when the TX pin of the Bluetooth module is
+	 * in tri-state (module powered off or not driving the
+	 * signal yet).
+	 */
+	bias-pull-up;
+};
 
-	pinconf-rx {
-		pins = "gpio45";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
+&qup_uart8_tx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart8_rx {
+	drive-strength = <2>;
+	bias-pull-up;
 };
 
 &sec_mi2s_active {
-	pinconf {
-		pins = "gpio49", "gpio50", "gpio51";
-		drive-strength = <2>;
-		bias-pull-down;
-	};
+	drive-strength = <2>;
+	bias-pull-down;
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -1196,468 +1162,342 @@ &tlmm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&bios_flash_wp_l>, <&ap_suspend_l_neuter>;
 
-	amp_en: amp-en {
-		pinmux {
-			pins = "gpio23";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio23";
-			bias-pull-down;
-		};
+	amp_en: amp-en-state {
+		pins = "gpio23";
+		function = "gpio";
+		bias-pull-down;
 	};
 
-	ap_ec_int_l: ap-ec-int-l {
-		pinmux {
-			pins = "gpio94";
-			function = "gpio";
-			input-enable;
-		};
-
-		pinconf {
-			pins = "gpio94";
-			bias-pull-up;
-		};
+	ap_ec_int_l: ap-ec-int-l-state {
+		pins = "gpio94";
+		function = "gpio";
+		input-enable;
+		bias-pull-up;
 	};
 
-	ap_edp_bklten: ap-edp-bklten {
-		pinmux {
-			pins = "gpio12";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio12";
-			drive-strength = <2>;
-			bias-disable;
+	ap_edp_bklten: ap-edp-bklten-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 
-			/* Force backlight to be disabled to match state at boot. */
-			output-low;
-		};
+		/* Force backlight to be disabled to match state at boot. */
+		output-low;
 	};
 
-	ap_suspend_l_neuter: ap-suspend-l-neuter {
-		pinmux  {
-			pins = "gpio27";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio27";
-			bias-disable;
-		};
+	ap_suspend_l_neuter: ap-suspend-l-neuter-state {
+		pins = "gpio27";
+		function = "gpio";
+		bias-disable;
 	};
 
-	bios_flash_wp_l: bios-flash-wp-l {
-		pinmux {
-			pins = "gpio66";
-			function = "gpio";
-			input-enable;
-		};
-
-		pinconf {
-			pins = "gpio66";
-			bias-disable;
-		};
+	bios_flash_wp_l: bios-flash-wp-l-state {
+		pins = "gpio66";
+		function = "gpio";
+		input-enable;
+		bias-disable;
 	};
 
-	edp_brij_en: edp-brij-en {
-		pinmux {
-			pins = "gpio104";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio104";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	edp_brij_en: edp-brij-en-state {
+		pins = "gpio104";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	en_pp3300_codec: en-pp3300-codec {
-		pinmux {
-			pins = "gpio83";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio83";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	en_pp3300_codec: en-pp3300-codec-state {
+		pins = "gpio83";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	en_pp3300_dx_edp: en-pp3300-dx-edp {
-		pinmux {
-			pins = "gpio30";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio30";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	en_pp3300_dx_edp: en-pp3300-dx-edp-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	en_pp3300_hub: en-pp3300-hub {
-		pinmux {
-			pins = "gpio84";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio84";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	en_pp3300_hub: en-pp3300-hub-state {
+		pins = "gpio84";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	fp_to_ap_irq_l: fp-to-ap-irq-l {
-		pinmux {
-			pins = "gpio4";
-			function = "gpio";
-			input-enable;
-		};
+	fp_to_ap_irq_l: fp-to-ap-irq-l-state {
+		pins = "gpio4";
+		function = "gpio";
+		input-enable;
 
-		pinconf {
-			pins = "gpio4";
-
-			/* Has external pullup */
-			bias-disable;
-		};
+		/* Has external pullup */
+		bias-disable;
 	};
 
-	h1_ap_int_odl: h1-ap-int-odl {
-		pinmux {
-			pins = "gpio42";
-			function = "gpio";
-			input-enable;
-		};
-
-		pinconf {
-			pins = "gpio42";
-			bias-pull-up;
-		};
+	h1_ap_int_odl: h1-ap-int-odl-state {
+		pins = "gpio42";
+		function = "gpio";
+		input-enable;
+		bias-pull-up;
 	};
 
-	hp_irq: hp-irq {
-		pinmux {
-			pins = "gpio28";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio28";
-			bias-pull-up;
-		};
+	hp_irq: hp-irq-state {
+		pins = "gpio28";
+		function = "gpio";
+		bias-pull-up;
 	};
 
-	pen_irq_l: pen-irq-l {
-		pinmux {
-			pins = "gpio21";
-			function = "gpio";
-		};
+	pen_irq_l: pen-irq-l-state {
+		pins = "gpio21";
+		function = "gpio";
 
-		pinconf {
-			pins = "gpio21";
-
-			/* Has external pullup */
-			bias-disable;
-		};
+		/* Has external pullup */
+		bias-disable;
 	};
 
-	pen_pdct_l: pen-pdct-l {
-		pinmux {
-			pins = "gpio52";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio52";
+	pen_pdct_l: pen-pdct-l-state-state {
+		pins = "gpio52";
+		function = "gpio";
 
-			/* Has external pullup */
-			bias-disable;
-		};
+		/* Has external pullup */
+		bias-disable;
 	};
 
-	pen_rst_odl: pen-rst-odl {
-		pinmux  {
-			pins = "gpio18";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio18";
-			bias-disable;
-			drive-strength = <2>;
+	pen_rst_odl: pen-rst-odl-state {
+		pins = "gpio18";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
 
-			/*
-			 * The pen driver doesn't currently support
-			 * driving this reset line.  By specifying
-			 * output-high here we're relying on the fact
-			 * that this pin has a default pulldown at boot
-			 * (which makes sure the pen was in reset if it
-			 * was powered) and then we set it high here to
-			 * take it out of reset.  Better would be if the
-			 * pen driver could control this and we could
-			 * remove "output-high" here.
-			 */
-			output-high; /* TODO: Remove this? */
-		};
+		/*
+		 * The pen driver doesn't currently support
+		 * driving this reset line.  By specifying
+		 * output-high here we're relying on the fact
+		 * that this pin has a default pulldown at boot
+		 * (which makes sure the pen was in reset if it
+		 * was powered) and then we set it high here to
+		 * take it out of reset.  Better would be if the
+		 * pen driver could control this and we could
+		 * remove "output-high" here.
+		 */
+		output-high; /* TODO: Remove this? */
 	};
 
-	p_sensor_int_l: p-sensor-int-l {
-		pinmux {
-			pins = "gpio24";
-			function = "gpio";
-			input-enable;
-		};
+	p_sensor_int_l: p-sensor-int-l-state {
+		pins = "gpio24";
+		function = "gpio";
+		input-enable;
 
-		pinconf {
-			pins = "gpio24";
-			/* Has external pullup */
-			bias-disable;
-		};
+		/* Has external pullup */
+		bias-disable;
 	};
 
-	qup_spi0_cs_gpio_init_high: qup-spi0-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio37";
-			output-high;
-		};
+	qup_spi0_cs_gpio_init_high: qup-spi0-cs-gpio-init-high-state {
+		pins = "gpio37";
+		function = "gpio";
+		output-high;
 	};
 
-	qup_spi6_cs_gpio_init_high: qup-spi6-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio62";
-			output-high;
-		};
+	qup_spi6_cs_gpio_init_high: qup-spi6-cs-gpio-init-high-state {
+		pins = "gpio62";
+		function = "gpio";
+		output-high;
 	};
 
-	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio89";
-			output-high;
-		};
+	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-state {
+		pins = "gpio89";
+		function = "gpio";
+		output-high;
 	};
 
-	qup_uart3_sleep: qup-uart3-sleep {
-		pinmux {
-			pins = "gpio38", "gpio39",
-			       "gpio40", "gpio41";
-			function = "gpio";
-		};
-
-		pinconf-cts {
+	qup_uart3_sleep: qup-uart3-sleep-state {
+		cts-pins {
 			/*
 			 * Configure a pull-down on CTS to match the pull of
 			 * the Bluetooth module.
 			 */
 			pins = "gpio38";
+			function = "gpio";
 			bias-pull-down;
 		};
 
-		pinconf-rts {
+		rts-pins {
 			/*
 			 * Configure pull-down on RTS. As RTS is active low
 			 * signal, pull it low to indicate the BT SoC that it
 			 * can wakeup the system anytime from suspend state by
 			 * pulling RX low (by sending wakeup bytes).
 			 */
-			 pins = "gpio39";
-			 bias-pull-down;
+			pins = "gpio39";
+			function = "gpio";
+			bias-pull-down;
 		};
 
-		pinconf-tx {
+		tx-pins {
 			/*
 			 * Configure pull-up on TX when it isn't actively driven
 			 * to prevent BT SoC from receiving garbage during sleep.
 			 */
 			pins = "gpio40";
+			function = "gpio";
 			bias-pull-up;
 		};
 
-		pinconf-rx {
+		rx-pins {
 			/*
 			 * Configure a pull-up on RX. This is needed to avoid
 			 * garbage data when the TX pin of the Bluetooth module
 			 * is floating which may cause spurious wakeups.
 			 */
 			pins = "gpio41";
+			function = "gpio";
 			bias-pull-up;
 		};
 	};
 
 	/* Named trackpad_int_1v8_odl on earlier revision schematics */
 	trackpad_int_1v8_odl:
-	tp_int_odl: tp-int-odl {
-		pinmux {
-			pins = "gpio0";
-			function = "gpio";
-		};
+	tp_int_odl: tp-int-odl-state {
+		pins = "gpio0";
+		function = "gpio";
 
-		pinconf {
-			pins = "gpio0";
-
-			/* Has external pullup */
-			bias-disable;
-		};
+		/* Has external pullup */
+		bias-disable;
 	};
 
-	ts_int_l: ts-int-l {
-		pinmux  {
-			pins = "gpio9";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio9";
-			bias-pull-up;
-		};
+	ts_int_l: ts-int-l-state {
+		pins = "gpio9";
+		function = "gpio";
+		bias-pull-up;
 	};
 
-	ts_reset_l: ts-reset-l {
-		pinmux  {
-			pins = "gpio8";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio8";
-			bias-disable;
-			drive-strength = <2>;
-		};
+	ts_reset_l: ts-reset-l-state {
+		pins = "gpio8";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
 	};
 
-	sdc1_on: sdc1-on {
-		pinconf-clk {
+	sdc1_on: sdc1-on-state {
+		clk-pins {
 			pins = "sdc1_clk";
 			bias-disable;
 			drive-strength = <16>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc1_cmd";
 			bias-pull-up;
 			drive-strength = <16>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc1_data";
 			bias-pull-up;
 			drive-strength = <16>;
 		};
 
-		pinconf-rclk {
+		rclk-pins {
 			pins = "sdc1_rclk";
 			bias-pull-down;
 		};
 	};
 
-	sdc1_off: sdc1-off {
-		pinconf-clk {
+	sdc1_off: sdc1-off-state {
+		clk-pins {
 			pins = "sdc1_clk";
 			bias-disable;
 			drive-strength = <2>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc1_cmd";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc1_data";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-rclk {
+		rclk-pins {
 			pins = "sdc1_rclk";
 			bias-pull-down;
 		};
 	};
 
-	sdc2_on: sdc2-on {
-		pinconf-clk {
+	sdc2_on: sdc2-on-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;
 			drive-strength = <16>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc2_data";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		pinconf-sd-cd {
+		sd-cd-pins {
 			pins = "gpio69";
+			function = "gpio";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 	};
 
-	sdc2_off: sdc2-off {
-		pinconf-clk {
+	sdc2_off: sdc2-off-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;
 			drive-strength = <2>;
 		};
 
-		pinconf-cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-data {
+		data-pins {
 			pins = "sdc2_data";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		pinconf-sd-cd {
+		sd-cd-pins {
 			pins = "gpio69";
+			function = "gpio";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 	};
 
-	uf_cam_en: uf-cam-en {
-		pinmux {
-			pins = "gpio6";
-			function = "gpio";
-		};
+	uf_cam_en: uf-cam-en-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
 
-		pinconf {
-			pins = "gpio6";
-			drive-strength = <2>;
-			/* External pull down */
-			bias-disable;
-		};
+		/* External pull down */
+		bias-disable;
 	};
 
-	wf_cam_en: wf-cam-en {
-		pinmux {
-			pins = "gpio7";
-			function = "gpio";
-		};
+	wf_cam_en: wf-cam-en-state {
+		pins = "gpio7";
+		function = "gpio";
+		drive-strength = <2>;
 
-		pinconf {
-			pins = "gpio7";
-			drive-strength = <2>;
-			/* External pull down */
-			bias-disable;
-		};
+		/* External pull down */
+		bias-disable;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 58976a1ba06b..9f465662bd49 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -795,7 +795,7 @@ spi0: spi@880000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi0_default>;
+				pinctrl-0 = <&qup_spi0_spi>, <&qup_spi0_cs>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -849,7 +849,7 @@ spi1: spi@884000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi1_default>;
+				pinctrl-0 = <&qup_spi1_spi>, <&qup_spi1_cs>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -939,7 +939,7 @@ spi3: spi@88c000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi3_default>;
+				pinctrl-0 = <&qup_spi3_spi>, <&qup_spi3_cs>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1029,7 +1029,7 @@ spi5: spi@894000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi5_default>;
+				pinctrl-0 = <&qup_spi5_spi>, <&qup_spi5_cs>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1096,7 +1096,7 @@ spi6: spi@a80000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi6_default>;
+				pinctrl-0 = <&qup_spi6_spi>, <&qup_spi6_cs>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1186,7 +1186,7 @@ spi8: spi@a88000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi8_default>;
+				pinctrl-0 = <&qup_spi8_spi>, <&qup_spi8_cs>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1276,7 +1276,7 @@ spi10: spi@a90000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi10_default>;
+				pinctrl-0 = <&qup_spi10_spi>, <&qup_spi10_cs>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1330,7 +1330,7 @@ spi11: spi@a94000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_spi11_default>;
+				pinctrl-0 = <&qup_spi11_spi>, <&qup_spi11_cs>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1486,410 +1486,443 @@ tlmm: pinctrl@3500000 {
 			gpio-ranges = <&tlmm 0 0 120>;
 			wakeup-parent = <&pdc>;
 
-			dp_hot_plug_det: dp-hot-plug-det {
-				pinmux {
-					pins = "gpio117";
-					function = "dp_hot";
-				};
+			dp_hot_plug_det: dp-hot-plug-det-state {
+				pins = "gpio117";
+				function = "dp_hot";
 			};
 
-			qspi_clk: qspi-clk {
-				pinmux {
-					pins = "gpio63";
-					function = "qspi_clk";
-				};
+			qspi_clk: qspi-clk-state {
+				pins = "gpio63";
+				function = "qspi_clk";
 			};
 
-			qspi_cs0: qspi-cs0 {
-				pinmux {
-					pins = "gpio68";
-					function = "qspi_cs";
-				};
+			qspi_cs0: qspi-cs0-state {
+				pins = "gpio68";
+				function = "qspi_cs";
 			};
 
-			qspi_cs1: qspi-cs1 {
-				pinmux {
-					pins = "gpio72";
-					function = "qspi_cs";
-				};
+			qspi_cs1: qspi-cs1-state {
+				pins = "gpio72";
+				function = "qspi_cs";
 			};
 
-			qspi_data01: qspi-data01 {
-				pinmux-data {
-					pins = "gpio64", "gpio65";
-					function = "qspi_data";
-				};
+			qspi_data01: qspi-data01-state {
+				pins = "gpio64", "gpio65";
+				function = "qspi_data";
 			};
 
-			qspi_data12: qspi-data12 {
-				pinmux-data {
-					pins = "gpio66", "gpio67";
-					function = "qspi_data";
-				};
+			qspi_data12: qspi-data12-state {
+				pins = "gpio66", "gpio67";
+				function = "qspi_data";
 			};
 
-			qup_i2c0_default: qup-i2c0-default {
-				pinmux {
-					pins = "gpio34", "gpio35";
-					function = "qup00";
-				};
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio34", "gpio35";
+				function = "qup00";
 			};
 
-			qup_i2c1_default: qup-i2c1-default {
-				pinmux {
-					pins = "gpio0", "gpio1";
-					function = "qup01";
-				};
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup01";
 			};
 
-			qup_i2c2_default: qup-i2c2-default {
-				pinmux {
-					pins = "gpio15", "gpio16";
-					function = "qup02_i2c";
-				};
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio15", "gpio16";
+				function = "qup02_i2c";
 			};
 
-			qup_i2c3_default: qup-i2c3-default {
-				pinmux {
-					pins = "gpio38", "gpio39";
-					function = "qup03";
-				};
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio38", "gpio39";
+				function = "qup03";
 			};
 
-			qup_i2c4_default: qup-i2c4-default {
-				pinmux {
-					pins = "gpio115", "gpio116";
-					function = "qup04_i2c";
-				};
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio115", "gpio116";
+				function = "qup04_i2c";
 			};
 
-			qup_i2c5_default: qup-i2c5-default {
-				pinmux {
-					pins = "gpio25", "gpio26";
-					function = "qup05";
-				};
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio25", "gpio26";
+				function = "qup05";
 			};
 
-			qup_i2c6_default: qup-i2c6-default {
-				pinmux {
-					pins = "gpio59", "gpio60";
-					function = "qup10";
-				};
+			qup_i2c6_default: qup-i2c6-default-state {
+				pins = "gpio59", "gpio60";
+				function = "qup10";
 			};
 
-			qup_i2c7_default: qup-i2c7-default {
-				pinmux {
-					pins = "gpio6", "gpio7";
-					function = "qup11_i2c";
-				};
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins = "gpio6", "gpio7";
+				function = "qup11_i2c";
 			};
 
-			qup_i2c8_default: qup-i2c8-default {
-				pinmux {
-					pins = "gpio42", "gpio43";
-					function = "qup12";
-				};
+			qup_i2c8_default: qup-i2c8-default-state {
+				pins = "gpio42", "gpio43";
+				function = "qup12";
 			};
 
-			qup_i2c9_default: qup-i2c9-default {
-				pinmux {
-					pins = "gpio46", "gpio47";
-					function = "qup13_i2c";
-				};
+			qup_i2c9_default: qup-i2c9-default-state {
+				pins = "gpio46", "gpio47";
+				function = "qup13_i2c";
 			};
 
-			qup_i2c10_default: qup-i2c10-default {
-				pinmux {
-					pins = "gpio86", "gpio87";
-					function = "qup14";
-				};
+			qup_i2c10_default: qup-i2c10-default-state {
+				pins = "gpio86", "gpio87";
+				function = "qup14";
 			};
 
-			qup_i2c11_default: qup-i2c11-default {
-				pinmux {
-					pins = "gpio53", "gpio54";
-					function = "qup15";
-				};
+			qup_i2c11_default: qup-i2c11-default-state {
+				pins = "gpio53", "gpio54";
+				function = "qup15";
+			};
+
+			qup_spi0_spi: qup-spi0-spi-state {
+				pins = "gpio34", "gpio35", "gpio36";
+				function = "qup00";
+			};
+
+			qup_spi0_cs: qup-spi0-cs-state {
+				pins = "gpio37";
+				function = "qup00";
+			};
+
+			qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
+				pins = "gpio37";
+				function = "gpio";
+			};
+
+			qup_spi1_spi: qup-spi1-spi-state {
+				pins = "gpio0", "gpio1", "gpio2";
+				function = "qup01";
+			};
+
+			qup_spi1_cs: qup-spi1-cs-state {
+				pins = "gpio3";
+				function = "qup01";
+			};
+
+			qup_spi1_cs_gpio: qup-spi1-cs-gpio-state {
+				pins = "gpio3";
+				function = "gpio";
+			};
+
+			qup_spi3_spi: qup-spi3-spi-state {
+				pins = "gpio38", "gpio39", "gpio40";
+				function = "qup03";
+			};
+
+			qup_spi3_cs: qup-spi3-cs-state {
+				pins = "gpio41";
+				function = "qup03";
 			};
 
-			qup_spi0_default: qup-spi0-default {
-				pinmux {
-					pins = "gpio34", "gpio35",
-					       "gpio36", "gpio37";
+			qup_spi3_cs_gpio: qup-spi3-cs-gpio-state {
+				pins = "gpio41";
+				function = "gpio";
+			};
+
+			qup_spi5_spi: qup-spi5-spi-state {
+				pins = "gpio25", "gpio26", "gpio27";
+				function = "qup05";
+			};
+
+			qup_spi5_cs: qup-spi5-cs-state {
+				pins = "gpio28";
+				function = "qup05";
+			};
+
+			qup_spi5_cs_gpio: qup-spi5-cs-gpio-state {
+				pins = "gpio28";
+				function = "gpio";
+			};
+
+			qup_spi6_spi: qup-spi6-spi-state {
+				pins = "gpio59", "gpio60", "gpio61";
+				function = "qup10";
+			};
+
+			qup_spi6_cs: qup-spi6-cs-state {
+				pins = "gpio62";
+				function = "qup10";
+			};
+
+			qup_spi6_cs_gpio: qup-spi6-cs-gpio-state {
+				pins = "gpio62";
+				function = "gpio";
+			};
+
+			qup_spi8_spi: qup-spi8-spi-state {
+				pins = "gpio42", "gpio43", "gpio44";
+				function = "qup12";
+			};
+
+			qup_spi8_cs: qup-spi8-cs-state {
+				pins = "gpio45";
+				function = "qup12";
+			};
+
+			qup_spi8_cs_gpio: qup-spi8-cs-gpio-state {
+				pins = "gpio45";
+				function = "gpio";
+			};
+
+			qup_spi10_spi: qup-spi10-spi-state {
+				pins = "gpio86", "gpio87", "gpio88";
+				function = "qup14";
+			};
+
+			qup_spi10_cs: qup-spi10-cs-state {
+				pins = "gpio89";
+				function = "qup14";
+			};
+
+			qup_spi10_cs_gpio: qup-spi10-cs-gpio-state {
+				pins = "gpio89";
+				function = "gpio";
+			};
+
+			qup_spi11_spi: qup-spi11-spi-state {
+				pins = "gpio53", "gpio54", "gpio55";
+				function = "qup15";
+			};
+
+			qup_spi11_cs: qup-spi11-cs-state {
+				pins = "gpio56";
+				function = "qup15";
+			};
+
+			qup_spi11_cs_gpio: qup-spi11-cs-gpio-state {
+				pins = "gpio56";
+				function = "gpio";
+			};
+
+			qup_uart0_default: qup-uart0-default-state {
+				qup_uart0_cts: cts-pins {
+					pins = "gpio34";
 					function = "qup00";
 				};
-			};
 
-			qup_spi0_cs_gpio: qup-spi0-cs-gpio {
-				pinmux {
-					pins = "gpio34", "gpio35",
-					       "gpio36";
+				qup_uart0_rts: rts-pins {
+					pins = "gpio35";
 					function = "qup00";
 				};
 
-				pinmux-cs {
+				qup_uart0_tx: tx-pins {
+					pins = "gpio36";
+					function = "qup00";
+				};
+
+				qup_uart0_rx: rx-pins {
 					pins = "gpio37";
-					function = "gpio";
+					function = "qup00";
 				};
 			};
 
-			qup_spi1_default: qup-spi1-default {
-				pinmux {
-					pins = "gpio0", "gpio1",
-					       "gpio2", "gpio3";
+			qup_uart1_default: qup-uart1-default-state {
+				qup_uart1_cts: cts-pins {
+					pins = "gpio0";
 					function = "qup01";
 				};
-			};
 
-			qup_spi1_cs_gpio: qup-spi1-cs-gpio {
-				pinmux {
-					pins = "gpio0", "gpio1",
-					       "gpio2";
+				qup_uart1_rts: rts-pins {
+					pins = "gpio1";
 					function = "qup01";
 				};
 
-				pinmux-cs {
-					pins = "gpio3";
-					function = "gpio";
+				qup_uart1_tx: tx-pins {
+					pins = "gpio2";
+					function = "qup01";
 				};
-			};
 
-			qup_spi3_default: qup-spi3-default {
-				pinmux {
-					pins = "gpio38", "gpio39",
-					       "gpio40", "gpio41";
-					function = "qup03";
+				qup_uart1_rx: rx-pins {
+					pins = "gpio3";
+					function = "qup01";
 				};
 			};
 
-			qup_spi3_cs_gpio: qup-spi3-cs-gpio {
-				pinmux {
-					pins = "gpio38", "gpio39",
-					       "gpio40";
-					function = "qup03";
+			qup_uart2_default: qup-uart2-default-state {
+				qup_uart2_tx: tx-pins {
+					pins = "gpio15";
+					function = "qup02_uart";
 				};
 
-				pinmux-cs {
-					pins = "gpio41";
-					function = "gpio";
+				qup_uart2_rx: rx-pins {
+					pins = "gpio16";
+					function = "qup02_uart";
 				};
 			};
 
-			qup_spi5_default: qup-spi5-default {
-				pinmux {
-					pins = "gpio25", "gpio26",
-					       "gpio27", "gpio28";
-					function = "qup05";
+			qup_uart3_default: qup-uart3-default-state {
+				qup_uart3_cts: cts-pins {
+					pins = "gpio38";
+					function = "qup03";
 				};
-			};
 
-			qup_spi5_cs_gpio: qup-spi5-cs-gpio {
-				pinmux {
-					pins = "gpio25", "gpio26",
-					       "gpio27";
-					function = "qup05";
+				qup_uart3_rts: rts-pins {
+					pins = "gpio39";
+					function = "qup03";
 				};
 
-				pinmux-cs {
-					pins = "gpio28";
-					function = "gpio";
+				qup_uart3_tx: tx-pins {
+					pins = "gpio40";
+					function = "qup03";
 				};
-			};
 
-			qup_spi6_default: qup-spi6-default {
-				pinmux {
-					pins = "gpio59", "gpio60",
-					       "gpio61", "gpio62";
-					function = "qup10";
+				qup_uart3_rx: rx-pins {
+					pins = "gpio41";
+					function = "qup03";
 				};
 			};
 
-			qup_spi6_cs_gpio: qup-spi6-cs-gpio {
-				pinmux {
-					pins = "gpio59", "gpio60",
-					       "gpio61";
-					function = "qup10";
+			qup_uart4_default: qup-uart4-default-state {
+				qup_uart4_tx: tx-pins {
+					pins = "gpio115";
+					function = "qup04_uart";
 				};
 
-				pinmux-cs {
-					pins = "gpio62";
-					function = "gpio";
+				qup_uart4_rx: rx-pins {
+					pins = "gpio116";
+					function = "qup04_uart";
 				};
 			};
 
-			qup_spi8_default: qup-spi8-default {
-				pinmux {
-					pins = "gpio42", "gpio43",
-					       "gpio44", "gpio45";
-					function = "qup12";
+			qup_uart5_default: qup-uart5-default-state {
+				qup_uart5_cts: cts-pins {
+					pins = "gpio25";
+					function = "qup05";
 				};
-			};
 
-			qup_spi8_cs_gpio: qup-spi8-cs-gpio {
-				pinmux {
-					pins = "gpio42", "gpio43",
-					       "gpio44";
-					function = "qup12";
+				qup_uart5_rts: rts-pins {
+					pins = "gpio26";
+					function = "qup05";
 				};
 
-				pinmux-cs {
-					pins = "gpio45";
-					function = "gpio";
+				qup_uart5_tx: tx-pins {
+					pins = "gpio27";
+					function = "qup05";
 				};
-			};
 
-			qup_spi10_default: qup-spi10-default {
-				pinmux {
-					pins = "gpio86", "gpio87",
-					       "gpio88", "gpio89";
-					function = "qup14";
+				qup_uart5_rx: rx-pins {
+					pins = "gpio28";
+					function = "qup05";
 				};
 			};
 
-			qup_spi10_cs_gpio: qup-spi10-cs-gpio {
-				pinmux {
-					pins = "gpio86", "gpio87",
-					       "gpio88";
-					function = "qup14";
+			qup_uart6_default: qup-uart6-default-state {
+				qup_uart6_cts: cts-pins {
+					pins = "gpio59";
+					function = "qup10";
 				};
 
-				pinmux-cs {
-					pins = "gpio89";
-					function = "gpio";
+				qup_uart6_rts: rts-pins {
+					pins = "gpio60";
+					function = "qup10";
 				};
-			};
 
-			qup_spi11_default: qup-spi11-default {
-				pinmux {
-					pins = "gpio53", "gpio54",
-					       "gpio55", "gpio56";
-					function = "qup15";
+				qup_uart6_tx: tx-pins {
+					pins = "gpio61";
+					function = "qup10";
+				};
+
+				qup_uart6_rx: rx-pins {
+					pins = "gpio62";
+					function = "qup10";
 				};
 			};
 
-			qup_spi11_cs_gpio: qup-spi11-cs-gpio {
-				pinmux {
-					pins = "gpio53", "gpio54",
-					       "gpio55";
-					function = "qup15";
+			qup_uart7_default: qup-uart7-default-state {
+				qup_uart7_tx: tx-pins {
+					pins = "gpio6";
+					function = "qup11_uart";
 				};
 
-				pinmux-cs {
-					pins = "gpio56";
-					function = "gpio";
+				qup_uart7_rx: rx-pins {
+					pins = "gpio7";
+					function = "qup11_uart";
 				};
 			};
 
-			qup_uart0_default: qup-uart0-default {
-				pinmux {
-					pins = "gpio34", "gpio35",
-					       "gpio36", "gpio37";
-					function = "qup00";
+			qup_uart8_default: qup-uart8-default-state {
+				qup_uart8_tx: tx-pins {
+					pins = "gpio44";
+					function = "qup12";
 				};
-			};
 
-			qup_uart1_default: qup-uart1-default {
-				pinmux {
-					pins = "gpio0", "gpio1",
-					       "gpio2", "gpio3";
-					function = "qup01";
+				qup_uart8_rx: rx-pins {
+					pins = "gpio45";
+					function = "qup12";
 				};
 			};
 
-			qup_uart2_default: qup-uart2-default {
-				pinmux {
-					pins = "gpio15", "gpio16";
-					function = "qup02_uart";
+			qup_uart9_default: qup-uart9-default-state {
+				qup_uart9_tx: tx-pins {
+					pins = "gpio46";
+					function = "qup13_uart";
 				};
-			};
 
-			qup_uart3_default: qup-uart3-default {
-				pinmux {
-					pins = "gpio38", "gpio39",
-					       "gpio40", "gpio41";
-					function = "qup03";
+				qup_uart9_rx: rx-pins {
+					pins = "gpio47";
+					function = "qup13_uart";
 				};
 			};
 
-			qup_uart4_default: qup-uart4-default {
-				pinmux {
-					pins = "gpio115", "gpio116";
-					function = "qup04_uart";
+			qup_uart10_default: qup-uart10-default-state {
+				qup_uart10_cts: cts-pins {
+					pins = "gpio86";
+					function = "qup14";
 				};
-			};
 
-			qup_uart5_default: qup-uart5-default {
-				pinmux {
-					pins = "gpio25", "gpio26",
-					       "gpio27", "gpio28";
-					function = "qup05";
+				qup_uart10_rts: rts-pins {
+					pins = "gpio87";
+					function = "qup14";
 				};
-			};
 
-			qup_uart6_default: qup-uart6-default {
-				pinmux {
-					pins = "gpio59", "gpio60",
-					       "gpio61", "gpio62";
-					function = "qup10";
+				qup_uart10_tx: tx-pins {
+					pins = "gpio88";
+					function = "qup14";
 				};
-			};
 
-			qup_uart7_default: qup-uart7-default {
-				pinmux {
-					pins = "gpio6", "gpio7";
-					function = "qup11_uart";
+				qup_uart10_rx: rx-pins {
+					pins = "gpio89";
+					function = "qup14";
 				};
 			};
 
-			qup_uart8_default: qup-uart8-default {
-				pinmux {
-					pins = "gpio44", "gpio45";
-					function = "qup12";
+			qup_uart11_default: qup-uart11-default-state {
+				qup_uart11_cts: cts-pins {
+					pins = "gpio53";
+					function = "qup15";
 				};
-			};
 
-			qup_uart9_default: qup-uart9-default {
-				pinmux {
-					pins = "gpio46", "gpio47";
-					function = "qup13_uart";
+				qup_uart11_rts: rts-pins {
+					pins = "gpio54";
+					function = "qup15";
 				};
-			};
 
-			qup_uart10_default: qup-uart10-default {
-				pinmux {
-					pins = "gpio86", "gpio87",
-					       "gpio88", "gpio89";
-					function = "qup14";
+				qup_uart11_tx: tx-pins {
+					pins = "gpio55";
+					function = "qup15";
 				};
-			};
 
-			qup_uart11_default: qup-uart11-default {
-				pinmux {
-					pins = "gpio53", "gpio54",
-					       "gpio55", "gpio56";
+				qup_uart11_rx: rx-pins {
+					pins = "gpio56";
 					function = "qup15";
 				};
 			};
 
-			sec_mi2s_active: sec-mi2s-active {
-				pinmux {
-					pins = "gpio49", "gpio50", "gpio51";
-					function = "mi2s_1";
-				};
+			sec_mi2s_active: sec-mi2s-active-state {
+				pins = "gpio49", "gpio50", "gpio51";
+				function = "mi2s_1";
 			};
 
-			pri_mi2s_active: pri-mi2s-active {
-				pinmux {
-					pins = "gpio53", "gpio54", "gpio55", "gpio56";
-					function = "mi2s_0";
-				};
+			pri_mi2s_active: pri-mi2s-active-state {
+				pins = "gpio53", "gpio54", "gpio55", "gpio56";
+				function = "mi2s_0";
 			};
 
-			pri_mi2s_mclk_active: pri-mi2s-mclk-active {
-				pinmux {
-					pins = "gpio57";
-					function = "lpass_ext";
-				};
+			pri_mi2s_mclk_active: pri-mi2s-mclk-active-state {
+				pins = "gpio57";
+				function = "lpass_ext";
 			};
 		};
 
-- 
2.34.1

