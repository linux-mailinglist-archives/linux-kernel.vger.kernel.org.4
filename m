Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4165EB18
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjAEMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjAEMv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:27 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACDB48CD7;
        Thu,  5 Jan 2023 04:51:26 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 509D2420E9;
        Thu,  5 Jan 2023 17:34:01 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922041; bh=X/5AJksXQf17kf4+orqMNYWY3Pk7OE2P5lNRHc4uMus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdHPXCU4DmUQaohQf+3WmjH7BUzIgX+SeiCg2HmlHBhw4WZq9VvvSDXGE4XMzo+vm
         4vEIUckbcXq8uMCFngzqQXcCowhltz/K1Hj0nJIjJ/S5ETaOCSt2KiDs4oHyfSxOTw
         Vp7vBXUAvKI+l7Y622KE0NN5omDtPrhwB+YzNYKAH6hxkeFBzjfWfzlIW63KXI6ipW
         FtalGJwwl9ld+pfu5OTA8oSVcNYAhO1FdPVLQJEEDKI/D8VhLU1hGcGnA4JBnD2BJz
         v6sxoELVq5QdkRgw70tTpNvq1EKK6Wrizrnb4AoOkCxmLdJ+HbxVjg+j8FkTWAHgxH
         UwwVxNfMfdtDQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 7/8] arm64: dts: qcom: msm8916-samsung-gt5-common: Add fuelgauge
Date:   Thu,  5 Jan 2023 17:32:39 +0500
Message-Id: <20230105123240.1089375-8-nikita@trvn.ru>
In-Reply-To: <20230105123240.1089375-1-nikita@trvn.ru>
References: <20230105123240.1089375-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gt5 devices use additional MAX77849 MFD to handle battery, charging
and usb switching. Fuel-gauge from this MFD has a separate i2c line.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 9cdb33247691..9f97a8129278 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -63,6 +63,25 @@ hall-sensor-switch {
 	};
 };
 
+&blsp_i2c4 {
+	status = "okay";
+
+	fuelgauge@36 {
+		compatible = "maxim,max77849-battery";
+		reg = <0x36>;
+
+		maxim,rsns-microohm = <10000>;
+		maxim,over-heat-temp = <600>;
+		maxim,over-volt = <4400>;
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&fuelgauge_int_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &blsp1_uart2 {
 	status = "okay";
 };
@@ -218,6 +237,14 @@ l18 {
 };
 
 &msmgpio {
+	fuelgauge_int_default: fuelgauge-int-default-state {
+		pins = "gpio121";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107", "gpio109";
 		function = "gpio";
-- 
2.38.1

