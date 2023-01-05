Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85265EB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjAEMv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjAEMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:28 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D8485A6;
        Thu,  5 Jan 2023 04:51:26 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id F1E90420EA;
        Thu,  5 Jan 2023 17:34:01 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922042; bh=AfmbF3JjmXKU9T2jtly2Mo3ig2mVtRaWbIeULclrM7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxAl392HXkVVnPLj+qaVI87DjLtaphJO4FmU0L84V6CdB/k4zVhciI7XNqB5YpIBD
         Y56OJ9kQ8PT9s0Bk8voY46XNSRj8yTZta+7eHx39zF00d5KqMbevNpLp1sj3iV9ayg
         GoI6jWi13kvBtZP+f63LrKKl1YY1WFGQWjGvBa5SdbPpaNhTFJkElkWxIwgH3CP0wV
         DrtPO4CFP5VWBUx6h0mlVeWtK6MrhrXlxnheQC7Vi4sAco57hwh62sx9NGwWlaQBSo
         nVcDvescddiD5ARDSOh+F2uxAusOXYxmtQ0dQKE1Y6W7OWQFQwhlW6JZn6fMkyLUnb
         a8TBFI+AEFaNA==
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
Subject: [PATCH 8/8] arm64: dts: qcom: msm8916-samsung-gt5-common: add sensors
Date:   Thu,  5 Jan 2023 17:32:40 +0500
Message-Id: <20230105123240.1089375-9-nikita@trvn.ru>
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

From: Siddharth Manthan <siddharth.manthan@gmail.com>

This device has ST LIS2HH12 accelerometer and Capella CM3323 light sensor.
Add support for it.

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 9f97a8129278..bb1b1e814d8a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -82,6 +82,35 @@ fuelgauge@36 {
 	};
 };
 
+&blsp_i2c2 {
+	status = "okay";
+
+	accelerometer@1d {
+		compatible = "st,lis2hh12";
+		reg = <0x1d>;
+
+		vdd-supply = <&pm8916_l17>;
+		vddio-supply = <&pm8916_l5>;
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <115 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "INT1";
+
+		st,drdy-int-pin = <1>;
+		mount-matrix = "0", "1", "0",
+			      "-1", "0", "0",
+			       "0", "0", "1";
+
+		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
+	};
+
+	light-sensor@10 {
+		compatible = "capella,cm3323";
+		reg = <0x10>;
+	};
+};
+
 &blsp1_uart2 {
 	status = "okay";
 };
@@ -237,6 +266,14 @@ l18 {
 };
 
 &msmgpio {
+	accel_int_default: accel-int-default-state {
+		pins = "gpio115";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	fuelgauge_int_default: fuelgauge-int-default-state {
 		pins = "gpio121";
 		function = "gpio";
-- 
2.38.1

