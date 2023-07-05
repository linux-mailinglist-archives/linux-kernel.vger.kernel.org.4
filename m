Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A0748740
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjGEPBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjGEPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:01:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E532E19A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:00:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992b27e1c55so791971066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569236; x=1691161236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMKYbPXW5rHj5BSYtZkxoAiCwGu8BA7vkHu7UcyELvY=;
        b=U16jkIvJ9bwdoZDbuJA8IPkqOCJ5uxIqnJ6Ur8lhQuAhY4RdCrfbJkJaePqWx1o2jO
         J1D2HU74PLZvb6ozWlEkrGMdTw74lh4v670I5Ejyx748xG7YmCJ/MzZq3MyTx16ee1qu
         nEEG/vfFqIXteUBInsYIzBABA0r5sBiRz/jTpiUbg5uVuubSDDbEErDkjIFaq2IiJ0wS
         v3iK9NYJ6t4rpVVDVkb37qA630LyRR9QiVbGjk7X7OkZBq7NhWcsZN678Yt5RR9WnLAe
         jEKG7DsXwDq5IAXwj0dgOd5vSaCx7onlQH9P9FF+BKk1blALz9V3CyB3dvgANATycBP7
         d5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569236; x=1691161236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMKYbPXW5rHj5BSYtZkxoAiCwGu8BA7vkHu7UcyELvY=;
        b=YzlEOPbXfnFHP3xHjAVtntat612Fb+e2hCjBSbtmUVv1ja0EqB/hyy4ZFgXqBMxEkp
         L/JHMOO91UEc36sHjlJt9aSwHkRhwx9avy63085nUUe9q14tq2q8zVDXncMwY0WbhDPM
         iozi8/fy3bqfelUZS6zNmIWWfs3yPBXodxTSdgRctr3uzYnApXvX/H0NAqIUQ9SDzVAT
         2YwuKrdCy+edVq6yQw0VTE0gQlKiualRAElSW9RJi4cK+2BC56plT5euzlhrSdsrTpMs
         cKVTh59pUhbhngE3otS11mJOf1h5XURUWr8A/DLb2Uw218Z97ZS1PZn7+bTmQmTQQBNE
         Y53w==
X-Gm-Message-State: ABy/qLaZ0gVRZgjE0hjks8vcS6SaA17MxjB+HQRzK3y2HecqcjMvPBko
        EE5xM/m25se9+axlJ+Qn6NloDQ==
