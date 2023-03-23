Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901266C6F22
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjCWRci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjCWRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:32:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF623800E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i15so9704047pfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679592698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRxHjat8O8FYtA1vS1Ehqi9VaQ+n7ssLGElmobuUyNk=;
        b=U+4DEso+L/0m/PFXzT7CZpH9N8N0qk37EIGBUM9bYOrsWMIBtlO2tOyJBPL29QQwV4
         GJhQjcoCRMUsexIHCQ/f996IhXXdiUupT4oHps+65XZzI28Yo9q9VrTbsycdovu6fpKs
         mujXI+2Hz+scgy06KyIdr+3MPES2iK719bDgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRxHjat8O8FYtA1vS1Ehqi9VaQ+n7ssLGElmobuUyNk=;
        b=2NNRyAXdVOnysJ9zpEiuRvccpqJOr5ASJwyo03qKHepI/6j+ZP2iiZ07W3B/miNyD3
         iRad07N1QESh+o66B8b3E6Wrxo9/9YwohPJ3TR4ah7Rn7CEkrL2YcjxhnoJPx8TwEK/T
         R1CVaMCHTcJV4ovoV5eIKGxuXUwr9hRA2FTktsLLGp3X2oikelGFamO9DAnTRm3OOv08
         UscYC0xL9aL4SzFAWwO6O+M5poABxuvmwyo1ZLSr8smFPsdpEdum9jRXcTLmqvR6WXYs
         pMC0FhKeUetcAWtHRSWPHURTeaynSbvOcHOpcaWUFPCEplftswETK84g610x0bxMA31y
         i4Sw==
X-Gm-Message-State: AAQBX9crnQju6TnnLiT6ZdHe3KLGWQ65Rftptn8OsGU5E8jaPtwcScuv
        jNIsJ56zStrVxoJXQDux9MGoRw==
X-Google-Smtp-Source: AKy350Y9uI++VGMZHk8Z3V/GCLI2m4BsnZwP4JxPB7sf6iJ3SVpjUx00AyoX5UWoTsvS+s5PYYvTWw==
X-Received: by 2002:a62:18c4:0:b0:619:53de:8880 with SMTP id 187-20020a6218c4000000b0061953de8880mr187692pfy.16.1679592697823;
        Thu, 23 Mar 2023 10:31:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16d3:ef20:206a:6521])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm12613546pfm.171.2023.03.23.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:31:36 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] arm64: dts: qcom: sc7280: Fix qspi pin config
