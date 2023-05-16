Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726C470529B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjEPPq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjEPPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:46:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02519900D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:45:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965c3f9af2aso2195705266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684251944; x=1686843944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAgahxZvZI+ueNx3zmY15nLRJ1KnLPgYZpaJXAq3Hfs=;
        b=JCKRKBqlQnkJ/a3WQyTZeB0t8+xkrK3LwhgSFztMZT3evmhNniR7h+GAhlAxVqFq7H
         eSQHJBXQ0M/1esGoK1lS/5UxHhJ9zU3kVw13pjs8pt5XUoYSUjJ2iDvX92ZWlYExSqYx
         oLmSZO8ZFi0DlpOazTm1esXKAPY12WV3JDxTAwU8GLs17G4J0aQcM0PbFGTFKqaya7fv
         wQ17rtxXosYv0OVc9/xf7p/MNwQwLdWVisSRboXDoGgwu7xFrFhuXLzIW6uD6fchdpzG
         FCWG0Yn+/LvyfKjuxGCzIPNAnUTMslKVQBSn8AAK5MXLIuac0rR539DDRwi3HfoAD72M
         nvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251944; x=1686843944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAgahxZvZI+ueNx3zmY15nLRJ1KnLPgYZpaJXAq3Hfs=;
        b=Rkkt6vB1C5rfsgWP5u1wW/JLGa4zapS4dxaIH4sqoQHS1PoDH9DcEESEx08Uxmh64T
         5cA9Y0yWPAmSywet+maW62BAf9PihzVHRVpgKZhYgf4zHaKW4/4pSYf8FvJoffUBzhGq
         hiyqQyA4R1+NlGTzT5m4R52kqWXSAdZdVD8WTxnVbcm/L7EACXOa65tEyN62WB7rI/si
         nAiQPbZPj0WdDiy6sOGh9PjqVgNJ73BrpiJZCKgUhWOrN+kS9Zf/p6SpQszp9McfpelV
         6pupJyRCf5t+vJl5SSZpNvsUdiSbpL5no8TwzHOU+La15ejhVUwZ7R7wo1Kvjx8lmsbj
         ay9Q==
X-Gm-Message-State: AC+VfDwV/+vG0TnPSM6nz4wSls8ZdGvPpGhQRdnkRKuIsSKCci/DsL8W
        kNATnBDfKI/j/wTdAZAhw/YRAA==
X-Google-Smtp-Source: ACHHUZ4EDVrnWEfbdkG5mU3WpO83DH+5+O2ZIP27e2NTAKGr3C1qTtqLz1sTc0wTznIjqhjQbqgxJw==
X-Received: by 2002:a17:907:c1f:b0:961:ba6c:e949 with SMTP id ga31-20020a1709070c1f00b00961ba6ce949mr37299614ejc.68.1684251944289;
        Tue, 16 May 2023 08:45:44 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id z25-20020a17090674d900b0096ac3e01a35sm5787587ejl.130.2023.05.16.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:45:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8550-qrd: add display and panel
Date:   Tue, 16 May 2023 17:45:39 +0200
Message-Id: <20230516154539.238655-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
References: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
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

Enable Display Subsystem with Visionox VTDR6130 Panel (same as on
MTP8550).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Context in the patch depends on:
1. https://lore.kernel.org/linux-arm-msm/20230516133011.108093-1-krzysztof.kozlowski@linaro.org/T/#t
2. https://lore.kernel.org/linux-arm-msm/20230512160452.206585-1-krzysztof.kozlowski@linaro.org/

Changes in v2:
1. dispcc is enabled in DTSI.
2. Re-order pinctrl and regulators.
3. Drop mdp.
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 68 +++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 30b36a149125..ade6ba53ae6b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -431,6 +431,46 @@ &gcc {
 		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l3e_1p2>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "visionox,vtdr6130";
+		reg = <0>;
+
+		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
+		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
+		pinctrl-names = "default", "sleep";
+
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&vreg_l11b_1p2>;
+		vddio-supply = <&vreg_l12b_1p8>;
+
+		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l1e_0p88>;
+	status = "okay";
+};
+
 &pcie_1_phy_aux_clk {
 	status = "disabled";
 };
@@ -532,6 +572,34 @@ wcd_tx: codec@0,3 {
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
 
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_active: sde-te-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_suspend: sde-te-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio108";
 		function = "gpio";
-- 
2.34.1