X-Google-Smtp-Source: APBJJlGFsoT+lD+UucgjrQQG8RmZs3tol/dGrf4EnANjg0F+j2HLFyVI+1vK2drfL59yK/Le+Ow5Nw==
X-Received: by 2002:a17:906:a38b:b0:991:f207:411e with SMTP id k11-20020a170906a38b00b00991f207411emr11021642ejz.69.1688569236626;
        Wed, 05 Jul 2023 08:00:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y12-20020a170906558c00b0098e78ff1a87sm13096344ejp.120.2023.07.05.08.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:00:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: st: add missing space before {
Date:   Wed,  5 Jul 2023 17:00:33 +0200
Message-Id: <20230705150033.293832-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/st/spear1310.dtsi                    |  2 +-
 arch/arm/boot/dts/st/spear1340.dtsi                    |  2 +-
 arch/arm/boot/dts/st/stih407-family.dtsi               |  2 +-
 arch/arm/boot/dts/st/stih407-pinctrl.dtsi              | 10 +++++-----
 arch/arm/boot/dts/st/stm32f429-disco.dts               |  2 +-
 arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi            |  2 +-
 arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi            |  2 +-
 arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi              |  6 +++---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi            |  4 ++--
 arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1.dtsi   |  6 +++---
 .../arm/boot/dts/st/stm32mp157a-microgea-stm32mp1.dtsi |  6 +++---
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/st/spear1310.dtsi b/arch/arm/boot/dts/st/spear1310.dtsi
index 2f746a9428a7..ba827d60bf07 100644
--- a/arch/arm/boot/dts/st/spear1310.dtsi
+++ b/arch/arm/boot/dts/st/spear1310.dtsi
@@ -11,7 +11,7 @@ / {
 	compatible = "st,spear1310";
 
 	ahb {
-		spics: spics@e0700000{
+		spics: spics@e0700000 {
 			compatible = "st,spear-spics-gpio";
 			reg = <0xe0700000 0x1000>;
 			st-spics,peripcfg-reg = <0x3b0>;
diff --git a/arch/arm/boot/dts/st/spear1340.dtsi b/arch/arm/boot/dts/st/spear1340.dtsi
index 818886e11713..d54e10629a7d 100644
--- a/arch/arm/boot/dts/st/spear1340.dtsi
+++ b/arch/arm/boot/dts/st/spear1340.dtsi
@@ -12,7 +12,7 @@ / {
 
 	ahb {
 
-		spics: spics@e0700000{
+		spics: spics@e0700000 {
 			compatible = "st,spear-spics-gpio";
 			reg = <0xe0700000 0x1000>;
 			st-spics,peripcfg-reg = <0x42c>;
diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
index 5ebb77947fd9..3f58383a7b59 100644
--- a/arch/arm/boot/dts/st/stih407-family.dtsi
+++ b/arch/arm/boot/dts/st/stih407-family.dtsi
@@ -645,7 +645,7 @@ lpc@8788000 {
 			st,lpc-mode = <ST_LPC_MODE_CLKSRC>;
 		};
 
-		spifsm: spifsm@9022000{
+		spifsm: spifsm@9022000 {
 			compatible = "st,spi-fsm";
 			reg = <0x9022000 0x1000>;
 			reg-names = "spi-fsm";
diff --git a/arch/arm/boot/dts/st/stih407-pinctrl.dtsi b/arch/arm/boot/dts/st/stih407-pinctrl.dtsi
index 2cf335714ca2..7815669fe813 100644
--- a/arch/arm/boot/dts/st/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stih407-pinctrl.dtsi
@@ -1090,7 +1090,7 @@ st,pins {
 			};
 
 			i2s_out {
-				pinctrl_i2s_8ch_out: i2s_8ch_out{
+				pinctrl_i2s_8ch_out: i2s_8ch_out {
 					st,pins {
 						mclk = <&pio33 5 ALT1 OUT>;
 						lrclk = <&pio33 7 ALT1 OUT>;
@@ -1102,7 +1102,7 @@ st,pins {
 					};
 				};
 
-				pinctrl_i2s_2ch_out: i2s_2ch_out{
+				pinctrl_i2s_2ch_out: i2s_2ch_out {
 					st,pins {
 						mclk = <&pio33 5 ALT1 OUT>;
 						lrclk = <&pio33 7 ALT1 OUT>;
@@ -1113,7 +1113,7 @@ st,pins {
 			};
 
 			i2s_in {
-				pinctrl_i2s_8ch_in: i2s_8ch_in{
+				pinctrl_i2s_8ch_in: i2s_8ch_in {
 					st,pins {
 						mclk = <&pio32 5 ALT1 IN>;
 						lrclk = <&pio32 7 ALT1 IN>;
@@ -1126,7 +1126,7 @@ st,pins {
 					};
 				};
 
-				pinctrl_i2s_2ch_in: i2s_2ch_in{
+				pinctrl_i2s_2ch_in: i2s_2ch_in {
 					st,pins {
 						mclk = <&pio32 5 ALT1 IN>;
 						lrclk = <&pio32 7 ALT1 IN>;
@@ -1137,7 +1137,7 @@ st,pins {
 			};
 
 			spdif_out {
-				pinctrl_spdif_out: spdif_out{
+				pinctrl_spdif_out: spdif_out {
 					st,pins {
 						spdif_out = <&pio34 7 ALT1 OUT>;
 					};
diff --git a/arch/arm/boot/dts/st/stm32f429-disco.dts b/arch/arm/boot/dts/st/stm32f429-disco.dts
index 3b81228d46a2..a3cb4aabdd5a 100644
--- a/arch/arm/boot/dts/st/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f429-disco.dts
@@ -190,7 +190,7 @@ l3gd20: l3gd20@0 {
 		status = "okay";
 	};
 
-	display: display@1{
+	display: display@1 {
 		/* Connect panel-ilitek-9341 to ltdc */
 		compatible = "st,sf-tc240t-9370-t", "ilitek,ili9341";
 		reg = <1>;
diff --git a/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
index fcfd2ac7239b..781197ef42d6 100644
--- a/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
@@ -6,6 +6,6 @@
 
 #include "stm32f7-pinctrl.dtsi"
 
-&pinctrl{
+&pinctrl {
 	compatible = "st,stm32f746-pinctrl";
 };
diff --git a/arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi
index 31005dd9929c..c26abc04e2ce 100644
--- a/arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi
@@ -6,6 +6,6 @@
 
 #include "stm32f7-pinctrl.dtsi"
 
-&pinctrl{
+&pinctrl {
 	compatible = "st,stm32f769-pinctrl";
 };
diff --git a/arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi
index aa1bc3e10a49..7f1d234e1024 100644
--- a/arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi
@@ -94,7 +94,7 @@ pins1 {
 			drive-push-pull;
 			bias-disable;
 		};
-		pins2{
+		pins2 {
 			pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
 			slew-rate = <3>;
 			drive-open-drain;
@@ -122,7 +122,7 @@ pins1 {
 			drive-push-pull;
 			bias-pull-up;
 		};
-		pins2{
+		pins2 {
 			pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
 			bias-pull-up;
 		};
@@ -162,7 +162,7 @@ pins1 {
 			drive-push-pull;
 			bias-disable;
 		};
-		pins2{
+		pins2 {
 			pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
 			slew-rate = <3>;
 			drive-open-drain;
diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index 06e969aa5fdb..05c9c4f8064c 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -1659,7 +1659,7 @@ pins1 {
 			drive-push-pull;
 			bias-pull-up;
 		};
-		pins2{
+		pins2 {
 			pinmux = <STM32_PINMUX('E', 4, AF8)>; /* SDMMC1_CKIN */
 			bias-pull-up;
 		};
@@ -1694,7 +1694,7 @@ pins1 {
 			drive-push-pull;
 			bias-pull-up;
 		};
-		pins2{
+		pins2 {
 			pinmux = <STM32_PINMUX('E', 4, AF8)>; /* SDMMC1_CKIN */
 			bias-pull-up;
 		};
diff --git a/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1.dtsi b/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1.dtsi
index 9de893101b40..569a7e940ecc 100644
--- a/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1.dtsi
@@ -165,12 +165,12 @@ &ipcc {
 	status = "okay";
 };
 
-&iwdg2{
+&iwdg2 {
 	timeout-sec = <32>;
 	status = "okay";
 };
 
-&m4_rproc{
+&m4_rproc {
 	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
 			<&vdev0vring1>, <&vdev0buffer>;
 	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
@@ -184,7 +184,7 @@ &rng1 {
 	status = "okay";
 };
 
-&rtc{
+&rtc {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1.dtsi b/arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1.dtsi
index fb4600a59869..a75f50cf7123 100644
--- a/arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1.dtsi
@@ -117,12 +117,12 @@ &ipcc {
 	status = "okay";
 };
 
-&iwdg2{
+&iwdg2 {
 	timeout-sec = <32>;
 	status = "okay";
 };
 
-&m4_rproc{
+&m4_rproc {
 	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
 			<&vdev0vring1>, <&vdev0buffer>;
 	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
@@ -136,7 +136,7 @@ &rng1 {
 	status = "okay";
 };
 
-&rtc{
+&rtc {
 	status = "okay";
 };
 
-- 
2.34.1

