Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1627D7051E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjEPPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjEPPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:17:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9847A81
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:17:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96aa0cab88dso834965966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684250231; x=1686842231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0lCm3iG0pXdFFf2LiZLAcS+oXB2fCjsEQx26FGefBo=;
        b=Ock+dXRpE6ZvT5f3R/3I6ixw0WaylD6JfMxORJ/RZP9zRQVqcYMs2S0spKA7vG/r2I
         nsed8ZaD6xNYInAV6H1xDGne2gG6CSAHzxx2l8b+moJ4qVFXWKZnbDkARwTFkhYvC03l
         fqNwM0T9hrIzjZ0NjwS+Ct/lXWjX+ddNKLUCt/JNkqWZcOAxRvzF8AFiVYz0PN1T7HUf
         kFCSyTFYm0qe1E3QkQpgGRnXamU6dw58u8be7yTDIs66KugMhWO/KrBzhkoog+h3/Tne
         02ORlsCfUvvZZblGfDNRFmWjlkhHkUA/JlY9qCdCbsRIRjWMCcnvrQQSIB+uC+aaid01
         0ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684250231; x=1686842231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0lCm3iG0pXdFFf2LiZLAcS+oXB2fCjsEQx26FGefBo=;
        b=hx+xqWrnu+8diQb3W/Egl7d5vUzpmVyWfZO5/bX+W4J5cHxB6qBRXsrysMGGL2ysfo
         4wLJTm/iw4lSYtwBFjtXQkPsjyCKi0v2rDxxkqWL71LM87zDVoJ7hNpBwYsYJg7DSYmt
         UHoMJ7WyLaWuSG/xO748XtmSGdLoLWsHgDEhfTj5troKlGypJpkrVSdL6z/e8tD23c72
         fuo7FXUrVeSVvaMBdESEJFTEJS/lI3weiZBoc8Fu5LXpTOyRbArNrRDIuqhyJFmn+JCE
         EC1EJQaDqsc2e5hKr1xWfGdmFB1hs82RiFJZ3U6o4yL+FhWliuWcenrSrtY3YVpKNNcN
         ErQg==
X-Gm-Message-State: AC+VfDyEqgfC8b2GLnnldw7CUc9x0FkL/WZvISRHV7c0UbHIRpFenqBq
        W9QSJUUeHz4OwQIFGuCIrefaopGd8ouk/KXl59k=
X-Google-Smtp-Source: ACHHUZ7LuW59MV2maSsv4YGosQ/nSRc/ya6gIddFgArCauQXSfupdE/pYwXHIqR4afjo+Y7hLVWITw==
X-Received: by 2002:a17:907:d06:b0:966:37b2:734a with SMTP id gn6-20020a1709070d0600b0096637b2734amr36602432ejc.22.1684250231573;
        Tue, 16 May 2023 08:17:11 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id jr18-20020a170906515200b00965f5d778e3sm11096028ejc.120.2023.05.16.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:17:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8550-qrd: add display and panel
Date:   Tue, 16 May 2023 17:17:08 +0200
Message-Id: <20230516151708.213744-1-krzysztof.kozlowski@linaro.org>
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

Enable Display Subsystem with Visionox VTDR6130 Panel (same as on
MTP8550).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Context in the patch depends on:
1. https://lore.kernel.org/linux-arm-msm/20230516133011.108093-1-krzysztof.kozlowski@linaro.org/T/#t
2. https://lore.kernel.org/linux-arm-msm/20230512160452.206585-1-krzysztof.kozlowski@linaro.org/
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 76 +++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 30b36a149125..03bf6bc2db4d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -420,6 +420,10 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&dispcc {
+	status = "okay";
+};
+
 &gcc {
 	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
 		 <&pcie0_phy>,
@@ -431,6 +435,50 @@ &gcc {
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
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
+		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&vreg_l11b_1p2>;
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
+&mdss_mdp {
+	status = "okay";
+};
+
 &pcie_1_phy_aux_clk {
 	status = "disabled";
 };
@@ -532,6 +580,34 @@ wcd_tx: codec@0,3 {
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