Date:   Thu, 23 Mar 2023 10:30:17 -0700
Message-Id: <20230323102605.13.Ib44c3e417c414a4227db8def75ded37ad368212c@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230323173019.3706069-1-dianders@chromium.org>
References: <20230323173019.3706069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to sc7180 (see the patch ("arm64: dts: qcom: sc7180: Fix
trogdor qspi pin config")), we should adjust the qspi pin config for
sc7280.

I won't re-describe all the research/arguments in the sc7180 patch
here, but there are a few differences for sc7280 worth noting:

1. On herobrine the SPI flash (qspi) is wired up differently on the
   board. Rather than Cr50 and the AP being wired directly together,
   there's actually a mux that will _either_ connect the AP to the
   flash or Cr50 to the flash. This means that the internal pulls on
   Cr50 don't affect us and we should enable our own pulldowns.

2. On herobrine, EEs added an external pulldown on the MISO line. The
   argument in the schematic said that we added it (but not one on
   MOSI and CLK) because Cr50 already enabled pulldowns on MOSI and
   CLK. ...though, as per #1, those Cr50 pulldowns would only affect
   the line when the mux was swung to Cr50.

The ironic result of #1 and #2 is that the external pulldowns on
CLK/MISO/MOSI on herobrine are _exactly opposite_ of the ones on
trogdor.

3. While I still don't have the actual exact schematics for all
   variants of IDP/CRD that were produced, I have some reference
   schematics that give me a belief of how the qspi is hooked up
   there. From this, I'm fairly certain that all of the older variants
   of IDP/CRD either have a pulldown on the CLK/MOSI/MISO lines (maybe
   through a direct connect to Cr50) or have no pull (in other words,
   they don't have a pullup). I'll go ahead and enable internal
   pulldowns on all the lines since that won't hurt to double-pull if
   there's an external pulldown and it's nice to have a pulldown if
   there's nothing external. Note that this only affects _older_
   CRDs. Newer revs are considered "herobrine" (see the hoglin/zoglin
   device trees).

4. I didn't find the same strange "auto-switch-to-keeper" at suspend
   when probing on sc7280. Whatever pulls (or lack thereof) I left at
   suspend time seemed to persist into suspend.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../boot/dts/qcom/sc7280-chrome-common.dtsi   | 25 +++++++++++++++++--
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 14 +++++++----
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      | 13 ++++++----
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  9 +++++--
 4 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 16fb20369c01..f562e4d2b655 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -60,8 +60,9 @@ &pmk8350_pon {
  */
 &qspi {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data01>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data0>, <&qspi_data1>;
+	pinctrl-1 = <&qspi_sleep>;
 
 	spi_flash: flash@0 {
 		compatible = "jedec,spi-nor";
@@ -85,3 +86,23 @@ wifi-firmware {
 		iommus = <&apps_smmu 0x1c02 0x1>;
 	};
 };
+
+/* PINCTRL - chrome-common pinctrl */
+
+&tlmm {
+	qspi_sleep: qspi-sleep-state {
+		pins = "gpio12", "gpio13", "gpio14", "gpio15";
+
+		/*
+		 * When we're not actively transferring we want pins as GPIOs
+		 * with output disabled so that the quad SPI IP block stops
+		 * driving them. We rely on the normal pulls configured in
+		 * the active state and don't redefine them here. Also note
+		 * that we don't need the reverse (output-enable) in the
+		 * normal mode since the "output-enable" only matters for
+		 * GPIO function.
+		 */
+		function = "gpio";
+		output-disable;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index b6137816f2f3..e651f633341f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -692,18 +692,22 @@ &pcie1_clkreq_n {
 };
 
 &qspi_cs0 {
-	bias-disable;
+	bias-disable;		/* External pullup */
 	drive-strength = <8>;
 };
 
 &qspi_clk {
-	bias-disable;
+	bias-pull-down;		/* No external pulls */
 	drive-strength = <8>;
 };
 
-&qspi_data01 {
-	/* High-Z when no transfers; nice to park the lines */
-	bias-pull-up;
+&qspi_data0 {
+	bias-pull-down;		/* No external pulls */
+	drive-strength = <8>;
+};
+
+&qspi_data1 {
+	bias-disable;		/* External pulldown */
 	drive-strength = <8>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 8b5293e7fd2a..6aaa77abc00b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -636,16 +636,19 @@ &pcie1_clkreq_n {
 };
 
 &qspi_cs0 {
-	bias-disable;
+	bias-disable;		/* External pullup */
 };
 
 &qspi_clk {
-	bias-disable;
+	bias-pull-down;		/* No external pulls or external pulldown */
 };
 
-&qspi_data01 {
-	/* High-Z when no transfers; nice to park the lines */
-	bias-pull-up;
+&qspi_data0 {
+	bias-pull-down;		/* No external pulls or external pulldown */
+};
+
+&qspi_data1 {
+	bias-pull-down;		/* No external pulls or external pulldown */
 };
 
 &qup_uart5_tx {
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 71e2e51c7c7f..b98994cc8616 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4337,8 +4337,13 @@ qspi_cs1: qspi-cs1-state {
 				function = "qspi_cs";
 			};
 
-			qspi_data01: qspi-data01-state {
-				pins = "gpio12", "gpio13";
+			qspi_data0: qspi-data0-state {
+				pins = "gpio12";
+				function = "qspi_data";
+			};
+
+			qspi_data1: qspi-data1-state {
+				pins = "gpio13";
 				function = "qspi_data";
 			};
 
-- 
2.40.0.348.gf938b09366-goog

