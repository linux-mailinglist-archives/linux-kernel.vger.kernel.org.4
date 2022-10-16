Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9528960026F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJPRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJPRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:30:16 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9508240A9;
        Sun, 16 Oct 2022 10:30:15 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 819381402B9;
        Sun, 16 Oct 2022 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665941412; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biK9SKRwYJsO1jq7QuCitwGwUZNgIZQWDcG6i8Ktt8Q=;
        b=zmWI3/T7/NCVm95YqsksbVCdkiMg9H2yLlvyJKghEcU4dW0P4Moq3o7ZpgkLrpsgvRz/tX
        CBIrJJtpnMMy4tWF8e231h+FDgRlSsRD0bv9ilPqgsqq//07tY9mH1IzePyu4QiPrABte6
        LpHXzOaDpWrZCCpef/1gn13MDidn2zU=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
Date:   Sun, 16 Oct 2022 18:29:41 +0100
Message-Id: <20221016172944.1892206-2-kc@postmarketos.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016172944.1892206-1-kc@postmarketos.org>
References: <20221016172944.1892206-1-kc@postmarketos.org>
Reply-To: Caleb Connolly <caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb@connolly.tech>

The 4-pin configuration for UART6 is used for all or almost all SDM845
devices with built in Bluetooth. Move the pinmux configuration to
sdm845.dtsi in preparation to be removed from individual devices in
future patches.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 37 +------------------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 25 +------------
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 28 +-------------
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 27 +-------------
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 27 +-------------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 22 +++++++++++
 6 files changed, 32 insertions(+), 134 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index b5eb8f7eca1d..923d5d681daa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -860,6 +860,8 @@ i2c_tunnel: i2c-tunnel {
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth: wcn3990-bt {
 		compatible = "qcom,wcn3990-bt";
 		vddio-supply = <&src_pp1800_s4a>;
@@ -1079,41 +1081,6 @@ pinconf {
 	};
 };
 
-&qup_uart6_default {
-	/* Change pinmux to all 4 pins since CTS and RTS are connected */
-	pinmux {
-		pins = "gpio45", "gpio46",
-		       "gpio47", "gpio48";
-	};
-
-	pinconf-cts {
-		/*
-		 * Configure a pull-down on 45 (CTS) to match the pull of
-		 * the Bluetooth module.
-		 */
-		pins = "gpio45";
-		bias-pull-down;
-	};
-
-	pinconf-rts-tx {
-		/* We'll drive 46 (RTS) and 47 (TX), so no pull */
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	pinconf-rx {
-		/*
-		 * Configure a pull-up on 48 (RX). This is needed to avoid
-		 * garbage data when the TX pin of the Bluetooth module is
-		 * in tri-state (module powered off or not driving the
-		 * signal yet).
-		 */
-		pins = "gpio48";
-		bias-pull-up;
-	};
-};
-
 &qup_uart9_default {
 	pinconf-tx {
 		pins = "gpio4";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c6e2c571b452..f87b1e2025b6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -986,6 +986,8 @@ &uart3 {
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
@@ -1141,29 +1143,6 @@ pinconf {
 	};
 };
 
-&qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-disable;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
-};
-
 &qup_uart9_default {
 	pinconf-tx {
 		pins = "gpio4";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 392461c29e76..02ec0fa4e5f0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -500,35 +500,11 @@ pinconf-rx {
 	};
 };
 
-/*
- * Prevent garbage data on bluetooth UART lines
- */
-&qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-pull-down;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
-};
-
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 82c27f90d300..5dde27b7daf2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -481,6 +481,8 @@ wcd_intr_default: wcd_intr_default {
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
@@ -567,28 +569,3 @@ &wifi {
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 };
-
-/* PINCTRL - additions to nodes defined in sdm845.dtsi */
-
-&qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-disable;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 7747081b9887..c8b439dcbca4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -639,6 +639,8 @@ wcd_intr_default: wcd-intr-default {
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
@@ -735,28 +737,3 @@ &wifi {
 	qcom,snoc-host-cap-skip-quirk;
 	status = "okay";
 };
-
-/* PINCTRL - additions to nodes defined in sdm845.dtsi */
-
-&qup_uart6_default {
-	pinmux {
-		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		 function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-disable;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f0e286715d1b..55de40bea684 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2971,6 +2971,28 @@ pinmux {
 				};
 			};
 
+			qup_uart6_4pin: qup-uart6-4pin-state {
+
+				cts-pins {
+					pins = "gpio45";
+					function = "qup6";
+					bias-pull-down;
+				};
+
+				rts-tx-pins {
+					pins = "gpio46", "gpio47";
+					function = "qup6";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				rx-pins {
+					pins = "gpio48";
+					function = "qup6";
+					bias-pull-up;
+				};
+			};
+
 			qup_uart7_default: qup-uart7-default {
 				pinmux {
 					pins = "gpio95", "gpio96";
-- 
2.38.0

