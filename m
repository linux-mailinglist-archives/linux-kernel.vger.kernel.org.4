Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6A7073FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEQVTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEQVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:19:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141BFD2CE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so929336b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358311; x=1686950311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaOxHre3ovU7Pucxt1LaFOdz4xHkq3r9vi0PelhMX8M=;
        b=pyXV4Fhls1HBbuAaTrUbGFCRy5EipRtmSV3hfUir2wZPT3hVCHakLcBc7lgbqkKy8X
         xV6s9Haquqh2efKd7ts10jabPFQOhBOF5i3aqlcA/DjOmv7HdENvJuA0MDkVg4TyPDUe
         MZ6iy1HW6oPuChk7VrU8CAGss/JZs3jqjqSjNbrvNDcfzns8eDzFA3GyOXBGyYOT6/64
         hIjApE19ySrr1ATionl25OKoNaNdriNIYVhDlcE1lz7RjrLkkWz/CdDR0lNlJzbY++4p
         gBHfy+BhbAf4/GGPByCiCKk1oxmJGpYAsAnM28R9CtClLHT6kVPFJsM8nITOmFWtkbz7
         YeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358311; x=1686950311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaOxHre3ovU7Pucxt1LaFOdz4xHkq3r9vi0PelhMX8M=;
        b=EZnWMFNC5YGBUOeogFhmVz6QF4zG5LyC9fkpRvjCJaek1GzQLYEuY1z3JBiR4sLoAJ
         /2XPgtDeZqQ7bRdKpHxm8tWB6TOZ3NjZ+58nj+LeT0ub4hnXD6Hq2D+A6njYtP5xX4Nx
         A3/GGqFuXVePUmF97mCt5Zx0iNXnCHaYPvymei75dsMwbrkWbURi8Utf7oP0IG9iUY8G
         Ab/LkeZ47P7hDZW8Nb6fQIrs+fAq1vG/1yL5vxnAh8mPXm29Sg/95xgerBWwD2icfQIc
         7X2UFEI/eiaD/WJaKE5kTdgyOhIapV4V21sDkpgqbcmnsrspb3A1T4TVcnqLL0dgFb6c
         nXnw==
X-Gm-Message-State: AC+VfDwR1r6jCz9objvvJKuCNARvJGgxNXqTVCkNBUWYoLkNJCJFsbu+
        zQ9HXwaN+x/NKFSxfJNyWnp/7A==
X-Google-Smtp-Source: ACHHUZ7masePph0GCUOSSsLvYgjE1D6uV20rKtOgRKNVUwYOlgLJUvuBZ2R9P7oPXxVe1uRK1WyD5w==
X-Received: by 2002:a05:6a00:1948:b0:63d:47ab:65ed with SMTP id s8-20020a056a00194800b0063d47ab65edmr1558870pfk.7.1684358311634;
        Wed, 17 May 2023 14:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:7a51:340a:a439:1b87])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79052000000b0064cb6206463sm4359210pfo.85.2023.05.17.14.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:18:31 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: [PATCH v6 5/6] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
Date:   Thu, 18 May 2023 02:47:55 +0530
Message-Id: <20230517211756.2483552-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
References: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
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

Add the Embedded USB Debugger(EUD) device tree node for
SM6115 / SM4250 SoC.

The node contains EUD base register region, EUD mode manager
register region and TCSR Base register region along with the
interrupt entry.

Also add the typec connector node for EUD which is attached to
EUD node via port. EUD is also attached to DWC3 node via port.

To enable the role switch, we need to set dr_mode = "otg" property
for 'usb_dwc3' sub-node in the board dts file.

Also the EUD device can be enabled on a board once linux is boot'ed
by setting:
 $ echo 1 > /sys/bus/platform/drivers/qcom_eud/../enable

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index f67863561f3f..92a82d7172ca 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -180,6 +180,18 @@ core3 {
 		};
 	};
 
+	eud_typec: connector {
+		compatible = "usb-c-connector";
+
+		ports {
+			port@0 {
+				con_eud: endpoint {
+					remote-endpoint = <&eud_con>;
+				};
+			};
+		};
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm6115", "qcom,scm";
@@ -647,6 +659,37 @@ gcc: clock-controller@1400000 {
 			#power-domain-cells = <1>;
 		};
 
+		eud: eud@1610000 {
+			compatible = "qcom,sm6115-eud", "qcom,eud";
+			reg = <0x0 0x01610000 0x0 0x2000>,
+			      <0x0 0x01612000 0x0 0x1000>,
+			      <0x0 0x003c0000 0x0 0x40000>;
+			reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					eud_ep: endpoint {
+						remote-endpoint = <&usb2_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					eud_con: endpoint {
+						remote-endpoint = <&con_eud>;
+					};
+				};
+			};
+		};
+
 		usb_hsphy: phy@1613000 {
 			compatible = "qcom,sm6115-qusb2-phy";
 			reg = <0x0 0x01613000 0x0 0x180>;
@@ -1144,6 +1187,13 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
+				usb-role-switch;
+
+				port {
+					usb2_role_switch: endpoint {
+						remote-endpoint = <&eud_ep>;
+					};
+				};
 			};
 		};
 
-- 
2.38.1

