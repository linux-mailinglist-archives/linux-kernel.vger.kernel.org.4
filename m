Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B520C7256E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbjFGIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbjFGIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA371988
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30af159b433so6928705f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125114; x=1688717114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=na7sIcXS3nGZEOht6isKqTn7W/wE9MxlLjsQUlpCZgA=;
        b=ke9A2K8/aNR9CAtmw6mNBUl/DyrBbn0JGsTFDFaWOG5vXRLpAnqvUzkhAS6zPgjNmz
         laCVFA68YEncnmRr/tMgF3XnZZWsgSOspsLvpta+3EAmyYqbBBJuEINIkxroj0BIvUb0
         3QpMhmKccPpojHkGYUlhd1YESI/d22aC+nOfB//QAqDfdIzxXriguULkITpnj8KoLiK4
         c++9UjBdPknQfXNFjM++9qFeXv5ZOnqXVpNMVTnZT5eMP5tJQZjUwJ4sSXlRGkaD7xjd
         x6P1Rs7/kf3myFA/SyNV0fSpAPmU+ltALy9qkC+F2Cnlfsr9SYfsKk+bw1Tu9jiW2Lvl
         zq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125114; x=1688717114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na7sIcXS3nGZEOht6isKqTn7W/wE9MxlLjsQUlpCZgA=;
        b=lidOFS81j3ZKsREe1PdnORz6jUf/GH+G9PSgc93TJmuNkz3kUUumIIbp4fjErvtCRa
         XmoxSGpltS2ZDCWylSANOQIgdpIe7jRI+ianh6meqqmalYWyD3yZaxB/bD8v7x4DsSHU
         bchQK2gYceD+EvkGJBAtYFJoMWYh9p6MXXOYr1MiiaYB5XFXxMjteJyHlw8EjveQby1o
         leotFifBMvUxBmVyvIQUoQgXooIEuPIB2FKn7g33r7a4qXEKBFOCiUWgnIFwg577gcXh
         vHSJq2OwGMfJB1HJ/73DTelfdbk5TW88Tr1NDX84wU7VfeE88odBW1CSJXNl3/GjwT8k
         njDQ==
X-Gm-Message-State: AC+VfDxcWxEetA5D93gqorubEnyQAK2G14Tb2pP9DGnK8lJAMLoeK5fr
        AXtixC4KI4Y8+4TbjiR4Jyse/Q==
X-Google-Smtp-Source: ACHHUZ4P26uoin2BEUm1XhMS2zjpRrx9Lr41abv9NEOVrPCsdc27vB/kepbD8CoiykADJbRPdYdh9Q==
X-Received: by 2002:a5d:468d:0:b0:30e:3ec5:1fb1 with SMTP id u13-20020a5d468d000000b0030e3ec51fb1mr4021406wrq.33.1686125114066;
        Wed, 07 Jun 2023 01:05:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm14706269wrm.17.2023.06.07.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:05:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 10:05:06 +0200
Subject: [PATCH v2 7/8] arm64: dts: qcom: sm8550-mtp: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v2-7-3bbdf37575c3@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=O5luTbpHIG3K4YFndZxQ5nNrwrQj52dmp08Q1lBGmYM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDowkHT+iwD9bAecvWiluZ05dqaXO9MqoUAf1Ivx
 T0l14iGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA6MAAKCRB33NvayMhJ0a6uD/
 9IYa57kTw6H4dI6kbmiLiDBr/ee2Y20sS93blWpSFXrQt0p/h3wsexEHVH7+mRLHvy+mNwue1jmgVx
 viIN6yTUff77WWf2UmfobautUveIT9W0rHoC/4c/5JSJAKuGcf/kGQLvCyK+wWrKgqiX4lf9m170nZ
 RCX8+3T1PyQ8NMQ4npxJbgzyTM8pTjiTKhSkwV4AvOuQQVkmGfjqROEeCzblrfBjImDaVlh+CKQ2Av
 695w+wA0jDF3ibbPNNerixaIITHbBj+Wnfgf2HZaHlOXC05Oq++kMkjPIZBskbLxVvYCOVE9eCDiDK
 D3NJEOMXcnb7oHCw12ucilWlRwCe0TWXQS7QyW6gnbl3lVp5UVMarAU0rcj00EhhuerVEj1iqrbS13
 AQQRVjggixUg2stcgO68o/VlBv9irejKScW8zIEdqXGEDtcdM8EtnodMn14H4XnyaxXkS8NpFShxlj
 abIcBFnZkwbJZZSRDdy93c/1TpMaFkiyCz1rO+ZBVzlY9IAhNdwOHl6nh4aYqYOl1z5fOiCgIi2Uk+
 6Xho3IU0qHfRoJKWuFfzqIHAlMJLKd6muYpeNrhICTXwxhoqdjsMpWGRklMG9XOiCnpVORpFr7knAL
 0EW3WO27irecXM+cXhkIp9iR+p+CRsbIUAt4e/jxcGmUbbGgO93Bb/awxTow==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to support Type-C USB/DP functionality.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 67 ++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 579f65f52370..8d4741404f2d 100644
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
@@ -419,6 +427,38 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&i2c_master_hub_0 {
+	status = "okay";
+};
+
+&i2c_hub_2 {
+	status = "okay";
+
+	fsa4480@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		vcc-supply = <&vreg_bob1>;
+
+		mode-switch;
+		orientation-switch;
+		svid = /bits/ 16 <0xff01>;
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
 &mdss {
 	status = "okay";
 };
@@ -459,6 +499,15 @@ &mdss_dsi0_phy {
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
@@ -652,7 +701,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -668,9 +717,23 @@ &usb_dp_qmpphy {
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

