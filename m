Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5B734CED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFSH7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjFSH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6AE54
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so1921519e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161523; x=1689753523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxiaZ5bIDFSAVarg8oaXEN/qLNFgPaQwTFic4uvWP48=;
        b=fdhMWcKPI/BysjJK3t1/oNVe1QoWMSsgMkSMk/tSevIX9Q0V+Lw5/UNXzBHfozR4E2
         M6Pto1XBRRxjv4VOVyHJkNZa98FacF2Ho/LuhQ5EO4ZlWQc+/l6ZyYWXBPE2SxEYESly
         faI0CwPx2EAm6EQJxq07a9sY45zZLK8OcvMozcbOJH78OMKeGZth6Z5lGhcV47Y+9PlF
         sfJhkb93FeuwYjTsISjjgRN/of9RMONZ8DCLBf70/rVUw3XAp2XoRIia4qpDl4AIwzu4
         OPOIs8oxhS+4wdKdiDGOe5IdmKf0BUQ7bUWxw4Tw9UBV1fn+rtGaeIR9qbQmKloVsIgr
         xQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161523; x=1689753523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxiaZ5bIDFSAVarg8oaXEN/qLNFgPaQwTFic4uvWP48=;
        b=W7ZEPeqHhq4lQCfNArRZEDyl/IWo6BQtcrhFEd3qJcagS7b+B9KW9HnVp8GtT8/7Cr
         4SnSC4ksb8g+/xJE8SXqB+lXCQM3jWPD3iCK6+opjDn7Icx1OFIqffdx8uHlsvrs1h5t
         HVbhLd7EklOkuhBgDI8Bku2MbJ2dDIXW/U6JOXobU8/r2LnDfGX8Hwg2FlCUo7KOpBJB
         z3SfqdKd01oUE5A7N9Ap4m0NnImHVZFE1Xm2F5KqTp/63HK3gJQZwjR00y0I0Z8HvXPv
         bGSJNm29Tv8Ctje+bPTEVjUjYpsPlDf+ShJW2hbX4LqFUHctgvjDQmnzl3egIZZxps/S
         +nxQ==
X-Gm-Message-State: AC+VfDyPhUM/2/qevtnzgA+vAF0dbDdCGLsVhKfdsJM10j7RdVI5xMc2
        QQAOWFZzVzK4jmaTUTIQD2v6QQRAEo3MbJ7K0iOTRQ==
X-Google-Smtp-Source: ACHHUZ7VYJpIyM8Ryk/6TpF4D0noBm4da3QdpLqJMyyHSLsUxCBvbZYwh1WoKnmCP6PvSGucfman1g==
X-Received: by 2002:a19:8c17:0:b0:4f4:dbcc:54da with SMTP id o23-20020a198c17000000b004f4dbcc54damr4449516lfd.27.1687161523405;
        Mon, 19 Jun 2023 00:58:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm7091491wml.19.2023.06.19.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 00:58:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 09:58:20 +0200
Subject: [PATCH v4 5/6] arm64: dts: qcom: sm8550-mtp: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v4-5-eb2ae960b8dc@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FVFzX5TzmJ4Q7uHGdGJK2tcC9JAQWYVr5nuVEVM2G0I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAqsMTClWtaDTK6xS68LNcZEMLxdrgJrOatp2QrP
 WtAW9T6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAKrAAKCRB33NvayMhJ0SdZD/
 9Qhpgnqpse59lGgwGuO7LwPDLuL12O/X3T9A90+oKGQ2OlD7yiQAlqwJVL/0s/kAf87SQ/5H44LJve
 pHjyh3fqIuW5DanLQVzcHf1pYRj1UuVlLWdcBCTzFb7rGxHc3YwigpFsQ/zmcWeAYD9hDQbj7U46Im
 SjPJZ4sA9LrmPWKjJgU4lNg9w2a3+KPF9cgKMSvXOh1AtgNArxRGofhADBQfd3vX3gtgOjANFFyiLO
 A3ksDJQNUGVwsibYTXv6ij9jgu3/D1vOZ9TiPiw6u7H4X7buxnPV/DMMlFzhjlrYE0JKeNL+vLT3SP
 EIg6aVIZ8ewBUHmQ1Fi8lNUoZH8vEnMUdmFDTtnGQ/fF1yE/z2gHbvNfJcEFbhvbaFqyET9dBSHurO
 YrxNwQ14Ww6lHNtgy/g0kWp6agZuT4W3UOqJhtkjSNP52GW0OuHchdDkTF7p5E36HmDrVoOsvCBYxc
 KuuWdB5EB2aBFGDR2AKNX6e9peGNM/hszMBSKg4zsbcogE8+mVlhy7TSKI4ddM2dwfJH15sRgEmCSY
 KayIhIoPmo3mBaQa07es9NhdurcBUB+OBgjARIPEk0Hhm2sD6Y5Vtwhm5+tIu5Mz7x0sCM+H2xbjyG
 ey/YVp0dacNNrqKmu8Z1SOjujsjHQ0hP/8XTRm/fj3lZiVFpko5HW40oCyYA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to support Type-C USB/DP functionality.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 66 ++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index ec86c5f38045..67e0a2d2042c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -80,7 +80,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss_in: endpoint {
-						remote-endpoint = <&usb_1_dwc3_ss>;
+						remote-endpoint = <&usb_dp_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&fsa4480_sbu_mux>;
 					};
 				};
 			};
@@ -500,6 +508,37 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&i2c_master_hub_0 {
+	status = "okay";
+};
+
+&i2c_hub_2 {
+	status = "okay";
+
+	typec-mux@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		vcc-supply = <&vreg_bob1>;
+
+		mode-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				fsa4480_sbu_mux: endpoint {
+					remote-endpoint = <&pmic_glink_sbu>;
+				};
+			};
+		};
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio17";
@@ -558,6 +597,15 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+};
+
 &pcie_1_phy_aux_clk {
 	clock-frequency = <1000>;
 };
@@ -781,7 +829,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -797,9 +845,23 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l3f_0p91>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
+&usb_dp_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_dp_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};
+
 &xo_board {
 	clock-frequency = <76800000>;
 };

-- 
2.34.1

