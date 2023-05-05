Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6906F7D22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjEEGlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjEEGlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:41:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284E7160B4
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:41:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf7067647so9587055ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683268864; x=1685860864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWLQsA8VjQXbFjS0WuyMsEB8Z2ZmjQGp/Fup+oGYwnE=;
        b=gH/PEd/+LF0SIIk93UjJvwut68t05KgmaueNRoys2HAZhujIK1StQXYQ5SgxKYjfQR
         6ms591/CJfcQmZG1c0EFQ3VjvB9nvRe1nAHUaSuNqip09Q6QFRXgjo4JmtnUlU6JKUwJ
         hyYYwaq3n6VPp22BcQs1872b4cV9hEfb/JMbZKHF/ceqZiFCWFNiM9/ZIWTx2F66IX4A
         /7hwEbCL9uwxJU0WGqfsA4uxmNbi3Q6ccI2raLCGffSmLXs+6oaQmY2SedlnUQXN7mo2
         45i46koNaECXNaDSvz940i59mnm9V2NjYkgWXm83PQL+h+ESBYaGBjHpj4XI+y+vZn11
         aBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268864; x=1685860864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWLQsA8VjQXbFjS0WuyMsEB8Z2ZmjQGp/Fup+oGYwnE=;
        b=YYNuNaZa1mm6RUKXgQ2L7G5Yz47HAFGqJZNNT2EL92rYyuGHoheZAabPpY95i3pevm
         yaXmGZgvWeTYZ9CE1oHZa7tiLeEn90X6vZ2+w9nTWfj2UukTlNyvvqnu8eW86kbUb5zK
         xHLJ/qXccmyD1vEk739ssoH0TIxpUj3BhLX63hL4026iYbM2I4NFaU7g8RJcZJWRsJpb
         fWTwkOd0GJ5pu+UQVX4shpophAc61auvTmOGJEcOgpY8tVwP0XBuOZQQb/uwgYGlInQC
         igflJqRsCMPl6JG1Eo6zq/HzahH4wk2wwaIGesnitU5b6kJ5Z2m4yq5RS9B0kBLAa2R/
         Z1zg==
X-Gm-Message-State: AC+VfDxdYVfq4faFzmJfHLwaxA2PqA6kOGtgCqjZnf2yxZJ/8/VOhdIJ
        o7b98JYr7MDKgP5bGdWOCfKcBA==
X-Google-Smtp-Source: ACHHUZ50ktFhXuYFobIePkB+4sB6nmdn/x7eLSzKTuHKNUeWtx6xRg36mQzho+sBie5LtXZi00dymg==
X-Received: by 2002:a17:903:1210:b0:1a6:a988:b858 with SMTP id l16-20020a170903121000b001a6a988b858mr485823plh.58.1683268864428;
        Thu, 04 May 2023 23:41:04 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902848400b001ab0b2dad2fsm816251plo.211.2023.05.04.23.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:41:04 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 4/5] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
Date:   Fri,  5 May 2023 12:10:38 +0530
Message-Id: <20230505064039.1630025-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index f67863561f3f..61a0af33ca43 100644
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
@@ -647,6 +659,38 @@ gcc: clock-controller@1400000 {
 			#power-domain-cells = <1>;
 		};
 
+		eud: eud@1610000 {
+			compatible = "qcom,sm6115-eud", "qcom,eud";
+			reg = <0x0 0x01610000 0x0 0x2000>,
+			      <0x0 0x01612000 0x0 0x1000>,
+			      <0x0 0x003c0000 0x0 0x40000>;
+			reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,secure-mode-enable;
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
@@ -1144,6 +1188,13 @@ usb_dwc3: usb@4e00000 {
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

