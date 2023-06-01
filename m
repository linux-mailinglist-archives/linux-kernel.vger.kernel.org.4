Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D07719F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjFAOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFAOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC56E4A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso9123465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628433; x=1688220433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=na7sIcXS3nGZEOht6isKqTn7W/wE9MxlLjsQUlpCZgA=;
        b=CPBtHCMoTZhbq9wMjV975yNQlnVcUlP2dVsPEGnNlLV5Xd7NLy4KQBlkU75Rxnrcwg
         9DZNzR++HavQmR4FqfwzlNRNU2V9yLEQ2Wg9pcRCH0cdKOicLdHDHEhPccrVHTCgyij5
         i/k5UFcTQkhLMCEKgu74L6Vz6Tkbv2BguOrBO33LVhtgdHM9z9s6CU/hAvvJLkKzsR1p
         SO/1VCeRPnWSLrsmYFmFsrO/Ge+LHC1yO7l/o3ybOLnqsPad/3DtevxVTzFdkUAmR+Y/
         Gjt1nZYcy9+Yy0pnFxl0Hhgx9JJmjpz9pG6WandoN1PybneFJ1eAXdFIWb36IWhT18H1
         9nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628433; x=1688220433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na7sIcXS3nGZEOht6isKqTn7W/wE9MxlLjsQUlpCZgA=;
        b=FrA8ZA/bj62uysTbXAWNNWfXvKVrMSfUmO2TEflUVwY1PDpHTgPJkfp2F5G6lU1WzR
         LKf/43JV7wK6J7xgyX0CPU+ghoBbCEIvBEOIFCi509JlcU0I63Wgy5ZcoBPI2p+hlfhf
         ibyYiXuYSuuPtgUT4x/VoRCbzSElW+x2U02LFzcoeEXbQ6k3Dq531HnK/OdlHi+qfNLw
         lXb6BJPm3HyqtehCvq96NFXEg8fyqvDk0PDncktop9+trKpV8rCyoiwlxKXscVgWvEvG
         jWgyKJQGLzdK6uAx8itebRQdr6fmJ4nuyIBKiKqaKjyzXFlkwqIlRSKC7Zy62lmANy5V
         DnBQ==
X-Gm-Message-State: AC+VfDyJNNa/gmHDBqqtwUNA1mxlqumamOPhTZJAAzk5z5hzBcNvXVLm
        MY3/tI8au3j3jAypJfq1NND9cg==
X-Google-Smtp-Source: ACHHUZ56f0cPgytfUVKrMfbUOuRCHh+jqBtk/pf7kIrjXa/6JLvVr3S7zoLVHsDYPzEGQcRFsKLFEw==
X-Received: by 2002:a1c:7703:0:b0:3f6:580:b082 with SMTP id t3-20020a1c7703000000b003f60580b082mr2331758wmi.0.1685628432922;
        Thu, 01 Jun 2023 07:07:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b003078a3f3a24sm10504166wrm.114.2023.06.01.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:07:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 16:07:06 +0200
Subject: [PATCH RFC 6/7] arm64: dts: qcom: sm8550-mtp: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v1-6-d4d97b4d8bab@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeKYJ8taxHNLBLxzirg9NPrk8xDBHhSncxuBGkVYF
 E0U7jCOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHimCQAKCRB33NvayMhJ0TDtD/
 4jHNLRLojVuxmK/Azr0qE4LlFkX3VElsDTQtMPH3p6lTILUa+ZPJPCgVO1h5fYt2uC03E2diJ/vX7c
 dVgfqivj/MrDbRHjLdk5xTpCIfDJr56UExmAbKHMlk7wnj+u9k8i2wHOfePVrRWgrXbvQWtaoaAdMK
 QMRnhAsMaXnibp/gJ74YMsTDFINi+Mh5kPqXbglyfp2bmDbbCt9Kh0YvuSbhQXnasWlziza1ittKmw
 O3Ptv0VTymaZ5zDEteve6ce73+6UdYXua4FJ5JHTPBOL2llXEk0dh+QlQu2hTyfQcsGSjxwUHaoh1A
 5avf4J8+fNxR7xGDcU0Nq4/rIVrRcTpPNH9RUUK4xFsq1TgG1DXaZbUyFq9EiZLUzz3YzfUGTjZB4l
 q7ZgMvpMuDK3v+XaoZkt+kxcjdBr5WXp/TzIHBA5fRA3/JLvyCXHi1Mrb0hJ58uqjsT+1bd782TciO
 grtjeMhqi4EUaCXJQjUROo9R3LbY7AH0ZEO95xNYL4ZUe1dyCeEHybDmsL33Hjhkq1XrTM46buFmyE
 N+QyF1hlYaO47HE6H8SpCwx6gDRakE0xCTTNeUhRLNPpFmyMkDdazfjlZNmh7Kpt9QH8AP7olQVLo/
 W4aoqMs8nvlDTEXKb38IE7e34Jke4bvCXnf5qBkKoPpm5SLxx7QDHC1pQVDQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

